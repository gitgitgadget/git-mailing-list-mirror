Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292B41A80
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821631; cv=none; b=YFgo6ewKYRNx9KEtmO/5UhNxirZnSOm2x3mTj+Y1O7tsMl0YcjGeu32uwI9A150wsjKBT6ZWn0Gxzp07R9UB0h8rO9ciMwTHfVUE9SxXXO8stNWKFzyCuu2sSbXIfXLPOTLqPDSM8mOdd0oqJ25UZYpxG/xYvT6dxTjF1YQwEZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821631; c=relaxed/simple;
	bh=L/2Kd6ByMeIm/cMEr6P77JEzh5qx++BzqoRdxJr/1e8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=N2oR6b1GDqkQvR4g1IwyEU0KwU0IgF4EA0iGdqadHP+6ZebD42HGgtYNsxoU+EYoGnh+eYeMgaDRkZyYh9rcGyxaMPtlTKEdwP6b6IY0bdxfthi2Zib8skjaXo8SrrK6ppNr5hS4ZkThiIkimL+LtoSJAfHfj9mp4z6lWFZhsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGfCEawt; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGfCEawt"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-250ca14422aso3513769fac.0
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721821629; x=1722426429; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swQZoL0/LpxUq/h8BcO2Jdt6lcpziCJPViee8xlaNrM=;
        b=LGfCEawtpnsWd4HuQe3Gi51MxBpL9qWjcXOMPbhVBOY2hBi6selzcmCigpvVGPKDBX
         QcxSFwELig5+SCY2jy/1+cETWx/u0S+Wc5ob5rrdtY4w9xFxfWB0h03PJ4FqUMhw2DFh
         yda/ITvvovl6dCYBKwsPk2silMvromht1Yr3J+Yr6EalEFnCySDiJQdm2CgPvdcH1p3t
         7xlY/2zFcWa88vguBCm1QLm3iILOV75BHQuM/3N2BTvZU6Rr6Py53kQViiIz3uBz6A85
         9BtdujX5SAnQywl3oSP8if9jgRSVJeCSp3CeiHIyWv/8fcEGLpSNAH8NkquY+9h8wtVN
         bEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721821629; x=1722426429;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swQZoL0/LpxUq/h8BcO2Jdt6lcpziCJPViee8xlaNrM=;
        b=ORYKddj+5Twc9hFRSP5DRmG02piQlGB3PGG8Pe88NBUCRqfW3gm9VKfI3ouMM7V4GJ
         G+EOKMUJV8YNbaQ/r0AxHXPwKvkJsqwKyuDrnk2R3JExC3ifMtOE4l4ID0eZQ7A9bdXL
         6kEIhkqVJ9S+oaypjzk0tC4WWIbN2PTtuFZmsTPajM3tTeZKBhBGziR6L4Qx6Xiz1BPd
         SKNBtr0VciwmyMoI6QeWD5p7QD9hZRz4DPvIQBq5pObId8IsUF1OHWqKpvTL8H1SBMK9
         1EvNLiqMBACawDDXS+NieBm05kyJY/ZEeHJ2z2DjwYQ51C6932y/DXJNAujmznTz9gkL
         yXtw==
X-Forwarded-Encrypted: i=1; AJvYcCUq+T0qffKFGzmF5LabMp2m4epBfKdWnIqrwrCIZIW7aL93H8CsgXiZqs6+vag8qJ2SPHd0orADJWjnVnaVzAIcWzcs
X-Gm-Message-State: AOJu0Yz+Ee2GW9GLVLszrXyawHXn1QDq9oT8n4TjW82vW4AOr1fqh38M
	KXA1iwxviRBDZpw8dG0SINIaKYVC1E54wBmCZH/w8PSTiARN54livscmt0jg7QQ2PWRb5Hk3UXX
	mxNZ67uKA6H80JTezl9/AmCXFKO4=
X-Google-Smtp-Source: AGHT+IFQpXE+VGRiweRVbrDW6uBfV9g2OjcEUTV0y+h26dzb0r0gAWK+AEcvnlLm+FkyaOzRQGsLA55kw1hOt6fNLbA=
X-Received: by 2002:a05:6870:4710:b0:261:86d:89e2 with SMTP id
 586e51a60fabf-2648cc082c5mr1666526fac.36.1721821628810; Wed, 24 Jul 2024
 04:47:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jul 2024 04:47:08 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1721818488.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jul 2024 04:47:08 -0700
Message-ID: <CAOLa=ZS_Lfqa+Z5JQYuJ-maMgW0=DWAouZC3QfFcEEbX4kq_JA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Documentation: some coding guideline updates
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008d6233061dfcd614"

--0000000000008d6233061dfcd614
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> I've had it in my mind for a long time to update our coding guideline
> for some things that I frequently stumble over during code reviews. This
> small patch series fills in those gaps.
>

Thanks for the initiative. I've left some small comments, but overall
this already looks good to me.

> Thanks!
>
> Patrick
>
> Patrick Steinhardt (3):
>   Documentation: clarify indentation style for C preprocessor directives
>   Documentation: document naming schema for struct-related functions
>   Documentation: document difference between release and free
>
>  Documentation/CodingGuidelines | 41 ++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> --
> 2.46.0.rc1.dirty

Karthik

--0000000000008d6233061dfcd614
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d3899faf53e1de63_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hZzZia1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzFkQy9vRDhnZ0lDUnozV2VnSmhCRTJRa3ZEOXQ3Qwp4SFlIeGhFMmtN
VXlWK0NYMkF6UnA2UEkvWmhSdi83aC9oQzE2UVp6NmhkUXlwcEkwZEFNSDZlTGcwR3FhZ2V1CnBS
d21iOGIzNEFucUxWV2EyMjR6bXAxdW1TTHQ2cnZyRVlvQXF6NGo4ZGhkNDZIK1FUbW9VSCtKajFQ
VytsV0cKRFhqNGdxcjcxaEFKSTlndSt5UHV6RjY4REw3c0Q0YnhkL2NuR2tTNFlFV0s2c0ZTZWdD
WGgyN2Y2bk9vVEgycQpvR2d5QzkwTzNlRkprSFk3ZnBiblArMFFQRjZIRGFyT2xuT1E2T1MyajRS
Vk8zVm9oS1U5QmYxUUQrakgvSU9mCkswZkowZnRmdFNLckMzY1VTa1Q2WUFzWGsrWWZZYUdvcmM3
bCswMmt0WnlvcDZEYkdFYlVWK2p6ZGpoNklFbTEKNlZOZFNXWUp6aUNWMndYK0xPMEc5T2xWYldJ
aFBiRzFGdDVDbTJ5Ulk3eFV4eWVQMVdoNW1xS0Zmc01kRGFKYgpyQ05oQ3doTXlBYmZON24zeHZh
UlZkNGxpU29wWmc1eGxacUJNbENWekNzL1dKUWtSejJhR0dkU250V3dBa0V3ClFNNTNhWXlFdHVK
L1ZoZzIvMFFwMFkrbFhTcnNHQnZ4akhSSnhtaz0KPUkzOWgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008d6233061dfcd614--
