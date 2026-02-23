Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED54634F48B
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849630; cv=none; b=kAbVAbrsk21QgQ12to52wMvXxTZHDRM5DPy8eu7/iozSefwIsoJuJjjbinXzX3FhG/z0qMZDKpDq2PdlPzPIMrAMwwjH+OuHgaLXgefByy+788NCLQqmRS0bbWnf3I7FpHVRgur8Tc/iKxHVEGF+cYJp41XwP/rI7F4dWmpOOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849630; c=relaxed/simple;
	bh=SGM4nxyXnPnlpPwu25yaioezlwWIfzNvtJEYMOgbIHY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SkU9lGKrn67nrL778ZkgmQdd/MCDlmPKrc685zj1C0ga1IdFjZ74PLEZmjapxF23mMwhgXJV4ivdLmc/HxGLfyMNoFI7UfiXnUqnqh9sXOyPiQGw1GAA6ZvcoXRIoT3sGsaupVXD9+ZCUQygRUOn/byTiulnGtp6c2Jmy4TeCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjOpvuaa; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjOpvuaa"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79801df3e21so39606227b3.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849627; x=1772454427; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj6TJhwixvvu+P0aI/UcSniUiFQdJpfxq67+Shy5JNk=;
        b=PjOpvuaaB1imZeCVga2E+meX/QoaeJNLNnyvHvxC0yHtgL222ByWMg6bDjRja/VRL7
         zs7A4duVRpQrRrN4faHQrIprNeLJKfllmRSos1CFOe4tXp5fi5enQxga+uRAnOQJ0ekm
         GGnqPbi5aMs0JwGdm4VOK0PXumnzBD1mfA7FuMHLsLn67SkPJ6lelvSIm4MFOuiQ+Oc2
         DeGdqU7Hp0KtowA9AOM3To+PXPTve4AVgc73ntyGV6pucYaBXH0FU2dBfmxpWWqM7AMg
         dYENB4O4/IH7mE+FAmD3VU8nkVK+B4UT2Z8Onc+Xhil5qP55MeH0+iUcbElHkDuiUn54
         2Ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849627; x=1772454427;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nj6TJhwixvvu+P0aI/UcSniUiFQdJpfxq67+Shy5JNk=;
        b=pon7Dvyd9IpqB2c1FCLiI15leqbuTdPw2n3kPVKsfJq+yLfRc94ZcFnZlYAFV3zIRz
         vewRn2S0CMviphM75hmEQOGOlffShfia79Q0xWA2STnL+N/Iyfy1ogLcmjOyAvnnNBUm
         mQzeJLAj/zso25JOXvb2T4I7wb7lBUN2jEqHYOaAzA6fg8BJ6yB9qN+qaX6ulE4PQ1rc
         tRbkEXWEs5dAYkizebgys64awHjsH+/bdC5r9WaHf+JcnpP64fHx6qmMyzkBpPspJg9s
         EygRqAvWr9GFS+jpCEw51xHL6WhB+/T3uVBD8j593CX8qDvpAiPUz52MDLIs8IR9hENm
         0Pqg==
X-Gm-Message-State: AOJu0YzW7KxQKWWR2MSzc9/loLjbnUlMTMmld83e52r9zSEE29AtAlDK
	Uj3xUpOPWCIXHdayZDD/Q8pjUh2iutSukn2XtD2k/B2hKRhMkxiH/8fVGAMbxQ==
X-Gm-Gg: ATEYQzxZK2ufc21YQzWlfj6BdlsXVLxsJwMMi8+JpMT4B3qiLJvrhIs2Pph2Z05NNxW
	HfOLAl+LUHd9D85HqNYEamFKIfq+xO9ECacv9M66upn0zbPl5ecu2dzKfbBw61sLk0fzijMxeUF
	OsRVnMr1fEXDAIpPD5Gt9cxDB0Eqim+I/RDfgTRg0d8Djt9/NUiuyLyu/3RmzkPW3ktL+gwiuon
	EfdQ19w1L0mhb964Pg5vWhpCDCqy5SrwuPPxr/QHhZqEIW8o6IOwyYcL50mMtVF9HS+19snoREu
	Qr1BPfQGw5tzpf6kRp39HlvWmC74b5/eGDbuqU9ZLkDe9YP8ZUhAictTI+aGFsn7jhIzGmdRjYz
	E5tbJuey0WedWEFdkPVps4530IzI5Gz4/CbKTfKnEB+0B0I1S8Hv9uCyXeaNrFXLYPp1lbKLPe9
	O4u/7wnyohB11DKqg7saVXW7H+VQ==
