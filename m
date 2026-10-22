Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792691088;
	b=GMsBNoPmr4U5VGxMlbR9hBBPXsJy0VCsGJ9Ylo5gwT4ruTnyyjbe+J9o2rkMFAfHMAIm
	 JkONQXruFlrbZkXOSZNTbxUTUJPBaH8xRxJxfrYt6ASkDflJpk7lk1GHHamk7fvsmjOq4
	 pryYdB3T3ByY54Hb+TB7rD/5QDKhR2vVGyE9sFJrAsedFy7Nb9CzrHD4YClgJ/tsUloP2
	 1NzYacvmKhAbdiku5vkHgUqpbr5i7xmZRjUrcaW8uwHH3I+ZJWyhHWzidD7EHWWDCJnVH
	 t5p1pyBqMOVD8Q50ou0U9wl6PNgoBrL+rA9zzmmzu66OYDSuLlNzSLRsDbEuOCXs1jQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=TwaaLUJsXwZMTF+OgFsPFOlwTsMckJXtuef+utPu8kk=;
	b=eWaCLtdGwwU4odenCHWe4xoKLv2ao9tV9bWyvvGvENzt+PRI6ydnQQ1QlupFWgMbCx1h
	 xuiBkfWskmSttYSfA+eQ9C32fz+YdZOZbhdx9jdUY4mvkr4DT8MwpgnrtdcK2sUpjMV5A
	 8iw1QEurMpG8VKJ14gPCYOI7tqGWhHWt7JJRJ/BKkPJRcvoldztKrAhIXfSBxHGWSt7rY
	 OLUWwUmVLqDyEoQk9GLhYj3JBBMWr0EdUMuAi2LXfNfH4okqiBAsuNnl9DxwS3BC8bCfz
	 qiIFbbq8/XurUNbL1eLW1bN5DRKo9POlulK4xL0Lblq4ypzZQDdw1ZdvgF1LPa/5SSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OpeQRjGf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47A606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED47A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OpeQRjGf
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so3717607a12.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691086; cv=none;
        d=google.com; s=arc-20260327;
        b=ZK9K7OXCWrjHDZhxqxFWvEr53bXsckE89iEWwVvUpUrRl2fS2+Eitf68QQ6fKiOEtb
         8Dt7vNMLF5+GIl9IRIJBKua1yI6CaASvmndQmebFp93cOoBJ2QNpTOvHgJ2P6+YUXcxN
         HsLIRDAEuChS2wBGK6RgDRoO5j3/MQZ2MUZy3sg8HSj1+/irqtDKdUHYUpJbqPATY/Xf
         O+ZDDJGRXhKIurJTovSgV0J4TOUWvT4IjlZ2DpGNUvvc4cWo5U+L9JWhEIXsZQVyfo9b
         sxgfcfv2SOcER7Yt9yh5IRCEuEg0INr0/hqP6BXoLHnVeE7P5GzDE8uiI1m8VlONL63b
         4aFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TwaaLUJsXwZMTF+OgFsPFOlwTsMckJXtuef+utPu8kk=;
        fh=J/ni60HWp3CEm4ACjDCZBuBseRlnsGzufd9Y2NlYPJg=;
        b=nQrNb9SN+JsHlHLloC8Mi2RCHtxB628v3EQbrRizPq3/DFKVEIH6/NcnKwK1yU5tUJ
         kiqT55VrVyfywxeSAy7Dd6Bzsp2zKISW0MaSSRvF0PN8yvUqSuCMJrha9tGbIaMQs9H2
         v0+ju5C6FOupY8EE5U9dnLQZb9lxXtBOUsW2Vw+64wMPwcSBEnU7jQWlwwYB6jDfQUjq
         82nBqGNqlXOQlzyC/8CXCdGaDARVuJs0WV82uNSxyOWKWZ1uHQraAnnA9t0fVLlztCag
         nJuqpjJOkEkdoIVA0lD+vfuwnHWo9bqrhRD2VY6KgSL49tN/GQrD1gTRVATTW7XH3leJ
         hL+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792691086; x=1793295886; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TwaaLUJsXwZMTF+OgFsPFOlwTsMckJXtuef+utPu8kk=;
        b=OpeQRjGfc4LwM9v50OOHjV4RCJd9xZiwl8+geafCHPCbAOv3o2prjNVLy01ULFoZp1
         0ihrMSiLFMQQjW9NdlVGlbxdPv2D2sCQfJoSqc+YoRgerjGCVlXr91PuMffA3uJd3Cuc
         CLXY2XkHI8QSwjjNW09/M4URDzH7XBXHD++w42xWX1+4bKbGknW90tCPMpzOGcLMCvnV
         VHhUzkzBWxtC7YxXcWL3sa7DKw8/6A1Kkyyw8tlKazF+1w9xQwDUFxAWb1BV1U5BKJ4Q
         7O1toRGYlVg6R6GncajP2MQdI9GDlX6mD/EdWgksxJJbqfGFg6gxo6c4qwBcqCbbXto1
         iwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691086; x=1793295886;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TwaaLUJsXwZMTF+OgFsPFOlwTsMckJXtuef+utPu8kk=;
        b=t/U0TK3+2ttVPbgiJWyYThwAGmiI4fHe3ZZV9uwUuawno0C6tIlk7mtFqTlWjelZKf
         qqK8TUL1IKNcD3wK/kXDEQJcp1MwX2dkkToikpoRGVZT047/KEUXXFQXqhx+BaSu2Ax/
         XH3jXho6eKAz7XYuSJSTiN/95HgiKBX9EjzewU3xjUeUTHAKVYI38Uy/RIVxfqe1eRb6
         G70Cqz1z5Wz4K92hsSFKkkEgC0pb4uCsGhiQ+B3Bdnk9alrs2IP0kZ62IZgwmdcjKoi0
         J+Hf6sqiPfJ6R6H8PWl7k1YcHFvuN+BRuvs7Z3eLa9pmBmoSGEZ9iw9ufnJqQQmYAe7C
         GkgA==
