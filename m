Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795757036;
	b=fZOrcUDmBFMOhxbaTzKZuiXPoZ1d/dFYNsHPsArNZ9OUkmXxhwjhAE6rNNPPzuOzLl+3
	 vz512xlwdNltN3OZ+49wpjsaL4zBaHGWHS/ruAGodDRYKp9vt6h5Az2/JIT3CsyZPifXF
	 5Mif5QeXmwFHQAhF/a687ugEmQojkNZ/0q5ufO5+ks6cHRTCEHpya7krmVl1tIsUeZHh8
	 +AL+l4e6ecIoH4fnAjKB2ox8Wf7j62aneAytqe0Z9Ur/bwU4wjiuEmxh1cjY2n0UEYNaf
	 nFO0ftGzh45okmt+tdpHaJYx1rkvdnoz8x/+WFVWVa9FTPm2hw3be581FlufQfObQVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795757036;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dRBE98pBpgBoPX3K53m9entS0Tq1rZFVlVMxC2suvoU=;
	b=Lnlzc1nZavWAYyfESzPOO2ccPM2zTg8D2VLdMuWpjf6drMhdOXDAgD6TTvkzNdUwhXkl
	 sYF/fKMQy1Udt2uIuoUlCo5i1sCO6uwe8PkzO5mLpZaJ7MfuhS9AcCyx89BjLbp9qXF8/
	 8OO+6dqaynlJ4dqyM/c5gSUpfYDEXOSPHKB67hc9xOB2Ca05UqSi2skgyBrNcEAUtOypa
	 kxQmh7tTFxRiozc1BQ0sKcGZlDbzxcYN8ICeG12pV1RJbZkEHzvnNWcbjn85zADbaWH0e
	 lLvwEYNJk0k/EU0rXaqwJfpbxBj2yw798hAg5BbaaICynnawMd5vajeJFICvedWCSGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=M2tCp6LL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q8tCvGxw;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C30606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 05:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97C30606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=M2tCp6LL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q8tCvGxw
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BCE74EC09F6
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 00:23:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 27 Nov 2026 00:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795757034; x=1795843434; bh=dRBE98pBpg
	BoPX3K53m9entS0Tq1rZFVlVMxC2suvoU=; b=M2tCp6LL8Kt5YHLN7ZLv5m1GBj
	aL4p2hqwxTDDJsTrtx+BYerr3/rZYPqUzOSY7DB8kr6eH2F+okBHKgOwT/jQbGL5
	SznfFP9Ls7RkuOyjbtwFXccKJJjqlv+MEvZcCJEJKVUQJZspnI/RdZfbz3LfhcQS
	y2qa9AzLnRg5fAWjh2mqzRVRQ+SJ3p24eqBSRDkKmh05WXw9BcO1hYKY2m+hOtKZ
	FjWhQEMpSLA6KdF0kG7vnhg3D4Jy8me0eoPnw8Kazep5csu8OFJgZEtr6PbW8YW0
	cjOLmdc4yRJJVM/hbyR0PqlvSGXcj4waWozMc5OcGIPlB6wuHczgbLivSrtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795757034; x=1795843434; bh=dRBE98pBpgBoPX3K53m9entS0Tq1rZFVlVM
	xC2suvoU=; b=Q8tCvGxw0CiO6tJuk0rypLgx49P48PPLJF+Vui2K6BsSmpOqWHP
	OMU3ZmCnJJ/R2i6hhwsqnNcI8IDCWS4vHSqwSnFYR0CZKC1awlFTdIwP/oaoAaNt
	HfrgL6iYY32OPYyjGXAX09OQAFpZAAYE7znG60BMykvVltLHIjzppAmirJbeyzQu
	masp14iEpfd8gyK/bSj2/3OqtHio8G/BrjPVhXiaQd5z1gAo7VNBzeBScwJD1RhB
	ll56RQh1Jyl2BC7szWxVefQCk9Ua7AJSCPLN0QU/PZSValnWgOpnMg+E4QLWps6G
	I2G/J+EX3ToUbCOK1NKcgIYU+DxG7MMAbtw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795757034; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:g8qYnjADH+dhnJVVJCMRZIiBEpGAN/6Wg1Xcqt1/u0bO84l
	5QLmaO+HpSnXmPGufB6CAaIeslNcUfTBkW1FWKKUJ6TPA23waf6QWNi2SKlNGzV8
	yOM32Do0JueAmmQfpu6PNvFr4H2XDsmtpfullX4qehFUmmq8mDKWPDjJ4OfMm8Rj
	tonXIQEWJ1b3WWCwhWeDR/xHQv8oqltcYk7aUYOXH/gcl4DOAwuR37jjcC5mpIkJ
	hau9qGQLB+VxRejyjXhPP2u+v4/PaWr/EfbhOY7CVwiRSApy2xA/mQDoM5ddajhm
	+TNJlh8y9dRKmu1yGcSBnSJByvn1pNk+YQpKVfQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YqTfZ9ZLLXf6ACApDzHfCI0/ZjgjNs8rdhBdcL0CyHQ=:v1kMpN4PfEYZ5dYbcNqNTOShBT86Hxb2LTtb8I4Lqnw=;
