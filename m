From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 14 Oct 2007 21:50:13 +0200
Message-ID: <471272F5.2000902@op5.se>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com> <Pine.LNX.4.64.0710130130380.25221@racer.site> <853awepyz6.fsf@lola.goethe.zz> <20071013202713.GA2467@fieldses.org> <Pine.LNX.4.64.0710140135020.25221@racer.site> <alpine.LFD.0.999.0710131810550.6887@woody.linux-foundation.org> <20071014014445.GN27899@spearce.org> <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com> <47125BF7.2070503@midwinter.com> <20071014184050.GB31260@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Grimm <koreth@midwinter.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 21:50:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih9Tp-0008AG-Kd
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 21:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbXJNTuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 15:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbXJNTuU
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 15:50:20 -0400
Received: from mail.op5.se ([193.201.96.20]:45207 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103AbXJNTuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 15:50:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B036D17306EE;
	Sun, 14 Oct 2007 21:50:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Ryp58OQRzpj; Sun, 14 Oct 2007 21:50:15 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 2DF16173068B;
	Sun, 14 Oct 2007 21:50:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071014184050.GB31260@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60896>

J. Bruce Fields wrote:
> On Sun, Oct 14, 2007 at 11:12:07AM -0700, Steven Grimm wrote:
> 
>> It's possible git's introductory documentation should delay talking 
>> about "git branch" until later, and start off talking about how to work 
>> with one (checked out) branch per repo.
> 
> One frequent use case is the case of a tester that wants to try out a
> bugfix in some topic branch.  You want to tell them: "please test the
> fix-that-bug branch in git://myproject.org/~me/repo.git".  They need to
> get that checked out somehow.  And they should be able to do it without
> re-cloning every time.
> 
> That's one motivation, among others, for including git-branch (and
> git-remote) very early.
> 
> Though actually the quickest way to checkout an arbitrary revision is
> with detached heads, and that doesn't require learning git-branch right
> away.

But the *easiest* way, where "easiest" means "involves the fewest commands
with smallest risk of fscking up your own repo", is to do


git clone <other-devs-repo> other-devs-repo
cd other-devs-repo
git checkout -b thebug <the-bug-hash>


The proper command-sequence for any other way of doing it will inevitably
be different depending on whether or not the user has changes in his
worktree or not, whether or not those changes conflict with the bug-spot,
whether or not he's got the other developer's repo added as a remote, etc,
etc.

Too many ifs, really, whereas the first way is guaranteed to work exactly
the same way everytime, at the cost of almost always being ridiculously
suboptimal.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
