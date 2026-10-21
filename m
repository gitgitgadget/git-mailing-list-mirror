Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792608742;
	b=eluRD9P4CapBj4Js6+uDNd6bLVYGrDcQVuBmcSos36jrl0rYu5Po+vKiDMC1HBEzCN3/
	 +d/ZzSUSDAfUhpnyEysPgnlVFaJUh9uEOdCne089pMu5yMUBY2zDeJcWY5B2PN1fNl9GW
	 GFcVvIYV7zKddSrxn054XUxnMm86c9os9QhW6jWu9PRNH3aazWATYe7dzy8ZSuvBUafkw
	 gq+W8OdB7eEXx7Mf8Bj2h0jpxwjb0UWm9zg6OsZrVmO53WL6innJCSRGU9B4OIPsi3rgW
	 TIK2y1dtO9WIwJ32SlomF5ffQt0eo+uq2cqatK6ylDXzLLwKLk8KP4/+I0K9n345Fyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8j6kaWukO6bOyVLQDZfeiTPo6sZEqbXzcMlDaaVXCDI=;
	b=zQY6R3kI30hVWTv2jBMamp1nAGU1oA0r9+Fvj0jsrZbElLLqgIZZCdCZMBj8b/nWMkvC
	 O2AwWUyA6Mr2N2B0CWaSstjZUqv5pSo39QS52P9wD8xtJ1y8drsGRcgYCdqJbQa8s1XU/
	 4w5iGoPAwoaEkXTHBXrQDDfq2igL4MFtc4aDsXHF1BUZdvE6dcn89xVw7sWnMwez8hZaE
	 egQzgyg3UI7y3BP9cHGstbXLfCwLacteur71AQYe1Nbke9jcxWbANPH+LL4Hu7d4xrpD0
	 BaGPlbsMnFJ/ScxHOo1fDDZdH3J84YYoJaehiBQuE2haBSreF8AOtieyQEEvCR8k2Dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K5qk31mj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC8606A325
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CDC8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K5qk31mj
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so900340a12.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792608740; cv=none;
        d=google.com; s=arc-20260327;
        b=gwoHRosoPTspXVeQ1AVXbH+QIi947yesZ7lX9xbaZhM0bi5H+7pyD+pEEoS7j+O5Hv
         C4tHhJKSQJzQr9tkgO6lFbx4QN4rFHCZEr+lDBS8Ulif08yS16lnHfxkPY3Yegl55tOB
         oZroMif0YFCUhiXEFof3EQqlUQLH/fEt9HIoN14aOfZbHSSvaXLFqF21pi97muH7OTyl
         6sUTpx6/GjmgSFSvWS8Qqjrvst7we0bthbu21vwd8t+qMJeq9jtoIMbxZXQwTm6xcngD
         UvI0t9nIcl9xRxyYT1zkf4cBFaIY5UzGwE03rARvGvT2n/05IS9VUyPkFqcIysshiObw
         EvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8j6kaWukO6bOyVLQDZfeiTPo6sZEqbXzcMlDaaVXCDI=;
        fh=FMEmb62iD1I6L3AHBQJX5/uztIb/gwNOWIkmWzc389c=;
        b=RaeRpqHJKOFED+PUm1xqlEouYQtWDzjvK9JFZEfvIHrbRp9euRmMoXlh1d7UkNd5JP
         rVKi2CixAvECNwP/5klFMc3mOYei/OhS3jZDG2gpKTREo/wy6RaLT8X8zAMTdKSDH32t
         +tYhvfw/yUmAqL8ZJAAluwkCTavbdKSqwI3sWr6i09/vVyoAFAI3CEAcQVCNca13VgC2
         paWjeJMfRjfgayCgf4uGlS9wJpAiwWd5JKnkWEdj94BSxSbSG5kYMMR//EoLeZFWZxiV
         VqbB/DLTX9ISX60N9obJLbdEpKnbPpwce9duFPzDEuKHdmFyPN7+i/qld5a06l0813Bi
         uzIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792608740; x=1793213540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8j6kaWukO6bOyVLQDZfeiTPo6sZEqbXzcMlDaaVXCDI=;
        b=K5qk31mj2n5nmU7JZGv12GQphpR7CX4nEUkpsKaL71F3J7SQtWDPGnGYZ9a2iQ19pC
         01R5wKDOx8Xc5UaLW4uKoL7MN0u0FFeRHNzoMquV36eWRj2QDmrcuPD2whawXMmhDC/Y
         0ndPFOG35tk1vfgiyo7v4MRnHjkv6r48kTwQkvzJWWLh2PVXkBENoDgpdnx7uYEcNNmd
         o+jFpNsq7fIz+cncL/24mrnfKPD0N7MoNGbOXqpkc4b24tU2M7M8bwMmLv6CQ0YDP7+6
         aK+A1xFDnI8+xTr0LXxo3bMi6x9epMEnhPFPtEVhoHbfbX4pShbo4sCqTFoqCrXCeeFR
         5o+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608740; x=1793213540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8j6kaWukO6bOyVLQDZfeiTPo6sZEqbXzcMlDaaVXCDI=;
        b=TSahXTdgqjkpUtYViKVOepawls6c79xHSbC+XIX6EXOMNLmPIg8uvn1fO1o/z7Mv6n
         XbpkOGNuXOlAySU2HNbzONoAS87zIgZhS38+XyAFHLoh6wsA89o7E+mvk+DJTiUW4GSh
         BQ1gUe7D7q9cg5YGmmuVrXe4oMzmgfkEpDQ3oTf9ddMn/kXxxyXX0ESpylpBoOtjUsh5
         hN7hfKYkAxj25xFG7KaKrzI/qqDYY3JAOVD502tEZ/YtW5ZckvfeqRUJeDC5+MDODx/2
         2TCRiKqUmtJp90oBT9bzx0OY9vOGvVg9OYJ7a6zxRmUCLL84+oYdP5ino58VL9XtMqzH
         1pTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNJ/jwazj0/5gyEvLCw7PhT0h/VWQYw8ZSsoBN76o7Otzi3EN0hUVZ/OjRJy1UCEYqYJo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDnDYe4hXe1qwnwkeXtU9h97v7At1mj6LLqZa6mCqcyE1+OlND
	FK4UAiol6afd8WopmwASsMMpsNR9jWUXZoFDxl/ycfYZEtsqs/OmT7Zmn6ng/3rUPSQd/fZpKOf
	OZgG5rr7eOPPJ2uUsWpQ0JAlLSXfSrkw=
