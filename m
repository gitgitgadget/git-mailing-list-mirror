Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A1372B32
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165815; cv=pass; b=YWjZFqu7G9zZg2Cu0f45JjC/vp7V7M4xSXQ9QjOslc1usJUfAT4h3jB3s0ERtDbKCPZc03ZxqXSh9BCyot6C6OrT3aRus0ottH92Y0+qmkYHhIzTaCV5iyVYBuzzO3vXXnV663H9/bxXWuv9tfDhyeznwWNFT/H3XS+bAPQezWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165815; c=relaxed/simple;
	bh=97c1QF1IeIFA/XIuAOVNZJ9wA6rP0VPLLh7gsdQceY0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQi5v8MfjPz0LS0/Tf28faxINJ4Lzcgb6yZy44xWF79ElO7XaYqTw1zX+JZNjS8WzKV77iuvnyDgcWuK2CmebouvGQ7seACHQ6bU8vbHyjpObZzlXBUxKeYg6aP6JPQqnB9ik2lOass7jvQfZ2gU78RzdHuYTOy6+5aKTjNMQm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT1XyeLV; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT1XyeLV"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9638f7e9896so354931241.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 01:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781165813; cv=none;
        d=google.com; s=arc-20240605;
        b=hMpWk35X/BzZw++qaVZ3J7gdE2eqroEp3H/HypkbT5P9tIqMtqITBy3ZWOmDHf3/Sf
         YJPXMDYY+Tbd5IrG08E9jwiRaYFvCEoZ1LCq+mjLepBqzTLQCV6GgTNLVJ4PFXLYxYBR
         d1+Z1n+xBl3J6/KzBuRI9rktYUnyfWQqHeyjizR2/+86Ippswz4/m0FYU7zN7XK1okE/
         HPP3sHseBdUpYbK+ccykD54o2ZvQmILWmSAXvjDr6XSasKe/7D2PMcbLYJEa5EKlRDrP
         IzlUQFqaLKAMUk8PEHED2pCXcfZKxo5VFWwH5ppA8cAP4XzNMEy03ANA6Vk+F6xKbH9i
         Nv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=15N30mP5yI33NhAhinMOtYD+gsTpLBjecMk4/aCvLIs=;
        fh=SVcJ57Ikenus8+D0dWnhvNUqzjuzEBu0D99c00gGeGU=;
        b=ZVVj2FghVd8VWcI2bfqlwaFhM5WhhHajJKbKtaoNNEFW+290ja77eK1VquR1PscRRM
         1wUt+OMioRWHc7ev/mrdN8bDZYFXpeXhncFcC9oSWZIaaNCTZUCFJ1aVd/9D2GZAuuzr
         st6ul3ZB3YbJhWk7mekl1y8v9AXgF7DkmkcCw4lPAihByu9G2YwM0u3aOgOin97Zr9qD
         AEa6vFE5MeFl63MfI2I3EIw2uu1HqcmpW27lZ3iHBy3Y5k92NMkkyZGnCZN3wPRZRrSY
         eZq7TacK3mRgItHTp6w/DWbnc7uURrLp6eL58DT+wBvh4krdihpMR5+dPHVmElhWBZG4
         bLmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781165813; x=1781770613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=15N30mP5yI33NhAhinMOtYD+gsTpLBjecMk4/aCvLIs=;
        b=GT1XyeLVb8TpKK0lVzQDZ8BjEWmcVQbwbQ1qUXiuvb+Bjs6KVmlslYmLkYxG4gz9n+
         9WsYZCXAbzy1e0FWOYRorRZU/kZvFsuPQTN3aO9/qaGO9ETklcvBUMAoE2+0cb/lXGRH
         mzUa1Ecke/k474ulmH/D/S2bGw7cUNUmAPZiGJz9FAfit0E0JAaenBZsYx7x0FLbSVH3
         f+xJqdq8n5uEDMmuP0w47Oot87PtusKn64C3OfTchC/9+OM15yl9P97AAnDdkIVW+Fig
         tV2n4EMq0PITeye5zOW8v9naXF2MoR8Frn+VtTqZJUnqp5A318d1LKG79Q4IfDUg812G
         uvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781165813; x=1781770613;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15N30mP5yI33NhAhinMOtYD+gsTpLBjecMk4/aCvLIs=;
        b=N2HZKBQICia5+Hoza3Tn/qKW5eyPHx39FXdcU9QPiEpuzPSaAe2NbZ0zn6Gw/N+sKh
         Bxyye820QWmHd04cSCI0P4CbD5CU7Ehuu77iCutmt9BLfWrBPgD4NW1xnuNY7YVkVBAR
         JjKLEA/SGg76wXgRXzDecFs3NiK1bzFdCTShlDg4V2YEj+385MS69HLkDrwpNQy0rnp5
         4THn8K5piUGunMwhpxgHNCWERT99VQIUd6HhKvj8umO2O4fIlWwJGnpDNNvDQrC/LjTh
         DXRPr50Nv1e5068IrKau5zSidE6gd3dG3s8pfreYT1iY+8Dqo1GCHtPftB+zAcdwcRWE
         GNNg==
