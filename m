Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A293CE083
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913695; cv=none; b=jANqDpntjoaLmtkUj2Cez5zqm9X49FlTwTyquZ/Jb40J5giI4FgKfMrNjlAkFqIr9bkffoBIEwvD+RByZbuSk/cc0FVwedsSRmtWa3a4E/5hEzrz3/gkNdVaKgDmuOA7LlPlsHyQEl5v1wd29yB8DpJJalMXrWlHCl32snuJ2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913695; c=relaxed/simple;
	bh=hiXfgzyOXX1S3hL2BgzRiI7i1S9zPyEjgZyFJEKfMt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QM7JeQAFoW40dWtQNZa1B7v0z74Wx2lfln30iM1T95HkpCWUXLFy8CwudZ+tEc2knh/dYRiMI1EZFEUnu7bB/w1/tt966Cw8ArG+gPdRR2wYkYSmayzYSo+eJu22opopMWUbBIesMIK+R0Qj4FE5C65I+7wvlDZDKGQpyX0fc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKvRTsA6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKvRTsA6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4600cbb06deso2193702f8f.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913692; x=1781518492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Gz+UucEtv2Sqx5P9SFvGMaCMLIpqEd+aR7QwmcyNWE=;
        b=cKvRTsA6P6PKV/QJm2LPMFHusHJeroBsBg+/LQMcXBDL1mqx2hylmgyu3N2AdCkSxg
         H9qrAuW4aYPLhoXIQwY6obsVGkIMn8hNh+qdZi8YGJpfByfevHrTkDEOJVu481g2LDsZ
         oDj2VzP3/XgvalMLvN5T1wQK8uoy/7s7ciesA0jneWN9UyI6zaBpsGHIYmo+rSnVo7de
         QoR01gnupm3m3GRfyLeXMzOBU7weZXTthlyHITEZO95GWN3hroe/qg1H/6Qxqi0OyakC
         GlgUsE7fbtJAAivCLyCghQ7SjbXjDpAuIwJy39xAOYCMDubOI7yUuXhAvrNCfScRuruj
         PrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913692; x=1781518492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Gz+UucEtv2Sqx5P9SFvGMaCMLIpqEd+aR7QwmcyNWE=;
        b=fy8BujbAYZXzwG36AIQlGzvnWit7uY52Jlyq3SuyIqvEXi1gE91KTR1Nzdn7Z+4MOO
         rX6OflMp+4o09CQSX2xgFF4IoGg0no0wD85QgKnOKWx1CxZzH1iaIZM1lp+8KL3dpczc
         6INhyvlNy36bJcXSqsxRN2/RmkbSoS5kOtDkQ0dXxhZxueKAZ7wTcu+MGyKjnZ2OZkSg
         r1wF/FNxFR/qLSfC9MX4TDMA/Tu6GnbHdA6/PSnZRB8MqizZgFygQuXS23WPsVNZpZDQ
         J+o373ETVzOF7JESLItDMglLkWpsc18hQ2NxJKMol3pjYQ2dA50STuz2zrDYb//jsDZR
         FUvw==
X-Forwarded-Encrypted: i=1; AFNElJ9zydjqx/mAxxiLL2Lx+L8WAuQgCrR9ip4qOgosLrVSpQ/HZuFcobJL/+o6szBrrwlijDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWdl5mvaeQ430bwPjj930IJEa4PX6AqNnDSXlvEElbCzjFBmMA
	ED90mq8/703fiSFqMmqkJPeMsJCTiiJ1ota6C+h0fxk+eqgB89ZDS+9G
X-Gm-Gg: Acq92OHVpTop72F2GTocb0s+Wgh4CeVCqlNiuNVG9i6YgjC7XPE0oLzhVmrxAAMyDU3
	vZEA1GN2fkI14tzM7kJEQz/MH9WitBU+h2CoYNXul2tYm5I7wN/p/6exIaeHfE3aFmND80YcV8Y
	0ZSb7GMvbxzdZnfr9ByWgAtcIHX5AHpxqt8KvMdPx14Rpnx/rkk7/sjpqh39n8nD/IHaK6owB49
	LZeb3P69VlhwSkOZ5mQzg9M+HQ5RQMdFj+MXDUx7nEAMOcuXJFRf446egULvy1/c19xOv3UlUfx
	SxTLor9Av+AQz+IUFCLvfz2Yaivn20lA9sV6TDmkZ6nv2tPmcKiCYe90P80nyAZfeRf4Uiv5UGt
	+N9yHOeaR/khTRuVZSU4KzKK+cTmyWI07LthyJcNH6ynP0y5REZ3ZYhsAdqKR70NpYYNiTWvRNp
	ltYK8VujtncBJ3NKXCiPARS5HKYC5v1gggY7swXvCb+nD6QTySesyPBIr9pQi0FAF03cE4gouSF
	AbD2odu0PaJV83agxgZ76zTQqEo/nY6M05P4xyiYee7F9Rbns8NBifjYPL1Gh9yH8Meiut25lVc
	xBKXcU9lWnmrjWd1nKojVU/IW6CeRjCxGdYY1cayHmQhsTs56uSBxOl7q0zih8RDOw==
X-Received: by 2002:a05:6000:1785:b0:45e:daa9:f34c with SMTP id ffacd0b85a97d-46032dce5d3mr21125756f8f.26.1780913692038;
        Mon, 08 Jun 2026 03:14:52 -0700 (PDT)
Received: from localhost.localdomain ([188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm51131949f8f.0.2026.06.08.03.14.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 03:14:51 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: eric.peijian@gmail.com
Cc: calvinwan@google.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	jonathantanmy@google.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v12 03/12] cat-file: add declaration of variable i inside its for loop
Date: Mon,  8 Jun 2026 12:14:26 +0200
Message-ID: <20260608-ps-eric-work-rebase-v12-3-5338b766e658@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

Some code used in this series declares variable i and only uses it
in a for loop, not in any other logic outside the loop.

Change the declaration of i to be inside the for loop for readability.
While at it, we also change its type from "int" to "size_t" where the latter makes more sense.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c | 11 +++--------
 fetch-pack.c       |  3 +--
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index fa45f774d7..c060fd4800 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -726,12 +726,10 @@ static void dispatch_calls(struct batch_options *opt,
 		struct queued_cmd *cmd,
 		int nr)
 {
-	int i;
-
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (i = 0; i < nr; i++)
+	for (size_t i = 0; i < nr; i++)
 		cmd[i].fn(opt, cmd[i].line, output, data);
 
 	fflush(stdout);
@@ -739,9 +737,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
@@ -768,7 +764,6 @@ static void batch_objects_command(struct batch_options *opt,
 	size_t alloc = 0, nr = 0;
 
 	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
-		int i;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
@@ -778,7 +773,7 @@ static void batch_objects_command(struct batch_options *opt,
 		if (isspace(*input.buf))
 			die(_("whitespace before command: '%s'"), input.buf);
 
-		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
 				continue;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 120e01f3cf..f13951d154 100644
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
