Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8FA3A453F
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058235; cv=none; b=OYgkBa0raX9XsUNwRkW0Melzghe6HOzabE8i1Q1nv27R0mzl9dR5l1YC1rJZXnP8x8Vc5wwr0BnYrDMYfWwXtre/Q/BZNWWLG6JXfqQXSlEIVNOGp5F1sSM84xSfpHFu4IBtd5Bd03HJSE2drj0+bHN77gZBHJcXFqlqqu44QHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058235; c=relaxed/simple;
	bh=80cnYxFHHQOvqoDhI4hMuiLIurqgpr+v8TtQQzyduRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHJM6wMypn3fddawT2AvxFCa1dDOkBNmuS+g9+IHIRy3p//o+I4zAEwz230kvqH/DTmsowQ+M4CIcJfR5kxZps5uxKL8KrS5JWVqUyQ2x6Ikn9XPxx+fufDZVzg4UPYDEtFyh2nm7cWBhyeAjyWUGJVIhFMUr18q4WmbphtjfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxIXwqUz; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxIXwqUz"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25187so956879b3a.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789058233; x=1789663033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FTj/HIAofzVaDy8AlS3E0jjc22Io8Fb3yoEcTQE0mp8=;
        b=UxIXwqUzglIPZeo5LniDAn/7Jx+UshvZq76Rd55ZXexrQkPbZTCkGwxgf5DCrDv1xW
         zZJYP77+c9lxrC+8AEHH6L3tOEtrFJq85xa76U1rI/KX0AJI0lKp/hWvl4w0xJuKNH6i
         CyYFuKhKqVVnwL/93vmhJWAk9Ll9jF5ssEwadvYLk0bXdtXX/c7LVb8QaQ/ypnb9+/RX
         x7lcNH84/uc6FryDIxkjvBkFh6dSvKpWS6lUT3QzzL4NlEDIoaOLXE61UOqGX3EOkSFX
         Z7CqrpchcMJDUolSsBtP0zzz3gz+p0DSwuhKZ+Hn0PHoH44WFCiuCat9An1gFluBxy58
         viaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789058233; x=1789663033;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FTj/HIAofzVaDy8AlS3E0jjc22Io8Fb3yoEcTQE0mp8=;
        b=gKp3KdgfWm8QdzMr08mnRNmFB4oV/pzz8H3Nc1TuPlCGeBtZcJ9sgJ0CovA4uD1yVe
         OeRS6QH2H/yTDUzK3I2gTBtjTrZpDFz4AGYdeweQnRqsKKfrsu4ogOYap6zrWxGXDY1S
         LxdmTsq6k2DrmFbr+nxe+IULrU+PZajGGhewlNMLVn6MN75wKG98QjsSplJL2iPZwns7
         TlwjaF8bkwxuAVJkqUNopP9tis5/QT5BVrw9Nm1fvBDyP97N8O+HK+0RbQHsRSKAIDh1
         ERwO5yRAYCDnXlLepaAMVRnR+WuIUlDjNbAhwv2gbRdgQLJNZyXzaOSqaDc9ezNUkOAQ
         Usww==
X-Forwarded-Encrypted: i=1; AKwUvBwdRJh+nbbBL7ZaINoUeaby4ZkCX7wZAl6AysgOv3Z/fgq1kMFXK+0HBBx2K2rG7aeU8mo=@vger.kernel.org
X-Gm-Message-State: AFuF++nn3AMK4TcyS5qF1nGcz9HbsxGSQnfC341AMkI5nFVLGb+m/KAQ
	0duKNwX4Om3bQ00jMvAMBCGzJUe0Ef9a45QGMS3B86+wqAiEigvBNOvk
X-Gm-Gg: AYBFou2hTXjDxk7m/of0U4Dm2SdxrXMGiWtgRcnXlIGfjDiFOF0ltfrdJd9123YcyiP
	NOCsoCzLK870ISjWmUFtJwDZF6V/5VTKRBEtt8KBZTdwTo7e5tJTJwLuKptXdTzoCkgfEAG5enN
	Lx4QSWWVZoqGPz/qv2TjmZ1GQ+2OvY8pOOmFoHvNbcwXoLTO6ZjGoyWSiPRZHjzci/7l0Axtdb+
	wvkcK6SunQkM2h5Wn+6qiwv3rl58dELrlhWjfC82EvEHSz8EEJ8s+txldI4t8zSzlXnsx4CHf8g
	6HoX3EGNcZiCKlYzXlBVwkHKZt8qkAvGxaqCkh/9KWXWTClsCjeXi7FYcOqYFDFNuLR7onEHysf
	pOA/sblBrstPJOfU98IAAVAXOzEvxCnV+xU27nIqBm/Dd0Xp0CCmCSCM0DxRRUPyo068odoZnt+
	sjMl72Lx2Msz0HFTnXH73FGD7o0d+RHmBAM3saSW97HzwUt17uda1FstNWvjT/+OMqY4DHc0NpG
	lNym+0nPxjeIbWXJAII2HnXrX34aHpuzgn0ka+4+VONS9Eh54Dmdno=
X-Received: by 2002:a05:6a00:80f:b0:857:7384:b5f7 with SMTP id d2e1a72fcca58-8694801d67bmr8194402b3a.19.1789058233393;
        Thu, 10 Sep 2026 09:37:13 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:ff8f:ddf5:ee1e:28ec? ([2406:7400:12b:61a6:ff8f:ddf5:ee1e:28ec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-865ba32af8dsm5140247b3a.13.2026.09.10.09.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 09:37:12 -0700 (PDT)
Message-ID: <20d607c2-2380-4d52-86b2-25016574abdb@gmail.com>
Date: Thu, 10 Sep 2026 22:07:08 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] builtin/history: unuse the commit buffer after use
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Git mailing list
 <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <xmqq4ifxgree.fsf@gitster.g>
 <20260910150021.348548-1-kaartic.sivaraam@gmail.com>
 <20260910160254.GB251185@coredump.intra.peff.net>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260910160254.GB251185@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/26 21:32, Jeff King wrote:
> On Thu, Sep 10, 2026 at 08:30:15PM +0530, Kaartic Sivaraam wrote:
> 
> I'm not suggesting a v3 with this wording, as I think there are
> diminishing returns to polishing commit messages forever. Mostly just
> food for thought for future patches. :)
> 

That was very helpful, thanks! I suppose I've lost touch with writing 
patches for this community. I tried to beef it up hoping that more 
context / clarity is always useful. OTOH, I definitely agree that fewer 
words to convey the same is always better. Will try to improve in the 
patches to come :-)

That said, I don't mind sending a v4 with your proposed message as it is 
a strict improvement, though.

-- 
Sivaraam

