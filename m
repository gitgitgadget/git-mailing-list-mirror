Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4423AB294
	for <git@vger.kernel.org>; Mon, 25 May 2026 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691829; cv=pass; b=tpzYOrRJXaF+RnJ5homRHx4IFk4yiwziC+tz8yifOvdumx4k/5+R9ESULhg5Vv3ki3on4MCDOpzxJjVEMbVorA9hN+MJkf6D7KnW2bD5Au9fF84depBBMG5WEABvB4mqcsXZPn6juiEFc1DDU/z21nFGew0fqWDqLkDy9RnrBTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691829; c=relaxed/simple;
	bh=JZK2rSSFMcpduIaIdXPhM131uu47pRyzUkvOcZF+fzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkHbk3fTJeqCSmLmzQVoa4AD7e1eVNQ0SXpL0GPb/XIycABPFEcU3ZpJFBs8sHN+DoSJDuRI1crTbGG/SzBvS/O9RXilkO1T5RPh02vlUSdux9kiGEVtGzcoHjQszShWws9A+Nnj0bK8RNjd6nHWbQXB5byKJqH4eSrljxQnl8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=WMUdx7Xd; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="WMUdx7Xd"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7c04749d739so62077207b3.3
        for <git@vger.kernel.org>; Sun, 24 May 2026 23:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779691823; cv=none;
        d=google.com; s=arc-20240605;
        b=GxtOs+MKQbTbfIpj5l0aXHUuiaLjmITsKqNInVsD2Q7ubJQJ7eK1kpk+MKnTK1NxR8
         xy8XnsRH4gcd9b8j3OIl44GPNF3cEjxiIcTuFIDU0MpfRvBPugJhP3wqnPLEsAM2yi+a
         3hGsghr8rsS8pzVxcGl/+57qlJLU0DLiVrk+Fkx6lCMe+ciT+d7X8vwKEW9RxfSGkqYU
         aWUsybDPUoetDMfbOjpzpAQojBg+xpX0h7euP6sd+yYmk2oM+KshmMnngxmU1vD91o6K
         T5bBfsr8Xu1dwo1PDPxZdP68wRLq3R3gZJwRB18wo+P7JPM3C6OqdpDLDkXhz0Vdd17v
         2WfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oj7dOjB3ngjg5D7KcJVXsR+OO/sef5AG+M5D1onXwCM=;
        fh=+V/tEV/fyOP1q9doMVyt/er0eT88Xqz8H2+DD8cDvK8=;
        b=NGTtSXdBhm0Dm85qAbBBbTa8wwFbOF4RuroDBxmYkTJ8SATuKC6grzpjgnecQ7uwaR
         Tj+XoIkkeKYWtPGI6VTglrLaPIW5WZS6OrypKZ0eJaGQqFKP8T5kerL/HYtWYbLmdEtq
         IBXurDKVKPxayDtsRX4qpA686tjLvJseDLpqvu7bfIbduQEV64M1KC7AjF8aQ17zmAKb
         VlU/LL1jaG7aapb+46i/IeuXsWeLS/Vz6fN6hzWVc/TYiS8Nas6enOpNSqnJ+xxFW8Hi
         +gPc8KLPsOoz9vMnCK5akX6CS7pzfO+G9netwuhVXslazoMIGFtGqL2P6Ow2JHLjUY9R
         HoOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1779691823; x=1780296623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj7dOjB3ngjg5D7KcJVXsR+OO/sef5AG+M5D1onXwCM=;
        b=WMUdx7XdWBz2ikhlknEQSB58pfIKW0ObJnkocnalpw6CKhgLZ11i3KhPMiIWtfhzvT
         ORL9oilZ+4NZOThTM/brxOCQhG9xWOWZ33gS0MLciBOF1N8q9tZmmnzQHXS25opVy4Cj
         Orm3aF8OlM0vSJDZ0/47AFWIt1N/XKknO2qUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779691823; x=1780296623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oj7dOjB3ngjg5D7KcJVXsR+OO/sef5AG+M5D1onXwCM=;
        b=jYy7wq0bAVg94q/m+cpEtyRGr1OGHbRXKygRfc5vaDNs55UXa8gsO6gbf4Z0L49DdD
         bQfMToktrAxFikUW+jjmzA6szDOMkHPAZ2Bcf3PPGPuWLbhyOu/hS8bFbs6+oPKh6i9f
         GejtMkMZ1/55RTEkl098MVqQchPiOP9jpnWiMA20B8d04w1J49TlIDsZfA2nldCWU4a8
         ijflM8PF01FU/Sn4Q7rotF4tOV9xcoWCRk69LNntTa4GcRolWmu0ZuGazP8pcC/NzpHc
         lgXTKZ1f0wZtvDA3a6qHEsXGDg3ck0QyGAEcazUjsrBmGekMTCxK1vNfvCOgHQtWKb/S
         HF9A==
X-Forwarded-Encrypted: i=1; AFNElJ+DE6W4F76kuHOcnM1aXS8SSyEwUl7RPepdlir2e6Q+tQxru727pWX4Bc2fVT2bxunNpjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaH9DigLfR8s02Ifs3L5W3xSuu6zfzjviBsYHGWzWTBfxhSMLI
	Jv2KmsIoQdKOPSIYJkMeRVZLVtzHfqHM/FKjoIy0PCB16ixe4So2mQrYeXUkWXLWpaFHMiy1EGV
	hcpF6NSf+MukNkrBGyspEHo9jqATqOMY7SQk1uG/INw==
