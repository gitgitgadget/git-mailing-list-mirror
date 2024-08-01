Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CCF1EB48A
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542489; cv=none; b=RP3zj0NoIxHmmccJEptqciUKn1jK4mMJXW2hxHmBplAmFkkt36sZh7ZY4ZCY20wv/1ksYpisG2KPdVtFWQHwsG4VzGsVRiHkv4a0rmHo/wfRe/lhHPDRk8N+nZMZGP53MNYUGlvRWtjBwyoBALO8B9aJCnvet7HUsjhKv3noxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542489; c=relaxed/simple;
	bh=4uu9166HFu5A164HH9TBL7S1CRaqc/eUkh8j6pzpBqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPSnmefI/gm4l7W0Q1SJc5Dys7y+2KobI7BLB9mKgGnDv02Y+lpx92blSip87dMzsSiVpJOI2kRm6r7IrES7Iu1rbX+WCsoszK1Dbqgd+3p0OXlfIN7zktxQnixvDkVLpFClOgNnaLb3Eoab39r6a20fvIWBiQCWcGocYz1GpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=R9vJgC7/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="R9vJgC7/"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d7a544e7so520318785a.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722542487; x=1723147287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uu9166HFu5A164HH9TBL7S1CRaqc/eUkh8j6pzpBqk=;
        b=R9vJgC7/zO64e5kaCgV5VdKkDOpZuXWSbJq6RgSEO9zLhXTJZuR09reB0m+JWkayXy
         160DZJK5Nai+LYjFppDVFkm7J45LTZPpDkd09zDcll6GwfUBZ+VNAot6QT5HXPiYRRln
         u/LEdtndmlqlw5HcwrB0fqHo7vg/zt9h68utt7j1jqUhfV2t8wh/EUMdsPQF3+7R5TCZ
         2qII72upNzg4chPHZbn1odAECX78IJLR+x+BAhxBs94KvhjsyOkawdlo0Rn7caOj32aa
         HJ6WVcmdZcZpgbBUmDhPf6nTpMHwQNWS15x+4nQk1JwHgYqmMZwTwAlvs9XTITKJ+P6h
         axTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542487; x=1723147287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uu9166HFu5A164HH9TBL7S1CRaqc/eUkh8j6pzpBqk=;
        b=QJvKxFin/fY+K1J+NB5wrGgXF+0BsJ7oj1th3EgUjj58kQFcWpedFOdpwFLYl+nTUU
         mJcOceJZ0bPiUKcqVTM46pfkB2fC9fKQHJs4EETL00lSx/acyY60ALiuekiqpSmA4is2
         UDEuzpp0VPaleHbezo+Hp8ayFvlMM2Y5oM62Nd/RQrQr23/OurZvN2xjnIoR565A/ZuT
         aNgrciTc56bSLmJi2u4jocb8MZWdDH6BCUO05VnPm4n8e4SafeaG03Zw1LM51kZg/UDA
         QE8PGpmCe18B3cCGNr+TyJ+HYGe9rW1r/BBg8ytOUlXusmp6DRJBZyEftcTe/UBK6iS7
         bBKg==
X-Gm-Message-State: AOJu0YzoLaY06TRmxvdvmb9kYIC/etsuP741XcqVTKScytXe87crjJpx
	Q489CU/RW/b89uwEViq0xaCvc/1VvMOoF1Tj+HfYBdnQRjV4OceFkSD3dyd+tHY=
X-Google-Smtp-Source: AGHT+IECptHBvxZmucAJdrJQTsSALQj/5bum2tz3emI9iWdGEXXo2rtDMGJZJzOB4RI95JnrJE9CQw==
X-Received: by 2002:a05:620a:2413:b0:79d:7149:764e with SMTP id af79cd13be357-7a34eed1548mr163487885a.14.1722542487433;
        Thu, 01 Aug 2024 13:01:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f770cdesm22997985a.76.2024.08.01.13.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 13:01:27 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:01:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/19] midx: remove unused `midx_locate_pack()`
Message-ID: <ZqvplfibWoQFhgEi@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <22de5898f3fec0cfff4289660b5f52aa31533fe1.1721250704.git.me@ttaylorr.com>
 <20240801101454.GK1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801101454.GK1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 06:14:54AM -0400, Jeff King wrote:
> Nice description of the history. I wish all patches which said "eh, this
> is unused, let's remove it" went to the same trouble to make sure we
> aren't missing something subtle.

:-), thanks.

> -Peff
Thanks,
Taylor