X-Gm-Message-State: AOJu0YwSqgLIrqH+athQUHdNT935w+T5qfIZWHrgZMMtiP73fUbDV8g2
	btNpeI3noHH/IU17ppigUZh1Qp35+5gF9mjbk48u9KC4/sF6ECZNoTR59cNVgxDGiBbaRPymZoM
	BhqnZJ2MFuhqiPtBkIsrWVEYxLFYJmcY=
X-Gm-Gg: Acq92OHaMEguL5Ndjg5RwfdeqGggllK0IEar2T7MJPjKMOxHlmTrE869fGvyZGj1Tr4
	h4vO4gPeFfCHZHEd877l5mr1fT7R4RkEuqpml9QxhOk2OR0dZaFyvbxEcFLnKz6Hja6Snk1iYsl
	fZGbPKGDM18Wxklm//DcbNZxnqyqeHlN8ceUcEe+UyFp/OuijZEcd1vgJnSsUiyyfX5TEDvWCcb
	ppS+UbUUd7/6b1WtIhjB9T75S2OgL3PkIMgJa5kqFRRFCDEpwcvEzR57u4g0/NJZqdQhkcjjr9e
	GsfDf3CKmRjEDKoi2KKf8GCfihXeKTim3yy44u4xAIXlVp4ZVYGUhuF2QIaRCBYHkUelZgkxD0o
	+vNoz4zy+MUQKdFy4R8k=
X-Received: by 2002:a05:6102:442a:b0:634:6b98:c37 with SMTP id
 ada2fe7eead31-71d69bb28d7mr31332137.7.1781165812830; Thu, 11 Jun 2026
 01:16:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 03:16:52 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 03:16:52 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAJ-ks9ku=-675naKESOJJxOo0b5BmoH7=76aKZXXmUHM+=ZV0w@mail.gmail.com>
References: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
 <20260608-ref-filter-memoized-contains-v2-2-e72720344a7c@gmail.com>
 <CAOLa=ZRFSuGrqFXhTuQ7Dk5GCQQGHom++78xwONoiNdt1h_gWQ@mail.gmail.com> <CAJ-ks9ku=-675naKESOJJxOo0b5BmoH7=76aKZXXmUHM+=ZV0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 11 Jun 2026 03:16:52 -0500
X-Gm-Features: AVVi8CfIDxzf-N0fkJ986h9H7T9uUm5rV56tzt1NOIz0Utx2iJingqHihvYaHGg
Message-ID: <CAOLa=ZSezQOj56-TezVaAcisUyczxhJmu4VghyFBHcBB_mKJ2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: memoize --contains with generations
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008f6be80653f5fbf1"

