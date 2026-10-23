Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762285;
	b=Pf2ehzTMa8noI+0TDnnA8QZL/gRYGW7tcakg6yN8lgO77LeoO/hfq1uJv/xMJgiuYqUv
	 N70eqJTE1p8xYntCIuXbwCMGxROllJDFN5IQ4gcwK9yGwitKO99fIQXl0bOnApxc5z/tt
	 kEpJkm/rVKaA9aspJXRk4BKYtCi8kB/vyeHFOwcoWm7RgKeaajw/ihi6GJsGNWOdZjtMR
	 ogYAVsnNlzu4WCSVfgf7mE0r0mS+1NTFEQWS6JdkjA4KNifLMuYg8UEraQTlAv62MXZT0
	 B1eBqsQdKn1uUdo2em5WaVqCm0L5QCcGyumq+8gM8FO/aS6r3vwzHHwf6sFgNxZltNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/09pzq4Ct0J0BOMCRMSzETuCFglb49sooU+AbicEvtg=;
	b=OpQiJ1PtqAJdTZUFe1/rxOZHLuHbHeHQ95xjPlmLNlw2yorpFYVZAgRA8RvbJgkgYmDu
	 Nc3ir9CtV1y2hAxNBA0GUfrpGAdeEqyaQPWYNiz5NPZPQSV8qoq+jiBm3yzVMU1Ycn3Tt
	 gcxfhzfiig93ob9uMEyxb13WzAyOoB2RB1Ghpt6KRB88gOmsOe05zwciE4siDbJlG8K4K
	 glBRFESmNiFIwsSUl2LkY/0H/TyICrK3UlJgUrovlcA55xEBXT+1R+ovBy03H/DIxAavf
	 0yPgOLNJBdTBGTM2c4f1kMMk0VLveFjDDNZ5aPSqmDEpmFhfzp4oU+tZdgPrV6mPU5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J9Fr2NOA;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF6606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1BF6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J9Fr2NOA
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9d1114320so6313075ad.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792762284; x=1793367084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/09pzq4Ct0J0BOMCRMSzETuCFglb49sooU+AbicEvtg=;
        b=J9Fr2NOAZKD5YvjWa9JSTv1QrqwrI1GqHUzVrHDvIb/SAMNMu8ye5Zvg2nPFW2Wwvm
         NJrHaHIafhCkSngE+qmhL/VHpK38+jxzZyGRbfaplcT6xxG70kfc6JtHnrokcF1Dpj5J
         LmaSxd9Sb/pRv1xREm3Q6icSMH7GainjZExr/OoIKTmRzhSfEJHjtgXkl5TSUFCJE9Sj
         VlHvSrOH12mbWnjV3zs/ims+BUb6Zae5MIbUHG/647Shl29Bklm+CPVRw0+njJDR7NjG
         ltDre8lrQJ8ZT9Mz2IseC6qvY6hYJuSGzUHi8c0DjSr16NConyEiwPzcM6hwdg65Slwh
         gaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762284; x=1793367084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/09pzq4Ct0J0BOMCRMSzETuCFglb49sooU+AbicEvtg=;
        b=QvkODzwUI5QSFlO2+udL8vISCBmzccb0tUcT1cdSVsOkV078F5LMP0Ce2iRZn3qwE+
         ujr3s49cB/s1h+7M5K7E217b1tb7ubt3cSLZq55jQqrMI/2eowKhDwQfCJJiu6bMMbi8
         v5vrh5yMCn9qRYBN5jpSCMJIS+zR3APIXxX3dzc5At7x72VsiNfQaN3u23qoc0q/SPwP
         OT3Ecx0NJUHnjTB5jLLyBdAjemlbEELIYcolzUyLE+NfqA08X09jwfhdin3jQh7ferSV
         v96rg4iEKLWUkTHYY84R65M7o0s2lGIOz424DnUGr8qlFW1QmyMt07bnNz2zqKs5Qc0J
         ypVg==
X-Gm-Message-State: AFq9FYJ8jNTjJL/kTeRwL129KzI8gY5NeAENm2ifB87pCRZdQu2uluxj
	R7JJ2U0PRPJuJBmTVLYQPGlOMXmsS8O3hkYjPULIhSnaRAJWPH6/gXBa70z0w58l
X-Gm-Gg: AYBFou1rLlQOKLAbeTF8Q14sOUvW6gBNWUnYfCKRDFH5tsPmUGkUyBR6BXfN3AgaDwG
	SpSeXcvII10zifjssXhAOQ64qzPJoMbakUXDd/pRpkg6TTxTU8sMg/lUOJQH6+T+nmltiXR+a8f
	jXWq0rBpHcs4hzdx9qYDLo7TxL4zn2WwV1WOiq25LbU2pAejjJ90pKc+F7IKo5ghE2gHbA1yXKS
	UpGOCB2SalmCP/Tez8YZph1xrOtDwyGRcsGwkYAHVvgOaeGyXaPxCof+kGTSe3y/O1YPw4U2V1d
	CqwbrJcSoGD6TtztVINK3X8YyU48D/zgDycpabzifDuDdJ8RG5dmiJ/TtnBXSUw0rGPLX4RAOEc
	Va7/RKHLqZVYvl4xZmscPGivTTA27NXpxeSSQV79Ew8Mv/0kblNyuX2vON+NbiG9fZgI7Fsl1mX
	hRanIIV86fFvVr451ygHQGCRSm0XYOG7JVDE04eofdvDiviNJmSJQE3ZKOFHwrFoVJkpsJGq5X6
	hImyJ2tGt1i8Jckiefu+zryXRh/CgsGfjRxa+GWQkhe40wbcARpkbvu6JbnbK/qcL8OONezZ4IO
	622Mw3T21Z9aP4OB+qFq7Azn
X-Received: by 2002:a17:903:1b48:b0:2e3:598:75b8 with SMTP id d9443c01a7336-2ea7cfb86e7mr20340145ad.27.1792762284027;
        Fri, 23 Oct 2026 06:31:24 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK ([223.190.84.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea94677805sm385635ad.5.2026.10.23.06.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:31:23 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH] object-name: use Q_() for the reflog entry count
Date: Fri, 23 Oct 2026 13:31:18 +0000
Message-ID: <20261023133118.456-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.237.g90eb39633
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
 object-name.c         |  4 +++-
 t/t1400-update-ref.sh | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

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
-- 
2.43.0

