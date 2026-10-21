Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595760;
	b=HhWHF6taksARJzoV+w5xCUEmWdcpuTQTkQkqaMjRGf/E0RXVAgrSUZuZGZJHbihU15/0
	 S1VAsdLnrr8p5Q2I7uV3u95V+xQhPN8w56xDWQ2y47NY1hzsNYBdf5tLoyN5d0T/Gdz0W
	 evdhk7bjZfNdmgJnY6F5Cec0F7G/vpOtD1T5KEndhJIvgHKoki/UoGXXh6GMbxKKYhEdg
	 RIrGqaHAiW+ghMjjzbmgm27ONnT//wY9Z9ttys05IB1iJK+zoREwAVckVJt9YmOUdgzud
	 vQOXhn8M58pKrRStzmaDoeejgo9W3MfImVYn75EADqDe59BT+UXSvTKEP/qKj8eenHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dfVVAdPVueUaBJbVuWb//3aMHuOj8UsdsGBTnRvns5g=;
	b=OSdGI6/bkFI+0iJoMH+Mal5nOJkqGE6Qe3TiSBz+vDXu6kn5qhbq/MYky35cEVSpg/8s
	 UQHccaZu9Ty9OGfxkep2boCAPuic5lZrQUm+bQiOLZz5ATgeks4CnLWWLBUrVx+CGvWFN
	 IZiT7clqfv7ivNd0X+1tAgMkRN3stdY1uF4PFMVi1TkyifveaplyQR5EDmGBQdDO7ysP1
	 nhsYKpa3wpNArnMydQvFKAxNhW1vl4gyG2gb6s8XPA4kBuzwf9BW+0f9s1hrfjBt6Yt+A
	 0r/dWp4/Fi4O30f/Wl0rnXk5PRKGtBLz4l+1GGnBYvhHseaQsUha5dBuRhR5cPMi/JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="bBxNM/di";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E8606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 15:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 792E8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bBxNM/di
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so7347585e9.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792595759; x=1793200559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfVVAdPVueUaBJbVuWb//3aMHuOj8UsdsGBTnRvns5g=;
        b=bBxNM/di6+qFMHzEfHhQzmJz6fGZLK3e5JomO+FrKgDZ3q+fLY0BVPL0yNTugh5bFU
         zEr4I98g8mlvxJQ7O23v4yhYjtpu4hzw5BxXurgrh+4OMnTvaEGEG97rSnZDZ+qbILVw
         W/JNVUrGDfuIU6C9xa2BKezRIi04f3KSSHrJh38dQvbCEZ5aUKSr0L1V7rnHtD81zg8+
         B+/xy4bPVw/c12r8LkTwq0ssraCTq3l/StS+WJMdvp/83FC/K3933wVYo7rrVHXcDQ6f
         4jrPSQOpecbxOjGFqvgHRVYw5tMNtpyHqZ4w426S1vTGBvk1L5MSQyiz1mSpex8V7R5k
         y9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595759; x=1793200559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfVVAdPVueUaBJbVuWb//3aMHuOj8UsdsGBTnRvns5g=;
        b=mtqVOjZXghuA5c8vDq8ZqMpkpEkn50Gj9oy1fJklYTHs5TYuMF0Gjvu6itjFegUnDW
         lVp+nCsJAFW1J/qRI5lOvtcehXzVUk77rwOmmaNO0mMDlQopjleLVJ5Qi1ZjE3xjWjdf
         fpdzcxBNfloKoC6jS6hoCUrkZmNoYCQAQGQIJg+zP//zW7q+sk2WdKza16k7PlTe5iCG
         vltUrCuIbW8VQfVvb59gsbLdB6+Q0ayHaT9POlcJb23tS+op68V4xh79A+4DlUxPAUaK
         0j9sZ9bqzg+1J6zuE0JKMKj0AGdKprHrQvTDQwCf+VtxFolbAwd16jfPDtSjABi3I+LJ
         hTKQ==
X-Gm-Message-State: AFq9FYJ8RMufYy+880GK1xUbDc3liGhBwSX+gruqnU2DXkOu2Yj9LdoR
	jEXsW2sXzlpf0W0fI1g0yHVlFKXtfjWq6+0zYxZ0V5UJ94w+jz6bmfjCoQxf6y/uWjg=
X-Gm-Gg: AYBFou2f5KJV11t39jeaCr28Z9iHtvWPSfoUxXZL0/NxwMsnY0MbkO8YOeCSm2tClDI
	CbqXoUNfecYntrTPFPYteU/PEBd7sTGGiZO2meJyDNrRZrYaVf2YoSnqrfs12DSmrSz0f/sdcpm
	qS1HN2XMMle0a4l/qulz55k9lKKm4UOU/hR2YXeg+mGzdsD07OI5w62ROWkkUXmPcU5XFOsF8qm
	qGzg0w0SAbm2xMB3+AHvdKBhZKt4ZYrP+IrgF8UyV7lCLGoCPfNzwJ149cJOucJBS+j4sCzI4z/
	T8RmUxAL1kOetSi6RhHAHnlfOqWKf6ww3ceSFYCTFV3AO5HlaM8Lue8rEkchqp2xOGBll2TZkRX
	1Jk8XtVOo+HGQOse4cDFoKUYWGOeFQL/rrfCmjv23sA7Es21JWOkpWsfsInJYdIDgTppc8V4KGP
	4E2F9STsZER9ZO8sA9MbqFXFBFRmynQlTAKNkIWPA0fHMN0OvYb0C877+Aljkch8Uo5zA0vajbl
	G9hIQm9/iSL5AdzvJCWrd7wcMvrhNf3Pa4u0jCdOT30cdDTb8Lp64K49FXlxjXZ0WxCdkcLiBlM
	ep476J9IadrN0v9MmQ==
X-Received: by 2002:a05:600c:4f53:b0:4a1:88de:9e8b with SMTP id 5b1f17b1804b1-4a1fdd20ceemr52479555e9.5.1792595758677;
        Wed, 21 Oct 2026 08:15:58 -0700 (PDT)
Received: from zito.localdomain ([102.88.166.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258358c1sm6273686f8f.43.2026.10.21.08.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:15:58 -0700 (PDT)
From: Azuama Odinaka Maximus <azuama69@gmail.com>
To: git@vger.kernel.org
Cc: Azuama Odinaka Maximus <azuama69@gmail.com>
Subject: [PATCH] rev-list: skip --grep argument in early scan
Date: Wed, 21 Oct 2026 16:12:53 +0100
Message-ID: <20261021151253.3689-1-azuama69@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Signed-off-by: Azuama Odinaka Maximus <azuama69@gmail.com>
---
 builtin/rev-list.c          | 2 ++
 t/t6022-rev-list-missing.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0faa833fac..453d82d25c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -771,6 +771,8 @@ int cmd_rev_list(int argc,
 			revs.exclude_promisor_objects = 1;
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(repo, arg);
+		} else if (!strcmp(arg, "--grep")) {
+			i++;
 		} else if (!strcmp(arg, "--missing-only")) {
 			arg_missing_only = 1;
 		} else if (!strcmp(arg, "-z")) {
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 1bd2c3bc4f..e87678e468 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -215,6 +215,12 @@ do
 	'
 done
 
+test_expect_success "--grep accepts a pattern beginning with --" '
+	git rev-list --grep=--missing-only --max-count=1 HEAD >expect &&
+	git rev-list --grep --missing-only --max-count=1 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success "--missing-only requires --missing=print or --missing=print-info" '
 	test_must_fail git rev-list --missing-only --objects HEAD 2>err &&
 	test_grep "requires --missing=print" err
-- 
2.53.0

