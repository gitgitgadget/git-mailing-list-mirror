Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632DE489FAD
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920665; cv=pass; b=W9BSKvRB7QtGvNLeMA/AhaMr7SIMCSEv76nyZZL0Mea9rsxorxXRnMHCvRudQPeET7EgsuLJfZr5T5EWepkVjtH3nETlistAxILaC7zTcdBXhZRDjjrP3L7jPqt9pMQ5dS4SWjE9F8sUBDnQ8n+D7WTrgFmYhnlUUD17wEpik3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920665; c=relaxed/simple;
	bh=MusOrF28v8JyuZtARMp4sPwk/HqZC4q7eQsTWclPTF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTntJAWjS62NRyN8NgwfBjpxqEA/8uSVIOgaQ/Gcv9A8V/wfSG1E6T6MyzRyD/P8GHIDrtngg6dhTYr52ANXM1D2R1v269x7SqvshU3E2UsxPPUwcjuYsSc8Q6IwhQaxqVIxo7YzU0jskin0B2A8wnDxR9e5Y1T3iUQUUosWXRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjPw9Alp; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjPw9Alp"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ab38a051aaso27313367b3.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 12:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791920663; cv=none;
        d=google.com; s=arc-20260327;
        b=iK2m1m5UluTFJ+gXXWFgKxqX/opjR/dg46ZUzmGwYy3tXGPV2jNmULyTAGcpexJpoI
         UchWjQJnYql6Q2vRleaD6RKw99kUaP9DJdvN1Za6Kemj6eNrTxsEL5OdJo0AGUiCo7FB
         IvFOOQxr32ckEnS/WYhMpQvkLChiKWAyOt/1721LzNI8JPa0pCjOzfynI0+nN1zDSzOU
         b2nmIaAKAkts84/mTjIEydksY1uWO11lTCid2wsKGq+I51PXQhFVHtbaP2e2FWiCDXgJ
         HE8sJqNyzPMESutHdECIB3W/DJQby7gefEJnWMsOgSVloIdYNGJKlr5dMLSU4pywVDWo
         usqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=23Kxs+uZCRFnPWmRgAx1pLneyOjAJYojMQ/5wUWtIdU=;
        fh=IeFnzBTmwIJp8Dv/+kFoBDJb3gHqZ7ypCOUNkSvfZ40=;
        b=osSB/ppobhaYF9I2rAiuXtX6nUs5TBsJr+P2f63ZU/CwOr+OvtQdQoQMfbqelWLJYC
         U9M6ZHQG8hCv3x/Ti78lbCzRlNEgbCEuhyP23Di2HomVavtAnLvtTbc9Km7ecfhRhjY7
         wwApLmEigDQt543oTVximi1y7YB9U5KKqvyFFic4H/e3kB967f7TFUM/qRs2vhNO+fvD
         bVbBbRjN69iWn53PslFkZk7pb6n6XqZCiiOXWDG0DMOcuyE07nrvRWZYn4vv+qhqC9Ay
         TiTRSlpFyA+oMhpwR5YJwullW3/kEQgAZ038oOrgqjhBSVFVGre17VMQ85sxyQEH2m2k
         GMYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791920663; x=1792525463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=23Kxs+uZCRFnPWmRgAx1pLneyOjAJYojMQ/5wUWtIdU=;
        b=GjPw9AlpuL051mS081ix/Sw/kHZgpk/eAMZ9xIz0WgcCKoHV3TqDQGI2ar8UYnXho4
         Wjdgb6CZlKrnlPgyXIMx8JWrM9shWptBxmr777UZ8E3DtVARKZNxVZmvum6Ta6w9oK6y
         qoO3xyiZJlUbVtFwihi0bbjLdw2OTpRcfkA42NLw73MaWCrMvuSvS41y5f98wtepZwgX
         gjErVgyKptDAd9pnLigDcC+h0RTd/qELiHLdD6m9i+KKGw2YOspxZ1/s1zYHyLtPe+7r
         VTWltG4eE4alN4ZDGAZTlyDnpYlCsUl55s6hhSBrC3ye1QHneUrgvZGr4YCTU3OTd/cn
         qucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791920663; x=1792525463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=23Kxs+uZCRFnPWmRgAx1pLneyOjAJYojMQ/5wUWtIdU=;
        b=HES37vMoccyhnC3rPwi6FySGsQ/TcPpJnoYGm61oF3YbIeh3Csw/2Rhyk2sWuWd3Ac
         sZXWDYXIju3YlVY3HE5Ww7ib2Db7PNwQBqVkJ8JhjUskew7IoBVx8bvC+/dvK3voProT
         eoo6JYlSzrl3s4NYDQkzb79e9EyaW1TUSegv2U2WOeqwgwi2IAVlbDyHvyJNzDXlKfEE
         EGyO8zUydkaI/Tb3RylRt/K69si7QdM7FvR9cJEClG1SCPqnlORc1GGCinMFnHiFoDcp
         sa4o8b13IPU6h+45LMrl0y0MhpOWLYGsAUVFJzNdkNISn/2cajPdVOcasGw8LseB4J2i
         wUXQ==
