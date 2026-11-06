Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794002589;
	b=IIoz5VSiqMblR7V8ohjU5dtkTPNkhmX3QxFRxJ6bcmtfX+97MrLR6i4yTuWUNnqYPR9t
	 SJYjiZu4/PHEJzrUXWBfYbLYikFTviHYuN2SbPA/jeVQdv6kcx6/3WeCUb/8+NVOXYx9M
	 ReAV+ZgsoirZr1JJjWmxtwy8LCopD/xai7k5iR0GZjaV2E3myxyIQ9OL2najHnsarrSQY
	 8YVYhdSo4r5toT5vuV3dTkIjsqR3Ao92Ktd85Tm6tE6j9j9nJtQAfR8oQwMjWNUf09ZD0
	 IFFlcUjyQ2SQSmisQ+YWRzXebhip8pYfYP6BY69ZXOfogWM01zzY2IrMKLxaYCvQ7/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=r+QCqOKxWOhhY/GIfXxzMY6nwm+/we648G6PGvPZQgE=;
	b=uF1cU/DPsPdGQcqSv8JJ50Ebx7OLbLcdDbPJjiglVoIxkKL41HE5UP/vFjRWr0dUyYre
	 gvdsAPCtIhKOgzVPRqyx/UP6yDmoHYu8zKWT2s+Dy886XAyoXCuNI37Te7viguMCBEP9Q
	 YE6HleSVWC/3yEuge8RLEEROv+VMCEHFZTKS2j7SIgeQxqekVdmHG6qkvcYUG4IUtdTfr
	 kJgDsGtZ3v7vugpZzUdqkcffJNxWef5+4K2fJU5Jdv/yFr0Eju4wJof5Hhg0mnS2kACLq
	 +KWSrfsZglgJTVA/eZPvShwZOm2kk6TXZ5OOxHf10LjsFvD/c5GpldswhDPkxMo3BpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VoBEydmN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B5606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 22:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 617B5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VoBEydmN
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4ad881b6517so716288fac.2
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 14:03:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794002588; cv=none;
        d=google.com; s=arc-20260327;
        b=BjzKnFBtAirnmIdRd42kiGOkgi3UM9N39hq5wraBT/gtLgdqg8UsC5H+VxcEmdhJ8V
         PctzbFeanHhldL+MmWCWeO8+W6aZDMK8TGLPtXkti7uEfR1Ms+vNMpBObRSBKFtfhZlu
         FEJBA5Et6Wy6xMIAW10NMRXihsZOLhqc5/OSCJ3SYjMHGKHTZ+ThwN5OcTW1iMXkAYMH
         7SjIyukF/EcOzVCRarY08JcigteZ7kZ3vrKnDWal3brCkA7I/Y6+BsbK7b20CUmLCq7A
         sgBC1BgZvkUHsIEVcPmzTLpOh9wPaQExCYZmgKDpOKrA+4IPWY5zqRsmGIVtBaXtYci6
         Vc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r+QCqOKxWOhhY/GIfXxzMY6nwm+/we648G6PGvPZQgE=;
        fh=5PFJeBr7a+nhkSJKkBd2FkDf8aw85ThIkZJzXtcSCYg=;
        b=JPkn72wVqUSxI1LYNkF6rUl9uCjE+k4SzU3TukWd4eAREPA4FMpqNSz1ZVWEpmP6xk
         Tul7PenzA6zk/QX80uJ7yDpTQFaT1QJeeb30UlolH0/bVW01Mp1Fwuc7j3/srVFmx4oL
         3/tBcF/ty/Oa8JG+HSMLMzt7A0/K3TcM8QqYWWfm2ebXS3fBtbxbn96KyvjSALYa9xiM
         Q04rr2QIWvrGs565fPALJSoirbxRVMvU4RzhMfDLOdCfZvwgS53OJZvSEjsYMRBnazo3
         D8Jwdn8VPcRKEFQrIhfA8J3ZgwAb29fiZap5ataHA4yVCU12JLr7b5GzlBFpTuf5Wipt
         RuHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794002588; x=1794607388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r+QCqOKxWOhhY/GIfXxzMY6nwm+/we648G6PGvPZQgE=;
        b=VoBEydmNVsx/zS8O9gnX6x/8SMZj5MEpJg0frqvbgzOSC/8CuvvHrJJZcC7+S+IlDu
         y03e5jS2N1KO67oyhglt3CcHNRy2YFkRYrnPEwnboQjzHvvrZYfQu0BAO9gTCO0yoRP7
         zNLzZ+82XP0UABs4bbwIcaWqucOc4dmZBRauiNe3c+9usE51xnDPKjvxZJ/v3JeIbSvs
         CE2h4hsKq93rAJwfNOmooOe5hECRqmOdAd4+KEYqzA+w/tf4S2tdsv/0FrlYnTiS2dEm
         1w56pcRDYIcetDxMXOmUdrU9WEnXEEI6ZYP1T+OZpSGwTvajPqmEv49ylKvx8SJULB4S
         7bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794002588; x=1794607388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+QCqOKxWOhhY/GIfXxzMY6nwm+/we648G6PGvPZQgE=;
        b=SksQybT8WhlxyJQV7pTY+5O1S9LKgkVWCcoXA8GgQPaOPjV4VHR0l4YwhH71FFyfY6
         QlZ1C69PqNb2twUzce4YurKu9azj1NgNKtbaUIw7Cnn1cL2UoR38R1pTyn+tJcjH9zsP
         E/H/EhnUG2GzLU4RIUt4Lgh3RuWMqXHtG5sv2Bd9NyhXNEg5jlF67Qn9A6ZWJ4n9ExWu
         YQ6zToYThYrPlLAxDCZ7Jtx15keCJAipfOH5qSQFAsc7W4NHISa1I28yIcqTmCNOqOjw
         qvb4GDh1UdESPHkcWz15KeKdv1cC9Y8tmw8Xj/ZwaaaaJfjZNUt6PyLNOabZyf/59nHU
         pv9w==
