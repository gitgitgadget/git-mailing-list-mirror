Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4828C2AA
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298489; cv=none; b=uBOZ/XBLKhkZt/AZluz7e+CV47Bb1shKIh6VYBbRshiZoxws2zS3Se+iGmiKyHcottrbc1qlp3mGXCUXLvgWJ4sRNDmgCDaeoM4WjaH0HXK+vhUumkOVb9uvOIv2mGlHzR5YR6inHxm1Ky5++5eeUvRqiVO10a3twLPYNzYlDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298489; c=relaxed/simple;
	bh=yWpdq7fTo4ofmxeUDeNpW8f9I3i+PY8qk9JIF2k2c50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r+UUBZowPfLy0y5JyGRYCMkD6nP73vO7fDsAmSHY7mXOQ2HIf2oiq2Da5nTZ59hAFNQMgbS9VuRrHug9V0WNLgn9hX9g0QQH1SYahPaV0sy6DiwFdZyYqLsrefiOO8qSi9BCVFl898x80e4GUXj78yuPAIWyWt8EYlxBI10DyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyYrGgKf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyYrGgKf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-236470b2dceso17428455ad.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751298487; x=1751903287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HZQ1k1TIGYjHBySyiCuVN9uZ/Jt/MNdUcCPrzMdsu0U=;
        b=LyYrGgKf0Z1+0pcoENLyd0J3MpQTDoxFKSDIVLx7I4HpmzxPjPswjli3y/Fwc8UWrV
         tplqNjtHWal87n90o2inFX6njrWYil149CG21QkRZe+phA9jrVEY1Dh0bdWTMYjRGDTX
         bHP9MNcM5v3uBrK/1OVqQOmgxNy7vUxEanz2KKksMAO6pK3Qx0Okg2DEDyE8jGbL9e4K
         6tljIx8gz2+DL9hL824kcXJHDOd/xcFAJ4z/JNKcXsYbSvT3+WHMEyirSdSa+1X572bL
         INiIbXXtYCXkWqFRbtERyO98z9AVHqKw7yuB4dwsDHhgEP+cVqnfgv52Fs+u77aLs+KU
         aY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751298487; x=1751903287;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZQ1k1TIGYjHBySyiCuVN9uZ/Jt/MNdUcCPrzMdsu0U=;
        b=lYJBJ3LnkUKphcEbp2FV5nrKqcRWXIz3ZDBmNQoVP0K9unGZa1miU2wmOUEm+A3KFw
         c8W1VFiRVKuzZfRmfKiHnIEchlUTvj+64vXorddq1aWXZB/K93AN3gWI85W0Ck/BvZZv
         6iKRskDdZk8YBY81TmnykVUC6fwJGLUwz1mBcbPsgYggMiLTSaVOPmi4wiMQ9a3xWYRm
         RtnzEWmH09JHVnCPpGce5YjKNKbiN+2iHpG3OwudgJEy1d8M7x+oyeX9AgbZPYFq+M/4
         9eY1N/XsGY/EF/DRrdFP2xxUSX1OsgL1uZF4ZMGliBRy+NBzwS4Mrl854r/QOu9dUhNh
         ZDSw==
X-Forwarded-Encrypted: i=1; AJvYcCVB3HaJxt16tcuQ4qGw9BI3YuRWLdmV5YhcU/kisPNVA7fvYEuhU2omBuyq8Hjh1ZDvO/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3KQsh59Fl5bcFBhESudbNPT37aNrUcEkJYYlEgKfKxcO7Yx8B
	9+/soJVNfU+zvyKMZopq556VbzQ454qDXoqMkJfm9g+qtYqJr8YCPJYx
X-Gm-Gg: ASbGncui30Hur3Iyl31xVgONYXtbmIE5ZBLTrYVJQ3i79xn/IWt0GzlN0/bhj7kcMcw
	wTD9FQZ/Yd8O6eGplw/sE4RTPb01Dc20AMVYB47j0aBOWfmpyqh1iQdNwTAHRONwnmbUAYvmsfE
	BN10fI8wpmGmtsRmioXQ5IV9igmrV/zvQc5LyD1PY7hjOnON2mcFI8O0BA5sIhAECl0x/loPLHN
	cJEyW2XG0yriOd3g4pqgvYO+oV5wc2nOagILWsikcyA7slCoPVWlNMuFKojKYXhrKJn2FarMxY4
	6T2XR4Ck+dEQOXgjwPunxPJVEyNW3+hqsHQ2rHivtOp/yWzLsZob8VHNLICtPCxJfMThbCg224X
	Tq+7JGiXQTNiXx7loioYIHvk1itc=
