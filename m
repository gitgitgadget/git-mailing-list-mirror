Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028897;
	b=xh4xj6+lRNaXSn25W2s32ihTiAMbpdmsmFIKSyWoy9Q7DXdVeGLXH7sFZBdFo5qTnJcY
	 ltEz+DZuzkdJr/a9jj39CDyVlkTL0ZTMrK0wEk9QuIHPcG6fHLYIpMTBSGnBq9SYasxxM
	 xmU+epr7/DAgSEMHrwMZyphilcmypxLLpNbtfOTXATErQ2T4/2u76R7XYNDyWJRkQuipl
	 egwamHKg90pMg0RwE6DayKhbhSlGunhS6GiGGGRXy5ry0PG8yBoddxkn0gjqKqqgGRiLg
	 FN/76Dho4QPzEn2idXDrFtqF++V58osOmnhAIe6SJ1NUnyXU6N9hgbM45LbyIllKeIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qwp6PGSlhtBocTScbIJcs+9ZhJjGrMenbMoU4Cq/cK4=;
	b=5ENnVkA4aFuVZ8SBGBHiSmX/JrzTb56CrxEVtmJ+yZcndhuLFLUY25lzKfH3vXU0+kyG
	 15P7JaoxUlxX5y+tVP1OQJGY1H3sru5ZmkD/iVp4pa/ill5+X6cq55haS+45U41Nvb/vX
	 Gn77Gjh22aFaL0RMJm9kGVaiFEeu3bRYUubB+Gf3OZfEWOqG7NrPYosfAd9fV1AgbU7zB
	 Y+73tu5o4o+JEi5ztbJ2sRYnQsSXZok3T3CGquQFykvTVkHJvpuzhclRzGNPQafJVlucO
	 fzk5eApxeQ4Smthjj0rhri8Cnur2OEclh/KFavFlrHTvyBgbIB1eqZb6G0d6JHKdSCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="W/x+jrL+";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E060A2600
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 19:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 469E060A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W/x+jrL+
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-382ecd5cf2cso155108eec.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 11:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795028894; x=1795633694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qwp6PGSlhtBocTScbIJcs+9ZhJjGrMenbMoU4Cq/cK4=;
        b=W/x+jrL+kdOt9bSHYPhIyL68Nm12Hexg3ZvnApCwR6LyV1zO7izEv7sasLvNI1SOa8
         7rVTfpb7Pl5KV3aWFB9pA+OltEeQbXEYmKaEzvnD+cAPZ8RczJQO3PguZbPgvPK/z2iY
         T3XgUJWLlTwTgg2jAj0ss4CA1Zf/6mkBCdeJE2rTo07HGsfFN2rB0C69MgWNv+zFs3ag
         Loo+lUKD/8+EAiCIupCvHipY6gDapzsy1MSdXcSVKam5vI/lO1Uga7oWSt8PcCYrpYNa
         l5DafQTvqS4f/PZutwcqjT10QF5gMq1ZzPjBogw0ivPBfzJujyKhtMDSGjnqXkZmHTuJ
         6U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795028894; x=1795633694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qwp6PGSlhtBocTScbIJcs+9ZhJjGrMenbMoU4Cq/cK4=;
        b=yMTDWEHQxhSdgdmlYomJ1fCiUNNALrGG7d9TM0ExfpMnw9IPSMiDIt2r+T5fsDZ/0f
         rBq//KVpbXsOnIVeAcvVnvZZPoAuykcWW8uhwNUYGcGjaYs2ahgtpvgPxdilxn86jHm1
         XA04tO3MfMtprS/WFJbHb6M4NDs+wagP7nF03HVPIdMitQ0T/0S5RKyLE8gDr6c19JDM
         QRDLo9cXiVvcVL7FqlvJQoi8myf99pGRz4+MMTHbFnnVhXAC+c9rJw+H8R09oJH6r8ES
         CpjGrJ9byRcua9eYa++Xu0fFPdtaY78mRzhte8eXyAySe6gyBzcRCwz9Y6wyPVYOSj7I
         +reg==
X-Gm-Message-State: APuU4Z80YId4v39H82HxffEWdPLnO/gZ3xE+mw4wNVYtxrkReMhTWvMB
	BqPK3L7bFB5uzcJvtJrPjAVFON4s+3wcshgBwzF8/q1We5nFimf91m/Aa74QTA==
