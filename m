Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFBC78C9C
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815054; cv=none; b=OqfnzjoMhSeA9Z7fD6zMgvrIF/C46lFvBzLOLzlDDukKwzhYfyg5/omUnn8m7AK48Q7899Xex3cyhH3w6zz5B4olR7kFG8qyk+bf8oiC1aEX9I10YSQygkW41rhyDeEoWUC431edBNqRxd9g72m+Y7kosXCAknCHplCNQkw4cTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815054; c=relaxed/simple;
	bh=SlOz5YkNlH5zgnSyuGDnP2KlpTB8f2RDcE/xZ39FSX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0g31t2f63Eqk3W2jFxaGh05DYQcayp66d4gfOfAGibzQ/faxIUTb8vCqKw52KnF6a/pheLOl6PNvWppRgq6xjJaNi+wdjyttUi1ZOCPuGCDG0pyNlhZtwW+2BanAwkHyprsPcbfSFt2MNCA5C0AZ1sSjlgIrujcNjgkChd5pH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Hc1LIwU/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Hc1LIwU/"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6f666c94285so2719007b3.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741815051; x=1742419851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SlOz5YkNlH5zgnSyuGDnP2KlpTB8f2RDcE/xZ39FSX8=;
        b=Hc1LIwU/wFgPUisJpCQoJuVtPMPkQzphsJOZta8nDzFpG1+njyt+05N8Pjw+1yVA1E
         Joewxpt7cx4novtS68tnxeN3B61eIsXmc4P7mFNl+qCHBz7aZYRk8DoWgswIMD4DIuiJ
         tv3E3nTXdkFRnIXi1Zto/s47PzPOuOA0eLsBqP4C6BfDK7iWSY2RAYw9D9QCE/h2jJJ9
         o9qj0+FWbS0IF/n/flTOKBeD/UyXNAc+I56fE/UFwcRYYT/eFgtxpk4osGexNeEWIBwz
         YF0x8O70ZiU+p8i6ywF1tcUJ0JRGcBc5UHTBKE6WUgaTMkzJ4rjVS5ctrORlbwUQQhRd
         y2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741815051; x=1742419851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlOz5YkNlH5zgnSyuGDnP2KlpTB8f2RDcE/xZ39FSX8=;
        b=Gb9XkUMvFllCY3j9FnjZo3NLbdFKtwlAcpyvp9DHzrG1csncbnHXtzaTV5ZZ/SkHYk
         CKc6IUXHsR9EwIx/AO9n4thcf0VjJU6B3eBJAzJjRybdC8bnObtrTrBh87Zg/r1HrX0o
         ZX0SQVzxguW+L0C91MrfsGa3Qg37GKYDkfpQCz97QLUtZK+yWA7JcU0+LhRdXtgHKpQ3
         wC0iVyAcZ2HjzX2BuuDMbJIBmH06mxi5DrlMQF7S213jIl39SPAClimiKiis6tiU8iUj
         brdMCJ/YbLWy7o6lR4H+eCZ6U7zrh8PDjqH6hWSSb1XsdHXX2tv/g123tRvpvRJut0fx
         VF7g==
X-Gm-Message-State: AOJu0YzlOTiG1V8DHXG45wPzleZUhjtF0W4Q52yR3+7OO57e85GVpkqU
	h07oJlrKGtk9uiyAbKCYcs2ADcnCwNtlEz4dHphcXqgAoxUeU+CxDPN8IgJLoUZOt2L0TcEtVp+
	6/YA=
X-Gm-Gg: ASbGncs4P76KYee6WMk/pcULEZ5zXbmkeeqat/uveDCS75VWtlNruYuvImA+rPsHkOs
	sifEmGn7NVY81im86mZCPLzzliKBLwyNPP51oENWSDxRf6IXIaYn0uczAWnroNqzzonNOsBrsRy
	QIYvY9DKkRdNvCO1fZFobqbn1VX7werD6LFLhAxtBPDSmBcqN8K/6qIGz6qmH1MTEnMGn+gweKo
	u0w4bfqX1S6+0hT5c3z2XvI0bvLh9LEp1khborc8aKuG574CdJm6sgypAEg1Ax2mxxHuehSuK0d
	F2frqVsu0ZvsRkgs9/h3Oyljo9t+z1UWvX5BL2IHAILODH1Sq1eH8DWJpQiLk3CvolkzlzJrtQ0
	H+GlWnAZq0tGf4C25LRJ4EpvrFio=
X-Google-Smtp-Source: AGHT+IGTIYRR9jWdhSzgONqfIFtm+4wotfDO7fevz4wxDukMwOIiiV4cngFQjL6kSwJ+4iNR4pHHGA==
X-Received: by 2002:a05:690c:6c09:b0:6f9:8605:ecb5 with SMTP id 00721157ae682-6ff092794c5mr130380957b3.28.1741815051362;
        Wed, 12 Mar 2025 14:30:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a68bdbsm33328087b3.46.2025.03.12.14.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:30:51 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:30:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 3/9] t5516: drop NEEDSWORK about v2 reachability behavior
Message-ID: <Z9H9CnQxvf2nnYgN@nand.local>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309030203.GC2334191@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030203.GC2334191@coredump.intra.peff.net>

On Sat, Mar 08, 2025 at 10:02:03PM -0500, Jeff King wrote:
> At this point that behavior is well established, and I do not think we
> would ever change v2 to match the v0 behavior (and if we did,
> remembering to update this test is the least of our concerns).

;-), indeed.

Thanks,
Taylor
