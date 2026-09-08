Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA804A2A79
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863230; cv=none; b=SiNhackmy2afZXFxUhd0mogExZvTI0F7V+ksa45bHqphVfy11D2hIipQZ7aXXRgoQnJNra/GriwcIQJaDIbpO0ZbVY3lcQaeu2e79fUZ0WSK4/vWGCyr46p3BnPrHfWDdou7fL/rBs9B+tdebHhWWRLN/NQ1NsRYqvxfADlEUCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863230; c=relaxed/simple;
	bh=oPFNVlgdGnWSDAEAptIjUeM9FGZGxsQo45wIQH3dJD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uc7Gixcsu2Ilq5WSakQ4AcDgcwY0fobH6ZaHYv9hXEjZAPbbFDg6n+QJYmRBHkS+bxUxy7zWsY6KPTqvoVBhRgpn9RwstQLXt8JRco90yX2GZ3nJQNQkqudgYyZddsgRqdQRSk1E1LzzTQh+CyIGHzgQT54ZQuVF/dVsiL1L8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4j+6Xjl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4j+6Xjl"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so5089464f8f.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 03:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788863227; x=1789468027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9NI5tJRoYGApzMsOQjTaRdChS1ePX37pXO6xdepyNE=;
        b=I4j+6XjlsoYYkuK9EwypFwzb4OIiFqGnYrUZ5h2RrUwDbSTPK3drftxqRFIUxt4Xu+
         LuMBbgvjuNgZOff3eqKBUseVpa6y0/MPiNVqNLA5VCnD5+Kq8WoL7+al/RAZtVGx5eDz
         dCzPiEmVeAlj5w+RrZjQYzhbdaCw4EMx7q0Zzy1A0cmu0gaFqIUFDOPOIJk0jyTVSXtn
         0sHeW+ytJLiYcQwf4chM7LlZYzAlIhcAsYqECPsKVzMg6aJt1XiVxw8Rpb3ULZ0SwzIn
         icWHH/rCiuV7w3Nn6zIG5uyEmzhqxXKxHhNp7t4dceCW9Kym41JYDgfUPlMGAderYgC7
         ve2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788863227; x=1789468027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9NI5tJRoYGApzMsOQjTaRdChS1ePX37pXO6xdepyNE=;
        b=O02gNJX741gRH7peSyxqXPRD2qiMhVIesXYSIwKK4frZlyBWpJ9feMsTkSop6b/vb9
         BGUo6YUed9iRqdniGpVTe/+IegEdAm1tbCEHikcQAuXR2a30II/nxi1M9EKT1OHQZPqk
         1VNYd44rI5Q+wMJ+1/VbMFDavzQsgaXTJlkP7dyXodl7c0dzImHmdJMs5gLYZZfB+RwK
         62YGZKIx0b5VbFfzm8yuL9E5JRCr/NVUkFMKrKr58FSsUYwntSowBgPQ97inF/Z4YDF9
         QwOsognO5/hzzu48d6YYG/zkZ+MUvcePVBZQlgH2O8OPiNYvI4KoigqNFVr5hQBdXOJ9
         QhhQ==
X-Gm-Message-State: AFuF++mbRL/62zqaQ1YA/dTJgt661tYQEwwjd7IUhq84JwV3BlsSGkxt
	Mon05eY2VIBISkBNuzVx8V3Z6nnraa9oLpbbf4yLYazJqiO73ry6d5rm
X-Gm-Gg: AYBFou2+Tl3O5FmN1cp7a4gqWY/c8gKRZXOfGf0ZDQW2FGMH2YfRkOglCcLHVQpQL07
	0NPi44wcOpOdYD2f8f7fIdSazAoQVBa2CrGrMzQmjtL8QcD0BWZtkgUhB+MKeCgn3+c8J8ekfXz
	3CRAabfGDCCm6Q4hfWJk1HYki89MzQN1Tj1tQKcSpTCvC6K5H2uYsRtXh9MwmYk3OQ2nyeaFJrs
	jMM532fDzTX6l+GsdgigcEVYwuOMHk+siOLBG0OVpsbaAkZMgstBxhgHXiC6ED37Iq2FjiioasI
	hLNGoy6qrS54VOcJMadwGJtYP1Ah7arOESWH2XT9IW7X6J2gpddFqrIy7jxf1Uw9LuRWDeU9lmL
	H7CdPKMMNYHq14R5CFj2Rm45LHkLLOIWfP/5znZ1fXaYPR4os4nhkgmmSqUeOTBhrRxjcMS4rJ+
	0m6qJngDhRsgVOkFZH+gPP43+lx314qF/UpQ47960f0q0KP3mF8jpaFSOukLxiNI98kzk5FfjZ7
	re5tifAA80NAJ2Ph07RLwcg4zM=
X-Received: by 2002:adf:e181:0:b0:485:a0be:7841 with SMTP id ffacd0b85a97d-485a0be7895mr9974045f8f.14.1788863226742;
        Tue, 08 Sep 2026 03:27:06 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ed36:96cf:ac4a:2747])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885be1c1sm34446572f8f.32.2026.09.08.03.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:27:06 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 08 Sep 2026 12:27:02 +0200
