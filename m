From: Kent Borg <kentborg@borg.org>
Subject: Re: git-p4
Date: Sun, 12 Sep 2010 11:30:57 -0400
Message-ID: <4C8CF231.6090403@borg.org>
References: <4C8A8CE8.90600@borg.org>	<20100910235323.773d2c5b@varda> <AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?QWxlamFuZHJvIFJpdmVpcmEgRmVybsOhbmRleg==?= 
	<ariveira@gmail.com>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 18:01:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuozV-00038F-KU
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 18:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab0ILQBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 12:01:08 -0400
Received: from borg.org ([64.105.205.123]:34654 "EHLO borg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012Ab0ILQBH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 12:01:07 -0400
X-Greylist: delayed 1799 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Sep 2010 12:01:07 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: kentborg)
	by borg.org (Postfix) with ESMTP id 43449877FD;
	Sun, 12 Sep 2010 11:31:03 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156036>

Tor Arvid Lund wrote:
> [git-p4: depot-paths = "//Path/To/Your/Project/": change = 30049]
> .. where the 'change' number is the number of the perforce changelist
> you synced using git-p4.
>
> So - work that you want to submit to p4 should be rebased on top of
> such a commit. Then it should work to do git-p4 submit.
>   

That doesn't work.  I am suspecting there is a tangle in my branches.

Firing up a Python session and manually running the git-p4
findUpstreamBranchPoint() I get back something reminiscent of the commit
I made at your suggestion:

  ['remotes/p4/master', {'change': '160991', 'depot-paths':
['//depot/imgeng/sw/inferno/kernel/linux-2.6.33-quatro']}]

I thought it looked reasonable, but when I try to run the git p4 summit,
at line 811 in git-p4 it is doing:

  git rev-list --no-merges remotes/p4/master..master

And then reversing the results and trying to apply them all, starting
with 1da177e (which is Linux-2.16.12-rc), and again it fails.  (Again,
thank goodness it failed at that.)  How is git rev-list supposed to get
a limited list back?

Anyone spot my silliness?  Next I'm going to see if I can create a
normal (and working) case for comparison.  (As a newbie git is one
thing, trying to understand git-p4 at the same time makes it that much
harder.)


Thanks a bunch,

-kb, the Kent who Monday morning (UTC-0400) would love to casually say
"Oh, yes, git-p4 is working great, both directions, no problem.".
