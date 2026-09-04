Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894D3D0932
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557344; cv=none; b=dRTXUvuo4Zt6aiUtYBUjW9jCBRV/bVheVonvXXsJOgNdqKuxRAR9nPU/ZUz/n8v+hq7yih6PANeFjWQ2G+w+4q8pUEOj2SZeZ2ljE78MTISJlkBQyBulf3t4GFSb4VYtk0P9U/W3WTdQyBDm7skj3hiAsncH/naYHMGbS+Zv0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557344; c=relaxed/simple;
	bh=fcGuVw/u5p/NaYUMvoSmw3QE9hYG3j6IhG6iAyRf8T8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hc8FKGBqHEj02kraOWCasevIuUWw+dHt9DNVuxp7I96hbIX7Zom8yTm9IKE8pLNCxGrp0Plfcn2E+QIeE/dw6A5+oIF7crXdREbH01BwTJibICRohxg+0/YVO1UOOZgVKFrODIOyc/W0cmiwRSqcNB/hxZd4M8jEUGplNTfVGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCkeKodA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCkeKodA"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so13406765e9.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788557339; x=1789162139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MDNCpSwpt2JrXZpaPG3zDTGZW20Bk2ZSKQnIgU1/oU=;
        b=SCkeKodABCLOVHU1VzyiGUz4QIu7OqTvANzm74SAcGOeeMz/WXKfn5aRINY2XBki7z
         P+8PB6f4BfjDOZ3Qjx+39nk2MOcEvu5cQj//qhmoGp8RYKEBr6ukijkU548oBXiNcyuo
         vgRKZ+lto9gVSQpTxbRmjafckzK4FNHht8miQFim5v6P96dgzntDW3AReP6IEmpDD94y
         R6ttbweUgL4YY8CTTBiI0Z+SsDDwVWELvGnKKUFGBon/TDJvbs+XJ5xEVAqX54F2lNfE
         A/brto1//vG4PPTWmkRW6nqff4vOOg1Ern6URoTIkhEfPmvGfnItMtdJkD3X99MlQsfV
         EwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788557339; x=1789162139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MDNCpSwpt2JrXZpaPG3zDTGZW20Bk2ZSKQnIgU1/oU=;
        b=PjF4/OIm+Wcjc7FQEHiv/pjFHrLE9vP2iK6S3SwfwcOXRnGIuAL4Zwza1ODGaFhLaq
         j5cB0pqHdPMRrPulAhkNKu5eukBzr+TdSH69xyPWYL8XnSgefeO8HSRfk6BGoCSTXc/z
         B6T8g7t4du6omvKC8AMtXezdufO5u4DtJVf3RWG+ZwKrP3G8UxdNf5KVsszKNaPxyf+y
         rcej3LydVGn0Kt+fLmkh5+b2UvEVB+tn9zX7DqiLnBxpgW4KSSB8DtsSD72xLyfqxFF2
         59oyM1vCxrpW8uToFjBgsxBPhNl4SzD9E8JvmLtvTULrJwj82yhO6CYdSAVm0cqglOVn
         bj1A==
X-Gm-Message-State: AFuF++m69ODuvqfpp5WS64sLHX8dCdLaailPZhlts+AhxZ5hk3O8ic88
	uilro7xNhEXmGDQTriDcIVMcadT8Dl56nwy9azuIPbCnjhTKs+ox2km2
X-Gm-Gg: AYBFou3BV5MILV1aMnA2eq2rHLeaJ6iV9xFjb4Wa+p1pcEIzpJ+BUT3CXHz2dXdE1Aj
	oVoFkYCx1EvIoTmnPKUkMjqY2e1wDSayI0G7y4HyS04u19pg1hQa+/g0f1Rg62ucUSPYwzmMzyP
	Vg0+D8SyriA7J9QptgWl9Pv+9iUTTRGnZaTMVzcZhZUd2l/CW8vNgaoMKcZ123eDeoE0w51GP6M
	OlXemIHrKqxs2L7FLCsXvfvL9j23L4FZqu4QYc9MFOyKlswJXsfeWRNS7L8IBA67dR3HIwKez7Y
	hNw7S/mPRDpP/hAHOxtvNSV+UVwOKeb1aLuVsRpWoCD7rveuwQTmb+OFzsgcsxVHkXyeDMqLAxC
	GJF0FmhR82LxwRnubmxZIhxopS3gOVdwHs5WgIMjUcF1w5T3FUF1iitc1QqhcIo7wnXP2GeeM4Z
	A82TPhTtUYUmbS952tWjD39SSmSEjFNK5WbXochwiyhnVugM+XGwOJ8y9TtJqQvo7zgAM5rmLyL
	RPdOSLybrNbjMaexyfbIbS9XFsZos/jMY7m
X-Received: by 2002:a05:600c:3496:b0:499:b65d:1250 with SMTP id 5b1f17b1804b1-49cf7fe62admr151469945e9.2.1788557338803;
        Fri, 04 Sep 2026 14:28:58 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1faf:874b:d20e:6b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm8820051f8f.23.2026.09.04.14.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 14:28:58 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 04 Sep 2026 23:28:50 +0200
Subject: [PATCH v7 2/4] receive-pack: drop static variables to track report
 status version
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-758-introduce-hook-v7-2-6c66f0a3a572@gmail.com>
References: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
In-Reply-To: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=fcGuVw/u5p/NaYUMvoSmw3QE9hYG3j6IhG6iAyRf8T8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqbOBW49I2X7DnNcPSBb8coKtNWEkuYoLZUf
 zGKJ6Kx7/EIwokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqmzgVAAoJED7VnySO
 Rox/sb0L/1+4EhhwbzNmSi23Qd2dsxGWj3m85sbd3Ngtju2uYQ+o1S2K9xHBM8e7a+a466ciVrw
 vLp43elgBHqfm562ZgMj7cmAPWo6Ha+Q+Q3gGdNAeLyC4/iBgcWMF+q9zsfIUpvBEaXNeFmT7Z7
 4QAYy8YrHVqFTYuHgfrJo7q3QaDhhO4yZ5FulCIjV2MufqwQWAxgE9Vq5YzAWj4sVxynRjvjKdS
 QM+zCBEZtujpnG4FE43q1vExHapiIuMpa1akgDNwqyOK6Ikw+z4iMY7bX4c97zpS65QH/raL2VE
 3y05WuU1EBot4wGDh/IQtajijXRaylf/zGn2WqPrk4mmcsT50C26zngV/7u+FDmCVXxeARMeM1K
 oLakb9UQPiyTfwnXx0dVQ/guOpt6ieObq3OhaU/BW70gJZcH0OLfEyQsTiUzmjimTOGvkST+baa
 0cMrPvaQnZ/MywMSVGlg0RqJQAu/nk9iD/e4nd9AErQQVqd8JO5mCnJvqjqZuCdvznFroDz1pv7
 S8=
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
index e6e54ba55f..c356e34cd8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -53,6 +53,12 @@ enum deny_action {
 	DENY_UPDATE_INSTEAD
 };
 
+enum report_status_version {
+	REPORT_STATUS_UNKOWN = 0,
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
+	enum report_status_version version = REPORT_STATUS_UNKOWN;
 
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

