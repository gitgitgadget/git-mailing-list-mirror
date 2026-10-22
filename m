Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792662079;
	b=jKfx8So9INVlBKmVwYYHAhCuHywVQXl84rmD+xjNhB6gQmGd43N2JNnK6q7iLyQbL7ky
	 rzSoPEunyiJ9SsFL6B+xih0T1B2YbGC9jat6eJCI1Fi+tIpx6un3zhS2OTFcqC13Yi+do
	 P1biBUjcNJzvAPygtGFF62r1V7aByVl69nV11DMJoxkdP+U2ST+BInCvIZgV4IEP0k91l
	 gJ8TNYkNaKJWAXT94sQ4NcgXtRkrdfr/xVXDax7TFrDpDbhvCdIGojpXiCDnttGjaxtcs
	 FViPDUK4NWM87SeFF8KkN6pc6M4kRQ+O0wYtPnQKr+gTrSA5XrZx3G/RiX7UGYYxzDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=QxbA9lpOZ0Ax/Dy7NPpN7GztB+PeiW3FHLOqd3SP6KI=;
	b=fkBjUXpw9ytook4J0dkz4PFKJfLi1ergUQF0xTUN92bvCUwsrP5GxyP7SCdEo8k92cEz
	 5G8tSub7+/WB+q0oLg4+dToRc5lW/Ol57tmkHWZdOX3bcMYkbxdFMch9QfOejfTQXroVj
	 lwckIOw3D6i/Fy2tINJXwSn+a0BtKuush1nWWScrLsr0GAJ13SzB0mB+t87G4qlfVGEmK
	 635TnxdBr8Y2mk8iz96GxmboHal0PiVLJMzJju6ii7a5JVXwYD24RN0rUJEo5kXohhabM
	 HlKM3Xex7oOmq7kAdIaPHfJDmcmmz5kkgGGqGV1tqJCOj6F/jcsmxkVwAMlb3UP42RA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VDVTiMDG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610EA606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 09:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 610EA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VDVTiMDG
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so1650310a12.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792662078; cv=none;
        d=google.com; s=arc-20260327;
        b=VWuOxYnDBnYNw02ZcR+5RhL/HPvsQa9iA8MwOg/UMaJtxrcarxBaYM5xbvtjYbMq8A
         C6JtY3aOiP0MHOvtE+FZI4COSFzR9J29ktWsEkNijnLQ7U/SnV9wUiwbrr6BxyMElgHG
         FBXId6OODV5FBxai+DDLT3CVPl8+2OOWeycjWM8mZ8THjo2eM5aYn7oEonYEVQ3xfgc6
         seV+7xmKCRKKg2V1nFL55cw1CtWXn4u49yA27rk9FYBJ3aBH2nTLn0QtEIzS62R356ZN
         plzSvamll0COtlBiHxDWMlNxvC3ejoydNirbZHFJxD4BzDe+mmPWlv2YY4Q5cUp+R0Pe
         zYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QxbA9lpOZ0Ax/Dy7NPpN7GztB+PeiW3FHLOqd3SP6KI=;
        fh=xEwNemFXS4bNjoQJ/u99Eqj9SfdLR39dP7gdi9L7gCU=;
        b=Ea+8myr2NbwqQTJssJHli7iNW5McNc3MfkYf71weeYtRELnrNMjC2eDre8Q7R0OQnX
         ZPNa7uYA4NJVZe1bc6loytyDK/JGI4wJmh+MObz2RfZRUetlPMY5ZebKSo+d2AudETnQ
         VwpKbj5ZvKf9xHO8o0TPMfK0vjNOYesW80/8vPJfrfzBmusRGqAtplK67YKIuxiffeKK
         0Y/Mf1JZh75XrO7u5Ombs1KL8Y7ZaWlmJkGD9HDNwVBC75dJL9oPfsKZmdq1kNdUVDCX
         qzdGW/mzQUn8b2MQ0DefFZHeY0TqaEKLKF/NLFsSszWxyoffg39AjMEVskGeiFEl4FVy
         fLtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792662078; x=1793266878; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QxbA9lpOZ0Ax/Dy7NPpN7GztB+PeiW3FHLOqd3SP6KI=;
        b=VDVTiMDGAJd+nY5QGNps7Y2UuWNk+45XK8cm1VJHccD/zwp/LTylGzF6Ab9ZuVL2Ct
         7J1+GxtvVZKu6YhHgHZeHa+aYz0etIHEoTYrXn5r08FooaodMnnpda8oUT1JaFu5EAK7
         zHyjr52ZHvv8suZ9/Axg6kcOP04lexf3/p3wdJR+P1s3F5GnT/0ZDkj7bQpzZbwU6cKK
         nLCOHsD70K15xGdzB8obkO1CNQgnbuyW4TLmaESjiOnFen6JY142O8XgxqnXdBZHF3zh
         mtFMkqe9HHBpSRn/OV31/xcLEc5/GrP+amJZGg5U8yjk1FvxMxF2oHmG2DTWECj9/yI7
         hD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662078; x=1793266878;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QxbA9lpOZ0Ax/Dy7NPpN7GztB+PeiW3FHLOqd3SP6KI=;
        b=yfih5DrzBSGu+dffci8Ht9Xtl5pMpYhhwuZG0KzMrWBoGVXyyYblhBdlkC0fiogclw
         pTsRu/IyAxrdyhyavwInOJyiqeKj/hZKRKDhEZQtDZV1OE0cXk+tvO9l1cyFHMad3xd4
         RwOyS6JvVK3XxKFesaHfe6jvauzdI7WifiZEaSO6Dggp4rCRfDM6vscZ4nXpy+63TZOc
         yfAgAUconZ1rDQdzasBUImOZ82e471pvWYAGEsOiFANDwWuBxtwfqd2ZEmyP0LAHZOYb
         xsaUrpLiXag8wdk1b5GHtcGioS2Q6o+AHe5tbZ61gw7x5TH+OzfQZ3aMh7ZGpxXSJ8Pd
         0Fqg==
