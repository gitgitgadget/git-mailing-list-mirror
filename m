Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6342ECE91
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 04:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756883; cv=pass; b=pYZNDr2Pj773SVgXDUtym6aFRpN4jYBm6zVnkxBoUP1dqIbgnIwPj6fQhjIbliXmbL6JX0Wd16QedHIdgQptlep/Vi/2SBIhPa2waSw8aWe2eQB7OEgc7AUscoOzNGP5TuKxcj022RP/mOC6K6+IsRQlOwaSUg07q6ySTm15pdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756883; c=relaxed/simple;
	bh=zHqZUIVkH2PUwkkqHOCzbQjFKIPhGxAg+TeCTu5uMcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbQIjExmfYGSuIFqAZylQq9ym2lcyB9vnNAqe7g3qtIl4xBiem0T6hxejyvF4gFi7Mya7JEZB6y/7MnJGo8HNlTlYwnePnwGbxt7fEQthIwiHUtOhuDAEDdbvbTVrVk521Or5xqKTZNadfZcOx1K0DdGWFghMTl9BZSjHW0jXiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=mAXoMRtD; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="mAXoMRtD"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-861f30636f9so43151697b3.0
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 21:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788756879; cv=none;
        d=google.com; s=arc-20260327;
        b=DjbBRcztomVL1qjmt83xlOMfHj4EZBk2qES25+F3vHBVKgAG0Qs9ejFKc7aK9+lx+U
         ZzImgndPufmdDntDKViLlN4Z3+8M14Jd8CIrXkV/gu10pcn/0KPIFqodYftkze4+1YOP
         QncSMMZDjjawqjVjjwW1Fe9QQMBDTk4l6Qe5fzvnbQpAdH0vim6tOz8RY35TUJFd4v0l
         6UZDyY8ydJEJeH63RADe3H8A3PTId4zxz1Rhx/vghwVhrMW7g+hRQRLZphcjp/EE2jFE
         2FI0l8bvSYr8Sa5eWGEsJln2kX8ylHmfne1hw9ILkAUeACeDFGFMlS3smwEW4PrfxHnq
         2S8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zHqZUIVkH2PUwkkqHOCzbQjFKIPhGxAg+TeCTu5uMcY=;
        fh=tWw9VqsBUZq1veENkKhcAw4GPJho4ajpfbbbgx8E+G0=;
        b=rPgX4+Ef4+sBX2D12Qp6Ra+ZWXcW/BQCI7lctzSI8twyMQXVtUJeRyCxtu4w75sMBO
         lcfqRmmE/vJDXwD9uN3noV7rZ/XSDzI95E8AOdgZ5uYb5ScqK4fdf9Adm8cu8glLKNC5
         n/vQL7MZ+COCpqtg2ZlxK+Fv/2kQz/fXlbwE8qNI56ZPoDBKw6M6wQLbaisL2WEWK5rH
         5khggcbd13IeqcdSLSvh/bP5fXAdiGTea1OUWQKDbzc4cmHZXvAzMvht5PFPG5FdAdgW
         d8k/3sdUUwLePfd4Sh8uFv2Uq1phwVf1kwY09+CHhkJkI82Nff7jFTBiuuK1e62PABDi
         mkrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788756879; x=1789361679; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zHqZUIVkH2PUwkkqHOCzbQjFKIPhGxAg+TeCTu5uMcY=;
        b=mAXoMRtDqnzt84iC7a99d5YLwB3YmoE8BWkMKBf9ZmfQkG5n8srCVt5QnleRwCLyOA
         Bz14edVsIQI3Ni3zsPTicSTXUA0nl6AYdakA3AUbrm2qR2mISVN/IxyVHzzaJ4YchS/n
         jFU7/XbifN0KyqBHtXFNAsXlc5/DGlxNxBvlXufZIbJ6H7cv85za4iVQtHJdmEgRk4TI
         yOMQSVXrHHn42uzgfZvFWqGZQ4JzyXFfLMhmwwcbdPvPqG1FSKhXmy/GHw2cMQoJ/ByP
         kMGMCPBIZhVaDwZpTEXiBUUbvPEbYggOS6MN4VSMSzM+hCiXwlDGkspAcnzKUN4XsdCd
         cYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756879; x=1789361679;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zHqZUIVkH2PUwkkqHOCzbQjFKIPhGxAg+TeCTu5uMcY=;
        b=gP4kKi5UIoF/quNrIPlQ6t7jkg3dElh9x5/15k8FYxW5QvmQzDsey5yxZBGM5iDDYb
         tfronFp0YejUVCvx7LpCiscetmRmKT/5g9NuKRDk2gVMok8foDrnCrgniDQ+b2HpNVCw
         VaqBoCOLpvQRL31hIWKFkZRIyCA8kdlQb6XSjpRD77oSnK+y1mpAFZUf+g9TllqdnTjt
         3yb2+q0IXwV8OTjS51iEF44ChGswRVzC42EcY4bbO1fspetdmzM8MhTBt8PXajIBtW8c
         TjExtxF4JzaafIl3mQUG78XgdoRMkzJudBhSOw/syliMi7c46aIiBOKrFXbK6Xh2vbbP
         Ls6g==
