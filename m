Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3FE159576
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975930; cv=none; b=O+ocsePZhv+CXj8gM41F1U9zyjQ3zvW3tGU7ZRE6D/HUbgtL+/t686aID8bxLTMPQ7iLPon4do5X8LBWAhyPhRj3IEMdRbHfQ81yyRu4qdrz2WSVniqVDD0CCEiqaUYxiU99fg7vf0WhvsoHA4GaI6gfAsx5BKWJdsPahN9vmOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975930; c=relaxed/simple;
	bh=PeTI+0Jokt1ZgypxnzTyl1pDpICrrqXc2p/XYCohs/0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZK57yy/C/7jmIzxH5PKOAZwrLzLy8H3IUutYP8QoEJAow0KL0whhIVSkJewS6k1HwjCfaj+A3/czt47YVqMxIo+1NSqQ76Q/PlCQC+KWtEGCNkKyt66EhqmOLIFuIPdQCvzTq8Dp4mmN61fSSVfx4gfx+eVUyTXh4MkH6/xRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkVQ6JUm; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkVQ6JUm"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22f746c56a2so68605fac.0
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713975928; x=1714580728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ojWHwU5agzZtfk/ZlNA9YvGPTYpsBihWphqtUfXPZk=;
        b=SkVQ6JUmWqJmg51irMdEujSuCNf0W3z7UTnivfH0t3rNhprVFcuDUk7V4ZH6lPfe8b
         mtiQ0VpOd4ObLDDCIBm5QnaYKvjg5j75ww6v/na/X9SEbrs7/VgDDL3JeaefQlqcN+DF
         3occOHnPAopaJ5LaU5anQxV412dNcpwR76zQS61vtKW9rJtRfdgctVUF0HdIbGXkG6A1
         rYrldQ0ET0xU2pk/YWF6nr5kIcFq9PlT4MAqdfJ9SRbrxqCFL+WvFLcb8S4QiiAauJEe
         gW8B3aOn4iYpWeca5TO7QUNh33yFpX9hTfwHHtf/NpjJDaUEC4d1b3+3k8UJOLgThI3M
         wAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975928; x=1714580728;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ojWHwU5agzZtfk/ZlNA9YvGPTYpsBihWphqtUfXPZk=;
        b=bdZ7kagSCGCutD7J11y8kmp+uHavectpYpd2W0tfuEaMCKBe4OdCBvoLuVmFUK+fyq
         u/Bj8NzgXk40DSu3VtIzEbGA/KqOsFZTIx6d/z1+u3pG+EDdW5gODDjkmpjFvufJCieH
         slV4uhHocDRVbuYHtDogy1a96+f+5UWDhrTRf1qbj2IPR+gSvGpHR/dho3e9tGEgm9A8
         oC+7zH99QHiVUCBx+nu/d3DUY5/B/rgh5nNqJecuh5/4WJrhvFEJPLSw59PFDpS5reJw
         e4wBiHeFQPWAl3hTTPp0mG8aPVy/SzkXnwvXg4ROWy+JtyF7Rpx7hQVx2A7OlTP9IMUn
         n7jA==
X-Forwarded-Encrypted: i=1; AJvYcCW+4b3X5zaCTiKWyi4Z1SBsmU4EWNgvIWhU9DhnxaBjD4gU+nvPSRoJHzo9oq4fPFukX3NTMaYqqZe+4nYAKnTQS8lb
X-Gm-Message-State: AOJu0Ywq4mnKtkuMM/n1kOJ0QYy/i6WaLyZUCuO1aO70vvMtI83Weo6j
	qxMG6Io0v0ZGnpzGkAUC8hHMur861gMiaG1+FBASMrqMvna+yp/z06EnMK7bcmlZxWuTXnMT/nl
	PzaCGr6B9mdOfnFjGM1N+Hb9vtDfITA==
X-Google-Smtp-Source: AGHT+IHB+Lk/av6Y9e+0hz2ZjNtCHe1e5/Uq4cQXxWIKloz5D+JZ8O8SMBYf8TqyiwCOLYFn0YXFuvglmOvwD7uKXcs=
X-Received: by 2002:a05:6870:8929:b0:232:f991:8fc4 with SMTP id
 i41-20020a056870892900b00232f9918fc4mr3766201oao.46.1713975928182; Wed, 24
 Apr 2024 09:25:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Apr 2024 09:25:27 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240423220308.GC1172807@coredump.intra.peff.net>
References: <20240412095908.1134387-1-knayak@gitlab.com> <20240423212818.574123-1-knayak@gitlab.com>
 <20240423220308.GC1172807@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Apr 2024 09:25:27 -0700
Message-ID: <CAOLa=ZRk8QR4qkbkRm6AirapdrAqz6bG-tXfY3zRQU_9XkJM1Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] refs: add symref support to 'git-update-ref'
To: Jeff King <peff@peff.net>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000005a75390616da1e9e"

