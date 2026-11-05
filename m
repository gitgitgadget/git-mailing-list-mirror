Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793919363;
	b=0jWdNqW52di9vBBfQxeF251Anvg+jySL53/UUQxkl5SKMvBnPqUJok/F2UacBTJdaYUT
	 TwVLwbmF+Af5FTdQgEDp22s7Ym5RsVIKWDFovSddpzHK+1Hiirrb0tshih70LBYOM/7/g
	 sRxAIsaQUQJTlcDviU4peKktO8wjdmEW2GVoxNu1gRbaIkxdngeXImrvGkTfLrN1XuInY
	 vEa20qThDt/9kyqIM+Bw8mYo2WSh2Hri2q9gdaUsNBRamjDsRQvukb4vNDaxUIYpzhx1m
	 934PQ3k9+wB4ALnG6SYSXS+wQmWX9th9UD0JaA6urT2TiIxvIqr8Wpol6Mg+BOcyeZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793919363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=U/WGAfesl7JMmyoo8JsB37Ve3GC5hycVsFqfEu6Tp7o=;
	b=A3ephNth+F7sS9lYjO4OsLjAXD5Nwm8bSejE/zN7RgpV4i9rPg1L3u4JAk+Uz/UyrgZ9
	 7HzFRCveZ/XBxLz3qdbOoLIihmHcJL0JOf1kpznBeyx9GXe957dQWzKjgAezHSN+6OTZ7
	 TLUwNjQVvFoi3bhEM9YbDg2qgNwxVzo57o8MQfyhyagxyxuNjksd4JFDzsg/27/bRw0n6
	 DHLzSAKP3p5Rhl9SwrE1F+pmio+HZB8iodtreXaRfx0HS3DJ+M5+xiU85A6D6zyIkKosl
	 SUliehtNQqzqOHjX/CkDVQCWm+cAS6FEFJYu01IXrT6DJjpj2N27mB6lPomlhE4ugFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQDt9Lb6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16AA606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 22:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E16AA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQDt9Lb6
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-99806b7d89aso1101529241.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 14:56:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793919362; cv=none;
        d=google.com; s=arc-20260327;
        b=qY55wLtV7afgJM1eIno9P0UbAUQatfK/BGNCMn7SJWTSGftd/09Iuc8PWfDoXo6gJt
         A8YbpwA0nl2rvdwkyMLmf/aEPDPOlPpeCi2a7DFsh6EZWhvEuuOFIKK43yaw7GqKkGBq
         RnjZaBGIxmXNRq5/gUtesipgb9cEwVbwSRIcSgbb34YZa7veZdkH8MVc9XX3ocXzTx3m
         pQHP57Wz09QaZs4GuYrM0Ol/tbN4I/MrScffrlh4LrNg3Pjvu4coPq79leAr2wuV//Qo
         uUWYFcjALY2AK+tYYpljAqa+K8Jw+PUaqTreNNzf6wzG0pHYXuXQNAMtWEdEuMHudSiX
         l4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U/WGAfesl7JMmyoo8JsB37Ve3GC5hycVsFqfEu6Tp7o=;
        fh=wQgUnpXGUIJk3O3LwnS1894ThlxCNh3Gq2z4w+1V8nM=;
        b=ovIPML+IDBOkWsMATjD5Jy8D+xifUYMWk3WaOyG9CGZpVAUhqGREd5sObHKnTVRu9f
         gDMKI7MXF6a7sRUaKZNQ3V8qLeIttxUVOyCK09QG2OdlnYj2eM3/yVrxOEP/AKHAA0jr
         YnbQAXsrngGU84u9QJbOUtxFYshrEycs5l7UabVY1qLmm8qgeOho5D/K+jMDJdMyLnKT
         BIwm6BS1vHrpRyH6zmYOXGZLzs9LxnE2/ley0Z/ATmppHIh/F/2a6QNlGAdYJ7GdyiaI
         OjZCCmsS4nKjnSmcJAm5X+ug2udDMKsVVPPTS1uRV3EmxzRn2Uhmp3UsXCq7hMb2j9HZ
         Lp1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793919362; x=1794524162; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/WGAfesl7JMmyoo8JsB37Ve3GC5hycVsFqfEu6Tp7o=;
        b=FQDt9Lb6cPTPHwq03o7Ry4jv2dHVIV0CxPIlHRK7bcD1dcMjqxvAB9zcql4PtWE6i2
         coV8N/6Wiv7Q3YRcrFct7fyGxwOIt2sAHGdIXuIuXce7n26+utIQk+XfMD4HApMj/mQo
         ZOWeeRmMqMhijgxozdP/ANY2VGlkmZWDfMXYdaA/oJhI7jIUnOg2NMjqcQkZhLFxxJlr
         Ha2X48eLNg7ncOtV1/ipFDtkIFTmlJQPvNTY7WD60cPGhXPt7YGqNLDKOsuS/xGEa+f5
         7p4mvBdINuWzZ2vvZFwEpEoLNgxFEwc0T1H70pWEyahtQ/Z7e71HFp3q2Ej6udIudnpP
         d1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793919362; x=1794524162;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U/WGAfesl7JMmyoo8JsB37Ve3GC5hycVsFqfEu6Tp7o=;
        b=COX0NIynnVxveFkeCc1GBfrS066Hd44ud0Bf9J5TBZuO6D9EXteX5PcoWvHlZ6Yi1x
         9D/DTyzZwk+hy3cJAEJwHAZSr12aXsQcjd3oPydI6HkQjgGyfkXq7DzTYQbS76dDYIJ5
         ANRrm5ipHcGFreXg3FaFOY93cH0RSw9B2CkKXTZXeqGAYaXJBhPoZ2VoDjvaUTA9gd+Y
         tQ8b4h1st3hziSRUZj6L3wXml8NtryW1IQ4ZHpAetBCtM47t8bVJjwW9kTYxacISZ1Ph
         laVclnIVD2NM/dqX9R1wEHjT/fG73HtItK6A8kVYJiStR1Il+n2wMVwZBeD/dBYfdUPq
         N6WA==
