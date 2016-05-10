From: Sascha Silbe <sascha-ml-reply-to-2016-2@silbe.org>
Subject: diff --break-rewrites for just a part of a file
Date: Tue, 10 May 2016 18:22:34 +0200
Message-ID: <toea8jx3mt1.fsf@mimosa.sascha.silbe.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 18:32:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0AZq-0003tB-LZ
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 18:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbcEJQcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 12:32:01 -0400
Received: from bbox.sascha.silbe.org ([84.201.25.44]:60695 "EHLO
	bbox.sascha.silbe.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbcEJQcA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 12:32:00 -0400
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 May 2016 12:32:00 EDT
Received: from mimosa.sascha.silbe.org (unknown [176.2.62.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client CN "", Issuer "stunnel Pseudo-CA" (verified OK))
	by bbox.sascha.silbe.org (Postfix) with ESMTPS id 88298BF1A4
	for <git@vger.kernel.org>; Tue, 10 May 2016 18:22:59 +0200 (CEST)
Received: (nullmailer pid 24730 invoked by uid 8193);
	Tue, 10 May 2016 16:22:55 -0000
User-Agent: Notmuch/0.18.1 (http://notmuchmail.org) Emacs/23.4.1 (arm-unknown-linux-gnueabi)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294153>

--=-=-=

Hello,

the other day I was reviewing a patch that replaced a large chunk in a
Makefile with completely different logic. No matter what diff algorithm
and options I threw at it, the diff would always synchronise at the
empty lines between individual targets and thus show the rewrite of a
larger section as complete replacements of many smaller, but directly
adjacent sections (only separated by a blank line).

--break-rewrites would be nicely suited for this case, but once I dialed
down the parameters enough for the option to apply at all, it showed the
entire file as being replaced rather than just the section in between
that actually changed. Is there a way to have --break-rewrites leave out
the unchanged lines at beginning and end of the file?

A combination of --break-rewrites and --inter-hunk-context that merges
changes with less than the given number of unchanged lines between them
into a single delete/insert change would be even better. But just
ignoring the unchanged header and footer of a file for --break-rewrites
would already go a long way.

Sascha

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBCgAGBQJXMgrLAAoJELpz82VMF3Da9GkH/2hR791ylUK4zUquSO7xqsIw
FpnK0r9CGzffSeoEDEzrqF8Mnf2QNFJEk25sk4nkhmFpBmfhe6EnAAjNmVU5h1+j
egC/2k1M+89LmXGUoQigj0dPDUk+LWiTEhlHs4PJ4Aj1V4mTwKUrQSXs30CzxiXM
Vjp6KjlBURg28vgfxyKrff0KHZl2ofReu+Gnk2Bnw8OvOZ6F68fFbgmQgnCpBl2i
I10BKOApL+0XZd58mf6pkQHfJvppektChaJmoPf6CaJ0xTVDV99DbnUEOKBgpx2d
FwdbXNI05SW+I5jzIvPrNJnCgttSL4d2w4I3uxwuliKx3Ozlzzz1wEqag//bcPc=
=BvuX
-----END PGP SIGNATURE-----
--=-=-=--
