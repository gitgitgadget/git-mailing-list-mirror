Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5E283686
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001239; cv=none; b=G1305XTUKJBh2OcW4icntJpfzg+J1FtPXrRErL/vcsJ91abgKCqyqrgN/0jnh9Wwk7IRICqZjtNRzRdqXWd1fgzSp2OWbBADsflwSnhCMzTQcC9qu/JOJCba/n51yWeXculn5WLLlBIu+aZguISBE/cYjBIuZmYknjexiJfm1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001239; c=relaxed/simple;
	bh=8h5bluIYVV71NEiPbP+6N0vKX89qL64sGYb/uDOfXiA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7uKN4rAU8jEr6kc9RIPkAvZzV2DPC2yHidVCdmDwmMzRWcAZCrwxLMhdUVUYguo5GqLbO+NEGvNtLGt133mgpGW4Io7XT6l6q3wm9aTUdnheOkFM+IBL5L4cql+F0odfGY9165hS1Ngio0JpK7aIr3mSjWVPbZ2xXQIAwwRZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWUo0wOz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWUo0wOz"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47928022b93so13993545e9.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766001236; x=1766606036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCdSqxztQC1mRPXTn9NrFpSxzRoklqD4t2vhX+sNBb4=;
        b=AWUo0wOz1h7+a4Lykuv+KpTbwcQx6tZZNgupk1uKejDZhZ96DtpGLhoQ+Bv4h4lIWF
         kXmaZJGD5Hzpj7x56iS5R1Z+1hBFot29g7X39akBtut6hb/DGQvnRR07pM+po0VhtHxo
         /yF7rIB/fHjbV62QoNDdbos5kOdbtu3OGuRX0WmUKShA1Y5ARY3+KDVuLga5Zcl9L/Zm
         ddu5yN0wWAufb3kJzg7Ii3hhVVup6Czf/DCjBu39YxyioVyLDdGizbX4jpHvESPkaEeN
         XV8DdwbJTJfVx6JApCLNwe2eLgoiHvRXMtw3MsAVSr6jb/yWF5dwVbMiPXlxT/ABe6n2
         pW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766001236; x=1766606036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tCdSqxztQC1mRPXTn9NrFpSxzRoklqD4t2vhX+sNBb4=;
        b=fxOKOtAadv/rV2yOaf5bt7znTkjs313Ln78Etpvvm0s5MSFZBJxwlKoV1Q1eWDr3Ob
         oNf/WtUqLA79jnqh32xD7pcn1HyE8jw3wPJHArAtLph8ePKxA9EBtMtSsmYftBLFxjio
         mQTQv81qF1VP13u+ivg7BPHa5YlGg7MBv/gG82FLCiXOxKwTW5fHDshvdg0N4UR4AP1a
         IZAcTWGVBlfp42dT3OSIvPOjGBexEdyyN8gZUiDN6PbwjgpHMyUfUAJDdxpVGwknLRJ8
         cMfs07apB1LD/36WhZch2jX/0NHT61pQFuRjsr+ZkBBEvw629alT6Nzo75IYkmoHGJvS
         UjDQ==
X-Gm-Message-State: AOJu0YzAH2rzXOmRn+LMaO5WCoi3usX6ODcKtRdP2wBCcRuHNbCEqTgN
	ZsSb16azNpW1zUwL+NfsmAt8eoMNt1SCz1wWcEtZY8NkntSXAvRh/sfabUFrpynn
X-Gm-Gg: AY/fxX5d0n7Necr9DLJ9SiPehylDEqGTvlmwlPn/hB4k2q6nrc2QBiG3NcYOmuAN2nf
	IPomPrT3/9MN6/go/PlAgUSGC0QVUJ4zy77dGIWHADYYACTYOhiItiL6Q4EN3DVHC3FzICqrtW6
	BjZ9MrIcjtO7yRHsDuaEF8AvwLvRfkaVkM19c1+FVRIfBhnTlH47If/mH4lAjgrlzBYPgmBDfc+
	+LKSUSwIpS4PofPYxYW9W6QpXGVhVoUkrNFHT5aaqlGMACbIhyfEmsI7CmHJVfYspTd77Qls6V6
	nzfsDy/TZ8kj91blomfV1MZ22Di0j8kLHwQpnFxtFAtDqJMB0bUvm3fw06G8eWnx2nFtlu+/NdG
	h7k5NwEOTmnRWNy2bNOQp5c2VFfdKKATCLfV/v/TdP6PeGgu25NEorDBXS/P1uFg0wx0I8sfB+J
	iw9mkC/g7raVSvTA==
X-Google-Smtp-Source: AGHT+IE98SH0epl4ZFh2CGKmrQHZVw7gZpwl5nRD3kFEpdnO5fy3zG5micGJRTC+NTgFC0Hw7ggEng==
X-Received: by 2002:a05:600c:1c8f:b0:477:7b16:5f97 with SMTP id 5b1f17b1804b1-47a8f708f26mr133549845e9.0.1766001236379;
        Wed, 17 Dec 2025 11:53:56 -0800 (PST)
Received: from desktop ([194.127.199.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324493fd7esm710306f8f.10.2025.12.17.11.53.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 11:53:55 -0800 (PST)
Date: Wed, 17 Dec 2025 19:53:54 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Subject: Re: [PATCH] docs: note the type of core.attributesfile
Message-ID: <k47im7xsyy22gfbkyl733l6h5hsamiix2jibc2thcw2wiz3wn2@5oig4uhbmmuk>
References: <20251217195050.24837-1-matthewhughes934@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217195050.24837-1-matthewhughes934@gmail.com>

On Wed, Dec 17, 2025 at 07:51:10PM +0000, Matthew Hughes wrote:
> ---
>  Documentation/config/core.adoc | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

I forgot (again!) to signoff the commit, I'll do that and reroll this patch
