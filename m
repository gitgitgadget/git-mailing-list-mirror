Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878819F127
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172837; cv=none; b=SNNAqkEh8k/t/3w2gx6s008+4poHsSX4330kC09r3NKu7AuKlCNE/vX0W9IXm9Qj5zMnaAXwxH756WqcQs1gwDzzdBpmcC0dsM7VfmfVFJvDeOVf6HJDNFWBwowcihTUMFGNMzP3sUdqd8eiIcyYI0Nf06xcHl3/wAekjyiaC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172837; c=relaxed/simple;
	bh=20wfp3Yeo7oIvbvUDUc4a8lQmiPkEnpUq4opBmFVx14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seax9GxcTevTiRq4XG1RNWTU7YRsyjmr0BXEFH6MYaaxZryDubvEZC5mvos+p+NdKNVPX36Ve+thuiTJurElA7lnDLNUHK2y9f+b/beMHK9dMBfMNNw+GAUWDnSd+smQM4V7IzntgIorKFvNlsj4wBv+LWGV11Smc31CmzkIR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=f1ECgck4; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="f1ECgck4"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3eaff77982eso31218675ab.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 18:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756172835; x=1756777635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0n4070Gar+X63emD5K1Pzr8iiC1vE4CIbEGYn7VVdoA=;
        b=f1ECgck4Q65YLnkcjJpjbk+qT62+wjlXaa6LU3utbtnDPFpSlXaPnoA0Z2sS6giywV
         XmQ9c3w67nfHCXV48nUNVG+60nKQfcZiwHGjmJglQyXU3ZCw15sLWdvqTxbSTRwlFhwA
         9gKVIh/5RBXcrgMYosjgX7o7aOTAXxHzJiAM5pF9Yv4Q78KYFKKb+mhcvo+9z9ATv30f
         cGqYBH8l3O01TeFQ6FUWObMRdJKH01JjaRZMM7ObnMV8NMNXLQM9ssVpzpICNKJsW6V7
         94n0mU7EsB+VuGNH9/9eH2BqM4vMhk+mYwZNXYibYuzBNu8SP1QMbxLVwEuVFgVKW+Vr
         2aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756172835; x=1756777635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n4070Gar+X63emD5K1Pzr8iiC1vE4CIbEGYn7VVdoA=;
        b=UUJJrghuTm4nf4mGqvjGHpGLTL5vzFvz5Jp/0EvdFoTRvwHMUqDNV0uPFaFR+3tRUo
         v/DXvKq8bnf7Q9FKV245SV9d/b6/GXCMfwOLIIz1Y2CqF4wbC/wkCM/1dbM+xhKgwaax
         KgHvGHLSywIropjGzSz9JY7cqD3/v0wgBc71th4RJZSvsZBouquufsMosVB0yn4MDeo/
         F303KQgoHIQZ4SR3e+Nf5oMUS6Ayi/tmCwCB9r+u9j9gDhaEVNpqefCCLYnNsBKrAX/0
         yAh5xrWd1Rkkz2TiBO2q5bCa0UQ1fD/EAirBlhYA+VDXHKnAz/XVTQaQyG6LvwNjvzst
         2Wjw==
X-Gm-Message-State: AOJu0YwnCv4TJjvxBNfWY1LSLVTYSx4ym6wlkWoCAyMGqmby1A1TZu7s
	w9+CnONcGcIq04KghGc0DtOv42F81NwErNMna05+9wkiACQmWHAAuh87Z6VYy85BK+U=
X-Gm-Gg: ASbGnctWlOBSmKYd9D/qKEQSK/mdsD/qQQZk4G166R4SvXHJsSmL3SDMqEIx2ZbBBXR
	4Y2/I3akKTcnG1llnqDE0whWV5EEpf6U+vtKr3oyE2b9U8kOwwYW2lz3EPq7LFuhGaUrh+wGznE
	uMzgeQwF2QtrNaYMpiK3FWwKEogjHrbFo6Mkx836aDpZLNxwr7pxYwqZQLaF6r4briCKohe2VZx
	ye+2Mnw99nd+nsvTA4Bh8aeGjkJOmHYGlsOdxLjZQpuQofui2SSq0cy6GQlHnGUw2JjCBFumOLT
	5QeDb1QDstOem0Ti8XLgunUEb85cs4G7SW2aBwm8a40Fk7NGSUVTOyoCcO9cCL+Fo/5WlaDnY4d
	GP1Xlz8e5uEN+61R6zai8IS4YYE4D4mIWte7SGzd6GB135tFBAgG4p0SLGQSwdrdPvajRqiCCPc
	qyinFwXeXfP/wcctNtjQkJ1YcXmg==
X-Google-Smtp-Source: AGHT+IHyk/fYPrd7nG0ZrJoP12HBgmPmRx/MQAWXroOF8K8nDUaXM5UEf6qxOdAeP3XLkyZm5uip7w==
X-Received: by 2002:a05:6e02:2502:b0:3ec:2c8a:f35 with SMTP id e9e14a558f8ab-3ec2c8a13ecmr54129825ab.18.1756172835461;
        Mon, 25 Aug 2025 18:47:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3ea4bdaa473sm57324015ab.8.2025.08.25.18.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 18:47:15 -0700 (PDT)
Date: Mon, 25 Aug 2025 21:47:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 07/16] packfile: reorder functions to avoid function
 declaration
Message-ID: <aK0SIkGvHmUcS8xO@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-7-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-7-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:05AM +0200, Patrick Steinhardt wrote:
> ---
>  packfile.c | 67 +++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 33 insertions(+), 34 deletions(-)

Inspecting the diff locally with --color-moved shows that the changes
are faithful here; thanks.

Thanks,
Taylor
