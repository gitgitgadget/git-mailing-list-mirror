From: Junio C Hamano <junkio@cox.net>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 21:30:47 -0800
Message-ID: <7vzm7k9c3c.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	<20070211225326.GC31488@spearce.org>
	<9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
	<Pine.LNX.4.64.0702112022430.1757@xanadu.home>
	<7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
	<9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
	<7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
	<9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
	<9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, "Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 06:31:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGTmE-00062A-Ur
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 06:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932996AbXBLFat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 00:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932998AbXBLFat
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 00:30:49 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:59362 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbXBLFas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 00:30:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212053048.NHVE4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 00:30:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NVWn1W00h1kojtg0000000; Mon, 12 Feb 2007 00:30:48 -0500
In-Reply-To: <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
	(Jon Smirl's message of "Mon, 12 Feb 2007 00:01:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39367>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> On 2/11/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>> Same thing with cg clone, it's what is broken.
>> cg update is broken in the same way.
>> I'm using the current git version of cogitio.
>> I'll switch to the git commands, git clone is about 10x faster for the
>> clone anyway.
>
> Don't read anything into the 10x speed diff, my last git clone was
> really slow. I'm probably fighting other people at kernel.org to keep
> the tree in RAM.
>
> But pack to the original point, can't the server check and see if it
> has write access so that it can keep the fully packed tree? I've just
> caused kernel.org to needlessly repack the wireless-dev tree a dozen
> times playing with this clone command. If it didn't have to keep
> repacking for the clone, clone would be a lot faster.

You are assuming everybody does initial clone all the time.  I
do not think that holds true in practice.

For something like tglx historical tree that will _never_
change, there is a specific hack the repository owner can take
advantage of to always feed a prepackaged pack, although its use
is not advertised well enough (and I do not think it buys much
in practice).
