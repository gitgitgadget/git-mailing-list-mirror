Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12234028F9
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723380; cv=none; b=OjnenE82LEc7cA+QH+OoPZxLOYYXtIPiDivKJkB5AqNJJ7Qt/qDun/LoWSYfOvpHJXqml8O+8X6cTJZiSo1J66Hb8xyPgvPuVRa/qTArLmYa6hTW9WnA425WFZteqA3Vr/g9OCmA+58f5YuJKFzwiJerG4yq+XXGuuI0KYOYfL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723380; c=relaxed/simple;
	bh=PLlkUZ26lRN77yKYSlz/Q5aR26zIWThLo3iGUINbC6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+jFUlYytMHXN5mo6w7nYKH5oCGoxLMur7JKhv3gVAnV2jQqw9vQzOhn38W0dKBL9os+dzndTyTRdOuHrW7eAXBcV0OHgkD7UWzzy//eGXrt8vA7WeRzBXCZRN8mc2GNYaTMSLpU0NKgDOknej0D8Np2cTINyOOJvCQcbggjM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=cEvGyQfD; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="cEvGyQfD"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8efcef23d21so11213566d6.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783723377; x=1784328177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q2dn3MYf5VTXJoDtq6aKcv451hUySX3RR+yVGaFEuZY=;
        b=cEvGyQfDuYrQj6i/LU2vT7mQl17TOcSXONjwoKd+H5wQ3u1tVdUrT9l/YDlOQL7gLK
         EFUzlJi3FJJFVo02HlwVF1CyR3s9N7tHYqaUh2MNJwCyu/GLWFSZWASVpv4BmGcFWx0/
         lpWPr9lhFlJu0eIY1w4hbJ61QFrLmKOuNNIL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723377; x=1784328177;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q2dn3MYf5VTXJoDtq6aKcv451hUySX3RR+yVGaFEuZY=;
        b=VTvppmsMdp64OOtluBBp1HS1d9bhKhfUgW3zkmHhvB6jmoWgeHDQ1sl1W+wecIYgmR
         B0f0JKlKXg4Iu9/r93AWRp4f8+Pp2NLxIgQKzjP0P4KObLK1hiYCW2Fl0MqqjTrEmkIb
         XjTNI2hE/JLMwv2FBxfWpYwmTVlS3HoOTEEtttaO5Fq+SXhT0PyzheI0V3Dq5cSLHEKL
         S7rKhjT+WfKnriSg0NSyNUZQLERgI3wFqV+br46JWwEteUcIOiUfzNVrO8I7waRfU6tb
         Z8yLLm49P/0rHNye+IMy3Z2fbJon/vkNUgiwKGJVUUUEpMj4wg80eGGtEkvmEv2M0oFL
         U4mg==
X-Gm-Message-State: AOJu0YwNxoMWrJ61suAS9UrEvEtyt4sdLR1Pn7Do3AIpcaXoFs1fsy1b
	h81WYAau/PDr/U13KQGJa5ozok9Jsx+Y6WXn1tC+29nglAnM0Kdl5kUBslc6V4q4Elo2ill2qqh
	vBVX5ncwi/A==
X-Gm-Gg: AfdE7cmD256PthY+hrwhqQozhCp45tqc+J0vvBV/iokpeOzkgTUo/N5sshcbmkrHcLL
	dUdgBClluNXTnjWeuH0kkSMkaDvARbWG3fS4t5OSOQbVL17YcpEiUbJ14toC5Hcyrqps38+gSqj
	rHzWL6q+MMO/EnrSdg5aLI9bvbemf5MBgJSQ8w0aSb0U31hSlWtNYpaeDtXOCC7oy9UhZKiIG5I
	8NNlmDqxx7dc3DHk2OG9pqq03ugYD9tUIhcBU/+qgAl0+p8viXoF0LwrdhdwDztruF7JKAyoxoU
	FS3NVA4YaKwZzbUjcBL37uJ8BL5IWAv12skWzUa4WMx9EooByH7BFeM6uBuscvDvp8EXepG4A/B
	4CAtd7OqzeA/MeuhFK+ebHWH3qf/hOP2jz/e+19DcqRevig0fjApYibicaOIVTHbhfYdTK397zh
	xz6VjbusEeDwGO9o3scDQ22AAp
X-Received: by 2002:a05:6214:53c4:b0:8e9:f62b:bedf with SMTP id 6a1803df08f44-90403656036mr13330666d6.47.1783723377600;
        Fri, 10 Jul 2026 15:42:57 -0700 (PDT)
Received: from com-79390 ([209.249.37.133])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87cacb8sm51533306d6.49.2026.07.10.15.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:42:57 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:42:54 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] odb: introduce object filters to
 `odb_for_each_object()`
Message-ID: <alF1bmRwwutpLQ7W@com-79390>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-7-3710a9cc165a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-7-3710a9cc165a@pks.im>

On Fri, Jul 10, 2026 at 10:48:59AM +0200, Patrick Steinhardt wrote:
> ---
>  odb.h               | 12 +++++++++++
>  odb/source-packed.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  pack-bitmap.c       |  3 +--
>  pack-bitmap.h       |  3 +++
>  4 files changed, 78 insertions(+), 2 deletions(-)

This all looks about as expected to me. As mentioned earlier in this
thread, I am not as familiar with the pluggable ODB code as I'd like to
be, but the patch looks plausibly correct to me.

Thanks,
Taylor
