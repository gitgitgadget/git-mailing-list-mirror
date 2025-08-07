Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAD190498
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754605632; cv=none; b=Wb1vTn1ZOhqSUuCGtNG+EKNfnWFmXwobhV628C93BWF8ySvEIor7faWAOqHvMo2K0E+EIy4sFDkDEuYr9hxXgSuOEc6Yti1iRWODjvcg9hUsntjfL78urkVc8L+vCuj590iuGBodXOYklCvKBNTZ+ScmtbRA8ePt/1/L//ZTiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754605632; c=relaxed/simple;
	bh=RZ6ByxBandk88ux7cTVGc7H934uFsOKOZf4+W4kMNZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnAWCR0x7dUidOx/wpqGhbG2arJOllXHhrzRq0X5WMcC27AdEvQI80qtIRplB2gkGCsDFsVPSi71U3jECDjPSgOPJqtTIlGvx/wnYPTDk98ffdGSieoNcJwMobPjzOpye3fMFoJQeiUO81vYjp7+lKvVFDimYqVAwimfIbv9viI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jeT/5BSB; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jeT/5BSB"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e51e6fcf65so8853325ab.3
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754605630; x=1755210430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mlm+CbSwn6oMFu2mLut2qVfYafw0g0hNnuj0FdPPWGk=;
        b=jeT/5BSBstGeX8Si4sPArRCLoGY03ZxnyQ90PLPsfQ2RkUKHtc/ifHLDlPmZsinT8S
         yZ7y6TetR1yuRqR3iQ4cONyPpXJBU4zzgN8rbrCfQxDd+Opt+GwgrUSNZk6hRAbjcb3u
         jFI/h5qAT3JUWrzN66uJdjK9UMSGmZ4ZmW6cPIYMP8Xc+e8iof+LgUAzKffNgkULQOIU
         6IYs4t2K1wpB5OqVojmztTClmsX/CrZU96SrXkcId8ywhkQQffff2mER7Qy2ipGI6fa1
         /iubFzJfOL/vD2wlYjLrR+ZcYewl4Vxhgq3nWuc30iWpO2/Difwio7R22MaueT2W3OwA
         lQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754605630; x=1755210430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlm+CbSwn6oMFu2mLut2qVfYafw0g0hNnuj0FdPPWGk=;
        b=i5kS8eG00j/Mu7M8qBliPzJVAGGFNPoPKb8T3Q36DPt+J9pJCJ7mrs822CvlS8a2Ij
         NcHjyZxbAN0HduRZdEj9rWGsJR/L+y51AtRLd2R1EWM4mhZfCFR0/i5gnig1rjdvcaEw
         bRwJ6Y7sddvJBz4TLDLiVfL1TxlOEtUJXGInvKp8IihLde6P63ojKuaqWhBFyqbWil7I
         UR5PaXG3Gljd1EJZKlpHwcN6tRPWPHC7/5492OFopPtatm8v/NlIcHlLteuXNvRwlCSY
         PSXo0lYCZFF95aEq2RNYzjSGB9dTLZnbxtJKPylY4CTIPvPp4yetGd6NJXDNwU9WLVur
         JxfA==
X-Gm-Message-State: AOJu0Yy+1j7KUEk0uTCT/LCEpGgsIy78VOf0gjEvjJm9h0GGZWvm8zmU
	eBTmb/fbYmul6v4/X68JeKDug1SXyj6ahAngfP2J0oHNrVimUCxUwFHa88jeQbuMDAc=
X-Gm-Gg: ASbGncvkOmJY29FZ1JGGoBT7BOiNWUu2o39Meaf/Dz/cnHQ7NXnLtM6tHdfuhRCtw6X
	SZw9hgZsItCIFbrdb3P+dembUYs8UdzsgG01Q/1iMoWtbKhMxyBD1fH0Asx26zOjYOE6vtqoDgu
	+Bzw+DA/fJgVsRFN7P7jFH2BDuUh2fpYl0IcgFRY+wsKmeWAktXrDfnDX1ql16GN/nIsIFBapGq
	DF/Xf0vfJgRzjmDJhb64r7pAJsZAlD8PgYu9mGWmNEI8VhUvKHriaD01jGsF8nOE2g96NtFdGgj
	xfZpo3UtYMPgi58UaHS/XUn24C6FBc+6ikQLStXNj42qYgCG/kynuNvuPtcA4s4zeCH9A1y77UW
	PqDQTd7jdHjZsZEYxDmjfRs+z08Zjc9kQMuaX72x+dRpubr80+bpZ+Swl2FZrmLIY/VIRSw==
X-Google-Smtp-Source: AGHT+IHLUIrYmsQ5yNO6nQcZQc9HSrxzenzXkbK0eN20g1fRYaK9dkiisAurhJykRrZqXlC2eC0/SQ==
X-Received: by 2002:a05:6e02:1888:b0:3df:3598:7688 with SMTP id e9e14a558f8ab-3e533186e64mr18347065ab.21.1754605630040;
        Thu, 07 Aug 2025 15:27:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3e533cce7desm1181165ab.37.2025.08.07.15.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:27:09 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:27:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 0/9] midx: stop duplicating info redundant with their
 sources
Message-ID: <aJUoPJrVfGS5l9L1@nand.local>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>

On Thu, Aug 07, 2025 at 10:09:50AM +0200, Patrick Steinhardt wrote:
> ---
> Patrick Steinhardt (9):
>       odb: store locality in object database sources
>       odb: allow `odb_find_source()` to fail
>       odb: return newly created in-memory sources
>       odb: simplify calling `link_alt_odb_entry()`
>       midx: drop redundant `struct repository` parameter
>       midx: load multi-pack indices via their source
>       midx: write multi-pack indices via their source
>       midx: stop duplicating info redundant with its owning source
>       midx: compute paths via their source

I read through these patches, and they look pretty good to me. I left a
few minor comments in the first half of the series, but nothing
show-stopping there.

I would, however, like to hear from Stolee on the --object-dir stuff,
since I am not sure if the implementation here has any unintended
consequences. That feature is (as yet) mysterious to me.

Thanks,
Taylor
