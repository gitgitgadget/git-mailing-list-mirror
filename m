Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470910F1
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776558370; cv=pass; b=Mu0dpJeWbx0FQKax2GHn5KGzW1uB9IQ63xYuQO4znYArz7dUPIkt88yHuzFynf6Ne0HSHYY8ZDZpnRdGb1rYqY6zOoaS26giF6kKIygaUtm9v41MVU31r9JD+9s4XD12f9h4XmZKxDQQEWyojUBVBIr0r+XGVBTcAuLmL45akHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776558370; c=relaxed/simple;
	bh=3frXRPhQ1ajXt5pDJgCNGxt3JgyfRtPb1YegtIBrrcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iD1rE2nQMUFNUDUwRHGKWGvEhMZuXsc5GzC/mXhNO3r9A6R6LqK0PoIiEjk8uNVM5pz+HNw+LhXSJb1rKtfu1Npe0S6NZ+Cw1gG046PqSS6TBQjqpk56Tun/OvX76jled9T9jOJYaQap1eyf857u45wnDUQ6EDdlCNzM3PS4xOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j31PJ7IA; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j31PJ7IA"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b458ca2296so13321015ad.0
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 17:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776558369; cv=none;
        d=google.com; s=arc-20240605;
        b=YPoVpviJmKpl3tn9KfyFP2J6ls1G9orgYG8b2DHRo6ogEd79jFnF/5qk7RsowmUZ4u
         EbuP8xWXQK9vgzgq/21Y9P0pXZKyBggEcrIM1Du/5F8Rkdteg3jmoaKB5n6sLFxhkL6l
         EdjjoWdhCKT9ab4uEU1Kv+yv7MsC605AbTgWiMmv/nfM64rFlL2tKXnZ0Aaw4nwEtzjt
         U5JGxBoqpAfhDl0NsMhUFCu2OwmpVgysyDWRa3PCrrTgSQAdq29s1/e1dqEcM5VlsiWd
         KZi408P1p1BUJrmKL9Us9apH9f76dPufdApgI7qCdX3M4viekvRSLjhNg+yKgqVhQMes
         pZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uh/648BuUna+N52tp8Vwa08Esg4sxKZLd+1Y+mVyIPM=;
        fh=SlejNgZhDGxYE3RoeDx16OjaGxHLTwSxXQ+/jdvn8IE=;
        b=iTQwuDGHR7r17rcnMxvz5PrbsB9LQKveyQ/T71r91qdMcczidjdoB+9kg7PvAAA8Rc
         IE0OWLK1C4IFmB/I+/1RFCGUlI8I3ktoEniJ9HKBYttPD406wxdQ/ygspjmlAKzdgptX
         qMrriPYOxqiwOA0Mg0Scq+f+dITAd7tAkIjjtfshnjh+C7zNs8CzoyeQchRGwy85VDsh
         +uZRdvfdLeu5fdGOR4i5/LkS1O6XFIu7OS1D/47jePPFHMOxSfJTulIqB4jzXWojaktK
         llIW5RKEx/VtHYG+CqSbt2jKzdKH9EbkiR/j9pfI6543UvwO8sJVxAnYqExmJWFSC96d
         l6pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776558369; x=1777163169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh/648BuUna+N52tp8Vwa08Esg4sxKZLd+1Y+mVyIPM=;
        b=j31PJ7IAefg9Jy6EJLLV8AjHl0XA0Um3Rw7xVQMnXW9JLZordsFmXZYWoekHfz4H2Q
         ClQ/biWIexzeDPg9wyQ1Ejj288WTslyP5sSDta9SW5WkWZtAFYuvWlYzC+ZtVduh8Zpc
         uOS2S6v8gr0/kvsnDjvs6v3c8r4/jyrbOqR8UzotBH1ut4HafQmsF8nemDEHfhEUiSFr
         qJce0THU/UMnyWm2zv/rG5AUHD3jiq3M6FATsk4ZNtMM5tLGMUcM/AFoplGk1ZvbaOVU
         DBkU3p+SqS5vUJjRN7dFM/VABqeIcnCMw42p/V806bCDQ/PL+PoESEwlcoFKX05naatf
         x53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776558369; x=1777163169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uh/648BuUna+N52tp8Vwa08Esg4sxKZLd+1Y+mVyIPM=;
        b=NPsfyDMwCue5K4msit+k9HxP1v3/+rFta82X5+RfK5w///oqh5g4PZehuyND5ruXm7
         igNYGzud7CFibnLo/psb8xod92s8BS6okoGzg/A4i6u20jYl+aFJ+frv6/T8MivlAqTC
         R+QkrEg/CLo2etDY9VNkqqsBSrlCcVquBExQ0aYpzsr/AtS5Qt/D+pEQHHoZNtnJmuVc
         AbnpyMKraXgPuPYp5W+UdgO8XahgeyqQn0xHjIfVBolCDl6fv5kh3KeCXTXSlcG2Lo07
         XX4PYoLOgvTYQqjwYGyu6v85CHxJseGByEiOoZMt9OYpzZrS6gBeZOYhKPnB2DMkZIAW
         86eA==
