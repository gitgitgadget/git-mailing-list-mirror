From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 07 Aug 2007 15:26:27 -0700
Message-ID: <7vir7r56cs.fsf@assigned-by-dhcp.cox.net>
References: <f99cem$4a4$1@sea.gmane.org>
	<Pine.LNX.4.64.0708071257350.14781@racer.site>
	<f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org>
	<20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net>
	<66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de>
	<30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>
	<07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 00:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIXVn-00080y-5e
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 00:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935338AbXHGW0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 18:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935037AbXHGW0c
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 18:26:32 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:53673 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761257AbXHGW0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 18:26:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070807222628.JHOL7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 7 Aug 2007 18:26:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZAST1X0091kojtg0000000; Tue, 07 Aug 2007 18:26:28 -0400
In-Reply-To: <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de> (Steffen Prohaska's
	message of "Tue, 7 Aug 2007 21:41:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55277>

Steffen Prohaska <prohaska@zib.de> writes:

> The discussion below basically leads to two questions:
>
> Is there any chance that git can be ported to cygwin's textmode?
>
> Is there any chance that patches would be accepted that try to
> do so? Even if they add "b" to fopen and O_BINARY to open, which
> both are useless on Unix?
>
> Junio, Linus?

Hopefully fopen() would not barf upon seeing "b", and O_BINARY
can be ifdefed to 0 on platforms where it is not applicable and
or'ed in to the flags.  As long as they can be proven to be
useful on Cygwin, I do not see an issue.
