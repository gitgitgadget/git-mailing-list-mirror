From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stupid quoting...
Date: Sun, 24 Jun 2007 04:47:07 -0700
Message-ID: <7vzm2ptw04.fsf@assigned-by-dhcp.cox.net>
References: <86ir9sw0pi.fsf@lola.quinscape.zz>
	<7vd4zrw3k4.fsf@assigned-by-dhcp.pobox.com>
	<20070624065008.GA6979@efreet.light.src>
	<200706241314.46238.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 13:47:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2QYq-0007H2-PC
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 13:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbXFXLrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 07:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754245AbXFXLrK
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 07:47:10 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:58406 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbXFXLrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 07:47:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624114707.UACL2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 Jun 2007 07:47:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FPn71X0011kojtg0000000; Sun, 24 Jun 2007 07:47:08 -0400
In-Reply-To: <200706241314.46238.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Sun, 24 Jun 2007 13:14:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50794>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> I can't talk about "most" here, only local conditions, i.e. northern Europe 
> where both the legacy ISO encodings are very common with a steady increase in 
> UTF-8 usage, in the Linux community. People using OSS in windows almost 
> exclusively get the windows-1252 (for most practical purposes the same as 
> ISO-8859-1).
>
> Even a *very* small set of random people you will wind up with people having 
> different locales.

More problematic is the case where pathnames and contents are in
different encodings, even for the same language.

For example, my mbox files that store messages I receive from
people in Japan have contents in ISO-2022 as that is the
longstanding standard encoding used for e-mail over there, but
the pathname encoding used by the system I have that mbox file
on is EUC-JP.

If I were to create a patch between two versions of such a file,
the diff header would show the pathname encoded in one, and the
changed contents would ben shown in another.  As long as you
treat "git diff" output as binary blob, that would work just
fine, but when you have to transmit such a diff in e-mail as an
in-line patch, you would have troubles.