X-Forwarded-Encrypted: i=1; AKwUvBzHFL2OwjqMZ5Pub6MNHXhIzIDL+noUfFEsBsY0SnkHm+gfJI9ToxUduh1ShQHQ5xvuGF8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsIhJxxopLA7DJ81JxFQ81PXTgoXG91Y3Dpu4MkGKs/OkHZUIX
	Zq3jxeoXspWsCkdpngmMQFDiuXGZ5sG1JPfFY1bQgwtH/Sagvb6nBf0EQsELSVR/Pl0QQqH68TN
	HfWSWkJNIOHhR6WA1FxXp4DDo5qcbEpw=
X-Gm-Gg: AYBFou0cdk+q4Kb/L8m0cVyICm6PfOYiEfOixBSL1kh2cGKZUB/SYULicQHyAqVhF+a
	EW5UygTwgdCtmHYPMRAjl7HyB3JxKnT/avmuPDthLmnisDS4riG6RCHMFJDBMGcSk0yXwuxOsoF
	4ku8roNRsk42i6LgVH+LjKXF/2yfDyRdWxSMZFj2tnP8JRvKjSN/JyMGgnkDx+g9d++9V4S6qiG
	/t7Esb0PxBlWV8l/yErLDYxStnWDMeWs4QnMxXpZApOUJh9MMSZ6dEftEKuiE1OFHvSnQLjRPb9
	24m8wni1kDI/nXUySa+VgBts3dR54inrhhl4Qmr57uZD7fAGd6q7qd7UaMczw0Bj25QKAUgdrWu
	F2spJXHsUmTdQBhiXmCmNdMmfjb8aaArbI8fk
X-Received: by 2002:a05:6402:3456:b0:6ac:c1fc:8a98 with SMTP id
 4fb4d7f45d1cf-6b432c34e61mr129231a12.42.1792691086133; Thu, 22 Oct 2026
 10:44:46 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com> <xmqqjynajndt.fsf@gitster.g>
 <CAHwyqnXcdgzRnFgFhTfhQFFOgDxUUKoPf2sGViBTiXMK1aNttw@mail.gmail.com> <xmqqa4o5itkc.fsf@gitster.g>
In-Reply-To: <xmqqa4o5itkc.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 22 Oct 2026 19:44:08 +0200
X-Gm-Features: AclHuK-KM5jNgwnMrmDy3YZa3WLXwq1-JH7qKEBKI_Q4-6bwoGdvMUSA3BjDL4Y
Message-ID: <CAHwyqnUpheti76YJSn4h___fNZr52PzPQq0pQvA8KNyuoanxGQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jasper Mayone <me@jaspermayone.com>
Content-Type: text/plain; charset="UTF-8"

> I would avoid a negative-sounding word like "irrelevant".  Your work
> is almost always relevant, at least to you.

Yes :-D

> Another point is that different kinds of detection should probably
> form subset-superset relationships, rather than a Venn diagram, to
> make them easy to understand and useful.

> When you specify --delete-foo=squashed,rebased, do you expect that a
> branch that would be removed by --delete-merged (i.e., merged as
> identical commits) would be kept because it was not squash-merged
> or rebased onto the upstream?  I doubt users would want to make such
> a distinction.

Very important point regarding the design.

> I do not personally care about the distinction between rebasing and
> squash-merging, but users probably do.  I suspect they expect that a
> mode catching squash-merged branches would also recognize a branch
> that was straight cherry-picked (or rebased) upstream.
>
> Perhaps the options could be structured like this to be as easy to
> understand as possible:
>
>     --delete-foo=merged      Same as --delete-merged.
>     --delete-foo=rebased     Above, plus rebased.
>     --delete-foo=squashed    Above, plus squash-merged.
>
> Would this be a clearer way to present the feature to users?

Yes, but we can do better on naming, something in this direction?

     --delete-foo=match-hash     #Same as --delete-merged.
     --delete-foo=match-commits  #Above, plus rebased.
     --delete-foo=match-content  #Above, plus squash-merged.

This comes to mind
(https://git-scm.com/docs/git-push#Documentation/git-push.txt-pushdefault),
different `push.default` options can overlap or subsume each other,
and it's also clear that only one will be used at a time.


Harald
