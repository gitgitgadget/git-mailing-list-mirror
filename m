Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC737F8B1
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769689372; cv=pass; b=iJXWWLch67/X84LiWPOpZVSK4fQobrmuxPVybRX3I3V5Dy1TtHCwj44Na8XJQ2BAF+0123TwkWxghL0mGRFZUzdoatphtUj/Bu5gRvUNPazrVJ++zL77z5jobeyDjXWix7IKXHYrOc6bMsutAXz0ZBbtFPOtPpIhbYMTEd+TK1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769689372; c=relaxed/simple;
	bh=DVuf8LsvP8Cj5RXu9bhtc556KtOs2GDJL1GcHxe54QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bs4Hbq0pIdBpxx4fefayLaFeb/XhAQDHwWL1ytaF6xb2AEm+LdWlULOI7DPQDTiSGEQz2c0cwKAtmm7Jvgvne9tzPh909l+SBb5dY59O5s6SWPRXGTcPmDEhkV3xq4I1nNGr5MdN/1DzZ/6eAwtcg5KdKlzkb2R6MZhez5UpP7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGg0iH2g; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGg0iH2g"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64959e30705so817996d50.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 04:22:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769689370; cv=none;
        d=google.com; s=arc-20240605;
        b=QE4dH6z3ByNEmEKlX3nzdvT7QEmucEZj8uuwgVBiGGKxkSgIP6fSpHtbqIZLhNs9fr
         0QMAweChvHLyicIg50fjI5Yxvk2AuwSrlF4+4NiVf3tlCGHX2gOcRogf90kSGtm21vsh
         IEje3I+leVRqr8UYwF4wu1naoxwQzt6CuBifcNqVjHS16aenHz6yIqWSskX2EZtbHWr2
         MExHrXY0Gq8G9/Uehn2DNZSHUZnO1PjuZD/BIhK8cP11l8UcPiRumM09m8HuztIHRugU
         uje+DzvvFUIVfBZgFpaT2IyboKPZ8Khac4I/hkQncHD5VC3dgkhZ53YImBUHT3mKsGKC
         2f4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=334pvpZhH7LLkxDOjCWxKGmUQ9x+G/qAY5NOz4ub4VE=;
        fh=F+28c4S1DLBLF8WAKGCbUdQDaSjxlCk8M97gm1UIdr8=;
        b=Q1GDlDG4U52CFzCBO88Qrou3jioNZqPKG6SxZAJCw9aI9Y73kKFUlzPLlZQH6ccxEY
         CWHy15BIIKhPKXlZ4PKjfJgX7SoDrDxLIR1c2RoIv5NJfSdC1evW/eozWlMNkIoktqdb
         Kf2JLhSBfPeWU5JuU2HXrZU63lFOKCCBz/kcCzmeUlcEmDdNkghHzSv11xw/ne+HzCXs
         fosPOAry+AsJ2g8TJKDs/LHz9piTVXvR8FppQ6WRdQr1d+K3pDqv5ge4aEe3e2V/rIlA
         zon5l1DEGbJNhRwIo9K2I07rs1IPToWcsfv0vlNJRtkfsKlBnleKTxZ11ugB97XXzuO0
         0cUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769689370; x=1770294170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=334pvpZhH7LLkxDOjCWxKGmUQ9x+G/qAY5NOz4ub4VE=;
        b=bGg0iH2gHUFFjbZZI7vue3XunP+fX8EhMJ0HHN2my3O9C2I6Rosye/S9kGPGi6K4pE
         nlsWCGXieygMADepEPoYcTnL9bQTg0TWAhqJktm77XvbuPKR98utVloDg95c6M8tvekE
         BDlJQMiHUXm7mw5nKn6zl1qGuSEqdrTTceViilR2g9oHgrp/imMjDjskLGQLXpI7vkYP
         IjR87bS6lVI2RjBdhNPwll9VBVaEpgux+q3EX81K01he/IL9mcbuFf6g34aRG1nCsS/r
         RX+RrhIqmSqQBzRlD3kxV37byqHN5VqqZHDMRd+NWgTWG4sWEa7NMJUczOV+iR0a/kbb
         jIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769689370; x=1770294170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=334pvpZhH7LLkxDOjCWxKGmUQ9x+G/qAY5NOz4ub4VE=;
        b=avYUbqRmM21yq+rqF0ZZZDP7MgdqwlecXmYf6tOc6rNF1OFz4nk2AKBMLho5z8pRlg
         RSSZn55Ok/LBxh5C6WI7eylaJSkFUZuweFVdXKRs7+GKdBnBFI8XkdsC3916aA/yvg5X
         ebWeG00KRvrvdXZYvIg1Kr9IBcqt6j9OW4BSfOIBguGRr8k4OwwjAYzjuTUfGZ0ef8n8
         aKVP+vnhE64sqpVSVISWk6hrtZQ/Tkt4hXCe8aX5PoOv4aN8x8wkxhxVqB6iVy1a4NMx
         9YBhUEVCQUTPhYJPkw1Yro9pPEF6tBDVhx9cOH/pDTtSB8cKfnEk36RU169eDW5WaWZ6
         DBvg==
