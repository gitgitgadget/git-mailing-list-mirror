Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5C282F35
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756253; cv=pass; b=MjikLD42GS7kiRPCYTET9GJlvJRD9HrId8MxqJuioOQpt1hVG6TNP7hBqkauHyDRPuygpSe+ZaG0rUEyCSHD4Y1Gh/wruhYdpPG5qJXJLpDWcWSru+BZtuQgwFnvF5irYjGSg7k6evQU+Cg8XeRkN4Ylc1PGXix/sRuh8QqkSz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756253; c=relaxed/simple;
	bh=6htruieKKRpkrB58Hkp4h2rAP3e7CDi6aB5tS1RSYBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1qbWkEIUsBvfRGpVmkXUqPLGnY6LfFSIRAQ5uFA03SkhaoueeCEBAufxdngMEhY/Smzgfnq1Og1amu4p4wDN1gQQdmcDhq/9H0TM1iPIpRzbAmympjc/rsCyQtpVOmvCgjtUhz7jgv18xvzKDW0KTioaD5jDNtkhP1j/ouon2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX+cgsSn; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX+cgsSn"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso5067421a12.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 11:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782756251; cv=none;
        d=google.com; s=arc-20260327;
        b=MFdmSOFp4pLM5iDWKZKt/Tss/Ep/a2BnVbPKRKBnRU3T4guLuJUtd4fe9CQOH2BSBE
         HbX3Ymgpzc4HFNeHlw0Z91Kxk0Y9h/sz9Q+//VMuFFQM3QKSA07HJ01Na0G7dGTBF2mi
         x+Jt/QgXYQLLSK5mANbh68h66P04wUxk4oMXZH/VhxXzL4Q7IcT6DMKESj7ZP4Y0tEwY
         AfL8INYdZXzs3ynLsBy7cUl41Qxt3KYi1zK14ZuFintNHxRPZAjb2+siAZGfb18yxUOo
         arV6AeI4mV16eBQzYPU9P2O0qmLQjXwdF7xJFCoLoCoGXom3QOgAgr+lRjSJrW6P4tti
         +/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wgFuMStil+Ci3OywpRVKpvlKXRlkPI4t2RElhVF6WAg=;
        fh=IVR3BQbGhZb8D66CLeyAg3IF96fkc33A2ADte2m75uo=;
        b=VBfjXabsLWHu5lTGHmEUBHje/qk6//pzs6cW2QBbWjLnm4HuIrjPTJBwO/neHZyjPe
         6n8EaHTw/+/dyO97yzbCbUVbMJXRtxyUhetNPJEOGxhprd73dhc63KICpRaM89/DTTV3
         7+GnuEZ0umsuFnPgFgO8JqVIn0GQskkINlJILzv9jFMy6YUhiqE1Lh3we2QG90xNbKxI
         7o7bT899tWv7YXNacw73NlveUvVu+Y96DPzYQejxQvdK+DOaUCC4isdGcb65Fb1EGdTA
         tyIu13NwFL5f/sMgEFwzzeMaADT5FUrjS5xww7/6cE7ApM1WihE2X9R5CjiSqv6g83uE
         1Xqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782756251; x=1783361051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wgFuMStil+Ci3OywpRVKpvlKXRlkPI4t2RElhVF6WAg=;
        b=JX+cgsSnaVAoZpTl1hmGiRMUZMvOK1pjpcEASu6E6ISIq0MZ1RFv3t19qvfbIgqA0x
         Jq7eU0OlY48mJClihur/geP4Jnk9VnNsFREmKKJvSUdlKKJWHNiH2AX99+C2g7EXVc6J
         QEeA/+H22rnQL42XviFuDWsR5Ui4a3MRjW3R4kuq7/8IZ8qcrZ546ZVUTRdmoOH7tyjL
         WoKrlb/5hmiZw41ZrykA4i58esuksWNqcyJF0h2IyvRC4vxUPWr9gC0aZFucm88V1Ocx
         JBTnso11+ki4RTziQsuP26VrIea8587VeLLkz4+ogoGFbBH0gzGOOby7Hjx4hSc9Zjb+
         F4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756251; x=1783361051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgFuMStil+Ci3OywpRVKpvlKXRlkPI4t2RElhVF6WAg=;
        b=UUTlklGjyCWmlOGheAazB9Pbu+9ogcyxsnTyk6+zZ1pXiryMtXJIio9ZEhb9i00gdO
         /xDK1BoPkexk52bwYPvsPU62eBXjw0SS29wn55zknmivjAAXyqdfj1N9dyA+ftUCi8SD
         A77DOQqNnTiQ8nj8tfX8+QKOBoFjCov1M7mEDimLnOzOrjOr7oioJXPUj8JROjqFQL/s
         M+JKW4wf3cMuTxkLrDAlt/DVh0qlpRcwRkRJG6UdZyFR960OHCR+oawrB5FvB72ER7ll
         ULl4BhnUaGd36zF1FCUeGCFPMNEObw/JobzJO4N6Vy7ztU7xj9ihUKj+ILSlKl7utfwE
         uoLw==
