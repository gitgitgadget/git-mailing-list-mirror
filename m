Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792908749;
	b=cpfhsyHOo9UjBNUXpJyxM1NoXlKXUrYqQkXrgPVFJ8z+RP/wYS/85GHzAYAb9rP7QtF9
	 HUw2LTAgjnXWu7y+e4HZnrZRL5SzQNzN8N46/G0qpaZ3S+u0zJ6cTSpDrF47Npc2wih+t
	 ayOPzTsGFiYpL3F8foLksVJ8ByMXHbxGHmdOsfA2MMYtXMhwKVAgKH+nAlLCy7bDrCSGs
	 P55NGotvr6Y0s8Y3G495ggfxzEEv6tKGpKbD85GIbc/KLw7zj2uKkQgsIz7WRQRoZ3Qn5
	 pvv3IvHW6MI4mrZ1OP2bQ0O5oXDKaDLB+EBDDdXtG6fCrer321b/+PEIqxVgic7E8Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792908749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZQASeWHgipJa1xD+ZjKpXFrlPgL5UD8lCBQa/AHS/D8=;
	b=jpe7X71gP6mITQO6wrGT23wBx6+cUZQnp+Rl8EaFRDP43e9o7xlblnCRrNyFy5IANz1M
	 xbhBOSkgzPJfmbTN8pt/jJGCuUGdw1gjnFvHq8/TIqtJqPkY8mKagUZUg1dbM2gw8v106
	 7+Jd7M+kwY5CEuAl3LtG1kG2uiacvydM59IuXWfiX4ULhRC2eESYVTknHKTkJBCJdugnt
	 Emc7Q0ENK42qBB4zYz/8md6tKEXNputJMQ9O+Y0m6xt0QcDeJB5utZYFu/1WTxJtHj2R8
	 2py2OXA0fwWRcMeizErF04C2AHPbCqGtat5shZfhihFfUDR/v1G/eGgEDnm3Xt97m+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r2P24hbD;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F0606A31B
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 06:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E6F0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r2P24hbD
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35d0be18c71so3573616eec.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 23:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792908748; x=1793513548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZQASeWHgipJa1xD+ZjKpXFrlPgL5UD8lCBQa/AHS/D8=;
        b=r2P24hbD0tEO90hLFv4Xy9awkPY67RuH7YRVn7bEWBOCvS52+rPqEyf/YUZnbIsi/0
         a7xvp6n5SHGvcs+6Fsyw4TvAxA+AWym59FxcsA2rrS5EF/AQi7j5CYNQf+DPGBqWkytF
         RYfF3HoiwruYLqD6gVUNyX7ImZfevkD3k+7e6twrccfx074K6ENAvxCakph73JMtnfwU
         1tXEMEGj0dy4wUT7TsNqFY/7Gf6c4MydjKjp9SOiZM9I13tmwRiK2fbJTQvesxPmMWWZ
         stp0tEgn1W/jvqHmESgXPOAwWCgR77G0Novd8KQHYxXzx647G5g9HiooxgUEZSLXE/nF
         8QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792908748; x=1793513548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZQASeWHgipJa1xD+ZjKpXFrlPgL5UD8lCBQa/AHS/D8=;
        b=SbhV2u2n6Rz5JdfL30gSW76QSjqRTq7ZlpkSaiyigg++q+QWRUJh+MpE3DdUA8Pjsw
         FE7uedCx4K4mxuFCm7qRxoJIsfeeOM4pXIs2/zCY2KlfWxAN0d0kDNNDLlqysasSeUm9
         6urcsTwklX0JQxJzN+Z7A/+G3nv3jbh+uwLuB6+2gC6RsbDbLVqsVShDqsd9liR6dIP4
         EFiHEPJuHNIyJePRlG6pbKRU2vMng+KU8/mrOV8hzw9X2xZI/KpeqQjn4EKHQQjnVhld
         kWmTrfSl2r6TEa30l+RQx048AWyHdCyDvmc2AK8x4zcSJ1Ha+y5i0LGbHYEIX9QktIDj
         FMyg==
X-Gm-Message-State: AFq9FYIEf79vX6Q1X67EcPf1JC5EHcZwBWlKz0hqUphLZaPQxwGHGufA
	fbVju+4Ti+CiyQoKxNW1ZHE9CkMjZicGG6B7Vt/2bjcYBF6a7bgjIG4zedXpr+qTHGo=