X-Gm-Message-State: AOJu0Yzqs1BvDcGV+KohSf7XbOZ9thuFTySZCrnU2gJSo1WAQ57nHX1C
	BSbviT7ndja2ViZfFnLh7CfsdB+MuvY8Jh5MM9qOlMOcgMB7PjdJYsASMWGOnlM5s35gZJrVFq+
	+N7yfiMXTspK1Q0/soQ01lJdh+Q8O4UYxiHY+l5g=
X-Gm-Gg: AZuq6aIuZyjkOHtXjD3AdL01gLxAVBTCmLBXd4UaHiBdRww0Z9mRjHZzxhEy7rMNFm5
	RKDXiMsFvLsMajxpcHM8MIQCWdh8CkUOf+cfIoOeOpPqV7gROUTlRYKWUaWUJFV28tnh5rTuZQq
	KFjybuxkC8tB33oe/E7iQvMDuVKuX5ojplRQm+8gM2ptuaf4/NW++rqO1SpQyp0/now3uMI2Tky
	dy0UaPpwF3/Issw6swO8wVXiWLlC9XavTmoyD83kG9BVJQJXaoGsZfkWIRTaP3BtdR/VPI=
X-Received: by 2002:a05:690c:a0cc:b0:794:7131:3dce with SMTP id
 00721157ae682-7947ac02063mr119834227b3.34.1769689369893; Thu, 29 Jan 2026
 04:22:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE2CrQD11Qa+wGVhsF8JwkuwkLWkDf9kGvs1NM2dsYFuPgUKA@mail.gmail.com>
 <20260129112446.GB1285720@coredump.intra.peff.net>
In-Reply-To: <20260129112446.GB1285720@coredump.intra.peff.net>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Thu, 29 Jan 2026 17:52:39 +0530
X-Gm-Features: AZwV_QjASU3Oig6b5dyJCyWBxONexky2PDU9JIe6xIAu09n5W5gVI9-dYsvJNlE
Message-ID: <CALE2CrQVnv7wcvD+ewDD2js7=mUE4soLmsud1U2AoorBRwAoNw@mail.gmail.com>
Subject: Re: [RFC] config --get-regexp: avoid rewriting regex patterns;
 consider REG_ICASE
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the detailed explanation, that makes sense.

I had missed the subsection case-sensitivity, so REG_ICASE would
indeed be incorrect.

Appreciate the context on the historical behavior and tradeoffs here.
I'll drop this for now.

Thanks,
Pushkar

On Thu, Jan 29, 2026 at 4:54=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jan 28, 2026 at 07:42:34PM +0530, Pushkar Singh wrote:
>
> > The documentation says matching is performed against a canonicalized
> > lowercase key, but the current implementation achieves this by modifyin=
g
> > the regex itself.
> >
> > Would it make sense to stop rewriting the pattern and instead use REG_I=
CASE
> > when compiling the regex? This would preserve user-provided regexes, su=
pport
> > more complex expressions, simplify the code, and eliminate the NEEDSWOR=
K.
> >
> > If this direction sounds reasonable, I=E2=80=99d be happy to follow up =
with a patch.
>
> No, I don't think that would yield correct results, because the whole
> config key is not case-insensitive. The "subsection" (the middle part of
> a key with two dots, like "section.SubSection.key") is case sensitive.
> That's why we only lowercase the regex up to the first dot (and after
> the last dot).
>
> So as a concrete example:
>
>   git config foo.Bar.baz value
>   git config --get-regexp foo.bar.baz
>
> should not match (and does not currently). Whereas:
>
>   git config --get-regexp foo.Bar.baz
>
> would (and does).
>
> If anything, I think we should consider deprecating the auto-lowercasing
> of the regex.
>
> The "right" thing for callers to do is to downcase their regexes
> themselves, in order to match the canonicalized name (which we do
> document; I think it was added around the same time as the comment you
> found). So any lowercasing we do is a favor to callers to make their
> lives easier. The fact that we can't do it as thoroughly as possible is
> perhaps OK, but I also think we could actually screw up their regex in
> some extreme cases (say, by thinking we found a dot as a section
> separator that isn't really one). Which is gross, but nobody seems to
> have cared too much.
>
> OTOH, it does help the regex queries match the regular ones. We will
> canonicalize "git config Foo.Bar.Baz" into "foo.Bar.baz", which we can
> do unambiguously. And especially since we document names as camelCase,
> people tend to write things like "fetch.unpackLimit" in their queries. I
> don't think we'd ever want to stop making that work (though
> interestingly, I do not think we document that anywhere).
>
> So probably I'd do nothing. ;)
>
> -Peff
