Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51F331EB7
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151106; cv=pass; b=vD3LfdymEhkIszJDNin6f5rAMy8LCcelggw+f/lAK1E/Q3K26kgML2zSMUlrmPv7dsFna6a0bCrnxMnqr7tPQgh4SItKvI2gp+x0SRndK2xDlKqsSrJwsxRTPvIc1v31heVboe4ZuDxoBFb5T5oHNcmtOAEgjZ+g8bPIx/8mvcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151106; c=relaxed/simple;
	bh=G0rCUMbFZa7sTaNQhmS5JXL9eHdh1L+5nWw3OCWnKbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juZJb7GiEynsbNEmhA5I2x3Z462NZtdiLXOGQKDuWhGKd4IbAJbuBu9j1lNIyRxw/0E7l73W71jeDvO/tjgnWsFOfd8/WGcYBcokb3ahMYyUrq6NA5Pik31KdCIp1z+qklcaThlUxeJlIWr7sAbW7nE4ZNPU1uHE/VOylBRI6fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ee3/jYcR; arc=pass smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee3/jYcR"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e62211987so739368eec.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 01:11:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790151104; cv=none;
        d=google.com; s=arc-20260327;
        b=V09pmhru4d0C9pVDGxevyCSlspqJLABW8HKz7VkMwNjmJcmYQu0Cvi4pUgNfWsup3n
         iJOFyT8OHDgV93+K2wDrl5Pe+JNca4/4b6TtMe2PB6tgIN83HavbivuZJRKsiJ5NmaW3
         VDmxx0mEY4eHeLLBbeQrKS7tvEetFQnR4adW2VDmmlz/6dsmSibqwS9vjYRfKWI4VNes
         CdHMxOcaRl2stjDz/sSyG81N+sjji4ZGIR70c0HcVs+R9vwHSmvIjLFOHIhWnAHm4E2U
         AhF81iFBX0hR+nkFQ4425VsQwnkC/sPRKk2YJWSK9HXqSbtaJNo4Vo3+eKJz2TgPzAvd
         L4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FcxapiMiwaLysIIp3BI4hNzqIVq6vT1dwCHjv2BP6GY=;
        fh=xgj+vSGq/gGUery/oIClRsu4cMrai2x0EL1nksSCsY4=;
        b=riCkXY6+ZcsgNHZFVRa1Kz8MnGB7EX60u5Md1EFjzblmPilTkdU6HTTmaS4hbPiPug
         we82OlwDP1xR5k4xf0j0lWcwNruZ8+6eGTzWktKgDC3Lqe0mnCJx3fh2s7KO/fdZJ9uw
         vAiI/nevZm73wXapt1vKLYKD8lRR4BxVYL7cVP4TOFkN6Io82RCPQInvDEOKL5DsuzxT
         FFBm3dJAAMkE/KmXO+nbSUAJ9XxSHIhLHNThYyE2ByOOxfMpJtUrwg0BjuRlGEhQIUZb
         sb/9BCy8qwDgDOaYwna3hOk+AvwrqUctX9VzmHEW7xHCtpww8B5h60hejixFhpWv70IO
         Oc9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790151104; x=1790755904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FcxapiMiwaLysIIp3BI4hNzqIVq6vT1dwCHjv2BP6GY=;
        b=ee3/jYcRX+zxKb7PBKq5c7U3tr98A/uhj24Lw+5quqr7Iyg6d9Rj2Jex7VAac7mdpH
         xqSfLBQz34aZRnk9LCSxk/J4+THJAyFVfKjxfhmpMjMGJ83sunDA0pIegq39i6S+Gj5D
         lRYyNWLXqlMxOY0JlvGTkdDMZb1L49o2bWuZPz/WpOZBYpzRowDCLZ36F+vDI4T6A/Ix
         dol7bDH2cVMkHEune1IbYAjHIDoGVChF6YeF33CdDUZqDIxMcCEoYmeMRWxCdyb0ENzF
         bNEERvNbUm9p+AV2601qaHXHmdXGb11FgyfZCjEdjyvMdHwvfIcnocDGfJJaoNsH8dDJ
         v72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790151104; x=1790755904;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FcxapiMiwaLysIIp3BI4hNzqIVq6vT1dwCHjv2BP6GY=;
        b=mHE2aWpFDFEcIo2Af1CBko3LZgRCAtsuNRV6NDRq5ggXdX7CtNYts/iwW7Le03U34k
         AXWU6slbLKgHNGC8LdzqVtbBTKXMO97oy1mXt8XCl0KiNnaNY3yBW4F+Xlh8Qq2XP8sL
         /3PWYw+hrcuomFW/fpTuMvLO0kvP8PSQuPglPiVoOORO8Oh6pP2b5ZOZqnyDPbF07NIh
         8/stWaw9icja0kgBr7BeRXGJjDe7CPXoJgOFu+y7KdtLvvUJV1x5yUAW5PDeYhPkU0kj
         Z8vPgv3jABCz+6lBKlqqyS6xtqsmo8CmlQYjdXdbNKSHTO9mH9Z6n0yDwaHJ6K7ItISo
         xLxw==