X-Gm-Gg: AZFdTZcx5zNPaDwxIYI6AAVHoGRui/zrZOrzXBxj7ZYyjTNIFA7M7MoQdvJ3GVAf6MB
	VTvrS1rtfwlkXcdn5vUDNFCgRFFIr/NIM4RoZrn/bU/He04zk+gvP1B/eYrDFfeCofUiF+c/Rq+
	Ty+JeKeIPaGUWOIdaIZ7Hixw3KkVwdwvc1JKdz/gzLpjxCQ4XhGHMkNv3gG3L0CI9qVdWvpXyx7
	Cy/grNWRHs6VWj4bj1YsH7jAwaHQGiiIYO2suCPmS7w+j2MEojg5EWxTc/x1mS2+akbah6gkhUd
	lD+cM3Uy6kDeuobXlFdbRyjARaA/XYph7N2vKw4TK80lo8zLfd02zKPSbRQ2Z7v/Tc2k4DyK0EO
	MekzdW4LYaICHuOhoJcWYeBbH8o+uIMa/jq08jY+j+n1UGjIKesjIjIQWHSdE3115LB17kDapXB
	hVc++ArQJpkkcLVeagAQnG2BT4Ff6WJ0benCVlE02nSGBFVbl2A/IzVsc5Niraif7f8v6J+uJF+
	X1myJIUbGCeI26R459MrQ0zRqokynmyRBrTS9rD10UTz4VjRfadFRKNrgR6v7chv2XqxmH7rE8A
	Ju5twY4tK2yZ7uWXGuF721V/iMa48XZgwUmkUwpQyroHvXMYGw==
X-Received: by 2002:a05:7300:b28:b0:369:f17d:efb with SMTP id 5a478bee46e88-383ee12cebdmr296626eec.10.1795028894160;
        Wed, 18 Nov 2026 11:08:14 -0800 (PST)
Received: from HP-V15.xu.edu.in ([125.22.10.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a680032dsm9065155eec.10.2026.11.18.11.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:08:13 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	mail@thomasbachem.com,
	ps@pks.im,
	ttaylorr@openai.com,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH v4 2/2] maintenance: trace lock acquisition failures
Date: Wed, 18 Nov 2026 19:07:35 +0000
Message-ID: <20261118190735.3928-3-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118190735.3928-1-pushkarkumarsingh1970@gmail.com>
References: <20261104173422.20725-1-pushkarkumarsingh1970@gmail.com>
 <20261118190735.3928-1-pushkarkumarsingh1970@gmail.com>
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

When automatic or scheduled maintenance fails to acquire the
maintenance lock, emit a Trace2 data event describing the reason
for the failure.

The event uses the "maintenance" category and "lock/skip" key,
with the OS error reported via strerror(err).

This makes it easier to identify cases where automatic or
scheduled maintenance is repeatedly skipped due to lock
acquisition failures.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 builtin/gc.c           |  4 ++++
 t/t7900-maintenance.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index d423b68cce..32d6f9c473 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1413,6 +1413,10 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 		 * another scheduled run is already running. Do not
 		 * report an error in either case.
 		 */
+		if (opts->auto_flag || opts->schedule)
+			trace2_data_string("maintenance", r, "lock/skip",
+					   strerror(err));
+
 		if (!opts->quiet) {
 			struct strbuf buf = STRBUF_INIT;
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4e519e4a5d..959c99a51f 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -423,6 +423,35 @@ test_expect_success 'scheduled maintenance skips with existing lock' '
 	test_path_is_file .git/objects/maintenance.lock
 '
 
+test_expect_success 'auto maintenance traces existing lock' '
+	test_when_finished "rm -f trace.txt .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git maintenance run --auto --quiet &&
+	test_trace2_data maintenance lock/skip "File exists" <trace.txt &&
+	test_path_is_file .git/objects/maintenance.lock
+'
+
+test_expect_success 'scheduled maintenance traces existing lock' '
+	test_when_finished "rm -f trace.txt err .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git maintenance run --schedule=hourly 2>err &&
+	test_must_be_empty err &&
+	test_trace2_data maintenance lock/skip "File exists" <trace.txt &&
+	test_path_is_file .git/objects/maintenance.lock
+'
+
+test_expect_success 'manual maintenance does not trace lock/skip' '
+	test_when_finished "rm -f trace.txt err .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		test_must_fail git maintenance run --quiet 2>err &&
+	test_must_be_empty err &&
+	! grep -e "\"category\":\"maintenance\",\"key\":\"lock/skip\"" trace.txt &&
+	test_path_is_file .git/objects/maintenance.lock
+'
+
 test_expect_success 'maintenance.loose-objects.auto' '
 	git repack -adk &&
 	GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
-- 
2.53.0

