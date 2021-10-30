Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77323C433FE
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 17:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E1760F21
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 17:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJ3RHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 13:07:34 -0400
Received: from mout.web.de ([217.72.192.78]:54073 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbhJ3RHe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 13:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1635613497;
        bh=hRSL3WoA7H+nfAwkGo4/SeHJpXqeZYBMNx3tert1vA4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=AZC3g7P72KmyqzLn7ZR2mtq0RF1V36wMTHJtO9PETfwvhum2iI/xFxAdZkYVvSnZO
         Vfj0468jZDa5CNjI9x/y9XjkTEFAmmT1wRxhcr42noiznuQtZFoieI+hzgnomLu13Z
         j5fSLGVtCZ8O9Uu34BNVeQx1VQiQPMysxwguEcR8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MVJRl-1mFXd00nuJ-00SBdL; Sat, 30 Oct 2021 19:04:57 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] gpg-interface: handle missing " with " gracefully in
 parse_ssh_output()
Message-ID: <f6fca7c0-079c-4337-23d9-cd970c79b8ad@web.de>
Date:   Sat, 30 Oct 2021 19:04:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:02va4aza+D3dBwfcPVpdUwQdDvXK9courBnpPEd4HpFblEP3p7z
 U+dgunzfm7fiFXuztt7Cto8W+g+7mcN4wFxrCZD8SfcOkxMQRgR3WLNr2+GximCSpcTYKPJ
 sPbkgEkkNm6nDXVdZOc9DrMDbx6nYr6kk4HZ1DgVyClD+20loq6lXe2So1uQdgf6+DnvqgE
 uay4a757DT346AZZOYrpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uBDsiJqqVD0=:urzHvhPyoIOSuwYg8sQtLe
 lHnFj2e1NwXDGPRTv00jk+sj5Cz1htl8cXqw9O/bpaPZM9kmc6Xi2irKsNBm2aemtIRR2HXCb
 fdXn1vPM1gIKZbo3UzHj/2q81yLPj+InsUIt6yV8tASyDpiIo+MQ0Yq6WG4KsTreWWnOdjFPa
 szxgBGojy/FDSyiDT2Z3xyWyN0ebzvV0ql6Z464uXReBuh9pY8h5RO9/c5Rr4NqVO9eKM7KS6
 gS+whf9GxYnlaFGlx2WY8+D7XXv1tlIdBwajGHc1U6YvpV0Vl+O7gpmBgaBPr6XAw5SHGZG3V
 p3h6iCZ18/pMozuR8BCUpcGMmGJn3AYAzSDQAkpzJd3I31qQ/FUVNSzfzGQwSrADu5slPLLkP
 5cn9DtaI+3vyD6njKThidHiiSGePlEjkQdszixP3ABEdCXeiHFjWsWdYovajuQLntjVWOJB0g
 lZoQe2YmrvMyh01CZJRe5gpsF1ZgYL280rSyHUJpmDcmq1uoMSX4mWKKi2kZ/hiByBW0EvITQ
 jpWn1hHk5Azyt4QWQU3BaUkepkHQ1IdRGBWUbtqr5HA21Tq89OjDCBhnWizJhHz0kuzHkovwR
 ngY9snhk45lpMhsh7mfQIvvTydIMr2lhrRGlCFHMLQMYwB4kXmQ/lLoIBKCUFoMVncwIa1ELF
 QmH5Tld1PgRQbqfq2pPvR4MBFH0fZZaELxvFFVNEdNN5nEiGBDyWoUMz8XjiKk9MKg8AIYnti
 8LcBA+iVCi7fX4pFy7VMKLWiZnfxD9RE+beEcb1PnKo9DpY0f0ic+D7j3AzmTouMB1FAzrvq6
 flA+akVUvXttI5Ez106fTB1gjHHxWocpJ6ELy2QTAIMvZ2cnrLcmnUElBTG3OQCRsdMxH9SN0
 XE0Mmif/5tfboSQmfcs1XIrXoWy/RIv4WuX8YBbOF+AsqEtQ92Fk1/EG3elfhZ4uh9ZY+rENY
 uLYoyuwvRyHHGla8VoBS3WmGqHGXgxlHroZ142+0pGKTLMcKec4l+t/31N218ucC7ANxMnH5d
 gI1DcFFHPVEYIxbBxVnjyvlBIrwTydncOpoOOQcyqW9SmjQwHVyxuWV1gnWm4GcT4w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the output of ssh-keygen starts with "Good \"git\" signature for ",
but is not followed by " with " for some reason, then parse_ssh_output()
uses -1 as the len parameter of xmemdupz(), which in turn will end the
program.  Reject the signature and carry on instead in that case.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
This code was added after v2.33.0.
Patch formatted with --inter-hunk-context=3D2 for easier review.

Silly bonus question: What's the purpose of the "+ 1" and "- 1", which
seem to cancel each other out?

 gpg-interface.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 800d8caa67..62d340e78a 100644
=2D-- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -387,17 +387,19 @@ static void parse_ssh_output(struct signature_check =
*sigc)
 	line =3D to_free =3D xmemdupz(sigc->output, strcspn(sigc->output, "\n"))=
;

 	if (skip_prefix(line, "Good \"git\" signature for ", &line)) {
-		/* Valid signature and known principal */
-		sigc->result =3D 'G';
-		sigc->trust_level =3D TRUST_FULLY;
-
 		/* Search for the last "with" to get the full principal */
 		principal =3D line;
 		do {
 			search =3D strstr(line, " with ");
 			if (search)
 				line =3D search + 1;
 		} while (search !=3D NULL);
+		if (line =3D=3D principal)
+			goto cleanup;
+
+		/* Valid signature and known principal */
+		sigc->result =3D 'G';
+		sigc->trust_level =3D TRUST_FULLY;
 		sigc->signer =3D xmemdupz(principal, line - principal - 1);
 	} else if (skip_prefix(line, "Good \"git\" signature with ", &line)) {
 		/* Valid signature, but key unknown */
=2D-
2.33.1

