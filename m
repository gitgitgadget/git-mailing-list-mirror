Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793893368;
	b=2kVCmKfUKND5aN12uRzU4avT6XC+xQV6bUd6x7UkMzGkANwwJYXF9v4/lOItKvwMT+wy
	 PIMGFwgcJkY+ybhIdGv6s+iw8jf0qLRRc7UXkOak/xF/5aVvkRQ1ejkvF1cW/1axO6gsf
	 oJ4Z491YNk0fNbqF+zMgX/UwlF057NuUe2EmlOAv8JN1aoKur0OKmDXXsYViV258LBxyB
	 I1okguWX24a0sHHSZNgFEGiKmOs8qGC+vUzAf5QVsU2XuUvJOz1b0qnfRnlkXeeyZl3Wo
	 83gAyPyX7y5Si8HFGyXRDRPbEpZO5RczG/dtyyN7lM5RDCt1iQZfleRDkoWBiO7UvQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jtwHfS40UzqtEB56fCpPe3+g39R99MFCSDr4AFdZMzc=;
	b=44emgmH+0b5K4uj+jlLXlWCCAzOl9KHlfGXg8Mdd91bfowtuFjNfu/IxyEpT4RZ5Yj12
	 k3uGmnl1P5gKRNOqhfEm1wMY9nY/+nCLT9vL+EWwgvLsfjyA7XeY4KaON8OOG72Bxm1qg
	 c8JJSv1+fKT9AQtOMKgW7yFPT4qdHiUL92wKCIKw4bD9MK7Pv5/aYr1gKbYwFn1eA8Api
	 UzoaaxhM2XIEACtcxbkq6rwMEw6kax49TL6l9256sT39LonGdZgwoQYQ8KRwWh0NRgx9+
	 O7/8VyfcIBTc0Qo68LUrVRo7SHXp2ryQh+uf4iVx4fvcWGMTSfZdP9GIxndCKbZS5YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=aESVfSkG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ABD606A332
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89ABD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=aESVfSkG
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4cdc606b47so303937366b.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 07:42:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793893366; cv=none;
        d=google.com; s=arc-20260327;
        b=W2jbX+QTUfjHxPDOjTysoHXbSqYwXnrljg/RB3G2mOJbugM28HK3cdd/RlqXtQ/sPv
         HouwtOHjgAfP+9peN5Kf+7LS4N8WqVBpqUVvAT5V+Y+HyxEgNYaazdV6CObcz6zo/1Go
         MLe312kWnuYexqY7qtnWbKxwmrvCgHCHXxbxICyhE6+qwR3Y4jVWYVocF6Q14AglDYM5
         hfNIbscZufyvpLRjFhrwOsbx+krnfKe0f2fOZwnlc/UuKNXu468H3VAbHXFLeZhuYthC
         Z2nxIYRSBDaLId1zIaNt3/AWZLAEsH/FUuhvaPhk2lEJz0yf8ttBPpr6ZueoB929d1bT
         oWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jtwHfS40UzqtEB56fCpPe3+g39R99MFCSDr4AFdZMzc=;
        fh=nPeRBxDrSl3jq/okiojJUuAfCNNjRetvBYnqM6a3anE=;
        b=Lg/KX9hdqje6JrosTWQd3gz8To8PIm50XC3fC/h0nezXUFKWavS9iieGVenOw2h++x
         pibdAqXMwGgLh1ITXpYaZvljsxg8iNSvLFjiL9CvBAJyviWjaqBwdrpx0bI4R/m5ITLa
         FM5RtLecKkm2uyComYaGoVMTwtrXdNr/lCeZJJOmomHh2AxXkOxfdY7y+z2sA7l07m35
         3k1oRYVoNAvYzqWH84RU5lY3SwvH/Gc+Xgjn0CaiWlVmpWdD0j5/P8D/lWjnEMi7AkSW
         b55TdurRnZT78VBVPZIGUaqdhC+gkgAcMdE+i7/klVxI89O5nPEqtX54JKZTHU1NaYMu
         q+bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793893366; x=1794498166; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jtwHfS40UzqtEB56fCpPe3+g39R99MFCSDr4AFdZMzc=;
        b=aESVfSkGqq0M46HnuGJlULw4o2tw0tqmTULXdEBvxbA0wqOUc3C5eNT81HcKb0+kxK
         q5KDXLpmPUjf9TGq3gciUl12EH+NHJSIsiK/iFOwQDZvF0xq1RiBobZdtOJ9T2b7MX+y
         U30eGrZot7x3phrtF8mAM/ee0+dAR9INYEAP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893366; x=1794498166;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jtwHfS40UzqtEB56fCpPe3+g39R99MFCSDr4AFdZMzc=;
        b=lkCA9GhgvaNUIjcqsfZibtVUeU2ruBx9qRNN8gOFUHoWwI4HmLSx2+YkPgIT512cpt
         MMALZImv7mbMmlelVjjLj9lPo94GFQDavL6FnlJHWqLrdrJtTr1Fxs+sPjFTeHMEZDpM
         pHHz6t4rP6umDEpqKiRfnuOUxQJEcNWqd0n1NOt1QWxVsSsgJSYSzgwtqGfk25szYbIM
         5+vnP8DXtcDkx+J0cb+5fcwK84Z1ZWeWfybI64chcgSkrt+ERKeQflpWSNfl0qDmZ/1e
         9MWi5R/qwsPs85eZWwCHRjhLfMEUkvRaTBv5FPYRWDToAFtDTPlqRCuXgTpy1LXceVFg
         075g==
