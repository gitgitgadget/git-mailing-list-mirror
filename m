From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Inspecting a corrupt git object
Date: Wed, 4 Aug 2010 11:48:49 +0200
Message-ID: <201008041148.49668.trast@student.ethz.ch>
References: <20100804092530.GA30070@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Magnus =?iso-8859-1?q?B=E4ck?= <magnus.back@sonyericsson.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 11:48:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogaao-0005ei-KM
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 11:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393Ab0HDJsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 05:48:53 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:57794 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757076Ab0HDJsw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Aug 2010 05:48:52 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 4 Aug
 2010 11:48:51 +0200
Received: from thomas.site (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Wed, 4 Aug
 2010 11:48:51 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100804092530.GA30070@jpl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152569>

Magnus B=E4ck wrote:
>=20
> $ head -n 1 /tmp/hexdump_corrupt.txt
> 00000000  78 9c 2b 29 4a 4d 55 30  32 36 62 30 34 30 30 33 |x.+)JMU02=
6b04003|
> $ head -n 1 /tmp/hexdump_okay.txt
> 00000000  78 01 2b 29 4a 4d 55 30  32 36 62 30 34 30 30 33 |x.+)JMU02=
6b04003|
>=20
> From what I gather from the community book and Pro Git, a git object
> file is a deflated representation of the object type as a string, the
> payload size, a null byte, and the payload. Is there a standard tool =
for
> inflating the file back so that I can inspect what the actual differe=
nce
> between these two are? Short of writing a tool utilizing zlib, at lea=
st.

I'm sure it's a one-liner in almost any scripting language, e.g. you
can use

  python -c 'import sys,zlib; sys.stdout.write(zlib.decompress(open(sys=
=2Eargv[1]).read()))'

with a filename argument if you have Python at hand.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
