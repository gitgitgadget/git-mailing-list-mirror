Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1B43DEDE
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020889; cv=pass; b=lUNrxPjYQJ+H13My5OncRe7JVyC2YabtssVmlZpOR2d+ySQWJjKdCe5GIfC5Y3wj/UvRJtAqxKIb1saVOsoy1Lh7r5A8PsXIch8h8vYkS0qs7/fUWU/1T9of/chAppUD/eOIVFiJCurX5MsnGYYpNceohW5f6/ICvZesH9R/ALQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020889; c=relaxed/simple;
	bh=+t8w6hH2WrYVsDbwVEcedGSq9ZESL7oSkNHIhsbZdTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yyeq9Jaiu5tOZVrl2XPOk923V8+YAPsGbp8a+ZROvMz9FouRgVJoRlyfZfxNjrVntRS3hic5M/3zqqM82WLsNiIBdvS8arzPFYG2tDrvbcoZp5cBIEDYN+D1xg/eh/k+crB0JDYxYN19dnNQLyTqZYDcnwD0ASkk+n3cTj3fOLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmyNV0Wq; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmyNV0Wq"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1744fso5593572e87.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 13:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790020885; cv=none;
        d=google.com; s=arc-20260327;
        b=ERBmJBL6wiJMpx/PTYNrOUTZIosgOGTEIKW88tySDfbiB284ATYOoOf3PJl56oR6Xk
         h1QETODdzlJq9thBP3o3adt/J3B8Hp/DU3jdMqS/QA3/Od7bZQnt7lDkoNAQYEOnaf8H
         a0ywKdh7TeD5fZRr8Y2nIQ2d4SAII9PpsmpLtE4Kf9Peda/qLcPF5MDl0kZrHNnEH1t5
         /TBFGOaGAQNM5b0hstzmFpu7LqN4EJBGsR1fT0qCTXMST/Xha1ZjVmTqWJAyz4ORrvnS
         BsdP8eezzPidmtzzkoooqxJHqpaYMK5mJ95dl0I1vqbbAfXMEqsFUFQgYRgy0sRRksfl
         fY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0DEShmWKkFgHva7sw60c9905HiYY1fzaUl5d+mN2sVc=;
        fh=Z7dcLEAaNB5WfDOIiuJHhuN2t/+UV8Jr3gL7ZRfiE5k=;
        b=SlpJicEQnW5lgmQpeD000bIK9ytUzvN92/mJgkLxQRC+8i15U4fIvH9T9xzeOzqwzB
         FmbE5c7WnFlpG44mQeCUsaDN+Wr320RjTJPt/QGbh2LkGobq2L2J3R9GYlPiUSYAfcyr
         zpvM4J2oFV299VInJg9cLFxAmdRyiT4rg4uBHzpPxJyU8uDMAeArJKZvRfJ2aR9TwBCj
         9wIr7sy4554zO63XXeiWvmYjQLCU8Pe+iKuZRywrKxD0nEo3jTEwf9wGLpf+oUWinBBy
         xOq7zK9TwN2sRW1R6nVi2rvTPkOc5XdwOq3jfl56e4lqDAVZO1m7nR3OrjJRCb3xC5iL
         yKnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790020885; x=1790625685; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0DEShmWKkFgHva7sw60c9905HiYY1fzaUl5d+mN2sVc=;
        b=SmyNV0WqRySxIc2TBW4CHCNP6UVeHCp3tcHYl/a3Yl6J5Ovg6TzST6hNdr4rfIB+Bx
         9V1AtrJkTXlxDQmUFCQXvpraak7QGZ3w/CyjNzQxVkeoINhwZ4apo0T6NDIkx88I5drL
         Kf4j/taNfGc9pt3fEiI8Liq9PG832b17LUebDM223XUB0WkEzjVqClixE7bc9DWeq+A5
         TLurKnaeH72FcVTWz4kS3jCorwQegaRj53hgyHWzG6ChIlnqtIX/LXNb8BwkwUhyXnbf
         cvmqZkZ9pCgZ45bRfil6IOHLeLikeDFLUt2GAD/JZ27RCcDLk8HxqVmqVg/YOrjthexm
         xsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790020885; x=1790625685;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0DEShmWKkFgHva7sw60c9905HiYY1fzaUl5d+mN2sVc=;
        b=V5A/rOhscFbeXHXD+H2+fVDx8uV6R/oVcvCxM2oWq/06ZQkNNwuXpCMkZ3kOf/c0cP
         7T5BngqJN0DUwg//K8uwWkxlNxll2Cp8946L+TPEDBjnKt7xHxZ3DhQ/PeZbALbBVSmS
         oIzoIWpqKMb7ZgjjhkZjt/pdJO2zC5hVLJb6DFtrl4Q9PuaXo3VSf4/RWdf0GSTZlgzV
         BCX7P1+F1oIfPQLCoX3CFIkQGvJ7x4rnLiyzlCzx0IlpfLmByqiWODqlsOxyIaslNG5I
         bipCx2uRoWzpuNVFOaRM07K0rr0hMVwRSFzDQTXHpCQPYZ3P/Th4+4XoJLhYK5hU/V3U
         5MIg==
X-Gm-Message-State: AFuF++kbW+HEmxmUaiZclCBlL0cGh6DZW4hsUcqZ+y7h6n2WmAManl1v
	UtQY1H7PLFNqYN2ym+n3Zxafwf45kTxJzgmXY6rYM1TzHQn5ueqovz1JnmtNo8OU5CXQGHBjfK+
	xb09xPGhODXqmJYxeTQeM+xqHI2NtZc0=
