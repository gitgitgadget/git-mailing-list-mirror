Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793653446;
	b=Fhi8dLRtidlA/ybmtOPbxAeBU2EPuKVbQ2zy8bjeCzEa1FyBbkPJ9b0A3ih8ixfqKylU
	 AlODnllil3doW8IBBO/SkwuUA6Ccq/3KHTi2fRmAGLv2XWxkXgMGb3Y5imqedtt6whJmI
	 C7yP09X3MyZDxhxkiWrRAji019DggPnaf4fNbWRBtvXzwJPAUsdavldbTr6j0sCgvD7B6
	 eYlWQe/4XjyprUatpXhXle/UvbNaIPqwy64WGMFRSaxQcxroLTsHPDY2ZWKJdzgIp/YFd
	 QQsB8ZIQTI2BpJM89XoQEdPcU+j5jFlPX68Fa/whA4tqVmA4N9iDr5klbDwzIU9/sqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dHMA7oVzsDY1cmYRW6fMQo4E1KPdLuEVwmKemjTyT1I=;
	b=Ie47vQ1g0vdHVWxMM5FzUu+bCtrwh+Lkn32YCbu7mimF9CLIoysO+9b2pthGs6sjQXZ1
	 /HFZSHQpf6TifqfHPkbum/rjLA8LYAgBMCLOcVKOj2eO3550s2t3UwSWkiByz2T0wnHcL
	 egE3HluHQRjoCvkVV4i7dTdKRgSthTMymeh568/c4apDvHAf5Ib3sTJDwndCRpQT8Y0AV
	 CMEcIfjekeF7oS5bWHYfdXbv+a22tlapPpNJoD/mLIwmORBVPlApnSQxBr9yjFbFQ844C
	 puBbZk/2gyjhg2dyhWQXkZ/Zjh5zUxDjGipYKe/9Fwwf6S8wCCaQV6SITzrX56/JKpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jOV/s0Aq";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300A606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 21:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3300A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jOV/s0Aq
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so3658918a12.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 13:04:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793653444; cv=none;
        d=google.com; s=arc-20260327;
        b=b9IJ7WEuD/d92GH/sdABfYHz/pk03sAB0Pq0VnrSEZob0OZAXZJvFmiifWsU0zhKUC
         vB42YdG66HxJ5XacF5FN3WIwL7FWl0NRkJBL4Q6FGAhp7PaJEeavVOGvOsbu7K2Oghqd
         SNRvdD+C9S0sD0yl3G8psmBdonhBr5dy1aM4w9Zgsu8Qx7zoVde30i9Es1WFF5fDF26s
         g3ZXZSLMIQZtps5Fb8zZLfu2BfQIxZ/m7B+J47Azdd03ZSxHap0QhstDgEj+z7QMbJ4R
         kPBE/cJUuBo1g1rjqAzkxce+sUDaxgNWNvgKs2hPjbRBZ1LAOd3aaIUfwfPWHgZdAAHe
         wVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dHMA7oVzsDY1cmYRW6fMQo4E1KPdLuEVwmKemjTyT1I=;
        fh=un7ejnsC9917TP3Uu5BzYskiqa61vU0uWH6bVcNfJqQ=;
        b=rw+JrWr87+qkXixwiFU7zbAWnwo2NEYOdpVBQTgl5cO0RmcGGayYHIa664Vp5UyufM
         RTC0Gcgi23uSiRPxKG6a77/ivwAvctS1/zkkcgnQfskxc8MtYMA+p/aVmKzP+De2SPxq
         QKUyCoKNWH2xfr20lJX1exBrEZS1SF1k4v9e6v6383Yikx7UU3REWg8yOthGBHycf0/0
         ZmdkPQykIrn8u0wfakvZ6ZjI0gm0dMjqtAjVJJt/fAoxI+zs+gTGAmZU076udpxTQrgG
         +d2rzH2F2fqJWREaAI9bfoyopc9kWUdBuuubpfqsl2fLCQWJC/Pj3vTz1jgz7YRS/Kb+
         jCWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793653444; x=1794258244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dHMA7oVzsDY1cmYRW6fMQo4E1KPdLuEVwmKemjTyT1I=;
        b=jOV/s0AqgP+ZJmPdjpY8wBzERhSK+tgi97ZynZoFQz7mxa1bKDI60rGCt6NclayfvS
         8k/Z33l6nR9UIuBL8yWYOuT6OMbUmC5iyawlvhzOoiI99vS8XggO8QvUTjEt6X5ARHUA
         Xz3bx03Mc2ULlaStGKkZKrZULZarfZlBTu3ccV/OWyTTmhMjmgS+AxicpJpM4TFGGZuh
         Y2HPsdWeHg73Dh/d0tVUKJJKEey2YrB/iiMNXS51XJ59zJf/uign5g+ulYYVuyIKOwiI
         7ur6GNpvfQ5EEEcbKMZ9qKUQsWM8PD52pQmgcyXZQyXOF7ohH0QvUBLCsMyacS/OY3Hh
         dN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793653444; x=1794258244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dHMA7oVzsDY1cmYRW6fMQo4E1KPdLuEVwmKemjTyT1I=;
        b=LWY6uw6DPrwaGzOqOhqm+/N8T9xWWysrgq2fjyx4kkK70UIKZ3csG9lFtFbAPHExy4
         MXdj+N080QTiMM8Oo6uW8jOzryMmDuuqGUe1UDr8CvCE2GstsR0IJQKAgPyS+oKoDbxO
         KX71dCNAxc0EMauBkA+6Sf5WLEnwCG6RVnD9PDRcsPUnkmJO7Y8MNWN+MN912vd3CLJi
         6JSsFlkKIlVXlFFRwTdS7aaJSr1vRdvo7XNzIjDrWAN/miub27iDXmslYKMhlU+iPaKJ
         VpyjlGBkxfjt3I8DWGWdAbyAxICLJ8Jr+zozES7ekpkOS+EVzBwAa/i6oOOaug+Yo3Jh
         bfPg==