X-Forwarded-Encrypted: i=1; AKwUvBxv9CUXuPPdtJHBjymv8fYMxpgvm5Ub7NLqEs5qo5g/3fIeLakiLnkXy6bh/nWHZnZJitw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IUcFLD8kYOf+0EBrUhL4RwmKCosVXjXbaEaQHd48gxwWZhbCo
	dRFzIb9QKB5NMwuqlJLyMGhu87TXL7LAszSyEZWl9Iti6wSIS1M4lI2yJffoPk7x+RV7y2zdYCB
	iiSwHvydj7C9x/PvM6kJ6DM2bIOIizOHHAmxrX60dpA==
X-Gm-Gg: AYBFou3sLld4jQ/TONwdObQE63P9xXzjIztX7dOkO7j+zbUPJqQuOvyBt3fpJqG3kgT
	jglT4dY7eC2Msn4eWAGbf9CNv6eOE6m3YCuPdj/Xsfrvj0/cqwxAVEclDZxn8ABzohZ7mMHzg4R
	1K4b1MvdhLiJmEvAjISqLuvGvpwBT3FrVzW3JvpvJaMuEu6BrNRLTcsDIM0Z4jLqxwzAbcA+KTQ
	J6uwMCJ/vP1R4hjUzP6PYwHxpmJQSa12U9FGazDpcyHAR51o4bof2bXHvOtoJEwXfKo1u15ylFN
	RN2DrgEEQMRLeUatmLPC45OYF6eBR4kcR5sU6Q0aFOAsMFs4ezFsG7jVzWJ/gpf7L/KK8tGZnJE
	SDzpFLFgveRVxC91NGcqBu2XHcHtp8THJV2j6vA==
X-Received: by 2002:a17:907:1688:b0:c42:a326:78a9 with SMTP id
 a640c23a62f3a-c4ca7ad1e30mr1726852366b.42.1793893362784; Thu, 05 Nov 2026
 07:42:42 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031065525.19883-2-torvalds@kernel.org> <auiGP4XhObUzC9vD@pks.im>
 <CAHk-=wijLfduoJyOM+AW6FS6c02cuEFRAuQWLE+uf7SGhj8jXA@mail.gmail.com>
 <aumKXUS7_x0i7ZU1@pks.im> <xmqq5wyd4epv.fsf@gitster.g> <CAL71e4PqEQkGoont3tL5wJWd1_itsaaxfX+DOkLj64x-S7xR1A@mail.gmail.com>
 <xmqqv76c1mwb.fsf@gitster.g>
In-Reply-To: <xmqqv76c1mwb.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 5 Nov 2026 16:42:29 +0100
X-Gm-Features: AclHuK-63UEpqqj-7vf8Yb9EzFa73dKcEzcqHxga0BO3H81MCVBOQS1hdcdBzvg
Message-ID: <CAL71e4Pp=rZSKd+vC9anjEVHS=a6DOoK-HC_Z+3vDaqjo0+6+Q@mail.gmail.com>
Subject: Re: [PATCH] describe: count the distance correctly when commit dates
 are skewed
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 19:17, Junio C Hamano <gitster@pobox.com> wrote:
>
> Kristofer Karlsson <krka@spotify.com> writes:
>
> > Would this be worth pursuing, either instead of or on top of
> > Linus's patch?  If so, I would be happy to clean it up and send it.
>
> Sounds interesting to me.
>
> Thanks.

I have a series locally that builds on top of this topic
(lt/describe-commit-date-skew), and while working on it I
noticed that the topic makes an expected failure pass in the
commit-graph test mode, which fails the test script:

  $ cd t && GIT_TEST_COMMIT_GRAPH=1 ./t6120-describe.sh
  [...]
  ok 102 - describe --candidates=2 HEAD # TODO known breakage vanished
  [...]
  # 1 known breakage(s) vanished; please update test(s)

That test now passes when a commit-graph has been written for
it, which GIT_TEST_COMMIT_GRAPH does, but still fails without
one, so it cannot just be flipped.  I think Linus's patch is
good, but it needs something like this squashed in.  My series
would remove the unset again once the test passes in both
modes.

-- >8 --
Subject: t6120: keep disjoint history out of the commit-graph

With commits walked in generation number order, the
"--candidates=2" test for disjoint histories passes when a
commit-graph exists, which GIT_TEST_COMMIT_GRAPH=1 writes, but
still fails without one.  Keep that history out of the
commit-graph so the expected failure holds in both cases.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/t6120-describe.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index a75f9227d9..969f878946 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -704,6 +704,10 @@ test_expect_success 'setup: describe commits with
disjoint bases' '
  git init disjoint1 &&
  (
  cd disjoint1 &&
+ # describe walks this history differently with a
+ # commit-graph, so always test it without one,
+ # whatever GIT_TEST_COMMIT_GRAPH says
+ sane_unset GIT_TEST_COMMIT_GRAPH &&

  echo o >> file && git add file && git commit -m o &&
  git tag H -a -m H &&
