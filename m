From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 12:04:21 -0700
Message-ID: <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca>
	<200610180057.25411.jnareb@gmail.com>
	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
	<20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
	<20061018185907.GV20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 18 21:04:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaGiJ-0003ft-3Y
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 21:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWJRTEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 15:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbWJRTEX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 15:04:23 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:971 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161020AbWJRTEX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 15:04:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018190421.EDEB22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Oct 2006 15:04:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bv4R1V0011kojtg0000000
	Wed, 18 Oct 2006 15:04:25 -0400
To: git@vger.kernel.org
In-Reply-To: <20061018185907.GV20017@pasky.or.cz> (Petr Baudis's message of
	"Wed, 18 Oct 2006 20:59:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29253>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Wed, Oct 18, 2006 at 08:52:25PM CEST, I got a letter
> where Petr Baudis <pasky@suse.cz> said that...
>> Dear diary, on Wed, Oct 18, 2006 at 04:52:25PM CEST, I got a letter
>> where Linus Torvalds <torvalds@osdl.org> said that...
>> > In other words, to get such a pack, we'd _literally_ just do something 
>> > like
>> > 
>> > 	git-rev-list --objects-edge origin.. |
>> > 		git-pack-objects --stdout |
>> > 		uuencode
>> > 
>> > and that would be it. You'd still need to add a "diffstat" to the thing, 
>> > and tell the other end what the current HEAD is (so that it knows what 
>> > it's supposed to fast-forward to), but it _literally_ is that simple.
>> > 
>> > "plug-in architecture" my ass. "I recognize this - it's UNIX!".
>> 
>> Took me exactly an hour from mkdir cogito-bundle to cg-push to
>> kernel.org. :-)
>
> By the way, originally I just wanted to index and save the pack, but
> when trying to feed it to git-index-pack, I kept getting
>
> 	fatal: packfile '.git/objects/pack/pack-b2ab684daebea5b9c5a6492fa732e0d2e1799c8e.pack' has unresolved deltas
>
> while feeding it to git-unpack-objects works fine. Any idea what's wrong?

Yes.  You told the pipeline, with --objects-edge, to create a
thin pack.  By definition that is _not_ indexable.