X-Gm-Gg: AYBFou2CKD5n5x12Tvtf+KVoQCpYxDQOafBBrzqC/t6WCpcL55uQAuJX5B5eJseBazW
	30EsTcQvIeq2v/05t2r2itvlYtBhPtuOk/3DkvLz33NaT+4eLB3xwkTu7uTpnKtDNqsk/iNVoUZ
	ro/5rQ7Cgg/h2XApF7/hn0F9N5ZuZzlWEhCf77gjhQO1uTaRGSGFCHpZpeTB/mfnuqqNlLcNTa5
	VFpoQq5ftNgFpniDqryhEyLd4uhPqnoxiZGVpChwP8q30xZNm3Z2DEw8bt0F93koZ9o+w3Prfke
	Sb0S+rw4DfrV4DVjOYOAsyozvlIpCXyNPMvNnK5sseqzJuRRE7fE5qtGym3+hkbfE4Cr9IWJYbl
	Ss7h8eH66otLqPTIV4oJbOBtV5EpKaEuPWT3vo1AAKCDE0zryjzFJGZbqY9+GMUGysqlMAu4=
X-Received: by 2002:a05:6512:3b24:b0:5b6:183c:5c95 with SMTP id
 2adb3069b0e04-5b8c18598damr3983292e87.51.1790020885117; Mon, 21 Sep 2026
 13:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLa=ZTWGJZCmZnPLt5az_w-6YkGuQhQUKyJq6X=VFQL1T_6ZQ@mail.gmail.com>
 <cover.1789901584.git.maciej.ciemborowicz@gmail.com> <CAOLa=ZR4V45R0zST_gxb3FMSWCwbi2MFN=5sCzhTAQfuZrRH7g@mail.gmail.com>
In-Reply-To: <CAOLa=ZR4V45R0zST_gxb3FMSWCwbi2MFN=5sCzhTAQfuZrRH7g@mail.gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Mon, 21 Sep 2026 22:01:12 +0200
X-Gm-Features: AcwNN1Vd7xxJC9T0zg7xkQw2FL-PvUwQp9lgwyqDgBo_5u-Uw7yh0CAwvrMqz2w
Message-ID: <CACQ=SRG0q6Ezre3Z2bv6JJw07KXnUn2SDxNLTt0FqbwEdcbOqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] refs: report old OIDs for batched deletions
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Phil Hord <phil.hord@gmail.com>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Karthik Nayak <karthik.188@gmail.com> writes:

> This does break user behavior though, previously we would never fail on
> pruning refs, but now we would and in a all-or-nothing manner. So
> perhaps a better way would be to use the REF_TRANSACTION_ALLOW_FAILURE?

That makes sense. I will use it.

> Here refnames is built, but below it is only used for the non-atomic
> flow. Perhaps, we should move this into the else block?

Yes, I will move construction of the refname and OID arrays into the
non-atomic branch.

> Nit: the formatting seems off.

Will fix.

> Curiously, was an LLM used to create these patches? If so, please do
> read our policy in 'Documentation/SubmittingPatches' regarding AI usage.

Yes, I use an AI coding agent. Thank you for pointing me to the
policy. I have now read
it. I reviewed the resulting changes and tests, understand the
implementation, so I take responsibility for the version I submit.

> Seems like the other branch condition also does the same, we can extract
> this out?

Will do.

> We do this in the previous block? We don't need a new iterator here.
Right. I will append the refname and corresponding OID in the same loop.
> test_create_repo is considered deprecated, let's use git init
> directly. While we're at it, we should also cleanup the directories we
> create here.

Will do it.

> Why do we need to pack-refs?
It is not required to reproduce this problem. I will remove it.
> All the commands above also run in the 'prune' directory, can we put all
> of them in this subshell?

Yes, I will move the repository operations into the subshell where
possible.

Thanks for the review. I hope tomorow I will prepare v3.

Cheers,
- Maciej Ciemborowicz

On Mon, Sep 21, 2026 at 3:57=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:
>
> > The reference-transaction hook receives zero as both the old and new OI=
D
> > when branch, tag, fetch, and remote delete refs through refs_delete_ref=
s().
> > Those callers already know the values that they selected for deletion.
> >
> > Teach refs_delete_refs() to accept aligned old OIDs and pass them into =
the
> > transaction. Besides making the hook records useful, this makes the sel=
ected
> > callers reject concurrent changes instead of deleting values that they =
did
> > not inspect. For branch and tag, this restores the compare-and-delete
> > behavior that existed before 8198907795 converted them to batched delet=
ion.
> > For pruning, it prevents a stale scan from deleting a ref updated by an=
other
> > process.
> >
> > The values are already available at every updated call site, so the ser=
ies
> > adds no ref reads and retains batched performance.
>
> I still have some concerns about backward comparability here, since we
> go from a delete all without any checks to a all-or-nothing situation,
> which can be an issue with commands like `git fetch --prune`.
>
> Left some comments on the individual patches.
>
> >
> > Changes since v1:
> >
> >  * Document the conditional deletion behavior and its race protection.
> >  * Add tests that update refs from the hook's preparing phase and verif=
y that
> >    branch deletion and remote pruning preserve the concurrent update.
> >  * Avoid printing deletion status when a non-atomic prune fails.
> >  * Use a local string_list_item in refs_delete_refs(), as suggested by
> >    Karthik.
> >
> > Based on maint at e9019fcafe (Git 2.55).
>
> Might be worthwhile to rebase on top of master. Seems like there are
> conflicts with d38352cd43 (A few more fixes before -rc2, 2026-09-17).
>
> [snip]
>
> Thanks!
