Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE49C199DC
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712800; cv=none; b=NC0iws+dVQMTXcUJRgqwNq1+Mc1//iqNZ0iFZYwkEvS34UZqKBVBOlf7izO8XRAbiIjj148+MlodK+vtWbPDoLqG+o2L5TB1Eoa0vEbj7OR1y45Uan6mWK4UnoOynEWUmVqwGb/wUS2mDwWefi5+2Gvun01PRGdA7MNPlwBpd7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712800; c=relaxed/simple;
	bh=kQ5+cj8Ur6yql+96xTzVo7Iw364Ycbz7Qwknx041MAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqgpqXEGUtKlOKw+BHOMq9LZU/RpmYOgkI+GZxSMA1rqluzzSjj++2VVuYs+BHfrUP/VQkcPJj4AsL0DtluwQJfzd8WOb8S91bwSbB2gsbh6Va2hTKZgcZOsqGMCpHb3mAsBgGy1kOg3BenkigruFjIIbafMGHJjdn2N/b9sPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RV+jGcXu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV+jGcXu"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e27940554so3046605f8f.3
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 00:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709712797; x=1710317597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FocOTycbgLptQFisglwrOwJ0JiRIMaK0KsTbyq6AF0=;
        b=RV+jGcXuHuzfPdwz3yQtYFpzjtMQO6HuJddXc7Az15CbjywCNc5G8xV2z5EF017wh+
         b04BvKyeVcpzDEscOVtuXadaxqlQuLEHfehTC9Q3CJ0Y2ow8Zv8UbEs6NXmLezlvf0K9
         1rxlj4OINYxa7FMIOjm+9Db7D/DMuaa3W5Qa8IYjWRrHGayvA6cLvGSiqPOt+CjlqhHq
         Q/iaTHU0P1H+Fv4BhUSgMeL2eWCGAurwn4sswHZ+zsl3rDYTogqWn4EOIEY9CejlauXr
         eEpPngZbrGIt+aaO+hEhsLFFtyXRoVcTPorFNXDJyImwzOPFA1pZpeh3m2TqY2SMQ6DH
         AUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709712797; x=1710317597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FocOTycbgLptQFisglwrOwJ0JiRIMaK0KsTbyq6AF0=;
        b=stKkcvYICBbxPyI1G54HGg6evkW8YOrrT/xmDdjScSC7cRNRNrVabXy+TWtenWQp0b
         RaIdxXMngh7sDnmGm9IHZg1hTgEA3twQgjcosnJodv/HsxrqcKL8RGMsSWO5OrFpdhj2
         BEelASm4wuiU499K93rPipYc4bDqtXiFjAv4a5DXJ9NIWxi3fQq3V9sJmeA3CieexeoW
         aYkTl+hYO/eHWIZnhipOmzU4ewKLUv++y93eWnWRikBbzbBkySNuEU0NHjpEWPm1vgv5
         bTyMxz7XPF6PdfrdBp5VqvbhJvZHN1ClFiktZV9iIuXRgk0v6HG040onJXuJp98pqOZk
         5qcg==
X-Forwarded-Encrypted: i=1; AJvYcCX0deUc/BqFNxmclWGXomioIKUVgaGv/fYZph5LWtKI3NcbeMgTkqs3ENzyLqmJTo0CRI63oI/fq1p6QZzbrRKRMWQt
X-Gm-Message-State: AOJu0YzC7tLuhC9rTxzLsyMDsk7gojCKOuYPwfEGty+5o7Ub223p0y8R
	I2ValEhTUu5JnfEZMKFcG+067jBXiJZiAyckYnCvWEjsNth8+g1ALQHaNHgeIec=
X-Google-Smtp-Source: AGHT+IHwTfbe5AIz60KSKFk4nkJawH3epgKsA854LWOueE6av5+O2Xobk3QVMLMJx7CMSO6mE1rItQ==
X-Received: by 2002:a5d:6283:0:b0:33d:1153:f41a with SMTP id k3-20020a5d6283000000b0033d1153f41amr8783458wru.20.1709712796852;
        Wed, 06 Mar 2024 00:13:16 -0800 (PST)
