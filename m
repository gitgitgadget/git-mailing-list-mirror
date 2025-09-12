Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E04258ED9
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697087; cv=none; b=CNbHAUET6zGhINiZxi6Ao3PPiGNL1iq63swLrUvAaj8cYBmy5g7Qs2ZeSoYV2lmWx9XIWDNfdZdILi+u2tNwtwsXFwjSEFku6bi3uTFpLw+Pt9HS9k5gaCyqxc0z06PKgPkB7KuvHFawoZ7jDApcrsg8Z0zVRCJjFzAj00Mjygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697087; c=relaxed/simple;
	bh=qsqeClzFJHS3LIirdQRd1C0T39rWenUQG0rmCOM9Z+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9AWuLMvcN83OzxeOnGSglKsqOcLOJSXzSCekorn1p8seXSAn1MdedhWKQL0lLN+EA7/4g87XfEzPYb02O16IZuXWp4ru5fE+SMTkyOiHUNeoVvF46IG/YLbLB4HoROPyeCmTyIfdTNNMBwD/AlOOrKwlN9DHl1uAupc59OQc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZObwkrve; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZObwkrve"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-750e52fb2deso1802871a34.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757697085; x=1758301885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6CvHl7bP+7TJYaK/m4y6DjrKT+S8k7jgPBr8YIMKr4=;
        b=ZObwkrveu7tCeKJamneLJQ+Mep1blT+HYQ7vxZlunnyx4paNH6h+/dQTRjvU/r9nY6
         B/8DlluYonfHzQA4w+DwzbUh3t9N8GQNKHQUM1A6a73pE10qPiJQ8rt1cMZV9UyKY9AQ
         UMNT0A/6p25A6IY+ymIGcFMDJMvED9qnXTGE+pewFzfsHgpCTaFvDtSbd4m6RPlyrKEW
         sHKVaziTjYtcj2jhx/nFEvMjPKxWBfF5/1zFi6ugwVra8uvhiEXLz/HNiFKWcgLMgZAi
         d+sGQ0HLv1VlFic1liuUAqTCkRI6JshuukKznzjClWC8oTgz/N5V6Ttq01GKHqqYTA7e
         tfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757697085; x=1758301885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6CvHl7bP+7TJYaK/m4y6DjrKT+S8k7jgPBr8YIMKr4=;
        b=u+QJN6AZiUzarwSC/wc3BOQJzK5MHoyC0++bF5MMtW+vDIHBVHx8TmXXsAVa7cl0hJ
         kq4DSBICVCR/3xI3lSRJ6V7nNQPcm2uZxPIn+v/JMD6idqH04B2jEoHvl+CzM9vYN0p4
         modKCoDOkjUuH968TdDzr8yWpuqRW1e3Rexl7QQGC8APZuqO7qN4iGBEk+xzqxMgHhIQ
         Ebc41xR7GnyDGiqkcZtpnZECH7wLQ2ECY9XKo4BjxU4y4P2EbYueeJkXxKVdBjQGN2r5
         /BPlV2cBpmGaKpiU7QQwhRilG2S7pYEmCPlWY2NBMg2HG6KhsXNrq41ONp3LEVTSGJud
         Tr9w==
X-Gm-Message-State: AOJu0YyaSLQtmo2RgRudneVI6r9dHhF1+EyDTb+sxgFcMDrK3ZE8TWym
	dmy/xGx0Ae6A8MrPgU2qN6PLoVqrEY9U0Sz8W8HUl4aFXGG5gFCcaTs9N2ph5Q==
X-Gm-Gg: ASbGncutny4lCpxn+txMu4AcJkdr+d6ydaf6I/EgzwE7PTfy29lDRohwBURdxQh6dh6
	xWELRX9ydKNfNEyZ0AvZp/R8E11B14+oyOx4eM3vG5+SvqGtb8h8oh8JaF50ktDXuKdKWhChOsI
	B0l/NHtDxj/D7saKvGwwcSh49hpCSMcvG9cGw3GEYumESfJ8pSa42LWF1gXvUBflY668LKATA+S
	+XDtRLpFQHYw3CC+jA5mpmC2Atf+uvSElvFWaQ3JnBhGE3hA5P+ADKtq3g4SXgQj4UmjwIYNpPJ
	vwitEYTxtHoy3UsYLeBqPkEW12afGE004UqM5PzgNKB/M2h6vZ8jC/DEcz32WdzSvf9swYpA22F
	i2CcS3grP/6StxBxCB58ygxizybY=
X-Google-Smtp-Source: AGHT+IEeiKnumie7V0UQwJbGuqfaF7f4+ljhg/oK7V5nwecJLPUZ86yjNvNs/5wKavC5LiZO7ixuLg==
X-Received: by 2002:a05:6830:310b:b0:745:9564:bf0c with SMTP id 46e09a7af769-7535481d512mr1964796a34.18.1757697084893;
        Fri, 12 Sep 2025 10:11:24 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-621b7d220absm530600eaf.16.2025.09.12.10.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 10:11:24 -0700 (PDT)
Date: Fri, 12 Sep 2025 12:11:23 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] bundle-uri: ignore bundles without uri
Message-ID: <5hm6qdyn5ifs2kr33nwuc67qa3vdgis6w26rlvicrdzznzazzt@uytayxq5r25n>
References: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
 <20250912-b4-toon-bundle-uri-no-uri-v1-1-f4525a406df8@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-b4-toon-bundle-uri-no-uri-v1-1-f4525a406df8@iotcl.com>

On 25/09/12 06:46PM, Toon Claes wrote:
> Bundle-URI can use the heuristic 'creationToken'. With this heuristic
> each bundle should specify a 'creationToken' next to the 'uri'
> attribute. But this allows misconfiguration where only a 'creationToken'
> and no 'uri' is specified for a bundle . Because Git expects each bundle
> to have a 'uri', this causes a segmentation fault.
> 
> Harden Git against bundles with missing 'uri' and skip bundles which
> miss this attribute.

Ultimately, the remote Git server is the source of truth and bundle-uri
serves as a supplementary mechanism to retrieve objects. In cases where
there are errors related to retrieving objects from the specified
bundle-uri, it certainly makes sense for Git to warn/ignore these issues
and continue on as if there was no bundle-uri.

I'm not sure though if this should extend to client-side
misconfiguration. We don't want to segfault, but maybe we should return
an error indicating the misconfiguration instead of just papering over
it? At the very least, it would probably make sense to provide some sort
of warning that the bundle-uri was misconfigured and not used.

-Justin
