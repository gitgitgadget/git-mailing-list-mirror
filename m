Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521DFC433ED
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 17:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176BB6128D
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 17:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhDDROW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 13:14:22 -0400
Received: from mout.web.de ([212.227.15.3]:42841 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhDDROU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 13:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617556454;
        bh=J/s3/rkKEqba0dGQYzeXFudYPR3cCFkVWCvR3o7BI9c=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=jfSxDiR6h3WOXSReY5uDTrrMvS5vG79Z5viB8w1tcodr//4gmuz+DD8gvvfp+f8sZ
         K1MCCslAmioSlfTn8aZxfrbPQ1OlweZp4znBUZrB7FHYb9AwY9I46EB3/muDEANZSa
         dTds6peYCH9MWru86i1LXWy710pW+PApAIbT2SSw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Me6Va-1lFHCq05ss-00PtBd; Sun, 04
 Apr 2021 19:14:14 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, d.torilov@gmail.com
Subject: [PATCH v3 1/2] precompose_utf8: Make precompose_string_if_needed() public
Date:   Sun,  4 Apr 2021 19:14:09 +0200
Message-Id: <20210404171409.32265-1-tboegi@web.de>
X-Mailer: git-send-email 2.30.0.155.g66e871b664
In-Reply-To: <xmqqtuotfre5.fsf@gitster.g>
References: <xmqqtuotfre5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eFUA3vt9HGS+dqRu1M0V6syAbz5yS8zLIDDmplb7GH/sKLNzb48
 mhyJtV8ER5udUn5KMrFN64Ub+oxC1RnNhS2uyq3yzraQl9jfBQY+53dEgmaTofRT6Jx5fYu
 y3rMTalAU08fwHG4nIY8HOBy96l5cDydT2KgAL8rcbvLvxaVJyGcMGnfoV1LWoy9WdQ0+UH
 i+5tGlVwlcW5M3pH/OLwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NR8nQZXrTYk=:oHkcC59WUZskwuMZwUxgGN
 l4z1lv1+UBcqLGRrf20n4nx6C1tmDHTl8nTEQuFhpckwfdDRRcb0M3zJK3vYBrGbgnTUbQOmr
 1Rv3c1QL6X81A3Fta3ES3ZbDmzm4NfPY2jqH/8BKXhhCqbG1xgpMOh/pzv29zQUj6HbAVhOTh
 Rsj1hNAzTPsyPGFSpTah0dtDKvCdCCELTVsAgI3aMnPvICMtNC1lNk7fAJCeGE0rRWWX19g1U
 GyD8IdDke7V9EUHX2seDue6js84ezw78vSL3K1dcXbDugoPsKtJ4wzUb+pmI7JfoxjsfkJqBD
 95h3gqcLgFFPURRbBSms7xHPWnVXKGnC0uap89EHB/nN3jcZl4p5+BhK1hCAEGbjFoxnG5Mlb
 4KbnqIZMMKTb/NX7AqBx6cah1wC0TTVHzB1yAuPRXz6g2i7qFIC6mfZ5EVUZtDLzCpq/ohB5O
 gq1/u6M8gcaxfqHUvlogtFtbf2jSGiHGfwbUz485RjFD93ZlF0rC+zRaLfY8wDaLJtL7EPi8Q
 xJalJg6heLVl77CYIcRkicpM1zIeb5NEwp2SrptkA6TsYB9w8U20VPMspnmbdYAbz8fZbTmSr
 Mmm7l5V+m3S07f2MRpJVOdJjGb87Y5xZ1JHVjjGyZPrpVwOgq0rnEwt/VXgKTvOeZt+SdLC9S
 57ZkUrjHCTZ8trmvAM/WpG5LDvcsXGVRwk78rAA1CJbYG1Pi3s+Aq7GeaNpLpe/M5OtPqBRio
 dcPnHQuGvTHBBsSLzgZuFdOjNatNwql0BSow1AAz+QBwl3gfi9rEchWn8PNLc5TDQSpSVI+HY
 LzjNxemn8q5pEqaQFN/eY+il+HTs98QS3tZ5VqW3F9xDZvSysMKY+p9TOsIz+H54gvIzZWdcf
 4cBuGSAp1RAMANdNZGzKY4ptSORNOsROFNvd8gN2LT90jccuceaUhdN8Xo0WWyYHP789BXDhz
 GSoGKwyUiG+SY3PUdW0Ybjpl9hL5asLv5Q2GWMqJrrToUvxI3uQJ4RPeSO2HQ2CTgQ2bwy1eo
 +Y2+DNOb+eBt4cwopuyLiMArv2aXVAe0f6ImxMlnHTXSVKL+0RpTuThbSrXE8wdMZ+a5NBMxR
 kBBSN0Xl/OzB8pbTdnjcxJJApTW9D9mabvIhViP6fHgM3gIoJy0UKUCIV0JN2toyzSCMoHbXS
 KWobQPW/qHsAuDYW5jOrp7QxudTbVRRbUvQA1CuvDEW/DNIKPf5h1Dk0wHNM4pISy1k2o=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

commit 5c327502,  MacOS: precompose_argv_prefix()
uses the function precompose_string_if_needed() internally.
It is only used from precompose_argv_prefix() and therefore
static in compat/precompose_utf8.c

Expose this function, it will be used in the next commit.

While there, allow passing a NULL pointer, which will return NULL.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 compat/precompose_utf8.c | 9 ++++-----
 compat/precompose_utf8.h | 1 +
 git-compat-util.h        | 5 +++++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index ec560565a8..cce1d57a46 100644
=2D-- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -60,10 +60,12 @@ void probe_utf8_pathname_composition(void)
 	strbuf_release(&path);
 }

-static inline const char *precompose_string_if_needed(const char *in)
+const char *precompose_string_if_needed(const char *in)
 {
 	size_t inlen;
 	size_t outlen;
+	if (!in)
+		return NULL;
 	if (has_non_ascii(in, (size_t)-1, &inlen)) {
 		iconv_t ic_prec;
 		char *out;
@@ -96,10 +98,7 @@ const char *precompose_argv_prefix(int argc, const char=
 **argv, const char *pref
 		argv[i] =3D precompose_string_if_needed(argv[i]);
 		i++;
 	}
-	if (prefix) {
-		prefix =3D precompose_string_if_needed(prefix);
-	}
-	return prefix;
+	return precompose_string_if_needed(prefix);
 }


diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index d70b84665c..fea06cf28a 100644
=2D-- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -29,6 +29,7 @@ typedef struct {
 } PREC_DIR;

 const char *precompose_argv_prefix(int argc, const char **argv, const cha=
r *prefix);
+const char *precompose_string_if_needed(const char *in);
 void probe_utf8_pathname_composition(void);

 PREC_DIR *precompose_utf8_opendir(const char *dirname);
diff --git a/git-compat-util.h b/git-compat-util.h
index 9ddf9d7044..a508dbe5a3 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -256,6 +256,11 @@ static inline const char *precompose_argv_prefix(int =
argc, const char **argv, co
 {
 	return prefix;
 }
+static inline const char *precompose_string_if_needed(const char *in)
+{
+	return in;
+}
+
 #define probe_utf8_pathname_composition()
 #endif

=2D-
2.30.0.155.g66e871b664

