From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 04 Jun 2006 13:58:30 -0700
Message-ID: <7vejy48wp5.fsf@assigned-by-dhcp.cox.net>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	<7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	<20060603151240.GA4024@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 22:58:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmzgK-0001mk-9Z
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 22:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWFDU6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Jun 2006 16:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWFDU6d
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 16:58:33 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:4346 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932247AbWFDU6c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 16:58:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060604205831.JYPH554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 16:58:31 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060603151240.GA4024@diku.dk> (Jonas Fonseca's message of "Sat,
	3 Jun 2006 17:12:40 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21283>

Jonas Fonseca <fonseca@diku.dk> writes:

> The problem is of course to come up with some ascii-art which is both
> readable and dense. Below is my mockup of something not using line
> graphics, however using line graphics it might be possible to get
> something more unambiguos but also more "edgy".

I do not necessarily think an ascii-art is needed, nor an
appropriate way to present it to the curses user.  When the user
wants to "view" a commit, you could show from which branch heads
and from which tags the commit is reachable, and perhaps which
tag is the latest among the ones reachable from that commit, as
part of the commit detail information you display on the lower
pane (log/diff view).

I may not be using tig in the way it was intended to, but I
often find it frustrating having to do the following:

    - start tig, which shows list of one-line logs.  Wonderful.

    - browsing around by UP or DOWN and stop at one particular commit
      I want to view closely.  Press Enter and the screen split
      into two and I see what I want to see.  Again, wonderful.

    - I want to see the neighbouring commits, but UP or DOWN
      does not do what I na=EFvely expect.  It scrolls the lower
      pane.  I say TAB to go up.

    - Press UP or DOWN and I can move the highlight to
      neighbouring commits.  This is wonderful, but the lower
      pane does not follow this -- it keeps showing the original
      commit, and I have to say ENTER again.

It might make sense to make the log/diff view follow what
happens on the main view when both are on-screen.
