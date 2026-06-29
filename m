Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907171367
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713034; cv=pass; b=m18zNpcNXe0LmTuvFeYD8WBwplxLFBk7DnQKijNRWvre3BWdpNaH9O1f/vxNmV2AYU7PwvKUIazQtxeJEHaFlQXtt6WCNt+NoWT7bnXzJ46CgMPxuxiaUCfgeQkzoCOaxv96WV3B2LGwVrG/6XjxyZnjAlRaYlInKmP4iEC7Dqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713034; c=relaxed/simple;
	bh=zNt+ncdXlwieh+c7QfkXn9M7AVI48xAu2C17oOpj4j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeSPqCM3qNjZgb/CdqTVQj5+8Gh2gtKSZsVVbXCJfI7uuJOCyF6mRHuLJRj+KF7npCKwaXp52RdA6cYJ9VnnhzLY2gXq1Scf3aL04ObIgEGQe3vcjXNtTqSVhPec2fOmZ42nTIfiETt/9NIiUbu+WS/jq4Nes5CUX9C8NMOwwkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEpTcBHb; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEpTcBHb"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1397e093f90so313352c88.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 23:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782713033; cv=none;
        d=google.com; s=arc-20260327;
        b=UXz2jRU7oLdCwiNyRBQVevKee1e/ORU75wqtLuOvL5HFQoIZfzrf3aLK5pe3ADwzoz
         GO/9wnY20DHmhnWuHLnZ0SPowE7LOwGO6o1V3hYihUVKnQRDTwmrFhbCdkOLpEU+UpHo
         EaJN/dAQ++NKrsQl/yYGQ+p3+q7bpU8TS+qj8fFfHuhipzy+Txnr4KOWdqjUQjgn6/gp
         9dQh00xVII/iCSId4UzpYRjVIKSpqB+K7lRVXqgMl0hsX28Wh9/OLv/mTqk9EUNbWT8W
         TIqWSofqQcwNt7lbVIcoR6to5cmlyYw0YqyOMvzODR9M8cKgKEB2YB0EwltEQ9FRizXo
         0yQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NAJ1AkExuwFrd3t1L4gI9FF0dvtwMy5QARQjJZIn2Nc=;
        fh=awLKVMFOALteoxtHNVryV/86GpgLlmhFCNWdjumvQXk=;
        b=kgyn5bMvg9+vq55nlg5vGUiIjxmWV5gaEoSkNpq5yndQuemH5NJ1Sy1pRTdFYIGbyw
         hJio9l5wcrY1JR8OaE0Ke857tMsn00AyfLI1ehWz2N8kyUWC5ZYHEO7EypGJjETMY1wd
         OwE2bNbajWsRuDcBmKfNVSdDUSTCcCjibq3rbrEg4VXaPvwb0F3Sspu23+kPK74bKm6J
         gdhNterIKzLo0G0OWUerCIcUpbckRv/1qC7gVlRXkaq6fNdmIAvUDbm3UKlnyPLVXbs1
         RAPpD5yl8oaTAuJoggLpENZUTJ5IY5fSUxN2wxetML/hhM/Ef6U/o7wuNRC7CWnLBxDI
         CtkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782713033; x=1783317833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAJ1AkExuwFrd3t1L4gI9FF0dvtwMy5QARQjJZIn2Nc=;
        b=rEpTcBHbeAkUBFiA1wxQpMAuHhmxoPkBGlRGiq/TaoIiXRGb98VNlzbP16LUg0wKY8
         TiHtrZwrcc6YqoJVHge5srYALmlvTLbOBYiwlKf+XbUMy5zKWEaf/xTOGtS42BEtJXN+
         +mTjch3IZ9XWqAoKHOVqRvF8d4GxJgOehETD46ZgR5EOYkcCu75YgOczqt4ErLJzrFhu
         JHVLnutLdhYymxJIBaG/sPJx+6K5go2/qLQf+WULBUBYn5l2VofcjG1fA6KHAbVolfV1
         Kqtf5L36Zw7/LZsEW8+SgYWhAj74YQ2jSsvk7llPRJzbRtHvoQITNLnwQnExFs1DrOze
         xOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782713033; x=1783317833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NAJ1AkExuwFrd3t1L4gI9FF0dvtwMy5QARQjJZIn2Nc=;
        b=srAqfKHhHGCXFcIqMfHu+z0BwZGHQgfXtvUfnuBCSjIWH9tg235iNhdzcSFQh7DGqv
         hf8rQCxgdi1GcjlypxK0J99z9f20nupw2ttgVG5CQF8/UsK4+CyszmLvYA/vjqvtuYkM
         hwZMew7xtC99g0MiPFM2ER+rhtRKveeHwPqBiBxNA/nKheLntB3wjzHW5ow5QwvC495v
         pGpm7jY8oDsBZeRPIOaKNDXZ+PKpksglH7w5fjb754rjcIEr5nZRZN0aTCwd4RMEbZ6a
         ZcREfHHiwhLQDNc7PHNduyiQZY1AXQJUSH9cHjFGAhaKYuTadTUZkpCKdbZhIfMdWFgN
         n4cQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EdvQ5/cfijU9ENxJfy7nMR0fS8zIe/arsfe9qHJs0xH42SCKr/MYpNn0tY5rLaro95NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6cvnKsp+qXXtg09fGlakx6loLrEwL3phoQyPzZxL1RwFUMBm1
	jNU9A8zw5CeA+IybXB8WifVI+tvlVPZGUaN0hkJMd2jHsNiFDJbOOGKG8WGAEd72cUJvT/NelJ/
	+YtEj1IyXwqedGhCMR4PUDctVFr3S75+60ZYH
