Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270283382C9
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978466; cv=pass; b=KFR2f3hg54yMN4U95tgog+gLzct7ZtKffuBYi5rb+bHlKmLjqenWXgRVaLWFJQPkd/kRZsQUzBbJpBRhwzO9KQBlfKJ0NEaXZyN3yNkrIZHsyT4cFhHGuwLjVzndmw0nuzr+UVRsWcpQKuRqr0k6FwpYbHzRQqO+a/3tO9YHGX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978466; c=relaxed/simple;
	bh=XMeEX+FL4k2ujOEkDIiythOIbswFPufH0c6Ex5OoULc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUXmnbg/CK2G5vH/BfMgmkudu2ZXCSZasRvzPpIZqo1W/cj1lCO+I04u8OA03DKdq21dgE6MzkJCMWQdAW254F8coZVjZIHHrRBY3J1iUPuRW2XP6xGxhUJ03utl9Kv45sLfc6QDNFmlRw2O1rW0kKUPK6PyDQ8IaFjf0QZxbng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODr1fIYd; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODr1fIYd"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4a451915d8aso255099b6e.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783978464; cv=none;
        d=google.com; s=arc-20260327;
        b=PT3beBtZhzjFXVVGP9zCkpjwlys2WG6RIpoFeqj0xQOKtc2Yp4VJKjBGTDDSX7iCiB
         BSnImlAcT++gdgienewMU0j7F6VVjoitsUamoYHmX47hUrFeDGn1Igmu4n2to7kWqSqY
         ibiNSnUWciHBJ0PB4IH0HR4IPDW+6Bc4/FiQ8ArF54/ZJY6Tvn0pbqIBNSJsS/LYxYW0
         H+6VI6EBhz5rrSta4E6KgnkIcFVSMhPaUg2c2+63rrn2xr4sHT+V1JT9zgiXzY+OmX+f
         kM1wNK1gbd8GLeUMY+T2VQCjOSjZVs/zYZ9wtUiT8hr5NV8ztehuZmhGSG4lKL2m54ce
         g5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zuafqt4lfPo63yyPcb/0gm7sGGLEfNiUS7CIKOVfmYI=;
        fh=VHDmUbx8fjkdN75VWN5CTjkglZBzVlasQgJGlwhruOQ=;
        b=cjc5WolKIGTSCp2vWPYN9LyXoK4MD5IXwJlSDX4UlBgq9Nk+7uu3pyi6vPtpSZaFJp
         4FnYb7XTHlsxl09yjuOfPYdHlJ/akCNDp41W/ZnPIM4RSuPutNZ3IhvQ0UUvlLAhf6+f
         nCj1oLbXFzc90+4rH+Rm9t9oEtPPAZodNnguQRyD1c7p3MUI3FcFizR1l54H+pXhVS/K
         53+omLemChW0S5i5rShTY7XyafieJuhB74iR6EcJGOJQZ//iMxHhfEXQ74mBi/A6EsiT
         l3LytteAKD3ehxT5VB/nu8dI3e+41PahlpyCuW9M3B/zPvz9sePN2uVnM4LP24a4hf5R
         vYzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783978464; x=1784583264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zuafqt4lfPo63yyPcb/0gm7sGGLEfNiUS7CIKOVfmYI=;
        b=ODr1fIYdZLn3d8cq7D9TtpY6T9UcgruzzCS9Mbh6lxtn5JXr0KUOk3vsJ963wMaErT
         pa8UhzKjAPhaIjENL/fj694VXn5LOaXy1QTddF3ZxcJBh3bD3MjdDnODr++G2dbWC3Q4
         /Nf+0eBGLLLSeXrX3KfL69nH6/3T3e99XdIAkdLPXAl3aXH1xj+AAOSG2loLiy2ua6s9
         UwrKhOTvhmPT7mHhHLFB5ZNfnsc9MW25axEs7hyL7XIa1WhEwRp7SPqTMiNFzUcfrWYY
         iAhly0B+NbSFjSSZnbenCan5jrml7RxXz4xwZFOtDB+22KQk+fIywDlop8i1WTSJ46Wn
         SHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783978464; x=1784583264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zuafqt4lfPo63yyPcb/0gm7sGGLEfNiUS7CIKOVfmYI=;
        b=CsS76icPDAC+uVUpXQpPibXEm/03qjbcAbBdqWrPkDdHH0G7FWrIQuhTEIoQN2qQCa
         52tDu43+Fl9IWDTeaLjq7yT1BvV5Rkl5Wse5HN4kmtbKenAaqfwql3Wu4d2EH1r05PI2
         XQUsJvFYjVC1IAnO2+xYssVR+grXJTdB7VyD0EcsnlcO0G0N0s5HwVrDR/34O5yGP404
         LjyELARHaBCZKt90+vo1LJRrxE+gOi9QZpxbwkUNM4v5lrLQuC4DNign+ElLaWxWwm57
         +pXsio6zapjX/BYrEdjgEtwtRxf6zxoJyyw6ExLCSeqLoZEkv0DtvDLSGn07QGPWgKG4
         uUxQ==
