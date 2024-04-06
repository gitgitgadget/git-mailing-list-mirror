Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ECA1E4B1
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712413965; cv=none; b=UTy0mbkUgYy3wh7qqgTqFykCqDknYjmIKZGMN7uEH6FoQXVyIi3XrBEzbWlqUrkBN5LdxrXoHvJxeZrxCwCHWMXzonnVuCo3zgtg/WoBdUCwrzcuklrKBn1kNJh2N3pf52oFcQ7C8sRrxHvNgCkmn4EgZe2wptwocV+pzJV0mBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712413965; c=relaxed/simple;
	bh=49frcw5IDHGfK4G/3LL9tS0IUWjmD02Rx1qAdGsNxlM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=UpGWBoHL4iB8l1uGiu9cbO4qYXwG3rP82/gEWW7o5NdyiaZsCSDGhLjM2vqI6PEG2SlIKTai7GMYc6iydPShYz5E/j+k0ZZfIN9sfFOdXpGG7oUSlzZ3blKYYBYsRRAEgopPtMzJ9Bk7OoNaNqF4lPEQr+8uBE3GykzynsKYyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfTaz99p; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfTaz99p"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343cfe8cae1so1555652f8f.3
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712413962; x=1713018762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyMqb/pFDKZUufmMOMIKmtN83in2NOvovepYr9ptN3o=;
        b=YfTaz99pLZCCw5pM0FJMh3l80Wc4nAA2lEAqQHb0YsDG8mdCWButu0sNjyIdJuXSqz
         xE4kiKi0VqY1c+xReHjd1BaobgMdxtoxMFmUxqqhdJ/EacVShyWBYx2b9sfaoyPELxId
         qetl148fJyvaV2cNf0Tmwu1/U0lxh4HjdorftZ+P0a1DCVQGJAwsC6pCKtLkLhKGvbr9
         jhhcQy/KnuTScWjfoJ7JqIueePoYLuj5HY+qIKrbiwP+RRI7b1oNuY8/lpNJ5RwUyOrC
         /T87l8AOa3/NCl1PAhUe0pZ3PzpLM1CPGsQfgu8mWi0B9/2SSlpjle9EU3RV7Z9ro1+f
         Yj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712413962; x=1713018762;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyMqb/pFDKZUufmMOMIKmtN83in2NOvovepYr9ptN3o=;
        b=dXH+LzP4FQdR0jDOSeGTdSEpUNWq+7k9wNgZgYWPWgD3O/rThbiF76aAOI6EyVPUnN
         jTKiBNAZ1bioJKGBG9sLzii1jaPy6342KyYS05Fcs8Tuzp19+ZAt4+FEIK6O9OHOBfmq
         H31q2RuqLbs1r3/BRB9aeVOFihlmDrCyLKa0sAK/KbRWg+4u6Dyt/leAIugM4Rlw/ChK
         a5FnXmqBErjcsE5ShDmDiZtqpRJkrKdSamHkschq7u8e2NrReoMavmw5QiX9CdbW/8hr
         EvrbX2rWSU02tmf4ZbsQoCbpeW0fMqT8f+CLJGTgGCyHevcAjIOf0eC3F2VPRP0mikMd
         QKiQ==
X-Gm-Message-State: AOJu0YxI9FypcOr7jJJNR3IB+8zkh8jKgI6osguMfaXMAgODukf2EN+S
	uMpmm6x30hkZrJC2IbghrsBaxM4phg6Tm1Et26jVTh5tlacXwpFasMLhadNG
X-Google-Smtp-Source: AGHT+IFW7KoSS71bOXX3klFWrU8HsFy3l2z4JP7fYaTNCinv5WrjZvdZnDoRN8E1zaMy4oDVvnaSbQ==
X-Received: by 2002:a05:6000:1864:b0:33e:48f9:169d with SMTP id d4-20020a056000186400b0033e48f9169dmr4659624wri.31.1712413962426;
        Sat, 06 Apr 2024 07:32:42 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id j11-20020adff54b000000b003433bf6651dsm3789296wrp.75.2024.04.06.07.32.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 07:32:42 -0700 (PDT)
Message-ID: <657f1780-c813-459d-aecc-94a10f7a3b4f@gmail.com>
Date: Sat, 6 Apr 2024 16:32:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] environment.c: convert excludes_file to struct strbuf
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
Content-Language: en-US
In-Reply-To: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make excludes_file a strbuf, so that we don't have to worry about freeing
it if it is set multiple times.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 config.c      |  2 +-
 dir.c         | 13 +++++++++----
 environment.c |  2 +-
 environment.h |  2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index 9beeb63b50..bc64af8efa 100644
--- a/config.c
+++ b/config.c
@@ -1595,7 +1595,7 @@ static int git_default_core_config(const char *var, const char *value,
 		return git_config_string(&askpass_program, var, value);
 
 	if (!strcmp(var, "core.excludesfile"))
-		return git_config_pathname(&excludes_file, var, value);
+		return git_config_strbuf_pathname(&excludes_file, var, value);
 
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
diff --git a/dir.c b/dir.c
index 20ebe4cba2..e31ccd8e48 100644
--- a/dir.c
+++ b/dir.c
@@ -3386,10 +3386,15 @@ void setup_standard_excludes(struct dir_struct *dir)
 	dir->exclude_per_dir = ".gitignore";
 
 	/* core.excludesfile defaulting to $XDG_CONFIG_HOME/git/ignore */
-	if (!excludes_file)
-		excludes_file = xdg_config_home("ignore");
-	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
-		add_patterns_from_file_1(dir, excludes_file,
+	if (!excludes_file.len) {
+		char *str = xdg_config_home("ignore");
+		if (str) {
+			strbuf_addstr(&excludes_file, str);
+			free(str);
+		}
+	}
+	if (excludes_file.len && !access_or_warn(excludes_file.buf, R_OK, 0))
+		add_patterns_from_file_1(dir, excludes_file.buf,
 					 dir->untracked ? &dir->internal.ss_excludes_file : NULL);
 
 	/* per repository user preference */
diff --git a/environment.c b/environment.c
index a73ba9c12c..b4c66e7153 100644
--- a/environment.c
+++ b/environment.c
@@ -60,7 +60,7 @@ size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
 const char *editor_program;
 const char *askpass_program;
-const char *excludes_file;
+struct strbuf excludes_file = STRBUF_INIT;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
diff --git a/environment.h b/environment.h
index 05fd94d7be..114e3dde99 100644
--- a/environment.h
+++ b/environment.h
@@ -222,7 +222,7 @@ extern const char *git_log_output_encoding;
 
 extern const char *editor_program;
 extern const char *askpass_program;
-extern const char *excludes_file;
+extern struct strbuf excludes_file;
 
 /*
  * Should we print an ellipsis after an abbreviated SHA-1 value
-- 
2.44.0.697.g9b33b46f29