--0000000000005a75390616da1e9e
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Tue, Apr 23, 2024 at 11:28:10PM +0200, Karthik Nayak wrote:
>
>> Changes from v2:
>> 1. We no longer have separate commands for symrefs, instead the regular
>> commands learn to parse 'ref:<target>' as symref targets. This reduces
>> the code in this series. Thanks Patrick for the suggestion.
>
> Hmm. I can see how this makes things a lot simpler, but it introduces an
> ambiguity, since you can pass full ref expressions to "update-ref" (like
> "ref:foo" to find the "foo" entry in ref^{tree}). I see that you only
> kick in the symref "ref:" handling if the regular oid lookup failed, so
> there's no backwards-compatibility issue (anything that used to work
> will still take precedence, and the new code only runs when the old code
> would have reported an error).
>
> But I wonder if it would let somebody cause mischief in a repository
> they can push to, but which may get updates from other sources. For
> example, imagine a forge like GitLab runs the equivalent of:
>
>   echo "create refs/whatever ref:refs/heads/main" |
>   git update-ref --stdin
>
> as part of some system process. Now if I push up "refs/heads/ref" that
> contains the path "refs/heads/main" in its tree, that will take
> precedence, causing the system process to do something it did not
> expect.
>
> I think you'd have to pile on a lot of assumptions to get any kind of
> security problem. Something like:
>
>  1. The system has a hidden ref namespace like refs/gitlab that normal
>     remote push/fetch users are not allowed to read/write to.
>
>  2. The system tries to make a symlink within that namespace. Say,
>     "refs/gitlab/metadata/HEAD" to point to
>     "refs/gitlab/metadata/branches/main" or something.
>
>  3. The user pushes up "refs/heads/ref" with a tree that contains
>     "refs/gitlab/metadata/branches/main". Now when (2) happens, the
>     hidden ref points to user-controlled data.
>
> That's pretty convoluted. But we can avoid it entirely if there's no
> ambiguity in the protocol at all.
>
> -Peff


Thanks Peff, that is indeed something I totally missed thinking about.

This also brings light onto the previous versions we were considering:

    symref-update SP <ref> SP <new-target> [SP (<old-target> | <old-oid>)] LF

There is also some ambiguity here which we missed, especially when we
support dangling refs. If we're updating a dangling ref <ref>, and we
provide an old value. Then there is uncertainty around whether the
provided value is actually a <old-target> or if it's an <old-oid>.

For non dangling ref symref, we first parse it as an <old-target> and
since the <old-target> would exist, we can move on.

So I see two ways to go about this,

1. In the symref-update function, we need to parse and see if <ref> is a
regular ref or a symref, if it is symref, we simply set the provided old
value as <old-target>, if not, we set it as <old-oid>. This seems clunky
because we'll be parsing the ref and trying to understand its type in
'update-ref.c', before the actual update.

2. We change the syntax to something like

    symref-update SP <ref> SP <new-ref> [SP (ref <old-target> | oid
<old-oid>)] LF

this would remove any ambiguity since the user specifies the data type
they're providing.

Overall, I think it is best to discard this version and I will push v4
with the older schematics of introducing new commands.

I'm currently considering going ahead with the [2], but will wait for a
day or two to consider other opinions.

Also on a sidenote, it's worth considering that with the direction of
[2], we could also extrapolate to introduce {verify, update, create,
delete} v2, which support both symrefs and regular refs. But require
explicit types from the user:

    update-v2 SP <ref> NUL (oid <new-oid> | ref <new-target>) NUL
[(oid <old-oid> | ref <old-target>)] NUL
	create-v2 SP <ref> NUL (oid <new-oid> | ref <new-target>) NUL
	delete-v2 SP <ref> NUL [(oid <old-oid> | ref <old-target>)] NUL
	verify-v2 SP <ref> NUL [(oid <old-oid> | ref <old-target>)] NUL

This is similar to the v3 patches I've currently sent out, in that it
would also allow cross operations between regular refs and symrefs.

--0000000000005a75390616da1e9e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6c24a7d60162490f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZcE1uVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0ZOQy85SEtMeEllVjhEUmhQaDhJK1hFTWUweEFOYgo5Ykt1V0xkazNS
YktpWHpuN1BBaGlabUs1U0NPRXdjZjVSaVZzKzBUR1J0U0xveWo1MzVMZ3Qva1BaZjk4Y3RDCjNx
QWx3U1NyYUtZV3dXTE1abjRtUGdZUVF5UysweGhCRzVDUmFvVEhWaER2bUNTeDBHaUV3VndoQzBt
SDREMisKa0ZxQ1NiVHcwdE5YeENjWklVMUtxRjd4S3ZvTVBNdTcvbFI5emdhT2IwamVRbVEvR1FT
eXQvaDlkaGcrUHgwQQpnR0dENEo3TGYxazlpOXZTWVlaUlVCd2xDZU1YbkZDaFRxeTVJVUE2Yys1
SUtYbkhzdkRHK3NRSXhYM2xkeVNTCnZ1TFdtODBuMVYxVjlWOURJTDRkYzAwVU9uaVlpaC95bk16
S3czK0M3THRxZkdIK2hNTE9sMXE2cmpTays5cEsKbkUrUGE1ZGlXdDlhSTRPOGIxK2ZKOXprSHpS
dzE3Ykd3eGdNUC8rS0cwUU5OeVVLclRWVERWeHZXZG9KczhsRgoxR09rMWVrRXA3MEs4bDN2cVJj
cVJaWk4zUlA4STV6WWFkdk90MlErNWFUZ09ZTDNubHp0RGdVYlBQQ3d1OTE5ClpPR3E0bnVPRE5y
bkhWZTBRQmlXTWd0OXF5UFA4bnZPQ2IvQ2FUOD0KPUlVb2EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005a75390616da1e9e--
