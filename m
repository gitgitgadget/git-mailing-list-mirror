Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023F3E51F0
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741744; cv=pass; b=rQryAdIjlxQijh+z7n4EX9NVjD7kUWJdg/1HkqQSucFeC5+jTDXdQaaii08aRDBUgBjc5ZGetFBqlMib+JyY2uncGn4LL+EpJlRLpP3s3T0gkFZVtEl+LhmjwwqejDoomXkYeHZc6o5i1WiTjv0/FqdPPa4JRPs/53oxO99qXLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741744; c=relaxed/simple;
	bh=Jiq7i72jtG/e5vfPI1fy0uj5F/VGqAuwa74EL/TythU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bSRqi8dDa5J24LoYJu2MRXGEy+LKebxZyrM0GdwGzYAobpn6SGQQQyxD5wPMtNZDzWvdSFXIDVTXNJ6EZAuPwE4+S50e2ohw4d+NlT8VDXBtuJzLpw52W9XF4MpZSgSXTBoJB8fgId4TcjZxXvyB4WUedX3tvTK7LPUfmhiJ5+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsndPzoc; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsndPzoc"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c96c92c0980so542790a12.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 03:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787741732; cv=none;
        d=google.com; s=arc-20260327;
        b=ZTJ9u3BLm99HuKOSDvV2Yls9bsVIG0lC//XkxWUmVHPWYqfofRFVhpkLeDx9IXrwNK
         jXXGeaRIq5L9uhlbCZ4fjJttRHngH7qa0ZvRd+fWrvF3DW6l/LvN/VX8muB4CaWEE6wc
         CbWGYhiJOs9d0sZ3O04GFHkAfo1vkr4OTuGuCPiISZFU+rY+N86EmeKKTgHcNQ2GJ7vl
         tSXpXMhjPDDJ6H1GakQO6sTwdHokIyQojanffzxq+2gaHV1rm1EkcsGxt/vPeMLZXum1
         g/KUS9FCWaZexchXL+a9K3E5WKoctl//I/8RAQ1UzMa9IDLBG36NjHO/dHarNtD2wurX
         SfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Jiq7i72jtG/e5vfPI1fy0uj5F/VGqAuwa74EL/TythU=;
        fh=fWFOT+k0LcQPZlUqE6tEnc8N8+hRv1ZO0UyeceOWdV4=;
        b=p9NRQKo98T0oMKTjXYqca4zXkp58Uey06N2P7Bc151tTAwcSmDC6S1lvZJ+nY7ZQKt
         uYmXVzrNpCzdvrgtz3+c5mhLchGRFflv1KOtKf6jvHm0IQYQiF4tv1qOLFiwyrKtWNYX
         3+9dfWnt9Wb/AxAXzTjRTidknWSMQ+/7I2xe+szCnQjMXRXAuk1xxJ/6UiH4jLq1Olx9
         //9iuF8wDvre6xy3xP77svARPOsSTO9iKVoUTbVrlXpMqKzQchcDv7jDmbOVfW/k+zwE
         kem9JbiAH8kus3QwhAJClgjyfsUv+uPOIv5JgftWNF5aFQY/XUhpDVwYeqVITKVfKppy
         X3Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787741732; x=1788346532; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jiq7i72jtG/e5vfPI1fy0uj5F/VGqAuwa74EL/TythU=;
        b=PsndPzocJUdAIz6HCAWs7F0DyS0RdWs4EmUx7h6NBVh5WlIeDi4BkK2c7Ct0Ux/2P/
         N90OBBH6Nqh8Gau4lT9IrlB/8q1HcCjteT7R5MzbEoW/8+Qyx1VCLAR8rLClEQwUaAi2
         Hd2OYIHFM4u5n52YCFTNalSVNAhyJX9G75eCn+L0X7GbCSLwqunJWbBJOjRMJXeSRUl5
         6u/hrPjqe7hx0BwLpktOZO37doaS6P+kUvmPXnd1n2XdlrRNK2ZLbnEhCsiyirCItDkU
         /xpbeBd+ghigW6FmWYnvkfbT0CZhAjSzYtrwocdSnV2BxVxEs5K2c7TyBWkvNEdtVKyI
         nCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787741732; x=1788346532;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jiq7i72jtG/e5vfPI1fy0uj5F/VGqAuwa74EL/TythU=;
        b=Jm8ebUyBjx+iiOcfb/fPI5OgqRtiLED1MFrgzv+X1c3CRYTniznVo/Mct9Y8pRXPrv
         0503s48cYedteizb1Rojo3viuSMhrSYKIbKRu4LHQADnUGDCJJNuxnx3KnqAV4PKxOfk
         ekUilsbMtBA788ntX5wmssBTiZY2PfntoR6XjCsMBu9NfF9vE3XgkuFnfEbWM1Fs+0Ty
         OwTlvboreI81rC7WRzkkZUh+Awk7W0pGJWbGIH2frC0q1T6J9OsJsTEBVJdjUVPBF8aA
         4VtoJv9wZ+vcNqq8N5tYSE9W0z9qfRzOc6TouGmdQtNZ6nks5t5yu+KJtIxvDRv2fySz
         cEBQ==