X-Forwarded-Encrypted: i=1; AHgh+RrsD9OmFikrC4FdrtZuzUI5PmXce456LFJZOvWYZYKDSb0SWB+M0FKjPgelb6K7iFI1aZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsIf9ZegHtMYzVeqjtept1b17Do4TDpBuUWBLfmVrNvXH/wDq
	PWL2nH1oxJ/b/gzdDaw7srVE4xWYipOiGStJfxunzuRmZoGgvhH9wSDAq08fbbgau/9aLJ9QyGm
	6Ffo7SnleDCwlKaboxpHagSOhOMLGO8Po8cfOmtM=
X-Gm-Gg: AfdE7ckQlnXMzCXoDeccl4dOJRgC7YOb72qA1gi+0LINRCf5RqQPwtxRroICaDkMOH+
	J1nOzPcBfH/VqrkxmVaSEvj/lcJjdchG3mj5wASlbHTPM4+U14dJ+/qnRVI7HqQMYT9+lC0Q55V
	RrjbViIVCB5/hklKLKcXL3PIPWeZF0E20bIBBtgNGOirfMISsq/S6e6MwE/mjbOjXg/Au9b6upv
	lwn7AoLDXEFOCf3dEkMyHxmOXgoRZu5CrU8oJ1pGWH7PWyXa+LK1hyKTvjruQY4ZBPLuyC6
X-Received: by 2002:a05:6402:40d3:b0:697:dbe0:de0f with SMTP id
 4fb4d7f45d1cf-69879d61246mr135757a12.0.1782756250337; Mon, 29 Jun 2026
 11:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com> <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
 <akIQLM6xZTHBudWT@pks.im> <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
In-Reply-To: <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 29 Jun 2026 20:03:30 +0200
X-Gm-Features: AVVi8CdFOMUJH8uc4SyYTQfReD3M4zw_rBHnZ0DZ-r0190V-OqO-ykETrP3VpkA
Message-ID: <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> So instead of
>
>      # This is the combination of 4 commits
>      # This is the first commit message
>      Base subject
>
>      Base body
>
>      # This is the second commit message
>      # Another subject
>
>      # Another body
>
>      # This is the third commit message
>      # fixup! Base subject
>
>      # This is the fourth commit message
>      # amend! Another subject
>      A better subject
>
>      A better body
>
> We'd have
>
>      # This is the combination of 4 commits
>      # 123 Base subject
>      # 456 Another subject
>      # 789 fixup! Base subject
>      # abc amend! Another subject
>
>      Base Subject
>
>      Base Body
>
>      Another subject
>
>      Another Body

I think this makes it a lot harder to read. If every commit body was
always just a single paragraph it could make sense, but it's generally
not. Look at the commits in this series, with no delimiter of where
one commit message ends and the next one starts, it would be very
confusing.

> It would be good to error out if the user tries squash a fixup! style
> commit and range does not contain its target commit.

Good point, I don't see a good reason to allow this.

> There does seem to be some support for merges in this patch series which
> I think behaves pretty sensibly. If we have
>
>            C - D
>           /     \
>    - A - B - E - F - G
>
> Then squashing A..G should be fine because the parents of F are in the
> range and it looks like we support that. Squashing should B..G without
> --ancestry-path should be safe as well because B ends up as the parent
> of the squashed commit but we don't have a way to disable
> --ancestry-path (and maybe we don't want to add one). Squashing F^@..G
> might be useful to fixup a merge (though perhaps amending F rather than
> creating G is a simpler way to fix a broken merge). Squashing E..G does
> not make sense because the range does not include one of the merge parents.

Thanks for a good explanation here!


Harald
