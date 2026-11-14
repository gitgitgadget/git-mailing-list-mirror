Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681453;
	b=knitCNkWQgZhGcM1UZHXvMjF5Yvij3t5QQBpVt4llG1Zsc1GLSIa18HzCLbPIVhKvk6Q
	 Pbg6XkhNjcORUTvpyBshTeAojBRA4QMjxZzTWhv0dfzuWfcD4FzIozNzHh4eOLekrKpX1
	 Xb5iPZPFNGoLGBWVcdAHDRPMFD4HEA/o+r2TbBEDeTuxRnOen8jdx3h1au+of1mdeOGpj
	 unxa909n6a54T8n3Ixd1eUrq+H4CFgJ6v1BYy+PuOzXZHshFAavP84ydfNJysjB7wBot0
	 ROpBpeGrDcB0sx4VG0rquu9/o/IFkwQQw1t1ir2c56Z32Qp9DsuDvASnleXuWiJ6aEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kOcFTvs0kC897QODTb0u+0oHopX3rpmpw69D7rp2A4o=;
	b=SfZ11Iv8GTwlAyiPREya/WdYyfgivRrQjpzYOaNVsJ0lVrn5OZdS9SsOn6X6cm38Cq+m
	 lvBuEbQipGkumgyyWIfTIWbINnh/XtkxLGW6tMWq/S3+Gode6oLs9O9gNCJxOgIMxLcVV
	 MjS8jZ1EuEvkwHKpHDwh0RFyjJpeuxce9YTY7RT8PZiKstyVl1KxFix0ZuSuZ2IUp/wBO
	 yS8nKuUQI4FZsQU2C3B23BdwqwWrfUWjudx2zedHf1y2TevIcWvypz6xw+8m3X08NEhYd
	 oHPeqR78qY7lRS6ffKRZNGpZb/f3dc5CTbN3230BBfAafTR3AHnGHUHjW6ADs+Lo5gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JpFPFqE7;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00D606A32D
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 18:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D00D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JpFPFqE7
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2661714eec.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 10:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794681452; x=1795286252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kOcFTvs0kC897QODTb0u+0oHopX3rpmpw69D7rp2A4o=;
        b=JpFPFqE7wRe8wap67k25xiPIqghucWvVh2m51iazZNi3KMY+nRpRN2qFvxnQdK31Ol
         IALfx+YZvnQZE+AvdRhpEiHyuiejIWuRVPRTCi1HiOamf0RWOZPVpPAXY4WGlZkp8U1i
         fx5Nd/I38Oj08/7pL2vysj8/FhROFYxbIphYLI9uMb/iODVa9Mx0rowMy4fYEigMLb3+
         nM3T+//QIoVwnPVODDkp0L7Q8sVSjSpKofdNhVL6FErSWf49xTHMcdrrx2UNHrz75Z0G
         sUtqh9vbbHQwrTFzebBofH/G3OLhqed2ImJd1R8u3hKnA8J551W8vyTpdM+RCi3Rlult
         Vnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794681452; x=1795286252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kOcFTvs0kC897QODTb0u+0oHopX3rpmpw69D7rp2A4o=;
        b=J5feEQjZupJtXJXow0BLfBZAcDlnHDYPV+WStKfjeU9U+svzOpSBeQYK/YXmNr2bcj
         nuodc3B6Dcw/tcJmG+znR1+SIRejHDYk5TydDKqO9pdYVJ9TM1rNc9hYQ4TOzhRkF/Ke
         bGYyCAljaOrd9fxOqA+P1SkSfP+442aUL3Ut4O+Sqf/LmG2pDPBh5S7MNBlPXpKTV5SK
         MckZRknZOvysWMW7TM1RhKal65j5Of6IM8jU2foIvawMVSb9jHPAM8od3/WJTo/1IenK
         soFkwL7w/CmyVOkU+d8NkGMdTp+sGfsRkWbZy6+QZDNyZ2yC+C2Y8lcqDstBq9a1Y4Jj
         rRIg==
X-Gm-Message-State: APuU4Z8s05eVvO5no7fXVZ/ZjEDniNSIzKBiMF3qzO951wOqNvE8LEAN
	eKjcfarmIou1anVCbS8SpjFjk/2EW2CehQ611nmYAi7kRYInUCXt2FrI9CeIhaLY