X-Gm-Gg: AfdE7clLOzvHXkoUFx/sZKIuEGPaixLPxAovSjP89bWqRWo0GiVfxsec9745+bRvlbI
	CdAzaXh1PFVSp0QaRJaSpZN5A+gbLmXk35I4waQGv5V+an8bsMtD7Eu7P2yav2LfMxMhU4bPWBA
	oOKSKy68M79EGj+DcIBU4bhvnrkKcCqCW4lfMAd/cp/u3WXh8mz+KtCPBpEP+IoASEsrR24o+Ic
	cKCXgC/S1b1hh3icjwTkjoHFutq5HlxvrHejM6oIMEyblBRCuVDH5Sw24ku1zTG85bHzQncJ9QR
	SivI3b4hHCyPkBzfe46BQK3TVGWnESpVbCe2Pj03yqf0Nseb0OFLQHK2jQ==
X-Received: by 2002:a05:7022:f411:b0:139:c4e3:947a with SMTP id
 a92af1059eb24-139dba4ca3bmr11245637c88.15.1782713032668; Sun, 28 Jun 2026
 23:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626075037.532164-1-cat@malon.dev> <20260627160813.1074201-1-cat@malon.dev>
 <20260627160813.1074201-2-cat@malon.dev> <04d1a7d5-ef83-4728-b816-5cdf1cb4aa25@malon.dev>
 <xmqqv7b34snt.fsf@gitster.g> <eabb8169-2c13-4961-9b21-f44b1fa66f70@malon.dev>
 <xmqqbjcv2h3j.fsf@gitster.g> <18ad7c1c-5ddc-4f62-ba7c-5cda53f5a48d@malon.dev>
In-Reply-To: <18ad7c1c-5ddc-4f62-ba7c-5cda53f5a48d@malon.dev>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 29 Jun 2026 08:03:40 +0200
X-Gm-Features: AVVi8CcXgcY4RVczpYj4SLpXopTWe4IpajPktlEQ4ZwCDPQ5qHAXJ052w9QmG18
Message-ID: <CAP8UFD3Z0M_1NEXGcAxNZKpRUQiSkHZLTEvNNYushKA_PoPgjA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] environment: move excludes_file into repo_config_values
To: Tian Yuchen <cat@malon.dev>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, cirnovskyv@gmail.com, 
	szeder.dev@gmail.com, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2026 at 2:58=E2=80=AFPM Tian Yuchen <cat@malon.dev> wrote:
>
> On 6/28/26 16:40, Junio C Hamano wrote:
> > Tian Yuchen <cat@malon.dev> writes:
> >
> >>> Wouldn't we rather want to try to be more strict and say
> >>>
> >>>     if (!repo || !repo->initialized)
> >>>             BUG("repo must be an initialied repository");
> >>>
> >>> here?  Aren't all the callers of this function supposed to be
> >>> dealing with an already initialized repository?
> >>
> >> That makes sense, but from my point of view...
> >>
> >> 'repo_config_values()' already has a check for 'repo->initialized'. If
> >> we're absolutely certain that the 'repo' is initialized, wouldn't it b=
e
> >> better to simply remove all the checks inside the getter and leave the
> >> judgment to 'repo_config_values()'?
> >
> > Yes, that was what I was getting at ;-).
>
> A lot of CI tests are failing, but that just goes to show that the
> "bugs" are being properly identified, doesn=E2=80=99t it?
>
> It means there are a lot of "invalid" calls in the tests (if the way we
> define a 'valid' call, i.e. repo must be initialized, is correct)... It
> seems that code like 'if (repo !=3D the_repository) return' or something
> similar is inevitably going to end up somewhere, even though, as you
> said, it=E2=80=99s "sweeping problems under the rug."
>
> I=E2=80=99m not sure how to proceed from here either..

I agree that the best end state would be to have no `if (!repo ||
!repo->initialized)` check, but we shouldn't have to get there right
away. I think it's fine to proceed in several steps:

1) `if (!repo || !repo->initialized) return NULL;` allows us to remove
the global variable and use getters which will help us in the next
step.

2) `if (!repo || !repo->initialized) return BUG("repo must be an
initialized repository");` now we want to find and fix callers
(including tests) that haven't properly initialized things.

3) No `if (!repo || !repo->initialized)` check, as we are sure that
all the callers that didn't properly initialized things have been
found and fixed.

So I think 1) is fine for now as long as we properly explain in the
commit messages and in code comments (maybe using NEEDSWORK comments)
that we know there is more work to do on this in the future.