X-Gm-Message-State: APuU4Z/qIc0qHfCWp7oaSqP3Mf41iWYjEc091/ukADbwzaaWF82uh4rT
	Swhbjh93gnC6+YvJKFlOoJZ6IE1CG9mQYs2CYRaxKKc0sKUE1FjrlnJ7qminx4dQt39VzxmO3De
	BEIqD9YyB2JID8vPSlKi4tG2iefvzsCRIDEM/
X-Gm-Gg: AYBFou2xEwPUhg5Me+vznxUAOl4rd26DthSqkWeiUCuAnbCp4WYcTHLjsmrEynh3vW9
	pkcl+g/LcuxLlfutgHRo+M3gSh6s8B43wvbkHD6tYQJGxSS55qrCeRzOnrI+8QtDkRiOClatzqM
	9XzV687N3ymHAFRLy9pna53O7c8Jx8Ctu1S2auPNrqyUFQwJGZYqVc00Ddl1NL08zehjvFm//V1
	jSCXsGL3hrVJYhjVZIU1iSLSpdEpJ+H6bq9WSV/iLw83HAja4zMdxee5LfYLGKm6BtiXa2CdOJW
	HpxLH3mXVr0QP+5Tq58BmGbA9BDYa5/JBJUUoLK7mLiMFjdjXd6Ve1e7cN8Ny7wGskvxcdJzH4T
	/mjm19eo/0AQDumEEBjRyYTTiDldK8kp5FpNtOd67DoN/JExsHBTAMHy4qDET9vV8S1Ix5HtadF
	kPsaX8V8v6P9nrNjAZluvogUpSyjhnt3pyw27Shk4ggTv/6cMM
X-Received: by 2002:a05:6102:6448:b0:7c0:115c:14ca with SMTP id
 ada2fe7eead31-7d28674445bmr2414086137.5.1793919361766; Thu, 05 Nov 2026
 14:56:01 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104172434.691381-1-yopatatchou@gmail.com> <894327d9-57b5-4adc-b300-25d946211606@gmail.com>
In-Reply-To: <894327d9-57b5-4adc-b300-25d946211606@gmail.com>
From: Tatchou Yopa Nelly <yopatatchou@gmail.com>
Date: Thu, 5 Nov 2026 23:55:42 +0100
X-Gm-Features: AclHuK-cL4kzo58rY9fTaZWhqMmAfzO8CMh-0fYntirQrzbdwwJOViQq6RlV7eQ
Message-ID: <CAG7jffxRscX3ntX3p8L1GwGbs7WJmj6WoKPRGUuz3wcCS0NZag@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] promisor-remote: honor promisor.fetchOrder
 when trying remotes
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tanga,