X-Received: by 2002:a05:690c:19:b0:795:1b83:9b02 with SMTP id 00721157ae682-79828f01dc9mr78212987b3.18.1771849627455;
        Mon, 23 Feb 2026 04:27:07 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982de13ce5sm31077127b3.49.2026.02.23.04.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:27:07 -0800 (PST)
Message-Id: <d198c238e948e500b769d7b4d8267109f7297a8c.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:50 +0000
Subject: [PATCH v3 08/13] config: format paths gently
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

Move the logic for formatting path config values into a helper method
and use gentle parsing when needed.

We need to be careful about how to handle the ':(optional)' macro, which
as tested in t1311-config-optional.sh must allow for ignoring a missing
path when other multiple values exist, but cause 'git config get' to
fail if it is the only possible value and thus no result is output.

In the case of our list, we need to omit those values silently. This
necessitates the use of the 'gently' parameter here.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c  | 32 ++++++++++++++++++++++----------
 t/t1300-config.sh |  3 +--
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 79c139c5b0..2828b6dcf1 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -314,6 +314,25 @@ static int format_config_bool_or_str(struct strbuf *buf,
 	return 0;
 }
 
+static int format_config_path(struct strbuf *buf,
+			      const char *key_,
+			      const char *value_,
+			      int gently)
+{
+	char *v;
+
+	if (git_config_pathname(&v, key_, value_) < 0)
+		return -1;
+
+	if (v)
+		strbuf_addstr(buf, v);
+	else
+		return gently ? -1 : 1; /* :(optional)no-such-file */
+
+	free(v);
+	return 0;
+}
+
 /*
  * Format the configuration key-value pair (`key_`, `value_`) and
  * append it into strbuf `buf`.  Returns a negative value on failure,
@@ -347,16 +366,9 @@ static int format_config(const struct config_display_options *opts,
 			res = format_config_bool_or_int(buf, key_, value_, kvi, gently);
 		else if (opts->type == TYPE_BOOL_OR_STR)
 			res = format_config_bool_or_str(buf, value_);
-		else if (opts->type == TYPE_PATH) {
-			char *v;
-			if (git_config_pathname(&v, key_, value_) < 0)
-				return -1;
-			if (v)
-				strbuf_addstr(buf, v);
-			else
-				return 1; /* :(optional)no-such-file */
-			free((char *)v);
-		} else if (opts->type == TYPE_EXPIRY_DATE) {
+		else if (opts->type == TYPE_PATH)
+			res = format_config_path(buf, key_, value_, gently);
+		else if (opts->type == TYPE_EXPIRY_DATE) {
 			timestamp_t t;
 			if (git_config_expiry_date(&t, key_, value_) < 0)
 				return -1;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 1fc8e788ee..48d9c554d8 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2545,7 +2545,6 @@ test_expect_success 'list --type=bool-or-int shows only canonicalizable values'
 '
 
 test_expect_success 'list --type=path shows only canonicalizable path values' '
-	# TODO: handling of missing path is incorrect here.
 	cat >expect <<-EOF &&
 	section.foo=True
 	section.number=10
@@ -2554,7 +2553,7 @@ test_expect_success 'list --type=path shows only canonicalizable path values' '
 	section.red=red
 	section.blue=Blue
 	section.date=Fri Jun 4 15:46:55 2010
-	section.missing=section.exists=expect
+	section.exists=expect
 	EOF
 
 	git config ${mode_prefix}list --type=path >actual 2>err &&
-- 
gitgitgadget