X-Gm-Gg: AYBFou0N/Oz5BTlz3SQkErLmrNh6Ymb5QnDrqZucG3nRDSkCg6sRBoLRxjQnBkE+y+u
	OdN1g+wUofOeEtKjkACkFNlIMAQ5VNr3FUWeUkdtElOJMDuA0lYjMibRSoWZxj8cRMTk1ld2kpi
	IqD8JSGMSI8oHBoEHX3f4gQciwWpCfjPZzmcW0sfOi3RwY/poKrHsLZ3MJuNWUBFBLWl+ofLjpg
	LN7VsazQTRyf3u4xNtmpyYONlcGkQ4PlMVQrfyYN0mu9CTTQERhnVt/1hd1RWUggwgk+DmtVMyy
	Nh70sZw0MtwuiCQirU5OOgBXQcDdX5cJ69hbHAZkUg0J77o+9sHLuoS5s7Hj3gqNt1nWE0pvIEw
	XUCwVTEoFFgE6t6atitYSHogIVv8VwWamBJLbKOEDqRGftzG3SW3GfyOFlFhbncC27WTs8TscAF
	KVcYl/1GjcDTNr2IAih0gQHS6clPUk8+Ce3LgqXyAyJgrSVEmxcYH/Rjxglrrs7Yo/aDdbAQyvo
	2B2iTyWFDNqlMBmWhTJ1QIaR3XvkOQXiNksxX2r3p4q7PpMXzGwhLovZYxx2MZP8HpZOtF88vbn
	L/7qzY+ag388+gvzr7rLt581gQ2bSuA=
X-Received: by 2002:a05:7300:d584:b0:378:a35b:9e1c with SMTP id 5a478bee46e88-379684afa4cmr5475730eec.37.1794681452137;
        Sat, 14 Nov 2026 10:37:32 -0800 (PST)
Received: from aeron-host ([2401:4900:883d:dce5:aeb5:d73b:40b4:bbdc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f02ff0sm17802719eec.16.2026.11.14.10.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:37:31 -0800 (PST)
From: Abhishek Agarwal <agab0323@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [PATCH v2] for-each-ref: avoid segfault on --no-format
Date: Sun, 15 Nov 2026 00:07:18 +0530
Message-ID: <20261114183718.57552-1-agab0323@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113161413.15688-1-agab0323@gmail.com>
References: <20261113161413.15688-1-agab0323@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "--format" option is declared with OPT_STRING(), so the
parse-options machinery also accepts "--no-format" and sets the
format string to NULL. The default format is assigned before the
command line is parsed, so nothing puts it back, and the NULL is
dereferenced in verify_ref_format():

    $ git for-each-ref --no-format
    Segmentation fault

"git refs list" shares the code and crashes the same way. The
problem dates back to c3428da87f (Make builtin-for-each-ref.c use
parse-opts., 2007-10-13).

"git branch" and "git tag" have the same option and fall back to
their default format when it is NULL. Do the same here, and assign
the default after parsing the command line when no format is left.
"--no-format" then cancels an earlier "--format" and gives the
default output.

Marking the option with PARSE_OPT_NONEG would also stop the crash,
but then "--no-format" would work for "git branch" and "git tag"
and be an error here.

Signed-off-by: Abhishek Agarwal <agab0323@gmail.com>
---

Notes:
    Changes since v1:
    - Use "Abhishek Agarwal" in the author and Signed-off-by lines
      instead of "aeron-gh".
    - No code change.

 builtin/for-each-ref.c  | 4 ++--
 t/for-each-ref-tests.sh | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 4a2fc421db..4390f3f5e9 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -52,14 +52,14 @@ int for_each_ref_core(int argc, const char **argv, const char *prefix, struct re
 		OPT_END(),
 	};
 
-	format.format = "%(objectname) %(objecttype)\t%(refname)";
-
 	repo_config(repo, git_default_config, NULL);
 
 	/* Set default (refname) sorting */
 	string_list_append(&sorting_options, "refname");
 
 	parse_options(argc, argv, prefix, opts, usage, 0);
+	if (!format.format)
+		format.format = "%(objectname) %(objecttype)\t%(refname)";
 	if (format.array_opts.max_count < 0) {
 		error("invalid --count argument: `%d'", format.array_opts.max_count);
 		usage_with_options(usage, opts);
diff --git a/t/for-each-ref-tests.sh b/t/for-each-ref-tests.sh
index 4991a82b91..3e0108a7db 100644
--- a/t/for-each-ref-tests.sh
+++ b/t/for-each-ref-tests.sh
@@ -285,6 +285,12 @@ test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail ${git_for_each_ref} --format="%(INVALID)" refs/heads
 '
 
+test_expect_success '--no-format restores the default format' '
+	${git_for_each_ref} refs/heads >expect &&
+	${git_for_each_ref} --format="%(refname)" --no-format refs/heads >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 	${git_for_each_ref} --format="%(authordate)" refs/heads &&
 	${git_for_each_ref} --format="%(authordate:default) %(authordate)" refs/heads &&
-- 
2.56.0

