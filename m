Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D5A373BF3
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436585; cv=none; b=tFkK7044O88AB7omc+P8UMMkXs2GMhJST+M+UBLFV2fS5Fq9elmY10/oaN0EnTApgI149CI8nfnwZ9VaYNia0sOGg6tlMGbp2OrefiGSNPdb7EqftNDiT+4PlVX8qJepI1Fg+iHX9uU8UpWtOJQOf0BvifsCXHbPL6oltRqS+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436585; c=relaxed/simple;
	bh=9T1LIVkkTZcXVkA4/b13kkFZaXgIqGVjuHMDRehSdio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6sJsbs7WzgrD9OFBMuv+SjYhxdEOm5ZXcYT81SqTFR4UNnj6jy15qXMCc6L2nv66CubRP/7DYLuroxYfUxl7kC7Qlqo5oo/KmujcTmcseI/7rf7wt4lRgGLCKTmxrZOagJbaUBFEkyKtLhnxy8CJLBWRcwCbKJWGqJNvmqNc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRwcV6Ds; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRwcV6Ds"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6b554044fso3287616a34.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783436583; x=1784041383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LY++dNc/GOYD7pztHeo7D5SJSZPzV2HGTezml+w0fb0=;
        b=qRwcV6DsagNqTgm9xhuunDPXSNpSedCbCiihq0URVXsp/68manQstUUdIlBt909qr8
         gzmuKJY2LMWxtpHEdozcE9ShXiCI5Qygjgt7XVNyhrNJzj0QPgjcWyofIOEe6aeWyyzz
         SjVz9jUr9MVQJIE+TXGwBDDqiaUWSvmmKUwibFKHBJfNMkNUIXNkh0XKFDJP4qI5QjGN
         JUW4u9BZHbi0KYD8DCdUJFVBFBn+NJYSbDpvqB8EkcyFxItQ0G4BDJaBeo1V1Fu/6Q0v
         VVvZylbfpdgVvcoqxvKEX4sTcjT+r7o6Pi7jcDbzU+70P1rXsoaFVkQ4HAYh9uM773Tr
         fbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436583; x=1784041383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LY++dNc/GOYD7pztHeo7D5SJSZPzV2HGTezml+w0fb0=;
        b=H5JjgidaanVONxCjJjQfZCCw9lhVEQwd1dHt61xZ86YEnOhYZ2zcwq0n9heiVef4qZ
         dnVjENX35kCW5/8py5xrDpGi9wceaDQ+jGv3oR5LjFINZ0aiT1GkW3/oQXHVM05oeBbn
         ehGUeNAWBgzRseuM1lVHrd+eFdM9kJeV14HqsSi/Z7Bns00hfbihHD4F4ea+p0Oh0ynr
         kmaaxrpRtpiCmLKZXfgnzqCekkW/yOz1xC8bzKmCpIvARAMaGrCe80IT+qMrG4x+hMR6
         uicHG5MbUOg7AmU9kiv01Of3RmR5Lgv86k6W1j8tO4omBm7t3YqjeDMoYgSgpM6RK31q
         AP/g==
X-Gm-Message-State: AOJu0YyR6xbTEZ++KHoq77mMvIRWNKjzwhu6aRgwPylo2E7V8KQoBvSg
	Egsv31yBkErUCuJWnp9tWW+J005BTRix0IN4VxEXumO23o7d7+ZX+8x6KKp4zQ==
X-Gm-Gg: AfdE7cldkfXej/pATkcE/WNiDNVtF+mX5NlMU6uf/jrqywfVw7mBfQtxH/3JG2a68M3
	C8Vfan/ROnagrVueIyd5U3iVrLQYPZiwxphnQZWLZu0kB9o1DE38IR31uJcCRg4LyvFBnEFpCOT
	C2mgBIGckrxp072gPehApWsNO31tPVo657HQ6w0/+g1qV6IDpi29D9uKC2+77mUXBaabX8m4ZHt
	MFNkIclZBoh7amGgm6xs0If2LILEYx5DC8BQ+u2xrlCmP8N5x2ooGrLcrhdiXKekw+Ovd1BbxMI
	ZtecFGPweUsDQlrmOFVAygsVCilLRYtO9AGmWWCP7+qcBWLNyXyTwcg91wSBv2g8aZedm1EW3o0
	nRhUo0ohDtr8T8x1JgBg267h8hdbzbyOl/EYFTB8ZL+D9Kb4IjcCyxmiSKRuiHX2XVZE4bT9jiO
	ikbLU/3w==
X-Received: by 2002:a05:6830:3747:b0:7e9:e860:6f1 with SMTP id 46e09a7af769-7ebb23b17a3mr4247574a34.32.1783436582875;
        Tue, 07 Jul 2026 08:03:02 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542936e6sm14133596a34.5.2026.07.07.08.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:03:01 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:02:58 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/13] setup: split up repository discovery and setup
Message-ID: <ak0U46-J4qmwL2FD@denethor>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
 <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>

On 26/07/07 09:21AM, Patrick Steinhardt wrote:
> Changes in v2:
>   - Expand commit message to talk about precedence order between
>     the "GIT_SHALLOW_FILE" environment variable and the "--shallow-file"
>     command line switch.
>   - Remove a now-unused parameter in `set_alternate_shallow_file()`.
>   - Fix a typo.
>   - Link to v1: https://patch.msgid.link/20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im

The changes in this version look good to me. Thanks.

-Justin
