Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982044;
	b=j5dA2UxuFi8ZH+ghWz977HApkTQct4iIdwA/QZ8de5b9C6n50wQ3fO3x5Got69g0Hmlw
	 7ZqQXePbegnTtNLjIASrUyfFbnjSC7s+v/BES0c0a9JaHo8Pv2tZ2B8OqroFBuSsUPoVi
	 kjVixXlQ7PKKg6Jj8ile4ryt0YqZUdavwukfkqh9uh+sH2h47o5p0T77ziAOSW2SpgRDS
	 KUpPbF2ARCCBlyztfvKPxw7UvOwlTWg3AmULi2lDKEFo2AnzfqjFyYdaxeMe3ekTcVlTc
	 bxy83QTKzx0qpuMqo1gwsSVxNuIz3yCxp4CzL60IqPej0ZiUng6/VKk1YdSjsIaGhSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=a74rhlC4yJ6iZmFmkb40kZ4FxUkRcsTKlIoWCehBBfE=;
	b=cG9rXvTTSTK5Z459m4zzm6nwIKpULxuCGSOs4NKgq9ex0p7v/qB2BjxfhNJyB85PFMrv
	 eQvoh+aeHYiSLlgo6PwoeBOPRi2eleHDK1diw586N5D86L0eiwvKGrowghUNfNas/gY+o
	 y7NfLA/dAeAQEWj9wCKNzpe0xuODgbxphr43t16LR+qwqd3eoGluO9qdqXCkAP8pTIA1A
	 2oh/lJRhadP4t7GYmsGR+PjlU2i2JTvWPwbJ2UqOE5g2OxJNx6Lac/+7zwAv6XpkIZV6E
	 nPAZEuN/ViiotrNoc22z9Nrjd0srt3ONgTJ9f2KQaQ3Ix0ksTIV4dZtmaw0se2RnhzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x2q9CDlp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF6606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 16:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38DF6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x2q9CDlp
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-854e904005cso1412090a34.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 08:20:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793982043; cv=none;
        d=google.com; s=arc-20260327;
        b=KZV+yjthze17/W9h0CtmSuI+nTInR0zoxuhSNO4jsDOepopg4MmCUxYyTmNjR0vyTL
         8sNe2sXy7e0xhOkZ2IiEpksRhRYmMXbs+0zK8aiDS0RD3u7qwLiiwvVqdHo6vpQnWUvw
         dOF6eztLVEpsMBKVQ6wzjTWqYJjNMY3m4E/phc25yW/K5j9kPk6RehMDAtr1NjtYjHiS
         nU5jk00QWJS4FyW0dCzaVYj/CoU6g6Gcg2bUEiz0EMXy2b8qn7MNMitwlL8jHcaiWDKH
         D0z5tyHiITK8FAb5Jjk+rypN7iviwUI4hwKz4YFjpx96bDGapee4A3KXf0hbUN0D1oiC
         v91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a74rhlC4yJ6iZmFmkb40kZ4FxUkRcsTKlIoWCehBBfE=;
        fh=01n5ZpYtL2lc8OJDGqB3dyQTn1NMNCzuqUCgs/ekPp0=;
        b=q1KmOKntlyJZ6/XWIrFhaeDTWILU/cNZgTTpR3fVpNk1J+0zsB3N0kG9fIu9LplAeZ
         9jnJaVKEYoUhpauj3eS2jVLRTp3iWb2ZKQAOuRW4hFIqozmovYDhiPvq/2+8dE5xNIaZ
         eQhuOjQ8u/A5ACyt0Tp4/L4kqs8yUr6MCVD+G9Rc5VIOzCC8oKVHV5ahNLmKAZD9xAs1
         R6Kc2146X+tM1FjbnzxnIRkoqZd0HelQXjlRuR9GwgN/aYzkNFv52ajVT19YRc4faTzV
         WODiUw6zQQRdrvOon4xNslZW2H8Q5lQCxI7zV6kr1tyZ421Dss1nqlM1jejIUzWDd6jB
         HPRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793982043; x=1794586843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a74rhlC4yJ6iZmFmkb40kZ4FxUkRcsTKlIoWCehBBfE=;
        b=x2q9CDlpN1CWGJ0mwVabH/HY0/EH+OvuGEEtdp94RUOd9MolMVeNmovn0m+IGFzsK/
         jgWh55jNJtOgNvt0A496yXw28/J4mqbNhqe/2S8qM1Aco9l1+iGiIiIxdHs5N6+JsmTK
         GC5TtitGDCv203Gqw2ZnPckiKuSse70R4RSk15ECBBMG44uOM6TRrK/CMmYMfIztCERr
         3pxaHYArACSyjhSWJC/CS2lM265javVu5Ih1H/7xKzlBG0KY0uNz09LZuq0vEti4/IYT
         e5h5tnWFopMKfgSztDXsgBgiL2LoAPB6HnkonOB5jGr5mSMaVs7KgDWL7IehKdIeWswb
         qexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793982043; x=1794586843;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a74rhlC4yJ6iZmFmkb40kZ4FxUkRcsTKlIoWCehBBfE=;
        b=Zkm+qLU+UXSm4rDBsSeiW0HphGFaWTrRMquGLBTrfcFHi7WbpwlJHaLVT7XQU3s/qe
         TOoXrQ/N04lohim0lO0qjy8VNiEoTB2MMIze4xNz8BLcMfXhPLT9yKwHVvYFrbuQmNq1
         mHiUjdn5GIrrx4J6rSP55V28iJcIHq2hpa+jXak0qgZZwssuZ6m9RopArlBJKFrSxMG/
         Axgyi7dHzTKW/7+A3TwoozWDM3w6UEPiOiiVtKpvbFbrdca7pbhRL9lJcGnaGJhWSJ5z
         iCS5y1NpJPrHkpbOwO867oFc6uIWQ4SPcLqpSZcUbTY6VDpBzY6DvWGE5ts5uT9bf71z
         Mt0w==
