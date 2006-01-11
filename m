From: walt <wa1ter@myrealbox.com>
Subject: Re: git-bisect is magical
Date: Wed, 11 Jan 2006 10:07:19 -0800
Organization: none
Message-ID: <dq3hgn$maf$1@sea.gmane.org>
References: <dpuoqf$3rp$1@sea.gmane.org> <Pine.LNX.4.64.0601091516460.5588@g5.osdl.org> <dq11c6$g15$1@sea.gmane.org> <Pine.LNX.4.64.0601101131540.4939@g5.osdl.org> <Pine.LNX.4.64.0601101143180.4939@g5.osdl.org> <dq168p$3kt$1@sea.gmane.org> <Pine.LNX.4.64.0601101308540.4939@g5.osdl.org> <dq1o88$1bm$1@sea.gmane.org> <Pine.LNX.4.64.0601101846170.3294@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 11 19:08:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwkOJ-0003aR-TC
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 19:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWAKSIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 13:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWAKSIG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 13:08:06 -0500
Received: from main.gmane.org ([80.91.229.2]:37848 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751436AbWAKSIE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2006 13:08:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EwkNv-0003Ui-IN
	for git@vger.kernel.org; Wed, 11 Jan 2006 19:07:47 +0100
Received: from adsl-69-234-210-171.dsl.irvnca.pacbell.net ([69.234.210.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jan 2006 19:07:47 +0100
Received: from wa1ter by adsl-69-234-210-171.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jan 2006 19:07:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-210-171.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20060111)
In-Reply-To: <Pine.LNX.4.64.0601101846170.3294@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14493>

Linus Torvalds wrote:
[...]
> So when you did "git checkout origin", you basically blew away all the 
> development you had done in the default "master" branch, and switched to 
> _another_ branch...

First, many thanks to you, Junio, and Sean (by email) for the great
replies -- all three were extremely helpful, and this is all finally
starting to make sense to me.

Now, I don't know whether this anecdote will give you any new
information, but I'll offer it.

After I did the 'git checkout origin' yesterday, I didn't (yet) know
what I was doing, so I made the following pilot-errors while still
in 'origin':  I did 'git-reset --hard origin' and then very early
this morning I did cg-update, both of which seemed to work fine and
gave no error messages, and I compiled a new kernel from the result.

After reading the three essays from you guys :o) I realized that I
had made these two mistakes, and tried to switch back to master:
$git-branch
  bisect
  master
* origin
$git-checkout master
fatal: Entry 'Documentation/kernel-parameters.txt' would be overwritten
by merge. Cannot merge.

So I cloned a fresh copy of your repository and built a new kernel.
What I learned from this was that the new fixes to Makefile and
setlocalversion (at a minimum) were not actually applied to the
checked-out sources in my 'origin' misadventure.  (I watched the
commits being listed by cg-update, so I know the fixes were really
downloaded -- but they were not applied to the checked-out sources
as they normally would be.)

Would these anomalous results be expected -- given the, um, unusual
circumstances?

Thanks again!
