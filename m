Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE171DE8BF
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838321; cv=pass; b=sFoXgvp+jB440V126pikAX9NCcc99rNHYZjOvY7dquTgzap7Copc9s1uUC4oGSKDiXw+hZgJGLijpXLzyo39mazuKyfqeEeUVNWISUH5DoNXNXgcwOq5dEgYwyibrdaAFeTCXDhNYCDKauhwo4ryL6sVnp3kFMU0SU3uamdC1/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838321; c=relaxed/simple;
	bh=OoG13t5fMRo06fZmFNgpTUcetWwaXCMgRnWZXOe6uoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ym0P29ozfq83ffpcCGCuBzStWM/abyyFjYgHk283vbZNkN1tykM00qY29gRjwNS9ZVdeIzSIaN9utv/0i0T+7rmHgzWiJNvy2xtXF15dFW0elznF31OZmk1kUinqqGAkmPj3OHJyqQ+DJ3eq2g+U91XS+zjgFtHgwpcM3KZHRaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjYZERbH; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjYZERbH"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a46260385so26050107b3.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 09:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775838318; cv=none;
        d=google.com; s=arc-20240605;
        b=Q2G6jasMT34rmgt8phNDC75U5JP2OJXaDc3gOqYfSzbZ2joBfOXmDWvpE1R6/5fE5l
         vPBFMt2F7YvoRt/b+RZXQd7ysRw7RJY+joIvVsDgkEF3/IMyx4/G3IExL9xE0XdfoeRW
         nWVDdYiozu5ieYEZaiQ7PQBL8Sf5fgg3NxxzIUatCcW8jGVdppFKK6IfY7cMy31Q+oUd
         tIYDFjLM+l/NTLyFInRW8M8YDwzIemGiFSQdI22ulQRU0lWSP76jzV1YrDV371t0YMqT
         B7xUK2PJTQOyYi6ZI8d9v8p+JNZRag0IYW2gmTimNTs265D2lbTLArRF4A44nfxPNgWo
         aaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aOafYtGdAJCkg1zCvNbEejS9Rxnp/PpHYzzcYKXo4XU=;
        fh=4opnlJvYV2nW8sHhvyX0EQ4qARKRNpDSXSTZ7/64WvI=;
        b=dBKZ1iBofvOw3BqASh0MmSjF2hMb6Mr0GtwnoKJhUAm+CXze1qVTC7MN06Ao08XB88
         qS+cYUmR3GYbNP4qLgFHLK4t6DQh322fpaystS/OTO4qxwdKnGMbtR3gfsTckJzAHxyK
         TxmyZyu9RLjS+7WTdbjl2NL9GZrmXWRhdU8RRMu2pWhYl4tgcuIjuwj6Eej3NYs/K2Z4
         YMiokUaduNgOI1gszc6Q4m+okzBOsKIfTKsd8P+Vy3MYm8OkYbCAPse152hL9wE02M73
         HpGzv0eEGA8P/usVM8kUnYk9mpeGjIJNJ7w8PzC3ZuO6z/F3DFMTATKPXl7iTMsAay2m
         EwmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775838318; x=1776443118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOafYtGdAJCkg1zCvNbEejS9Rxnp/PpHYzzcYKXo4XU=;
        b=GjYZERbHs3Wkc6PCHhLDLym8rKzLt1gBWZiuDyOFuFFnitIZNGAHNHOiJ7xGWpunYR
         TXdKTWokMRv/SoCdINv4MeR1loCSc8WHbecXs39L2HTobRO/yWtH+xjHGQZ84rlTYk4V
         8lS+xkprpl+wdRelFjNjCZqwPyIRKqDrLgjBMgYxEve4qbh1clIHAKw841xeYx5xwrqA
         efBg6QgvHLB5bsCAWT+pSzhZNiO7zij/LKlxP1XnfMH4a1k3kqvDuwa7pTNxqCq13khK
         MQtfTKZ9MkIvuB/+iJ4g0/rW548E1txCAHvimfiQ/qW3Y2bENjbGC79C2WcM9wVJcosI
         7Qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775838318; x=1776443118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aOafYtGdAJCkg1zCvNbEejS9Rxnp/PpHYzzcYKXo4XU=;
        b=JuxklHd3znpzCkW4tNQ538YYWKfwuTCqcBTEQ8QLqZUsdNbADwETJpPVz9kwDK3T/h
         HiuE+9pOi7Sbk/0cG9SlNKe0/3uKu02/Vu1iRTkhVCUmTlhTYScJFOkKisXomk7HzeDY
         PgRyBwAskhCnid7bpnB6617ahPdeDwET2ZyC5dsXwn/phtwGaY0t5i89VGqTM80AtaQH
         KEf/oM2HQxfJUQ+ebphGrzkPYnxueAYJipo4oRWBkYy4EmdTA8gn/ITsARLtQQVJ9El7
         EXfgvlqnwohfmKin7fMHOiOhf/tusCryIyqFQSRKAlDtGGQVRLhVkuK4pxHaIUtAxXyp
         BeIg==
X-Gm-Message-State: AOJu0YwTEv2knOlSce90ZpnXasbKfSqQYACVCZg1GYE4EdUdr7q497KJ
	0hvwXxylWHUa3ZQW72//dZCrq9vxmISkULE9QORKban34OInHBFxM9Lvq6CKiFDMzuSlFj3KRHw
	/gHBXPlS7vgycYfzKzZsEVq70Rvc3IWiUcoBvVCc=
