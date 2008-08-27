From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/6] 'git svn info' fixes
Date: Wed, 27 Aug 2008 02:53:42 -0700
Message-ID: <20080827095342.GB26475@untitled>
References: <1219779157-31602-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 27 11:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYHjk-0001CS-GS
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 11:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbYH0Jxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 05:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbYH0Jxn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 05:53:43 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55907 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741AbYH0Jxm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 05:53:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 3C2542DC01B;
	Wed, 27 Aug 2008 02:53:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1219779157-31602-1-git-send-email-trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93884>

Thomas Rast <trast@student.ethz.ch> wrote:
> However, I also wanted to provide tests, and that's where the fun
> started.  Turns out t9119-git-svn-info.sh is currently quite broken.
> 1-4 just fix the tests; a brief summary:
> 
> [1/6] git svn info: tests: let 'init' test run with SVN 1.5
> 
>   The tests do not report any problems with 1.5.
> 
> [2/6] git svn info: tests: do not use set -e
> 
>   No idea how 'set -e' ever got in there; it completely breaks the
>   test script in case of an error.

I have a habit of using set -e in my scripts since I often
forget (or am too lazy) to check for errors when executing
a series of commands.

> [4/6] git svn info: tests: fix ptouch argument order in setup
> 
>   Swapped arguments caused ptouch to fail and tests to break.

Hm... I seem to remember explicitly setting the arguments one
way for one reason or another.

> Yes, I'm just whoring commit karma here, so feel free to squash these
> four into one if you like it better that way.
> 
> After these, 22 of 37 tests (all except --url, plus all unknown files)
> fail. Most of them are caused by 'git svn info' not URL-encoding the
> URL and Repository fields in the output, as SVN does.  6/6 fixes
> this.
> 
> However, the unknown files tests still fail, simply because 'svn info'
> itself fails on untracked files.  It would be great if someone who is
> still running SVN 1.4 could check whether that has been a bug in
> git-svn all along, or is actually a behaviour change on the part of
> SVN.

Oops, I upgraded to 1.5.x here already.  I should still have
another machine with 1.4 to check on tomorrow, though.

-- 
Eric Wong