Subject: [PATCH v8 2/4] receive-pack: drop static variables to track report
 status version
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-758-introduce-hook-v8-2-be88a671ae1f@gmail.com>
References: <20260908-758-introduce-hook-v8-0-be88a671ae1f@gmail.com>
In-Reply-To: <20260908-758-introduce-hook-v8-0-be88a671ae1f@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3509; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=oPFNVlgdGnWSDAEAptIjUeM9FGZGxsQo45wIQH3dJD4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqf4vcnRjvVvNH3jii2ndmG3JsGuT8CCIhpn
 Jfzkhf4EUEG/YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqn+L3AAoJED7VnySO
 Rox/GTAMAKLN39c50+PUPzJHNymyzdRsQ6hlYHw8BNtmsi+sVG56qHUjmqP47i9aaW//aat6/XY
 0IG/+v9NWkR8ig0WDTetqkU07IKE1gSErvy1wLrMDmWwRArFFPH5yPRdmDIIVAC5NWLCvbCtk4m
 mTZ2qkgOhgbGCHsXAKH+vvm+L9WPBcul+apS5qA7zCmAe0Y6Eldwdbof3zsUf5dODKv57PiKcn0
 SkcHBVnLr92o1v87hjUAYF4bGQK/xMrE4YP7l70nsA9IfUmfbrrHXfKxBYsk+K23vEtBL0lTZdR
 ivMk3jseP78gxRcrSAr5L7bqBI9LgcOEtO1bgIl9eyX4XXsdMlLUllGXHAZebK19ddwepv2HbG7
 Orz0F1jioiuYgtT44BsjddFrj8VUK+cvH0yI5GZbKOhSuRkdHz9qMH+T8IHbLZhWmPapqTc8WOD
 CxYL6c1kPveSa8T5iqVg+AvdL3bWNVlY0wW4v57oYL990aNrTtZ28+S3MnZOB3bPCIvFSysBl/5
 K0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 'git-receive-pack(1)', to track the report status version, we use the
static variables `report_status` and `report_status_v2`. As the report
status version is mutually exclusive, using an enum better suits the
requirement. switch to using a new `enum report_status_version`, while
also dropping the static variable to make the flow easier to understand.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e6e54ba55f..f7ff6a9abe 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -53,6 +53,12 @@ enum deny_action {
 	DENY_UPDATE_INSTEAD
 };
 
+enum report_status_version {
+	REPORT_STATUS_UNKNOWN = 0,
+	REPORT_STATUS_V0,
+	REPORT_STATUS_V2,
+};
+
 static int deny_deletes;
 static int deny_non_fast_forwards;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
@@ -64,8 +70,6 @@ static int advertise_atomic_push = 1;
 static int advertise_push_options;
 static int advertise_sid;
 static off_t max_input_size;
-static int report_status;
-static int report_status_v2;
 static int use_sideband;
 static int use_atomic;
 static int use_push_options;
@@ -2191,7 +2195,8 @@ static void queue_commands_from_cert(struct command **tail,
 }
 
 static struct command *read_head_info(struct packet_reader *reader,
-				      struct oid_array *shallow)
+				      struct oid_array *shallow,
+				      enum report_status_version *version)
 {
 	struct command *commands = NULL;
 	struct command **p = &commands;
@@ -2217,9 +2222,9 @@ static struct command *read_head_info(struct packet_reader *reader,
 			const char *client_sid;
 			size_t len = 0;
 			if (parse_feature_request(feature_list, "report-status"))
-				report_status = 1;
+				*version = REPORT_STATUS_V0;
 			if (parse_feature_request(feature_list, "report-status-v2"))
-				report_status_v2 = 1;
+				*version = REPORT_STATUS_V2;
 			if (parse_feature_request(feature_list, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
 			if (parse_feature_request(feature_list, "quiet"))
@@ -2500,6 +2505,7 @@ int cmd_receive_pack(int argc,
 	struct shallow_info si;
 	struct packet_reader reader;
 	struct odb_transaction *transaction = NULL;
+	enum report_status_version version = REPORT_STATUS_UNKNOWN;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("quiet")),
@@ -2563,7 +2569,7 @@ int cmd_receive_pack(int argc,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
-	if ((commands = read_head_info(&reader, &shallow))) {
+	if ((commands = read_head_info(&reader, &shallow, &version))) {
 		struct string_list push_options = STRING_LIST_INIT_DUP;
 		struct strbuf unpack_status = STRBUF_INIT;
 
@@ -2596,10 +2602,18 @@ int cmd_receive_pack(int argc,
 				 &push_options);
 		odb_transaction_finalize(transaction);
 		sigchain_push(SIGPIPE, SIG_IGN);
-		if (report_status_v2)
+
+		switch (version) {
+		case REPORT_STATUS_V2:
 			report_v2(commands, &unpack_status);
-		else if (report_status)
+			break;
+		case REPORT_STATUS_V0:
 			report(commands, &unpack_status);
+			break;
+		default:
+			BUG("unknown report status version");
+		}
+
 		sigchain_pop(SIGPIPE);
 		run_receive_hook(commands, "post-receive", 1, NULL,
 				 &push_options);

-- 
2.55.GIT

