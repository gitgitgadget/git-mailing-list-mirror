From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] git-svnimport: Parse log message for Signed-off-by: lines
Date: Wed, 6 Sep 2006 15:53:17 +0300
Message-ID: <20060906125317.GA21645@sashak.voltaire.com>
References: <20060905184611.GB14732@sashak.voltaire.com> <7v1wqqc8dh.fsf@assigned-by-dhcp.cox.net> <20060905221754.GI14732@sashak.voltaire.com> <7v8xkxc2tr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 14:48:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKwpk-00022f-9N
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 14:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWIFMsH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 08:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWIFMsH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 08:48:07 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:13437 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750814AbWIFMsE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 08:48:04 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 6 Sep 2006 15:48:01 +0300
Received: by sashak (sSMTP sendmail emulation); Wed,  6 Sep 2006 15:53:17 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xkxc2tr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 06 Sep 2006 12:48:01.0534 (UTC) FILETIME=[B01751E0:01C6D1B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26519>

On 16:26 Tue 05 Sep     , Junio C Hamano wrote:
> Sasha Khapyorsky <sashak@voltaire.com> writes:
> 
> > BTW, what about to importing subdirectories, like this:
> >
> >  <trunk>/path/to/subdir
> >  <branches>/path/to/subdir
> >
> > Is this could be improvement?
> 
> I somehow had an impression that svnimport dealt with the
> reversed layout already, although $project/{trunk,branches,tags}
> layout is assumed by default; maybe I was mistaken.

At least I didn't succeed with reversed layout. With option
-T <trunk>/$project import works but only for trunk branch, attempts
to specify branch as -b <branches> or -b <branches>/$project don't help,
the same is with tags.

> If the tool can automatically detect the layout the remote
> project employs, and adjust the default accordingly, I would
> imagine that would be a useful addition.

Not really automatically, but $project may be passed as option argument
in command line (let's say -p or -P), then git-svnimport will attempt to
parse such SVN repo layout:

  <trunk>/$project
  <branches>/<names>/$project
  ...

I will verify the patch (it worked only once with our specific project -
OpenSM) and then will post.

Sasha
