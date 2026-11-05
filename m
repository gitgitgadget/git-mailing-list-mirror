Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837782;
	b=VJJbz3Ik7WFDRblbw0bBtf6guMUtGUYxLkrJzkuDOPjd5n18bhEh8pMAjQpXT+6yi3gA
	 ++FY16GIQMvHj3lXQIF0BdX47UT9zFvVZRuVrJEDiN0OycTnXILRkUv/g1dj3ayzw2oLX
	 VLrVBNkavW5TbkeICLSMCdnw/OsXTqn7Kz6tk1uEIxoKpOAUKGdmNt/nyZeJ+inKjnyk1
	 546dg3E1hEl3nCzvmgvWJL2I++9380mrH3yy5292DxS6kpEwgOskTMM35hZdBjT6lLPS8
	 Z1O89XM03ebH2cEMmr6azfwUAJabf/ui9ii7YICxJ5BuA4/18yygNKM3QN059SbEFvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=EseB5/XL6dUT0g7bS+s9/XW1QpCopE7mG41h71kMMyA=;
	b=NSRlKfzHb36pOfdM2c24Zyyen+ICVoBmyRbO6fsV1uzEPf4XtSkiTZWfsqKBo0L4oxU8
	 T28oyZ//B4DLfHu67bvs3XZs9NnO1mUAZDuRkkTXJPB6dzqW/Drm8Xm2rLiDc/+l0s53N
	 6qWstpiIA4dHOWURR6fdgJa+T7lAME1Zoo+v3RbvTgVXJL6WqJwwJ96UV2i6hm6JFwqmL
	 ymtP1a34RPNiZS7gslBMe6zorycGNVkiAPkQSXXPQDXZbCJZpGlH30DN48CtY+G9x7ydy
	 7bwVRH6KwPc0UN+NMt9s3Zda7no59sRxSNQ29L7nEtTQOwdatVz+Pg3kUuMPGTOXk6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WBWOoKcu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7EF606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 00:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E7EF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WBWOoKcu
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b561b60b78so183130a12.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 16:16:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793837780; cv=none;
        d=google.com; s=arc-20260327;
        b=P1tMUpqWsbHrXcr3nC6zvJ4PxBXz0eGu58Kid4i8OpoKR7uVD8T1pWVkeZUZIBTQfM
         qe0L2UExsYbxogxjal1MJBZXquFN1VthYaXCdEA758nwPsDwv/9BiX6edbzgaLD7A9ZD
         oeGRRDVrLP+BhpU4Cxbqqu9GcreddBJ6UIq4GcXTPiGWaIj+hbfiekBDs8x2JPAIeugN
         UDoxtGI2W8xGRJ+Ah+/t8Ss0Z9XOVa0oKwD66t7aWfntiThPsDe3Nvgo+nbPfbLacRoq
         K8H7hj1D6iloVDn/hbLIzy5U+CFd9AYIXuD1tW2nCcxzqlhKci/8FCEjFY2fgC8DruM/
         ad3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EseB5/XL6dUT0g7bS+s9/XW1QpCopE7mG41h71kMMyA=;
        fh=xEwNemFXS4bNjoQJ/u99Eqj9SfdLR39dP7gdi9L7gCU=;
        b=nUVpTF9ZQKzjVbsZXTyTpBxZG+6PriW98ERSWfr4iOnoqdir/PlXzQkXTZ8BHMVwzX
         Yks+jw1m5usnDXc+WV1T2R7xEqY2HZTrSPwMmsv9LsQKYY4EkRVnLiLObJx+NSJmOjeG
         /+mI2av4byduYgglKWl/nu7Y+a4WgVzAiZxX2VCXBMYGcvw+XoiH967jcVOLHT91skY4
         Prsyvqj7B7qVu+lfXMRQhZ6vzWTIRE7Yc0LJBQT7MpLzyhSDkU/eqygIKW3YFQezDhos
         aADgST6Fv5Q20x9inV3vDj/BNUjTXoKRCWf17P15yLLUXXGWPehgWbHCB9QB3jrcyemb
         aMrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837780; x=1794442580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EseB5/XL6dUT0g7bS+s9/XW1QpCopE7mG41h71kMMyA=;
        b=WBWOoKcuHRe+I5d4LLr4RtqzScS3LoSjaDMox94Xaw4juLQFwbU5lOrlsHlLC8Y1Ke
         cCEDBXyMsYLKZhGV59sBy3juY1o0XAlRF4fOoQ8ECaokteYGcFPnaN7CPdyxI4G3wAJ8
         F00OOSFHC75KTrxefPAVJkwDGnIXf4Vk7vhTD2rBv7DNsQpbQMYzHJw9QVNRYpJqKoUQ
         OFGB1kUjZaTr248VlIxlhhRwE9xK3s9amKLDg/x9q4E21sGpMX8dm3zE8NKMwV1aEFxU
         LfDE/9fOPa3QrVMIYKbffLpn3gX+X2WUM2NkxB7J7T+VNo4wQat9hwXDnmnbLs4FDBpw
         t+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837780; x=1794442580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EseB5/XL6dUT0g7bS+s9/XW1QpCopE7mG41h71kMMyA=;
        b=R9ZlOYcpUuQU1qZk22fW2Izt5ZdGtJLR088Fz5RLk/vFZqrgmeAXS7XsgoNKNBComi
         S5n4ANV9OiYggPIkhukJpH+OKDuPyc/z3NAldVZrow5iN/g5WdKC3e784Icazn/YODfa
         ZhrctfZhok92M/NN0AFu9eIZ9E7S58DqVU3OwnwpnBoWb2Wvh6k+xfuvYXoK2sTORmTk
         A6z7WBnU5qg83AO2wNASTM/IAZbdhk5x6n0zemkGxdJLPPIrbz9dwNeQL6AzKbHAs/YY
         CxGjzpA4rKvdCmE7UHigM5tt02MSYfKkbpho6X9peZHsOR7apwuO6455u37FoSVwJenT
         hkxw==
