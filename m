Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BD321B185
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551387; cv=none; b=uKlWv97s+na5a96H90fsJbmwJLszvtMfscv+ghmBwp6R0OBbHbB70vf9H0SvGtUzUpbUG8869G8Nzqek77hTkIgDfc9Y2140xdJCjzfSS7Al/wtkQ8rpZUbtD6cDFRtVo7Uo9PVxfEjUVbhY5/NFFLVuaqWuF5PhnXwZw3NQOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551387; c=relaxed/simple;
	bh=3eONVIQnRhHrhYu/j+3cl+NAFhGk2Cy6wY65DNmTncY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ghufa8fg4JaAGkB8G0/5ADmPA1M+/GYOZbiKb6tXkkT68+vR0avUf7QDasre2tW7tDBSwZ8evZS7VeRQZ7Tzb/ZpV+KLwz7J+t+pLVHLCn00qOXBiwCnfsoWTguJb44It2vspz0C6B7Lhdg+5q4vz+hC4M8nOOyi46nokmi/r2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gxRTSz/F; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gxRTSz/F"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-649523de905so503727d50.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 14:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769551385; x=1770156185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3fZ6bixlRt6uu2EdZSgNiXydSEHg1xlPxNQUA2vXlU=;
        b=gxRTSz/FaPdPMfSUlF04gf7rTdJWOPH+Qoo8ES+OPyBgC1xm1qOZS57tsHMVaPOOFL
         IHgeo0t1dVo74f6OJzsA4En9PdnC8Xr0Xc5T1xVVhKGmFRSqHFPE34Mnyt3eBq8lDW7z
         IWdIaVoq8sikY9CJLRUVeEls/lhG7pXOP9MvoYm0SZn1qzexc0QXahhR2dgIotwZGe/D
         GS1lrEkIfPlu/JgWpWAaTtvplkNh6BkxSmBMcYbVf+DLK5oUkxUtcgbcZ5HklVt2xwBw
         x3Iz0PUtmoPYKZWNPupYu5aRm3jgUW9GPOHfZ3NOo+T2AEI+9ixBv2X5XoBa3iy+8j9I
         LyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769551385; x=1770156185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3fZ6bixlRt6uu2EdZSgNiXydSEHg1xlPxNQUA2vXlU=;
        b=OkK0uCmDkVW5VFyUiSVg3RrnERpnOxuKV/zGEaF/aV4MYX+1Of8K40szQTIl7teHmV
         dJU5B07X7jixtcgoll7r5+Wn1fYvAN0IoIEWsxSrfDr8Nf1mwcmbyIDu7YNc+Vt0oRH3
         8jmQrsZDHiBqDlR6l5ZkeY5H6VDpjmO5qu5Ee4LDWDET0a8O+sFwHOPapty3jUE0JElB
         zpiyCXQXqoC1yYz7lrNwdw+MDX9qE3360QoERX9jMnhrZX9Od4XzM7L/Br1hlAYfIbqR
         bDaqhw6MpGqsZZCdE0l+1lotIqYieGRXWL5agZ7G2fTjL7oxVLEi4pLyJM59hDSRrSJk
         ndxg==
X-Gm-Message-State: AOJu0Yyx6aXNuHlbHLoJjjN53eHAKWSOmEEvrW6Ut0FKVC+28hU3QiYC
	jmh9t5MrecZtBhOZg3yDvZXIcXNGdoVUgIeZU1OJe0lPu7dBUfBZJxIt4jv2taVj8nDgomQztl1
	xEj0zFB4=
X-Gm-Gg: AZuq6aLhouaArr+UH4Z5sXcdi8W0gTutyRiXmRqKfhjF0Bi6JwkJO6OVjLq7YnOarNU
	NxJaDvijrQ6HtAr2yx+wz+u/yyImeU869+Fr9Wm77yMtm2Yhwr16gHnxQ7sDXcatGrYZjFwKfyD
	nwE3r41QBcjFacpSn9Pw+R1f5Qg+bEVuFMtsleD4CLZsNrsNYQd+xIfy0YkIe9Lkug7ke/mz2bQ
	1Q9Q9kupWhj29mbJOI+V/gUY0kMKc1RM++648cxPGZlFySmqU9yjvjX76q3yFu183SccSMAcKg8
	SUi4mDBApuP6iSXDHBn5ysb9TXYvntPVfN5mU1QJaYRE4busGqB+NEdBerKNCJ/SzzrMCUHEn+X
	joXAL9mxpcO8XAHbWMEHH21njT1ETKej9AYBSlGUW0oAa1DItkG+Ji0AzcoGviDIsLtLFeVYp+o
	MD8ZBjQIAJsj2oBy6awXEY3Ml1OQ9p8/YwtjZfRlWnMAWPkh7ucqsDVPFFaqGCICIedgUyD8vf+
	IyHKxtNXL+Dr3Ae7Q==
X-Received: by 2002:a05:690e:d08:b0:649:5789:ded with SMTP id 956f58d0204a3-6498fb06c9fmr2182208d50.29.1769551384866;
        Tue, 27 Jan 2026 14:03:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828d157dsm2998937b3.40.2026.01.27.14.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 14:03:04 -0800 (PST)
Date: Tue, 27 Jan 2026 17:03:02 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <junio@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #09)
Message-ID: <aXk2FjTUMMThs5Kp@nand.local>
References: <xmqqecnbeyvr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqecnbeyvr.fsf@gitster.g>

On Tue, Jan 27, 2026 at 09:42:00AM -0800, Junio C Hamano wrote:
> * ps/odb-for-each-object (2026-01-26) 16 commits
>  - odb: drop unused `for_each_{loose,packed}_object()` functions
>  - reachable: convert to use `odb_for_each_object()`
>  - builtin/pack-objects: use `packfile_store_for_each_object()`
>  - odb: introduce mtime fields for object info requests
>  - treewide: drop uses of `for_each_{loose,packed}_object()`
>  - treewide: enumerate promisor objects via `odb_for_each_object()`
>  - builtin/fsck: refactor to use `odb_for_each_object()`
>  - odb: introduce `odb_for_each_object()`
>  - packfile: introduce function to iterate through objects
>  - packfile: extract function to iterate through objects of a store
>  - object-file: introduce function to iterate through objects
>  - object-file: extract function to read object info from path
>  - odb: fix flags parameter to be unsigned
>  - odb: rename `FOR_EACH_OBJECT_*` flags
>  - Merge branch 'ps/packfile-store-in-odb-source' into ps/odb-for-each-object
>  - Merge branch 'ps/read-object-info-improvements' into ps/odb-for-each-object
>
>  Revamp object enumeration API around odb.
>
>  Will merge to 'next'?
>  source: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>

I have some lingering questions about the mtime-related changes. I am
not opposed to the series in general, but I think some more time to
continue the discussion in that thread would be beneficial before
starting to merge it down.

Thanks,
Taylor
