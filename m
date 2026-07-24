Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46B427F9D
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890475; cv=none; b=WUEfgBONW20gl2ETPaZ5MrZeu43zc8P+k6OtMPsY+MoBcw+Ax9GacsNo1iYPpZM8uOI/y84O4YdeVwOoJOjqRd3Rr3RHNUC5aSqyF47eK3hPb7kGXroRZOeXYNaQScb3tRkxQpiRAMJ9yltfiHcPf3oCf5S2olESgOjEaSCkaBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890475; c=relaxed/simple;
	bh=BforLgeYW4fWm0BaA75bIHQAC8Jr8r5i2JpLa+c+dXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjZ2ArscJbfn7G/XDIFSo4nZGJD0OiE05E0rjbM/mPdjbom+wZ84ajgnnjcwQ2DMVrB51we8o2o1w88hWsVAbSM6tFGUiqArgElqR2h/lat+YsarJv3MIDnpNhTUL5i4/rQxh2Vdu8F6NpHJIHVa7NDHmG5MqnsrO5Sy9jsfjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrKdodSg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrKdodSg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so2585465e9.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784890469; x=1785495269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bd6FEBVLXEClvE7aMGqwW1VDrqGH+UOz8i5+5dDYbt0=;
        b=DrKdodSglTMtdnaAFCcldr67eXdKrcgOcDhGOpo41rkSVT9Vapz01f6gOaWi4FJldf
         +opQKCf7ny5AaJNzZytFExqSkFUPXrfhERhOMfeV3KfQLPhTd46gZYVODjsEf3megj2D
         zK+ZeyoZ+RaZCGpMYDIQRAB2QpTskyD9pDKkKVD1/yJx1IpTnhya+BeCJ/7bvNvUxKnc
         PGyl2QTUod2ytEKOtgIPDId/3RsfawpP317btZCm7cx0xOFsqFB1jmR1gCgX9gqsO3NU
         wLETRB5LTghH/ARHHhnEzZPZXRvWjPvAubpC2Z1Wdj7Fap53kiqoTnMht8mG58AtqtFZ
         982g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890469; x=1785495269;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bd6FEBVLXEClvE7aMGqwW1VDrqGH+UOz8i5+5dDYbt0=;
        b=TKvGp5ceG74BPCbE5HeLDhwpNiVc6mMxvBSxy3Okzjp3IuCdA9a+IkyXPLVN/9sCCa
         vUAgbYmdrqIt7lf7dS7+9t9RiQmR2DeH/P8LnsDtrUbBMQfX/XaJ8LCnIwaPwPrkJsDd
         jrN7hJTtL/QyLhqQ5zlnB4P4tsX/JqY9bqa2F0HN1wkrJiwLrd65jo3Nfex7H6/AU31w
         NbbvsFdv5qgn8f1WUoqeVPf5OGSIeV4eQ4SPDzAPx/6bV2CrVtm9bZhpeWUG8ThiOOqe
         T38Icb/qo9OE17fjbloj3BtAfQ1xAZ2v2++Tb9QBUi9b+4mSTkr+gYAuKUcEYyqHxp/x
         u+Ug==
X-Gm-Message-State: AOJu0YxjBViPmlnopjChr5PX05a8k5DXeDdTpk5arbY7dmRRR3iWe0Sm
	ZlVCIYMBlgDOVy49rc+r4SDzbqPPp1X92oirEjPbRp0jZr7i596vjewxLt2K8zbj
X-Gm-Gg: AR+sD10hL8DUs/Lg6uV2+vjzCLy38b6odaStKz1UEjEoVQ48C65daNNqHM+bo1cO93J
	gh6bCSpUwhF2ufqxmtsxv3rvVEHYJdu7YgXBRzNt6ioWcqVM5sAOOT1nyXYB4mz4Ii3AA5gSLRW
	4a7ec6bcajIMi+5u5nFUfxtzjN/aIoyZSRPpGTGk2oeYFq4sPgV+5U/sRoMq0mvrRno9tZd6yDU
	MGQLuLilCA46hycfzW7lrIL6Lh8s592zVyWof6Gq5P0mvUPEiBC+BsKgl/Zz7+C6ki6eGEnZ8XR
	Imz5GaHJNKpW7YVWhI5B/i5ndd6P8R0uTPmLvl5mgvIUstVkHSqplDes16tDUuD2BFLsHhqueBu
	WMb9Rj5OLsOPtXesnDAVR+JBq+L0F/v7KNQNEHjzNmRmlHiSoDDML6CMnKR56jlFp4ShfDl14+s
	v/ZP7kapXsdZ7/pQ8U0IpaawQccGV1w7xT0rkG32xz28Tl60FUPcHZKLGTCnJmBNqPVOvjZ8hEz
	sZ8mbKWnRTGMF5RZQqCbPsU+q9z30iPw+t10xZYeQn7iZs3nKHJ5u9p1ibuGO1YiHg+DZ0TNfks
	RDlyesHaj+ovqcV6CwQtKpJ0CrI4l55y3ARxVtny40vEkWU=
X-Received: by 2002:a05:600c:63c6:b0:495:607e:5ed6 with SMTP id 5b1f17b1804b1-49573cf0eb7mr56995375e9.31.1784890469116;
        Fri, 24 Jul 2026 03:54:29 -0700 (PDT)
Received: from localhost.localdomain ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm41797645e9.0.2026.07.24.03.54.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 03:54:28 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	szeder.dev@gmail.com,
	toon@iotcl.com
Subject: [PATCH GSoC v21 02/13] cat-file: declare loop counter inside for()
Date: Fri, 24 Jul 2026 12:54:13 +0200
Message-ID: <20260724-ps-eric-work-rebase-v21-2-ba67f024fdff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
References: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

Declare loop counters in the for statement when they are only used
within the loop body, limiting their scope and improving readability.

While updating the loop counters, use size_t instead of int for counters
that iterate over object counts.

Update the 'nr' parameter of dispatch_calls() to size_t as all callers
already pass a value of that type.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c | 13 ++++---------
 fetch-pack.c       |  3 +--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1458dd76d6..fc18a92736 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -720,14 +720,12 @@ static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
 		struct queued_cmd *cmd,
-		int nr)
+		size_t nr)
 {
-	int i;
-
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (i = 0; i < nr; i++)
+	for (size_t i = 0; i < nr; i++)
 		cmd[i].fn(opt, cmd[i].line, output, data);
 
 	fflush(stdout);
@@ -735,9 +733,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
@@ -764,7 +760,6 @@ static void batch_objects_command(struct batch_options *opt,
 	size_t alloc = 0, nr = 0;
 
 	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
-		int i;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
@@ -774,7 +769,7 @@ static void batch_objects_command(struct batch_options *opt,
 		if (isspace(*input.buf))
 			die(_("whitespace before command: '%s'"), input.buf);
 
-		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
 				continue;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 29c41132ee..9eb8fc5399 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1388,9 +1388,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	if (advertise_sid && server_supports_v2("session-id"))
 		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
 	if (server_options && server_options->nr) {
-		int i;
 		ensure_server_supports_v2("server-option");
-		for (i = 0; i < server_options->nr; i++)
+		for (size_t i = 0; i < server_options->nr; i++)
 			packet_buf_write(req_buf, "server-option=%s",
 					 server_options->items[i].string);
 	}

-- 
2.54.0
