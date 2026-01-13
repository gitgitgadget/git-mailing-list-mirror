Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F30187346
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284097; cv=none; b=XoPNkZ4ZH8oxoYQRKVS6+xO7j9k5ZxP0ZQovagaK7yarLgxJ1UFY6JMSL4Xm3TukEv98/6GdTGXgi4HHkWWi0f1EB74Pt+9CaKxISnPxSDnzayCm2oE8jvCF6ye5N7EheotkFGTAuiSPl89XETF1RKaIEChGUQt5fBlMo4KXba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284097; c=relaxed/simple;
	bh=MQDBlrY5qAzukGB4L914ltnjw9ElqKS92DAEHx1ErM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFVr8+devxJsEJ5EePajFt8GKJifaA6roP9PCGxOmzXp5xQ3rQJ/69GgIRwNNvECUW/M3m8Cp0AXdycBfCzsmpotFBisRgxC9ro9nDMYPx5WNhgoV0GyhSNrsfiyp4axU7e0t13qefTCFptXndDmaFgIoHoSudnbELIz6kNW3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt5EJiLW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt5EJiLW"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45358572a11so4425961b6e.3
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 22:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768284095; x=1768888895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYHNqP18T1XmjQTnL/0gD1TqQXpwHngudrbjbs3mE+4=;
        b=Qt5EJiLWKnrgBvm52u5DdNr1Trba/T44657l9Q3vBp9evGlk95itzZa0xEjHyhtljv
         NATkYEkCvmIg327SsDSzDHSs4UqEr4D5g0RDIUdVQa94c66D5WMGng7f3/rHZQBq3Xt0
         M67xfwmWDbOTsYH+8RCfSlwQVXK4mF10kEcNfyMfV42+MF+Dzd76Gk8rcSJ0ODefJKSJ
         /xpFn3hkX3VXqX047yNVoZG8A2uw5SW5Ee5Va9RdnS4ggMPHtFXjC0+YOfj8KLaA4DXb
         VoTR12GIflJgzIr8+lXdRAKbiwv/UuPHpXGL3fdsKeL6XT5TuknmXHg4YYvZrdjsBo8X
         fFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768284095; x=1768888895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYHNqP18T1XmjQTnL/0gD1TqQXpwHngudrbjbs3mE+4=;
        b=VqguoF+E+Ta0q+9OypHoBLvlmy5mSZA8nGl2pQ+IJahVog1iAke25laHO7AjQKgXeB
         AjDXXUbKpbX5l0RwwxbmrnBrqs8TyI4APhQDNZFs5yYeMvDTnX343R1x1wJp4R8sYyVS
         o9US392+mKmmHLlyrupYV4y3RIhnMBnVuCOcbzwJShOt3QqouNA8dWoW66JwZ7jniN0x
         4xlvSl69qVE1N6a4f+LR9H9nISgfODLhyDrw+LixdNBa7Eghdz29QTew5NMBThz8Ji0O
         /dbo97g1j3pfkLeJFquGV8xBq/J51h9jgdIphigVEUqEbK8fS6goMuZbbTmbQzFifJv9
         CpZg==
X-Gm-Message-State: AOJu0YygCcWAKv8lNsvHHaTWwa0byZIZgUYhOMvd92s+I7yuKDca3N4J
	GTIHZebaoikg09r0B6BhCwA4kRmayuw1Y7z3y1+oxNMl/kLelAjONby58/ku2rQ6kOAmyK80UZA
	Kyy7Yb1uPJnxhXnQaxsJ1i8n9ppqD1PI=
X-Gm-Gg: AY/fxX4jsnVhFpw35lFHsAmg5peNTYVpEygFypTSiwoN1n8VM+RwhsT9ElSRVxgSTIl
	jBgHlcCMqgoVlwwGggGlDefsA4DGbyE9DPwdlyeBNTWQhBKQ1M+6J52Z7ZFFSJt4n6fAjwwi9tc
	kNEgBwAAFfUHxfnyLLqODHRid4PhTIQ4Z9TwKUNs4h73SlI6pH3oiBx7bDcOnG+Sej5dvFgECPF
	FYkxOTpfkIERg33vYrSYP2X9OesF4HjqlhFOgGH1LTiTd0RW3fblkXLWN3+FgvpNnazn5rvOOFR
	qjv9xn0snRKxY9OdGooeaCXfyOqg
X-Google-Smtp-Source: AGHT+IE4+QN1PT7t4X0ErYpZMJTrSD1ydFvv+1TzVeqdvnGvVuHJrbpo1mBZVtgiJUsOqvyTpn3ithE1P26SyYWNIj4=
X-Received: by 2002:a4a:e9ae:0:b0:65f:6759:992c with SMTP id
 006d021491bc7-65f67599c65mr4090899eaf.81.1768284095415; Mon, 12 Jan 2026
 22:01:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im> <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
In-Reply-To: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 Jan 2026 22:01:23 -0800
X-Gm-Features: AZwV_Qhl2iNAtyTFB2_De0MSUks8cj6Ccmppc-l36kLJIC-BryWof5c-Z642sv4
Message-ID: <CABPp-BEDpjfxLrB5nWS+DkkTBKR+Le+jJhQiJCio=WkruchioA@mail.gmail.com>
Subject: Re: [PATCH v10 0/8] Introduce git-history(1) command for easy history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
[...]
> Changes in v10:
>   - Split out changes that make `replay_revisions()` handle empty
>     revision ranges properly.
>   - Drop redundant `struct repository` parameter in
>     `replay_revisions()`.
>   - Move around `die_for_incompatible_opt2()`.
>   - Fix up some of the headers in "replay.c".
>   - Split out the changes that make `replay_revisions()` handle empty
>     revision ranges properly.
>   - Create a separate commit that fixes updating detached HEAD.
>   - Strip "encoding" header as we're reencoding commit messages.
>   - Merge the logic to update refs in in `REF_ACTION_HEAD` and
>     `REF_ACTION_BRANCHES` modes.
>   - Link to v9: https://lore.kernel.org/r/20260109-b4-pks-history-builtin=
-v9-0-8766101814c6@pks.im

Both Junio and I highlighted some changes in patch 1 (you already
indicated your agreement with Junio), and I had some minor rewording
suggestions for the commit message of patch 4.  All other patches in
v10 look good to me.
