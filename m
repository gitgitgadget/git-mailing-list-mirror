Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E343BBE2
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712512690; cv=none; b=F5IOr3nJEAzoADnFQkZRvyrjTjv9rg0Z5EzJJLvFfOZpNH0FVriLvLzOi7+7FuwRT8osBgY61ynJU4dxMcQ1maoh6HNnK8xcuXmMBQBkh2RTLGyyqANS9YKoAK4Cvf9GH3x2BKP1xIdlgY9ToSH1qrws123yPoVAWxa/qcLOHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712512690; c=relaxed/simple;
	bh=2JWscO0K471PlElQa0ZIeKOI0Ga5LuVXOXa1Fvp+Cs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGoTtnALJ9CQFoJpbjeYYnn6dyg0/frGRTZ6nQ2bfnvfXAvnlv7AyuwJ3RNamwep0fSoa1snzk2q1+MsdWPvxvXuFlmQPAz4kELxddZoHPpZUdGhl1IPXtuBjAVZtPH0YaZNJNcMGtSvDuVacw99AqCpqT4H83RUyO4Cuz+o+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIHC/Neg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIHC/Neg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41650de9e1eso3181295e9.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 10:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712512687; x=1713117487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42D4Dg1Tyd5F9tPTZG4pDCHt7wAuxpWpm/bDlD/xUAI=;
        b=dIHC/Negpl3OAl77kzQYUqWEBDseeoOSvcqRgdtCoSH7wULDhJnJmNpHM22Dl12Xge
         H81PqDZflOVk4CzgQ/qfdrRxqw+E823l/v4ykmEuBXr1amKi7TXeounsRedSiq1PUyjq
         2A2ivINKIdT1Mu9q/Ryi3ZrobVEK13qcz9omsiyszkOAy0zF6YCZkfHAs4USn4/1ms/h
         Qao8aDthCKPYvMzzAQAWDrPiLlJDVtuQLad88D1CTa6Wdp+nQ9SAwcBg15psN7PxPt1l
         qcT7jmJ8pc6tSp2kD7TMXlqQVzmE4Q1ZjCtHWzxA5QJy8Z1mpYyPMKyh9OEIlIdtDgPz
         eLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712512687; x=1713117487;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42D4Dg1Tyd5F9tPTZG4pDCHt7wAuxpWpm/bDlD/xUAI=;
        b=JDN2XqELQAA2PlYCYoT49Q1yOI3JBVTWuOPm4+v9mFIgd86iaahLK71wjRaPins7bY
         fnT+8Uv2e8PXYbInEn5vzteLbK/N1ibe/6kFIvQ8+xnouuXjidX0KiNrHvI2IZirnWgY
         yIh+laOjJBKaU7I56F+Ff6u4wxwT924uVKZBPS05O1R5h6SEv/ruEflM1rJj576d6k7h
         FTSBJZOwPj03Fnv1RdMo9Q7WZFSjfLLW6sLCL9iH+ewmOoi8/ELawxNePXYhVErKnvzv
         QAArTlqpMimypofmRtFWetd/1KPB77yTIkrrWq3OvxCa9rZCN5++UqNnvSBgrU79xquz
         TE5g==
X-Gm-Message-State: AOJu0Yy4CZXDcNk4K3Ufp6p7WNX/UCKykrRAWN2g2BSeGcjHOjxQqKTH
	qoeHw/lrdnSamxhUoVuK3gTYAerBR2pLaCoNhcKhhweHBpRHb8R2
X-Google-Smtp-Source: AGHT+IGlgQT6S2O+tU2mG4wOsIGfWhY75fv08SEfbMt/B8mZyeVrvI38ueVR/KWUMyArLH2d50/ubg==
X-Received: by 2002:a05:600c:4448:b0:414:8ffb:a6bf with SMTP id v8-20020a05600c444800b004148ffba6bfmr6683059wmn.18.1712512687267;
        Sun, 07 Apr 2024 10:58:07 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b0041568e91c41sm14054118wmo.41.2024.04.07.10.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 10:58:06 -0700 (PDT)
Message-ID: <ef8e5f43-5f27-4f0a-acf5-cf4f8281a8f8@gmail.com>
Date: Sun, 7 Apr 2024 19:58:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/12] git_config_string() considered harmful
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqttkeicov.fsf@gitster.g>
 <20240407005656.GA436890@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20240407005656.GA436890@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sat, Apr 06, 2024 at 08:56:56PM -0400, Jeff King wrote:

> And it's not just git_config_pathname(), but really git_config_string(),

Indeed.

After Junio's series and yours, I'm on the fence now, but my envision was
to introduce:

--- >8 ---
diff --git a/config.c b/config.c
index eebce8c7e0..7322bdfb94 100644
--- a/config.c
+++ b/config.c
@@ -1345,6 +1345,15 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_strbuf(struct strbuf *dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	strbuf_reset(dest);
+	strbuf_addstr(dest, value);
+	return 0;
+}
+
 int git_config_pathname(const char **dest, const char *var, const char *value)
 {
 	if (!value)
diff --git a/config.h b/config.h
index f4966e3749..46e3137612 100644
--- a/config.h
+++ b/config.h
@@ -282,6 +282,12 @@ int git_config_bool(const char *, const char *);
  */
 int git_config_string(const char **, const char *, const char *);
 
+/**
+ * Copies the value string into the `dest` parameter; if no
+ * string is given, prints an error message and returns -1.
+ */
+int git_config_strbuf(struct strbuf *, const char *, const char *);
+
 /**
  * Similar to `git_config_string`, but expands `~` or `~user` into the
  * user's home directory when found at the beginning of the path.
--- 8< ---

To allow uses like:

--- >8 ---
diff --git a/config.c b/config.c
index 7322bdfb94..03884fa782 100644
--- a/config.c
+++ b/config.c
@@ -1572,7 +1572,7 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.editor"))
-		return git_config_string(&editor_program, var, value);
+		return git_config_strbuf(&editor_program, var, value);
 
 	if (!strcmp(var, "core.commentchar") ||
 	    !strcmp(var, "core.commentstring")) {
diff --git a/editor.c b/editor.c
index b67b802ddf..618c193249 100644
--- a/editor.c
+++ b/editor.c
@@ -27,8 +27,8 @@ const char *git_editor(void)
 	const char *editor = getenv("GIT_EDITOR");
 	int terminal_is_dumb = is_terminal_dumb();
 
-	if (!editor && editor_program)
-		editor = editor_program;
+	if (!editor && editor_program.len)
+		editor = editor_program.buf;
 	if (!editor && !terminal_is_dumb)
 		editor = getenv("VISUAL");
 	if (!editor)
diff --git a/environment.c b/environment.c
index a73ba9c12c..b5073ff972 100644
--- a/environment.c
+++ b/environment.c
@@ -58,7 +58,7 @@ size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
-const char *editor_program;
+struct strbuf editor_program = STRBUF_INIT;
 const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
diff --git a/environment.h b/environment.h
index 05fd94d7be..c20898345e 100644
--- a/environment.h
+++ b/environment.h
@@ -220,7 +220,7 @@ const char *get_commit_output_encoding(void);
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
 
-extern const char *editor_program;
+extern struct strbuf editor_program;
 extern const char *askpass_program;
 extern const char *excludes_file;
