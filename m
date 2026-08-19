Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0103D45EA
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123577; cv=pass; b=V5pthJZ6PkazCAAZOLQx+cY4K3JEKDccoa3MX2UpmMncm4are6tyPXo7TGq5ROI/PAUaMS4urPrSr10ihHCTH1k19knliHEWzyXjbhFyVzTU3g2bw9112a5lcYU3XTYREn0qGEo+aSU685hBZbej4wQefa1pLv2Zl9qj32LmKPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123577; c=relaxed/simple;
	bh=/I8xJzL5zIJup0LLQcw8UnGdqoFToUzPMChh1e1QoOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1kru2TOtc+huDYzr949DVaTesTyLgozvLD1eqCF9X0tAa7XhWL5IkL8EcnKvoAMHJNTr/uYCd8k8dwtXur3M80dEQf8HMc35XDAEjSXAoeoO6ZJlcPOnmbGIfX8v0dcoUkQPwm4IpjWwibPb6WkO2HbnquIOw7knSDPgkXr51M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka2Bz10B; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka2Bz10B"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84eb992a881so641560b3a.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 00:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787123575; cv=none;
        d=google.com; s=arc-20260327;
        b=jgGsQJk8qbMe5OGN6m0X8XcSSTms58eF7GpNYrt6bkLC7UkJpFpR22dTxQ1qRtVhuu
         dr7Ty4wTOPb7eRvFBrm8qU61lxfqzY+wDSzJso4Gg3E9kY7GXtp0nykmOIIhITfBda8W
         Y4Kv+5tbvm7kirquE81LFnf1EsDH/RAebebxnDvHoaZ/yukWnx+5Y1qVF6/MGWKUmwor
         npmOGDZqgCYUYI4BU08I6Uk49c2ZrFKjg6tNh5OSCZ5YKoz02r014yER+zakOKLsJGmn
         BH2Hu7Z+apUJDRPowC1DRYwypBmCkHQK1OlobsQdN1DC/O/R120VDWxwqACkUBaUpmJv
         ZotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/I8xJzL5zIJup0LLQcw8UnGdqoFToUzPMChh1e1QoOc=;
        fh=xFkGNlwBTIbSQlTAuP7IICOn+9qF32ywGtU2a0gtYq0=;
        b=g6dqzcRF+jJ/MbJKMJ4QiwLXPTXFqb8iA9KQcpEjpefR0FGX9AY+H+P57ZG6nwfaEm
         Zg+H5x+NxjF04WfTkNMFiQivUFc9SXcxZCpxWKVHUvCPNlTPgyTsozxXIL+2ySSHyDx8
         IR/sRwFDVrMxzGKi3ldcd3orI/wZp6REEzreOYAkx4SG40DR28Dzvnr6REy1E6bO2B6O
         K2EpsCe0WVH5cIRef+h129Gjp6QVfyQ9TQ5OP8dP5af7yrdlTgRkdekI4nbpO8RVdcYG
         mPYaAPwvq39No2Ra5x/y5MA6AfF7RdnTKGf5mDEySLu2yu9xP9ZCv2rt5JT9PYOXzelL
         Q91g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787123575; x=1787728375; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/I8xJzL5zIJup0LLQcw8UnGdqoFToUzPMChh1e1QoOc=;
        b=ka2Bz10BTXN8o/Lk8bCsRuwB2eALOcj8BMjSuWrFzKJMNi8QcLRIdSx1lT5Hplff1K
         ipL74kaozkVBFrdB8nUcKPuyGi3mHBd3mr0WGp39QCRgF6xij7DMvdBlaVYMcSs4JCNS
         rjYo8vNnpxigLTxyoqSE4xg83vZBRXztjGhveRQa2xQ6S2xDkJ7o5fkEZP9uZBuIzLbu
         GFZVXlAKgjvuRQHIdKLF9deMK+F7RKSNzLdXerCGBTZhuvazHFZeADTOJ8ZCkrgib1zi
         jKFIMX+pwBe7vK9und3ndbIC44NysA9n6N0H3Ftrv0AIe3MYi1aT/pZU8T3tcXXoQ+iO
         SDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787123575; x=1787728375;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/I8xJzL5zIJup0LLQcw8UnGdqoFToUzPMChh1e1QoOc=;
        b=oQk7PtAmj6Zzp/yRuwGzAfJJwOMb7QfVT5Dy/YONgr3U4fzAllkPw0BRgRocaT7mSL
         e+IbnIXb3OMshToSb1ZT9WEjEL+9rT3pNCQdnch+il3WGG/g+0Gl+BkwVYcr6T/SkgnV
         22qV2GyajQjSUPINFZlW0HcRYICuN3zlpmMrIfKyHCZEYhaqbPGb0zTdsXIIyBPfLMlV
         Ckx2PYIYhRSXjAUYicZEaOPfxNPedfBqzAHvxTrg3rHAdgEMAEC9TvQVag+FHwvCWq9X
         futuQfzBtISic/W5sANo/NsGqoX9jSRC2RgYlKY9UwwalfijstEUCKIkiXY7bY/2YKOP
         aXXw==
