Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26836308E
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787689617; cv=pass; b=TVbHPKw+fX6DwVRV/Bc9kL8ysntZhMGWIm9rcYwnkXTKkPj4Oz4hn6+DyRTJFrETkn4A6n2Ji+6XMs/AbWg1GzhenaafxMlnCHjJSRT1+vc2PemWN2Riwiq6igA7gPouHpvXqKhOXqYSkoqo6NQCgfVT9/5y6jVDxX1VgbePeXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787689617; c=relaxed/simple;
	bh=pHuY04sc1ZQFslzJSr1GObWswTGpVGWmcYogJs2gEM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJWNE3kM0/y+lnSltbn50AEYoM8JxWWMkLYsDkGKn/IFQOiIhKa+rlY3jqTKr19OFHnwy0xk1n5hkDtysVkmqeWj0YDhxNINbnrB17m2Flmpdt4+BXBEUa9ahqPSz1Kz+qAVTzOWHcouTjlkfx5O+6Sw3gzsRT15LXbky8bU8lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=island.io; spf=pass smtp.mailfrom=island.io; dkim=pass (2048-bit key) header.d=island.io header.i=@island.io header.b=YdNxD1DX; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=island.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=island.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=island.io header.i=@island.io header.b="YdNxD1DX"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b159850b16so190225e87.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 13:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787689614; cv=none;
        d=google.com; s=arc-20260327;
        b=I0ZFtNvSOXgq/SW71Q8P9OsfhlhQrobNQhUKFdpAJA4nNQ8z3K3Qxl9QQz2GsvZmEv
         16Jf/Oi+nm2T+b3UhXdx3+uZ/u2OqKe70VdCTaH7/Eq9PiDIXQ6dM43pAz1xqTPsFhcJ
         VSY8zXgPrxTJ5EQyfs5trszTzi293JrPtnFBK3kCeXzSqaIrbGpDHGW5NXol3hotFg94
         EQ2TBWex1nc76uLu075sphnJI7zvgqM3WoBrrtyG9+4rVO8fZ5RovL6R3M5w65DROjPL
         5inZZoHlSZPbS2WLnOCSusFowQ9JhhkQIrse3gihCew5ApLiqb++2niTX0PrXKfV45cj
         gj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R/zCMX5IFQyl+GlRjLxHNpzlKhochyht3NY8aOu369Y=;
        fh=l7Jg0bdyeW8Q9iOq6X2jsY8GLImu4/0p3W+ODxIntmU=;
        b=Wpx0pEHy35xGhnYmPp5FIGDP0y3GhPgwJcLNdH/YG27E5nmZ+I9I8FUwTQAgs9ajt9
         pYcUmofvyzDolr95dOIu+x+8lGFFpQ+XNs+7Cd7seIaZVvVdqaZst6Oc0U1+5tiU5v9N
         wK6WvIMAMuimpRbt031sUeh2Y739+XZ/tomWyKGZVBF8YC1nJilNPAEyS9w0GOjNQkg4
         ysO0oHBWzrv4AI0AiReaH4R37j6OtWQFLxLEOtjJGjkbZOGvhqUbBFeSTwNAQ4efM+G1
         Mkrke89UWtXI9zVMdFydFvz9gh3l/JYI1R735EGaPZ0Swz4O5CagZpBRiLvooz37UkRB
         evvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=island.io; s=google; t=1787689614; x=1788294414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R/zCMX5IFQyl+GlRjLxHNpzlKhochyht3NY8aOu369Y=;
        b=YdNxD1DXZcP6DBEHDTKKr12EJngd59C0F9y8etoypeldkZt9wlsYfw0A4EurNY90gz
         zusRy5lLl+YwY04ix2BX/lGXgYyjWpCEfX4dBkkZ6kgYTrfgXgiIiRdYscmoEONp5PzC
         Sn4dzYx6fnKEfra0MZyuZSKfzI8bAKFRmFw6VLF49dr8s+o4qZCV4+TlQs2sfMtAWVbG
         CrL1NMrVT/gejpa+s+nxDNPCJbJ+5SADF4QU6SGoLU+8RdE4aZ13XpfWtd28w7ayJ3so
         07BbhizkEtYqHyg+ltk2x0RJZRh4xc+VfRjwZV2jiMeoIqA/f/GPagHmUTapQ9XBn/0q
         yE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787689614; x=1788294414;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R/zCMX5IFQyl+GlRjLxHNpzlKhochyht3NY8aOu369Y=;
        b=Xy8Fvy/hcmysfSeUDOt0S4QIjGPUqybUe67UOsUmhiO7E8i+6iK4bPJsXPRwjMvNFF
         Wsz7kRC2ESP7gans0inRXsEGmKN5l4NvCxLTRMPumGsmS7gjy+St9xvWkmf7G855WVbm
         cICjMPk2k6x0IfQ6pvhPsFpFw1glKoj/sAjjgQuFu+oraHQ10Pv1rBrCMayMYi9HLux5
         BGRHcbQplzEtXTE8J53NTH478/tNQFJh57JkX29G+1LyvXxan7L/OoJOW++5lmMfebDe
         FLbv6kyPmTRRT8rbRstc7ZOBCBhZNYTBEl3sqSjT5pvHLX2CvhOGGZg7jf9WHeytYz1s
         w7AQ==