Thanks for the careful review you caught real bugs. I've sent a v2
that addresses all of your points:

- fetch_order is now in struct promisor_remote_config, not a
  file-static, so it is per-repository and gets cleared with the
  rest of the promisor config.
- The list is now initialized with string_list_init_nodup() on first
  use, matching what string_list_split_in_place_f() expects, so the
  BUG is gone. I reproduced your exact sequence to confirm.
- The docs entry is added to Documentation/config/promisor.adoc.
- The whitespace is fixed.

I also dropped the linked-list insertion sort. Instead,
try_promisor_remotes() now walks the list twice: once in fetchOrder
order for the named remotes, then in original config order for the
rest. That's simpler than sorting a linked list at fetch time, and
it keeps the accepted/unaccepted two-pass logic unchanged.

I didn't add a test yet. You mentioned t0410-partial-clone.sh already
has a test with two promisor remotes ("fetching from another
promisor remote"). I'll look at whether the ordering can be verified
there, either as part of a v3 or as a follow-up.

Kaartic, I've also re-read SubmittingPatches#describe-changes and
rewritten the commit message to describe the change rather than
address the reviewers directly. On the RFC point: I treated the
Phase 2 config work as the micro-patch and skipped the RFC step
you pointed out. Should I step back and send the design RFC first,
or keep the current patch as a prototype while we discuss the
config shape on the list?

Thanks,
Yopa Nelly


On Thu, 5 Nov 2026 at 17:31, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 11/4/26 22:54, Yopa Nelly wrote:
> > From: Nelly Yopa <yopatatchou@gmail.com>
> >
> > When a repo has multiple promisor remotes, Git just tries them in
> > the order they happen to be in the config. If you want to try one
> > remote before another, the only way is to move lines around in the
> > config file, which is awkward, especially once you have per-worktree
> > or system/global configs in play.
> >
> > This adds a promisor.fetchOrder config variable that takes a
> > comma-separated list of remote names. Remotes listed there are tried
> > first, in the order they're listed. Remotes that aren't listed are
> > tried afterwards, in their original config order. The
> > extensions.partialClone remote still ends up last (that's done by
> > promisor_remote_move_to_tail() in promisor_remote_init()), unless
> > someone names it in fetchOrder, in which case its listed position
> > wins.
> >
> > The sort happens inside each pass in try_promisor_remotes(), so the
> > existing "accepted remotes before the rest" behavior is unchanged.
> > Within each pass, the order from fetchOrder wins.
> >
> > I put the parser in promisor_remote_config() next to the other
> > promisor keys. It stores the parsed list in a file-static
> > string_list. The per-remote order field is set in
> > promisor_remote_apply_fetch_order(), which runs at the end of
> > promisor_remote_init() after the partialClone remote has been moved
> > to the tail. The actual sort is a small stable insertion sort in
> > promisor_remote_sort(); order == 0 means "not listed" so unnamed
> > remotes still sort after named ones without losing their relative
> > order. It's called once at the start of try_promisor_remotes() and
> > is effectively a no-op on the second pass if the first one already
> > succeeded.
> >
> > I didn't validate the names in fetchOrder against the set of
> > configured promisor remotes. A typo just means that remote doesn't
> > appear in the list and keeps its default position. That's how other
> > list-valued config variables in Git behave, and it keeps the parser
> > small.
> >
> > No test, and I want to be upfront about why. The t5710 fixture
> > always has the server satisfy a filtered clone from its own
> > promisor remote, so the client never actually triggers a lazy fetch
> > inside that test, which means the ordering change can't be observed
> > there. I'd need a different fixture, one that gives the client two
> > promisor remotes and keeps the server out of the picture. I'm happy
> > to write that as a follow-up if that's the right direction.
> >
>
> To be honest, only part of the commit describes the change. The rest of
> it reads part like you're talking to the people on the lis. You might
> want to give the SubmittingPatches section a read:
>
>    https://git-scm.com/docs/SubmittingPatches#describe-changes
>
> Also, this patch kind of tries achieve a part of the project without
> actually going through the RFC part of it. That feels a bit strange. Did
> you possibly misunderstand what a microproject is supposed to be? Did
> you possibly read the following guides and have some difficulties with
> parts of it? If so, I'd be glad to hear more about it so that we can fix
> the same.
>
>    https://git.github.io/General-Microproject-Information/
>
>    https://git.github.io/General-Application-Information/
>
> --
> Sivaraam
>
