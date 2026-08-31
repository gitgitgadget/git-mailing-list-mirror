Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533C387569
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 02:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788143645; cv=none; b=NHQgLYU/Ix0LpXWVdkHNqPdJ9RyNukiTSINdZDNwp/kukr+e/uze13+8JRR2KUh7gh5GmlkMOD9AEtqXNpIQiNAvEViITK9SjOm3I1oigoDmVLiKl1ZoffdWHFEWCazIX+6rNC2m7VrSkBl/B1zvNCA2gNa4y91Yxo87+hsRTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788143645; c=relaxed/simple;
	bh=aCXNZl7BYF955cs8YiEK4OcfxDkjLok700cJPa+jzlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDDIiV378WXiGL4DkpDv0ammoyqEiyv9p+/9D2GuSYZB4iZ7pV+g3DB4VioZSD06GpowzWWAS3NmIy8eZQEg3XWd55Tu9INGTZ8SDPWnS3terHvLbUD/kRfTLaieud/r2fNghrWyUj7S5+f0iRo/Mwr/uNiLe5a8kwzmztmwClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oif7QWaT; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oif7QWaT"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43b7e186a0cso1417864fac.0
        for <git@vger.kernel.org>; Sun, 30 Aug 2026 19:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788143636; x=1788748436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dQJnhe8SXN9CH4yDZmal//LdAMO10QpJon4NW36SMLU=;
        b=Oif7QWaTtjijlB9dukkyieAyPgYzIwuO6Mi35iQzQlqu6rIui3S/ZQZSOMBwjy2Xwt
         Ip7Q5PDZmrzQbJReY/W/HXWzLp0tU8w3KN9qXZEfZZZufvFl1jYSpMfexSFjeVWY7yRu
         cEjCY46bEX/UQ0AHRsDrcT3lJWuEsEV78SAEohKapqkUMWHYTMmNjIiYLFoyqmWJs5x/
         cLhJgW0TLZzKu8CvwXoiRnwlvEX25iEJHsjy7J8jvJ7qOdwpEuzJTck8UXiAKLtSugWR
         k9xXdJ7MRqrvA2zJMo4pkZualtOcAkp663SxldMbQ5nqmWgFxawlDB3EBWd+IoNZAbN0
         g6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788143636; x=1788748436;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dQJnhe8SXN9CH4yDZmal//LdAMO10QpJon4NW36SMLU=;
        b=A72U6MesHcABSldTbvs9/w1j/va/bynGcEuJeA7fbvERmyhU56h6/aXxVDRoUjh3bl
         WRqxZA884pUTHqu+iSLPDDGixXJgYya9PD58+yOq+2IpaFcFQSGuFH/s0n+54/80cxnk
         gGaeM0M9QREg7gD028He6UCeGbU1IpInT7D0QfJGD7rH11OuTez942ALlyXtkYGJjyXA
         bKsF1FdF5eBUBkokho+FMFWwXQaWEUoYQfjvoFMCjcJyPs+VQf1CfYZMUcDnUlbFeJAE
         sl8IW1t6z7Lavp4tySB5cA471PxiRZOZxSVsQh7D6TQ2fU7noajQjEHL7kzdti5PLatv
         3/Iw==
X-Gm-Message-State: AFuF++n5Ddv2tM0D/Bhwo3+HNo4DEWNHe1kFoy1naSH5bMm3TrxVv2wz
	I1mZh/UXpo15OF3om22YQ+FftAczHM1qMfrBWnNCJ2+iMOiE+hAmUQVLDeuayg==
X-Gm-Gg: AYBFou3okRFHISPhnf8lQnqsHQArboeactqWcBoh4mKo5mRcALre6g/94s5BB02neiS
	ziwsmz5dz1g69uQSu5Fna0ui2DiBf7ViyiIavon1e03pF68xgVLQiIAtFbzzO3g3+RuUfFT3XHm
	EEsxOPZ0s3F1AwcE5jiy0w0NmYAL6UpOxE1gHe1R6t3U/woXXvfTf8xO53Kjxi+SpL+G/CjVV50
	+an1Uw1Nc8P6BAxbn36LzB17Q/coi+HsVU0zsSblcALzaer3G368RYcuwPjvUpTTMEUSCbUcZLj
	1FyUoEESLlQ8iHjOZ7TG3IsUcxhA8Gm9vGyJ/zPc0ZTMeb4RNNWxoc57uthQoncxFaLyTn5tFwb
	+h4KDDtKrv6wbmO3WYWf6RiWzV8mIvn9kU99zRhCWWua2fLMDd6IXvrbT8CoQ5RdzizAVEJCO0n
	lBw3gyOGX0bj+oI/vJjbIB12a4etvZUDD0QWHWMIZDWwjmF85MYxqUzA==
X-Received: by 2002:a05:6870:8242:b0:46a:dfa7:8410 with SMTP id 586e51a60fabf-46adfa78540mr1683055fac.2.1788143636133;
        Sun, 30 Aug 2026 19:33:56 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-468a5459a89sm9354090fac.16.2026.08.30.19.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 19:33:55 -0700 (PDT)
Date: Sun, 30 Aug 2026 21:33:52 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ted Nyman <tnyman@openai.com>
Subject: Re: [PATCH 0/2] fetch-pack: allow parallelizing packfile URI fetches
Message-ID: <apSpaLf_Pu3G4Nqm@denethor>
References: <20260821-pks-parallelize-fetching-packfile-uris-v1-0-0df52d9427ce@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-pks-parallelize-fetching-packfile-uris-v1-0-0df52d9427ce@pks.im>

On 26/08/21 02:31PM, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series prepares git-fetch(1) and git-clone(1) to handle
> fetches of packfile URIs in parallel. This can significantly speed up
> fetches when the server announces a bunch of packfiles, as shown in the
> benchmarks in the second patch.

So I've been working on a series to extend the use of the ODB
transaction interface to also cover fetch-pack. As part of this, my
current plan was to also refactor fetching packfile URIs so that they
can be written through `odb_transaction_write_pack()`. I like what this
series is doing, but I wonder if it might a bit more straightforward if
we try to land transaction here first. Otherwise, I think we may end up
having to redo some of these changes to get parallelizing packfile URI
fetches to work.

-Justin
