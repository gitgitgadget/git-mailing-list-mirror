Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C2365A11
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849622; cv=none; b=TfWHJ5KYd7QaL4jxHpgHItf6mEja824HiQeuGkWjs8KmYp2RnhazKYvBcMSDmrkhHneJBqnG3G9WHnMStqNMm/eRn9Ty0k6RnddixXOKhiuwgTV9NbDB+Qjp7UvkbPwbgMb/ss3RGKZbwKNzKPUl2rTR4Gnz0fMm+C3lnBWlDi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849622; c=relaxed/simple;
	bh=CqBvUoM8zzSuKjX2crZcdeylwoUipDpRPikEM2l+dVk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ns9967J+nuIvclJM/2Ps95YoP2L+ZUpMLCXSRZHKjYA3qOCJ3GFFDjjvo7CoQEYHGR6gW0BqRzPxEyUwSLrsZm0u4n3ls3nOJ01gqRFP38oh1xl+7N7gIxawmv8PmKbRqtoTDHQgohUTc+azV6diBuJoJSjh8oIgWNnmH+8L5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQWutemF; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQWutemF"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-649e97f1e1eso3187034d50.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849619; x=1772454419; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nIIxfVDb8fnoQ9Q5yLB8uLmtZi4JaOXiiKTTdkLSng=;
        b=cQWutemFFS4llY4B0yn0mX9afos3Aea94y+RDhjQHEx9gSlBdX2fDAaSNJFQ50REUi
         AGJzGDhhEpY5ui/FK/1n+/LDs1286TLgOfntdximA2SqusmbUu9Ej6ZOvAmc38Q+m1+H
         AvLXCZoF0UC0vo5L3+L8LmIQ9SBPS/iUHoDWACDKLancyxazjkhJX+SXPUANRIv//rYZ
         vLM5JpxqUi7tG6gOJRlg9F632ZSTyzpcecdG/6imIjgnYlCQjS3wHO//Oh8cNNv1EK5a
         tp6EWBW864WGKlS9uUXG+MGSMPh7J1sABIU7sqB+OORg65/6xzRHmZlOBAu0afbUbegw
         RJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849619; x=1772454419;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7nIIxfVDb8fnoQ9Q5yLB8uLmtZi4JaOXiiKTTdkLSng=;
        b=Fd32Jr3VJaesinF0t0dXgJGXDASguY/H4fV7hSUFARiGOESiqbJYkvCMUs3lEzjHaT
         O0hKbtuzdejfiZnoUReFSutSNDKqFbgZUZo/05Xqs29nv8cyDUDnxPmeNJk6Z5lCoUNN
         9lzGB+XLBmttB/iQtFNXHc3BD2Cs82O0Ku12We99CjvOgLy/QdZZbI3EntX8s8oCr5Qt
         nIVHX0I/hfai0c2Ri4y2MQr1/kdD3rI02r/i4c5pjAmBIB7vO5xq08+xE4Nbal123t1c
         cNCbpu3rZdX+ypdCPsqqIWeskNtSqjL5U0+CWfMTtEgHHAZFrO3MZ7R/RkW1SPVhKIDR
         iqJg==
X-Gm-Message-State: AOJu0YzZDhZFYxrijB5CRcgibXxqzIvyTNHnaiXIToUOoM1a4/V2eUuJ
	qblJhdIcjPCLRdv1a5VEJLIvrdgBaaASl1Czd1/I047683jq0wqf0dZlvZj/iA==
X-Gm-Gg: ATEYQzzeSh6fkDiRKvBrJX/iiatUSRacqGXJLm0J+J5oPjEHasdRtJR4RnkDg+fOOY1
	UVkEMO40IsaGnMAMbq0rWWiWIvvaaNkQRe1IOTo3MOHCXMQVZqQs+TgXgbi4Cg12d4soaVVgnJs
	cK4sK4yIQ57nTZzVsqr/fws4Tw/Dgt6eHKDBKlCagvVdQS4ootlegiqCvFKDZTjI1WClIpOywfE
	x/irkfMRwac4+9wD9hVtu0EoxBKT6P4XgWBjUMYS5HUqcKu9cWpZ9D9cFtZYMIKdU595kEVWezq
	AaC9dLKZRoxwgEyRYROTtKL4fX1gUWfX4M2CQgCc9qGnOMua7Mv19/IEQONjbXN+Aih54Ibp+jC
	RYYtwlmrz3hzNESSZxhdoJsZzcgslR0KoSEbMvxm9Co/l5i+hqJ1Y/pcVN86obrZZzC6F5IypYb
	H+KEeLJXdEpFwNYKhkY9U+q1i42dvE7wGdPHg/
X-Received: by 2002:a05:690e:13c6:b0:64a:d444:816c with SMTP id 956f58d0204a3-64c787d4d9emr7392409d50.17.1771849619429;
        Mon, 23 Feb 2026 04:26:59 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a28f9d7sm3177375d50.10.2026.02.23.04.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:26:58 -0800 (PST)
Message-Id: <93c94a1b257d26a23942e902630c220e4a4f8eaf.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:44 +0000
Subject: [PATCH v3 02/13] config: add 'gently' parameter to format_config()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This parameter is set to 0 for all current callers and is UNUSED.
However, we will start using this option in future changes and in a
critical change that requires gentle parsing (not using die()) to try
parsing all values in a list.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 237f7a934d..b4c4228311 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -242,10 +242,14 @@ struct strbuf_list {
  * append it into strbuf `buf`.  Returns a negative value on failure,
  * 0 on success, 1 on a missing optional value (i.e., telling the
  * caller to pretend that <key_,value_> did not exist).
+ *
+ * Note: 'gently' is currently ignored, but will be implemented in
+ * a future change.
  */
 static int format_config(const struct config_display_options *opts,
 			 struct strbuf *buf, const char *key_,
-			 const char *value_, const struct key_value_info *kvi)
+			 const char *value_, const struct key_value_info *kvi,
+			 int gently UNUSED)
 {
 	if (opts->show_scope)
 		show_config_scope(opts, kvi, buf);
@@ -372,7 +376,7 @@ static int collect_config(const char *key_, const char *value_,
 	strbuf_init(&values->items[values->nr], 0);
 
 	status = format_config(data->display_opts, &values->items[values->nr++],
-			       key_, value_, kvi);
+			       key_, value_, kvi, 0);
 	if (status < 0)
 		return status;
 	if (status) {
@@ -463,7 +467,7 @@ static int get_value(const struct config_location_options *opts,
 		strbuf_init(item, 0);
 
 		status = format_config(display_opts, item, key_,
-				       display_opts->default_value, &kvi);
+				       display_opts->default_value, &kvi, 0);
 		if (status < 0)
 			die(_("failed to format default config value: %s"),
 			    display_opts->default_value);
@@ -743,7 +747,7 @@ static int get_urlmatch(const struct config_location_options *opts,
 
 		status = format_config(&display_opts, &buf, item->string,
 				       matched->value_is_null ? NULL : matched->value.buf,
-				       &matched->kvi);
+				       &matched->kvi, 0);
 		if (!status)
 			fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
-- 
gitgitgadget

