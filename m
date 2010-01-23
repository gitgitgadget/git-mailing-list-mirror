From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sat, 23 Jan 2010 14:48:42 +0100
Message-ID: <201001231448.42721.robin.rosenberg@dewire.com>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <201001231240.28138.robin.rosenberg@dewire.com> <201001231409.30706.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 23 16:07:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYhZx-00023v-Ez
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 16:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab0AWPDr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jan 2010 10:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755437Ab0AWPDr
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 10:03:47 -0500
Received: from mail.dewire.com ([83.140.172.130]:28517 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753727Ab0AWPDq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jan 2010 10:03:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 465DC13F4127;
	Sat, 23 Jan 2010 16:03:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hRrkkOPBTFFl; Sat, 23 Jan 2010 16:03:42 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id A00C280034C;
	Sat, 23 Jan 2010 16:03:42 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <201001231409.30706.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137848>

l=F6rdagen den 23 januari 2010 14.09.29 skrev  Johannes Sixt:
> On Samstag, 23. Januar 2010, Robin Rosenberg wrote:
> > It seems this function does something unhealthy when you pass a pat=
h of
> > the form //server/share. On windows dropping the double // at the
> > beginning makes it a different path since // is the UNC prefix.
>=20
> There is no problem in practice.
>=20
> The function returns either the input unmodified, or it strips also a=
t
>  least one directory component, except when base is only "/" (or "//"=
 or
>  "///"...). I said in practice, because on Windows it does not make s=
ense
>  to invoke git with (literally)
>=20
>    git --git-dir=3D//server/share/repo.git --work-tree=3D/ ...
>=20
> i.e., without a drive prefix before the slash of --work-tree.

Why not? //foo/bar/z is just as valid and useful a path as x:/z.=20

Defining a drive-letter with msysgit is tricky because I have to find o=
ne that=20
is available and then also restart every msys bash instance to make msy=
s
see it.

-- robin
