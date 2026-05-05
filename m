Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF930DECE
	for <git@vger.kernel.org>; Tue,  5 May 2026 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778013756; cv=none; b=JMryR1xO15x/USRlo0SHgyAXqu0OjMIb/XY/YL2+4o5of8JyiXJD+eJ4AjgHqVFCFMqaFSa3bjYNd9z/s7NGOtTbf+LhtZby4WrQLqncc2iZQAmrprCzGV0TeHGsjJTGtpM2G600nmso3hbP2jRcKLwD5C5W5cDam6PPlRuiAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778013756; c=relaxed/simple;
	bh=Cic6bWNJDeuWSL8nZv78kAL4GWRHzFmbtTppXMcPdVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWtJyS7ZthHJtoac5/xYFm3cJfRXBaoxyBkcK8d4xcNACpWq/Xzpg4RBbPnTH4YPZ1KOcb/ECDDG6DjgN1iPQIi16pd7lgm5Kst7AZa9Cnwd9dvFnFTmnbv0tS8zVZfWJXIrIx+Do5dq49QisvLaGhUWWLfplpDi/9l6yjeGDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=N0QPNqVx; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="N0QPNqVx"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64d5a7926cfso5728950d50.2
        for <git@vger.kernel.org>; Tue, 05 May 2026 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778013754; x=1778618554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cic6bWNJDeuWSL8nZv78kAL4GWRHzFmbtTppXMcPdVw=;
        b=N0QPNqVxE4116sDfialzQ6QfM2rMNcSOUWTQxWPZb7XM/Daonej1h+UCebshsTqkND
         KTfA+99bWBxfKK3VxyU5YbJUpgAoKqD8yBGBSGQeFYMMqKND8DNSgE+0Iy8y08rZn9qn
         kMX5pEiA2EwlLtcRhsuBXHCr+0gSuln4y5SBDbgcZJkj7TDYyvGzb0EQbgJ5mYRPhYvZ
         zEc1f0hX3SunxhhvQJhlShTaqq7ov57sb8Dqm0LeyKI3/419UvTOd8/8niGakU7h8Myq
         Ihjn3sKk+Uho9cwMcs4NWrR+uB8W5a2DuD1696owCVeXVPOheeUO4UBFtNCybX+9jEtg
         YjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778013754; x=1778618554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cic6bWNJDeuWSL8nZv78kAL4GWRHzFmbtTppXMcPdVw=;
        b=bTZyYPcF+rK0JF42TqfB+lC1VJ8bI0GQH35RsMaWBeDEvIOlKkGMzrd3UuKF+71muI
         hRlB1Iz9PZBxT5YplZOKubrdDDNSFzpGrFIDRHCpwsPWlO4AoYTRcJpwZP9iRiWEEKQ+
         5GE7TxLzAvZ+hfz5re11qRwD1rlRRbZykgBvY6dXQhoDLyz6GboCH+CLT98z27M5//Ly
         fbZKsv4C/ywJIRRambQ9rwXgfP7lWXmIbhx5mOCtDVoSRVojx1fvXut4fBut3F9zF7ct
         IvAepNvQ7hFJvAy1kZxrvjjJnCVTHTKxQrYuHxLPDhzzVc2NT0dxPyJ7gzOVjDHMo/BY
         EBFg==
X-Forwarded-Encrypted: i=1; AFNElJ+8gDvLhNGRmeFSKb/4D0Sw1HVh94d3LCLZCj7eky5iqzN2xLiQTx3Xdi9FDg9mInaxH1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYlWIw30BneqZR+Ck7lHPEZoqNAo3Gfc7HY6AetOEyMFA/yCI9
	VBYAb4q2vLa8IMTCr04njr6gpzS6bgYQ9L5+AFGdJaWyCm9xvRZDRyFvvFp6yCGNFaI=
X-Gm-Gg: AeBDieuJk1J5sUZPygOefl+pVI11KJCrEzxDEFS+7FGmFYzyn+JMRWqBqD73MJygau3
	/fwqh8Ed3SwLi6WTEWJ88+xD+CTTsCH5VbGSvfjNy3JjHEZKG9VRDxowSrfHV/jhRiOO6t9CNNk
	28PpEGqet4LCFIjcgbgp32zgWqHlW8r5yGgLkz8n8igbP4KNPfDMAAiwN0E1C0o5QeJ473kydef
	OAUUxjC8OWFetaddYCijExBV0Z1gFQhIoMSzrmmjOgf06oJiK99xeyW6ei335vhLWLpH+oDShRA
	6e5mhJ2WBmSjeD4EWSevd0Hii0xDx1GM1Piu2cRmpt6b728O/B/TUkzRpQYyMUoVF5CoHiLPTe1
	T+Go75Xy4A8fXuYJowp8Yw3IHQH92HBxaQVwsQfP08Zzpq9sl5mv6LcTt0oI5jcue7a/kWgGqJz
	erWhfH/gFV+aVT8Dq+y7A6vWwYNmkk4xTN/i+j/tG/D4I6O5Jeers5T7MEondmSaOqM4sugdsLT
	I+IzCdpKQIHmWApDUI9BIAecKDL43j9WWr0BSiQTNHKV8cRJs3xrQtJDdW6JYutFzcoZtmafptl
	k07pAH7/VwxKcYc4wYKUIjrzK/Q/Sx5jpGVAQw==
X-Received: by 2002:a05:690c:12:b0:7b1:2c46:9480 with SMTP id 00721157ae682-7bdf5ed84c2mr9501977b3.34.1778013753787;
        Tue, 05 May 2026 13:42:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66559e92sm68931517b3.17.2026.05.05.13.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:42:33 -0700 (PDT)
Date: Tue, 5 May 2026 16:42:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im
Subject: Re: [PATCH v2 00/10] pack-objects: integrate --path-walk and some
 --filter options
Message-ID: <afpWOGhWJrRdPtcy@nand.local>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
 <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <f5d8d4aa-2453-45ef-bc96-2b94bdf55c7e@gmail.com>
 <afo+mEITFBSLevqV@nand.local>
 <07b36bd8-376b-4a98-a735-0c0f75452c24@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07b36bd8-376b-4a98-a735-0c0f75452c24@gmail.com>

On Tue, May 05, 2026 at 03:44:56PM -0400, Derrick Stolee wrote:
> Thanks for this suggestion. I got pulled away from my investigation, so
> wasn't to this point yet.

No problem. One of those things that in the course of responding to your
email, I had written enough to fix at least one of the tests. I hope I
didn't step on any toes as a consequence.

> I think the initial idea was that the feature was too niche to add it to
> the CI builds right away. Your series is going to make it a lot more
> important, so adding this to CI builds may be valuable.

Sounds good to me. I imagine that this makes more sense to place as a
preparatory patch in your series, but LMK if you would rather I place it
in mine.

Thanks,
Taylor
