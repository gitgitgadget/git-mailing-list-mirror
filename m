Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659648;
	b=2eFJgsi7wPJn1rqMEnDmQXj5HMkba+UFNQnID5mWS/Gh0bFcPsnTBOKWgMlrxJ7xfP16
	 xha3BmhTMH3yZP+MHvS0mi5DC21HmrcOJKRpbhZkmZNA8HLo1aBk7ptgyB7aVeMASdZhR
	 llpIrD6Olcbtn+oGBoWEookDs5Z5xVdEGdaJahFj0ZoyOxlf2TiNad1C1+IsuhPYpmneU
	 TPe86zgS/b5Ivg5Hy9K0nRHLRMCk3fYlGOUkCaD9BnNXeu0Wh4lbinO2F2XMk58oIRIcN
	 EoB2ASt551dGeaGdsWK0Lfh031JMjiZfT1MAIo7wGT5n/b/PIc/VZAW60TBjghRV5nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NHePWpUfDQI9WO+nQmQb6bqlYLslpwElPytj0Vt0JsM=;
	b=mG+kO94HNbr1zo5IMF5ls6Osr0iLpQAHILXESUlXukwY56uMCsh0N7Xh5DrJe+EOKrEW
	 eVWQSgi4Fyf2pZjlROmzyoK6jaL5qjuTYXPdF3/J8stan8ivhGUO9dr16PkKzyUWy63Jb
	 zF8yHDDhuFb1BV+E14AtLRCltwZqElYLbbiUc8wOV/Hat5ZT4+/7KRjqZkhLCvikqNqb/
	 4wRSnzDQa4Q4iNG1ZjEQfFLWMffDbAuArrxu5lJ3aD4DCexkc+bkR93F2DKSLIjulub46
	 bGKeJl+gxQnAoMGHQgrBTcLWHZcns41iEDrM+q3tDqFD5Ge7AdGfIqqzoxyp0BWPc/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S97QYs8j;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A4B606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 22:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4A4B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S97QYs8j
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4d7034a99a9so2261943b6e.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 14:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659647; x=1794264447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NHePWpUfDQI9WO+nQmQb6bqlYLslpwElPytj0Vt0JsM=;
        b=S97QYs8jBr3QwP95R9ua10Z0nmyXKDycx0X2kFJ1J32IrsWodlYshhriUTQCy0DDQU
         qT4eXptpQF3B5dcIkMKKzsRtw3uRrwAIob53gBD+rpq/z1PafXegQ48d4lo60t5KJati
         2h33ZYFdT3YSjy8YvNE477WO8OsnPkok38iK+hq5LqCFm2w5MfeUF2HwVZCuYumbiouF
         QP1Kz1AaiAIzkqxIccJdyTM4XTB6E5xsS6RYNnH4Mb0adr/19w+dBCnk9zxCHu5qVXZd
         Y0NEXDgKclyywOKvBfF2VEDudedbP+7fS+qhrLLmyQwBA/z6n8IantnSgHVDpF2iX5HU
         agxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659647; x=1794264447;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NHePWpUfDQI9WO+nQmQb6bqlYLslpwElPytj0Vt0JsM=;
        b=zWdwtHeKTxJQ4tbn4lFByF0ezhnA4IBvK3IQzkbxBCwT8o3VIr9POg0kJ773qVWT3A
         Jv4ul9FFtVflCAlKslWDOhHkQvLCqPBMQTAvYsp1B2qGIaLycjuxadzviah15DatnwyX
         0Lw2qHoLcshDb3CK37/11kedTmeEKVq8BdUjAoz970mcM8pJi0KbUg7bnhEuh/d8U6hH
         fIV2Xx6P/5RLhiV/uAjJMObCgK3u+VhAtG42ZHlDyNoKhaHAAi5PqRRTK9PEJOTbd3/E
         x4lxku0oOusXbelA92xMTKvXPMA/Veltcc3LL2dXw6SnLk8KI2+QqneY05c7ZkEmiieG
         2Bng==
