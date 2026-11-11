Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437363;
	b=ULqQmvENI4YlqiciQebHyARPjcPxUDvNt34wMY1iMzKq18k8sjZyb89HDdpx1lzH5ipI
	 ndF8gn0o0G9rASwLvvzOsy+DEtgsBT5Bv3m8RKqPl11Sedurcut0KtRJaQha7yX/mq4Og
	 c/tj2TrOnL4RfsZa4ldkwPuVQYifDU7IoUZZ25F8QV4rMd7f8uDSySalQW7pgJBBVoeTH
	 cCL5CxAlFu5KV3LEpN+JiVy1PYFNuJjGg6J7oAtsemrYPgoUVgsipLquebj3KoSTWLGoH
	 LsWgeGXD1yX+pZIM9PIqo2s4I/EuZkdYZaP6nhgyx9RBBL0I8RtVAl/B7MaiKfqsPBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=j9kiQFtR7ZzXSc2zfV3tHThfWht6wj4IYbR+PtkNKgg=;
	b=emULhdhMOj+G8V1gct/j5CnuXlV+LPcQ+VKbaKUO0vQxbMs76BrNUBI5r/yo3/3VzHOv
	 UeSgaLGJJqfLZ92nXBFNJJCp2RBSskpJylsUw0XCVgQl7vgY1iFchohOMMQVSvKn00TNu
	 7NhDKMN6FtG8MKW9lDSdb0egFbLb4a9wzaFKnoUVP+bdoLGrmUVJECO1sK6RKW7ZIz8uK
	 BgVZSY8A2FFChxx+YygClWY06F9D8iGoTjTbfJItw0A9ptu4kKPU80wMJVj/RpH+piEbv
	 YM29qCmETUKyrf6ref6Jkq0r05SmhVlAJfoOaXs9tiAL2h57NqTpobdG5zRMG6G5diw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JyHVp4KJ;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F03606AEE6
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F03606AEE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JyHVp4KJ
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6de1fd5f572so1533449eaf.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437362; x=1795042162; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j9kiQFtR7ZzXSc2zfV3tHThfWht6wj4IYbR+PtkNKgg=;
        b=JyHVp4KJo0GXEuxkIe7g2VIZeXaPlBEjfecbiDIgwbiTTGUPVCf/tpNISaXfUT/QkW
         wgR/1BB0ocyj1jP/9Pq9X2V3JieEkyxZ9OnaTN2TMmfGK2q9bAPdcVJeZus9OoGReYmi
         1h7U+CdT9y30+6TTpblj8bieuVhKuNIPpvAWqOKbVgs58SV6uki16SwoihdRyRi3BXc9
         U9wx0sJdFksWPxNOAEkJvxcuDEzsZaHay5Ej1OLq/DheA2Mamn/jMeMJvOBiDesUdZM1
         jpeTpLQ687/K68mw3bRwbplgRWlWEzVjJZHDLGTh0YSvf0JxF2xuU9Z5zyG3/b+aL16y
         +MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437362; x=1795042162;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9kiQFtR7ZzXSc2zfV3tHThfWht6wj4IYbR+PtkNKgg=;
        b=s863Gdt6VmsxluFQmKNMiTxcOv62Tr/TZ/m8C7q44wSTQVPRkbmxSysURXpL69gigP
         w/waZxHGXS1qwGh2duxnnh/y0t6Gl2ml811Pf+5ACPe0xYpp5zWkR7NKHJVS3KSo1kkl
         Bl9nHu44mTqRVBMeIGIE1ArnHuDaAPHeAfHITuwjFaMR/gmBaGdPEXg5c7HYLzdYYj1o
         x4Qcnf9By5aJECSw0pLrnMOaHy/1fjAPvr2aJZTWg2wEld2UZnfwfKfgvI3HqDPONTic
         8E+QWllkUrHQGb1YEm2aEaD99BH4praaha5qiNHVNETsOXS9rOOl3oRoKsnJcSfOG/0S
         TkiQ==
X-Gm-Message-State: APuU4Z/j2Z6rK+VqtgtP0OZHTL2EPb3BEb8cxig+mzV4h1m1LSLejDgs
	EBwjCuvrVqe4JezhIN7hlYu9HIAm8WA0BqSzYq4ejtmkW+UxSdcE6QGw+qp+F1Oc
