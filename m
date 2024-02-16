Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F219DF4E
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049866; cv=none; b=ct+pPA63yXhoYZrp8BT4DzefgysgQ8j9OQRRN5Em01RcMa7iIS+vMIdQ+FwZMfOYo6a0abD1b6YKEhwBxfcz1252N0kq9sgPrJ/QdBn1nyoePZLNV2R3uE34h4rm+Trumbh7db1Rj5h5Ph56ZxGpT+t+rX54UtQubmTf7zG1v+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049866; c=relaxed/simple;
	bh=b6Y2ZbcLv64GhjnBYnPieIQBadlCqBVFxlYS5vPDOMk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sVRccW2LGYTNS23KVEIqeQxKzNXvYAZ4cNffLjhNd1eISNi+j8lX6+GVORvYtvHSPSo3NXTxFrbzyyyN89NYE9YfP0qg+/EqOfuvKnwVeoR4R/U3KTa0ESTOJ70uZgjOq2mQQsVwBi+D9iCTCU3MAR4r6krflu+wlH0ynEQ9vEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/U77um0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/U77um0"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1db90f7b92bso12820455ad.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 18:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708049864; x=1708654664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImelUVFK9T8mipwnsGonyq7tQ0cssaA4LxnuEzuelgo=;
        b=C/U77um0aeEp+Z6834QpQL1ZfllBZmwkQiE+ClmA+bN+7F0bcncMkOeVUfSXhOO3dP
         V1g1oQCFMXvqpS7Da7ov7TQydjy6z6/J9cDKJAivfpQo9LouSi32edtyQgECu6HxoDdo
         4kAGGPz5z5F8s1d/W7v8iQoqo8M0ailnNyQ0YWa9DTrdW/OczfP+1PVIq0W9UUcNWJXR
         jeZJsYqDHtUuhHoEYz2MAzAcsXwk5DNSodM8VJdqAEkG3yZUZ3qmo51vzHQFIyg13jYJ
         xMdFYZFea0UgWXchqb58CMVB7SkyYwtX0BNTG7+kbvm++eFlYH83wSlNWLc2+VhOOex/
         pfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708049864; x=1708654664;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ImelUVFK9T8mipwnsGonyq7tQ0cssaA4LxnuEzuelgo=;
        b=VGHuqSaWX4d4FAnEQIsGMws8bVr6o5SAr3Wq8O6Gi3eTWTniZkCaQ+FcAgKDFk5BBd
         bIA1KX0sl1uV+3HE5GTfya5tg4hPUHI8xQa1nDbScIpuERuJmUvwapudecFgrP2CV7hJ
         ovbvz0r31AU51PTOPeD0gJJFBiLfkbdUOFIWBj2/dCfpAvrevNrIdkLhjzezP83rjdvY
         Foz9zNHEP7CWDXU2NPjKrMI5cAkV8MqxN+f4CZbCxrOe1LAU0zlzGW5JJ7HOwoxcC2JT
         nx6djePRAAytZUxEbag5RjPvMZxp0fy2uY8tXktwhCr7GZnKboMRi8qxpi+aENifh6cE
         fB4w==
X-Forwarded-Encrypted: i=1; AJvYcCXswyIo0qBiCFktmORhyKpVdspEchN8H1ywov/CbXc7bCu68kih1Y/RbhxaoiF8rBNFm0XNDv5vt/6xGUWuvTqBv3QF
X-Gm-Message-State: AOJu0YwYpVvL+htV9OdxUT6WaVFkXe7TKYfjTL/rg50GreKLF+Jyqejh
	MMCro9ehGD+PlG2la1EYw/HGIiV16QsOoJGXekF29nUiw1Uxby8GFLmw8J2s7XMGXAdfLjn5gT0
	cdw==
X-Google-Smtp-Source: AGHT+IH5eZiL1QGiVra8JRBrjlOXXIEZMwnDLg0IaY4v58kJvHdtqSG72xyKlFKuF5h3irJya/RacTffqKo=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:ec87:b0:1d9:b086:3a7d with SMTP id
 x7-20020a170902ec8700b001d9b0863a7dmr31824plg.6.1708049864403; Thu, 15 Feb
 2024 18:17:44 -0800 (PST)
