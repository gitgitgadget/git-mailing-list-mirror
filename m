Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F331E85F
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773971385; cv=pass; b=d07lBIB9i+ygITvcepoW45kRvtUw3liXAM82OU60wbDfolgOFpOY2xkgCgZVbBhCFtyOTjpnH8PyXD9n4O22ABzdQNj8gOWCXCVql8His0bl7jWw8ujxpLEb7xX4kT9h8RrSfAKvL60bx5mUjh07bgmkKXbBHYLvF1nrnBnU4dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773971385; c=relaxed/simple;
	bh=vuDYE21QKBOiXy1k4ukFAVgvejpOfLjmJ9ZYeOy0RAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhvEjDoB1L6G8OBCp2ADHSs5jBqrfbyzmrMUU4K67Z4efNdFs+s7SGIesUTI8iRYJTGSrjBNSDL0xKbTl94i26A4Ovvz94LZX0IdCUXJzVvwC9PetiKjvIAB9MP/0/DqFzoW/xH2XOHX1nWv9x18dA4Zogj51cH3nguSfI8CWRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWR+9Daq; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWR+9Daq"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506aa685d62so9769751cf.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 18:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773971379; cv=none;
        d=google.com; s=arc-20240605;
        b=Ru1AlRysb2KFN9ed8iis3kIvVDPUiqqMHrKHdlW66D0spDKNpCz2T/kKGGR7lFAI/0
         /tEy2Q5aLm5CxzUGq+osX7eDPg9AWAZBgXvtuieEkdT/WDHSGBYv+r3+Eo+uprw85Z1g
         jesNFbv7j+mGR34Pu2fl1Y7KHJWty/z4d5rf0Rm6uoe7FNier8IHjsmCgj2Ql5idEGq8
         hFd8H95QfwFJ3AKz8sCxVAGIam9bcwLSu1AReO+WWfx6n9Y3/FIgeHLddvr/vNkOQdXs
         XfEiy5YFdA3O7O/bodsWiLfXYQGfwVRvVvUj/AFmT7A+ksTaJktoHrfPlLYqdskL021u
         Vveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vuDYE21QKBOiXy1k4ukFAVgvejpOfLjmJ9ZYeOy0RAo=;
        fh=eC4t7QmPGd86qm5k/PNwvOgRAa2To+svQJwE+ADFrro=;
        b=BlJZvIbBh6KBwmfwHWrqgo0wvl4QupZw76iDKwx1MEHxjViIbt6rDY0zagMZiv4tln
         3WjrXV6xXS/ytczoCpwjKynUahxRtttfcSCRd1rb503pxNUGldjs8ENNOqKh7mPLsZo0
         TvOtv5F6gZz76jH0AfUe2KPWVgfFOu+bHfI8NagGDR4+QYQxobkSgJ7wv8oeRGYW7yiy
         WxKfrB3NM2nzWJuz29wj90HzMYszHhBbpe9dIqN5VxsUhPccz/UD7lbL/n/pyLlQCvrb
         oqtaq6FQZ3xadGl+cz6z3uv4+ijsLg1DHksEVZInRDEOtHh6gFUEzIedEbgQ43qbnnC1
         XT6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773971379; x=1774576179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuDYE21QKBOiXy1k4ukFAVgvejpOfLjmJ9ZYeOy0RAo=;
        b=NWR+9DaqcBGucooy+/sEyGE4Fw2dZVR9uXGCx18GQR8/z647Wwlf0ChwSZpQDWdiPB
         h4WKePOG2jo92+Vz/vv6oZapvqBL4raz+N5GwLBFM4P/XTY8EB61r3TjXkkaU7dMqlV/
         FVbcNLVNtCHcSfF7gaXB2hS8dwNLLOh/ZY2NzzwNh/BUzu8vacHcM0tGHuP9rHeMm+ay
         a/XGtW0CJzGLATMyp+c6crBrITXla81AaxzbuD7Xk7EocS1p0pb1gfUpfZZgp7YQ3S0J
         iTHIX/izWt23FXo0QNp6U70LX1vTP97pgcByh9dHHLYk59cIENMoJfIWkkzoGd7X2zEG
         0dHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773971379; x=1774576179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vuDYE21QKBOiXy1k4ukFAVgvejpOfLjmJ9ZYeOy0RAo=;
        b=kVQEsaR8P/grYTnHjKVbuJ6JPkeoNUf8vtURMSr7b48zOMsFaGMLG4ALDlWNoEfIG3
         dTZk5ij2ShXulTcep6LRhNfpKitbpCOSpUrpI67xCTF4m32lRpe9e22Ou81XUoMOBQ5n
         Jd9oxz0Y3nNXDO1a6hFnojXn6JGU8xvjKqh4qUoj3wN39wbtbVM9eHbwULj0R/kug82i
         7IHrRuWMAueoVOiIaNRKTe7lhHcy5Qz3TSXzuFRXojksep9ELsXcWtuglGrDFLik0M4g
         oGabB02k6gmqNYaFYwXnKiPg+n52oJfLdzlSjj/WGLOmEm6nOeMlxSX9/sRMKN7UGNDt
         Ov3Q==
