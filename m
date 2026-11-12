Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794519994;
	b=o0Yf+9y/HkXb3XifNhEkltjG2E2HrMg4vQGMARfF4PQgYQ86geLQJ9yoTJEqEyok3ep9
	 3ZnUwrQA8ycEK8pUAesyR3uq/+CikXq4DrdG8jrA6a3ox+/TqGBZyaMtOqoPhAXS8ID8M
	 fAtT2qTRH8YQI5HBpMQ5ZyYIT8Pi7VNHNidplQqMLTv48a2ybv52DEBxInmPto5kDsz76
	 POj9Lj707jL6Gy4/rrxvjO8+62qHH6576FmeTm1aoVZmh1Tyab5W/6rPiWg8Y9fTmn7Eo
	 nIw6WHGAx2W0xjcJ8IYgyncOIZB/PhpnVgwJkDu0ssUkifrCU5H03ETUGIaqv7xFtyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jSdTtQAznWWniYEaUZU/adXWabbjDAj1ygm/wITppQw=;
	b=eYizDRrq+Ips6U9mRakN0FHcyjfkn3SGWddMIipGqXt8TYJ/cJpKw76MoUtqDGAId8Vy
	 52F4VURALseH/PM+ZaARvJzf/Xf7gaGNkPnl0WHzbTubntATS+OZPu4SvWWyePQ/Vk8ih
	 l10ulvIgJVrL2WLki8MGbWKh/jiQLPkuVbIzClGNNTkXqOC5h4n+mtjq2MtClu0yXvUs2
	 MfnoXlYLrFxbD4DRiG9KYxnMkZQYRS+5U5otQs9q4rcy9DJgmj9v+7mbXydiaZ5Go/5fb
	 nPGOi07ZZ3nRH9gpjVQAyx9HYUMGtokN3F51Z0L/pgEL3ChyMdqlTD5UXQHnpkQ6Yew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=jD3Z3gAc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF0606A88F
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 21:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0CF0606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=jD3Z3gAc
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67c2c2ac1c3so365769d50.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 13:46:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794519993; cv=none;
        d=google.com; s=arc-20260327;
        b=mSqUggPjWJ8BwaiWhNHOMxH3nQ3jORMCYMGiRMbcKA1X8Olm0w73T7ktMpxsvx3XsU
         cCQZGHyrjtdMNjr54tEtTBI6k/UV+JntJXyzAO4YXeH763ypk9Y4i4rK4s5bVXO6F8QB
         sMnc3pomc2DhIVdHtxRKrc00JYDyAYfg/W/0vZyiy47WnM53sy4tHnJG2ufJnqtDmopj
         qwkEHQDYWlYdMJvGQ/7I7lNUyiGmhdWdwHUpYdzFnUi71sw0MsAp1YX4bpl/ZiHMh+6W
         i28rjejpobFYVNi2DuHSsHoELh4E7qA7pZTfSmXAEVHRY+3wBYhtQmjqCigx6CAlVWIo
         HTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jSdTtQAznWWniYEaUZU/adXWabbjDAj1ygm/wITppQw=;
        fh=D5VILqLqKj6YScCmTb1VLQ+ARo5Sx/Twva6iixQbpuE=;
        b=CGAUWxPiz2UO0jkoeY3M50GOeVKahJsXn9imtTrQMXZ40v8UFNGa3y8JpoLBdk0BA+
         GdA2DI2Gr4EJdZz/xovQFiFimde7v6KT0/ciY844J8DwPAVOaQ7mrAZnN38GY4qvNzUE
         mPSoLyO3YuqIpK3b60cyqjMsrIdZUHLzEJxfWUN216+D4BbK/oDDVRxXlGpB/8w2D/cl
         ok1Bc0oL7Ep5/Ttb7CvRHHBd541RVQyysRpvtN7YM895Q2btKNA6s/oQaIAmDULjxKmJ
         CcC4MC+iMojYYnk+D0chWQqt2H23Iykh53ijw5zdPfBq6UlOK8CJH3At+f48XmBSGM7A
         N57g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794519993; x=1795124793; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSdTtQAznWWniYEaUZU/adXWabbjDAj1ygm/wITppQw=;
        b=jD3Z3gAcxsZ20PtU9FxZHYQ46PQYZmnudUjCzvKyRaPLq8VDj682PO7mvAgjFx7bPp
         qmXUx4eriSwUoT/fj/wm+dNCT4eKDET0ihPylV+tojd5rTE0DjOYK11ajqt30U+WdjHR
         7h24vDnXe4YW0N0rMsV3/8i3+1TOEF2sEgeS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794519993; x=1795124793;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jSdTtQAznWWniYEaUZU/adXWabbjDAj1ygm/wITppQw=;
        b=ft7hjYb4ETAlulAYJ77qFIE1milMtQ6FJ/tvm9x5CA4hPsCzs2TeZEZSO7NICjCOKo
         XF2l6ReuhMxt1QkTIMn4zNSGdZl2u2jWNYD8KXInCAuzlglSbgA0jatwOwP4R3eZ1Mxb
         uEUclxDuwt3Ag1xH6Db8SFQ0BL3v6S/6uiRDb8lvOZw1wsSeKtKdxgk1K1p51sUpzH6g
         d9xB1jQMh6m4R5GmomOdlNYRRyHnR8PP7j07SqWFVege1DIGNT3jygIzN9VV84EyCXR8
         NMb63yyzOHvL8dAQTKvFwofEc1b2B4ST3jrbHxnVBA3LozyP3Ju5Jh8xMi1L9Oh3Brc1
         6xRQ==
