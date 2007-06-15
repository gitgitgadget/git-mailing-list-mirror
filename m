From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFT] Format our Documentation/ with both AsciiDoc 7 & 8
Date: Fri, 15 Jun 2007 15:52:09 -0700
Message-ID: <7vy7ik7rvq.fsf@assigned-by-dhcp.pobox.com>
References: <11810823561507-git-send-email-madcoder@debian.org>
	<7vfy4t915f.fsf@assigned-by-dhcp.pobox.com>
	<20070615080935.GB28554@artemis.intersec.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Jun 16 00:52:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzKeL-0000Di-OJ
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 00:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203AbXFOWwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 18:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756007AbXFOWwL
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 18:52:11 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:58908 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533AbXFOWwK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 18:52:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070615225210.CKAU3993.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 Jun 2007 18:52:10 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Bys91X00E1kojtg0000000; Fri, 15 Jun 2007 18:52:09 -0400
In-Reply-To: <20070615080935.GB28554@artemis.intersec.eu> (Pierre Habouzit's
	message of "Fri, 15 Jun 2007 10:09:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50281>

Pierre Habouzit <madcoder@debian.org> writes:

>   sadly, it does not fixes the issue I reported with git-pull.1 (e.g.)
> that reads:
>
>    <refspec>
>        The canonical format of a <refspec> parameter is ?<src>:<dst>; that
>
> whereas it should be:
>
>    <refspec>
>        The canonical format of a <refspec> parameter is +?<src>:<dst>; that

That is very unexpected, especially as your e-mail address is in
debian.org.

 * My local test and build usually is done with AsciiDoc 7.1.2
   that is shipped with Debian, without any local modifications.
   The part you quoted is formatted like this (I indented for
   e-mail inclusion and line-wrapped below):

    .PP
    <refspec>
    .RS 3n

    The canonical format of a <refspec> parameter is +?<src>:<dst>;
    that is, an optional plus +, followed by the source ref,
    followed by a colon :, followed by the destination ref.

   This is the same with or without the patch we are
   discussing.

 * I updated my notebook that runs Debian with AsciiDoc 8.2.1
   and tested with the patch.  The formatted result matches the
   above.

 * I tried the above with a hand-installed AsciiDoc 8.2.1 from
   the tarball distribution.  Again, the formatted result of the
   quoted part matches.

 * The preformatted manual pages on man branch in git.git are
   generated on a k.org machine that runs AsciiDoc 7.0.2 on
   FC5.  The version before the patch is formatted like this:

    .TP
    <refspec>
    The canonical format of a <refspec> parameter is +?<src>:<dst>;
    that is, an optional plus +, followed by the source ref,
    followed by a colon :, followed by the destination ref.

   I haven't had a chance to test how it comes out with the
   patch, but because the only difference under AsciiDoc 7 is
   the definition of {caret} macro, I do not expect any change
   in the quoted area.

In other words, there is no breakage like you are observing in
the original (nor updated) version with any of the platforms and
AsciiDoc versions I had handy to test.  There is something
different with the version of AsciiDoc you are using, but I
cannot tell what that is.
