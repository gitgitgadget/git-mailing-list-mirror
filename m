Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63F2556E
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442591; cv=none; b=HTe4zgKHF7df31JFYyn+M2UlGGb51lTSddZpWkIQ8KEaK+o5VpbAd2qGXVM6lCBiipUtNFO2HbRLy8anJEOY6BnAse7sMF4WKFwhpxWkT93JIVZq6v3D5eTwwTHnlj4YGc/PKDI12yRNxTCPrxnQaKHQnnRrrxnjQBxsbXLuelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442591; c=relaxed/simple;
	bh=YU0/eS8tHZTwMmv0egZOlZRy3KdkI8/WxZAo381moIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuCwxTwwyk0OP3JTsOdnC7a7ANniTSLHlg5b84bkTGSRrv5slsO9hI25m9zB5hjEN1I+P/RMWS4Wan0OhH6XgISn9tuM5wz9oCI1E2FtndwA9DNKVvqyziMrfXPIg/p3HvbNV6qAfE0oMi3kpjVgKGE7aUvpiC2dgpOlSsRjfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=K2SewISz; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="K2SewISz"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d5f6c56fso379357685a.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722442588; x=1723047388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cOr10UocfWiM227Nlc8LM6eXSX27mF54PtQfxmA5XFw=;
        b=K2SewISz6wLLqn8sCKgQ6OAzFdPW2ovZYYSIUja/6pOSjNFK196aBclc+Hz3b+TIZ0
         Rh1+mRrhr+QCvhrJgvoaBBZN1/azFkaRm20IkEZeVQfY2x9ZcVJvduqOyp75kBH52Ax+
         3MY+KjMGMpYd1YNTWZ8yOmCRDsQuDAPDHj1mxQTVA+bmZLezN4RPDkoV8EzcDN5eDw84
         fgfpkQ0INdZjXlgpTE1su/jUuPnXgVp9UNrGb+tr7IzSBDanvtwATv+XixgOgasn6Nvo
         QRP5NZN9cA35i2XsqXBt0dDjZopF0hOHwAKKItkXpdIv9pwLNfKw2wtBEx2HLn2z9MUX
         m9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722442588; x=1723047388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOr10UocfWiM227Nlc8LM6eXSX27mF54PtQfxmA5XFw=;
        b=cOWYQM8kUrx4KH2VRRSCUJJiRgmb3OVy6VEjRA/7mQT7SzIe/lljALee2bs0BaNlbq
         x/aSKYlGLBlfAcTWwHoAo6Qn3U/ccp8YGpQGZnL0unJYETkULHPChFhoRntfyvEdeeCS
         vfM9D/KSq3MW79tY8EdZLKbwLh/uxJ4HMvzp5dkcGHHfLiqGMykfajp61fmVAtavEZy4
         40NrYCu98WMtcf2c31swkFF9LM7lD/vmFArWGvBXyy41rTXaHXGm66dsKsoyS8eTdcU9
         oj6FD0XB2GaLRjf6UgxYppRew4HcozlFWTlBTNqOUyqyOnyrQzff67Q38ICQhbToSCit
         YqFg==
X-Gm-Message-State: AOJu0Yx8AYPt6Uc3YgCs8w3mkAd/ZONXiTZnevYYbkJYj7LcZisKqB+f
	3RFlSgoOBHlDGS/SqCPtpj1YHXXrw77u8iBP8UO+ev1n9zHZ3cHJJJ/Vp8XqpgE=
X-Google-Smtp-Source: AGHT+IEt3rBT4QqMps/qMYNV0T2VWyElrc08odsMF0Pdq4p0vzknye7V7mIsexsQPHTPJg5K24A+uQ==
X-Received: by 2002:a05:620a:430e:b0:7a1:e9f9:d4fa with SMTP id af79cd13be357-7a1e9f9d8b9mr1439549185a.31.1722442588394;
        Wed, 31 Jul 2024 09:16:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b2036sm764762485a.38.2024.07.31.09.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:16:28 -0700 (PDT)
Date: Wed, 31 Jul 2024 12:16:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
Message-ID: <ZqpjV/A9ZVPDiGgA@nand.local>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-4-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731134014.2299361-4-christian.couder@gmail.com>

On Wed, Jul 31, 2024 at 03:40:13PM +0200, Christian Couder wrote:
> diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
> index 414bc625d5..4d8d3839c4 100644
> --- a/Documentation/gitprotocol-v2.txt
> +++ b/Documentation/gitprotocol-v2.txt
> @@ -781,6 +781,43 @@ retrieving the header from a bundle at the indicated URI, and thus
>  save themselves and the server(s) the request(s) needed to inspect the
>  headers of that bundle or bundles.
>
> +promisor-remote=<pr-infos>
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The server may advertise some promisor remotes it is using, if it's OK
> +for the server that a client uses them too. In this case <pr-infos>
> +should be of the form:
> +
> +	pr-infos = pr-info | pr-infos ";" pr-info

So <pr-infos> uses the ';' character to delimit multiple <pr-info>s,
which means that <pr-info> can't use ';' itself. You mention above that
<pr-info> is supposed to be generic so that we can add other fields to
it in the future. Do you imagine that any of those fields might want to
use the ';' in their values?

One that comes to mind is the shared token example you wrote about
above. It would be nice to not restrict what characters the token can
contain.

I wonder if it would instead be useful to have <pr-infos> first write
out how many <pr-info>s it contains, and then write out each <pr-info>
separated by a NUL byte, so that none of the files in the <pr-info>
itself are restricted in what characters they can use.

> +static void promisor_info_vecs(struct repository *repo,
> +			       struct strvec *names,
> +			       struct strvec *urls)
> +{
> +	struct promisor_remote *r;
> +
> +	promisor_remote_init(repo);
> +
> +	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
> +		char *url;
> +		char *url_key = xstrfmt("remote.%s.url", r->name);
> +
> +		strvec_push(names, r->name);
> +		strvec_push(urls, git_config_get_string(url_key, &url) ? NULL : url);

Do you mean to push NULL onto urls here? It seems risky since you have
to check that each entry in the strvec is non-NULL before printing it
out (which you do below in promisor_remote_info()).

Or maybe you need to in order to advertise promisor remotes without
URLs? If so, I'm not sure what the benefit would be to the client if it
doesn't know where to go to retrieve any objects without having a URL.

Thanks,
Taylor