X-Gm-Message-State: AFq9FYJwa74RGDpzyIrSQeh6quNK7qwFx8wsdb58YcYRg3tkonxTUcnW
	Ey5y0zsOqq1TkhdkwuxsKNL7ynzBcheei1HzF6t0m6A7/up8VZIunQHj
X-Gm-Gg: AYBFou1+cZJEroCNSBAD8yt/4gBa1r3Jqj3peac+BJZ67C/x8kRv+7Zp2+A2p6FqTRY
	RhnyO55Xal9fs3CjmUQ5W8W3tThPGHIh5xPI/+jMWJ0zcJZsrX2dyWScW4o/wWmR60HZ4Nb80NT
	1EEct1PhUNb5Rg2NC8mhVAvO85unAGG8oK0yp/U4f8HhmXuHFPKuaXAP6BuZ/Lqbuy47Vlpwmdn
	zkhW3eAFlEFKb/0bkeSn9yQOzmBCsxeDul3rZVYNOkbBlUTCEiktxfUOAMJITnNRcWK8m52hLiK
	dkcMNUMPmPWSVNwSbx7vgszLlRzmOfQvJKQ8bDl5VCWma9ehjXOCFJJVO7M1M/emuh3A9T1rAgt
	Ce6xLNbpZMxuFsSeurFDkOTNaK4W+OHT97EE9iEAbnZU0309gRpiSE/X5j9XDuc/G8jOY84VBtY
	Gqx5eEqJU3HIHB3hhLgV2e1zPuEwt33rbF+6b7yg8v4HdihbTxZBRChdpEE74ep6W+ASmH0NioO
	809ZlZYxcZfpGLvICoxznK25ucnCp5dJtxVpNEEmtzzDCZtGVKVQkfVLGIxpQHUwB/HTgl9dzmK
	O2NcrQmshJu8Z0P7KwWohopNeUX7rZiVDWeCzO/lRE7Zey+aGV6mIw==
X-Received: by 2002:a05:6808:1a08:b0:53a:ad3c:17a2 with SMTP id 5614622812f47-5640dd5e078mr7500721b6e.40.1793659646649;
        Mon, 02 Nov 2026 14:47:26 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe0fc77sm8787723b6e.12.2026.11.02.14.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:47:26 -0800 (PST)
Date: Mon, 2 Nov 2026 16:47:21 -0600
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, gitster@pobox.com
Subject: Re: [GSoC Patch v7 6/8] repo: add path.grafts with absolute and
 relative suffixes
Message-ID: <aukQWTUKWwmCQwi5@denethor>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-7-jayatheerthkulkarni2005@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927114420.59724-7-jayatheerthkulkarni2005@gmail.com>

On 26/09/27 05:14PM, K Jayatheerth wrote:
> +static int get_path_grafts_absolute(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *graft_file = repo_get_graft_file(repo);
> +
> +	if (!graft_file)
> +		return error(_("unable to get graft file"));

nit: Similar to Junio's comment on the previous patch in the previous
version, `repo_get_graph_file()` already BUGs if `graft_file` is NULL,
so the error isn't really doing anything here.

> +	format_path(buf, graft_file, "", PATH_FORMAT_CANONICAL);
> +	return 0;
> +}
> +
> +static int get_path_grafts_relative(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *graft_file = repo_get_graft_file(repo);
> +
> +	if (!graft_file)
> +		return error(_("unable to get graft file"));

Same here.

> +	format_path(buf, graft_file, repo->prefix, PATH_FORMAT_RELATIVE);
> +	return 0;
> +}

The rest of this patch looks fine, but I do wonder if it really makes
sense to include this patch at all because graphs are deprecated feature
and also slated for removal in "Documentation/BreakingChanges.adoc".

Maybe we should just drop this patch?

-Justin