X-Forwarded-Encrypted: i=1; AKwUvBxUGNmOcV5rhqhDV4xDtkt8Kn7uxJZ5FQiUUVrzxn+ymn2DfOXY6GgPuuOKOR1QoSKjajg=@vger.kernel.org
X-Gm-Message-State: APuU4Z//ofYIoOuHRRvNJMSdPA8hNY242muPMWYNLRPYaecEhboGlgA1
	BBkdIoJ3MIN3sMHeg0kiFKcliUsGv+RcAPB5lG2O21q9Ann7d/eTgzqll1aKj5Hx71brWsSyZNp
	zZL89+Lf3+i2AQgD01fAB4c2E+sEBRU8=
X-Gm-Gg: AYBFou3aQzuibZfxqcj4jLYrlnE0+9jwCuJmRGhsr9f+9V5I9fXscdNZwdE6DM2AHKo
	V39SKQYgxSmUJdayeWegflZh7bhrMCvAstDZm7RXJtPpiypSIO8vauuTxgs+CNIq4meJr39gJND
	b5Hf82N8Ebx2wF8+qdhR+TCu7K3wEpArlenOKA+MxVZUyXr6Wn6R29y6fMFg17VK6rdEdcT8St7
	yinOvtpbE9RvQ2v/JgFd+MESaPipYkfNeMR4zGmzfYiFY8N7aMdF0hpDFgNVO8011JTdWA5/TYY
	4J16tiKteWinc0NnyghS86ua5cPIW135s0pCIjMoYgQ0fNHSYjoAKmYkLLt0iIuuavpaeVBVoEE
	EclxKTxuliWpa2EeeDhxaOBu6y0LkkY1iI7S/
X-Received: by 2002:a05:6402:c522:20b0:6b4:19d1:b2a7 with SMTP id
 4fb4d7f45d1cf-6b4d438ba86mr5604278a12.11.1793653443917; Mon, 02 Nov 2026
 13:04:03 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHwyqnVtN79Y7SAWb4YFRCqCO6+Jq9-9tZ9Jho4ec8pjVJR00Q@mail.gmail.com>
 <73E9A266-5224-43CC-ABC4-83FBC6B77F13@gmail.com>
In-Reply-To: <73E9A266-5224-43CC-ABC4-83FBC6B77F13@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 2 Nov 2026 22:03:26 +0100
X-Gm-Features: AclHuK_F83yhrqEoGCv6ABrgR7e8-jMmmbVz_7ab-NYanCzSXeYGBcI_UCdSc4g
Message-ID: <CAHwyqnVbgHOvCbXjWAuV7CkXranyBAocfobH8Jerf_96iWzYkA@mail.gmail.com>
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided commits
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 5:47=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> wr=
ote:
>
>
> > Le 2 nov. 2026 =C3=A0 05:11, Harald Nordgren <haraldnordgren@gmail.com>=
 a =C3=A9crit :
