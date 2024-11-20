Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD841386D7
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131873; cv=none; b=NDvBVE6zmdLSZaVrFZyqijQIhnfkML0qctGWGIk7hfH2TvDM4zaxZEUmuB0tYr8BEzkVMt/5EdZ5tFuTyiv6FPj1hVSppRSlagE2qBVpuCQ8a5dar5uwZF9O96+ciU/DxCry+unbPGpe81Ivf4s28Yq+wWjNrSYr1hNh1Z0ww8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131873; c=relaxed/simple;
	bh=W1JpBj8fI1Sqi14OhD8JgL6kS2/Hmbj58pd2hFd7qYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Euzangm38KDZQORUUCROK37kQ1vdt6j64xKVrVG+iUyA5hwMmq7uthd8bG6dOye6LbBFwmmxqMuOiLGxmeGRJO0xc3rW7OYU8UxT+/9xe9lmqBV5+CPJla8Qk7y8GKPczUc9WLWS02LqVnvK6/u+Pc1gRAkHHc5i9ifTmxEYaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=I1AmnfeC; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="I1AmnfeC"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e388c39b2d0so108430276.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732131870; x=1732736670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey1JmQ9DBMAXijU0rWAiE3WeNQYPl1+eTxDUwgBvSK0=;
        b=I1AmnfeCzjcTSR/1rt4a4S17tWx0RF8cJbxa3Rt3LhOThh5OBh/E7zv/NrLExzLCIC
         zTNmF+Rl8oLIj0MHccdOCyYVUyzxV8S96TCnEtmshNMhLDlOPX3+Fs6Q6HwQkTsgyOmK
         J/jbXE9s3aHFuWJn3bysN1te2SxdGBekKT74zIE63mBYnA/X8rKBu7nl6ZqGugdPAu7J
         te4gh+y4p7ZXNtx+RxPxk4qpB3Ecyr/PsObEYZHIHMN2TDmrB5sLyNbMqG2UbQhV9lrO
         CwX1oaQdXlkQmAMX85kH/GVP1JsNID5aBuHIxcTrIsss4FJlpX5e5IArOLHtA6oh5Hkf
         3uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732131870; x=1732736670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey1JmQ9DBMAXijU0rWAiE3WeNQYPl1+eTxDUwgBvSK0=;
        b=XdbSfJEE/S5bzrvSklfZjooWHt4p2SxBsQPm/pRHy/vB6VYBany0fQzbcXXgGtt/ob
         cZa/HO9biNeLT367VikEphIaKM1+9Myof6gogkrNkvuBvKGWwv2bJ26hHrmiXE8+t8u8
         jpj3KQfw0zgHK7LXqNWWfFaZOtLjN24GyM29pV4H90VqOBqhngU3p0SF1widQqIGEfvX
         nDVE1aiFYIq/KRILYhlvf4U2bwkxeTN3Wt7vEECCbmbwJFSj9gJxAURyXQHFPHL0Kphg
         0HPk3judraH4RyKgIzE2vgkOyjQSkrrDVWI1LaAJ8csfH8teKfrT3QavSDmO65tOvq/2
         Idpg==
X-Gm-Message-State: AOJu0YxvFGCcAP9FOrcfY8Yzb/v2uSYxlbWtUe8buFG2dszpx3ENkf7v
	+v1puQOFoH3T6k/dHz5uAwT2mkIm05wBkzR0IDZgFOeN5F+1BBghJ/3iwvV7Et2er+OPUV8sHy1
	5
X-Google-Smtp-Source: AGHT+IHO9IId7FfidTuheT/dx4VKSwpquGYSElLUjbuLvA2lFn6SpI7sXBfFnOz2oOHzb3zq7pyEuw==
X-Received: by 2002:a25:d60e:0:b0:e38:2b99:7f2d with SMTP id 3f1490d57ef6-e38e1588e5cmr739152276.12.1732131870665;
        Wed, 20 Nov 2024 11:44:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e753d7dsm3225857276.25.2024.11.20.11.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:44:30 -0800 (PST)
Date: Wed, 20 Nov 2024 14:44:29 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Subject: Re: [PATCH v2 03/10] midx-write: use `revs->repo` inside
 `read_refs_snapshot`
Message-ID: <Zz48HXREk6esJ7xX@nand.local>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-3-e2f607174efc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-3-e2f607174efc@gmail.com>

On Tue, Nov 19, 2024 at 04:36:42PM +0100, Karthik Nayak wrote:
> ---
>  midx-write.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/midx-write.c b/midx-write.c
> index 22b5233f51ec6c6d99b8f9613818f1581dca5982..564438f616f59cd24edda956e4af0e0acf167138 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -760,7 +760,7 @@ static int read_refs_snapshot(const char *refs_snapshot,
>  			hex = &buf.buf[1];
>  		}
>
> -		if (parse_oid_hex(hex, &oid, &end) < 0)
> +		if (parse_oid_hex_algop(hex, &oid, &end, revs->repo->hash_algo) < 0)

Looks obviously correct.

>  			die(_("could not parse line: %s"), buf.buf);
>  		if (*end)
>  			die(_("malformed line: %s"), buf.buf);
> @@ -776,6 +776,7 @@ static int read_refs_snapshot(const char *refs_snapshot,
>  	strbuf_release(&buf);
>  	return 0;
>  }
> +

Good spotting :-).

Thanks,
Taylor
