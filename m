Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D55613B797
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293943; cv=none; b=qkvmPi5tHLiD8KXnE2lGr+Ys0HUtHU+yW3Rf4LjTBvMB7g9hRINte8bBK3R+vtdt4rcofetyqo/RC75htVdgxGju+ottmdk0X9ijcBBFfvMIulfG9uteIW/ECcrHRafZBIflvKi63/FdJBBLhiMAyXOUJ9EDxRwNwkM+rE93G0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293943; c=relaxed/simple;
	bh=wD5UCUtyu8kg0eJqfmol/ui8+kbtuAjkvBUtpiN3zw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxsLMkmROdvvWPNp3zzjeHT4BumPclqAlpe99T6loRIyg7p5KteBcJ/Fiihqt/8ojxzC9VU7DLuOhadPh40yiViu79mLE20Tf5mpJHfKs67L1rK6BmZd7Q2nbil1tVTKss9D5VE3A0UELPYVt58Mgjd0Ctw7zYQEEKbSOnJa77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfDfIdyt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfDfIdyt"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fbce800ee5so880242a12.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 08:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732293941; x=1732898741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4vgJ29usoUrCdr+BO8460gT+fCzkp+mNVyxv1R0T+e4=;
        b=MfDfIdyto98efKMXO7cDW38VilXrVLUGmmxEO31JUzUBT1lRGcJ798PlGUL49qVVGZ
         13YsQTBFynUj6gZUZm4Iww5an64oHKNlcd0/FiRtbdrjgSC5AB9EwwxjbrwiVM9XBtdf
         zVFSRGohIjo3seLprfzGSpGmW/eC2IHvYUWCGm+PEdBXz5xbJGvZGv81ELDETaJm1bMO
         KAP96T680clPqkqnY4vNGJFoR8fjjlRizdlAShQx/IQfXeQf143UU+awXRST+jqJd9tb
         izJTGC/KNZBhHNnWSztxXkJfo3A/uYc/V1wCgX9zKfhseO6AD49kaaP07auLobTi4oHY
         WUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732293941; x=1732898741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vgJ29usoUrCdr+BO8460gT+fCzkp+mNVyxv1R0T+e4=;
        b=iZrtpO+RX6vHfnSqiCLeQKs7fvqK8vG0ZuG6eH5aV1K88oiKG6dkIGCd+9+sE9UTo8
         ZxD/isXqGkREFsFtiDQpCza1Hyqo23IxUAOSiIM6NQiWfqxgUvbDRyfnYp7BX4IGSyFY
         SWHF3fpzWAL3TpxzhGObcLcvUsBLdn3pVz3R/uvsDR8Prr9py79Orac5sT3AXhqRVFZJ
         duYZ79CpD8mJjCBLoJA6C+heAiZfBwYCXh/tz3UPcAsvqXH98w4Q+BfBJRGlH026ltGs
         HEvHBcJQ1PlzKJcEfs8ywZVX36FOMyfrx+yfaUcKOpfqq0YsL+JUIgnMWwatZ+2QIHkS
         VORQ==
X-Gm-Message-State: AOJu0YwbmcRwypRFL2SuHe9WH2m9ppWWdUqF7YYGYH88vxEaB2Amj4sR
	fUEyYggXNrshRpcuLUgH9FXcKdRYYXPKEKgcrhDPkxcN2P9GDNoCikL7hg==
X-Gm-Gg: ASbGncvPuYSV72NrX7Nn4qHseMi6MBHQnf9GxgunuUoskvktZ5V07MedjG1oUSXss47
	6twTLK7hKJcB5S7g7MvlZhPWKa2eTBTiyY8sq4paL9QOcC2c6mBz3Qb9QsllW5pGBt3JcQv9xTO
	hdGfuoX/ywK7v8uTTAM5ezCHb4XKc/dR3hoWF+Bx6IFQFLxpWZqfShqYp9WL3k040k2CelBGRQP
	gRJg3P1Uz6ebm5DEm8iswQIRkcquh1Z2b16lqt/erKq8Q==
X-Google-Smtp-Source: AGHT+IHnjKKRNmjgNrHZ0lL7MLKS4POJ8n03jP8Xr+DcbH1bvqvibnbfu/fK1LfbDyAj+0Vc9J6Yuw==
X-Received: by 2002:a17:90b:1b0c:b0:2ea:8d1e:a878 with SMTP id 98e67ed59e1d1-2eb0e888646mr3442062a91.34.1732293940555;
        Fri, 22 Nov 2024 08:45:40 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cfe44basm1799391a91.2.2024.11.22.08.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:45:39 -0800 (PST)
Date: Sat, 23 Nov 2024 00:45:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] fetch-pack: expose `fetch_pack_config_cb()`
Message-ID: <Z0C1PxdltxDm8pyA@ArchLinux>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241121204119.1440773-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121204119.1440773-5-jltobler@gmail.com>

On Thu, Nov 21, 2024 at 02:41:18PM -0600, Justin Tobler wrote:
> During fetch-pack operations, git-index-pack(1) may be spawned and
> perform fsck checks. The message severity of these checks is
> configurable and propagated via appending it to the `--fsck-objects`
> option.
> 
> With `fetch_pack_config_cb()`, fsck configuration gets populated to a
> `fetch_pack_options`. Expose `fetch_pack_config_cb()`, to facilitate
> formatted fsck message configuration generation. In a subsequent commit,
> this is used to wire message configuration to `unbundle()` during bundle
> fetches.
> 

In my perspective, we may not separate [PATCH 4/5] and [PATCH 5/5].
Should the reason why we want to expose `fetch_pack_config_cb` is that
we need to propagate the fsck severity to `unbundle`? Without the
information of the last patch, we cannot know any detail thing. So, they
are highly relevant.

However, from the comment of the Junio, there are a lot of things need
to be changed. So, just a comment.

Thanks,
Jialuo