Received: from [192.168.3.191] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id u2-20020adfeb42000000b0033b483d1abcsm16769311wrn.53.2024.03.06.00.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 00:13:16 -0800 (PST)
Message-ID: <10042df8-5d06-47cd-9202-ea6965f50784@gmail.com>
Date: Wed, 6 Mar 2024 09:13:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] Make read_gitfile and resolve_gitfile thread safe
Content-Language: fr
To: Atneya Nair <atneya@google.com>, git@vger.kernel.org
Cc: gitster@pobox.com, jeffhost@microsoft.com, me@ttaylorr.com,
 nasamuffin@google.com
References: <20240305012112.1598053-2-atneya@google.com>
 <20240305012112.1598053-3-atneya@google.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
In-Reply-To: <20240305012112.1598053-3-atneya@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/03/2024 à 02:21, Atneya Nair a écrit :

<snip>

> @@ -830,7 +833,8 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
>  
>  /*
>   * Try to read the location of the git directory from the .git file,
> - * return path to git directory if found. The return value comes from
> + * return path to git directory if found. If passed a valid strbuf, the return
> + * value is is a ptr to within the buffer. If strbuf is null, the return value comes from
>   * a shared buffer.
>   *
>   * On failure, if return_error_code is not NULL, return_error_code
> @@ -838,7 +842,7 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
>   * return_error_code is NULL the function will die instead (for most
>   * cases).
>   */
> -const char *read_gitfile_gently(const char *path, int *return_error_code)
> +const char *read_gitfile_gently(const char *path, int *return_error_code, struct strbuf* result_buf)
>  {
>  	const int max_file_size = 1 << 20;  /* 1MB */
>  	int error_code = 0;
> @@ -848,7 +852,10 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>  	struct stat st;
>  	int fd;
>  	ssize_t len;
> -	static struct strbuf realpath = STRBUF_INIT;
> +	static struct strbuf shared = STRBUF_INIT;
> +	if (!result_buf) {
> +		result_buf = &shared;
> +	}
>  

Question about general style: is it accepted practice to override a
parameter of a function?

I would have written:


@@ -838,7 +842,7 @@ void read_gitfile_error_die(int error_code, const
char *path, const char *dir)
   * return_error_code is NULL the function will die instead (for most
   * cases).
   */
-const char *read_gitfile_gently(const char *path, int *return_error_code)
+const char *read_gitfile_gently(const char *path, int
*return_error_code, struct strbuf* input_buf)
 {
 	const int max_file_size = 1 << 20;  /* 1MB */
 	int error_code = 0;
@@ -848,7 +852,10 @@ const char *read_gitfile_gently(const char *path,
int *return_error_code)
 	struct stat st;
 	int fd;
 	ssize_t len;
-	static struct strbuf realpath = STRBUF_INIT;
+	static struct strbuf shared = STRBUF_INIT;
+       struct strbuf* result_buf;
+	if (!input_buf) {
+		result_buf = &shared;
+	} else  {
+		result_buf = input_buf;
+	}


>  	if (stat(path, &st)) {
>  		/* NEEDSWORK: discern between ENOENT vs other errors */
> @@ -900,8 +907,10 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>  		goto cleanup_return;
>  	}
>  
> -	strbuf_realpath(&realpath, dir, 1);
> -	path = realpath.buf;
> +	strbuf_realpath(result_buf, dir, 1);
> +	path = result_buf->buf;
> +	// TODO is this valid?
> +	if (!path) die(_("Unexpected null from realpath '%s'"), dir);

In fact, this is not a null path, but an empty path (null is not part of
the string).
By the way, shouldn't this be an internal bug instead of a message to
the user?


Thanks