X-Gm-Message-State: APuU4Z9XVjPlLKz5OXZpG9/uM688cCo9PigxmFnMQeEYw4RYv/wv373h
	sf339fr5VNAK9ObvY1ET3WPJWBeR6SxY8HUx9VlM5r1d1DuXdNQ8VivmiMQwZZib4IjVvMuBlCP
	mc8AcUZOE9evfF6wm5n6DYI8P9W4jONEhS1HM3Os=
X-Gm-Gg: AYBFou0Ry000XrmnQhnFDcBlaAwcGCQy0yHBoStnGH0LEu2+h8UKyFa/krl7jHI9WW6
	WINW8yTWvyDWgLxfZaIUp2LbTUJmn9Gk0hLjdGRPe9cAv/55m4sad/rYPPBJO5K7Q4F6Np2erQU
	9GFnDpz4mOJA+A8CdJFpd78uS2S3b9DMx2crNI3zGCvsQD6uXtXOgTKIEJVzzd5OghpKNrygpEy
	NhOgo/8O3quC7ac/qGqtrLwoJZmYg2q3HXPd+NLKWfjFz2iNef/Hk3ZFVlUX/qtedndu5YLuN3y
	QzwxOJUif0a0cXF36TyY6j2hTo30Y+oZE2f7qJ3mQFIHyETmaY3D0tOtFJNHHYvxAfpvTUSqg9P
	O08U8PEBQmHcXGJeJqPFxY4prW3u7mIViiEg=
X-Received: by 2002:a05:6870:16c2:b0:475:e235:907 with SMTP id
 586e51a60fabf-4ad98de632cmr2477916fac.37.1794002588140; Fri, 06 Nov 2026
 14:03:08 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022212903.177261-1-andy.koppe@gmail.com> <20261101230326.3675597-1-andy.koppe@gmail.com>
 <840bc117-75e9-4d63-882e-3831156871a3@app.fastmail.com> <CAHWeT-ZdZ0o=_rPWFPcXqCyc-WV=fzmKVRVx2LetfQzgYkKO0w@mail.gmail.com>
 <f194e2af-cffc-4867-9069-7070c86785da@app.fastmail.com> <CAHWeT-YSK3xFA=Hztr3Uj5UW=L9JcC_0iOa5pUG-WGCpwng9vw@mail.gmail.com>
 <d3878168-95b9-4b4b-bfd8-85d459122e5f@app.fastmail.com>