X-Gm-Message-State: AFq9FYJeBfmKsyqcgZKq6Y1cnSRZ8UiIBIVY6fdbGBIy0s5VEHRBdbhT
	ssLf71JvyCAWcGfoX3+Ok5EVdc7kosEVIIgs5pHXrTmO8WSYxiV+CvDQQN33MTSBMmltFFuCnni
	nNBMbDMOzH4ArqWttCZbkuHtPSB+DOKFBeHRL02rVFw==
X-Gm-Gg: AYBFou3L13A66Ojam8d0MfryE9hI9UKx5bV7motgzAMQDa2I0FPoZf+6faAUg5hwmaE
	ak7vI1kGa2LLXaKrYelsEY0OdMHUWDVs8qsJgcY77zeRkjACythLKyABBMcgnTPlfik8lOrvtvl
	Zq+pelwac5eQi+CzM7D7EPK7So7ORUVbQbmTBJcrGV0Z+0eXxSWUW0Z/k5niqtFFCQnDzSYijt8
	LPOCK9BLnGzuAu5pflnllQXOpCu16Bd9Owm/B18FwMyawXZI2n3wAdXAnCMEjeHBkvgfSvRkBoA
	OabKe0FtDeNliM8Ae12pQnLQXKFiCHyO/LsKJmWXc0NbgeatEw6UGzd//HFGI7VRmwu7anbgq/+
	oqH2p4jM92Z/yH2DaZnkyObf3aiLXTh3LGZU75OjSzLvMRxbSa+rU6UUoMvAA/be32Rla8w==
X-Received: by 2002:a17:907:6d24:b0:c3f:cf2a:76a8 with SMTP id
 a640c23a62f3a-c4679697562mr455458866b.28.1792662077522; Thu, 22 Oct 2026
 02:41:17 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017225326.7827-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261017225326.7827-1-okhuomonajayi54@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 22 Oct 2026 10:41:04 +0100
X-Gm-Features: AclHuK9W7zj_c4RxV7hI1pTB24FOhSkq7SjaZ5zd9LMYnxIXUhOr2f90jisf3I8
Message-ID: <CAPSxiM9fCTEoQDv09fX_NZCcLRXYaaCdWXPxDT7JZ+LCwT1YQA@mail.gmail.com>
Subject: Re: [Outreachy PATCH] checkout: use repository parameter in unique_tracking_name
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> The function uses the_repository to read configuration and look up
Which function ? You have left the reader of the commit message to wonder
what function ?
> the object ID of a tracking reference.
>
> Pass the repository to unique_tracking_name() and through
> tracking_name_data. Callers pass the_repository for now.
You could be more descriptive more about the patches, someone should be able to
go through the commit and sort get the whole idea of the patch, what
was present,
What changes and why ?

Otherwise, the changes look good to me.

>
> This removes the need for USE_THE_REPOSITORY_VARIABLE in checkout.c.
>

Thanks.
