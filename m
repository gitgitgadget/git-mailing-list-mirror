Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795171850;
	b=anfD3o4erTwkQt0gAkCqaq0UTwJvC2JSYFntzpObQ6jKaJwiJi4c4yamSbtKaeLp2lha
	 CheYy2AWb0fCebEbQx84RdwgvpoKTe5gjP5Wl1ihVd2ZCA4WJD+U1tPpnhQwqsZ2h72I7
	 feR854rs+fMP2qTnPAbapnESIdZi9e0P8EmxEi2r+of0Y2941Rj4UI1o7/Rg4Hg/xfCEf
	 9cD8PiRFyLl0YHLB8d1H0Dz3wZJwrQ1K+X596DuL1S1TOZoujyDi+SwD2dLYeUgTeQbNw
	 cVMcEyYs/GLSrLALCVqhrQBYLtSkADz1Bg5SiFdrhzdcoxR0Eh88RBqCHYLKpEQCJCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Zq/S0698Xkba2lMVs+gXYgqGS/L8m9DAkCMrLikx+M0=;
	b=Nxn6/NWa05to+4tbU1tQQ+gJAVqK3RqcvDtjcfIBUBAq4TbBGYrQVRuS6b6torZInB71
	 hnvCF+ESn88sJ4kr1DaO42dRd7JEW39a1LC8NiSJJ8gU9U+iqYxi4Bu6ObPLV0ClkjTPq
	 kTXj2YfMGoDGeI+ft6OHPRq5yecK6/i+pTyrqVMUHB9nDx4kC69jmqxNtCSSZ8iQ/ciQh
	 dU8EkCehtKouqrGK1o/q42vvEw2fdAdo4UW5Zp5MHtN4wybIudMQyVChieOtV+h8ZYVz4
	 Ch2Vv/x84AM+vv15Ace4T0f2IX9cQE6cZ1e40wvAVIiXKLz2ro1NLzz8GnwUIRqvYIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wMnndG4w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387FD606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 10:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 387FD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wMnndG4w
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2e43ff4b4so1457908137.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 02:50:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795171849; cv=none;
        d=google.com; s=arc-20260327;
        b=k7BW+t2+InAeAKDDC4xClWdJuTzL0J7Bv3fP2RLUTFVQsrBXedmmvUwvvJh9A0I8gr
         OHZ9RVtfANDpgRu8J6r/Vz6okeiuioHEoc2HYZWtK0qIjAAYEufthPeqdZHzzr2bcj46
         s2IndpMFrXezQsSmcBUtIpSrMPnnicGFvBsNZe5Am6+TWA1KHWFsi6Xu9zoW3PRSAxto
         z/Z/x37pQMyyKi+33CAYyT57ZGN1yJ75tJHMSWEiraymgfseIe7amHKz3OCNSVvXFbaw
         h5quwNFHjJiBirRQW7GINGe6n7ZjNzg7YGFKAM3TYQ3mjn+fjTk523toWi6hX9hr2w1n
         QgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Zq/S0698Xkba2lMVs+gXYgqGS/L8m9DAkCMrLikx+M0=;
        fh=EuzTZeHClKMU1eF+pSgnKtda53qXUr4g9Wi36cauPto=;
        b=pux+EvbQZ96W8LCNDYVgPlTky1W8Z+EDzGCiB/Ke4crAVb6b7WblRjFNRyW2XynRzE
         rKcMvAC3VEes1QGZkkpJzkPLjD82wP2RS9+A1vMOiDeB2YXrwOgUw1NF1iioSvt1pTMe
         qTlRAHYTIfaitkagc0H/l0VSOBB2gfqCFtqeKrZYL7NGbCbRi2xZ6fe9mEE7rTZ5qBhF
         2rUj94YLanlJFm8kBLrD52DU+URpRcsoG36vwg70va2UNPHT4tyYZpoS8LBDZtxRsulB
         ys2HN2VVgZs9YnBqDJvKP6Hh3dqLq9YjLwqTrbxIwptDHmnThb/W7csOirVT0T9i6lyR
         A5VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795171849; x=1795776649; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zq/S0698Xkba2lMVs+gXYgqGS/L8m9DAkCMrLikx+M0=;
        b=wMnndG4w3rovw2mK5MvIInNONFc52MJfn6gnGhBenm6Z08bddLOtHr4yx+AN+C2/78
         y/dAd2NSFmzqOzjnQRr/GSNKC9Qusq1sSlTaDxhaWFRlVQVZB+zvAoB5R8qh6H8Rs5Xl
         s2vnDlV9tonSGj4QTWIFS11jwK5Gci8mhLNiphHyjaTQY/iSGTJGMtQRlf1BI+YBYatf
         2KXd/rMe3a/yQ95gOaHWXs3Nd5xP42CQXZqTj4T58c49A4kGGoJBUK/PzVhciAX7kaxk
         KowRR0/W31BEPr5z6MtqlM+n/qcmAz3Q/sZr2yKKSu1ezVsU1iZqA8M1gO8DZL5oMynf
         qXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795171849; x=1795776649;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zq/S0698Xkba2lMVs+gXYgqGS/L8m9DAkCMrLikx+M0=;
        b=vCYM9eGrYOg0T2gI5CF1WDFV06RUuRPuTzSFZKzU9shVtvzrBkVerWoOnZKExuVyOA
         E2CSZcqjGvrO3YWzUnY52XIjQc3i4m1L41STA42qofvQ075OTPuMoc9LNCnl5IMOJ2jV
         TSuFX9Ap4e5AJYNs6b1oTvZM9VrjcigFyWwSxi0q7pO470sknWcCxn0yA8z0rL+UJHXb
         v8Ac9p2qJHp+QPfk1ygU+EAZfCzLSkb+JTfzbf65yiROKIdo8E4ZBBtW4w4K90RUhHzY
         2HoGSaHZDx0Tl6AcTr9DY7eSIm6Tnd48ctFfEoQy/NHWExQXPvJbnNrlfYtgGoU3vIjN
         mshQ==
