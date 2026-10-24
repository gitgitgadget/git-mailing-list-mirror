Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792855777;
	b=Trjbe/k1jws3/Cr3N6ymJ15rQn/LAmNgoUPucc08fhf955bdGccj+EPGGFgxgrQhLwG7
	 ieWWUGKhSc3gfCWp5C8h37r6W7N8EmDvketOZh+w53ZNCEOpzKwV6+j5TmGd1qqTIjTrc
	 XYfSWsxyeZ9Syzvu3k84KqUio7r3BRgS9FyhwU84R81SwP0qExOts+6SbJ/uVOrbrNAyw
	 lBFvyJd0W/qmLpoWvE20TrbRpyqIqoKprj8lIzF+2LLgYaG9+U+X+AvqvzXYyBO/3CbiJ
	 D7iX/Q8YYUEsaVgLakvCK3FqLLMitIo6Uv8I7wAzB1Roj6+H9mlDlCwH3Kz3Tru4diw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792855777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Tv0tLtZwBx/F/FOzluVHQjxtMyCp7JWNefVrIczjlf8=;
	b=bitYISV0N5z5BGRWlelcLInICp4KoS6vaIDu6hBZ3/dE8C1sAJXbWkW5Q1z8wgIsQeiz
	 rdhJnX5qaFi0ewFkim0fkbjy0jHsRodMscdgTzscWqD3tQboWV1hKmPa0F6gsaYuig4RO
	 j9NG/13qLI71leWcJGBXHODqrF2SB8lXJnvtDePSOIF6H1VlFNk55AmViT7iGegQWUSSe
	 8lkfGjqaqYVxADYznZABzSC4Y6sD3s9eGW5oXzLavqBdIW9VIvOhf/QO2qsDx02DneISc
	 LkkwgjIWOpteTZaI7UqGPoLDoHbFDP8aps7N8NkrP/kJiyjNL2+dLQ5WwUwGH/WiAIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=phEMlcnI;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972D606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2972D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=phEMlcnI
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36661f953e4so3184054eec.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792855776; x=1793460576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tv0tLtZwBx/F/FOzluVHQjxtMyCp7JWNefVrIczjlf8=;
        b=phEMlcnIYqppR29adPswP9q467ggzRtPAIPgtx4YKFKH4CKirU65d2KxVqti6b2O8K
         YEqnCPqsiaW3NwuSA9oiF5vcDJkT+HEPfrk1AyneN1NXClFHr1WNGKSJTQwr7w/v1SZe
         T9fPDwL4zYYrhogg50S1TaxOTxH6SwyiYfHqhog/bzIqJmUKyF5A6NlSiWodlLCMLc2k
         DwnvbGvDERvIwCFhtCs+E8C+ehzcibv6pSvzrFGVmU2u1bmqmxgPsOaI7mEBaVHot9Sn
         1R9Hh27lK1JtGtrFplDeUkFRC4MwQ0AtCBQ1Labu6mHjQqduWbcbVzcfxkWB6lqAMBs+
         8/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792855776; x=1793460576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tv0tLtZwBx/F/FOzluVHQjxtMyCp7JWNefVrIczjlf8=;
        b=mu1rc00DzO9xfUrL1MDx2dKe7Di7MF7NktgSC9kmE1WRVmU4RsNLKIroGhGslJWrhY
         +TV6qRjl9K/YYKvQiR8DGp1BRWhOJU5kT2LnbaJzabnziqmct75MgMZ1oJ1V8R9TITDt
         A2KWIeGPnZzfixQBf0WZRG9som7fbzdK9AJ6SgsJjCQFAu5Iqo0KVuQClzu7q7S5mapb
         15RjdosSGTJqFixUWitkF+Sc6wGaGHJlf6bppATfKScfbsAbxw7jkE6k2mB43B8bOafo
         mDuIJKaUJn1MGrLzMDTU7Q05/6sonVH4HzraO1UbbirNDSexIvBSZaq1d6LR8x1CqpQW
         z1TA==
X-Gm-Message-State: AFq9FYI5yc8Dlq6ZOFh7YMVwJ4p7IqzglvmDyu5WK/gbBI4qLNRiRioC
	RyFeHjoSA7x90bJjcJ1DgSW9elsjHpUl3bwkm4Wmoy4mKwwXXUlG3yLbVjh40u6j
X-Gm-Gg: AYBFou1NI9x7SEgQAz7SjjHfBBoYgQpENSlDEwc2Wu2ZOZ0cZI9c2IaMkyFPjDDEf0d
	lsDmGDrkf5ehUrobHcd8Pae4JmjUGfoFBhFPXIosQ5KrnGFkAzrcB5HKixxcPjPtC8Yvq0EAvVG
	Z3kOgiQiNVeCUXWNjgKIbHb8xV2ZM8d/CKvPxF5TSLn/gQLESmoHp4llL6mQOjqZZjrnUBVQ7ki
	VTHubHZkBtLCtWLYf+lLVb6sE+f5SKBOzC5ZKWOqpyraQLvw30prIaghTHy84jdkB8eIyeKpm/Z
	ItaE59U5AepLn0hUp3TTnFYbLfhQ9Vok+s7ajgZ3LJgNE7fz3TZB/k4sCShXVXm/VqKKl4M6k5Z
	zHL1aaGFCkRMaaUbJz54TIkwz3Wta4OAlT7QK95DM0Tx+4hGXQRkfdvUpE1ga0en3twwXnTh830
	Q8iO5iECwsmd2UZhTOquVWfbChizGY5CY//rBL/4hRIBDz0M+BMfe9glGd5K7QYY93PPsHBXWqm
	ayGfGl0byqt5Ro4sSUrkuDGwLdyKwQO4CMiWPWYgAsbJG7XYwaswm4+D69pZCaNtYJTcbMV/tS/
	2acMcuhWVSeEqqKh/JvOcoJ8tQ4K4nEivCobDLECemp9oqYucsH/ciwfH1GZQIM=
X-Received: by 2002:a05:7300:c383:b0:351:68e8:4646 with SMTP id 5a478bee46e88-369e861e0d6mr3397526eec.37.1792855775978;
        Sat, 24 Oct 2026 08:29:35 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK.iiitd.edu.in ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec865esm7199119eec.26.2026.10.24.08.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:29:35 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v2] object-name: use Q_() for the reflog entry count
Date: Sat, 24 Oct 2026 15:29:31 +0000
Message-ID: <20261024152931.440-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.237.g6c8510d9c
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

