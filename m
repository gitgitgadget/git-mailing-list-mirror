Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993F56852F
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965505; cv=none; b=JjPbfMC1DLr6ImpeEFZUdNBLMK1ZBD6Tot++L7iCKslrisM1yhvt2D0lpV7cagdKJXWix+3nKDiyAljm/5Av/vQjNo1BFuSV7Urpx5OlxBbeFeGS0O8bM2nIk+0yqjVG2wGRrU0SgE7x+W19AgQpK1zT69tR5vAlD0sKCnPuh5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965505; c=relaxed/simple;
	bh=FWFx7SINTPmDC7CuXz7gSPL7MUyvJRrD2DwiymbCh70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqqfOe9W/pMvK34FUj1eCwgUEkgax7c7Jnud5vqrVbGoZXovGmfpUfCJQCRtEJFcahRdY6mBXdzhp9Z7/046sQ11MWSSOJD2nqgMmEC2B/5yubvBjUclI7tN3jxXSFySKd5anGUy0tjdBQm8PIykrmKhM2al4j9vU1c91T+uUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovThGERE; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovThGERE"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso2436435e9.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788965501; x=1789570301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q2AZUquSvjrwUZJ3/kpV0yA7yWlFvh3bckc30B8aF9I=;
        b=ovThGEREPlavU+Oo7A1b0TxQLEx3tbBIABylggPr6YE3XHpP8ZcJG5rqn3Ny96A1G/
         b6uSb91wTOJIw5mYNgXiYlqgGoMHO3dtN88Ha3/LxdBFf+xHRVV8yE2BpreSMpeAM5vF
         DeIg/FJA7EPpsU7aUGggKG/zvVWwqo48hBILdPGQyGxA1EX1OPB6tmxcwznkjcTFl53t
         DcrBYKY83lPV8ZCpxqGIAdeWFJQoO8FGElzg3JDEg/v9sO9MB9EJsFRIqk6qbwkQlMzQ
         AYPMOXdXlaNIgpOr3oEnCJPOiHYBmjPBsDgJwbWCPdyrlgOsgSA4E06w1pQXFlDAyEPE
         Ukkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965501; x=1789570301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q2AZUquSvjrwUZJ3/kpV0yA7yWlFvh3bckc30B8aF9I=;
        b=OegsqJmOuXYPMsmmbbB+fx7APjwb4L1gqXJNpwnnfn/ri9nQxS7v5RtD1c5iPDgg51
         WyfYpAS+FHmILRcp/LMmRoUyBBG/JMFmV5Hgg8Df9slwrChZq4wEEYzp+KGtiU2/91qN
         o1ZXDLcX2kFDcrxPU+t0CdcQAXAhfhWgMDFmj7zSkFBNpvH6GtTVbeKpeft01vDS1GPi
         JCwWafPVMAC6TU2/L2yMJYhWd1sxv2taR6XOJBv5babzzCjnNQPKRh/vPchMs7e0uVyz
         iaQ1tBqBMQuVLLaHkcAvrO5x1ZrV2Ocb28x6PhxTp2rwLVx0pK7YFk15WPTDJM4QcuBW
         RFlQ==
X-Gm-Message-State: AFuF++l3ztB2t7Ql+1jMTh+i46osxyTxA2lMGeGKfALm2d0PNbOP5PHz
	a7kNJcXRiTxUQYc5BSzZrCA7Wcz0CDCRfHWsQ2xbYkGUNQujyGbmxm+V
X-Gm-Gg: AYBFou2nuW3X24sTM7JWIJVITQQkh6ayGa9l48ezErWpKOogkBoyvKYg0NRzp6qs+B1
	q7HpYhC2G4yE41rBaiM5/pMFETt3f50xiCXGj7NJcxkkT56Se0lni63r3UZnn/OYDHyWg+PDvAU
	dUW5SiUWbAWlyczMsmlObqiT2acEl5ahPAwFoRulrQQYwA8wohfLWZ9TCrMzODS4a4xccqjj58T
	1Oi90+Aq118eriyNIGQKwJEta/JavdcS8yzw8/42V/3UcxZlhUdLZZOMIn3Ck3YkcGmjgP7DDwE
	Y5DnS4hZTxaFunEUmGVY/YbvrYXyUTJyrBWzIE+NymvhYaAs6QBEYOQL199sHlkGpjXGzwk4dmz
	dQJN8mVIcExXqV8BVV7+mOgpgEUjD+y3pY3eWnhsIINP5aX3MJ2e0qmpmQnmFNWRsV+yn2YuCEt
	J2Gkvmjd6tMPpIZF0kn6L7cnYzFdivVcRUVSNHyML/u8f4FxDV1dt2fAe61GOBwr/5qaYp00ydl
	Q2Gqa0qt5pn/Wfa41iHefWDwFHrQF6ar2Qzcg==
X-Received: by 2002:a05:600c:5307:b0:49c:f617:7cf with SMTP id 5b1f17b1804b1-49d25871d73mr35195985e9.0.1788965501053;
        Wed, 09 Sep 2026 07:51:41 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:a4c9:a6b9:39b9:91bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm661451095e9.13.2026.09.09.07.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:51:40 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 09 Sep 2026 16:51:37 +0200
Subject: [PATCH v9 2/4] receive-pack: drop static variables to track report
 status version
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-758-introduce-hook-v9-2-3043d417e0ee@gmail.com>
References: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
In-Reply-To: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3497; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=FWFx7SINTPmDC7CuXz7gSPL7MUyvJRrD2DwiymbCh70=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqhcnn2v/hHUiRUXB9iQgSqVRWTURYf/Vweg
 WoTj4QC8cWxQokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqoXJ5AAoJED7VnySO
 Rox/zR8L/36rvBzVWUDJWcKAV3mmOVdNsntuW12nM42Uk1+Wj68dKxPio5XAZAl7h3hVKwoSfPA
 ye1p4w/TLkHYnimPTyqJ9bBN3cmFU87jY/kg1vtUhTvKE57V9lF1SusP4IG4t3NhtM7LwepjE2+
 aBwYaB7JnXmr/oJjlcjTMgQIp0ou+ChBCRIX9QKJoYTJS3rIcaxcWTc4I4v5APsS/R6ggZnaixa
 apwDx1OujsIo3CIFVQdjyRpo9ZIgn0TcW3SCMNb2Ca3DdY0Gr6k6CYroAWbf0ZWQ4ZpNrr7uB8c
 sJU9/qlrvm3qWW9VhYkC1wL/9vLwmWti7Z8shPB3hRO/zQPnisfrupUbr4xI9y3M/7ZQMgp/2nE
 to35x8abpCVzNuPryhXJRrTYAzd7LKumBe7z7JDpQNUIXPcTiaMTjIv9Nlc8+YTsXhic7YxD47k
 Jao1pte+xI8mHcayJXGAfEHXED4vWbauV95cL6MKw7FrVz0yKkkrOadUxEsx4NzU7FBwYEb8Ti5
 po=
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
index e6e54ba55f..75a1788fa5 100644
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
+		case REPORT_STATUS_UNKNOWN:
+			break;
+		}
+
 		sigchain_pop(SIGPIPE);
 		run_receive_hook(commands, "post-receive", 1, NULL,
 				 &push_options);

-- 
2.55.GIT