In-Reply-To: <d3878168-95b9-4b4b-bfd8-85d459122e5f@app.fastmail.com>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Fri, 6 Nov 2026 22:02:57 +0000
X-Gm-Features: AclHuK_y0PHtuTVnU_n-CPu61-tMc4rCXjntl-2pbdsKI5gBiOGpbwTYqw9x-oc
Message-ID: <CAHWeT-ZR=WbR90NZarUqvPLOr3AQBBynp8JL=ZK87Hm=npkQ8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] root refs vs pseudorefs
To: Julia Evans <julia@jvns.ca>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Nov 2026 at 14:36, Julia Evans wrote:
> > pseudoref
> >     A name that can be used like a ref to refer to an object, but that
> >     is not stored in the same way as refs. For example, pseudorefs can
> >     be passed to git-log(1) or git-diff(1), but they cannot be written
> >     by git-update-ref(1) or listed by git-for-each-ref(1).
> >
> >     The following pseudorefs are known to Git:
> >
> >     =E2=80=A2   FETCH_HEAD is written by git-fetch(1) or git-pull(1). I=
t may
> >         refer to multiple object IDs. Each object ID is annotated with
> >         metadata indicating where it was fetched from and its fetch
> >         status.
>
> I found "Each object ID is annotated with metadata  indicating where it w=
as
> fetched from and its fetch status." to be very hard to parse, and I had t=
o
> go look at .git/FETCH_HEAD myself to understand what it was talking about=
.
>
> It might help to instead describe `FETCH_HEAD` with an example,
> especially since we already aren't giving a lot of details.
> Maybe something like this:
>
>   Git has 2 special pseudorefs: `MERGE_HEAD` and `FETCH_HEAD`.
>   Unlike references (which can only contain an object ID or the name of
>   another reference), these have their own format:
>
>   - `FETCH_HEAD` has a list of entries like this:
>     `d4c5f27105ee2e44366d718dbc5db95bbe99c714 not-for-merge branch 'examp=
le' of https://example.com/x/y`
>     with details about what was fetched by linkgit:git-fetch[1].
>   - `MERGE_HEAD` has a list of commit IDs
>
>   These are stored as files in the `.git` directory. You can pass a pseud=
oref
>   to `git show`, `git log`, etc, and it will use the first ID in the list=
.
>   Pseudorefs can't be written by git-update-ref(1) or listed by
>   git-for-each-ref(1).

I agree that the FETCH_HEAD and MERGE_HEAD descriptions are difficult
to parse, but I don't think the rather cryptic FETCH_HEAD example
belongs in the glossary.

I've taken Patrick's and Junio's suggestions, moved up the point about
reading the first object ID, and rewrote the FETCH_HEAD and MERGE_HEAD
descriptions, ending up with this:

pseudoref
    A name that can be used like a ref to refer to an object, but that
    has additional semantics: it can record more than one object ID and
    may carry extra metadata. In contrast to root refs, pseudorefs are
    therefore not stored or handled by the ref backend.

    Pseudorefs can be passed to commands such as git-log(1) or git-
    diff(1), but cannot be written by git-update-ref(1) or listed by
    git-for-each-ref(1). When a pseudoref contains more than one object
    ID, using it to refer to an object yields the first one.

    The following pseudorefs are known to Git:

    =E2=80=A2   FETCH_HEAD is written by git-fetch(1) or git-pull(1) to rec=
ord
        the objects that have been fetched. Each object is annotated
        with the ref and repository it was fetched from and whether it
        is to be merged when pulling.

    =E2=80=A2   MERGE_HEAD is written by git-merge(1) or git-pull(1) to rec=
ord
        the commits being merged while a merge is in progress.
