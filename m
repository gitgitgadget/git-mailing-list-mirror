Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961F1862
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071790; cv=pass; b=GmajSGBYxJne3RaUJ0fzHEexRdb2bTNd3CytBFj9GiYvaaYgYErKbV2VdWA0hNCnJldFABzEssae2YHeGhdrNRfOVROCCJTpmZyR89/MrgSVTiLKrkKVi2p/7mrLUimoTuQcYjVKbwqypAuccrfpUMYJJ2IPlKSvgkMIJnkbJc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071790; c=relaxed/simple;
	bh=BaBiOL7ngXgQAB9yQZvArGLrOMbB0tVd8593RPQSSuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTML/0hmX+CWNLEcW4jAns1ts37b+O+AbIKavtyNL2FsMA3miL66r6fkEtll7oZMSdeuy7+GZUEkkQ1I4rVxHynCXIseGflnC14Vlcpk2DScivJCr6GRCGznEkkWFZoI8CBabFTR1ZRz9PHKbZhUaOPCB66aCxkosOE7RiBi4t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iq2OPxVG; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq2OPxVG"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a168dc590cso1858786eaf.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 20:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786071788; cv=none;
        d=google.com; s=arc-20260327;
        b=DKROqdjxQJqBkr9k7iebn82IITYHWdYiUj5982jUvnGQH4t75HJzY2QeVMM5c2ZTr0
         PCaDKC6hcG4C3tGHEwo4t6h1MCvNHsUaNjz3zNR+OCm+Km92VlS1phfw10ZW8apOKxhr
         YvINhOgZeI3Lh36CzfXAD44JnaGSO1jQCAcDuA/9RHQzhmfVsXYITa2RieSpweW7dUR1
         fKuxPZNR5N9vlfE+4extbG6Wjx22LkpM272KAprYdFY5NVmBwJKPVBcghyOxO9DhQrKE
         uM0ara7s2fLQJVwLHsy2iq+WE4hQo5FlfprQppD0PzXSJfiwk4NlJ9TXcJ5mU0BQvPD8
         oTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tfcjjO7iLurQLVyV2hh2sTKXIe8NFhY+hulZhRIlePI=;
        fh=PdGuLsJN9JVZy5BHY9bPXqzeWCeYFKwbJ2iGslXTO1Q=;
        b=TVsCeCd0f46TpJO6QY9nfp0CcKRj24AcsGcFxhqG7hypJ1GqDRWRMHF3P8j1BPTHcc
         /CQHBl5x4dssSyMrh+YP4xccgCQVEYPJnMeigH0zk8VoCvjkPfaLYXZ7RcWOrKyTde1L
         c2aGNZzvaX3+lLEvb6EkjHfe+GUy226WSL1zsCP3Ok1DK11EzQzHHNDxo4Unxxxl3Tm0
         hj0l6TxVXCu4OfBS/WrucnpsnhqawAR4UgfxKN3Lw+/JVebPGom4lwKtkkjEp3jqngvU
         gY3tYjhm3myy5ireLQZcNGUINimiNV8ORM0b71NZkba7Ujl8FpszdxoHswqdYADjqRv5
         xoCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786071788; x=1786676588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tfcjjO7iLurQLVyV2hh2sTKXIe8NFhY+hulZhRIlePI=;
        b=Iq2OPxVGkLtILqhABMmalA27p0EmysjiLxEpXg3MQYlJTenwz4TrWOA528h+hb83er
         1Xst0eBohL7VTfckh0w6hMYg9j3p7sVrOm9VjVV32KsxcWhxhpXaXxRgzSf0UAAlUYlE
         HL3Ev130s8YiYGYqksBGBWya0usVvN4o6tLOhQy0bnYSAg0mfSilMBbl4yKq5BAY/phi
         APElvQXrK+64BxuCVj30hs7NDY+TxUB2Su2cRF3RTun7oiylFc8U6RqthXe4jrcUF0tJ
         5PQ6Flw7OzI0X/WCbwQ9ppIHeNZvTiBbVMOuZuqro2teZR+cKxrllmrYaBCVdkUUwNIn
         /ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786071788; x=1786676588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tfcjjO7iLurQLVyV2hh2sTKXIe8NFhY+hulZhRIlePI=;
        b=HERUsesV9aWfZ4gNsMlNdGn2pOVLCl79+c16mcvFL++5oN1eHaG1mZEtSzHTFCHQmD
         2vxVg09WrxIz3f0/gIxqgN7j5L5oMcly01kdTEYzMzGu4rpasK5bjIyN4vPUDeLUugRe
         3lBnBwUE00tFu4B6nTMCO+Ylxuv9a7FB69JXn8zJi0i552dZY5vIqEwRDQsugjVtbwoy
         0sBqtIvnt5sZCZgXjuEte/Tds7AyQi6y5h0WGbaq7nrp6ZlAVXUgXoCk29Q4bWlLQRMu
         4+9sLt1sMQsnYn5SGLjNc5sJuITvZLnQAh0INP6cMKG2NzF/EZOxjoOS0kLGNcbHi1Mq
         vFGQ==
