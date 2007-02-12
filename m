From: Junio C Hamano <junkio@cox.net>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 22:08:41 -0800
Message-ID: <7vr6svaowm.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	<20070211225326.GC31488@spearce.org>
	<9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
	<Pine.LNX.4.64.0702112022430.1757@xanadu.home>
	<7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
	<9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
	<7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
	<9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
	<9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
	<7vzm7k9c3c.fsf@assigned-by-dhcp.cox.net>
	<9e4733910702112155m3f5da9abgbeb2b6783005296f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, "Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 07:08:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGUMo-0006Ej-8U
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 07:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011AbXBLGIn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 01:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933012AbXBLGIn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 01:08:43 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:44151 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933011AbXBLGIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 01:08:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212060843.TCAK1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 01:08:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NW8h1W00b1kojtg0000000; Mon, 12 Feb 2007 01:08:42 -0500
In-Reply-To: <9e4733910702112155m3f5da9abgbeb2b6783005296f@mail.gmail.com>
	(Jon Smirl's message of "Mon, 12 Feb 2007 00:55:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39373>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> I am guilty of doing initial clones for different kernel trees from
> kernel.org when I could be doing a local clone of linus' tree and then
> pulling the deltas from kernel.org. But I'm lazy, I just kick the
> clone off in the background and it finishes in three or four minutes.
> I also do the clones when I have messed my local trees up so much that
> I don't know what is in them anymore.

Time to learn to use --reference perhaps?

	git clone --reference linux-2.6 git://.../linville/wireless-dev.git

where "linux-2.6" is local repository which is my personal copy
of Linus's repo.
