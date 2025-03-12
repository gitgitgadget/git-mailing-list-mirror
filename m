Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43C15539A
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793607; cv=none; b=CYhsvASpSKL+JH3Yk3eCqiM/ZZUrcLQAJEQ5RGFYeusCo3MqmlaC81sukykZCiK+CHFwpg/eMtwRo//A2RZE0gpUsmilHmH4C/QGiSoY4CDA/8oGSLOypLN8pN+3z67xVn2/x5FlYa3RkJEQIVsuunFJj8qycTiJ4BJDCSNl3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793607; c=relaxed/simple;
	bh=+1q5sntUtIodL0w39LoQesm/z0GSXHI2wSvkFDJU85c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev/EIyGLhi0TASXO9FIlGefimtArSbEbuEYCtLf1RmbCEOygnKpoP2vOfD5vzkfxZcHJ9lh6APNw+AmIJkFELk3jM1Zz+IPrCQU2m3bGnGPkT77dATn2vw2NkF7OtAFHptGAFe4waVqcHBa1jCeS14+jUSAIY+PzBBLeb7RFFgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NHHQodLw; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NHHQodLw"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f754678c29so68481477b3.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741793604; x=1742398404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGZJq53BIDf3b10e9zitP2ux5GNwcN2PJ7hVCnFVsmU=;
        b=NHHQodLwFxggGRtLAf0il1EaVk3EMW+yFE4axXkiX0i2jBN39tWvqvahhS6hHcQo07
         LpeMxvfdCyN7A2fbmcXsdpINoGlnRAyipJgG++AYLt/xMJI6so2q1mzEGhU+AzlE7pzG
         9+cH8slNMSr4DvaqBcRM894gDTtK/Qhedf6LOjsa0Jy1m177saeN3QpUjNgGO/Tp5CkQ
         SCOLACOUOun/MtF4LfGrPRzC4T7GIQXLNJEsesGZUIp7pfCBFrq52kk6PdHgChDDWBNt
         W/bowT9qy09xThGvmJxCjUGe8UR76I/+SYWlHPpNpvtptvwMcJQ6uVHLF26iRZkHcv5X
         1caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793604; x=1742398404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGZJq53BIDf3b10e9zitP2ux5GNwcN2PJ7hVCnFVsmU=;
        b=bd7HjU7k59/kDdbJfoO5bwDvAtc5nKNYJ783mNy0mxWJPTh27WuYCynMM063JT0HLR
         BmYOaZgpDyYY74UyRrqNuRxgV2nolgMoU0B/X4my3vV48LhVllLB56n9YGMFRnF2vPDM
         G/K6JwshNnUnMGwAiOnYTbtUj9NlauOgG6i8nQ7I6O8mWWW0C5WPQ+JgvDb4dITel3ba
         LjendSFkg+fwIP1LPBbdEa3Kqr6xN/QzxBsazbaGSHnD0wV6f3R3ZN02AHv3+vyVmpWX
         gtRlFyqUnH3uqVNmUdmj6bS+n7wzuAeMRLHOrQsczMue/8X5FwBbRbQHxtZXLA9df09J
         WcXw==
X-Gm-Message-State: AOJu0YxXjQ89NpiZ5VI8LHlv69TTv0QvFpeIjECf9ZjniOanShM50enY
	/lRI76hktwRE3SbBHQFhgXKrIfqK4rb9oG/Ic6ySF99vhF49q5RwQoDjiB5B7hk=
X-Gm-Gg: ASbGncvc3fgwdhiF0iT5nFYPl0hoG0Xc1ztBCOEKXXSYCm2GhTu4paJ2kFUm5OyfaMX
	NfYqSEh5mO/zKnf/eAsebsfGoKZrw2HRGZN8oqJpRe7Eq/tJcC51jGQIUmnieXyANith4+PWpkV
	2YvwzKVcnkb9NTFpafZOvQ4BvXjhLG27WAbSr1zFqkRmtEu8+wVBe2qeInNvMIN0WHrFeFDwZeJ
	qwo/fyhmfHMLonn0PNNXZ2XZtNM0wEG4tMH0rISAiji+AX4pnXSdeWhQQQQmRC22Pg0OJiPtBvP
	zyk/JUTI1t9I0oKXyvaj7+BAe3Uwltw7cj7JxRPxf0qdoGWET7d+Qa6Dy/9t2kSqSo25CaAzDYB
	kzDOjLCvTig08U3wl
X-Google-Smtp-Source: AGHT+IE6NO2RR9ZOxL7WPeQKcdRZ2VhS1bQyqK7P/fqNQtNhWe0yMhy2VQVJdJo1Tr6TsCbq3o68zA==
X-Received: by 2002:a05:690c:d1c:b0:6f9:776f:71d7 with SMTP id 00721157ae682-6febf321f2amr325681567b3.21.1741793604207;
        Wed, 12 Mar 2025 08:33:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fee31db510sm19140477b3.50.2025.03.12.08.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:33:23 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:33:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/6] pack-objects: freshen objects with multi-cruft
 packs
Message-ID: <Z9GpQqm4YBvWF7Ff@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
 <xmqqr0332un3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0332un3.fsf@gitster.g>

On Tue, Mar 11, 2025 at 01:13:20PM -0700, Junio C Hamano wrote:
> > This series resurrects the first patch from v1 after introducing a
> > behavior change for 'git pack-objects --cruft --max-pack-size'. When
> > given with '--cruft', '--max-pack-size' now allows pack-objects to grow
> > a pack *just* past the given limit by at most one object.
>
> And what happens when the last object appended is very large, like
> 70?  Would we end up with 270 when the threshold says 200?
>
> I still am not getting what you are trying to explain in the above
> two paragraphs, but in general, "give up just before" would be a
> better choice than "give up just after", exactly because the threshold
> we are letting the user to give is the maximum.

I think this is similar to the discussion earlier in the thread, but let
me know if there is something here I'm missing.

Thanks,
Taylor