X-Forwarded-Encrypted: i=1; AKwUvByZG6Pw38m76WyHro4TE8l23D+xgD84wS8SEJs/jTEyP26ivUPav0JaZPC3CtqIZz+hDbk=@vger.kernel.org
X-Gm-Message-State: AFuF++lMo1hArMzE1bNkYAaHWdMKF6XRVcKvctwiwhu8DJS/Fb8VozZk
	oiqBVNZUyzfOiXdLi7jPTL7pDjKppEqtNHLkMr+HmD2OLI8Ts25pQrmyM77rvbqo8HnIgutrVf8
	ZBcISRkwycXZ2SGTzQXMCE4WLnYXrX2f4mzZG+UKxNilfL4aj2Z2RpbDs3SOxyl8=
X-Gm-Gg: AYBFou3bv1eamEI9/yJn9+rhQmNLGmEUPDuk3Xn3gf+e6O5HQ2EWo/+RCNDST14ri5h
	h6Sz3FHKfp7xZWPVGhM1QJg4n6DGU3hyfoLyzOmbhT2nUSgxJPc8Gau+T7RV62mNRPR3tRTPIax
	JnWdBZjtBjemS7CD4yS8s+k8qERV79P9wtRflIqLcQZI1yISfK5qxNvb3nJB1dr/zfo+lSHqC7E
	aPPAHWbCrLHw9wMKITXWoVDWCyu0/E/+o6IvGKGwPk9HaGPcxmQhJ2b8ho9MIK8XgozbtmbpOeZ
	5uT8WTJYxKqGFU6MGs0SO0i2YvUNz2s+1acnzf1WHSv1QzSTiJ0ggu1BAAxKHq/dyA3RJMC4uum
	Q5p5MlPfTCCq38w==
X-Received: by 2002:a05:690c:c019:b0:873:5c7b:c0f7 with SMTP id
 00721157ae682-8735c7bc24dmr30896967b3.47.1788756878934; Sun, 06 Sep 2026
 21:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g>
 <20260903200015.36849-1-f@lex.la> <xmqqo6ee9jtx.fsf@gitster.g>
 <20260903214551.53918-1-f@lex.la> <xmqqpkyt3qul.fsf@gitster.g>
 <20260905171343.34722-1-f@lex.la> <fdf8fa9c-1e6a-4f7c-bbe3-a0b41cdaabd4@app.fastmail.com>
 <xmqq8q5e480p.fsf@gitster.g>
In-Reply-To: <xmqq8q5e480p.fsf@gitster.g>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Mon, 7 Sep 2026 06:54:28 +0200
X-Gm-Features: AcwNN1WnSFEC3NuNrALltLRt_BLFHW2K-rCjKuS3p5HQYvAswTy34y_a1fr7Rd0
Message-ID: <CAA0xjtou7HwaKS8arPsBavkOREBHJ5ARN52KWukDntTJG6DUyw@mail.gmail.com>
Subject: Re: [PATCH] push: fix --force-if-includes when remote-tracking ref
 has no reflog
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Aleksei Sviridkin <f@lex.la>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 06/09/2026 19:14, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> By commit message volume, I would have expected the commit messages (if
>> they are LLM-assisted) to read more like Jeff King log messages given
>> the corpus training.
>
> ;-)
I can ask for that from the next reroll on, if it helps ;-)