X-Google-Smtp-Source: AGHT+IGTGDBOwwPRI++vXT+uO2cBnTmvSY9CVUIcK1hQ+14prLqPkCcPHEcPJfozmwhL1TIR+oefKA==
X-Received: by 2002:a17:903:2ece:b0:236:9dd9:b75d with SMTP id d9443c01a7336-23ac4606753mr242404735ad.40.1751298486701;
        Mon, 30 Jun 2025 08:48:06 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2e32d3sm82090285ad.8.2025.06.30.08.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:48:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  shejialuo@gmail.com
Subject: Re: [PATCH] doc:git-for-each-ref: fix styling and typos
In-Reply-To: <20250629110652.123890-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean?=
 =?utf-8?Q?-No=C3=ABl?= Avila"'s
	message of "Sun, 29 Jun 2025 13:05:31 +0200")
References: <20250627074934.1761897-2-meetsoni3017@gmail.com>
	<20250629110652.123890-1-jn.avila@free.fr>
Date: Mon, 30 Jun 2025 08:48:05 -0700
Message-ID: <xmqqjz4t44ei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

> This commit fixes the synopsis syntax writing and changes the wording of a few
> descriptions to be more consistent with the rest of the documentation.
>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/git-for-each-ref.adoc | 30 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 16 deletions(-)


It is not making anything worse and all the changes I see here
(except for a stray SP slipped in) are for the better, but it is
curious that this stops halfway.  Things I noticed:

> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
> index 5ef89fc0fe..c2b2660771 100644
> --- a/Documentation/git-for-each-ref.adoc
> +++ b/Documentation/git-for-each-ref.adoc
> @@ -8,13 +8,13 @@ git-for-each-ref - Output information on each ref
>  SYNOPSIS
>  --------
>  [verse]

Eventually we would switch to [synopsis] I presume?

> -'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
> -		   [(--sort=<key>)...] [--format=<format>]
> -		   [--include-root-refs] [ --stdin | <pattern>... ]
> +'git for-each-ref' [--count=<count>] [--shell | --perl | --python | --tcl]
> +		   [(--sort=<key>)...] [--format[=<format>]]
> +		   [--include-root-refs] [--stdin | <pattern>...]
>  		   [--points-at=<object>]
>  		   [--merged[=<object>]] [--no-merged[=<object>]]
>  		   [--contains[=<object>]] [--no-contains[=<object>]]
> -		   [--exclude=<pattern> ...]
> +		   [(--exclude=<excluded-pattern>)...]
>  
>  DESCRIPTION
>  -----------
> @@ -35,13 +35,11 @@ OPTIONS
>  	beginning up to a slash.
>  
>  --stdin::
> -	If `--stdin` is supplied, then the list of patterns is read from
> -	standard input instead of from the argument list.
> +	The list of patterns is read from standard input instead of from
> +	the argument list.
>  
>  --count=<count>::
> -	By default the command shows all refs that match
> -	`<pattern>`.  This option makes it stop after showing
> -	that many refs.
> +	Stop after showing <count> refs.

This patch would have changed this to _<count>_, judging from what
it did elsewhere.

> @@ -50,7 +48,7 @@ OPTIONS
>  	multiple times, in which case the last key becomes the primary
>  	key.
>  
> ---format=<format>::
> + --format[=<format>]::

Stray SP in the front?

> @@ -100,10 +98,10 @@ TAB %(refname)`.
>  	Do not print a newline after formatted refs where the format expands
>  	to the empty string.
>  
> ---exclude=<pattern>::
> -	If one or more patterns are given, only refs which do not match
> -	any excluded pattern(s) are shown. Matching is done using the
> -	same rules as `<pattern>` above.
> +--exclude=<excluded-pattern>::
> +	If one or more --exclude options are given, only refs which do not
> +	match any _<excluded-pattern>_ parameters are shown. Matching is done
> +	using the same rules as _<pattern>_ above.

OK.  Doing the literal `--exclude` for options in the description is
left for future patches would not make it any worse, and adopting
_<placeholder>_ convention makes it better.

>  --include-root-refs::
>  	List root refs (HEAD and pseudorefs) apart from regular refs.
> @@ -131,8 +129,8 @@ refname::
>  	`refs/tags/foo` into `tags/foo` and `%(refname:rstrip=-1)`
>  	turns `refs/tags/foo` into `refs`). When the ref does not have
>  	enough components, the result becomes an empty string if
> -	stripping with positive <N>, or it becomes the full refname if
> -	stripping with negative <N>.  Neither is an error.
> +	stripping with positive _<N>_, or it becomes the full refname if
> +	stripping with negative _<N>_.  Neither is an error.
>  +
>  `strip` can be used as a synonym to `lstrip`.