--0000000000008f6be80653f5fbf1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tamir Duberstein <tamird@gmail.com> writes:

> On Wed, Jun 10, 2026 at 4:47=E2=80=AFAM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>
>> Tamir Duberstein <tamird@gmail.com> writes:
>>
>> > git branch and git for-each-ref call repo_is_descendant_of() for
>> > each candidate selected by --contains or --no-contains. Each call
>> > starts a new graph walk, so refs with shared history repeatedly
>> > traverse the same commits.
>> >
>> > ffc4b8012d (tag: speed up --contains calculation, 2011-06-11)
>> > introduced a depth-first walk for git tag that caches positive and
>> > negative answers across candidates. ee2bd06b0f (ref-filter: implement
>> > '--contains' option, 2015-07-07) preserved both implementations when
>> > ref-filter learned --contains.
>> >
>> > The memoized walk is not always faster. Without generation numbers,
>> > a negative check can walk to the root even when the breadth-first
>> > merge-base walk finds a nearby divergence. With generation numbers,
>> > the depth-first walk can stop below the oldest target while still
>> > reusing answers across candidates.
>> >
>> > Keep the existing memoized selection for git tag. Select it for other
>> > ref-filter callers when generation numbers are enabled, and retain
>> > the breadth-first walk otherwise.
>> >
>> > When generation numbers are unavailable, repo_is_descendant_of() can
>> > return -1 if ancestry cannot be read. The ref-filter Boolean interface
>> > treated that error as a match. Check it and exit instead. The memoized
>> > path already dies on the same parse failure, so both selected paths no=
w
>> > fail rather than return a result.
>> >
>> > Add p1500 cases for up to 8,192 packed refs along one first-parent
>> > history and for sibling refs near the tip with generation numbers
>> > forced off.
>> >
>> > On a checkout with 62,174 remote-tracking refs and generation numbers
>> > enabled, I ran:
>> >
>> >     hyperfine --warmup 0 --runs 3 \
>> >         --command-name parent \
>> >         '"$parent" branch -r --contains c78ae85f3ce7e >/dev/null' \
>> >         --command-name this-commit \
>> >         '"$this" branch -r --contains c78ae85f3ce7e >/dev/null'
>> >
>> > The results were:
>> >
>> >              parent       this commit
>> >   elapsed    104.365 s     467.7 ms
>> >   user        93.702 s     220.2 ms
>> >   system       0.723 s     182.7 ms
>> >
>> > The wall-time standard deviations were 11.356 seconds and 133.8
>> > milliseconds, respectively. Separate runs without redirection produced
>> > the same output with SHA-256
>> > 2466f6e2b72aa16b1a2126eddb81c8a1b2764ee251204ac034c191a925aa896f.
>> >
>> > Both revisions were built with the default -O2 flags using Apple
>> > clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro (Mac16,6)
>> > with a 16-core Apple M4 Max (12 performance and four efficiency
>> > cores) and 128 GB RAM.
>> >
>> > Link: https://lore.kernel.org/git/1445163904-24611-1-git-send-email-Ka=
rthik.188@gmail.com/
>> > Link: https://lore.kernel.org/r/20230324191009.GA536967@coredump.intra=
.peff.net
>> > Link: https://lore.kernel.org/git/20260527070510.3510836-1-krka@spotif=
y.com/
>> > Link: https://lore.kernel.org/r/20260608223430.GA340696@coredump.intra=
.peff.net
>> > Suggested-by: Jeff King <peff@peff.net>
>> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> > ---
>> >  commit-reach.c                 | 13 +++++++++--
>> >  commit-reach.h                 |  7 ++++++
>> >  t/perf/p1500-graph-walks.sh    | 49 +++++++++++++++++++++++++++++++++=
++++++++-
>> >  t/t6301-for-each-ref-errors.sh | 22 +++++++++++++++++++
>> >  4 files changed, 88 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/commit-reach.c b/commit-reach.c
>> > index 65b618959b..83a48004ef 100644
>> > --- a/commit-reach.c
>> > +++ b/commit-reach.c
>> > @@ -821,9 +821,18 @@ static enum contains_result contains_tag_algo(str=
uct commit *candidate,
>> >  int commit_contains(struct ref_filter *filter, struct commit *commit,
>> >                   struct commit_list *list, struct contains_cache *cac=
he)
>> >  {
>> > -     if (filter->with_commit_tag_algo)
>> > +     int result;
>> > +
>> > +     if (!list)
>> > +             return 1;
>> > +     if (filter->with_commit_tag_algo ||
>> > +         generation_numbers_enabled(the_repository))
>>
>> What's stopping us from dropping `filter->with_commit_tag_algo`
>> completely and then doing?
>>
>>   if (generation_numbers_enabled(the_repository))
>>      return contains_algo(commit, list, cache) =3D=3D CONTAINS_YES;
>>   return repo_is_descendant_of(the_repository, commit, list);
>
> Jeff raised this distinction during the v1 review:
>
> https://lore.kernel.org/r/20260608223430.GA340696@coredump.intra.peff.net=
/
>
> `with_commit_tag_algo` preserves the existing behavior of `git tag` when
> generation numbers are unavailable. `git tag --contains` has used the
> memoized walk since ffc4b8012d (tag: speed up --contains calculation,
> 2011-06-11). Dropping the flag would send it back through repeated
> `repo_is_descendant_of()` walks in repositories without usable generation
> numbers.
>

I did read that, my question is on top of that. Do we also want to use
the non-memoized walk for 'git tag' when there are no generation numbers
available or does that not work? If not, we should mention that too in
the commit message.

> The condition in v2 implements the rule discussed there: retain the
> existing memoized path for `git tag`, and use it for other ref-filter
> callers when generation numbers make the depth-first walk reliably
> advantageous.
>
> This is probably my fault for breaking the threading between this and
> v1. Sorry about that.

--0000000000008f6be80653f5fbf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 895c317c50ff9e6e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vcWJ1OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0FPQy85WVpCc0IvZXcyalBxbGpxeERPd1FtYnM0ZQpTZUpOaGZmMEtJ
NVl1UUUrdW1NN1RDMkRZSUpVM1lCeGxuSFFBM0N2bGN6WVYwNDREVWdpbjBBQzZ1aVp1cm1vCmNP
Lzg1OWt6dlBYN3l3TXdkSUFIMTQxaFVSM1E4NFV6N2FlQ1UxYndHQ1JKOE5OL2lTU1huYlRnYUox
cVdYSTMKNXUrVCtUR29iOGJmTXArY2ZyYnB0LzZvOVAxckRpMHQ4ZWF2dmVVb2RBMTU5eDN5ZTlw
WkV1MGY5MlVXeHB2UApNMm1UZktQd2pFanRWY1RkMmlFdE5rbmd1azNNeWlVem1TZ0pRUlc1UDhL
L25QbVcxLzhBOTN0N3E4TnFOdTJ5ClZ2by9FNngvYTJpMnJ6REQ0TUg1d2ZxREJWalY1c3pxVXZl
T0MvUjd5N3lVdTdYbzFpOHpTTS90aFpEcTBhcmsKVThVYUJwb041VlY1UW5ha203MzRZdFJmY0d5
K3Q1RVpsMFJPeWwzbHFnVEpuS0NrUkdnd1hOUG9WdnI4TmhnagpHT3JZRHdOOCtVd3ovWFpCY2lQ
Yk5TTUpPZHFra3RWbmJiZHF0ay9qc2FNelB6MWRPWVlhMTNFMlcySy9pS2lhClNOaU5YU1crd3Vi
R0N4b2U2UFZaSlZFL25jdFNIZ1FMQ0dFSEVZdz0KPUtOYmcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008f6be80653f5fbf1--