X-Gm-Gg: AeBDieu6JD/BYzT84nA1aRjN8luXxRKxv6xCrcqrluP9FSO+iQEOqIBAVAF75f52dkg
	UGFq3rGOKtKAApYuRP/onGbPvGrX/BRWLzyImkvZQ7SbOnbxnZixJxtUBIW/KXvg2pjSlEep1H0
	WNmj+C5ckPetdwZ5MHbBxjT2RXNtjp5iz7ZYy+9FKwQnt2byvROkOdaG/qGEAUWK9UudA/YlXle
	g98f9b4kUFHHrkyoZ+HMbpgstMaOgCHzznOr8/xz7ZZEyCedZsoiilUdUA34ZnxPZoMr8b4j7qt
	+ha5iIhkIVYU79xGi1jPhCxxcXFiTl7LLtWy6MyJitRhvHtiMxMBLX9v76FD1dd0STj/Y4qEAvN
	T9szqdk6sT3E87xZKA+Ck2w==
X-Received: by 2002:a05:690c:83:b0:799:2b4c:1d49 with SMTP id
 00721157ae682-7af71a57a55mr40343747b3.36.1775838318441; Fri, 10 Apr 2026
 09:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com> <20260404092425.550346-1-pabloosabaterr@gmail.com>
In-Reply-To: <20260404092425.550346-1-pabloosabaterr@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Fri, 10 Apr 2026 18:25:03 +0200
X-Gm-Features: AQROBzDGLrsqyK7vtbU3W0h9Qzl1zM7490bJgJ-OVY_NCLW9Orj01t0BKh_2ZRA
Message-ID: <CAN5EUNSEt+W4kQsoTfLVJQ+KFYkcPCx3_=YTSwh8zhBMFDttEw@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH v2 0/1] graph: add indentation for commits
 preceded by a parentless commit
To: git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 4 abr 2026 a las 11:24, Pablo Sabater
(<pabloosabaterr@gmail.com>) escribi=C3=B3:
>
> When having a history with multiple root commits or commits
> that act like roots (they have excluded parents), let's call
> them parentless, and drawing the history near them, the
> graphing engine renders the commits one below the other, seeming
> that they are related.
>
> e.g.:
>
>   * parentless-B
>   * child-A2
>   * child-A1
>   * parentless-A
>
> This issue has been attempted multiple times:
>   https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/
>
> This happens because the engine prints left to right from the first free
> column and these parentless commits for the next row, their column
> becomes empty and the engine fills that gap with the next commit (child-A=
2)
> seeming that parentless-B and child-A2 are related when they are not.
>
> The actual implementation is very minimal.
> This patch makes the parentless commits to be kept alive at least one mor=
e row to avoid
> that, indenting the next commit to the next column and then clean the map=
ping
> letting the indented commit to naturally collapse to the column where the
> parentless commit was.
>
> e.g.:
>
>   * parentless-B
>     * child-A2
>    /
>   * child-A1
>   * parentless-A
>
> This is done by adding a is_placeholder flag to the columns, the parentle=
ss
> commit is actually there but marked as a placeholder
>
> e.g.:
>
>    * parentless-B
>   (B) * child-A2
>     /
>    * child-A1
>    * parentless-A
>
> (B) would be parentless-B column with the placeholder flag active.
>
> By teaching the rendering function to print a padding ' ' when meeting a
> placeholder column hides them, printing the second example.
>
> There could also be the case where there are multiple parentless commits
>
> without the patch:
>
>   * A parentless
>   * B parentless
>   * C parentless
>   * D1 child
>   * D parentless
>
> with the patch, the indentation cascades:
>
>   * A parentless
>     * B parentless
>       * C parentless
>         * D1 child
>      _ /
>     /
>    /
>   * D parentless
>
> the _ / might look weird but that's how the collapsing rendering does it
> for big gaps, this case being from the 4th column to the 0th column.
>
> Another patch could change the collapsing rendering for placeholders?
> I haven't done it to keep it minimal, but a follow up could make it
> to be straight '/'. This would make it bigger but easier for the eye to f=
ollow.
> IMO is not worth it, but opinions are welcome.
>
> The patch also adds tests for different cases like a parentless commit
> preceding multiple parents merges and the examples above.
>
> There could be some edge cases still so any testing is very welcome.
>
> PSA: the tests are on t4215-log-skewed-merges.sh, which is not very relat=
ed,
>      but other graph related tests have +140 tests, and this one has less=
 than
>      20 and some of them are also not very related and differ in style.
>      A cleanup patch before this renaming the file and style of the tests=
 is fine?
>
> Changes from v1:
>
> - Changed to parentless commits instead of root commits to make it more g=
eneric
> - Fixed the branch names to pass CI and fixed tests style.
>
> Pablo Sabater (1):
>   graph: add indentation for commits preceded by a parentless commit
>
>  graph.c                      |  70 ++++++++++++++++++--
>  t/t4215-log-skewed-merges.sh | 124 +++++++++++++++++++++++++++++++++++
>  2 files changed, 188 insertions(+), 6 deletions(-)
>
>
> base-commit: 8de2f1b07a8053d7f1aad70dc1131d6afcf5a28a
> --
> 2.43.0
>

Hi,
I'm sending this because I think it has fallen through.
Sorry about the ping,
Pablo