X-Gm-Gg: AYBFou0CQruJXYhgrSwV8Ewyj03dFg1TaA8KcfBbN702lETmN4JpVIgPkEpCNsSocMz
	xZRRoRxSowO4Lkd0I1otmn1QtlmCUhOnY6hTslJNO978VvY208RAPhlRgUTgmMJMgV0iFstW+LN
	IyFd1oHuYKuzyzLcdQNOkyW3b91ek346sKEz9T63y7qGLvLmXyeFR9AD1lZerZsyDx9a3v2xAe+
	lcmYIOBG9PazdeEf1eKgdpfTVsrVP2uwMyk/GX6RCezDRPC4AnsK2txIqhfPe2Zo23uGUVcuq8g
	8GMphr8jSSvwGGx5tb662Xe5v4MXqm7FvAC5k/tlJGWhkRl3HRSx8Soq8yyv4eNVeJNsRGiOQ5F
	jH+2kjUhiBFVnaugC1Vrt8P/Bf2BFxuMnYGqaDhlBgcExbOJZtWvY3meXwG5J+TcErdvAw08CGX
	AoqBaqqUFOL7SQVaLhhmFD2u9oMuRwAx2TQ7SFuq1uvClM+yTjdP7Z65dn0PJK8xQCUu0J2+AHS
	rCwLfuB6h9bThf4AZLxdyEyzQ/X559N+DvRaF43igCeQ6q61ULFQ29Ar1qZn571l5FVbefcMOfM
	tZpUE9VZPPW2NoTEIanx3fUZfTAjqUJ5rK3lS4Vp7g==
X-Received: by 2002:a05:693c:880a:b0:364:377c:cabe with SMTP id 5a478bee46e88-369e8502311mr4215834eec.24.1792908747542;
        Sat, 24 Oct 2026 23:12:27 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK.iiitd.edu.in ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8afd64fsm15632196eec.0.2026.10.24.23.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 23:12:26 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [GSoC PATCH v2] object-name: use Q_() for the reflog entry count
Date: Sun, 25 Oct 2026 06:12:22 +0000
Message-ID: <20261025061222.382-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.240.gf97865f162
In-Reply-To: <20261023133118.456-1-aniketgupta3001@gmail.com>
References: <20261023133118.456-1-aniketgupta3001@gmail.com>
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

When reflog is asked for an entry that it doesnt have, for eg with
"HEAD@{5}" get_oid_basic() reports how many entries the log has. The
message is not marked for plural forms and a log with one entry says
that "only has 1 entries"

Use Q_() so that the singular is used for one entry so that
translations for languages with other plural forms also can have the
right form for each count.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
Resend of v2, now sent as a reply to v1. No other changes.

Changes since v1: t1506 was also looking for "entries" and thus
failed with a one-entry reflog. Now it matches "entr" just like Junio
suggested

v1: https://lore.kernel.org/git/20261023133118.456-1-aniketgupta3001@gmail.com/

 object-name.c                  |  4 +++-
 t/t1400-update-ref.sh          | 14 ++++++++++++++
 t/t1506-rev-parse-diagnosis.sh |  4 ++--
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/object-name.c b/object-name.c
index 654668576..eeaac2ddc 100644
--- a/object-name.c
+++ b/object-name.c
@@ -810,7 +810,9 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 				if (flags & GET_OID_QUIETLY) {
 					exit(128);
 				}
-				die(_("log for '%.*s' only has %d entries"),
+				die(Q_("log for '%.*s' only has %d entry",
+				       "log for '%.*s' only has %d entries",
+				       co_cnt),
 				    len, str, co_cnt);
 			}
 			if (flags & GET_OID_GENTLY) {
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 1a164c96f..1d1b46379 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -458,6 +458,20 @@ test_expect_success 'query reflog with gap' '
 	test_grep -F "warning: log for ref $m has gap after $gd" stderr
 '
 
+test_expect_success 'reflog entry out of range reports how many there are' '
+	test_when_finished "git update-ref -d $m" &&
+
+	GIT_COMMITTER_DATE="1117150320 -0500" git update-ref $m $A &&
+	test_must_fail git rev-parse --verify "main@{5}" 2>actual &&
+	echo "fatal: log for ${SQ}main${SQ} only has 1 entry" >expect &&
+	test_cmp expect actual &&
+
+	GIT_COMMITTER_DATE="1117150380 -0500" git update-ref $m $B &&
+	test_must_fail git rev-parse --verify "main@{5}" 2>actual &&
+	echo "fatal: log for ${SQ}main${SQ} only has 2 entries" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'creating initial files' '
 	test_when_finished rm -f M &&
 	echo TEST >F &&
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 722884e65..9a4b93b79 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -142,10 +142,10 @@ test_expect_success 'incorrect file in :path and :N:path' '
 test_expect_success 'invalid @{n} reference' '
 	test_must_fail git rev-parse main@{99999} >output 2>error &&
 	test_must_be_empty output &&
-	test_grep "log for [^ ]* only has [0-9][0-9]* entries" error  &&
+	test_grep "log for [^ ]* only has [0-9][0-9]* entr" error &&
 	test_must_fail git rev-parse --verify main@{99999} >output 2>error &&
 	test_must_be_empty output &&
-	test_grep "log for [^ ]* only has [0-9][0-9]* entries" error
+	test_grep "log for [^ ]* only has [0-9][0-9]* entr" error
 '
 
 test_expect_success 'relative path not found' '
-- 
2.43.0