X-Forwarded-Encrypted: i=1; AKwUvBxk+lHdA7flnGEltN3geJmmDBc3pff3A+1l6VShJZ74PrPBescuk2kNsZFgprVUX0EHNnE=@vger.kernel.org
X-Gm-Message-State: APuU4Z981tDX+RHiXcTgv5mZ8N0YDDAffvv4foLzVUQZUJZ2N1SYvD6s
	8EOL+vw9fuJrMgsxsrYspnpfNX3axrbfuXHW2Q7yPrSN8iPcq0BZNAEE3KnzPBouNrl4VElHkXF
	Z03cQSoeoQW8CyytSY4G/m07TIkwwTRc=
X-Gm-Gg: AYBFou2jd6F+5kGQn57rj2zXXJQn6MPCakgpcG5brUqTCMtt89tNJm/DuOrax2MnG+i
	dkRCJ/1zf3mZJgynPjbmkHYOdnp0Pdl7JDqJ+1fASNqUQa4CFR9HjKbbaEYWWnDB73+1sgxL/Iz
	9PhvcZyTocKiIo9GhEf2w5Kbe15iTqASTFHT81lfB2xkmYyPQ63/pT82hMyW8z/sD4MOb7JFGlV
	+FpF0ojGaFNLfhegHNkxfvMGKv0zLXUjtQmLava2EmnjxQzaMe0z1HtNYkRy03TFw+AJBWnQBgR
	4cGa9qNyGx63wcJvi7PQtFNf1gzoTOQT6X35ZgNNMGZe+7116TLj3OJIzdD5zfTsukjdHHlyci4
	5N+SqfLnamo0rBtF1i3VhYuxGKdk/gxGdWffE2y8vnJFlYp3HJmsVCxDza9J03qHedK2Ax3d9iN
	D3qwJ7
X-Received: by 2002:a05:6830:6512:b0:81d:9acd:ee04 with SMTP id
 46e09a7af769-85f1cb64f71mr1884202a34.0.1793982042969; Fri, 06 Nov 2026
 08:20:42 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2298.git.1793966368860.gitgitgadget@gmail.com> <au3hVGPuDyGVwOw8@pks.im>
In-Reply-To: <au3hVGPuDyGVwOw8@pks.im>
From: Joie Joie <soniqjjj@gmail.com>
Date: Fri, 6 Nov 2026 17:19:59 +0100
X-Gm-Features: AclHuK9disW0aoGC8qgfh61CmqlphKOKneHHQYfdaN7P3uc9c2Q5tsascfWwET8
Message-ID: <CAH=d44eGRgHOF1NX0t6+OJP4GVhTqnvQi+sgnM86CC4FE_4LsA@mail.gmail.com>
Subject: Re: [PATCH] repo: zero-initialize configuration values
To: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi <usmanakinyemi202@gmail.com>, christian.couder@gmail.com, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Patrick.

Yes, that was my reason for splitting the patch. It only changes how
the existing configuration values are initialized and doesn't add a
new struct member, so I felt it could be reviewed separately from the
changes affected by the recent direction.

You're right, though. I should have explained that more clearly in the
patch description and the original thread. I'll make sure to include
that context in future submissions.

Thanks for taking the time to review it!

On Fri, Nov 6, 2026 at 3:16=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Fri, Nov 06, 2026 at 11:59:28AM +0000, Joy via GitGitGadget wrote:
> > From: Joy Gundu <soniqjjj@gmail.com>
> >
> > Use memset() to initialize repository configuration values to
> > zero, removing the need for explicit zero and NULL assignments.
> > Keep non-zero defaults initialized separately.
> >
> > Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
> > ---
> >     [Outreachy] repo: zero-initialize configuration values
>
> So I guess this patch was split out because of our recent push to not
> make further changes to `repo_config_values()`? If so, it would have
> made sense to point that out explicitly both here, and in the original
> thread that you've sent.
>
> In any case, the patch is obviously correct and is a good improvement in
> my opinion. So this looks good to me, thanks.
>
> Patrick