X-Gm-Gg: AYBFou3Xa5GBQDhvVOUhNaRZ3XYW5wPlnbl0kWswl0it9bUbwS0bywEw9Ta5u8t/Xot
	/yfCAVPjl1SbHNFH1c5uZHnRTe8XapseTYpNP6c9lgtalPUIlpySA5A4GMrKRHY1P/oVFkyL+HX
	+1PV2xFIv2eDg1GpVdDp7hMssUdhMLpBP/VSDoCHfkbCBEfaRcokCnczgg8l3oRIaqoDWPXmDvx
	YOt0LMprZtgXc7+S6TDfyvZpXRYf9YcpUsn9G2wDSlUzTK4gVZN2M606v7l520ByL7qzxWYgaFf
	2nVcCW8jaXyboPoh8DcVq6hCB3hzEO3tDl1evk5kkUPepAAQt/vm4txqMKCxTnUytI+HArZecTa
	dINJHwhjWZGlprd1xI1qTpmyzHVdgciMslafeqYHNmsI3NjkIoyRif1KO0O8R3sb2y3WtxPd9W1
	4xZ+7ZiCSjYlBSMUcFya2469O6VYBNjVSm4S3RVdpGtRjDZN27tAFtDvaw5oAKnki4YLxokbWgN
	pHqCAiQKMqix6H91zI9gdZTlzH+YV7+ZkA2Ed8H5KqpbfjN3qS0GGKYEg7sAvLQJ9yyfXWDI5dY
	8ZCYpwyDXe9/M2OnKO352XUhFTGGktUq6kg=
X-Received: by 2002:a05:6820:1386:b0:71a:17b:11ce with SMTP id 006d021491bc7-71a017b1252mr402994eaf.78.1794437362242;
        Wed, 11 Nov 2026 14:49:22 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a6f2a264sm4943993eaf.1.2026.11.11.14.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:21 -0800 (PST)
Message-Id: <ec9d7fd183a100b0a7e52ea1b4968f1979e61048.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:02 +0000
Subject: [PATCH v3 02/15] odb: handle NULL values for core.alternateRefs*
 config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A core.alternateRefsCommand or core.alternateRefsPrefixes without a
value makes "git fetch", "git receive-pack" and
"git rev-list --alternate-refs" segfault in a repository that borrows
objects from an alternate: fill_alternate_refs_command() passes the
NULL value to strvec_push() or strvec_split().

Both settings take a string. Read them with
repo_config_get_string_tmp(), which rejects a missing value with
config_error_nonbool(), as the previous commit does for
rebase.missingCommitsCheck.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 odb.c                     | 4 ++--
 t/t5618-alternate-refs.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/odb.c b/odb.c
index 865c404910..ea086be8b3 100644
--- a/odb.c
+++ b/odb.c
@@ -161,7 +161,7 @@ static void fill_alternate_refs_command(struct repository *repo,
 {
 	const char *value;
 
-	if (!repo_config_get_value(repo, "core.alternateRefsCommand", &value)) {
+	if (!repo_config_get_string_tmp(repo, "core.alternateRefsCommand", &value)) {
 		cmd->use_shell = 1;
 
 		strvec_push(&cmd->args, value);
@@ -173,7 +173,7 @@ static void fill_alternate_refs_command(struct repository *repo,
 		strvec_push(&cmd->args, "for-each-ref");
 		strvec_push(&cmd->args, "--format=%(objectname)");
 
-		if (!repo_config_get_value(repo, "core.alternateRefsPrefixes", &value)) {
+		if (!repo_config_get_string_tmp(repo, "core.alternateRefsPrefixes", &value)) {
 			strvec_push(&cmd->args, "--");
 			strvec_split(&cmd->args, value);
 		}
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index 68139a1b3e..422da6dde7 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -83,4 +83,13 @@ test_expect_success 'refs of a shallow alternate are ignored' '
 	test_cmp expect actual
 '
 
+test_expect_success 'alternateRefsCommand and alternateRefsPrefixes need a value' '
+	test_must_fail git -c core.alternateRefsCommand \
+		rev-list --alternate-refs 2>err &&
+	test_grep "missing value for .core.alternateRefsCommand." err &&
+	test_must_fail git -c core.alternateRefsPrefixes \
+		rev-list --alternate-refs 2>err &&
+	test_grep "missing value for .core.alternateRefsPrefixes." err
+'
+
 test_done
-- 
gitgitgadget

