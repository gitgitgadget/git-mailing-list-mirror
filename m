Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793654185;
	b=AxKKk7pURsSIz91aUFkVVNpyfMwHrxESgVWja2dp8X54ub7FVEob4s23rGVqzXMGzQKJ
	 gA1XgWMqS9fscTMwHSjA01o4mbKLAjkpuQZvMNi6PPCEP2SEaZP4/7sx01W0DryANCSBl
	 28vAMLIVKMj8cPAqKtvCjvRiwiFH9ITVh2fcyWpEbd9oP9/JRhEKSStCDOtNpH/96uTMy
	 MOmaSM6zsoqNJcaATqeov3F3Q0Cc4ukXsiL5/C9yNs59PvV7Nd2dmG0cqfV2bt+1ePxaC
	 QvAyFvsUelT1jxne4xKAx8ASlFjOZv2UPCiFgbJ6prx3k22k9LeVAGSUtO47j1FYkcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M5zK9fpcvKLS0pMD9MQidsxXTseaOTk60QAGtSzSoI0=;
	b=nCxCzUMevZPQaMwabybat5yheZx00hol0ZpDSumlhKrmpeZyx8ONAwc9iHnAJfp7J54i
	 LJeqyjQW9imQnsdUrUW2VmiqxBndqOq8hyxCHGvCTjvDO939vKRYaTeN/7uUeKi3O9SUD
	 kiGeRxWQR1eaH89P6116BIiisEzkNWmlpv55pPVU5GwFwQyElxhQhhzYvSAbSMqiUR1wq
	 lib9/nBarE61Il0YbPrELQtn7CoG5W0wBHnuHHwXT9zXT7rpKxXa7kNBZEsZMrovNJv1y
	 u5hLz1cD/rUGfO3qIcwvtuHs9b+ZilPPeDUejyCN5fdo7VkSuk/f51T8yPfFHWPwoMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dsRgzlVn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C31606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 21:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C31606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dsRgzlVn
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so4775721a12.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 13:16:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793654183; cv=none;
        d=google.com; s=arc-20260327;
        b=HuoqOmRoc9umBFn1eOdgdA73sCaoWZ+RE/VERmZn5fYaCAmf5QRpvmS+n9dEeLKC1j
         t8UjJ0+8nLPGR6SoE9Jy12x8OCO9ZgOxCtbGOR0hYN0YwXH/JdFq11uvTch1/VX9lgmG
         V9XAy+W2PUeBYoQ2ZzfqlRro68qQW2BnlnLNL6qxmY9q5dCrq8HAWTkKaDcC2iEBREzl
         hadRwtRhfhOe8/UMjrXuvKEneCshlpYKns5ESI88/TiLIOJQp/rUZnzL0kIm8Yx6R3Ft
         d3m56fzqqGfmj1P+mzCWXQvU90wQYZNfamXRTk6sBTimIh0zIuOvSHDV/ysrzN+Mv5eb
         BivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M5zK9fpcvKLS0pMD9MQidsxXTseaOTk60QAGtSzSoI0=;
        fh=fPh0ArG6RixwTKfS8u2Cz+si7e3epBc8B9v5WMnviaM=;
        b=S+oSXmew0izJVxbJJevDPdgf66RD+FK+5UXg9vXBjt5f/rBFQ+bUmTNVxZ7f/2VNdc
         Keyd2IyUQFdsaTXHZGFbwcAoDWcjY0KerE32YOnwq9pyCb/78xcvavmIF7k+FzYOW8o5
         H2If71K6OjqD2QaicziPuHgtsVuxJ1MXyxPd2BH4TP5KeO86eNe5e77Dw3P4ifDfmrph
         qLjNcZZxQuE91ydvK3WL2xl1+gFHldZkdexwCOLsCe+findaK3/L9qkKawsFq/Cc8iXD
         rAoJ3VSnJ4sQ4QRsPfhkoRBiYSpXUzquLku3pmooQBJwdRBugfILwO/UIJB+Ubm3R7nM
         TxmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793654183; x=1794258983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M5zK9fpcvKLS0pMD9MQidsxXTseaOTk60QAGtSzSoI0=;
        b=dsRgzlVnZW95bqA6WG/g4PHKrVpAe1NCrbhJJDXqu4PfEu/CU2aS0GlHGM1u8zGHgn
         Oj3zNPpQS2woeOFIwvNi1CI+MlBa4PxyikL0An+9o3rFGo5jiy4zR32P0ZfbFb4M2w1M
         4PsmsVy4JU/LRsggcDhRnG5p909XpB+SLzJxKGUEAQnKxV76EaBUXz2SlGZRB24LbUp/
         WLLtvYBElloB4nKkYh/Guv8wgcfmQLv42JhxNzsg+xP/R77EHAe83tbj9DMiDeNFcQoU
         hR8dSqfGbCFnbPQRwC4+g1KFXHLHWFt8a7oc0JLYHikM0m5xtHBeMbJcrJ67Q/FL7+s1
         DwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654183; x=1794258983;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5zK9fpcvKLS0pMD9MQidsxXTseaOTk60QAGtSzSoI0=;
        b=ARK1A4enGRq5PpXWvIDoKX02CAWJ1buS8fWV6XG7cvlv1oGSCCp5PRp9UbQKGV8EJE
         B3Q4wXasZPEHqlunfyc/72jg6XC0sRdcCI+JIcp89NkRZWZ5qpRKabOgdcx2hJbhk4O8
         RFHoZt2sWh9XDphykXfOn1t9lQRVAsYVxqYmJjkt+mAnCTygPmn+bQMlankEGtFZmk0i
         ypp4UgCx+m5gtc6+A3/KBcuqJHi7czcIxa3hyoKWGkq6Kt3M3mn/Xex7t3SnOMOuisMG
         e0UiX1lmdeMrgPkxdOPXlEoBpVbCAi3eD+vtCvr52T/lEp2USgjHZKUvYdIAFHnheki0
         efZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlQnuYLKR5P2Odso9YANcpZpDF2TML0TOQfRKIURYfScTh2e4cRtyxw/oUEgbvmzp+ozw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2oWNARPwxwVxc/BQ2KKLmXue93Go7Mwk4w3KoWwZ+LNoCx3o+
	dOhCZeZRou93UowZeqdUkXwR4EHh/qQYw/6HDaTA6Koti0YO/rjtBBwbHYaHbN64XTn1JDpHfF2
	APy1rhDQS03tpWY/4UyUIr1CKrDqL2CwxvhCF
