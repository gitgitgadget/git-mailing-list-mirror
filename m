Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCEF3998AF;
	Tue, 21 Jul 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653800; cv=none; b=icJvXmvr3FS+EVMB6QVeziZCx5TKLPJoUWHGFEcjVEQJRfJUp+ZpZU9vOwOjXH2r6oNpKziHe5nSFweK9KGC1LU18j38oN9VZ7MPUuMPINHjvgvh6KZo7puaMQVBGVbgBTjhfGSUR4VVitZqgm+L82Qivvb+EjVyypxHEWodyaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653800; c=relaxed/simple;
	bh=6++Lg9kYoO9WSZYnyb+rgz4xtqnBDiOUcsIr42a/6zQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PKjY+uUoqcbEsmwokEs3UHfkTg1qgefKqmR5ZUWZr0uGRCK9sDqHWbZRpaCvQCFaTqbqW8ETBSirqffbFC64j64RG6lj11//vxgwd453r/9MIL+o3GhmCSAoCHXHeK5+WClnArb9Eh4Ph9xtDvJ4QrxNK6PtPMcC/GEuL12pqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jPSG47ko; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UOe7pxY0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jPSG47ko";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UOe7pxY0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55302140003C;
	Tue, 21 Jul 2026 13:09:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 21 Jul 2026 13:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784653798;
	 x=1784740198; bh=aVkQZcMR0JKJc7XvtB0/mypaTdoFZ0wIdBtDRlzY34w=; b=
	jPSG47koT3+B+TAwjVrvzzir+OuZ6ilxEw0EW8tOKf3FMoySqNG9RXI0xYYcY8Yp
	fjKxmqFALvxpcvTF9r0ZO0Cg6XFvbxQPTLUqYNit9hWpc3Xsko5RNIyHBplor8p0
	+kJ2xE+DTNq6l8BUBkao6W3i5dMMrFJ0GjspHOvPIAoGPbfp3r2jgC7GaSMivSkX
	W+DJYe+ZeNBHo9RYT4FC216TTpxuA2kkYg1fCosaT46OBFth07tsGqysVfXq1uoe
	W4ajSmiyYfaPeE2ilg66EFFc0/icruqNTd6e8XT4RXJNDkfaEFmfiuWiCUlI3Uf5
	fEFWBG2oh9DwSyFvXsN4gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784653798; x=
	1784740198; bh=aVkQZcMR0JKJc7XvtB0/mypaTdoFZ0wIdBtDRlzY34w=; b=U
	Oe7pxY0fb5b2Vy6h6HrcVo0ioJz73iNxKFdhLDslCfk96FYEB3Fd3xgLuWjS3Dao
	5tc/84+clP0FNS8plwNYJYfAWTjwLSJG+lJ4FeSNjqY6ouZ6IGOdpq4ce7lRjsl5
	gXToY1YB4RDSphqeNjRnBtR/leK4mvkFFjZE9A0QoNYU0PUjcUJQsrE/zAkyl96q
	2uJRLXp3ZfwM4QFAtplvB9POhOb5KtguO7vtgKVqrRD0BcKV6rwiYVU/3OAIMjg/
	gmpmvGJ80IO765OBFhO4+XouthX6ddLBE4UXDWR9Bp/rg9gIfxrpm1eUkgZBycKx
	vnRlWuJHp3SxIy0Oz1V8w==
X-ME-Sender: <xms:5qdfasgGYD16Fm5KS9iSc01FXdKowZsGaYffFY_OY0VlFHXnU1Jtpw>
    <xme:5qdfaoGUz0j0674P0hWF_jAH4nj29X7qwj2cJXP-8ffgjNzVdaYcMqykbFwwYMfIQ
    WUTkpqrCBJA2GbeDJQDpJgGN43cFI2JG330g7WxBK5IF7OYLt5tkQ>