X-Forwarded-Encrypted: i=1; AL+hErGAan83OZg7jbO8Ir8N1DhIzDGFtaSv49etG7RBMc8l/bSYU0WchYn92pbfp0WHg0bd2lg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7YElhqWZ84x/cFO5Khc3gh9S+BUvDutIqcBI9CHJrTgOgtPRB
	xoY1GztCUMdVh8ZEtFhg+wuF717+cLMMczT8wL35gL+QUgCtE+kpNyQsDNBEVPLlR/41Apn2/fL
	/8Ezbb4I448v9dYAK5+S8bOV33mljE4SMmFBgusVBtdXzV5E85jt2r5Y0Cg==
X-Gm-Gg: AYBFou1QmsQofDT7bzoXx//Ozcuxxz9n6VAnzidR8Bis5/aDtqCYTpyMERfQ+RpDSgM
	pVd6F65Dj3zu4VxmMjXNyCoevpjKIhEszwe+LtLMGMYu/iSKWUfryzxZEjMohldZvgBUy2gEid0
	S8aC4UBpD817CaCrn5KortsvhIRefSfdCRhK3G3bJVaSgFPECLJ0/jThX/2TXmcHkyr4K2yGs9Y
	A6f133H42ySA5YbdEXif9jveNxYVgB80TyA9ZPpVZzqIREGQHeLV4QKnwTHOiBT0A4LK5BwfIwm
	m8p49ZzR/3CVZyQnD3EDp91QcGnLJRwcLwfaZdQNrnv43wW3veu9QKPKM2oQQjsadX2Lt2Bimtj
	6fY6lLMmU8utoKPw2jmgRjpEB4tXHMSrpK4JxRw==
X-Received: by 2002:a05:690e:4146:b0:67c:2421:f2b2 with SMTP id
 956f58d0204a3-67d8933e0c6mr464962d50.6.1794519992970; Thu, 12 Nov 2026
 13:46:32 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2309.git.1794500044740.gitgitgadget@gmail.com> <60c1d61e-777d-4c5a-b5a1-10c6530aa0d5@gmail.com>
In-Reply-To: <60c1d61e-777d-4c5a-b5a1-10c6530aa0d5@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 12 Nov 2026 22:46:21 +0100
X-Gm-Features: AclHuK9G2eEF1Rv6qtji4si2BHoP6iVE6QTsCpcpqnGLCoHTF8pfFAKP-btOEzw
Message-ID: <CAL71e4MP86eaiMrP_eignRSL_Zc58qX-hXAc=GD=w9st71DN4w@mail.gmail.com>
Subject: Re: [PATCH] commit: remove padding from struct commit
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 19:00, Derrick Stolee <stolee@gmail.com> wrote:
>
> >  struct commit {
> >       struct object object;
> > +     unsigned int index;
> >       timestamp_t date;
> >       struct commit_list *parents;
> >
> > @@ -35,7 +36,6 @@ struct commit {
> >        * or get_commit_tree_oid().
> >        */
> >       struct tree *maybe_tree;
> > -     unsigned int index;
> >  };
> This certainly looks like it should be obviously correct. I
> believe that the only order-critical part is the object
> struct needing to be first so we can "cast" a commit to an
> object.

Agreed, and it is an important invariant, since nothing enforces
it at compile time.  Out of curiosity I tried moving "object" to
the end of the struct: it builds without any warnings, and then
fails in a variety of ways at runtime:

  git cat-file -t HEAD     works (does not use struct commit)
  git log                  fatal: HEAD is unknown object
  git log HEAD~5           error: object ... is a (null), not a commit
  git commit               segfault

If we want the compiler to enforce it as well, something like

  (void)BUILD_ASSERT_OR_ZERO(offsetof(struct commit, object) == 0);

in init_commit_node() could work, and the same could be done for
trees, blobs and tags.

I added some more detailed followup in the parallel reply to Junio.

Thanks for the review!
Kristofer