X-Gm-Message-State: AFuF++kt0lywNbyxEurvmFmJ7jwRI80uzCHFnCpLmgh5Wbuk0p5lcWEY
	4cyjbf50/WbdMOKL1Th1Cji1WX/s+UjGYgJPgEfYEEzAwVnPaYV6yEnOyeqQX3vFyKIg0PX1JvJ
	HAb87doQUWS2VjiWBR2HQyFrRpk1qKI2cDJep+DZG9g==
X-Gm-Gg: AR+sD10intKzhaIAMM3xnzQ9ZT1FDbE5ojt+RI0qG+nJ53YpdomQp1IivoAO5uq4tlM
	z97F9F3vdWF5T5QHslY7wnBB3D32XqnKG7AuE//MLwWyQEJDauAGKxTfzKuIFtOtfwlO4g361xZ
	DsIiuBUh3DB8HfeJmV8gJfuRxmijR4uMudzV1DSy01iPzB3qFMcJB6n+qoVBnrv1yF604cT6NGg
	fLPoUsOmY1zychMwMqtIvyBnGk7ehjRngu+/SVg8jm3TnW3/g+dgrlmEtYRJ/LY6eQffFx5o7Yo
	tBZsYi2/SCKS2zqXsi6ahNzC99aIcp+b1iOvLFLOFOriVSXR+l7ZIpgZLudY978peTmvVB3vDNM
	mscjRFs1RPJiWrZ5ue89Bm46tTGeKVQNefsAwGJ6KtlvwICfoVafYdIQLIUI=
X-Received: by 2002:ac2:5e8a:0:b0:5b1:537b:de9b with SMTP id
 2adb3069b0e04-5b4a9064b4amr202032e87.19.1787689613981; Tue, 25 Aug 2026
 13:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825085516.66088-1-nikita@island.io> <xmqqmruam8at.fsf@gitster.g>