X-ME-Sender: <xms:6hMJa_VOm71KzQsvT-dt3yNiAGbQjb8YiM1ubkY7P9qyoFSETy1clA>
    <xme:6hMJa-l8G-fjjSGz9S86xkfYaKw6XLHaIbTSGBX0-4efqLDYu5qW8EV0VYApZMn35
    NU2KcrdwQ77sn0ydp9sibn5zQ3f_8aPdEYvAc7w1YtiHcC229ej1mM>
X-ME-Received: <xmr:6hMJawaTo7tgCC48HiJVM1tZW4pvzZGntdvzvIeg5955Lq8hwTaxnJLbmwZbkG9SdvXBlB2yc3Usxc53cwl5lsZK7BaqIW6zvG5zrus>
X-ME-Proxy-Cause: dmFkZTEKqpLaTtKC3inYuFnlRYIwfx477Nhi2L4wPiKjKLwZeEpSaWDtzIP0h3kf92ma6y
    PBrNypSDKBMA3OwTzU0zkColA3jfZo+gzA+1MTDWrOqfyJIpsAfaMH/RvVwrDHbTSBJvgE
    JvasjwqYf6MjqEBvu6LCkeZUD5wBfl/IfKSykLhh4JwrJqo69Jy4PU3/ACVVaMpn14wrTb
    tDhRZ0V1UOtTZTJzlX7C/fxjGXMA2RpJgXjYJvISI4anhSn0xs7ysZDx9E79n05gY+T0Ts
    WMQOTF7cRDL/BzqmiGJ3umpy3FH3XoJ2cmxcBzMil9cQXt8JL2FzLI/xAmNuJMz2qsQ1fg
    Rkex1JYsIpj1801+uc7xO0AbVyu+onKfbpsP9LlDnhnXeadnangQ5WXBOSOMhpDt8Z+GmP
    bRjncDk1GOSoJtUcp9iK9tp5b+7MDr0qOw/qpWmDl3bnFdxml4ohQHoz/iR0Qoh6m/S9Cg
    wXQpdeUOhB0DcoR3ycX8WLEyfSUsh1yW7Z6vZb12CMMtu3fcWtVsNxZTp3AF6/I+lJYWk/
    r2NRfNsoGZP3jET61BfBnb0sd/hNHy1J3H+l1AyniRmitwIkyzYDIuktg1CUFZiMg1SoEN
    ZGNR2md4/xC4Sn0TdeKMiaAs1oQ0GExi9aGJtHUvwYC7GjoI//nYVyNz5ojQ
X-ME-Proxy: <xmx:6hMJa5MLZXFtKwOxeBp5yCLc5LDlzoXmZQvlBhq5skX5fNdy9zrYig>
    <xmx:6hMJa1Y1MeM9bDgxm2qtiaD8sSRAdnnU6kdgaelhlPPxjNl69Nc4bw>
    <xmx:6hMJa31Hvf9m1iaNUlak3FT0fNGbGgpKtDj6C8M4JjTCgM87fE2XZg>
    <xmx:6hMJa7fR-MYtpZLxaCBAIihAGjVgmJwV_oGejd-HvEAXAMJrM6B_eg>
    <xmx:6hMJa758lOw4BFw83eDJBPguu16ib-BGrMO4QmnklYutX6E-vlu5b24b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 00:23:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] submodule: make submodule.<name>.gitdir relative
 for worktrees
In-Reply-To: <CAF5D8-ve1dtYWUMDeiYYa0FpDOv3c=V4MAS49Awy4e-9iZy-xA@mail.gmail.com>
	(Yoichi NAKAYAMA's message of "Fri, 27 Nov 2026 14:04:01 +0900")
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
	<pull.2306.v2.git.1795273853.gitgitgadget@gmail.com>
	<435ca42ec99d0eed613621186306cb68def30e6c.1795273853.git.gitgitgadget@gmail.com>
	<xmqq4id6qakd.fsf@gitster.g>
	<CAF5D8-ve1dtYWUMDeiYYa0FpDOv3c=V4MAS49Awy4e-9iZy-xA@mail.gmail.com>
Date: Thu, 26 Nov 2026 21:23:53 -0800
Message-ID: <xmqqik1ietjq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Yoichi NAKAYAMA <yoichi.nakayama@gmail.com> writes:

> I'll update the commit message body as follows:
>
>   Currently, repo_git_path_append() can produce an absolute path
>   even when worktree.useRelativePaths is enabled, such as when
>   running in a linked worktree or when GIT_DIR is set to an
>   absolute path. As a result, `submodule.<name>.gitdir` can be
>   stored as an absolute path.
>
>   Always store `submodule.<name>.gitdir` as a relative path to ensure
>   that it continues to work when the worktree is moved along with the
>   main worktree. (This benefit also requires worktree.useRelativePaths
>   to be set to true.)

"Always store"?

I am not a heavy user of submodule & secondary worktree user, but if
worktree.useRelativePaths configuration exists, should relativifying the
gitdir still be done unconditionally, or should it be done only when the
configuration variable is set to true?

Thanks.