X-ME-Received: <xmr:5qdfauv416B1a8Z6YfFQCWnfOqb7ktKsDyDwqfgbd_gRriPMjLfsGXP26zEIsb10UTb3muV2AseQ3xrxVTlSk_0nH5AcYRr_xA>
X-ME-Proxy-Cause: dmFkZTFzvnjlaA7qNbdi1ClJM+reVk7Mmj5ft1UFI4oIdZvRYndnjV/7XahNW24X+KaNXH
    lAcSHGgSzP9jSS8PzHjEM6fIdbRO6E0tCFpJzzEy+LQJg7tEDM6LXPLSx/mNtDjTxzH2IT
    GLz4CPKiE3ogAFZkb+TZqEWzHkCNY0QZOf5n1yiJCLmTzxACUNpyf2hYuhHdPDZwN6fmJc
    GS7mBcRM12JYc3OEgKvJntlvy1SjgKyxQg/p4eNnu6bte1nkvqHlTPaTv8pZA76IVaKpN6
    B1nPi9bPnIvA9icDM1qpiMqi2WXpe7hs8O0FbOWrtLihMDYtMvW08wOwhqcuf5fyq4+FjY
    +irzf/1DiVZQCrwLr5QsEzXk2MzjJxunRxUdA1n7FQFG0T+xGwiql7dAt/SIme8xo06dDo
    O7sS/LHuRu4KowMuKHulLWXipy9Mjt8LSbBxiSJD5BmK7NT1eLn3K2jBhrnTzwsJXXX5EA
    N/0+LpgZZAZIHSzJAch5SyLR2hx1u5cKYR21Absrg1e18xUJnfDTj6S0QyavFYI0Oxg0Th
    zROax8sbzyoy+6XMYraoRFO1phTVH4BKLOt52RGDv2iDxEXYUcfoX45JcoocpPf6gBa0xB
    NpdAGydqzvzEd1OinHjUZH3ZZJoN+lsb8wx0934RKjDM4ctrUOhoPtzf4O0w
X-ME-Proxy: <xmx:5qdfapeVPqHNnA8SnODtdQruvMLvT1qPlz3FNH0meQfWp289tN_o-Q>
    <xmx:5qdfaknE_06Tt84yNYWbciHbe1_lMW6zQi12VO7Ejxmte4DETHr5Hw>
    <xmx:5qdfasA5_nBDiHDM6Mg5SHOGXmWUZuIcBZYjEYrWdn3MDb-Gw_qokg>
    <xmx:5qdfauPYm8oVStEcnVXnhQ8R_7ttFuGuq_iWxflnbpUHpO3GvL5jSA>
    <xmx:5qdfalVb73j8eUHkviDsGd5oGAG3burantSiabh3ip6EMoWdtQOAs8YJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 13:09:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,  git@vger.kernel.org,
  Thiago Perrotta <tbperrotta@gmail.com>,  Philippe Blain
 <levraiphilippeblain@gmail.com>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Yury
 Norov <ynorov@nvidia.com>,  linux-kernel@vger.kernel.org,  Codex
 <codex@openai.com>
Subject: Re: [PATCH] completion: complete paths for git send-email
In-Reply-To: <CALnO6CAuitGp_xLYkXpkQYV9oiXsNNfsXZ_OqzkW7_6ND49=LA@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 21 Jul 2026 08:49:54 -0400")
References: <20260719134447.381835-1-yury.norov@gmail.com>
	<CALnO6CAuitGp_xLYkXpkQYV9oiXsNNfsXZ_OqzkW7_6ND49=LA@mail.gmail.com>
Date: Tue, 21 Jul 2026 10:09:56 -0700
Message-ID: <xmqqcxwgz2u3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Sun, Jul 19, 2026 at 9:45 AM Yury Norov (NVIDIA)
> <yury.norov@gmail.com> wrote:
>>
>> From: Yury Norov <ynorov@nvidia.com>
>>
>> git send-email accepts either revisions or paths to patch files, but its
>> Bash completion only offers revisions. This prevents patch files from
>> being completed. It can also make a prefix such as "0" expand to an
>> unrelated hexadecimal ref even when matching 0001-*.patch files exist.
>>
>> In my Linux tree, an attempt to autocomplete the standard-named patch
>> brings a random hashtag:
>
> It is unusual to call this a "hashtag." Perhaps "hash" or "object
> name" (or id) based on the glossary and datamodel docs?

Very good point, but I am not sure if the author truly meant object
names here.  The reproduction test uses a long hexadecimal string,
but that is not an object name; it is an unusual-looking tag name.
It is like naming a topic branch '012345' and complaining that:

    $ git send-email 0<TAB>

completes the input to the branch name while ignoring the
0001-changes.patch file.

When you have a branch named '0-tolerance-policy' and:

    $ git send-email 0<TAB>

completes to that branch name, you would not dream of complaining
about the completion.  IOW, I think the complaint is somewhat unfair
to begin with.

Actually, I do not know if the completion script really expands an
abbreviated object name to a full one.  I tried:

    $ git rev-parse seen^2
    179eccf0d01729c19a3238905b951b1880aa4ba1
    $ git checkout master
    $ . contrib/completion/git-completion.bash
    $ git send-email 17<TAB>

and waited for some time, but it did not complete to anything.

In any case, when both a '0001-my-changes.patch' file and a
'0-tolerance-policy' branch exist in your repository and current
working directory, running:

    $ git send-email 0<TAB>

should offer both as candidates, I thihk.  Since I only ever pass
filenames to the command, I personally do not think it is a huge
loss if the completion script stops looking at refs and sticks to
filenames only, but others may have a use for that feature.