X-Gm-Gg: AYBFou2SEZT6EJjKxJU/ngpvU0OdEfjfuvotgT4/r5cPw4mRM4mAJhnGQC434wNqJJP
	j1tA5MKI9/OLKcrol5tsGtBQxROXXOg9x2K4wR556DWs5H0W6UIurUtTStygOk8gmS2L3YrzuII
	X8crC7J12ZJrfx4gw76BVSXDzz/duZHgF87ApA6wOlAOHGPQamR2fqQN371rEFu4Bz3azfEBaUD
	ziXTJ7gzSMRWVvAMa6RkstIlGqT+Aj/FbJmNaFJMqaO7Z17ecWOhCjvqsTgDAdYGo+znKBqxmfj
	CWa+pjKW38ommQBCCXxkOBu0iltb3DQrgFPz8wYH2H9aBZ4RztWNhwS1lrKl4gyIzETxBGtKdDL
	YVB2M+ZvyvIkAdle3KZrjCvcZBOJz00jMBMa2
X-Received: by 2002:a05:6402:2751:b0:6b4:12df:3ee0 with SMTP id
 4fb4d7f45d1cf-6b412df4127mr1806094a12.34.1792608740196; Wed, 21 Oct 2026
 11:52:20 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com> <20261021173503.70887-1-me@jaspermayone.com>
In-Reply-To: <20261021173503.70887-1-me@jaspermayone.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 21 Oct 2026 20:51:43 +0200
X-Gm-Features: AclHuK_RYPGPMMS-vqHOmLF1wcD9Ep2wQQaSNLJ1SWf3o3_poTnvGlSrHZl0FK4
Message-ID: <CAHwyqnWnp0W17TXbXgLQPaGuwasqndgoPHV1CL3mBpfGFYadtw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged branches
To: Jasper Mayone <me@jaspermayone.com>
Cc: gitster@pobox.com, git@vger.kernel.org, ben.knoble@gmail.com, 
	kristofferhaugsbakk@fastmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> But the false positive from my v2 report is still there. A branch that
> was never merged is deleted because another author made the same change
> in an unrelated commit. In v2 I could turn that off with --no-squashed.
> In v3 the cheap check finds it, so it happens with no option at all.
>
> That is the case Junio called "irrelevant", and he suggested that
> "--delete-merged" stay the strict "my commits are in upstream" check.
> The file contents of such a branch are in upstream, but its own commits
> and messages are not, and the user did not ask for the looser meaning.

My sincere apology for skipping over your post before.

My branch being pruned because someone else did the same thing would
indeed feel weird. And it could be stopped by doing an author check.

But I question if it=E2=80=99s realistic at all. The code has to be exactly
the same, and I don=E2=80=99t think I have ever seen that happen, I would c=
all
this an extremely rare edge case.

And if it did happen and it was *incorrectly* pruned, it is still not
completely lost, because by definition it is in the upstream already.
So why would you actually need that branch? (But it won=E2=80=99t happen)

> So I would still prefer the whole looser check behind one opt-in, with
> a config variable for the default. The cheap check and --squashed could
> then be two levels of that one option, for example:
>
>     git branch --delete-merged origin/main --landed=3Dfiles
>     git branch --delete-merged origin/main --landed=3Dmerge
>
> Users who land everything through "Squash and merge" set it once in the
> config, and plain --delete-merged keeps its current meaning.

I think this is pushing it in terms of UX mental load. I will never
run this check without specifying the highest level of pruning. I also
have another topic open to be able to skip the '**' pattern.

It's about giving users the simplest-to-use tool to work with, not
endless configurability for a command that just deletes merged
branches.

> A branch checked out in a worktree is still skipped with no message,
> while a branch with deleteMerged=3Dfalse prints "Skipping". I sent an RFC
> for "git worktree list --merged" about that case:
>
>   https://lore.kernel.org/git/20261021173350.67854-1-me@jaspermayone.com/

I'll take a look at that after sending this, I haven't yet. Thanks in advan=
ce!


Harald
