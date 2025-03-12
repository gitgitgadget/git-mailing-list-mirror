Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E2219E96D
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817837; cv=none; b=aTgmdSMf4/3BoJQC8vd3OtgrsuFL93m9NyYMUuJN9kcrw8gKnBIqfy3mTUxHJtKJvVYYgcDAtK57G8xbOS2yYGl/IEiJznDtMhYgLsgCPsLu/PcSAFUA/ADqTx2dEgS82mr47A803uOPC2lEfscLgKhqirKGIrg4UFG1KIaHw/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817837; c=relaxed/simple;
	bh=4Hl3rdJy3AkrDBL6Er2SD55jnDOtAe0ufEXQupEGVvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfDIvBXPFYlTrtFVRDK51Q8ur2G1F3BEekluYWCmmPknaFrQCNmChlfUAYHKci0ar3OYfQIFcSzsvNpWFHlWxoxcSh/WCMck7FMjv4YzPz2Aa4GNBIUcOsZJPOXEhcR0YMrAzqhH2x3FYy8c6r6b9tcq1AZgfqKHuK1OX+AMpPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KLmnXYd9; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KLmnXYd9"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e53a91756e5so361260276.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741817834; x=1742422634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSdwn8RsdZ+4ov61MKvV7tFZlIxNR1TLCbIHjhqVhec=;
        b=KLmnXYd9R7+QAZnm2aI4xP5Juz/DhLYj0T02JBeRZ9uhXk4T//oZOXrp/AsFrLJz2C
         K8L0++q7nOEirLKEHwMcVgOGiGRllbSavSI6Tw4Kkj/wGLGtHeiciafSubmmT+Uuilnv
         vTDor34gu640ez/G8laqm/9sB8IJwVQLV31xg+1nFy2MZlk1YgFpcSIfUFfj/oNg2KHi
         cO+j9QjTzqLyrY7oPMkmTiTvImyqeonsx09wkaUOlf/HxUEoXezJoLjPvBOKab2teZdE
         oBfhRLPHhheUBkPBalpl5fSjtGaiFNmOyeUxeL0vsoZ1iFUSHUWFdX+pTL1AMCFbirYV
         oREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741817834; x=1742422634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSdwn8RsdZ+4ov61MKvV7tFZlIxNR1TLCbIHjhqVhec=;
        b=J7zwxYGWNgnjguLssNcSE6RmGra3cxy4WoSjjsTwHpACM6pfxLZnP1WQ2xUx3WNOzf
         g0UVoyD9tD2MW6c95ehm9tK3y6EwEz8uwTrfhPdTr2BSxWeRnQeMocnut/tmGsMbxRCQ
         1EWxpEPtJheNLddlzudqHcI30Xb9qZ2HPiKh3xqPyE8h8aVc//vVXju3fvqQ49drYHgH
         MeGJ+0yg8EBte9qpPM+IyWxKs92AQ1OpHAEWu3VYoaMJBSR3ZLyisO+AtzsL8zvARQGD
         Rmw3CuG15czuwblAsN12o5R3g3Pb98oYbF/jDbk9K8p/F1L/N57xKp5ZD1V8m6hJqdsT
         ozzA==
X-Gm-Message-State: AOJu0YycL8F9d1lPjCD5F+7s/ItQJFqC2NitecEdXvo08o2Sj+hhp4ng
	k2zovRzXjcw7Blo6Eqvj0GXCG1cSkrs/qZEFNjmeHnCxLf6P70yrpDV3Y4ZRUvkY91OTLG97+JO
	gL3E=
X-Gm-Gg: ASbGnctylikPGTFkLQIvmsmImJ7G1CYZ8OLzExRXhzYIZUl09+Ge99X7LHPHLSIqFe4
	+TYk6ZyRANbWhgNWO/EnKAxggQY+7FR92mZX31cQNlvBkrD3OpkLGaXDksfhLTwo3PeiZ4oDEES
	JIJTQMcbHMGXryDgnjWEvFjHmECIkKGEuwxJGq4elfhcyK5VeUBJFpx7+LdQcdqsBntyVDcLntX
	/21HIW+e+Sm4rbT8ExcptnjjIOyEYeSweGoGqBkIzOSPhpHp1/lMNPt2Xog7CB3giabhlh1uWTn
	ANjm3W5aWf2MBrNBLvyuQG7eCnByXzwwTx875znz8DDJ9Ip+bvAuNWpTZU6HcgnHwXlwQ91vFHM
	dwnQDjrJFfPgHy9zh
X-Google-Smtp-Source: AGHT+IGL9636e+Bt2umyDtza5QimbNrkZMqj91MQ2ekVYvI8aBxnML/66wKt29tcxHzuCxF9FDQfXg==
X-Received: by 2002:a05:6902:2382:b0:e60:93ee:d94 with SMTP id 3f1490d57ef6-e63b522db9bmr10769805276.42.1741817834430;
        Wed, 12 Mar 2025 15:17:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e6366b6bfcesm2901836276.32.2025.03.12.15.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 15:17:14 -0700 (PDT)
Date: Wed, 12 Mar 2025 18:17:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ivan Shapovalov <intelfx@intelfx.name>
Subject: Re: [PATCH] doc: centrally document various ways spell `true` and
 `false`
Message-ID: <Z9IH6G7BnM0blOmH@nand.local>
References: <xmqqy0ycz9dk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0ycz9dk.fsf@gitster.g>

On Tue, Feb 11, 2025 at 09:20:07AM -0800, Junio C Hamano wrote:
>  Cc'ed Taylor, as the author of fb0dc3ba (builtin/config.c: support
>  `--type=<type>` as preferred alias for `--<type>`, 2018-04-18) this
>  patch butchers.

Wow, this is a blast from the past. I think this was one of my first
contributions to Git, and indeed:

    $ git log --oneline --author=Taylor.Blau --until=2018-04-18 | wc -l
    9

>  Documentation/git-config.txt     | 4 +++-
>  Documentation/git.txt            | 5 +++--
>  Documentation/pretty-formats.txt | 8 ++++----
>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git c/Documentation/git-config.txt w/Documentation/git-config.txt
> index 3e420177c1..76042581ec 100644
> --- c/Documentation/git-config.txt
> +++ w/Documentation/git-config.txt
> @@ -213,7 +213,9 @@ See also <<FILES>>.
>  +
>  Valid `<type>`'s include:
>  +
> -- 'bool': canonicalize values as either "true" or "false".
> +- 'bool': canonicalize values `true`, `yes`,`on`, and positive
> +  numbers as "true", and values `false`, `no`, `off` and `0` as
> +  "false".

I agree with the rest of the patch, but is this true (no pun intended
;-))? I thought that we might canonicalize "yes" to "yes" if the value
we are asking about is already something other than a literal "true" or
"false", but I don't think we do:

    $ git.compile -c foo.bar=yes config --type=bool foo.bar
    true

So I do think that it is worth saying "you can spell 'true' as 'yes',
'1', ..." in the documentation, but I don't think that it is correct
that we'll canonicalize "yes" to "true" in the case described here.

Sorry that this took me so long to respond to. I think I must have
missed it when you wrote it and I only noticed it today while cleaning
up old emails.

Thanks,
Taylor
