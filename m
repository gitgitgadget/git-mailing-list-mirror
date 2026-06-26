Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77503F86EE
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484526; cv=pass; b=JUc53AVLQ9HD1ppCAULBLlsMGPzc3m6559QbciH4Yu7xdZYlyo7X49/kk1Px4b5NLSgExImPlx1SEwtSlv57o7HH87wI5250pXWeVh6wuV2uucg/b9gXZ3jJussRxIPC0axBqfPrGD/oRCkmR6A5mvQFlUIAakxHZQHip+lSfxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484526; c=relaxed/simple;
	bh=utV9r23lSv8cL5SJedUiEiqt2JEsuTroMSuOHMHK410=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihS4OEOSQnePAHhRkVSgOQB72fuGLfqF8cWHbeSTuUML8j3jnS0kfRK1jKn//cOA3AOx3+0ov61kYinfVZyT8/q2eYzHthKdNSdX4lbb2RvNuau0dRJQrzpFW8+3S+EVfouHz/+hK38opLiItIUJ2bFpZ1dbDqRIaHv77DzFaGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=JSZMu5tN; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="JSZMu5tN"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8051ad12d23so10148307b3.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782484524; cv=none;
        d=google.com; s=arc-20260327;
        b=QNSaPR8bx3DOorvXtRtp24CbK42MloKwXfIA1h5JBPeeCI1N62cFDZmbbohuSiniHo
         R2kirhgQNRmwm6f9cux855Vy7r3gmlupVOaMMeA86yJjdvotxaQk2yv9ggG9SV8GyMxT
         Jn68L3RY0ZFwhPsgdWGxsLRPbJLnNkICc3tLIav3FORC+dRvKtwelCEvv281DTeIquNB
         /+BI0z3W5sEwQESa/h54N4psslGgyokQdkzyd1hBFL13nUCGExs2isrjIyT+PA3XsiDa
         12BP1/olmbXZwdOEYJFJAA2sB/FfZuJYmbYU8ga4BXV9dVhYMcG88UGKwF1QCciV8O4s
         cMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hJqYhU9XljJ7AdesaFtI5gn2PML6ogSvHSzKk80PAbw=;
        fh=zZsAgHjdobgJr1dBfx0Ju37uRuq02BqSx2X3v6wCd4o=;
        b=PU3ogxzU694U18ULPCqJwkjGVZqoQLqAeA5rmq4U7WhlH2k3ZEZ52UnIymfsJGjcGW
         3yZjTNZRyoEC2GDrp8OrFZ9KaPO8JFG5SK6ExBDran7mcycqXTf1rHN/Py6FKI9nWjGF
         DyIOciia+BIjOGxuG666chY1zaDLRION6DqOx+1758qcyZ4avYZeV3zWfF6aWgURlI0x
         W31Ul2LK57DLBnt5ndJBj1KutuLvH1+OCnC/VtAqUMTnY4rc4XrDuvQifa72Jyndf80J
         zJb1xAUlUvWxMs1yb3+a7lzvgTMlwL7kuUwEMN7tC9teoZGaoeQTGnB92XkBQxz/UegT
         91ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782484524; x=1783089324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hJqYhU9XljJ7AdesaFtI5gn2PML6ogSvHSzKk80PAbw=;
        b=JSZMu5tNWdkq8OPt3cEcSvX96QjcaxYQeNsmIT0FFYis+6MQV4ZuraFOXKvKNJ1q9m
         s6aCA2/nmzLTkuhu9Ei1IeAPhZU8w2ItCtf1X13Wo+qCwc7dlqxPwAxp8/6ayABfVZWJ
         9guKOcjwcWuDIixpwdydl4wnrtmE/o0hh6AIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782484524; x=1783089324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJqYhU9XljJ7AdesaFtI5gn2PML6ogSvHSzKk80PAbw=;
        b=XM5DnXIXNZZ7Qqp08E04ZJwKfqIqMt5+FzMnRu7Vzu52/Wi66/aQJvBUgJ1yklvS1D
         ucYytop6JHVXPWPhK0jwdbGuOWu2iAjswDnld74Mu0zN9MWGac4/z0KZ9ABr4WAbWasG
         OZyyIdmLbN9pSzeL/kQMUhzaZHMzFCEuEt1SPArZ1/t44UHPGHp6VoXYHTAj6bJjPM65
         DUAibgZwMrpJUmSid9+vt+s7E6ftDHcMrHB2a6BjnXXxRoydiIAXz2p9fv+t8EIg/YQ1
         CFmZtN7Amf8cn11rkzdSywn4iA/XQlV9HgE7NGDAxmQ24N7IV8SzDMmSCmV/IG3MJdfr
         ZFEw==
