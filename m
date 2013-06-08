From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t0070: Use precondition CANNOTWRITE
Date: Sat, 08 Jun 2013 09:23:22 +0200
Message-ID: <51B2DBEA.10205@kdbg.org>
References: <201306080851.17044.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 08 09:23:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlDV1-0008PB-7D
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 09:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab3FHHX0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 03:23:26 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:52272 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751212Ab3FHHXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 03:23:25 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 85866CDF83;
	Sat,  8 Jun 2013 09:23:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7617D19F5E5;
	Sat,  8 Jun 2013 09:23:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <201306080851.17044.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226786>

Am 08.06.2013 08:51, schrieb Torsten B=C3=B6gershausen:
> Filesystems like VFAT or NTFS allow to create files regardless of
> the write permissions of the directory.
>=20
> Therefore "mktemp to unwritable directory" in t0700 will always fail =
on
> Windows using NTFS.
> This TC has been disabled for MINGW, and needs to be disabled for CYG=
WIN.
>=20
> Use the precondition CANNOTWRITE which is probing the file system and
> works for MINGW, CYGWIN and even for Linux using VFAT.

Shouldn't it be a matter of

-test_expect_success POSIXPERM 'mktemp to unwritable directory prints f=
ilename' '
+test_expect_success SANITY 'mktemp to unwritable directory prints file=
name' '

It probably wouldn't catch Linux VFAT, but there're already a lot of
tests that don't pass on Linux VFAT.

-- Hannes
