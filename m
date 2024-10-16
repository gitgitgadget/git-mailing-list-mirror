Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA704409
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111565; cv=none; b=csfBBTetaA7t38+kunboyZxEVW4RFa52oXbEACwNccMjH6lfW7A8PzxOzHfW9hqCql+w9z1Vflkil1Cc630UNwND0buAY3QeV2cUmUD5qnPs8aJV0SRealX7KtHtg6oYbxUIsoJaR7jizDpX7fd/VRF+XOMnZtGkwl/SNAAcuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111565; c=relaxed/simple;
	bh=+MaMry+UwWKPiMCLby8+m4m1m8tVjmvEjmdD7CmmarU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr0KYCdNzAnHuddcG/XHd+TyG7+4UhOgFepgOY5apLXublLCaebJU2gsfvzQths0YOmBiUzslB2gKNEs9sDy5Dw5RIYRt6NIUto+/s+sgIP+yUr8Cx2AKYjBITXctvrk97/C7sltzhPX8Jr01Yie9uho7EiiGVMhwDsUv4VM2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DEGhzDI+; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DEGhzDI+"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e38fc62b9fso3591167b3.2
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729111561; x=1729716361; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HGG38w/6XL7eCEhJYfaBdXpQ1NDhvjAkgS23ptqkDa0=;
        b=DEGhzDI+I7wgSxPkHTfMyqv68EoDpWuSVuiKEpVt+fV0YFb5yFx3CfjJU4dDIrwATe
         ZiURhLjmyDrSi7kRjf2P5Z5WCB61OEcSt3uutFwq8l1pX0XXa30HqXZlpRvm0uNFFKK5
         i6UIWdiXVcZ2iwvIEi+lH64Jvuybs2+p1Zu8RGomDgHHY/UJkJDMFbheFTxmzjrNrBR/
         4EBmAlnDF1j5QyUsVVaIXD0VZl4G7AlDqtGW+X+Z23dGyvBU+dFmotiH9FlTTmfkUSyV
         U0PmQvO+QOZfIf7aQ2bBUt/pPmXSL7+y5rvFEZc8qjm8mc2kQ7SVxPnHv7q8gts4kVpX
         rvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729111561; x=1729716361;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGG38w/6XL7eCEhJYfaBdXpQ1NDhvjAkgS23ptqkDa0=;
        b=wlsFELemRP0F15AKNJJ71xUvYgBeVLQd5thEXGFWcmYoZbNoZhffvgESfkR+3D1h1T
         bFLKZXx0JUgbqiQRLHv5Udm0UK7JNZfOIt+pLEbxxM1s1tzzUfDRhC4rxJZPK9OAWXtM
         zjKsaD+W06PB2VzhAZRrwrB85PhNeQXCM/riJJvurcLas8/rg+k38ylR4t8+yFd785gx
         WU1/t0vaes7wikpdmnbjxjIBoVMy9fEHGPmnKBgYki/MJ7grK9GFLkddNCZoqZiLmFac
         ueZkGxvRZCUxnl2laSyeMQb89HLFF+xcOSoXcDMNXIeGltuNLOGx4km79GxbmfYpndJA
         52kg==
X-Gm-Message-State: AOJu0YyZJicMB6L2oNgKtY/U2DzgndjsrpZwCGOhDSd3kvpDYpaeBK8Q
	exy1cCgquVCPYcd5v7U7uCT/eP8sDoPQUDltxN6xmVxYj6HHCuQKRsIhPJT49kYypR8MSYq9ReL
	n
X-Google-Smtp-Source: AGHT+IGP6XKs1apXm7B8Jn6gIF+Pd7qtJZ1WZSgAkr6bH1eZWyQydZQDogBBdegRq3LrzXs61WdV2g==
X-Received: by 2002:a05:690c:dc7:b0:6dd:ce14:a245 with SMTP id 00721157ae682-6e364100635mr146035637b3.6.1729111561369;
        Wed, 16 Oct 2024 13:46:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d4a505sm8447337b3.132.2024.10.16.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:46:00 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:45:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk, gitster@pobox.com, bence@ferdinandy.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 1/6] doc: =?utf-8?Q?update-ref?=
 =?utf-8?B?OiBkcm9wIOKAnGZsYWfigJ0=?=
Message-ID: <ZxAmBsZzwBuEGN3N@nand.local>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name>
 <ad9ee00a2a971522968f95dd413deae24839ef71.1729017728.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad9ee00a2a971522968f95dd413deae24839ef71.1729017728.git.code@khaugsbakk.name>

On Tue, Oct 15, 2024 at 09:03:10PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> The other paragraphs on options say `With <option>,`.  Let’s be uniform.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-update-ref.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
> index afcf33cf608..fe5967234e9 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -55,7 +55,7 @@ for reading but not for writing (so we'll never write through a
>  ref symlink to some other tree, if you have copied a whole
>  archive by creating a symlink tree).
>
> -With `-d` flag, it deletes the named <ref> after verifying it
> +With `-d`, it deletes the named <ref> after verifying it
>  still contains <old-oid>.

It looks like we may want to re-wrap this paragraph after tweaking the
wording on the first line.

Thanks,
Taylor