X-Gm-Message-State: APuU4Z9rFuo65QkMUbs8A6gmBJ7xIvsemZBuELRHc1tb8BE4fO9aTPGo
	8O4QdjNLQyZK6bae+CDLmOjush8awiEe5yYmmC/LprGOyOFiikz5gSoxPZzCIqqqwWK7oSffHxR
	/Zqja0t6tMpEvd5fUQayWXyVxyPVtrmE=
X-Gm-Gg: AZFdTZeKQ/SF4Fn/Fu9h33jMMscwtSpf5Ut0/SucB941mPHFXpqqAILzvbtZtIoEswv
	8LxAMhMqtM0smRKvvhir7aeScrJUhTFu8g7T/lHX3KAMdfw7J+h6bhZsjQGyLXekARyq0dQAv4a
	52PUum5+fUM2dIj6S+YJTc5RRi5AfogAPLW6ho1Zdn5TuLEvnJtHAaPfVa4dADGMOaFyKiuvixH
	QmhBMfUoY5GaEPeoMP7Wmu33gzCu0U/hxhDLu8VMRORKH21SBSIGcrfJdA3Tk5KIdQ4JJp/4OUh
	kU8h2upSWuI7Fb7oyP/Vb23f/AdCHh+YUw8UyomwoaGtSrNEIHgRiypC9IU43GX+gJnh2YWyqE9
	BysnNagniPq8y5RtkNyO9YSklnzELNfVusy07DlcP4Tes1Gf4xwpRUizRXM4WufBXJjamB6w0jD
	TzHfe9SZ2p9wvmMbllBDbfODU=
X-Received: by 2002:a05:6102:4488:b0:7d2:edb9:f213 with SMTP id
 ada2fe7eead31-7d6db9e5f15mr1456503137.24.1795171848996; Fri, 20 Nov 2026
 02:50:48 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119192247.2671852-1-dmnk@google.com>
In-Reply-To: <20261119192247.2671852-1-dmnk@google.com>
From: Caspar Duregger <caspar.duregger@gmail.com>
Date: Fri, 20 Nov 2026 11:50:21 +0100
X-Gm-Features: Aa3M54oNa6CdT40QdFpofPowrm9VRa21ICotUG2wRCxcTWE66o6XS526saS0uY0
Message-ID: <CAFzd1+7RNf96x4TS57W2yvupypLSSzf5_wF7pESge5er8LL9Sg@mail.gmail.com>
Subject: Re: [PATCH] graph: do not fuse merge parents into left columns
To: Dominik Maier <dmnk@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Pablo Sabater <pabloosabaterr@gmail.com>, dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"

Hi!

The fix (idx < 0) generally is correct, you undersell it in the
commit message, and also a reproduction with just 3 parents is
possible.

sh
test_expect_success 'log --graph with left-skewed merge into its left
neighbor' '
        git checkout --orphan 8_p &&
        test_commit 8_root &&
        git checkout -b 8_pA 8_p && test_commit 8_A &&
        git checkout -b 8_pB 8_p && test_commit 8_B &&
        git checkout -b 8_pC 8_p && test_commit 8_C &&
        TREE=$(git write-tree) &&
        test_tick &&
        M=$(git commit-tree $TREE -p 8_A -p 8_B -p 8_C -m 8_M) &&
        test_tick &&
        TOP=$(git commit-tree $TREE -p 8_A -p 8_B -p $M -m 8_TOP) &&

        lib_test_check_graph $TOP <<-\EOF
        *-.   8_TOP
        |\ \
        | | *   8_M
        | |/|\
        |/|/ /
        | | * 8_C
        | * | 8_B
        | |/
        * / 8_A
        |/
        * 8_root
        EOF
'

I'm not sure if usage of BUG is correct here, sure we can assert
but that leads to a crash and without it it would lead to just
a garbage drawing.  That is a matter of project policy so others
have to judge that.