X-Gm-Message-State: AOJu0YzlnVElt9FLNgqPtnMr1Wz//4U5HHEx+OyTWy339DvYKw4cnsVW
	zSe0lT50hi/AjqPCBfnJRE8b8HdLI3MvFX8SjgSx8yT+1y6cT6qGxbCskE9H2WxH16TtJewcvwn
	C6eY4g2IDDSsk2mE5RoWmuuI0Nll4foVRHA==
X-Gm-Gg: AR+sD11OCFTb0Wtx4KuXvR+ZbzgBy08GomVkn58jx1xncxbV/7KOzj1Msfpr7q8aVe4
	Yro0pH5Fm/F8u5uYm39rUUwA4/V0e5cyGpZ3lZWJ5kwm1FezPoGOsl7tt8pueSotxMYLgJeSlAd
	n0OlbGEj1JHXxcqwCHyhBlv7qArQpb2ooY8XDGUWQaDlUU7PLNbF49f2W5hgU8R/ZsJJm33UyBe
	Imxrsi3tTttzY5nEux9JePnbHrMD8cQRISMXgpTctIT9CBGUYvEiOxfBN5p4x2vsK0t3zNr0Ade
	W+VCZQ133GNF4rRpXjJto8PqgnSZADf58aWmbyoXhFG5dNZP6XLZbzt+ofbkbDbTmZrhKVNhn1i
	aFyMibLeO6NOHwhOeCnn2rNqpnlBG/OY/3h9xH2VTxPQDT1qA52iSegmCTbwERA==
X-Received: by 2002:a05:6820:199a:b0:6aa:f172:3094 with SMTP id
 006d021491bc7-6ae96cb428bmr10287953eaf.10.1786071787912; Thu, 06 Aug 2026
 20:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <490be76befc4689d463d472829c0271351b69a43.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <490be76befc4689d463d472829c0271351b69a43.1786013982.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 20:02:56 -0700
X-Gm-Features: AUfX_mxXmcSlfOiiOm4a3gZa3naZ4rm4O09wUlB22wOEJj7OHikZggfGdSXqNQs
Message-ID: <CABPp-BHLHGQxuG3gO+nCa-FPFyOFEU2rk_oxLtFjekLqENvQUw@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] commit-reach: add trace2 instrumentation to paint_down_to_common()
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:05=E2=80=AFAM Kristofer Karlsson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kristofer Karlsson <krka@spotify.com>
>
> Add a step counter and trace2_data_intmax() call so that the number
> of commits visited during the paint walk is observable via
> GIT_TRACE2_EVENT. This provides a way to measure the impact of
> future optimizations without relying on wall-clock benchmarks alone.

Ooh, I like it.

> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  commit-reach.c        |  5 +++++
>  t/t6600-test-reach.sh | 44 ++++++++++++++++++++++++++++++-------------
>  2 files changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 8541264136..d59e76a2e2 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -11,6 +11,7 @@
>  #include "tag.h"
>  #include "commit-reach.h"
>  #include "ewah/ewok.h"
> +#include "trace2.h"
>
>  /* Remember to update object flag allocation in object.h */
>  #define PARENT1                (1u<<16)
> @@ -113,6 +114,7 @@ static int paint_down_to_common(struct repository *r,
>         };
>         int i;
>         int gen_ordered =3D 1;
> +       int steps =3D 0;
>         timestamp_t last_gen =3D GENERATION_NUMBER_INFINITY;
>         struct commit_list **tail =3D result;
>
> @@ -138,6 +140,7 @@ static int paint_down_to_common(struct repository *r,
>                 struct commit_list *parents;
>                 int flags;
>                 timestamp_t generation =3D commit_graph_generation(commit=
);
> +               steps++;
>
>                 if (min_generation && generation > last_gen)
>                         BUG("bad generation skip %"PRItime" > %"PRItime" =
at %s",
> @@ -194,6 +197,8 @@ static int paint_down_to_common(struct repository *r,
>         }
>
>         clear_nonstale_queue(&queue);
> +       trace2_data_intmax("paint_down_to_common", r,
> +                          "steps", steps);
>         commit_list_sort_by_date(result);
>         return 0;
>  }
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index 698b831a6e..45aa26cd44 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -153,24 +153,34 @@ test_expect_success 'setup' '
>  '
>
>  run_all_modes () {
> -       test_when_finished rm -rf .git/objects/info/commit-graph &&
> -       "$@" <input >actual &&
> -       test_cmp expect actual &&
> -       cp commit-graph-full .git/objects/info/commit-graph &&
> -       "$@" <input >actual &&
> -       test_cmp expect actual &&
> -       cp commit-graph-half .git/objects/info/commit-graph &&
> -       "$@" <input >actual &&
> -       test_cmp expect actual &&
> -       cp commit-graph-no-gdat .git/objects/info/commit-graph &&
> -       "$@" <input >actual &&
> -       test_cmp expect actual
> +       graph=3D.git/objects/info/commit-graph &&
> +       test_when_finished rm -rf "$graph" "${graph}s" &&
> +       rm -f trace-mode-*.txt &&
> +
> +       for mode in none full half no-gdat
> +       do
> +               rm -rf "$graph" "${graph}s" &&
> +               cp "commit-graph-${mode}" "$graph" 2>/dev/null ||
> +               true &&
> +               GIT_TRACE2_EVENT=3D"$(pwd)/trace-mode-${mode}.txt" \
> +                       "$@" <input >actual &&
> +               test_cmp expect actual || return 1
> +       done
>  }
>
>  test_all_modes () {
>         run_all_modes test-tool reach "$@"
>  }
>
> +test_paint_down_steps () {
> +       for mode in none full half no-gdat
> +       do
> +               test_trace2_data_singular paint_down_to_common steps "$1"=
 \
> +                       "mode=3D$mode" <"trace-mode-${mode}.txt" || retur=
n 1
> +               shift
> +       done
> +}
> +
>  test_expect_success 'ref_newer:miss' '
>         cat >input <<-\EOF &&
>         A:commit-5-7
> @@ -244,7 +254,8 @@ test_expect_success 'in_merge_bases_many:self' '
>         X:commit-6-8
>         EOF
>         echo "in_merge_bases_many(A,X):1" >expect &&
> -       test_all_modes in_merge_bases_many
> +       test_all_modes in_merge_bases_many &&
> +       test_paint_down_steps 45 2 25 3
>  '

Whoa, what?  <Digs around for a while.>  So, this is really confusing
at first to a reviewer; it makes me think you are testing that you've
already written the optimization and that some forms of commit-graphs
provide a speedup from your work that doesn't land until later in the
series.  It might help if you point out either in the commit message
or a comment here that this code is just relying on pre-existing
optimization where a min_generation is passed and --all is not passed.
(In contrast to below where --all is passed, so it has to dig deeper
with or without the commit graph).

>
>  test_expect_success 'is_descendant_of:hit' '
> @@ -329,6 +340,13 @@ test_expect_success 'get_merge_bases_many:infinity-b=
oth-sides' '
>         test_all_modes get_merge_bases_many
>  '
>
> +test_expect_success 'merge-base --all commit-walk steps' '
> +       >input &&
> +       git rev-parse commit-9-1 >expect &&
> +       run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
> +       test_paint_down_steps 81 80 81 81
> +'
> +
>  test_expect_success 'reduce_heads' '
>         cat >input <<-\EOF &&
>         X:commit-1-10
> --
> gitgitgadget

Other than the double take above, looks good.