X-Gm-Message-State: AOJu0YyGTcqcTj5McOB2U6l7TiUDbvguRFLo+wvLfUlp4+fX2kTr/PKi
	Kt80bGbAxyEh173KDK/sEJBin/MGHlczqn5WLyJ8W6ZDL9X2HpWe9MObkJN9Pa5cSubr/SAw8Gh
	dujcJWwmcti0M3eaJYzU9ztP6QJcuVz8JJqADot0=
X-Gm-Gg: AR+sD125ma8Hpb0cT6ZLuGXNnrs664RvUG80QBPDxonOy8UAtrqchyilgQsz/L+Rn8c
	T3PJPhJImzK9CBGzszcexISUZRed5HZvjcDkoKhGwuUBjxWg97ZCdLXx9Rl6A/cJkhHG915b5kn
	CfZtfAyK8e/AAd2sLw2Be7TSC5DR1XottbNfr9IVCt1wDUjDfUxwrChuf0ZLzrX2sKLbLa/ai5O
	X6qHj6dVdr0xpsb3PPAegYFM42nOc+tEmROIuuG4OUNhi/jGubfg1PLjr1FdHISH+3KIbUph+Oc
	FYz67dTg3pSZx9MN0z7HCq3ZsMWBM56tQBAxyalXvLBoc/WqbDNnLYLx4QWAmOdckSl4ZhzWiLO
	LJy1oROMW8hNFI66iyBwD+rvKcGQK4Bu9
X-Received: by 2002:a05:6a00:3992:b0:848:2e3c:9955 with SMTP id
 d2e1a72fcca58-851d3808a02mr3614679b3a.4.1787123575370; Wed, 19 Aug 2026
 00:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGWgyh_WJ2mAgbJ2agp9UQm8iyR=eq0xWjdYT59CC9fZTnAbzA@mail.gmail.com>
 <CAGWgyh-Udy9p9yF_8EDnVgK4bxyG9BsX1gio8oKr0G9b-sdQFA@mail.gmail.com>
 <CAGWgyh9154HAPs-YoMz6G02TfcLe3CCcd93TJjg6e+hQsmZxVQ@mail.gmail.com>
 <CAGWgyh-fXm2WdAqZDjYeHAuucniWnoathQvsFP+rDsKvxrs+eA@mail.gmail.com> <CAGWgyh8ijbA6gUcSgdkrwRtjSAfYbpfU9WitmcnFAr-ObAZ+RA@mail.gmail.com>
In-Reply-To: <CAGWgyh8ijbA6gUcSgdkrwRtjSAfYbpfU9WitmcnFAr-ObAZ+RA@mail.gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Wed, 19 Aug 2026 12:42:18 +0530
X-Gm-Features: AcwNN1X-nWVaelJNBZ6zT2MJIyYcolaH9U5nDAJ5rC5SAUawNXx7bp0Q0iCC3CM
Message-ID: <CAGWgyh9NjgXgJcrPs_1rWc-8U-e3XbvcpnHuSQjc8dv+7kX+cA@mail.gmail.com>
Subject: [GSoC Blog] Week 11&12 : Improve Disk Space Recovery for Partial Clones
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

My blog posts covering weeks 11 and 12 are now live:
https://siddharth.shrimali.info/#post/11
https://siddharth.shrimali.info/#post/12

Please feel free to review my work and share your feedback.
Always open to discussions! :)

Regards,
Siddharth Shrimali
