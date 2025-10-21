Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B470350A10
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075937; cv=none; b=Yv7kKehW928PGaXIBBl2gGFaTzIcTikw1I2WZlP/8iWIAVe/Dw/T8CotfogER8cAuAvLmg2eCBCGquF3qa/xvPPnvPDLrdA3PVPkbk9vrefbcCSmqWHNIts2bL/qDPJw+Y1H7zefh3n+r61LXprTbyk+d62OQEKOu+ATCGMPB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075937; c=relaxed/simple;
	bh=MnkYPt3YWIj8Iv6obGT9ZCdJSJnn1/nDXzsOdrSybXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaI7VogDv25vQN4y5PW599dTUkqd9F5trx50UQEwVGoUetw1gbeI1qoUlLRb1OMSC/QqAOnUMhw2Rydx8SXOFedhTclFSz4R0NbH4/vcprg3hzTJpD7OfILxRlPPRrRGv3n1VjqItSldqVNOIFE1DVvD9CgC1KyhJes8PSHIIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=NLkI4UuF; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="NLkI4UuF"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-92790f12293so298771739f.2
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761075934; x=1761680734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7TaywUQB3K1k3LaQCXVXke+fhIdV0t86akSysyunBMM=;
        b=NLkI4UuFAijrPdahGZRwwOAmWI7qjZal48Po5hY4MoN2h9xNqC+ZhLssI0PZjgMYvk
         YZHn6Y2mI6c9o421MOg/VQOhiIJcCj2U2swNVKZTqYjRdD8MlkMlSWjqDHCK0Nznn5uR
         YamFSZN/lJeYTyh6hIafOmokxz44GLLgCO3MxRY41Rj1AB6ff+SMfSHXpULHvRt9PJJl
         ZaOu9+nbKO+kFxf0l3u/IPzrkZz2B1OOi7ICvEpq1Ktg7ClJ4nhCxZFOuNet27w1PQY1
         KazYj7k9N01MXxq/FdRR2gcnwJ0ZdKdJHF5/1kgrWPo8Sp17W5rAM1H6fZ5TwcQvI9Wf
         naGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761075934; x=1761680734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TaywUQB3K1k3LaQCXVXke+fhIdV0t86akSysyunBMM=;
        b=kBH86r5wQ+3BmMD4W4irUU9n+1P4+xYjwxXssHAwmPyqJammtldZKsf9TsUT4v/hy7
         /zl9OlH0JrB834uiS+u3fvGghtXcbFssEUxdRJO8dgT1LC31LjTaIKemydnCg+Nr67GS
         NgCGq7Jk5E5aFPjWWiIc8gUNPFG7X9Luuohyhpdxy7sb+1jUmJI9LZzXdOdZDhsqqMrr
         LTIW0Hc785hKO4mh8bRYOYsX9BaOdbjGJ+PNunk5rxnemqcIG3lvGmWgS+eLr2VEVVxj
         LTBDFYYXARfgDfBwFTWWM/zaSz+5Udl94tCUfKILVLq2k0uM8Zw99QP4YmlOBx7047nT
         j4Cw==
X-Gm-Message-State: AOJu0Yz9PTEZJHi5ZvxC1NarOgNEMdVFa4VV7zmwG4yuX+cdcpsc7sg/
	zcNP4pjP76NWftDjzT8aIbErm+35yG+4WMU+Fyrqjv8EDIv2bXUBNFjJI3Pq7ah1dNo=
X-Gm-Gg: ASbGnctXV1Blhiv9WUSNBHSE7fDOol2R3JPT1A6dETFMsQ86bYgNXMPOJSAqVcjCAGM
	/U+zvdjbrgNsGbjiwkEFhk7yE/rCld2NH44ELbOZZQxtsvpCM0ElyueWQclnpJ+46l9GhPASRYs
	2cMVVct+bQB0px4LsTcy3k9ZtjAQhvTqG/6hpDHaP8QNAjbcT4uNTsqYSoQbQzRH8U/I0wGUDiE
	GjxKc2/f0JiAd6kf0MJ0qe3KZ3ByUWsydAal0VJ/nV1E7iE4OkfGFqeVda7c9GkyNXnae3KRxZK
	USZ/eRSljiHSDgcsOVx/tHIeM6ytxyQE7Tbqj3BdCNWrKlcwqrUTxFNkMt1oJU24pwwzxs40Rry
	VyMiZvU8ikYKbJ5UIGS0D6vYTqO+lv/TvH3TGhKr8c7pFMATnxLgG8bwNDJwT1ECDjrwvTqqeDk
	tPkeq8p5LRMfSHyfQzKobkGQ4gYnKJ+cz5eh4Ni5rvd6cWjiihm9jetXlfKglZiVpaPQiNMw1wQ
	d3kmX8u1zTYkLb0rQ==
X-Google-Smtp-Source: AGHT+IEah1nLPXT6XtjwcDQoz9xrdURjpO3tJEzUsobRR1ibvfvTvnEB6NfgGtay41gLQionErN8eQ==
X-Received: by 2002:a05:6602:148b:b0:93e:8aee:f98f with SMTP id ca18e2360f4ac-93e8aeefe69mr1945818239f.10.1761075934351;
        Tue, 21 Oct 2025 12:45:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93e866ca57bsm437551239f.14.2025.10.21.12.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:45:33 -0700 (PDT)
Date: Tue, 21 Oct 2025 15:45:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [rfc] flip rerere.enabled default to be "on" at Git 3.0 boundary?
Message-ID: <aPfi3JuQsDS9mpN0@nand.local>
References: <xmqqldl4und1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldl4und1.fsf@gitster.g>

On Tue, Oct 21, 2025 at 11:21:46AM -0700, Junio C Hamano wrote:
> A good default matters, and people who find out how useful a rerere
> database is would say "gee, that sounds great but why they do not
> enable it by default?  It is too buggy and they wanted to reduce the
> number of support requests?"  Yes, the reason it is not enabled by
> default initially was exactly that, i.e. those opt into the feature
> was used as guinea pigs to polish the feature.  But we forgot to set
> the graduation criteria and never said "ok it is mature enough, so
> let's turn it on for everybody".
>
> Perhaps Git 3.0 boundary is a good occasion to do so?

Perhaps, but I wonder if waiting until Git 3.0 is necessary. I use the
rerere cache daily and have for years, so I consider this battle-tested
at least in my own workflow.

I'm not saying we should *necessarily* do this, but I wonder for
argument's sake: what would prevent us from changing the default for
2.52?

Thanks,
Taylor