X-Gm-Message-State: AOJu0YwpgiTzz/CJoqffXyRdVrFGERhA+RrUE+jYZbAv04XoRt0dm49/
	F/mvj6jHwz5scZGpsezAgviCGCTCOBjqMf92Ba3TnOYXm0Htdk8OBBozz6/73/uCobyrzpJfFa5
	oeUF53cDztn862hs3EUH/fWzFC/3kjUs=
X-Gm-Gg: AfdE7clNe/N5S0ijM2FeNtiL2GX4A6kjm1FEXHkhWL8bw709DRtDzO2mpO6DC/gjl+1
	BVuu0jV6ORiGnEczE5wdZrGlym3e16W1TonzW+dqCA+zwfpk89ZVud5Y4pD4FAt+gxt5/pJk376
	GaR167i0ISptNG5Ce06/zuwTpEyEYAVuHFTzWzG3A6vnxNmUYEgZOLiR1wq6rIi6v+Y+OjmBdPo
	w/C3cxG8QbRXxOZUQULru/wu4qNZWgg++BVIf3HEbS4cWWsVm1WPEbhhaGk+Ux5QuBS8W9OjK4b
	BOELsDHGZX2XNJAnl4/5ot8S1o7+vo0UqA3R5/xZ+0up0Tc8WvfpbuaDXfmTeUCxrauJLyrdoAW
	IZbCtmFA+5X6Ig/U=
X-Received: by 2002:a05:6808:1452:b0:4a4:12c4:9c16 with SMTP id
 5614622812f47-4a42abac221mr7357821b6e.7.1783978463973; Mon, 13 Jul 2026
 14:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqik6j1m7u.fsf@gitster.g>
In-Reply-To: <xmqqik6j1m7u.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 13 Jul 2026 14:34:13 -0700
X-Gm-Features: AVVi8CfWN2Pz-KcOsEYuK-6KsGawwkDZUlfBxeS1Sayrzmob1akvHQNcLGWHVi0
Message-ID: <CABPp-BHFZsdNpYWEWq-r+BqKeFQ6uh1MAbSfWQRPL8-diw6NOA@mail.gmail.com>
Subject: tc/replay-linearize [Was: Re: What's cooking in git.git (Jul 2026, #05)]
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 10:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> * tc/replay-linearize (2026-07-07) 3 commits
>   (merged to 'next' on 2026-07-09 at 371c2e9c3b)
>  + replay: offer an option to linearize the commit topology
>  + replay: resolve the replay base outside pick_regular_commit()
>  + replay: add helper to put entry into replayed_commits
>
>  The 'git replay' command has been taught the '--linearize' option to
>  drop merge commits and linearize the replayed history, mimicking 'git
>  rebase --no-rebase-merges'.
>
>  Will merge to 'master'.

Could we hold off on that until there's a response to
<CABPp-BGzU9KHGF1nipi2HZaa1AiikMKGGaapQzHVH06wO4V1ww@mail.gmail.com> ?
 I think the third patch has a pretty serious principle of least
astonishment violation, and there's two alternatives that weren't
previously considered -- one of which would be simple to implement.