> >
> > =EF=BB=BFOn Mon, Nov 2, 2026 at 10:21=E2=80=AFAM Junio C Hamano <gitste=
r@pobox.com> wrote:
> >>
> >> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >>> From: Harald Nordgren <haraldnordgren@gmail.com>
> >>>
> >>> Reviewing a range-diff often means scrolling past commits that were
> >>> simply added or dropped, when only the ones that correspond between
> >>> the two ranges are of interest.
> >>>
> >>> --left-only and --right-only already each suppress one of those
> >>> one-sided groups, but they are defined as "only show this side" and
> >>> so cannot be given together, which is exactly why show_range_diff()
> >>> already rejected that combination. Give the "show only the commits
> >>> that correspond on both sides" behavior its own name, --matched-only,
> >>> instead of asking users to reach for a combination that errors out.
> >>>
> >>> Extend the existing '--left-only'/'--right-only' conflict check to
> >>> also reject any combination with --matched-only, since all three
> >>> narrow the output in ways that cannot be combined.
> >>>
> >>> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> >>> ---
> >>>    range-diff: add --matched-only to skip one-sided commits
> >>>
> >>>    Add git range-diff --matched-only to only show commits that corres=
pond
> >>>    between the two ranges, skipping ones that were only added or only
> >>>    removed.
> >>>
> >>>    Changes in v2:
> >>>
> >>>     * Update docs and commit message.
> >>>     * Use die_for_incompatible_opt3.
> >>
> >> This is more than 6 weeks old and looking at the archive, nobody
> >> (including me) was really interested in the topic.  Anybody wants to
> >> take a fresh look at the topic?
> >>
> >> Unless we see some volunteers to give it a review in a few weeks, I
> >> will discard the topic out of my tree, as 'seen' has been crowded
> >> with topics that have been collecting dust without getting many
> >> reviews.
> >
> > That's a bit sad. I wonder if no one is commenting on it because the
> > code is too trivial, meaning nothing that stands out to comment on.
> > All it does is allow left_only and right_only to run at the same time,
> > and the majority of the new code is tests.
> >
> >
> > Harald
>
> I just skimmed the v3 message, and I=E2=80=99m missing the motivation.
> When looking at a range-diff, why would I want to hide the added/deleted
> commits?
>
> I suppose when rebasing, I might want to not show the dropped
> fixup commits or something in a range-diff of @{1}=E2=80=A6, but
> I=E2=80=99m having a hard time coming up with another use case.
>
> Doesn=E2=80=99t mean there aren=E2=80=99t any! [But the patch might get m=
ore
> and better reviews if it is well motivated?] Anyway, I=E2=80=99d be curio=
us
> to learn what motivated Harald, as it might be useful to my
> own workflows, in which case I might be able to review more.

For me, it's simple:

If we take this branch, and I do some other changes, and then rebase
against the latest master. Then when I run

    git range-diff
pr-git-2401/HaraldNordgren/range-diff-matched-only-v3...range-diff-matched-=
only

I will have to scroll through 311 unrelated commits before I can see
what I actually changed. I want those gone.

```
  -:  ---------- > 282:  b2608c4076 t2104: avoid suppressing git's exit cod=
e
  -:  ---------- > 283:  5e106cb22b pack-write: make index-pack output
comment hash agnostic
  -:  ---------- > 284:  21bb64feef pack-write: lift and expose
index-pack report parsing
  -:  ---------- > 285:  dfb7f49776 object-file: explicitly write
".keep" lockfile
  -:  ---------- > 286:  b07099fff9 object-file: write ".keep"
lockfiles during transaction commit
  -:  ---------- > 287:  91ef176b8f branch: strip refs/heads/ from the
--set-upstream-to hint
  -:  ---------- > 288:  8f3d6ad89f checkout: use Q_() for messages with co=
unts
  -:  ---------- > 289:  7e34d8174d The 8th batch
  -:  ---------- > 290:  4ec5266711 branch: return an error from
setup_tracking()
  -:  ---------- > 291:  ad74e02417 checkout: finish switching when
the tracking config cannot be written
  -:  ---------- > 292:  d84678b8cf Documentation: describe
connectivity checking
  -:  ---------- > 293:  97998dcfd1 p5413: add perf tests for connectivity =
check
  -:  ---------- > 294:  d6d2d8557c connected: drop dependency on
`the_repository`
  -:  ---------- > 295:  9e0207b50b connected: add
transfer.connectivityCheck config
  -:  ---------- > 296:  43157175b5 connected: add incremental
connectivity check via rev-list
  -:  ---------- > 297:  656be5948a connected: add "auto" connectivity
check mode
  -:  ---------- > 298:  9dba0b87e5 rerere: stop using
`the_repository` in `rerere_path()`
  -:  ---------- > 299:  f62947adf0 rerere: stop using
`the_repository` in internal helpers
  -:  ---------- > 300:  a8b75e8eda rerere: remove redundant calls to
`repo_config()`
  -:  ---------- > 301:  87ab289605 rerere: cache result of
`is_rerere_enabled()`
  -:  ---------- > 302:  4f67f74fc8 rerere: stop using `the_repository`
  -:  ---------- > 303:  ea54cda7c2 rerere: bundle global state into a stru=
ct
  -:  ---------- > 304:  b948c10c8b rerere: get rid of global rerere cache =
state
  -:  ---------- > 305:  c3764d15e6 hook: make hook.<event>.enabled
cover the hookdir hook
  -:  ---------- > 306:  3a7784d0d5 hook: accept .enabled and
.parallel given without a value
  -:  ---------- > 307:  37b3475fb5 The 9th batch
  -:  ---------- > 308:  8d1b215c01 The 10th batch
  -:  ---------- > 309:  b9e5cff180 The 11th batch
  -:  ---------- > 310:  50fe5cc63f The 12th batch
  -:  ---------- > 311:  ebdc087dc9 The 13th batch
  1:  ee195c14fc =3D 312:  f01d7e30ef range-diff: add --matched-only to
skip one-sided commits
```



Harald