X-Gm-Message-State: AFq9FYJVYTVwrgjCc8qYdUdQGd201d/hGKSBE8nwLkMdi398qjg/Gqzk
	DBfRx2uiVCKVym3reo4NG3Ng7xzy3C0gtgG8uLSThEAUHEuJSz/Ygfqqgj8wEhhxGmzFwCnV1fK
	9SjeTdm40AMdd3615P6SHgdB8fcjjKk1zj0qo4YNaGED3
X-Gm-Gg: AYBFou0CFmMrrPbWT6m1W1hRuFm3UfhrVbdTabuxE2OpX50xec+BSIhtVE9G/ZY5Sdm
	NZUA+VEniHleXtyCCnLZjW/3pdyFIU7DsUQBstdzkX8oW6WMdT1CT5FLeCcTyRl/aJaV8m65Ef1
	btklnoVR2fAe9eEVXyii9twyh0aLXjlMrk7Foi0CBzQ0T1NYWHVKQFgJn50SItA4R7nult888FL
	RYEuG8beHwVeoCW+h4dflrkhJwgsBSnXDr4vOcY/+xApbZqrhKBYRCF0difPTgwmiJAvyyT9mSG
	nVv8swChCRoMRyYWVRusopV+nAUn2FPbVBVgTfLlTvKlTsjfb+HmTPxvNVLHJlKIrHYB7Gh9Rlo
	28xTHbfa6s8CzGyTphafIpOlW/9JoUzHjPT6VgXlebJEW2ZSTiI7q973uGmW5B+9aVTwO0W5N1o
	hkSAr1BfHTDTYbf0pyaAc6OJ4/4mFxn5oEiWw5TyqWU48UnluycDrDp8Y=
X-Received: by 2002:a05:690c:ec4:b0:8ae:845:5179 with SMTP id
 00721157ae682-8b07ede2328mr51556927b3.26.1791920663201; Tue, 13 Oct 2026
 12:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFpMFfAFsRvQ1mkmGVkRnLWf_OHN9h3PAThnVZmrbecV_ihRjA@mail.gmail.com>
 <20261013164922.93099-1-okhuomonajayi54@gmail.com> <xmqqv775xyz9.fsf@gitster.g>
In-Reply-To: <xmqqv775xyz9.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Tue, 13 Oct 2026 20:44:12 +0100
X-Gm-Features: AclHuK_72csGWSUPHchZt-Y5NxeZkAcVlupucs3ia9gSdwq8wDuJf7wUNgdMzb4
Message-ID: <CAFpMFfAQET2OvZB905cajvhSG6BS9t4zx5G6iGG6BUP_o8wUGQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH] delta-islands: use Q_() for island count
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 7:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> I am not sure of the value in this, though.  You certainly do not
> mean to say that you updated all of the ones that you found with the
> above.  You are not inviting others to do the same grep and "fix"
> any of the hits, as the pattern gives too many false positives
> (i.e., not all %d are about number of things, like the line number a
> parser has found the error it is reporting at), and without warning
> that, it would not be helpful to these others.

You are right, I will remove it from the commit message and send a v2.

> The change itself looks sensible to me.

Thank you for the review.

Okhuomon

Okhuomon
