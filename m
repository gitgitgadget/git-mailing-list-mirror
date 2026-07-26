Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E173BCD3A
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785081135; cv=none; b=Fl6v81/uV0Qu+Lofx7doxcVBBWJ+iFg2ZTLkCVbJKNghN7JZZEyp2KgrkaIJqrmEyyRKccJ1JJY/FGa4QXomS3vBEMDdqd69lbDij8BfHlksVro8GDdaHLU0NIeJrEeKEjy4p4yAKB0DvOxefWdnz4/0sEPZB9XWq+OEMvwMO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785081135; c=relaxed/simple;
	bh=xlYR2xJhvd3ZTOIxIkcd/AkCWuWgycBYna9oN0lvFG4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=FNwOKGsiARfyNSxctsomTQHjZJciDbjrL+lHKFP0Bx5NbWzBeEanEh/Vm3swaEM2RC4Vm3aX4fMkZINbMdtOAZ/yGuJWVeChDfIDre+NfDKdIkAf/R8rUh0/P4ajyzEkOWSEGq+VkrnmVKmO7Uce/x0kskr49l+/3QOR7ayIIbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVow5YD2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVow5YD2"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1509840a91.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785081133; x=1785685933; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlYR2xJhvd3ZTOIxIkcd/AkCWuWgycBYna9oN0lvFG4=;
        b=kVow5YD26DzfFfNVlMHHEo/V64nKC/suZYMNkGi6FLbAT9mY5DWhJIG2txgQALeSJL
         omOO5ojyuu1S6mBrOu1jO+Z8xo7kzhKM3zd+ecXnDambChtKvRUTWNysOdKeM98KZSD1
         qSyq5cR6ksoqHkwrMfttYGmcMKFNzH3FbSbX0g6a4C9K38SDTPU/nImGdRF3mjEBsucL
         GJMR/u3R2gURadPtpfeW250+JP5S3NVE1X19UPqa0FJ4GxKfWhYCFZAMBdWFL/JpVo7n
         zAsrvOH+7GDv6cJp2hxSeyCIs6syhtwNPw4nHkED6KWOaYX8fZSG21JOIEb5wqXBZVlI
         ch+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785081133; x=1785685933;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xlYR2xJhvd3ZTOIxIkcd/AkCWuWgycBYna9oN0lvFG4=;
        b=tMhD7J/XRKh9reS/L7JQI16fRu8FUoJOU+uHDnBqVh9/uuOgg3UFIPN6RzlBZMypFx
         VL6YN820z4bwaLf6fFCLXK2OqoLXdQLVMJ3/fWUcL+NDoyptG8a8jEuTXy7A+lkoNw5U
         Wdrx3nMq10Ez/lFbSzzskO9ulOLY3pn6+WY7Dl9Q/v5O2/f6bJy81kD3awocW6DorHhp
         ESq4TuSfPOt2iwOOfG523oV5ls8RbNZyztB+D9ak9sZ/NEaGFEgiOja6CFxSVEyxNxX7
         AURcGlM81kqvvXoImBeE5V66RaY77infdHxyivLm5yxvx/+yAl3nJK+aZZaPXsHH1gHA
         QbLw==
X-Forwarded-Encrypted: i=1; AHgh+RpdU6Wx6JMlWIyxkfnV8tkHI38RUqUhzvAZQvxuFSgAg9jtOJacpafXgxl9ykaYbXNA8xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRpn1k8VhviBV+A58ejOihmRwBph/pI4vZumPkCboJjWiNGLC3
	Xh2DVyhHEf4A86y9Xq/5oPKfYKZ1bNnoXipmnQFAd4QOTXUrLb+7aZvL
X-Gm-Gg: AR+sD13Ekikc/5DiFf0adrQha71n7EQiNeR2I/IcdKavN0mtOAtDyi7d7E0iLpQLdPB
	kuIlZOTJ7GBNRkgPWzDkWrFkt1FEozScPuG4wVTarLs4/iVgIlAMfmGcq1Kv4fKfCwPKpt1FRtQ
	Naw9E18z+kgodC9Xzj/Eq2Py+pjdiMIq5zJOSNmQJAnpjAHizXhmp7pk6Y0f8GLIb3N6L5sE4cx
	/EXl9AsBNGWKt73bbvQnl6l2x6lUiknm0X2d9rQWTfBwL+CwCRzrvWSMvgqlA+rYaT6d+QTwQUB
	LQeR8wUVbL2UBZ3GUTagJfVzhMlbjKht2yd93z3vaCvdyxxxsx6KbcslqYEEJi1aZLhGZquD+L8
	T0W97bHF0w2hzJEeq9fLy4nYoBrwSFLv1WLR3njXtFqd8sqE9r8iJTpp0jyr69FHD8xctGJiAFm
	g=
X-Received: by 2002:a17:90b:590d:b0:37e:1620:dabc with SMTP id 98e67ed59e1d1-38f1e63a2bcmr7729378a91.0.1785081133264;
        Sun, 26 Jul 2026 08:52:13 -0700 (PDT)
Received: from localhost ([112.133.220.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm23528116eec.18.2026.07.26.08.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 08:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Jul 2026 21:22:09 +0530
Message-Id: <DK8MG5RUM3WT.1KGOZVF7WWILF@gmail.com>
Subject: Re: [PATCH] change utf8_strwidth() return type to size_t
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>, "Hardik Kumar"
 <hardikxk@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260726123427.173877-1-hardikxk@gmail.com>
 <DK8L6JM14UNS.16B15DIOFW1K5@gmail.com>
In-Reply-To: <DK8L6JM14UNS.16B15DIOFW1K5@gmail.com>

Noted! I'll write up as suggested in v2 for this patch.