X-Gm-Message-State: APuU4Z/1bmG2WGTBsyvQz2WThOHF2d67KMSm7vboiFqIKde+bh/9pGSS
	6WewrUbVTTDBD7dU/XnJ3CxWIg7hu2NDv3bGZeWCohR1yU8i6/wdRNpPlOez/3PGTBYl4yftWjc
	GEYMkOYGIKb9w3vazZ6oU2IqGTKM6+3I=
X-Gm-Gg: AYBFou1SsnBdd3lnM/tFXAxilddHXHNoPvZqSNsYs+XwRz1Iea07Ba25p6wD0DI3zJC
	HHQmeK2aDlrmNwqyHkTFmEbD+fj+xW2OcHx+T7Zru2ThDHh8ul9odXlcEs3XajQGGFksdUjAz2e
	smNwASoWdB41qHQQc1EiwSteW5nxFCvWR4l3BEgyP9ChwJgXebhdrPu19LvdoT3qfksDKa78pWR
	uNlNfpsd8bgL3SCIkFyUUpHBcmHuPahxSTzU9eowonQj0Klv0s4gqoC5bikbu/x23oQozOIoPop
	UTBM/33vGl3gQVZrUA87K5NJ+ZT633J8bYSuOE1uBGmoSZvMaFRp+cRG3Q51u0VJFSnJR/KMha7
	SIxRMzE+S1KVUs0byyW2K4ROvOzH65pdZ8z52o9CCuDlfd0QgfCeEYver+ianJW9jC1e1
X-Received: by 2002:a17:907:7252:b0:c4c:b683:363a with SMTP id
 a640c23a62f3a-c4d207461ffmr81376866b.20.1793837780353; Wed, 04 Nov 2026
 16:16:20 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029141818.40193-1-okhuomonajayi54@gmail.com> <20261104083322.80687-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261104083322.80687-1-okhuomonajayi54@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 5 Nov 2026 01:16:08 +0100
X-Gm-Features: AclHuK_hzQ-RCLpCNL-9hJKghU3X4vgmik7CFt4-AlGWv9tPytzL-mEz7aS749U
Message-ID: <CAPSxiM-8W4hefg9XxV_PFe+68H3sNUWqe00jeakDK8DRk3mvgg@mail.gmail.com>
Subject: Re: [Outreachy][Proposal v2]: Reduce Git's global state to enable
 Git's libification
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 9:33=E2=80=AFAM Okhuomon Ajayi <okhuomonajayi54@gmai=
l.com> wrote:
>
> Hello,

Thanks for your proposal. Do not forget to submit on the Outreachy website.

Thanks for your contributions and your interest in the Git project.

Thanks.

Usman.