X-Gm-Message-State: AFuF++n4SIaSDKDsNRuzprXDofZ9dwRcR50Jrgz1PQlCH8K+TLE1VmZ6
	z08BR+KY7SCCmAJSgaYjHwsx0yEtq0pldSBCUbU/TRStKn3MKAOOdGq5mgp/25DhjiAsWMWH0dl
	c0GFisqvsNqtYmh15TXn9GnEWx0AFKsE=
X-Gm-Gg: AYBFou1njLvV9OQ1EjZL5f/Kepb/83Ra2JnK67AYfQ8L8v/2envCHCRzL7jbjAY1JU6
	IucRlpRuq/1qouia9LjItpBAUNoTaDt/6/3zvPGbRAg7IDKDvjZ7H56I7HzTKxn3flh597Ygkoi
	SY9KsRYJWPzvAGV2vjETOQuwx0gOIyY2QU6pGgLwaNC4r7q5E2MA4B32iHXmoHewpSroF3FxZ6n
	/G2veMDf6Y+xBXhjv2qcfZkT/poem5FhoTdE15cG6a9Tv2/BmXPmW7AsvdvFsCvsU1p6GZGkuud
	UG5K78lG+/sIj+HqFunMtiskrG5G7SuNF+1hcV2mcfczMky69SG3iYtqpuWDDZfPYrL3cT9WIqO
	QiDSlELkXtkJ1sVTbTwfF47Fat8PqJAtxrHU3TlaSKyVMb91GagyEK5NgkgZgdxUl7owj/jDnGi
	Ik/Mef5Q6UHfT6VFHshwsJ7BbAApqM/CwNJ6rLxlY=
X-Received: by 2002:a05:7022:43:b0:144:e0cd:76ad with SMTP id
 a92af1059eb24-144f916a44cmr2867416c88.36.1790151104065; Wed, 23 Sep 2026
 01:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902161047.476753-1-christian.couder@gmail.com>
 <20260902161047.476753-3-christian.couder@gmail.com> <xmqqse3rffr4.fsf@gitster.g>
In-Reply-To: <xmqqse3rffr4.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 23 Sep 2026 10:11:32 +0200
X-Gm-Features: AclHuK_bZoxtTVNp8tBjxyM5BIEsiuqBxylROMEtCZFjSrTzwrk7SZxBwJWYMek
Message-ID: <CAP8UFD3sh9Ejfgv7CB33LRU_z3i662_+tjdW7JqwRrzexWX_Ow@mail.gmail.com>
Subject: Re: [PATCH 2/6] bisect: fix "--" detection when a term name is "--"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 12:30=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > `bisect_start()` walks its arguments twice. The second loop actually
> > parses the options, and it knows that `--term-good`, `--term-old`,
> > `--term-bad` and `--term-new` take their value as a separate argument,
> > so it skips that value.
> >
> > The first loop, which only looks for the "--" separating revisions from
> > paths, doesn't know about these options. So when such an option is give=
n
> > "--" as its value, that "--" is mistaken for the separator and
> > `has_double_dash` is wrongly set.
>
> It may be theoretically true, but I wonder how much practical value
> it has to correctly parse "--term-good --" as "Ah, the user wants to
> mark good revisions as '--' instead of 'good' or 'old'"?  Even
> though "refs/bisect/--" is *not* forbidden, how likely is it for
> users to do that?
>
> This is not like "git grep -e --" which does have much more pracical
> value.

Right, this patch and the next one have been removed from v2.

In the future we can still convert bisect_start() to the parse-options
API, and then use the early-scan API to look for "--" in a bit cleaner
way.