In-Reply-To: <xmqqmruam8at.fsf@gitster.g>
From: Nikita Leshenko <nikita@island.io>
Date: Tue, 25 Aug 2026 23:26:42 +0300
X-Gm-Features: AcwNN1UNOE6m-j_uut6lfKZb4CO4L2J7GmJRbBojqleBYBneBWsKPV_CY6YT9cA
Message-ID: <CAEXts1trFiGJKZfgE=-HAkEcLPVB7Hsx88JX-NHXHX+G+=e_RQ@mail.gmail.com>
Subject: Re: [PATCH] am: record blobs of cleanly applied patches when using --3way
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Michael Montalbo <mmontalbo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 8:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Nikita Leshenko <nikita@island.io> writes:
>
> > This does not change the behavior of how patches apply, but when the us=
er
> > requested --3way it does cost one extra "git apply --build-fake-ancesto=
r"
> > process and one extra apply per clean patch.
>
> If you have a 50-patch series that cleanly applies, we would incur
> overhead to spawn 49 extra "git apply --build-fake-ancestor"
> subprocesses, to write and unlink 49 temporary index files, and to
> perform 49 in-core patch applications, generating unneeded loose
> objects in the object database, and loading and unloading the index
> file one extra time per step.  That is simply unacceptable.

Understood.

>
> Can't you do the equivalent lazily inside fall_back_threeway()
> instead?  A rough outline may go like so:
>
>  * Imagine that, after applying patches 1..(N-1) successfully, you
>    are applying patch N.
>
>    - First try direct application of the patch, and it fails.
>
>    - You call fall_back_threeway().
>
>    - build_fake_ancestor() is called for patch N; if the preimage
>      blob exists, you are done, but the case you want to address is
>      what to do when the preimage is missing.  And in that case (and
>      in that case only), can't you reconstruct the image chain
>      lazily?
>
>      Instead of returning error("could not build fake ancestor"):
>
>      - You inspect patches in .git/rebase-apply/ for 1..(N-1)
>        patches (i.e., those you have applied already) to find the
>        relevant blob objects involved in reconstructing the
>        preimage blob necessary to apply patch N.  Some of the
>        blobs may already exist in the object database (83b2a16
>        in your example).
>
>      - Apply these previous patches in-core to arrive at the
>        preimage recorded in these earlier patches (applying patch 1
>        to 83b2a16 would now give you cccad2b), until you see the
>        preimage blob recorded in patch N.  Write out that blob
>        object (and not the blobs that the chain may have
>        produced as a result of intermediate patches).
>
>    - If the lazy reconstruction yielded the necessary blobs, try the
>      build_fake_ancestor() call again, which should succeed.  If
>      not, you can return error("could not build fake ancestor").
>
>    - And after patch N succeeds with 3-way fallback this way, you
>      would also have the postimage blob recorded in the patch in
>      your object database, which may help when you apply patch
>      (N+1).
>
> When the patches cleanly apply, or if 3-way finds necessary blobs
> already, there is no additional overhead with the above approach.
>
> Hmm?

I'm concerned about the complexity of creating such lazy reconstruction
logic, especially for cases where multiple blobs from the patch are missing=
,
and their preimages were modified in different previous commits (which coul=
d
in turn have multiple blobs missing from other commits).  You mentioned
writing only the strictly necessary blobs to the database so IIUC I'll need
pretty elaborate scanning logic to surgically perform the minimal number of
applies given a list of missing hashes.

This can be done, but IMO such complexity isn't warranted for this
relatively niche problem.  (I haven't seen online discussion about this
exact flavor of the issue, even though I encounter it from time to time.)

How about this:

  - If build_fake_ancestor() fails due to useless sha1 information, try to
    apply ALL 1..(N-1) patches on their fake ancestors.  This will build a
    lot of unrelated blobs but will build the missing blob.  This will allo=
w
    us to build fake ancestor and apply N on it.

  - Record in am_state .git/rebase-apply called "postimage-attempted" (WIP
    name) that we tried to apply on fake ancestors all the way to N.  So if
    patch M > N later fails due to missing sha1, we apply ALL (N+1)..(M-1)
    patches on their fake ancestors.

  - Optional optimization: if patch N was applied on its fake ancestor and
    "postimage-attempted" is N-1, bump it to N.

This is less optimized than you suggested but it doesn't hurt the clean
path, and this logic kicks in only when patch application would have
otherwise failed.
