Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794370766;
	b=e8VNMEmDy0qSLiuKOuE+fWHH5MtD6Kcp/pZzOaTrNzn5o1J0tZtBfhpBV7xLhxrdxO02
	 vytCZxQIy0+p69wSVb17vqcL7cb7ftrI9Wtlm2wIKx9Yy7U1QUzdCw3tDcEEJPv2WZAP2
	 bKogQ7H5334C0PEzxyFwS1oopQwVl3cRc/BheJB1DVRBxHTO87XzaEh2C926Dj6HRzS39
	 VD9h3CmRsjGxo19ymQdIzQ1xgPVhhtPuF4W/8nrS44fbJfDaiPoDmj2tKvZ5AvkHOytfE
	 hzuxxwKrvF15z8TDVDjgI7HnIuvPewelGk9HO6mzJVlR9ZYBc6gzAOnJbcpVKKiI8uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/+KBQili/EFKsCTg2/JHY6rLA7fYyQOXJ56W3hSPG1w=;
	b=LMmLLqAmTFVqAKje80U3RRXfkDIYFgDwqqtYAMy/mFZQOXz5TUMECBR8E51u+vYHhfbF
	 w3wV5G1TxpOTejTAShnCxRFzhXymmM908r3ywgbn2RpjDYzFkhy26oSdqLIo8NeKSgId0
	 ZuGBu4NZlV6jkBaQbw4DJryrZE/tNI28p8bjVfZgQwfG4Hq5AhFX3UEgf6KSCzfBoFEzc
	 VJfAe5nZVv33+fdmwTTP8tQJAbYg0qQsWpGVsQjBczdkr+VV58Irm1LY70lOIAf+dlDRU
	 HlKqK43HTt8g9TiWaCEtKeMcEqV+A8neMQEtyFm6i0nKp3y5VmmDmw79uRnPjci9ZBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="GdmnYr/E";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97360A2605
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 04:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A97360A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GdmnYr/E
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91eed03da8bso25392446d6.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 20:19:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794370765; cv=none;
        d=google.com; s=arc-20260327;
        b=qZ19VEFnRRniU03Gumx4s4NmUJSMO/cZlf2TS3FPPbxKYv8+SWW0nrr4R4vGsHGCne
         kezoz3hhqESZzfPactFDcOl7FdCOrS/CODrsDRsAOBkxwrinKc5ugM8EWj/MsSr7irfb
         mj+T8B5KU/2UWXa4jMoeebs6rwUYGoUg77CI7DbSNiNOnLXUW8h2KHuTnIGuQE/2usRP
         zbHuP9cugammZR92eX+B1XsJ8KksH/H3hCPvXfu2CAv2lmqwY0SKYT8Pa1TraSxcQ6Ca
         tMagMQx0pssLka52P1CulMUUEjvtbtQkZ4EpCfdeX9/kv4L1hUK2rUWmFTR9J6dd0eLx
         9HEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/+KBQili/EFKsCTg2/JHY6rLA7fYyQOXJ56W3hSPG1w=;
        fh=vc8A9nqbIdemrkHFbmq41xkwsE51BD5MLr4/N3TcE5Q=;
        b=XKGdQmfuoM/AVA/CvA1inCFYdbDFRMM9D9pjvuuFb4fomERwckUMSYnqtmPC0E8kaQ
         tcSXx8Lm6aOpj5NSTFDMSP68zYP8FGNE/9g9fSbdDrCOdOhN6XkgoMt82u6YzHiDIs8m
         ZADPZnZLYmv0WyI+0DBtczv/8ShOH44XZaO/tLCGr2mCs+4yuKlqRcevfHq8o9yFQqug
         +oCH597PGFAGD49JhxP8ugKQs1yolXBf9emOJasdOrNxK/USWZhTGBKP+c2QhUvjNQ7T
         4YEt3Kd92EraTwdxm55aFiauKRXsplSZKrF+3QpT5/ROeE4PyiJu8mlxkS2AklFKo5H9
         /Juw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370765; x=1794975565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/+KBQili/EFKsCTg2/JHY6rLA7fYyQOXJ56W3hSPG1w=;
        b=GdmnYr/ErLJ/QpriNYmm5Av+xZEqlmoeBVzW0qyiF984cVSxkM8FXvV9NtWRlIDoGX
         vVsgkY3qtMUkrpxDApNxGrGYzFQdeEG24WyPSx6oh9UCVMvBh3s+fKkXRORpn07tPuZu
         /COhoVcGnuRYqaEIqjieVqISTVdaKTIuleUtivnl0Ke5AFB4L1H1RveOVQ9V1mzkpdAU
         n0++7oElruxLFmuBjoOsBwYEGRj4xcICihgUDVx+0kwo7KNAzPkCTUYsq+3iob+tt7yG
         IFiHw+9/zyzSnjQxKN0+zTF7jcKyqbUwdR7f4kpFcXLGqlZ27Q5rxu8QwatN2zuSfx/D
         v6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370765; x=1794975565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+KBQili/EFKsCTg2/JHY6rLA7fYyQOXJ56W3hSPG1w=;
        b=MyoR7CT5P3qEaKlC/NGw8zfOZemfTbQelgAhmd/bgj0U9I9DAblTT1iYUWnjl5OaOH
         ICeuZzGxv30pw/GKGskPjHLCsF9tcigK2PgEqPlpD2Sva2vq71t0sGIwzeGEG9loRQFM
         jUGnAvv2j8Cbt9WSjwc4UPeL2luUoxVPa+U+S2O4lSvZeLKjsw6mwOJIYMMZySwChZ7a
         wE7CXkYS+CgFb6gBCUmjjwCixK2XB+GZJs5AQu0OqO3CKeulTbvK8jzdhXvYLf/zy8pP
         F++RjV++gI9MMToRmoF1HLUkxVLTNDY7RWki5mDMiFm/n8rjAW6jMhmPYR2QG4/WEWMK
         /4gg==
