Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794399856;
	b=JjYcj03kttYuI/ISJkJtsljV14HCw6y3ulJVsbVPmKUFhK3+MBZwXxogY2LNQVwNBKeF
	 OP+C6/XL39qRcYUKhYDcqYU8qrSXQh4B9obzkvXGrfEU0b3tyGTD+bXjhpYMgtSpL/vvQ
	 stARV60+1MBUroIWvYy3Hqs1eLZT4qZC+3X5wFJmt/+8RtngLDtQJQPCqjShBpRPbG4X9
	 mPaYlXcRwLreb08Z8XjBjgjQM+zKJwhF4TplPFyBBHFVu3To260U2gNjMTfxC4yTuotky
	 elLy3MLg2iy+UefF1KNRjP4EgQ3JyYOfTCZ8oI6I4FXdfejLITyIjiabhqUwa4nGzMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4IMPANsr1Anfpg/nr4iPsTOtbV8BZeqgBUEQsR3Hoec=;
	b=Z3Dyc+lla3btfH6KPHiQG4Cqp/hIHU7goJGlHtn6KttPCGYeRdRpcAjX19ywnFouI81/
	 7iF17MCResHtftjXe9RNFxyckUfBXAh0GuYiAAbhW1d1INkfr2f2usJ//4+88pPrKmsz7
	 4gxDz1a1bmTnDRtH/sw/lWqkOGCzpamf2Kt4th1x5noB4KDLxpz8kqpre9hKM1XpoF+EH
	 0m5CLZj2+M3Yx4raI0GKBOr+FxK8uER/3UaunT0zntDFTNwZ5GqavDwHnRMdeEr4yGnWj
	 px7q308fZUTyEY7Zv7EMfdUiqDYcPACGz0IfZMFniF1eduCh3A/4IJkYaul/iDLdozQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=igA+e+J+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D10606A334
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0D10606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=igA+e+J+
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5365d26ccbdso37092711cf.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 04:24:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794399855; cv=none;
        d=google.com; s=arc-20260327;
        b=Lo0QHonEpHrg07UBVoEw9ylHdtJdymLDnk0VKFSJP0bRomK9r7mgQ2XWCgzvvWB7IO
         Bzd2sR1kvyL6AtZHJt5H7AMlteLPFWLE7s7MeQMIvEQU8ai0RhwGJLCep+Zt8d55VZSc
         yOf8jDg3QtcOJwXRrmXaaN7/XhYz4q8oKmPpImbl18woxFj+mHl8OYtLwaolGyZ8VLmW
         7GuZVxMTfra+ImmhtI7qNndXEtCuNiQMsTcmIxsyY9bhiJbzKrRPZA8gHBuLN+4wcQ+L
         PWHKJr3ryqGVIujhq8TAgIGgDbcUk/2g8+IuSxLF/lPoXbgKB2A4TJnfUZkXWvEf1xtn
         JRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4IMPANsr1Anfpg/nr4iPsTOtbV8BZeqgBUEQsR3Hoec=;
        fh=p6jXJH8IKVrQtpskFlO+80Ge4jJ2VqL4fe+j5pdbujI=;
        b=sxPx/BsycyZL6iz6HUFjV7cH+VoVTg3uplzRPk7jnPLCY0E5sb5/6W7apy8yI/CHNh
         RopOC/RYGeVWXXAKwYQTw8XumX1fJNbkDAfk6ed4XGDx37oLYD3Y1cVlx/aVkTT6a6FY
         rUKzY+tZBcKZTU4KE0jBF/T64K+spE/XZfEs0TQ/aVv9NWCKRLWShiQZ8YT0FhwZGVE+
         K9j8whxuLf3GQ7hk1OQGZe5NlOl17yeMmtsXqMBDDoS0Je8GExP5N11aSsXIJroacSG/
         NNFUgzj4jikQAF5DmTi5VNSLg3T1xpYrgmrqoeCW060+poqeZO5lyFYidsdNKGgsm6K+
         +LIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794399855; x=1795004655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4IMPANsr1Anfpg/nr4iPsTOtbV8BZeqgBUEQsR3Hoec=;
        b=igA+e+J+U1grjTeUSH+BasIdz1USrmU/Dgq3K2wj6UL89Yub0KnkeSwYiwh1kprgVS
         a0cbovhZezSQBfdBnXVfNjqrKN6jNrvMMo2TvtIbKcBkw9sDEdSS0dtLO5unNB9v370m
         SPQcabmAKlNo9iPLjnpMre2LM4YQdr328Wh1khiPhXDwui0kT8qLZHFiIJHJ26/GR6LM
         rvuZpjCk7bI3ZNqcPzvdwW7vz09yasfEg+z+W/bJJJbictRhrMkDZYZdoBWLtLxFR6+w
         +DJMNxyBiTU8jt93LKBUIl7cy5sd9E5H53/UpzXLXskhpt+SqkZOsxB997LwntIPzEu8
         lKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794399855; x=1795004655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4IMPANsr1Anfpg/nr4iPsTOtbV8BZeqgBUEQsR3Hoec=;
        b=Khj9TT4bRW/MmT/692Cks5ARGQyF/Sn52gkDhiAlO4v7sssVCTgo8+G4A4u0dPWVEM
         PRpGUKJkEjaeVAWzycnJOQQRTA6T3FG9zAOwI91NoHua4o23crsXax7uoeCn9FqKhZL6
         a8yr0yOMLDDlvF6we3q2JBYxw0/thlLTiIht2R6CeuXCeKA5NRs6VXZFfYXnB7ToRxXq
         qirOSywoLE4y7z0DTrZ/cP/TbqJf1P6t2jwUbiKRtQnNKEmi4kdGA5VsnONsTuGgfKnk
         nevdwnc6GWY80CoQFvFQRhDv7+gL0fp01gQsCcFIcotEyrBUsPJBFjYqEr3PslNYQWHB
         rf6Q==
