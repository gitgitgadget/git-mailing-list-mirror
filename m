From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn+cygwin failed fetch
Date: Wed, 11 Jul 2007 02:06:00 -0700
Message-ID: <20070711090600.GB29676@muzzle>
References: <f9d2a5e10707101106w305e28acy55f465e558485298@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 11:06:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Y9J-0001hV-0C
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 11:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376AbXGKJGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 05:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756914AbXGKJGE
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 05:06:04 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40080 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754689AbXGKJGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 05:06:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 4B03D2DC032;
	Wed, 11 Jul 2007 02:06:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f9d2a5e10707101106w305e28acy55f465e558485298@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52145>

Russ Dill <russ.dill@gmail.com> wrote:
> [...]/src $ mkdir foo
> [...]/src $ cd foo
> [...]/src/foo $ git-svn init -t tags -b branches -T trunk
> https://www.[...].com/svn/foo/bar/bla
> Initialized empty Git repository in .git/
> Using higher level of URL: https://www.[...].com/svn/foo/bar/bla =>
> https://www.[...].com/svn/foo
> 
> [...]/src/foo $ git-svn fetch
> config --get svn-remote.svn.url: command returned error: 1
> 
> [...]/src/foo $ git config --get svn-remote.svn.url
> https://www.[...].com/svn/foo

Sorry, I can't help here other than recommending a real UNIX with
fork + pipe + exec and all that fun stuff.

git-svn relies heavily[1] on both input and output pipes of the
safer-but-made-for-UNIX fork + pipe + exec(@list) variety, so I suspect
this is just the tip of the iceberg for Windows incompatibilies with
git-svn...

Maybe somebody can finally libify git? :)


[1] - probably more so than anything else in git

-- 
Eric Wong