Date: Thu, 15 Feb 2024 18:17:42 -0800
In-Reply-To: <CAP8UFD1vue6Pdh5rccibyPs179FYxRDS2-pDzOmTzF1vhTE-sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
 <owlywmr89ms9.fsf@fine.c.googlers.com> <CAP8UFD1vue6Pdh5rccibyPs179FYxRDS2-pDzOmTzF1vhTE-sg@mail.gmail.com>
Message-ID: <owlysf1t8855.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 00/28] Enrich Trailer API
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 13, 2024 at 8:39=E2=80=AFPM Linus Arver <linusa@google.com> w=
rote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>
> [...]
>=20
>> >> Thanks to the aggressive refactoring in this series, I've been able t=
o
>> >> identify and fix several bugs in our existing implementation. Those f=
ixes
>> >> build on top of this series but were not included here, in order to k=
eep
>> >> this series small. Below is a "shortlog" of those fixes I have locall=
y:
>> >>
>> >>  * "trailer: trailer replacement should not change its position" (If =
we
>> >>    found a trailer we'd like to replace, preserve its position relati=
ve to
>> >>    the other trailers found in the trailer block, instead of always m=
oving
>> >>    it to the beginning or end of the entire trailer block.)
>> >
>> > I believe there was a reason why it was done this way. I don't
>> > remember what it was though.
>>
>> Noted. I'll see what I can find in our commit history.
>>
>> >>  * "interpret-trailers: preserve trailers coming from the input" (Som=
etimes,
>> >>    the parsed trailers from the input will be formatted differently
>> >>    depending on whether we provide --only-trailers or not. Make the t=
railers
>> >>    that were not modified and which are coming directly from the inpu=
t get
>> >>    formatted the same way, regardless of this flag.)
>> >
>> > It could be a feature to be able to normalize trailers in a certain wa=
y.
>>
>> True. But doing such normalization silently is undocumented behavior,
>> and we should provide explicit flags for this sort of thing. Adding such
>> flags might be the right thing to do (let's discuss more when this patch
>> gets proposed). FWIW the behavior I observed is that this normalization
>> only happens for *some* trailers that have configuration options, not
>> all trailers in the input. So it's a special kind of (limited)
>> normalization.
>
> Perhaps because we consider that having some configuration means that
> the user consistently expects things in a certain way.

Yes, this was one possibility I considered after sending my reply. If a
user has gone out of their way to configure something, maybe they do
want things (for those bits) to be normalized.

And adding a flag to disable normalization seems like a good feature to
have also (while keeping the behavior of the interpret-trailers that has
been relatively untouched since its introduction). But anyway I'm
getting a little bit ahead of myself.

>> >>  * "interpret-trailers: fail if given unrecognized arguments" (E.g., =
for
>> >>    "--where", only accept recognized WHERE_* enum values. If we get
>> >>    something unrecognized, fail with an error instead of silently doi=
ng
>> >>    nothing. Ditto for "--if-exists" and "--if-missing".)
>> >
>> > It's possible that there was a reason why it was done this way.
>> >
>> > I think you might want to take a look at the discussions on the
>> > mailing list when "interpret-trailers" was developed. There were a lot
>> > of discussions over a long time, and there were a lot of requests and
>> > suggestions about what it should do.
>>
>> I confess I haven't looked too deeply into the original threads
>> surrounding the introduction of "interpret-trailers". But all of the
>> changes which I categorize as bugfixes above have a theme of
>> undocumented modifications.
>>
>> While working on this (and the larger) series around trailers, I only
>> looked into some (not all) of the discussions on the mailing list in
>> this area. Instead, I deferred to
>> Documentation/git-interpret-trailers.txt as the official (authoritative)
>> source of truth. This is partly why I first started out on this project
>> last year by making improvements to that doc. And, this is why seeing so
>> many edge cases where we perform such undocumented modifications smelled
>> more like bugs to me than features.
>>
>> That being said, I cannot disagree with your position that the so-called
>> bugfixes I've reported above could be misguided (and should rather be
>> just updates to missing documentation). Let's not try to decide that
>> here, but instead later when I get to introduce those changes on the
>> list, one at a time. Thanks.
>
> Yeah, it might seem like undocumented features are bad, and I agree
> that reading original discussions can be tiring. But if the latter
> makes it possible to fix undocumented features by just properly
> documenting them, then I think it might just be the best thing to do.
> Ok not to decide about it now though.

Thanks!