X-Gm-Gg: Acq92OGhD2aQQuwToUcSys36HWByO0SGKQuowew/od8StXaTXjJorGKn9XHl03IMsC4
	K8Yb56TMLRm/wnOxm+At7M5UWxo7/4JhuEcxOk1CfdqkVObDMYfwIhn/X9bl0rDjBiwgATCaU4m
	NkNZ0zZnSa1o4TuJyib3un5Tp1T86PzByr5uVGNq+PRmrFsUPT/YkdV7QdBa7H4siMmCw/XFppg
	SSuihKxrp9+TCtta7/4wB5xJlxsKB+Lofb01kNCOOEkm8dnvbfLQKOGz6c6WwcOtagfFJRz3mxB
	T4nPPX8XKQUndaXSPNzFtvFqUCZw1w==
X-Received: by 2002:a05:690c:6887:b0:79a:cc18:19c6 with SMTP id
 00721157ae682-7d33a95c639mr148467087b3.34.1779691823010; Sun, 24 May 2026
 23:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
 <1d3751569ba3a5f0c353fb468578d6c5bcd0b738.1779644541.git.gitgitgadget@gmail.com>
 <xmqqpl2kgyvy.fsf@gitster.g> <ca39c8ca-ca4c-4954-a1ab-633bfa55f64b@gmail.com>
In-Reply-To: <ca39c8ca-ca4c-4954-a1ab-633bfa55f64b@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 25 May 2026 08:50:11 +0200
X-Gm-Features: AVHnY4ITSiW8wB__IHqaCkmR4rOcjH-dkrbvnZuXQT-NJBCykYGRxZ39IV0AydI
Message-ID: <CAL71e4NxpbM8QZYhVA_SSC4vDmAFv-Kpe6qDcurefgPkSSdSnQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] commit-reach: deduplicate queue entries in paint_down_to_common
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I ran an audit of the flag allocation table and found three stale entries:

1. sha1-name.c was renamed to object-name.c.
2. builtin/show-branch.c uses bits 0 and 2-28, not 0-26.
3. negotiator/skipping.c is missing =E2=80=94 it uses bits 2-5 like
negotiator/default.c, with ADVERTISED on bit 3 instead of
COMMON_REF.

I have a fixup commit ready - mini-preview below. I can submit
it on top of this patchset or create a separate patch if you prefer that?

+ * negotiator/skipping.c: 2--5
- * sha1-name.c:                                         20
+ * object-name.c:                                       20
- * builtin/show-branch.c: 0-------------------------------------------26
+ * builtin/show-branch.c: 0-----------------------------------------------=
28

While doing the audit I noticed that reasoning about flag safety is
currently entirely manual. Would there be interest in something more
systematic (e.g. runtime registration/assertion, dynamic allocation or stat=
ic
analysis of flag usage)? I have some local work on that already, but I was
not sure if this was something worth spending time on or not.

- Kristofer


On Mon, 25 May 2026 at 03:43, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/24/26 7:40 PM, Junio C Hamano wrote:
> > "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> >> diff --git a/commit-reach.c b/commit-reach.c
> >> index d3a9b3ed6f..c16d4b061c 100644
> >> --- a/commit-reach.c
> >> +++ b/commit-reach.c
> >> @@ -17,8 +17,9 @@
> >>   #define PARENT2            (1u<<17)
> >>   #define STALE              (1u<<18)
> >>   #define RESULT             (1u<<19)
> >> +#define ENQUEUED    (1u<<20)
> >>
> >> -static const unsigned all_flags =3D (PARENT1 | PARENT2 | STALE | RESU=
LT);
> >> +static const unsigned all_flags =3D (PARENT1 | PARENT2 | STALE | RESU=
LT | ENQUEUED);
> >> ...
> >> diff --git a/object.h b/object.h
> >> index d814647ebe..05cbf728e9 100644
> >> --- a/object.h
> >> +++ b/object.h
> >> @@ -74,7 +74,7 @@ void object_array_init(struct object_array *array);
> >>    * bundle.c:                                        16
> >>    * http-push.c:                          11-----14
> >>    * commit-graph.c:                                15
> >> - * commit-reach.c:                                  16-----19
> >> + * commit-reach.c:                                  16-------20
> >>    * builtin/last-modified.c:                         1617
> >>    * sha1-name.c:                                              20
> >>    * list-objects-filter.c:                                      21
> >
> > Not directly the fault of this series, but we'd need to audit and
> > update this table of bit assignment to match more recent reality.
> >
> > For example, there no longer exists sha1-name.c but the table claims
> > that bit 20 is in use for its own purpose, and it being stale makes
> > it harder to audit and ensure that this new use would not crash with
> > these existing uses (note. there are other uses of bit 20 in other
> > subsystems).
>
> It would be worth adding an update patch before this patch, that
> only makes these adjustments
>
> > FWIW, object-name.c, which was formerly known as sha1-name.c, uses
> > the bit 20 as ONELINE_SEEN bit, which is used to turn textual object
> > names like :/string (i.e., commit with that string in its message)
> > into raw object name, and bit 20 is cleared from all the objects
> > involved in the search before the helper function returns.
>
> This appears to me like the only interaction that _could_ have
> overlap with paint_down_to_common().
>
> > Presumably, once commit-reach.c starts queueing commits and reuses
> > this bit for its own purpose, we will never try to parse a textual
> > commit object name to clobber what we thought is ENQUEUED bit,
> > breaking the code introduced here, so we are probably safe against
> > its use.
> >
> > I didn't check all other uses of bit 20, though.
>
> FLAG_LINK in builtin/index-pack.c and FLAG_OPEN in
> builtin/unpack-objects.c both seem to be completely independent from
> this use in commit-reach.c.
>
> Thanks,
> -Stolee
>
>
>
