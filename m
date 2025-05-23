Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070622DCC1C
	for <git@vger.kernel.org>; Fri, 23 May 2025 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962243; cv=none; b=BeICqkUxObXINaoXsEm64bUUNC6jKcSM5DFgXVYnXQEzDKitDZ7cIvq/4clrYaAKb2loNC12eN+5n1D25qqgev2bLgHDCZy+X/WM7CR8kGjjsWQH2G5U6wyYAm3UZJWZMBuwbeeVHaoa84C77yFb40byfo2P3nvbdqMw4v004v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962243; c=relaxed/simple;
	bh=l5tupLR/d9Hd/1diBG4OCdHxr+/nxEs2QC/LrDzbDDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPR9j96hgQSYgSZOSv2YkEzUy5lIqEJHabOHKfRRapRl9Chr1Us+Sd6dzeu7l/Pkb6FaynJPuEcgoODN3CcSA2Twn2vyp0zZHsgToSU+JgDAnqT1XhWRmD/Zd67ngRMnJniMeVYquo2u0oAyPQVbwo7I5DQ/Q6U6rEAH69Vkles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qdmt5oV9; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qdmt5oV9"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c56a3def84so822038585a.0
        for <git@vger.kernel.org>; Thu, 22 May 2025 18:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747962241; x=1748567041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5tupLR/d9Hd/1diBG4OCdHxr+/nxEs2QC/LrDzbDDM=;
        b=qdmt5oV9JOf6B3L5m0wDnsr461XPFr9m9Jtmz4WyF9njyC/PPTnnpuVz6bWG47bZLX
         KBI96nYtvKMhoZH5ymG89xi61qM+oHUPxub3MWR1s8qndzzm+bXNzSCWIWITg3USZRfv
         ZhBeTOzWLgGzPgENbdyCaG2LUvhfAE8r3XAqLnwpmFlGlLN3s1mHXfyVDV8pbCTXe7LI
         Tj0iZK/R60WVGkeJmGSYpj9w1CsxdGM9XI+TN+dZ7vf+3RHzxNzttHpqZ4GgEEa1sJla
         3AdBBzm9OywNzz3MCX1wLTgs/rHplB/nLz7pTvDamzsd0kd7PbRqFSak2nraIs43teok
         F38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962241; x=1748567041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5tupLR/d9Hd/1diBG4OCdHxr+/nxEs2QC/LrDzbDDM=;
        b=OJPwwfoPHT94GSBjcIeaoB3CnuSrX0k/z37ksPcQpTq/GT2IRvB6ZHaxhGSyln5Umv
         BZf1TQ6SIQRyem4syo1AvhW1qsQ+cQeMJ6enHUFfJA3vR1sA+y4baPmFHaJ64/T2aAry
         WiSKYAll2SaF59FNWEgPqO0chAz8onqZRTFp+IUxv8TCHxzyb8CA89Yvf2tV7rVS4o0k
         eTxkXUp/VV00hax7m7a688bCl1I4v50tvV0PZUxUb6FikwtVAtD47KWwK38j7o1mz4wC
         1S6dwxvaW8Nbahz1lC4pEz2r/d36R8/OOkOpPssdxt6bYqHDQatPIX9gOjf/7ksMsOUu
         PedQ==
X-Gm-Message-State: AOJu0YzNYxYdKVL/lI/bOOwKYzhbgG4tbhWJPZjS3nnjTNUmLlavCCgc
	QZ8EK3WLtVyaZ7NBKVn/bY5wXO3TRPFz+6HUxY63spSVNmbQyxUSOOg9vONbKK0TDYQQLMXoHnh
	Z8k2I
X-Gm-Gg: ASbGncsWWWg4+Rg14dghSj8H60wUBbFUe9o2kwNfVIu8bj/sqTeeTjTETGWixbuQJYi
	SQgA3eJ7BPvc2A1jYEwwh2aU0fARebNI0uwcjsY9G9SsdFNr/WaxuSal1+Pwa0CE8oAeeylsKmK
	L/S/2yg2jOM7xfRw7exMotxxxattZtPBPf1vPYbXji+P8fFPyHyr7+e0sOvClnOZPGSk55yQI6O
	/EeNbSLNt2bZgtYcrOFxIBTChn+CY8uhNCbC8/g7sPl5VEt87Z1M2ML/dKlQK6226vj1JL8zsqc
	9OHbvAlp2iDYmWzanb7KZPKqfRhjU45P+mnHfxhWkD+3u5fKAkkCAyIUfw8hGmJItNnxCU774Qe
	91MxwCh2VHBCu5hMoOl0t1Nc=
X-Google-Smtp-Source: AGHT+IHoGim+bCnRAQHTx560GuJvZfW/eE1tsSpxEaQ84L7tmqEE11mwhFOktWVioB0P5s665C8G0A==
X-Received: by 2002:a05:620a:28c1:b0:7ca:e943:144b with SMTP id af79cd13be357-7cd46725e43mr3603025985a.23.1747962240860;
        Thu, 22 May 2025 18:04:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467eedd7sm1094728185a.56.2025.05.22.18.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 18:04:00 -0700 (PDT)
Date: Thu, 22 May 2025 21:03:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] packfile: explain ordering of how we look up
 auxiliary pack files
Message-ID: <aC/Jf06HdCxTJwnI@nand.local>
References: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
 <20250520-pks-pack-avoid-stats-on-missing-v2-1-333c5217fb05@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520-pks-pack-avoid-stats-on-missing-v2-1-333c5217fb05@pks.im>

On Tue, May 20, 2025 at 11:53:09AM +0200, Patrick Steinhardt wrote:
> Add a comment to `add_packed_git()` to make future readers aware of this
> ordering requirement.

Thanks, I am really glad that you added this comment to aide future
readers.

Thanks,
Taylor