X-Gm-Message-State: AOJu0YzPwuw0ukM9g6mIP+IyVU4ZIiUi1hem4FC3fx+KG3uTkHNoeeaz
	iKftfRKE0PGYY9+4eGZ/dlYJuU+WVPXHz+qd/Ul8nBA3MaqMY/n7GhO+ZxKtrOvIhMPhKqG7MUj
	t4URQzMOoLCMGuXwECHHcA8ye/+POrQ0=
X-Gm-Gg: AeBDieuHVNgJ5K9onvZvchu0aCOJbfNj6o+i2qKWiBGO6Ae4Kn07YixhtbT1SMWUPwA
	pe81QcRVTU7K7xtWJJpUlzzB2pkYa2utTSB02PnclfU5R3DuPvfggwMaTfEoniO421kA5yUILQX
	nIQFv8VA658ZqJYIcsjcUfq3x2vN3tdsDOyzGbjNjKlOuKE1itd66O4KWs7Zk/vkGWtPPX7RQrT
	cEIzDThqMcfBnjZwjEG+KQ5DYMucOAWatKXKx61DLQYDZ8rzjgQeD4r6kEp3k8HX59dQSG75Ezd
	MbphnxUMwW1VpNngR3Aq4Jduhb1cHJPN5hjoiILEnz6jC7tw2tZPV6SxP4pvBYBJJzjaN/bSEg1
	oF+8adtk4Nk3kj5C7meKfpIUwQriJea8iSJz8
X-Received: by 2002:a17:902:ea12:b0:2b0:6e4a:32d0 with SMTP id
 d9443c01a7336-2b5f9fbbdacmr85307165ad.35.1776558368734; Sat, 18 Apr 2026
 17:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776124588.git.me@ttaylorr.com> <f4899b668e229069a10d7fc627835dbdc12d7b39.1776124588.git.me@ttaylorr.com>
In-Reply-To: <f4899b668e229069a10d7fc627835dbdc12d7b39.1776124588.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 18 Apr 2026 17:25:55 -0700
X-Gm-Features: AQROBzC2qL5QGnSKmHVC-ZmOt1eFxztlItC32Mh-i1DChPu_ZVL3K0OqLcfSfxY
Message-ID: <CABPp-BFFWpeHUemuDiJjXEhqyJ=amSOsEdrLFtYBrMWg3LpAmg@mail.gmail.com>
Subject: Re: [PATCH 2/8] t5333: demonstrate various pseudo-merge bugs
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 4:56=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Using the test helper introduced via the previous commit, add various
> failing tests demonstrating bugs in the pseudo-merge implementation.
>
> These are all marked as failing with one exception. The "sampleRate=3D0"
> test describes a latent bug, which is only reachable through a code path
> that is itself masked by a separate bug. A future commit will fix that
> bug, and, in turn, cause the aforementioned test to fail. Accordingly,
> that commit will mark the test as failing, and it will be re-marked as
> passing in a separate commit which fixes the once-latent bug.
>
> For the rest: the following commits will explain and fix the underlying
> bugs in detail.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/t5333-pseudo-merge-bitmaps.sh | 198 ++++++++++++++++++++++++++++++++
>  1 file changed, 198 insertions(+)
>
> diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitma=
ps.sh
> index 1f7a5d82ee4..20e77ab4390 100755
> --- a/t/t5333-pseudo-merge-bitmaps.sh
> +++ b/t/t5333-pseudo-merge-bitmaps.sh
> @@ -462,4 +462,202 @@ test_expect_success 'use pseudo-merge in boundary t=
raversal' '
>         )
>  '
>
> +test_expect_failure 'apply pseudo-merges during fill-in traversal' '
> +       git init pseudo-merge-fill-in-traversal &&
> +       test_when_finished "rm -fr pseudo-merge-fill-in-traversal" &&

As suggested in the first patch, test_when_finished before the git
init.  (Same issue occurs later in this file as well.)

[...]
> +               : >trace2.txt &&

The `: >trace2.txt` struck me as odd, since this file doesn't even
exist yet in this test...but thinking more, is this just defensive in
case someone adds inserts or modifies a previous test which writes to
trace2.txt?  I like that idea; somehow hadn't seen it before.

> +               GIT_TRACE2_EVENT=3D$PWD/trace2.txt \
> +                       git rev-list --count --objects --use-bitmap-index=
 HEAD >actual &&

I thought this was broken without quoting $PWD, but looks like I
forgot shell quoting rules again.  Assignments don't undergo word
splitting, globbing, or brace expansion.  So, nothing to see here
either.

> +               test_pseudo_merges_satisfied 1 <trace2.txt &&
> +
> +               test_cmp expect actual
> +       )
> +'

Didn't spot anything different to comment on for the rest of the
patch, so the only substantive comment I had was on the
test_when_finished and init ordering.