X-Gm-Gg: AYBFou21dyNGc4jooDLO/z/LiYEUbsZzBapt9YCXGOylbOqQByaT4BkQiA/IeIxwzTj
	ds8UYWjNqLTIDPJH76k9VuCRfeOaIS/0tsaLTSW+C6tqST3aImK8noxypdQjWe3EzU2r0DrCk/h
	GbRw4J7WFzCAHZx7zGiQ+BBE6KvLOZhEKz4eEV00ZXDk1I05eHaRxU0mE8WQtPQh4Zqtc3hsG8w
	ej5Z+ylLyld3alB+NLfEz/NXFTUcIjEJ2VHsO+LSJlPh6ivJPMWxLR+J2q2O4/9Wmwco5y/r8Pi
	aYRVIkSITA6S91Jr7XZ67wN/tGu6PwdDA+vChPMc+CZREFJhRW/8nZnSoTKBFfghwvPcrvGDpFb
	nYvYq98joSrSEyFYwfAtC9YZHfzmZoOQXGPU/
X-Received: by 2002:a05:6402:1e8a:b0:6b1:ef5a:6719 with SMTP id
 4fb4d7f45d1cf-6b5338aeccemr1027796a12.10.1793654183550; Mon, 02 Nov 2026
 13:16:23 -0800 (PST)
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
 <73E9A266-5224-43CC-ABC4-83FBC6B77F13@gmail.com> <CAHwyqnVbgHOvCbXjWAuV7CkXranyBAocfobH8Jerf_96iWzYkA@mail.gmail.com>