Your commit message is very technical and I had to read the code
to get a grasp on it actually.


graph: do not fuse merge parents with the column to their left

When a merge is skewed to the left and its second parent is the
column right next to it, the edge to that parent is lost:

        | | * M                | | *   M
        | |/|\                 | |/|\
        |/| |         =>       |/|/ /
        | | * C                | | * C

With four or more parents it gets worse: drawing the dashes of the
octopus reads outside the columns array.

graph_insert_into_new_columns() has a shortcut that lets a column to
the right of a merge join the merge's last edge right away ("|\|").
It compares against the last edge added so far.  For a left-skewed
merge, the first parent does not add an edge, so when the second
parent comes up, that "last edge" is the column to the left of the
merge, and the shortcut wrongly swallows the parent's own edge.

Only take the shortcut for columns that are not parents of the
merge, which is the case it was written for.  Also BUG() in
graph_draw_octopus_merge() instead of indexing new_columns[-1] if the
mapping is ever incomplete.

Regards
Caspar Duregger

Am Do., 19. Nov. 2026 um 20:22 Uhr schrieb Dominik Maier <dmnk@google.com>:
>
> In graph_insert_into_new_columns(), the branch that coalesces a column
> into graph->mapping[graph->width - 2] and resets graph->edges_added = -1
> is intended for existing columns to the right of a merge commit
> (idx < 0) so that two adjacent edges can join immediately as "|\|".
>
> When a merge commit itself is skewed left (merge_layout == 0), its first
> parent does not advance graph->width, leaving graph->width - 2 pointing
> at the column immediately to the left of the merge commit. If the second
> parent of a 4+-parent octopus merge matches that column while idx >= 0,
> it overwrites graph->mapping[graph->width - 2] without advancing
> graph->width and resets graph->edges_added = -1. Subsequent parents are
> placed one slot too far left, leaving the last dashed-parent slot in
> graph->mapping[] at -1 and indexing graph->new_columns[-1] in
> graph_draw_octopus_merge().
>
> Restrict the right-neighbor edge fusion to existing non-merge columns
> (idx < 0) and guard against negative mapping indices in
> graph_draw_octopus_merge().
>
> Signed-off-by: Dominik Maier <dmnk@google.com>
> ---
>  graph.c                      |  5 ++++-
>  t/t4215-log-skewed-merges.sh | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/graph.c b/graph.c
> index 95eef3a95e..a40834a639 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -685,7 +685,8 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
>                 mapping_idx = graph->width + (graph->merge_layout - 1) * shift;
>                 graph->width += 2 * graph->merge_layout;
>
> -       } else if (graph->edges_added > 0 && i == graph->mapping[graph->width - 2]) {
> +       } else if (idx < 0 && graph->edges_added > 0 &&
> +                  i == graph->mapping[graph->width - 2]) {
>                 /*
>                  * If some columns have been added by a merge, but this commit
>                  * was found in the last existing column, then adjust the
> @@ -1317,6 +1318,8 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
>
>         for (i = 0; i < dashed_parents; i++) {
>                 j = graph->mapping[(graph->commit_index + i + 2) * 2];
> +               if (j < 0)
> +                       BUG("octopus merge mapping uninitialized");
>                 col = &graph->new_columns[j];
>
>                 graph_line_write_column(line, col, '-');
> diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> index eebab71039..632c7d2c97 100755
> --- a/t/t4215-log-skewed-merges.sh
> +++ b/t/t4215-log-skewed-merges.sh
> @@ -509,4 +509,35 @@ test_expect_success 'log --graph --graph-lane-limit=7 check if it shows all 3 pa
>         EOF
>  '
>
> +test_expect_success 'log --graph left-skewed 4-parent octopus merge joining adjacent left column' '
> +       git checkout --orphan 8_p &&
> +       test_commit 8_root &&
> +       git checkout -b 8_pA 8_p && test_commit 8_A &&
> +       git checkout -b 8_pB 8_p && test_commit 8_B &&
> +       git checkout -b 8_pC 8_p && test_commit 8_C &&
> +       git checkout -b 8_pD 8_p && test_commit 8_D &&
> +       git checkout -b 8_M 8_pA &&
> +       git merge --no-ff 8_pB 8_pC 8_pD -m 8_M &&
> +       git checkout 8_pB && test_commit 8_B2 &&
> +       git checkout -b 8_TOP 8_pA &&
> +       git merge --no-ff 8_pB 8_M -m 8_TOP &&
> +
> +       lib_test_check_graph --date-order 8_TOP <<-\EOF
> +       *-.   8_TOP
> +       |\ \
> +       | * | 8_B2
> +       | | *-.   8_M
> +       | |/|\ \
> +       |/|/ / /
> +       | | | * 8_D
> +       | | * | 8_C
> +       | | |/
> +       | * / 8_B
> +       | |/
> +       * / 8_A
> +       |/
> +       * 8_root
> +       EOF
> +'
> +
>  test_done
> --
> 2.56.1.750.gf70dc682cf-goog
>
