Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C539449D
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020151; cv=none; b=sDqZZPSTvbwXRR/0HcH2V61m6O3y6mCYT6+yRTuHFIZBnWdTgmzbyCeZYBGsDFEcTgI0nt+OTHckPIiXFl6+d9nri7Piay111Uink4sr5DrnEbkhz4A8eZe1ANXoiJ6Lm4JFNOSCXykGLHsqHUCIlDefFHyKhrKGGzij3TFnrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020151; c=relaxed/simple;
	bh=3dYRHMkH2MsOS5p6OhkTDH90aUkN3Wq7RlVwz/V7fpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P8f7Urgpqsl9LQajcD3wC+z15KB/AoGxdLhgRhWf6E/FKWt6GneTaeMW/8/FGzkp+V32io06Ogc9jjFaWThkMy00nd7M4hgkWemLdJESvcVRvKXdS3oXvrg9f31iWcd4Qcnc3Q0b2SW6x47IOxrT8g5AdzydHV+R2klAXs47O4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cz10+rlP; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cz10+rlP"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506aa685d62so38929041cf.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 03:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772020149; x=1772624949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3dYRHMkH2MsOS5p6OhkTDH90aUkN3Wq7RlVwz/V7fpE=;
        b=cz10+rlP8jTfVjIM2+20RBssrFj8K0C5DBS2j3Xspq8i6QYGwSpVFaNipv9pNW/OZ+
         u7ak7EYzxlzKQ8GqxXCON2TtGj2i5I+/xgpDkQqYDLxjwTutluKqagGIV6Rksr+7xo4j
         fDoPFFwr6dbRvzkE5DWYIYkpSLckw+VaX0dMpWn1Y59fVmVK+6dgx6jaBpCx5yQO4Gs2
         53KekXembibEBjoafbgyPnyjnXgAhUvqTG2BfTIfaANF2vMDR1iDBAW86vrfk1V0qhpI
         Qpssu3e4ZYxoQBjEpWDZVwOvcfiaotIOgSKQr/Im/xdibfEIvYK0WWP+d4Hqg5jBjrC4
         guJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772020149; x=1772624949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dYRHMkH2MsOS5p6OhkTDH90aUkN3Wq7RlVwz/V7fpE=;
        b=EpfsfmE46rbJ2+msfiCWPeJwEBDt11p4L5ucd1c2alUkCtAs8WmHGZr01aiOC7abqq
         16Nra+29CsVUEnCiOE4vusv1hMx0Bd/qJO1iwD7zWCosghazxCnHR0cmv4mJrhemJnZJ
         bzrJktnfIxD0oxz9fEA+bebXM8TotyLoHoHQmVZgBzJ2W5xvv6y49aYSAzdCJCap+QN9
         FXGNxm8M3KxmCjx+7d2h04cGJofZesZcIBdj4E2px8JU+rrZjoyDfjruvmyVLs3rOoJK
         9bLR+UItz52g00SrF/x7vSDfZf72D6c4CUmiBcXCgC1eaXZsLJP2mtDWTaE5tWcygnWr
         b1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKNp0/0VFq4UFmbwOHRkfJ+vKI5zb8FAJGfCqkUJdI9xwGMxctClrPEDBfz1O/pBLESKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3yfFojz74bxFqi44D26H3AlTeLdcJKUPPTTyfVpJdP4XvTkiz
	3QIZ9wsWxaWqgx5PPRAT61Yq76cWNnoFz30t5AJA/4ZIcgjwSh5HyTgI
X-Gm-Gg: ATEYQzxEoyYM10hTjGWLNYMqMnKgytpq2NVOTnboh0yJznBotLHK5/qZXgUyrjg81kh
	YWqeOlADphOemNkk7x0Jkjto1Lc4OFT8CTHoNQuYlV8j5VRaMFQw15mhQ8bezj6b7vlgHpaHz9J
	2Ho0Pc2lmpj1lP2mOvDr7UqjqYkW9KhMJBbPJ18skcA3Q/0H3xznsHveMNTMOVRUwjw9xFpGqaH
	20SMljiD69VPCoH/dyR51MDS3WUh/dl3HiYxw3x+dXOIcDRl86fPx4viFbkfkdc9WZ3NV4Hi5Cy
	KFp2puQWV5tKetxFrcjF0QXnjo3Or25EJTJcIL2xUrlIJJdUbK0CGk6ra88SLr8zZiZ26DS07Io
	2SoqPa+auUsRNfzF4Fa+Vn6ST8reBYS4VII8SuZU0KxDsMZzUPg8LexS+AunAHESqc1zvDV/FkQ
	/8DgsgJGorE9b6tgRLDvzfZJbYV0AYgWCzFjtmmfJS2dV9pV6hVg8Z9whGJWdOMMFB3sbmqgtQU
	ranHVXcHFsZvUwe13MNayuNmwnrY8ocF8R5L21hvOJIiXfa
X-Received: by 2002:a05:622a:1922:b0:501:4b67:1210 with SMTP id d75a77b69052e-5070bca58a2mr220864021cf.56.1772020149333;
        Wed, 25 Feb 2026 03:49:09 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50725d40438sm67739781cf.33.2026.02.25.03.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 03:49:08 -0800 (PST)
Message-ID: <735eb76e-44a9-4f79-b769-23a3a07437ae@gmail.com>
Date: Wed, 25 Feb 2026 06:49:08 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSOC] Discuss and Introduction: Improve disk space recovery for
 partial clones
To: Amisha Chhajed <amishhhaaaa@gmail.com>, git@vger.kernel.org,
 karthik nayak <karthik.188@gmail.com>,
 "jltobler@gmail.com" <jltobler@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>, christian.couder@gmail.com
References: <CAPvEtrfYtEvsxbsD2Q378R3e84DwHPPCSgaa1pQugrwchj9h8g@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPvEtrfYtEvsxbsD2Q378R3e84DwHPPCSgaa1pQugrwchj9h8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/26 1:17 AM, Amisha Chhajed wrote:

> I am aspiring to apply for project 'Improve disk space recovery for
> partial clones',

I think this is a noble goal. Removing blobs that you don't expect to
need again would be valuable.

> I am aware of sparse-checkout and surrounding code while working on my
> first patch,
> hence i believe if we are in cone mode we can easily free up the space
> in partial clone
> for files outside of cone mode whenever user runs cleanup command, however
> figuring out what to free in non cone mode is a fairly new topic for
> me, i would love to have
> discussions surrounding this, i believe a lot inspiration about what
> we can clean can be
> derived from git gc and git maintenance.

I think you will have a larger impact if you focus on _old_ blobs that
were maybe necessary for a previous checkout of an old commit but the
paths have been updated in more recent checkouts so those blobs are
unlikely to be needed again other than for history queries.

You should keep in mind that some tools automatically populate stale
data (such as VS Code running 'git blame' in the background of every
open file) and so you want to consider how any decision you make here
may lead to _increased_ resource usage by redownloading data you
removed.

These are just things to think about. It's an interesting space to
help users save disk.

Thanks,
-Stolee