In-Reply-To: <CAHwyqnVbgHOvCbXjWAuV7CkXranyBAocfobH8Jerf_96iWzYkA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 2 Nov 2026 22:15:45 +0100
X-Gm-Features: AclHuK-qMs0k4GOz2l6GpWj0iSUs3bxDChT2TY6HwKTEA5D_IPQUQypSVvc7kHE
Message-ID: <CAHwyqnWPhgT54M2LL7SxSm0qufSaYDD-gGAJVTdOqaKy-CTA-A@mail.gmail.com>
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided commits
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Well, in this particular case `--left-only` solves it.

So maybe that's enough.


Harald

On Mon, Nov 2, 2026 at 10:03=E2=80=AFPM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> On Mon, Nov 2, 2026 at 5:47=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> =
wrote:
> >
> >
> > > Le 2 nov. 2026 =C3=A0 05:11, Harald Nordgren <haraldnordgren@gmail.co=
m> a =C3=A9crit :
> > >
> > > =EF=BB=BFOn Mon, Nov 2, 2026 at 10:21=E2=80=AFAM Junio C Hamano <gits=
ter@pobox.com> wrote:
> > >>
> > >> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > >>
> > >>> From: Harald Nordgren <haraldnordgren@gmail.com>
> > >>>
> > >>> Reviewing a range-diff often means scrolling past commits that were
> > >>> simply added or dropped, when only the ones that correspond between
> > >>> the two ranges are of interest.
> > >>>
> > >>> --left-only and --right-only already each suppress one of those
> > >>> one-sided groups, but they are defined as "only show this side" and
> > >>> so cannot be given together, which is exactly why show_range_diff()
> > >>> already rejected that combination. Give the "show only the commits
> > >>> that correspond on both sides" behavior its own name, --matched-onl=
y,
> > >>> instead of asking users to reach for a combination that errors out.
> > >>>
> > >>> Extend the existing '--left-only'/'--right-only' conflict check to
> > >>> also reject any combination with --matched-only, since all three
> > >>> narrow the output in ways that cannot be combined.
> > >>>
> > >>> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> > >>> ---
> > >>>    range-diff: add --matched-only to skip one-sided commits
> > >>>
> > >>>    Add git range-diff --matched-only to only show commits that corr=
espond
> > >>>    between the two ranges, skipping ones that were only added or on=
ly
> > >>>    removed.
> > >>>
> > >>>    Changes in v2:
> > >>>
> > >>>     * Update docs and commit message.
> > >>>     * Use die_for_incompatible_opt3.
> > >>
> > >> This is more than 6 weeks old and looking at the archive, nobody
> > >> (including me) was really interested in the topic.  Anybody wants to
> > >> take a fresh look at the topic?
> > >>
> > >> Unless we see some volunteers to give it a review in a few weeks, I
> > >> will discard the topic out of my tree, as 'seen' has been crowded
> > >> with topics that have been collecting dust without getting many
> > >> reviews.
> > >
> > > That's a bit sad. I wonder if no one is commenting on it because the
> > > code is too trivial, meaning nothing that stands out to comment on.
> > > All it does is allow left_only and right_only to run at the same time=
,
> > > and the majority of the new code is tests.
> > >
> > >
> > > Harald
> >
> > I just skimmed the v3 message, and I=E2=80=99m missing the motivation.
> > When looking at a range-diff, why would I want to hide the added/delete=
d
> > commits?
> >
> > I suppose when rebasing, I might want to not show the dropped
> > fixup commits or something in a range-diff of @{1}=E2=80=A6, but
> > I=E2=80=99m having a hard time coming up with another use case.
> >
> > Doesn=E2=80=99t mean there aren=E2=80=99t any! [But the patch might get=
 more
> > and better reviews if it is well motivated?] Anyway, I=E2=80=99d be cur=
ious
> > to learn what motivated Harald, as it might be useful to my
> > own workflows, in which case I might be able to review more.
>
> For me, it's simple:
>
> If we take this branch, and I do some other changes, and then rebase
> against the latest master. Then when I run
>
>     git range-diff
> pr-git-2401/HaraldNordgren/range-diff-matched-only-v3...range-diff-matche=
d-only
>
> I will have to scroll through 311 unrelated commits before I can see
> what I actually changed. I want those gone.
>
> ```
>   -:  ---------- > 282:  b2608c4076 t2104: avoid suppressing git's exit c=
ode
>   -:  ---------- > 283:  5e106cb22b pack-write: make index-pack output
> comment hash agnostic
>   -:  ---------- > 284:  21bb64feef pack-write: lift and expose
> index-pack report parsing
>   -:  ---------- > 285:  dfb7f49776 object-file: explicitly write
> ".keep" lockfile
>   -:  ---------- > 286:  b07099fff9 object-file: write ".keep"
> lockfiles during transaction commit
>   -:  ---------- > 287:  91ef176b8f branch: strip refs/heads/ from the
> --set-upstream-to hint
>   -:  ---------- > 288:  8f3d6ad89f checkout: use Q_() for messages with =
counts
>   -:  ---------- > 289:  7e34d8174d The 8th batch
>   -:  ---------- > 290:  4ec5266711 branch: return an error from
> setup_tracking()
>   -:  ---------- > 291:  ad74e02417 checkout: finish switching when
> the tracking config cannot be written
>   -:  ---------- > 292:  d84678b8cf Documentation: describe
> connectivity checking
>   -:  ---------- > 293:  97998dcfd1 p5413: add perf tests for connectivit=
y check
>   -:  ---------- > 294:  d6d2d8557c connected: drop dependency on
> `the_repository`
>   -:  ---------- > 295:  9e0207b50b connected: add
> transfer.connectivityCheck config
>   -:  ---------- > 296:  43157175b5 connected: add incremental
> connectivity check via rev-list
>   -:  ---------- > 297:  656be5948a connected: add "auto" connectivity
> check mode
>   -:  ---------- > 298:  9dba0b87e5 rerere: stop using
> `the_repository` in `rerere_path()`
>   -:  ---------- > 299:  f62947adf0 rerere: stop using
> `the_repository` in internal helpers
>   -:  ---------- > 300:  a8b75e8eda rerere: remove redundant calls to
> `repo_config()`
>   -:  ---------- > 301:  87ab289605 rerere: cache result of
> `is_rerere_enabled()`
>   -:  ---------- > 302:  4f67f74fc8 rerere: stop using `the_repository`
>   -:  ---------- > 303:  ea54cda7c2 rerere: bundle global state into a st=
ruct
>   -:  ---------- > 304:  b948c10c8b rerere: get rid of global rerere cach=
e state
>   -:  ---------- > 305:  c3764d15e6 hook: make hook.<event>.enabled
> cover the hookdir hook
>   -:  ---------- > 306:  3a7784d0d5 hook: accept .enabled and
> .parallel given without a value
>   -:  ---------- > 307:  37b3475fb5 The 9th batch
>   -:  ---------- > 308:  8d1b215c01 The 10th batch
>   -:  ---------- > 309:  b9e5cff180 The 11th batch
>   -:  ---------- > 310:  50fe5cc63f The 12th batch
>   -:  ---------- > 311:  ebdc087dc9 The 13th batch
>   1:  ee195c14fc =3D 312:  f01d7e30ef range-diff: add --matched-only to
> skip one-sided commits
> ```
>
>
>
> Harald