X-Forwarded-Encrypted: i=1; AL+hErE+XQWgBerzDAqTKEsP/3gZI3fez21ciKpW4XFG3E0Qsm/vYhf5kG2fqcuw63N71rP59ZY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kxFDZEkG2oLkq1rUSBMhrAylAgYW54EOCwg4/JUrRW5Dbp1ge
	Xa49bOf8huLE9E7c548hRQ/znIkoiFx5yWQAEKZEqlHIO8cVTIwJuWLa1rpBIxLD+UgP659SWlV
	OBzet2n97Flum+g2htwXXY/PIsOPagnLylbHK
X-Gm-Gg: AYBFou1g8ru1xN+DpB7hcKMWaH0/MbZbF3arhtTt/8ZqiygIxEAZfFAMlm7M+u+4SLh
	IBYnsl4twPECXan/KTNNUm+EcSHE2Hnm5/utFnBA+DYWbRfmFIW1DPwi/b6JvwUr1wxqx47Dm28
	W7JJ1Lb5aGTt67tFhufZCTZGW6DnueCnEhzaeyhpWkbyIo65R4mck5lx5Ckk++PgX3QjpCZ5TdH
	qM7E5XmAIhH/QvZOWB32I3nSRG8OjMbnx4fGcfUO52N5DvTw6lBTnePRJHZP65Yk8GsjpBFJVLK
	V427qLT+UCiRUpgNP8bXhnyDud8P99tvvr3w97FMlP4XyhUxMYl3Fhl15pxVVIN0EA7SkVUVb5J
	34yn5rJDAYeUXjWJ2bdJYOEtMcw+rnxa7bZWbGoBC3VJ6XpXLlVNpaGUvIdioQaSHjJ3QZWoOOK
	pbTJuJGWB+Ky+lTm/iS1C7mfiCqqU7v5nNCAUni3juFGL6/n3i3o09FWY/Sw==
X-Received: by 2002:a05:6214:19c2:b0:917:91bb:c63d with SMTP id
 6a1803df08f44-91f0415d811mr21857076d6.38.1794370765130; Tue, 10 Nov 2026
 20:19:25 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
 <pull.2305.v3.git.1794335969.gitgitgadget@gmail.com> <01c3cc25738c43d61aff153805e02db872ff21de.1794335969.git.gitgitgadget@gmail.com>
 <xmqq7bikqvpm.fsf@gitster.g>
In-Reply-To: <xmqq7bikqvpm.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Wed, 11 Nov 2026 09:49:13 +0530
X-Gm-Features: AclHuK8w4hQRkpQVrs_IDumu1kz_-sFa6wG3In3cPuKMErb-obrGUTke-e9CP68
Message-ID: <CABh_KWjYc15OJjdZQPFPhLO0VRFhY4VJEgYxVaJoGRK284wiUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] submodule: use the submodule repository to
 abbreviate commits
To: Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 1:56=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/submodule.c b/submodule.c
> > index 6fcb606f7e..1302c11ddf 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -543,6 +543,7 @@ static void show_submodule_header(struct diff_optio=
ns *o,
> >               struct commit **left, struct commit **right,
> >               struct commit_list **merge_bases)
> >  {
> > +     struct repository *repo =3D sub ? sub : o->repo;
>
> Let's step back a bit.  Use of any repository other than 'sub' is
> wrong as a way to correctly find suitable abbreviation of object
> names in the 'sub' repository.  Now, the variable sub is NULL when
> the submodule is not initialized, in which case we won't know how
> many hexdigits we need to abbreviate "one" and "two" to, because
> there is no repository that has any object from that submodule to
> begin with.
>
> > @@ -599,9 +600,9 @@ static void show_submodule_header(struct diff_optio=
ns *o,
> >
> >  output_header:
> >       strbuf_addf(&sb, "Submodule %s ", path);
> > -     strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
> > +     strbuf_repo_add_unique_abbrev(&sb, repo, one, DEFAULT_ABBREV);
> >       strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "..."=
);
> > -     strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
> > +     strbuf_repo_add_unique_abbrev(&sb, repo, two, DEFAULT_ABBREV);
>
> And that means the above patch is an utterly wrong rewrite, isn't
> it?
>
> Because using o->repo is just as wrong as using the_repository,
> replacing strbuf_add_unique_abbrev(), which uses the_repository,
> with a call to strbuf_repo_add_unique_abbrev() and using o->repo
> does not fix anything.
>
> So when (sub =3D=3D NULL), the code probably should just grab the first
> DEFAULT_ABBREV hexdigits of one and two and be done with it.
> Guaranteeing uniqueness of the abbreviations within o->repo does not
> help anybody anyway, right?
>
> On the other hand, when (sub !=3D NULL), the rewrite in this patch is
> absolutely the right thing to do.  Thanks for working on it.
>
>
>
>

Hi Junio,

Thanks for stepping back and explaining the root issue with submodule.c.
You're right=E2=80=94when sub =3D=3D NULL, o->repo doesn't hold object info=
rmation
for the submodule anyway, so querying o->repo for unique abbreviations
is incorrect.
In the next iteration, I will update show_submodule_header() to handle
sub =3D=3D NULL by using the standard DEFAULT_ABBREV digits directly
without a repository abbreviation lookup, and keep the sub !=3D NULL
logic using the sub repository.

Thanks,
Srujith
