Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602DD635
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719247; cv=none; b=phMYtyfJTg/LX/pIExInT76YIp24abF62VJ6yefmtzXpEf9Ui4RTTUbW7M+AVm4QIJzk1sJzsebSZuAAN9p0rMRFmUvPIrH5phVTYWNnda3jDtttSI2Gy2fW2H8e7lMwGaFv/TBxWHvpMfw8GWsEbsOqzTb2sqVpQQ/65Jy5spg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719247; c=relaxed/simple;
	bh=OEGI8jGjmxG1Oe+8B4sPcwNdnTkBm3tgg29Z/DI1mUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJaSEGbHvRbUGwLlZ1796VykTVaSED56wSb1TcrwutfDdN3CQf7AIad7PqN5zqPggYHCsnA5THKX8WiGfziCEpqvytrJRQfaaazPDdNUfP0+Pn581ZcPbp9veIOn6ybv2sFAzEfJ3zyRnn9WIMfiiDQrJJ+cnmBaSgJOEfEQ6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5sCtc+R; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5sCtc+R"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73e810dc01aso2513071a34.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753719245; x=1754324045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XIUuyLe/AfXa9/Hvo25C/8nhKrnG342iP5s/EnJweGU=;
        b=b5sCtc+R0zPmus+PkyqO4VPZvHYSRsM69l20Io/AytD+SZJHk67oqi37NIQTXp6t+s
         qlNZWSjLu3iMoXZMaTX3SdE/8ri2wTZjgTIRATYez1N4HpbWRqffYARqbbPaNYiDkikq
         uHVn3iKabvtBviSFhMa8UMhDp2RWgRr1gDCkYhmASxbiY91lQfWg6wXOLiC/fKLpgwvT
         22HN7C7BvO/AIZT5V8P+lh1kEIk3L1cKL65RjScY8bR/ySrvzesUhFPgBLE8LKFQUUmW
         Ujvy/nozT6kqUH82UStMHYKBmFikLcP65Kbv38UCEzIfeaDtms8c+Crl92NRGOQB1WlN
         foqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753719245; x=1754324045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIUuyLe/AfXa9/Hvo25C/8nhKrnG342iP5s/EnJweGU=;
        b=o2v+G0RZJjdy2+98ZG64Iy77r3qnTGyZdLf5n+VlRw7u/NUlb1xBT1sTrjbNPwzho6
         HrHWbNrCrryPPBkMrHaHyeyHesMIzBhUl1MnEaN4r+sHlryMxdPR0Q4anFJ5GSpnnGbb
         hMVJCFGdT9ouiA5h0GRYMUWl6aTSz8l1ItZXKULIt0MC8Ae460SSighxhbVvgMXQffcC
         PX0rNJ68uw1cTFvxRivcZLzzzLhf9spTTFmwTvM52L4eXvH/biEZdJAumXA2xImseiPy
         KeIhnICTYV1GLdWgw6B5gk4mRl9ax9/TVq3CfBMjwR5EySz6GZJlGERlWBcIcembWy+y
         NcQw==
X-Gm-Message-State: AOJu0YyQz7pDVHlM8dSSwhRJ5Q3Aa4u6NUMJoRLJmBXiI6q2cdBPHYGz
	rshOXRsgxmTaIE+/ii17mfm8SjBWbuD/whE21s/MSkBaFTUWtIoi1zTc
X-Gm-Gg: ASbGncvxchJItEhCjA78FpfFZ+0ly4xQqcLSlqVoR1qzrxvaDdncIPl5t0w4Lx+F4Ib
	0YdSX2JX2er5VNiFTc3mwzJNr4orYMcCeZ6fO++X/vv60Y2/gUF8QVth4G9Rf23c8949+0fmFv7
	KW3SgjPz72h7ZeHXKzaKxRr2MK2yWvDvpBX4bPCZlW1wGo+qpAZgabUGqay7tH7WUAuv59Pkzc7
	td2Gw5Ybjz7/YK2wltpUJhE3XUTV7E/lRJQlcEF6Sk6kfv5B+NOO9RhbpF5HQ66Mpqf9lgCY0hc
	zPrwgBsIpgnUHS7V2MBVz158E5WsPe0MDhuoU2rcVcbEDaQDnHyU/CHMFgmqoFWZrWPEnOzvdlo
	tOqP2G5dMqcO0ZY4=
X-Google-Smtp-Source: AGHT+IEFkuUzNUeQjFGHJBP/Taa/l9tcuDP+IfWkFOR5pFG+AzqVY2eUMdd95gLfEK5YX7h2+CpQdQ==
X-Received: by 2002:a05:6830:dc7:b0:73e:96e6:2525 with SMTP id 46e09a7af769-7413dcf2bddmr8455480a34.24.1753719245203;
        Mon, 28 Jul 2025 09:14:05 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-74147fc0479sm1126468a34.25.2025.07.28.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:14:04 -0700 (PDT)
Date: Mon, 28 Jul 2025 11:08:10 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Jeff King <peff@peff.net>, Han Jiang <jhcarl0814@gmail.com>
Subject: Re: [PATCH 2/4] refs: simplify logic when migrating reflog entries
Message-ID: <b4mvddzjkdv3htup4htigdifp3zydrknhheza4vn3dqkecgx55@vyhj57qanllk>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
 <20250728-pks-remote-rename-improvements-v1-2-f654f2b5c5ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-2-f654f2b5c5ae@pks.im>

On 25/07/28 03:08PM, Patrick Steinhardt wrote:
> diff --git a/refs.c b/refs.c
> index fd9a5f36b20..b820c3908bd 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2942,6 +2942,7 @@ struct migration_data {
>  	struct ref_transaction *transaction;
>  	struct strbuf *errbuf;
>  	struct strbuf sb, name, mail;
> +	uint64_t index;
>  };
>  
>  static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
> @@ -2974,14 +2975,6 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
>  	return ret;
>  }
>  
> -struct reflog_migration_data {
> -	uint64_t index;
> -	struct ref_store *old_refs;
> -	struct ref_transaction *transaction;
> -	struct strbuf *errbuf;
> -	struct strbuf *sb, *name, *mail;
> -};

When I recently was looking at this in [1], I remember finding this
rather awkward/confusing. Very happy to see it go now in favor of
something much simpler :)

-Justin

[1]: <tg72v5vgu56b6akawy7sfapi2qtrmy7q3uruhersy4dtzkpvju@wamlylndp3xv>
