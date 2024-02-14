Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C1171AE
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906020; cv=none; b=jU+IjuFOV1qjd9FjLYJNuyf2jXGTx6fa0lrRK1YmrkAoHYWX3I31BbKVpWg79/sux6CD8nhIq7tMVtt9rI5vpPHl+4sNFOZ/6POJd6JRYHSkiZJHWawx4O1MN/6HE9+T8h+Tl/10frUDkALyZIJKu+tabaJ9QhpucJP0KOvqLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906020; c=relaxed/simple;
	bh=anMtlHM94QQLmB3aZkVSMI39KnMBlNbwphnffbTvTqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iu2AvIEDaHCfeARGoY56kwU3SIpto+TzfWbeCkROI1cEdX+x4NRHa8JAUkkouTowGcWpFXA6IG2m8IazNvPifuuptmn73BiLP2j7TNyni9aOnRRaB9wYqLWrkWH/dPTcT5KE1DVn5gpTocUMceOftEWJnVNs5KgB5p/3MHLzL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efAoydFk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efAoydFk"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6078c4cadd7so14084547b3.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707906018; x=1708510818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yXOsxTVkVKvyeOcKHkx1gKSzSGaBrSKF+nr0s57JyyA=;
        b=efAoydFkHJ4JDYK8c7orh/ch2WG3qq4GNi3j1w3tOi/VO1GLrqDHu6Q6XHbDwkBTG7
         Ll72YEjtzpjxJfGtvxkqQ+Zsys1XxXcZo29x7eP5inBrjuI1W5Pl52mtpKluvDha70P0
         Wt7a3sxGbZPSs81T7LB/hUW6sh2c5bK0E2qgup0xIOpCwk39r7nwL2/iw/ovYqxsy4je
         JTr2Uhi4E8EpBkO4TK4oG//mira7BMmQ5pTxkd8xqLpPbTRYQYI21rNsX3O9ly5Vstx+
         7h6dGjdUDLKjD83a6ocIJmbPc9UisMm0ZUM8jsF9flFvWJD4+ofC/9ajjU2M7uo87a51
         7EDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707906018; x=1708510818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXOsxTVkVKvyeOcKHkx1gKSzSGaBrSKF+nr0s57JyyA=;
        b=JFIpOP5JgKnz5NSlYBIRI+HwbDfPnaRxCh5DLRVFWwEbo5MamIcmvjlLjAQR6og/o+
         n9L86ol/2HTd8fQ9u/5My63c+RMHqIGidIPQrz9R2g872MvHZd4fS4PcHXQjgpxA2Y8x
         4g217Gc9xuOfJcxaH6F4peU2XxwI60Assv9i8lkKU8P+6IUQcyWR0xcG1jtA3WMRFNLY
         kdjXUlkNLI8S+xwvMzIuSCadt76JZNpDhI0vDlcmF0OFeGpHsKix5lGaU7KdpJ9ACiMu
         y234UykI6czUIrkg5Lk9myQPkYPD9rqCNXENfcEEx0Lq+1KOP4QiMaFWt4/XjPnYY/a6
         LhGw==
X-Gm-Message-State: AOJu0Yw5iizxVRZKhbGKOnRyCIfosarRGcd6El3QdDInlrmUPOzpFC9o
	bQN9fOM/DJsvrYtO1lnN8wRVENtkp+jzFuxCUk49toAHzDYSTcjjhPSniCG6laEZwFOhWe98Zib
	WgvOH28L5spoX7U5YtVrCQcse8gQ=
X-Google-Smtp-Source: AGHT+IEp3qBQxg6rbxGwlreRRmZJcXt3cEhFf9DsUPx2H35GwUslTjw0EFIua6GYW80YXa8X9XSv4Ma+Qi7HyHMu/+0=
X-Received: by 2002:a81:6cd4:0:b0:607:9aa5:3fa9 with SMTP id
 h203-20020a816cd4000000b006079aa53fa9mr1944209ywc.45.1707906017788; Wed, 14
 Feb 2024 02:20:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cbb450b3-b333-4391-ac83-66c2daf0ae4d@gmail.com> <xmqqy1bo5k5h.fsf@gitster.g>
In-Reply-To: <xmqqy1bo5k5h.fsf@gitster.g>
From: vincenzo mezzela <vincenzo.mezzela@gmail.com>
Date: Wed, 14 Feb 2024 11:20:06 +0100
Message-ID: <CAF2+nma0HZUPevhT7A4vM0rFYF07eF_u9Sg2wRAQ8E2+qBj5uQ@mail.gmail.com>
Subject: Re: [GSOC][RFC] microproject: use test_path_is_* functions in test scripts
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> One thing to note is that you'd need to make sure if "test -e" for
> example originally written really means "we want to see something
> there and it does not matter if it is a file or a directory" while
> turning it into test_path_exists.  The operations that such a test
> follows may be expected to create a file and never a directory, in
> which case the condition the original code is testing may need to
> be corrected first to expect a more specific type (e.g. "test -f").
> The same comment applies for the other two.

Thanks for this clarification!

> Some tests check with "! test -f <path>", which often would want to
> be turned into "test_path_is_missing", but you'd need to make sure
> that is what the original test really meant to do.

I'd have changed them into:
-  ! test -f <path> --> ! test_path_is_file <path>
-  ! test -e <path> --> test_path_is_missing <path>
Since '! test -f <path>' and 'test_path_is_missing <path>' can return
different values.

But as you said, I'll check what they are really meant to do and
modify them accordingly :)

>
> A microproject is not about "doing the real work to help the
> project".  It is a practice session to come up with a set of small
> changes and explain them well, to send the result to the list to get
> reviewed, to respond to reviews and possibly send updates, and to
> repeat the cycle until completion.  So most likely you'd pick a
> single file or two and do the above conversion, while leaving the
> others as practice material for other GSoC participants.
>
> Enjoy.
>

Thanks for this clarification too. :)

Vincenzo
