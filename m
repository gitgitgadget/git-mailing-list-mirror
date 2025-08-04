Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728631C1F02
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343224; cv=none; b=JyltpKwukLPZlTKzbUEOSMZRFBCOsK6Sexv8L/0nnzVjmERALC3xIQ6b1rmk3mrzZoq/XdfdXgeLyIw678xsAHYrut6BtCBxq8FY1RpXvsAsAoocgC8wjq1UpLvUIbfxmRG69bde41KAHOc0TwU6Mz/fBpWIbOddosFwzHzSGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343224; c=relaxed/simple;
	bh=UqZp+IsnnMC8orAllbFekZBAoHI2lS4Ymy0UTT4/qTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG5D/5b96tmLfO1NtOXbPRf2kDZ4IrGtPlVLTN1X+2k4sIqRHglSk/HhQKo1Xth/DAlubnayol57X7TjetiMrMj5lyANez+d9QjTMBH7I0I6ZXACFVUzjN2xyO+X1b7b8ksurlMs2E3n5iPHroNh67cQjDVKOpG+XqqVA9KpX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=kMMxNdxY; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="kMMxNdxY"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e3e926fdeaso19771355ab.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 14:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754343221; x=1754948021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYt4ihzVtl8ADbVSBMB9lvF+ygiM8djw/WZxiKI7xG8=;
        b=kMMxNdxYowp3jXOpeqf3mxgcZ4kcdpSv9RtCFo7xbYeC7XSDjua0NV/gECTz4X7rh3
         jIaO8il0rnykfDjE9ylI1EaUc3aOGB9ltVPa8vOVObKwBzbfMITC4sdsX5i+PsPyi+u7
         BgvTQ/thNv0nn22wEJVltGc1oS7/1Y+9AVe5HzKpRw22CdnzDZzTA2h55RwJ2BY7zrIr
         8gQH28J7zzgLY+1n3esK9IC75Pcr++8X6Mjx7tgNqEN0sOGGQDqZecLctoRGctwjxUks
         JrZ2xepg9KxjTIBM+iX7SB9LuZYo4M4DwVEjiyC0Ce16rrIa0RRGmhxwFnWcIFeUMDuU
         Ahjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754343221; x=1754948021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYt4ihzVtl8ADbVSBMB9lvF+ygiM8djw/WZxiKI7xG8=;
        b=D19fIMUWTWu/kh1cWgARr2xxGr6ikdY7xUuqU6HSQNFBNRoQQR+eQZAXFZboJOw3dT
         bs4NFbLFXC4COoYXo57qzs6X+2SzhGbqnCcQ1U0jHQC5emUi1DAGugcXC42DWZ+yy86/
         pGSUB7slzSkEPBdQp9ZpUJvpEQ/U0z0bY8JthxY3Dc58FVSUW+mfDugsL/u0izeg1Vwy
         ifo88N8qOHvfKltq+nLraNiaRpwJDIsp9vxjmnlW4AAUltQB/D6LcnXLj/BHUeR/2Fwp
         obolbh9IPKuLWk12zDj6lqvg2EP2R4WBjfDCyx9XAqjvGUPUEpg1JBOsqbloAwovbmwQ
         kNjA==
X-Gm-Message-State: AOJu0Yy93liyAmWMO72WL6XaG6lrZEcccj3FrxL2/4z0hSJ9tiTfTYaT
	SvvGNNwUN5asZZGXxYW3aejrUCdM/+hV/XRnb08TY8YA1sNtH6BUkw2rPgr2poRTQT3qgY/HK0F
	tVIn+
X-Gm-Gg: ASbGncuAocawIEb69m/RflIk4yTdsULb/yUIQReLDdgea8PCe2DCQwtOpPvsE7Xo2LB
	bmeeXWnCwkDFsjl2Mb0/bLJAdc5bh70MTTR5hS9ugnlSf22umaXvz6TtUbbN9NFVFoyBuRkL7uO
	0gZZg5RKyJ2jN2CXNqMvY1jVyi9E4LkfBCRcid7aDYhuP93yMRXEvSIxnWMzZZr+XzHVwbli8YM
	f2juAxUAQ/LjlGY0OFPDXeQIFceFxeRjlvsuzcvtCuflxsMpNol/fpbAJwyEUOkBx/Nk1Q4d7BH
	94kt4h/u3Tdq/6eXo9qvDUQU31ine5v7Ow7lxwTAaAkq5MisULgjQn1pnB8HB7pe+FyXtpderAz
	5qmL3dr8AI/Sb3ruSQafW+H8XsguNYz6ISDQc+rDsD00LYNLPhx9TkR3HbNKD7ILnuViOPQ==
X-Google-Smtp-Source: AGHT+IEr0dbKUsCCjqYYX8S5H5XRWOuQOM3OvpJDp8SnpzharZEHHFd7r9EH9vX2Ph7oLP0JNWElIg==
X-Received: by 2002:a05:6e02:1d9d:b0:3dc:7f3b:acb1 with SMTP id e9e14a558f8ab-3e41618be7dmr169667615ab.13.1754343221364;
        Mon, 04 Aug 2025 14:33:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50a55df2da7sm3485428173.111.2025.08.04.14.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 14:33:41 -0700 (PDT)
Date: Mon, 4 Aug 2025 17:33:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] trace2: introduce function to trace unsigned integers
Message-ID: <aJEnM0IOrgwizw2Y@nand.local>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-1-850d626eb2e8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-1-850d626eb2e8@pks.im>

On Mon, Aug 04, 2025 at 10:17:17AM +0200, Patrick Steinhardt wrote:
> While we have `trace2_data_intmax()`, there is no equivalent function
> that takes an unsigned integer. Introduce `trace2_data_uintmax()` to
> plug this gap.
>
> This function will be used in a subsequent commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  trace2.c | 14 ++++++++++++++
>  trace2.h |  9 +++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/trace2.c b/trace2.c
> index c23c0a227b..a687944f7b 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -948,6 +948,20 @@ void trace2_data_intmax_fl(const char *file, int line, const char *category,
>  	strbuf_release(&buf_string);
>  }
>
> +void trace2_data_uintmax_fl(const char *file, int line, const char *category,
> +			    const struct repository *repo, const char *key,
> +			    uintmax_t value)
> +{
> +	struct strbuf buf_string = STRBUF_INIT;
> +
> +	if (!trace2_enabled)
> +		return;
> +
> +	strbuf_addf(&buf_string, "%" PRIuMAX, value);
> +	trace2_data_string_fl(file, line, category, repo, key, buf_string.buf);
> +	strbuf_release(&buf_string);
> +}
> +

Looks like a faithful copy of its signed counterpart above, which is
good. We *could* use a macro for this, but I don't think we *should*
;-).

Thanks,
Taylor