X-Forwarded-Encrypted: i=1; AHgh+Rrq97nCzwuBjM4i36lkLa7XMCYgaoaNJeqksf+OGxvxahs5oot8QYMXAk4EgX5YkxLmdt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3P1cQfuGqayBh/ZUFLr3C/2CQD43yUzV5gI6364oXnnSV4Ei
	R3VXLLq19QWJWL7aGFIN8EadI4ze4waM9ZLJAb43jWOQsTwv3YfqPyweYRmesOwNBZn0Zw50gxa
	uc3iMePDzI0a3eRZgyda8NfMV0G2BbUXGT2aCnIatMw==
X-Gm-Gg: AfdE7cmQq87ESBlhqoygP43MerHLIq7WAYKs1F03/LQUNkFMV55MX1qEljlNu83GKIo
	A+kN+Dq/kuejs3UsFuY0clu+qud0BNmcQsJI/pCQC1dMMNOP3zZ6NebLCVdHmn0rmiv/EmZYJDu
	oJHx5LVyLO2hw9vO7nP9vaqDMTbyi6ITpCgUfbQI30P74ELi02xa8HHZz7B3EWKWfqiAqmU1RcL
	S/VkQyIGcH+ObcvqaAuleW7e7K2LAuJr5B3zbN7ArLlusGkAcO1RzkwjPBtxr0i3+/kRidB2A==
X-Received: by 2002:a05:690c:7248:b0:7bd:995a:a31e with SMTP id
 00721157ae682-80a6a5aa349mr70280407b3.7.1782484523686; Fri, 26 Jun 2026
 07:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com> <2592264cda543c96c4479bb4ba6368c0121e4207.1782479286.git.gitgitgadget@gmail.com>
 <a74d3114-7d7f-469a-b181-60853bb82864@gmail.com>
In-Reply-To: <a74d3114-7d7f-469a-b181-60853bb82864@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 26 Jun 2026 16:35:11 +0200
X-Gm-Features: AVVi8CemCJdeP3mU1MBJ3lIt341-HMGVx2BMW067J_aYUJlzk46H-tBG_Pff148
Message-ID: <CAL71e4Oc2eUxSjF9wW=JbAqt8kVoiuDzkDHysGorHC_WEFu9fw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] commit-reach: add trace2 instrumentation to paint_down_to_common()
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 at 16:31, Derrick Stolee <stolee@gmail.com> wrote:
>
> >  test_expect_success 'ref_newer:miss' '
> >       cat >input <<-\EOF &&
> >       A:commit-5-7
> > @@ -209,7 +219,8 @@ test_expect_success 'in_merge_bases_many:self' '
> >       X:commit-6-8
> >       EOF
> >       echo "in_merge_bases_many(A,X):1" >expect &&
> > -     test_all_modes in_merge_bases_many
> > +     test_all_modes in_merge_bases_many &&
> > +     test_paint_down_steps 45 2 25 3
> >  '
>
> oooh that's clean. Thanks!
>
> Way to over-achieve here. Thanks for going the extra mile with
> this patch.

Thanks! I did not want to change it too much but this felt like
a natural place to simplify it a bit.

I also have a local branch now for adding a
test_trace2_data_singular helper function that provides
more diagnostics on failures
(show expected vs actual similar to test_cmp)
but I'll submit that separately later to limit the scope creep here.

Thanks,
Kristofer
