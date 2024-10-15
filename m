Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF04824A0
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729021643; cv=none; b=fA78fNigKVDMlmbjSdwAdPBz19iaRb5bX+d5qPY4mtKbPumO72DKfo7FBdTZIxlmeWrvpxAK4G2GljRtcjePEjQvJnCuO+IRdVl7Mt8ErOGQozWYqbbTpUM1t5VhYw4s+5pQckABpnILi7CxNSS9ozECLKbSMIyRbEUxMa8Vj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729021643; c=relaxed/simple;
	bh=M4oMhKlilmqlDSM5M1gDGQXHXBkXei+WPkQVCfQdmBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IR2L9J3ja+ZUuk1LcyaMUvMbrF9yXWJrIj3swRJiqjBMGSZiNylZIW88zOWB68fQsv/8LiKacb0EgIqcvjoaKV9khC6qLNr1p14zsQH9bNXmnRL495w7bABwAfrs1HhxIqIMto3/JUPy7eBHx7kg6INq1rOwt6kcNM2AyLMWEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QalqzXok; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QalqzXok"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e290e857d56so4892815276.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729021640; x=1729626440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4oMhKlilmqlDSM5M1gDGQXHXBkXei+WPkQVCfQdmBE=;
        b=QalqzXokmGb5z2cZ10t95Hxg2dxLBcenaiCtmg1LSltUb3J6IA7sPky4+K8TDbZizt
         cNOyqcKLsIRNWlPC9co/Wa2MzVPXkSIg/rhYERHOlJdXIclPGwyS6LFTBek+uctUgZnn
         tosFaUrWpvqp9DTQ8KMZ5YYc1r/pXujAQxDqRrxMWiLdH4EsS6HQnra4xF4OwDjq1S5h
         vu+XfTa7OYFV3PNpw9fwfpJ9F33VLjf5/UKX5DWNDbDuKelxm7X4qW44BiEjR08z+Ie7
         hKqhRoM4gbtQnaFNuTsDCeoy2RMWcK7paK1iryWE3AsPBffQapdaOU2xaSvYLA5wfk2c
         YunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729021640; x=1729626440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4oMhKlilmqlDSM5M1gDGQXHXBkXei+WPkQVCfQdmBE=;
        b=e+8HEOVZ9RGrZ4ter+NML29dmIaFQpd4aKBxfzA4nTr41bEsesnC6FgsFRhx1YLULw
         iHwCLDgyUM+vZqY8dNYaW3mogEHwXR2uiwbHgz/u/B+mi4El4w0fZuCioPHFR6BqbJ8i
         7hgpQmT8UoDcGH5Jur06fIS7zjHz7AEaF6DFR8zgcIpuIqDBGgmwBFerg5WC01VVtqFH
         HKiPsOJb3ULkK9g3qvs0l6+y/RSRutfmW/kWJNK6BRTRsTZPjvyiKGf5HZqSzH8MZzgc
         0spTQTH+PSFA1bmrvHK1zvGarU2gobcQ91oPKjqdd1/yIph63fs7ubtmh8RXzqnThE6g
         5e8w==
X-Forwarded-Encrypted: i=1; AJvYcCVK3A3KnWj07+UtazWwtJipuAjCaSu+fUljM80yyoqVC6axQWZdtD/cfI314qf1Ngt74mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBiCcCuLih5cJyvKIKLCD71cU1atXgd4S+9dKA+OnyWK+urz+n
	otcKou5OzK4WCQyFZxrwhyrEv2b0d0pCZrmy8PMVfnroiN9lozzZG7dKJxrw9jY=
X-Google-Smtp-Source: AGHT+IE//1AYbqveuSG9X+yVBxgbcmcgjKoqvYQkapzqc6Br2LP/Jfig34WVDxarYlYWIeKrMUOb7g==
X-Received: by 2002:a05:690c:a:b0:6e2:a962:d7ec with SMTP id 00721157ae682-6e3d407f355mr21084587b3.6.1729021640465;
        Tue, 15 Oct 2024 12:47:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5cbdde0sm4118537b3.97.2024.10.15.12.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:47:20 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:47:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Linus Arver <linus@ucla.edu>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] trailer: spread usage of "trailer_block" language
Message-ID: <Zw7Gx6D8ASANDwOk@nand.local>
References: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com>
 <CAMo6p=Fo0gp6Vgq73E6k=Q+tV0g8EB3L_AEWq_4e85G86QUc1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMo6p=Fo0gp6Vgq73E6k=Q+tV0g8EB3L_AEWq_4e85G86QUc1Q@mail.gmail.com>

On Tue, Oct 15, 2024 at 04:32:42AM -0700, Linus Arver wrote:
> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Linus Arver <linusa@google.com>
> >
>
> Hmm. I just noticed that GGG (?) is somehow inferring my defunct
> @google.com address. Not sure how to fix this... any tips?

Perhaps Johannes (CC'd) would know?

Thanks,
Taylor
