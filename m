From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git-archive's wrong documentation: really write pax rather than tar
Date: Thu, 4 Aug 2011 19:33:22 +0100 (BST)
Message-ID: <1312482802.68635.YahooMailClassic@web29518.mail.ird.yahoo.com>
References: <4E3ADCCB.6080206@lsrfire.ath.cx>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Aug 04 20:33:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp2jb-0005dI-9r
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 20:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab1HDSd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 14:33:26 -0400
Received: from nm2-vm0.bullet.mail.ird.yahoo.com ([77.238.189.199]:40562 "HELO
	nm2-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752640Ab1HDSdZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 4 Aug 2011 14:33:25 -0400
Received: from [77.238.189.52] by nm2.bullet.mail.ird.yahoo.com with NNFMP; 04 Aug 2011 18:33:23 -0000
Received: from [212.82.108.247] by tm5.bullet.mail.ird.yahoo.com with NNFMP; 04 Aug 2011 18:33:23 -0000
Received: from [127.0.0.1] by omp1012.mail.ird.yahoo.com with NNFMP; 04 Aug 2011 18:33:23 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 487760.99519.bm@omp1012.mail.ird.yahoo.com
Received: (qmail 78236 invoked by uid 60001); 4 Aug 2011 18:33:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1312482803; bh=SVD/PVTzjhI4pDBzN3uU7lLRWVH63bMREMxYOnmmijA=; h=X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=LjFQ8wo9ZDhYoGQCwVZAshzud8SeHly9s8F8sfJSuIxIrSWnpHoYHJowMskkOuqOzaSJ4pyJGuPtBBtoLTV/T57YT+qGu5O/VygPjVZisYq5A1SuztqWKPVIhVguDLmlGobcAFVf7oVmYbTnKCi3D8NxMf3ORc2xrXce0peVtzs=
X-YMail-OSG: w_mM1xEVM1nEH1jh87EoNOp4_u4oLl1C.FFMcIwNWKQ72k0
 q0AiN9EmF
Received: from [81.101.129.153] by web29518.mail.ird.yahoo.com via HTTP; Thu, 04 Aug 2011 19:33:22 BST
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/14.0.3 YahooMailWebService/0.8.113.313619
In-Reply-To: <4E3ADCCB.6080206@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178761>

--- On Thu, 4/8/11, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:

> From: Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>
<snipped>
> Ah, here it is:
>=20
> =A0 https://svn.r-project.org/R/trunk/src/library/utils/R/tar.R
>=20
> It's the ctype handling in function untar2 that rejects
> unknown entry types.
>=20
> For reference, the documentation of the pax format
> including a
> suggestion to treat unknown types like regular files can be
> found here
> (search for "typename"):
>=20
> =A0 http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.htm=
l
>=20
> > I think I tried the tree example and the R code also
> didn't like it
> > much... may be I'll give it another try.
>=20
> Did you try adding a ":" to the tree argument, e.g. this:
>=20
> =A0=A0=A0 $ git archive HEAD:
>=20
> instead of this?
>=20
> =A0=A0=A0 $ git archive HEAD
>=20
> Ren=E9

That's better! With a HEAD: , that code does a lot of:=20

Warning in untar2(tarfile, files, list, exdir) :
  checksum error for entry 'file...'

for each file it tries to extract, but at least it is extracting the fi=
les. I wasn't entirely sure about the notation used in the man page - i=
s
"v1.4.0^{tree}" same as "v1.4.0:" ? "HEAD:" is clearer, as most people =
has a HEAD...=20
