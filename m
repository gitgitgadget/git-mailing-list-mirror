From: Ryan Anderson <ryan@michonline.com>
Subject: git-diff-files and fakeroot
Date: Mon, 16 Jan 2006 21:10:57 -0500
Message-ID: <43CC5231.3090005@michonline.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFEB0CA84C60303B4A08B6D0B"
X-From: git-owner@vger.kernel.org Tue Jan 17 03:11:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EygJR-0004X1-AZ
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 03:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWAQCLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 21:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWAQCLG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 21:11:06 -0500
Received: from mail.autoweb.net ([198.172.237.26]:46800 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751086AbWAQCLF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 21:11:05 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1EygJL-0000Vm-7B
	for git@vger.kernel.org; Mon, 16 Jan 2006 21:11:04 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1EygJK-0002pR-5b
	for git@vger.kernel.org; Mon, 16 Jan 2006 21:11:02 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1EygJJ-0007hv-KA
	for git@vger.kernel.org; Mon, 16 Jan 2006 21:11:01 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14770>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFEB0CA84C60303B4A08B6D0B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I've been trying to track down a strange issue with building kernels
(and scripts/setlocalversion) and finally realized the problem was the
when run under fakeroot, git-diff-files thinks everything is changed
(deleted, I believe)

Oddly, running "git status" seems to correct things.

Running "fakeroot git-diff-files" gives me lines like this:


:100644 100644 f866059f24bacd314fa4a979334a9893dbfc19ba 0000000000000000000000000000000000000000 M      write-tree.c

Looking at strace output, I can't see a difference that appears meaningful,


I can probably work around this, some other way, but knowing if
this is something that is fixable in git itself or not would be nice.

Thanks!


-- 

Ryan Anderson
  sometimes Pug Majere


--------------enigFEB0CA84C60303B4A08B6D0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDzFI1fhVDhkBuUKURAn5xAKCyytq5wInYkRCK/N6wcQLym8SS8QCggLbA
coRKlFq5XPZwuR+qyRrhlpQ=
=zxPC
-----END PGP SIGNATURE-----

--------------enigFEB0CA84C60303B4A08B6D0B--