X-Gm-Message-State: AOJu0YzyGXjeH4/2vhgl3hLTo/qOxcW+HNZKVcEqw9US+rLMVMeTD8L4
	3uKRJ1htjkT+SrCbKIo8tej1YXxIqMDF+BJ4a4qjH3fC9P5yQKsgxFXkuNeK1Ktsln+cLNhxsR+
	chqPBIGBgFgaEf3qsyZKtNNtH9Wxiu7Q=
X-Gm-Gg: ATEYQzwBRsVJ/MSa+NZx+IF12GDTXL9ZYWQUBrzej5Avb7xyUwN3/IOkIL6xdOSVDxf
	DsscQLDJAAKNU80BLz68XtgwtAATSYnC36l9K+dK0E6sT+4zI4t4XBYrSbMx4Z1mVO3NQ6PNLfr
	6UMBsRkIMSGrf3nwCoNecVZIZN4JGAB5UTK4XrsOw43Z1h5aftvWtJCLaX2iRXZNHs8iZvqTd3G
	we6RglSZqHcKoHZFuzD4uGcdtIi3FOF344Bu8SVtOnsnwxT+aqcvBPl6BJ3bX+8bJqDieJFrI5i
	DoBAKb8cTVEnR1gOS7obNKMrNVnoXjunqvVp14vUwYrBO3CBUq7224I8KTWMVmj4Ev7JDD6gA00
	YRKSbcYrZjpbU9/vrIbb+lREoLv7rUYZ9t5UQ
X-Received: by 2002:a05:622a:4308:b0:509:4db5:88c4 with SMTP id
 d75a77b69052e-50b37541beemr15902641cf.53.1773971379249; Thu, 19 Mar 2026
 18:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318204438.40075-1-jerrywang183@yahoo.com>
 <20260319033641.38458-1-jayatheerthkulkarni2005@gmail.com> <58874877-D2F4-431E-82FD-722D8A2BC790@yahoo.com>
In-Reply-To: <58874877-D2F4-431E-82FD-722D8A2BC790@yahoo.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 20 Mar 2026 07:19:28 +0530
X-Gm-Features: AaiRm508Q-IB9bcPmXgtCCwUhGl6RHcE_kd3WfcQjehyO8AQ3Y7tXG2dKQUIjh8
Message-ID: <CA+rGoLdjCZfDnvyQ+qiJn4xhA7F5cj8Mouc+pG9vbrb6ngoxVQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] repo info: add category/path keys and --path-format
To: Jerry Wang <jerrywang183@yahoo.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 2:03=E2=80=AFAM Jerry Wang <jerrywang183@yahoo.com>=
 wrote:
>
> Hi Jay,
>
> Thanks, this is very helpful.
>
> That makes sense. I agree that checking only
> repo_get_work_tree(repo) =3D=3D NULL is too weak, and the
> "git -C <nonbare>/.git" case is a good example of that.
>
> I'll keep the linked-worktree / separate-git-dir coverage patch
> separate. For layout.bare, I'll first add tests to pin down the
> intended semantics, then follow up with a small repo-aware fix,
> likely with a repo_is_bare() helper if that turns out to be the
> right shape.
>
> Thanks,
> Jialong
>


If you are a GSoC applicant(I am presuming) I suggest not to start
working on patches
as you might step on other people's toes.

Similar discussion here [1]
Similar official info here [2] in the _Don=E2=80=99t work on a proposed
project right away_ section.
Another similar discussion [3]
Similar thing was caused by Eslam's patches which overlapped with what
Lucas had previously as a foundation [4].

Regards,
- Jayatheerth

1 - https://lore.kernel.org/git/pull.2242.git.git.1773766519857.gitgitgadge=
t@gmail.com/T/#m9506e0856630c9ff962093d59cc9477bd39ea6df
2 - https://git.github.io/General-Microproject-Information/
3 - https://lore.kernel.org/git/CALE2CrTt_2-9C4zCrZPBabtsWY=3D+Mk-bH4Jaemk=
=3DyHtfpoLjfg@mail.gmail.com/T/#m002015a8042bfe2717887c3ada9afd645615f50a
4 - https://lore.kernel.org/git/CA+rGoLdTc2caDUsQedpegL+T4MqwwiA62uuDSFSawA=
T5vcPvWQ@mail.gmail.com/T/#t
