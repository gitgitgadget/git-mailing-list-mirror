Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E109B3ABDB3
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902747; cv=pass; b=UukEu3x2+ZxY0q+6Aj2jtjsDscIOq/zDkT2SZ/+BNJaGrJeGOy14MXpS2hczjnUKbakdKqqpgKG4quaohwqyycjn49hDv6IzOrWuJtC31KNB63tDRo1w3brkebmqDvOXBBWe6MoBXen+Y2rNdegyQBxTu65AHkNcfCAFhOyHg3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902747; c=relaxed/simple;
	bh=TR7qMIj+WINJAwepWuYsBfZ4qJI1AWsSvvyuCWNVc5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBg8/LDJ0vufLhhs9FqEY9VUtCnetX3YjlR/1g8e8+STikeahFxoX1AXQEvmt5WVEg1EHPaAy/SfgRJb8oezePuH67grq+5W6KYfsE7iDZ3fghYtxzh1WCKIZuTvjp9Cq0Co+Nc4afwJxVYwzPWIYE3gby3LUxOmxwRlCuyHgJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qO/k1FJS; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qO/k1FJS"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b28db31b89so668525b6e.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 00:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787902744; cv=none;
        d=google.com; s=arc-20260327;
        b=EsiHTXQB6rzrV3kB7hH9HOXa+pfiiH5lFMretm+CC7onNhXbyZMo9QK+sShFSNPD33
         FcRFABGA+LTg3PHtW1RjqkF4P6GeRpzFyDKk+AtpogFx2LEbkPBUTFKyC43v0ZC2eiUF
         moGvhN8tyh0DaHh7CRrOvaWziPn2ibl/kN6UEhsfOQnvHZz7Y0VRtJAabhj9MtOkD0EO
         k8ePQeLiFzJXMxY16UJTUnDfN+MfstBxpDta1Ot6WUqFUZavPReKtcnllJ5c0eYHCVIQ
         AQNPDGRlTBHb6kpbxYZGQgWI0y3kaXWZP3g/FX5lhzSDTke+YetxEVjSxjZmUqHOAXoi
         t8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3QjIw8i9acSH+M7eIkFFm49kGN6X5e6BOGZvO4IiCmY=;
        fh=ZduR42fifIA/ahds9LbvsIew+5beEQob5PMAI6jgYRA=;
        b=AgApI7NpbIiBuwsSQq6zgZ9TT4RwOUIzyu9usidW8Aa02hwY/OUQRVssNZJTW+WogS
         jw3yIC71teSHAAqGyb6rbaek0PXCtPT+8lonS4luGopV5BX/0Nl1UnEwhz+SeBTQwAvm
         G8YuuaT7cbbjfWeFvuJIwZTjPEEk2QTxw0NhXqNRSywGgNwfJFYz3oKEtLA/fB7x6K/2
         A1PbvdLsMiKnotkEf0UusCUi14Xn2qs17WU9iMShgh8P2JU+Gl3wejYc2wVYs2ff0tOg
         K6vnEC86aGMXPVvm4DcYrAhjQXfHfk0BskTr0hu1M59YUKnvdxLlnn9IaynuufTI8sZy
         9LJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787902744; x=1788507544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3QjIw8i9acSH+M7eIkFFm49kGN6X5e6BOGZvO4IiCmY=;
        b=qO/k1FJSZKDPc7a8GRatIN1ocHKWzQbkWsOQEvm8k8/uGeaDmaKpizONLC4WiDblCu
         RTOh6NFZPKVpCXGKqprtYE4/kzB+9eP5r3LXsPGGd8DsT/oaWB/GgpAB42n8u/nJ4Jgb
         DcgsEcPaLhWsZX5f7UvpaSp5T07XGydtbK2+5NvGsZIgnWxbdmUXIYBAC4h+SyvxdanE
         lY24BuPlA6y2mGtOzC66j50lK4xA6eAk1s08j0N2dGUdJTZv+ZEZiepkIZD61rr3AGIM
         Xe+7bQ66jUuR6k820MHyYHq9dneryuv5f8Q2OcwW3CL8FYSUmuY/KyG3BxnJcDglO00T
         FxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787902744; x=1788507544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QjIw8i9acSH+M7eIkFFm49kGN6X5e6BOGZvO4IiCmY=;
        b=SHPaNRzkLF70wQ849EW7l3OOcj6eoeOAvabzUgTIirCtiM7/tpbOzZe6WvqvK7DtB7
         OBqwOXzUmPxkNvBJ833NeUgkaPZvnoux3POcRdtGJdJPjS67UlQut4kBT8Guc4UPe7Yr
         0CFqJVEkIyL6sS/8I0M6cT/OC+WtN8u6xSA94ZqQy2b+xRvsFmSRZXV34NHHEg+LKOdk
         YrLZQYEwpA4QrVNU43XLJXJxFa2pALtXBQ7DEjpuWmE9ruqmZk8+TduPz4gO0OL6Pkaf
         GjEC1/ct1PI5d0gm0R1NtPmGOGCkSf0yjWWjZ7KDFJXGBh3b9/5f+pQQ6v/IA3HsHP9b
         RsTA==
