Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78EB134722
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987121; cv=none; b=ITIK8cYIWzUF88GOEigG7kKRw2HokIJHndg1PZO+RyjwdC5FRuSXDjbKxiz0P86AOxqtg+HENcp8iYQAjhbCspM9PEnXRxlYoJpPB66TLH/C1jJXVYIBIhGDfFpg6EH5zY6nO2a1926nhC/my9YOS68SBHo5OP/ik7ykZVH87rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987121; c=relaxed/simple;
	bh=XeWR0wmtO4NjQ1rAk/XKZcfmohvkzYKlZe+vpbe/t6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvYvrU0vVS432kta4HsKGEkcyTGg5UAhob5kK1Q4q9BK3UY8H/f18Jd+37PZnYTpyvCVxxdb4ELoQiFtxvivVdvIftx6ZpAJtB15fe0XIld6CTXFP1GJIaitL4X7cGlpymAhIEgdpGErHrWPKWdkxo48b2iNQ47mHJNqkptMV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tWGhUyae; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tWGhUyae"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7ce603b9051so2549409241.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 14:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1708987118; x=1709591918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ynS685YhyvgOfkVSvHOV+lumDt8xxP8SNLyW1Hc1kM=;
        b=tWGhUyaeW3pmB93x1jNj4Gmt+imPRvh2EmJEexN/V3pEf1sw2P6bQGBIrb44cBn7Jo
         2UKwJDGAyh4lBSXBURTvm4O7OCVnTt7h4RUAH97Oh542edBv1jXVWy/Gzm3QpGoY5nvd
         ZLeUeVInMeJuS76kzkWZo7mQ+V6R9f463ssNNrrP6z1rVvoKZw636wVGbpYVMRPdOfdD
         4Kw61BbPXbzZMdqYyxci055xHx4gEOiPFJTiLnIGvcIU54noTYQil46f8pFWuk+iBXqq
         gRE6lVkZEbXZ2zayapiT8Tco+6MGJkFEdAC7KsWU5KeXb6QQPgknWQYzy6Ve3xDXLipE
         yV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708987118; x=1709591918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ynS685YhyvgOfkVSvHOV+lumDt8xxP8SNLyW1Hc1kM=;
        b=OJgiJs5YS7WhAQ8LJAicLqErtcfB0vxCCL656QDiTjmU4fcz6Ix2kgkknuMv5DIuOg
         IdhuSKLwCsM/o80tvACbxVhFV9H9hr8nd9FyHiMesXDeE6a129ekFLqlowJPljRhThB9
         nikfjXhZRizTQ/wv0QqN84ZuB6zfkrICdVrdpeSAibHASOmiOgic2v4qXeztAlRI+9Yd
         gQWYx+KXS3q52H9rbTu6ZzFTU6DUKeFe39HhfQDo+m/UTPKM7gz7l0ycEg8VDtCHJgte
         lL4PZD8gi+1h2aBPHzUbCrjrq7RCiiEoFAvOxRJWokmQOzcien3+x8eBh7cVoCdy1eEn
         GZmw==
X-Gm-Message-State: AOJu0Yym6RJjjIslT8Gts5geUET3bh8V6VoDGoYKn2IxWlu0KPqFg6wZ
	H4+mFej43at6dAQlzJwinc+wOaRkFy7yD2MZ93/LcdSQRGn2jtgehhjTZt3EhUstNUZaf8/2VTS
	SzVY=
X-Google-Smtp-Source: AGHT+IEZybv5pb/FV2KKqBnMEbtQo7jKzQqBfz4U5rCyswSrWaB4OMvegJ1xhjrERAakZTQqqISn/Q==
X-Received: by 2002:a05:6102:83b:b0:471:e045:2a0c with SMTP id k27-20020a056102083b00b00471e0452a0cmr4226422vsb.5.1708987118555;
        Mon, 26 Feb 2024 14:38:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p8-20020a05620a22e800b00787ada1ebafsm2968449qki.21.2024.02.26.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:38:38 -0800 (PST)
Date: Mon, 26 Feb 2024 17:38:37 -0500
From: Taylor Blau <me@ttaylorr.com>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v1 1/4] builtin/index-pack.c: change xwrite to
 write_in_full to allow large sizes.
Message-ID: <Zd0S7aUIG1bhGkaX@nand.local>
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>
 <20240226220539.3494-2-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226220539.3494-2-randall.becker@nexbridge.ca>

On Mon, Feb 26, 2024 at 05:05:35PM -0500, Randall S. Becker wrote:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> This change is required because some platforms do not support file writes of
> arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
> maximum single I/O size possible for the destination device.

Hmm. I'm not sure I understand what NonStop's behavior is here...

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index a3a37bd215..f80b8d101a 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1571,7 +1571,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  		 * the last part of the input buffer to stdout.
>  		 */
>  		while (input_len) {
> -			err = xwrite(1, input_buffer + input_offset, input_len);
> +			err = write_in_full(1, input_buffer + input_offset, input_len);
>  			if (err <= 0)
>  				break;
>  			input_len -= err;
> --
> 2.42.1

The code above loops while input_len is non-zero, and correctly
decrements it by the number of bytes written by xwrite() after each
iteration.

Assuming that xwrite()/write(2) works how I think it does on NonStop,
I'm not sure I understand why this change is necessary.

Thanks,
Taylor