X-Gm-Message-State: AFuF++lu5t+E5riJfTKNP7Ed/I+eXT3f/LXogDngEESkWI2ZAxcI98os
	kd5ugvy1Uy+PMbaHy8ISwmYRMfsJY3i0GZCbtOUNtFajnvqgZ3JzR6SkrhM8SuvQD4jwa+Q2rXn
	dAfkU1pVhQ7izbdTQcYvqKBkI6qAssbD+3vqpFio=
X-Gm-Gg: AR+sD13+PBpThguLQUvvIBdhJRO5H4LTjRbzWw4faZ6WYHOJmb2Z3LBfvJEzsNb/+qC
	k12jmb3nSUa6VdvrVNpWDeUhH0CBXwyj7oIRY1bZfBGAERmVSkADtF/k/sAyI1zJKpomFUmV06j
	QapzVdFIvZDlXQu//toR4mj8mTbJw8T+cBXO8lBB3YLYtjaHRuObjyTDDMQ1LtCiK1KWM5k4VB4
	Fy2Lu575HmQyWBpN6RXTP1kRIM1Pt3cD7pEb/jnjwMw9lEwungtuaT5WsW6OYnUMTPQi2KAtsom
	U3D8uqOqoL8w115OjCSkS7IX2LNIw4q0pQ9Z26BcBx3MGydaxX5kpeM4LlMkKHTWhHtwT4F/c0q
	zDoUh5D9UQ0qA4B4cS1FOXChfGWNfkdYUhDAjQmVIZnx4LuiHZpdHV3s1KIDmX/YIotoJTWRWTG
	bvQYrzfAMmqRQSUGVEJSkDLAGFaX3oh9BnGWo1my0T8Kw4Epo+x78F3f8D4Jv/fj2j
X-Received: by 2002:a17:90b:2604:b0:38e:ad9d:1151 with SMTP id
 98e67ed59e1d1-3966d18ec9dmr12433386a91.4.1787741731565; Wed, 26 Aug 2026
 03:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 26 Aug 2026 12:55:19 +0200
X-Gm-Features: AcwNN1UZXJaUYdZLXODXt4UlRFANnGPKYMqjr93Pj1JYJXvp_t_fVa8QYPD-SpA
Message-ID: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
Subject: Participating in Outreachy's December 2026 cohort
To: git <git@vger.kernel.org>
Cc: Git at SFC <git@sfconservancy.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Open Source communities have until September 11, 2026, at 4 pm UTC to
sign up to participate as mentoring organizations in Outreachy's
December 2026 cohort (see
https://www.outreachy.org/blog/2026-02-06/may-2026-call-for-mentoring-organizations/).
And (co)mentors have until that same time to submit project
descriptions.

Last year the Git community mentored a single intern. For a long time
GitHub or GitLab used to sponsor Outreachy interns working on Git, but
last year both declined to do it, so the intern was sponsored by the
Git project itself.

Let us know if you want to help as a (co)mentor or an Org Admin, if
you know a company that would sponsor an intern, if you have ideas for
projects that we could propose, or if you have an opinion on Git
participating again this year, or on how we should select interns,
etc.

I am likely to mentor and help as an Org Admin again this year unless
we decide not to participate.

Thanks.
