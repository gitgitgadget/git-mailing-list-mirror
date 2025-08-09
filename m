Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D32165EC
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754733938; cv=none; b=VJRpPWgpNTsXFgmx+2LbVJCF8HUqvpqMxHH1qC+l3f4k0+KbrCgp5oCiVeAPHYb8rATy0D1gjj8R/9lMjuX1/5Gtcp+dAuAAZwcrToQ4Cobs8gl5rGXSTQ9sRR9hDxTZOjsvuOZLSAYehS7ZeXP4/m14WdisjNH4Uym7JhgK0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754733938; c=relaxed/simple;
	bh=vdGMp7YUJGE+yxSqTW3oOJYyoePo1nnYwr0s8LQPNgk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KOCHEZdRmNQKvTjVSXWTSLqyl2H1ntVLDw/oS9XXNo/YaX8WYW9G+PXQF2juFJzhRDvy3J5TkviTOGEUmV4AtvNOFz2zHFR93KNk4rxhLQQBVEoBQgvqcxRfQlTNwxuBphe6QGsFOAOde9u8Ra1hH9LDAH2ZqVBoUH46AjQpTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=L3FRcmVe; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="L3FRcmVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754733932; x=1755338732; i=l.s.r@web.de;
	bh=xq/ZOHj0I+OnYXLJu13G0sSGA9FNYFX1l6Maaz5guIY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L3FRcmVeLOdyvN6tlD0ECQaVjs/v3CEm3pc5CNbPvmpBVfFEEhvmLiD3VTdobX7a
	 1jnooq9wgKR7KvNn4MP6A8koQEzDP3M6I9/1koBCk3dLhmcqrKPHg3h5lR2HA7jkh
	 Bb0XBCn9NeZdOVcEYAwyYS8dADkqVyyF1/3IOQWvtTIVfz2VAze8MoQoxfj/YI3yy
	 Uk3YtSOZTAstftHPp3P3kQ4L3AghklF3XwP7xLg2OMnYEGIwUBQBFUs3wPnB/tpyP
	 SsaYTNqRlUBioSO4DvV5T8wrWn9pZ01VgxpgITbgCE4+CXfAZ6F6cUzjCRPXVauvJ
	 Ks8VttOKYCS6Ei0kLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.152.110]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gXQ-1uX9ww2pTm-012hjR; Sat, 09
 Aug 2025 12:00:16 +0200
Message-ID: <890631d1-4e3e-4ea5-8f58-371fadf2b1b3@web.de>
Date: Sat, 9 Aug 2025 12:00:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] merge: don't document non-existing --compact-summary argument
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p2pVNFDS+qY14soQsTSAJn0DJJw5BKQk04cOmV9EPiwXfGyo54b
 kdyMTYOPY6kiUHMeu2JA9nBKbrXKaQDMJ/pOfM7x19mlGclk9ky0px5Cxu/sZoKblEQAkGz
 cshs4JsMEsSwKuPcvZf+s1Vwft8MNTaUKmfzIRvHV/239EeqgFCtSy4WgDEY9/TfNx5Cwju
 u4OgGsCGusDqupp6bFqYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NJ0fsDzm+/4=;8ezRoGekcCpqJeNmSjALiz2jBpE
 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

3a54f5bd5d (merge/pull: add the "--compact-summary" option, 2025-06-12)
added the option --compact-summary to both merge and pull.  It takes no
no argument, but for merge it got an argument help string.  Remove it,
since it is unnecessary.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index dc4cb8fb14..ce880e6ccb 100644
=2D-- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -264,7 +264,7 @@ static struct option builtin_merge_options[] =3D {
 	OPT_BOOL(0, "stat", &show_diffstat,
 		N_("show a diffstat at the end of the merge")),
 	OPT_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
-	OPT_CALLBACK_F(0, "compact-summary", &show_diffstat, N_("compact-summary=
"),
+	OPT_CALLBACK_F(0, "compact-summary", &show_diffstat, NULL,
 		       N_("show a compact-summary at the end of the merge"),
 		       PARSE_OPT_NOARG,
 		       option_parse_compact_summary),
=2D-=20
2.50.1