X-Forwarded-Encrypted: i=1; AL+hErHGg8beEQVUayUQTsVZVfdF56Q+4iGrmaKglGE4/EQOaTpxplEMhjYxvIJt1P2r2BMniBo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RGF76NrRJf1uyaknIheh1sB5cIppM5RRrBUIdbTMcmHcIAWIh
	tbq+7GnyQpqEhaFxuuclKMrWG354Xh9jhIjgWobOQLCP19c2QAqGGCnOQKSkkxjxOjiZB+TDY2p
	7cxQwYW5M0aV36ejjMBuIZ+5hT2mcbVg=
X-Gm-Gg: AYBFou0hs0UkAT7wM25uZ7ZNCkoOFkaoJ1khZ2js8ykSUfPgONcQnRO4OkmSi7DK4TH
	cjep3j2Uj0INOsp2V7xJG2ACQhbkA+yIqtjxKmd3mr8Nx3Gbbv4B0g7bir7rLfPeUq1wTogzkl+
	WJoENh2It640dOSNTuIxeVezYwYfIMw/OOkY47kxfaLJIVV1R6zhegRidie3Q3jf01yEL8Gjvif
	dvG7qsFMo15DgsBYChg5plgiw7be5iA9EoBXHqoVqZBIWqaH75USmVH/fffV4qQ/Ga8VIyqTyxv
	MvjnTYU0nWZ4R1hz6vstcNLv/Hgmp2Ery5zrDsReObrhJEBBm1FOGBNC6UsocxdhQHOFLTtlxfo
	2BFG4o02XmQIpy/BNmUc1nP81LUdKo5TORt8ZSflO6ZNLblA+Zu3Q89aFZ5LtBdcsPyXET3Gzad
	HalPKPJYY7l34tg43Am83Br/05lEBKgefr+ooqsQqCNwMCdf7PQ+RrINwS
X-Received: by 2002:ac8:5ac2:0:b0:53e:35dc:9be6 with SMTP id
 d75a77b69052e-556c1b5ccfdmr31446261cf.62.1794399854698; Wed, 11 Nov 2026
 04:24:14 -0800 (PST)
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
 <pull.2305.v4.git.1794385537870.gitgitgadget@gmail.com> <CAOLa=ZT7xKFf5_Q5hBfstyeXfTA=TDfzS-Z7mig18rZLgLKefw@mail.gmail.com>
In-Reply-To: <CAOLa=ZT7xKFf5_Q5hBfstyeXfTA=TDfzS-Z7mig18rZLgLKefw@mail.gmail.com>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Wed, 11 Nov 2026 17:54:00 +0530
X-Gm-Features: AclHuK-HSebthfpStVRSyBkJZLbGSlfHIaz6eZiML6r9keJzFZjpY_HHaAQZFfs
Message-ID: <CABh_KWg+v7Pme=7n6_MPjxBOVpX9BHbajKB10cCASOo0p1uNKA@mail.gmail.com>
Subject: Re: [PATCH v4] archive: remove USE_THE_REPOSITORY_VARIABLE from
 archival modules
To: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 4:38=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> > Refactor archive-tar.c and builtin/archive.c to clean up archiver
> > initialization order and header dependencies.
> >
>
> Please read the 'describe-changes' section of the
> Documentation/SubmittingPatches. This message here doesn't explain
> anything.
>
> [snip]
>
> >  archive-tar.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/archive-tar.c b/archive-tar.c
> > index a1c66024d4..1b376d048a 100644
> > --- a/archive-tar.c
> > +++ b/archive-tar.c
> > @@ -531,11 +531,15 @@ void init_tar_archiver(void)
> >       int i;
> >       register_archiver(&tar_archiver);
> >
> > +     /* Set built-in defaults first so user config can override them *=
/
> >       tar_filter_config("tar.tgz.command", internal_gzip_command, NULL)=
;
> >       tar_filter_config("tar.tgz.remote", "true", NULL);
> >       tar_filter_config("tar.tar.gz.command", internal_gzip_command, NU=
LL);
> >       tar_filter_config("tar.tar.gz.remote", "true", NULL);
> > +
> > +     /* Load repository config so user settings override the defaults =
above */
> >       repo_config(the_repository, git_tar_config, NULL);
> > +
> >       for (i =3D 0; i < nr_tar_filters; i++) {
> >               /* omit any filters that never had a command configured *=
/
> >               if (tar_filters[i]->filter_command)
> >
> > base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
> > --
> > gitgitgadget
>
> So the code only adds two comments? Which isn't what the message
> suggested at all.
>
> Taking a step back and reading your previous commits and messages seems
> like we're talking to an AI model. I'll refrain from reviewing further.
>
> Thanks,
> Karthik

Hi Karthik, Hi Junio,

Thank you for catching this. You are completely right=E2=80=94the previous
commit message described refactoring that was not reflected in the
actual diff, which caused a clear mismatch between the message and the
code.
I apologize for the confusion and for sending automated-sounding
responses. As an Outreachy applicant, I am still learning the Git
upstream review process and workflow.
I have amended the commit message to accurately describe the exact
changes in the diff and force-pushed the updated commit.

Best regards,
Srujith A Poojary