X-Forwarded-Encrypted: i=1; AHgh+Rom6XRdkaftspqhk3HDyzGqplXlD0zHKS4TJikN7U8FvZVY8AgkEZB6Ete5Wb4C+oWcIKg=@vger.kernel.org
X-Gm-Message-State: AFuF++nAfsv1iH/YdN/8bzyqJBQa6Wa+0oypH0+XbZiXloMwENQhCrze
	VEtWG6qtC3qRQhJUPix9E06NP6Asg0CZ0yCzUsYhi9pmXFgoXalT6CTvEauCo4W2onM/Oyf0kn1
	Q3Lna2NzcCS2DHUhVlHRuDENIBAFal/U=
X-Gm-Gg: AR+sD12bJJLbL4iD9Hs4gmxyfy0C4x0gD0CeBctUXDTRJKUt6Omyer2x5Djy5F272WE
	fXcqOYdvFSRiX3foT4sY2gW4/FfjQfhieyBF3F2+nDut+Y3Sa7ov7ebtj6VzZhW/GLPJS30zd6M
	SBWl3sEEmQ//VhyMKlIF+MQoJX5p8Ak+qTNX1ffJkulvBHQw4n5HWl/A+zrXOqnm5x3Wiwa7QHj
	B3GNj0PVWvGCnsghng1m+81ktCjJp40R7YIuV81pr7vkZdgURV1pUfe6gsTpbATyP6F4jphMWnH
	NlgTjM3GtN1g9twESYqrILlIKR0obRNxbiClZ/QSVv84Z2Yy0jCkJMEp0zPmV8jElNt7x7FI+88
	TgqjLZh9KSFKpAv1i6rhfykgxCgtoF2mxKFwIROnDsD6oWU2mEfynQD05YVr2
X-Received: by 2002:a05:6808:228f:b0:4af:5d69:1cb4 with SMTP id
 5614622812f47-4b39826ab9amr6012672b6e.15.1787902744566; Fri, 28 Aug 2026
 00:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com> <65c48ed3cb638cf0be18a3aa6d86d4c4f2cf01a2.1787792534.git.gitgitgadget@gmail.com>
 <dec05fd6-b99c-4a71-b80e-24e7d6de4b62@gmail.com> <xmqqwltba4gt.fsf@gitster.g>
In-Reply-To: <xmqqwltba4gt.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 28 Aug 2026 00:38:53 -0700
X-Gm-Features: AcwNN1V61XKgRysd5QaJI72I3cXJVzvFTX6x5T0Dmw5u9_q5Nb068btrgWBfFJQ
Message-ID: <CABPp-BEaPtkT48-wpPmniWghhZ97VELkHAzFMgdckTAosmstgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] commit: reword the empty-commit rebase errors
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 9:55=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> @@ -521,7 +521,7 @@ static const char *prepare_index(const char **argv=
, const char *prefix,
> >>              else if (is_from_cherry_pick(whence))
> >>                      die(_("cannot do a partial commit during a cherry=
-pick."));
> >>              else if (is_from_rebase(whence))
> >> -                    die(_("cannot do a partial commit during a rebase=
."));
> >> +                    die(_("cannot do a partial commit while resolving=
 a commit that became empty."));
> >
> > "while committing a commit that became empty" would be clearer to me,
> > but I what you have is definitely an improvement on the existing messag=
e.
>
> A stupid question, but wouldn't a partial commit of an empty commit
> still an empty commit?  IOW, why do we need to reject a partial
> commit while committing a commit that became empty?

Not stupid at all.  After some digging...

Originally, we just checked for doing partial commit during merges or
cherry-picks.  Then in commit 430b75f7209c (commit: give correct
advice for empty commit during a rebase, 2019-12-06) it was noted that
the "cannot do a partial commit during a cherry-pick" message was also
printed when rebasing a commit that became empty.  Noting the
misleading message, rather than drop the check in that case (likely an
oversight), that commit opted to make the message print the actual
operation that was in progress.

I can fix it in v3, with another preparatory patch.
