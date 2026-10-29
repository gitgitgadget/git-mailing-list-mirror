Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283832;
	b=5ShNHA+PGt89JxBnTXzIJnrFmMyDuWFyKpiCHu3lck9TdKa3oh2KdXDoRAmC7NE9E3+m
	 ykKwVHfhXHAYVM1v1rEmj8h0Yw13VaFNL3LR3AWX+R/s0a2++eyJ2I2PnK0tCMBjsGavL
	 CjG9cefC3fSyizhHzZ6bSU9ZmJ0CD292sOhDsXnSNGgJFD2XhOLp9rdGjeJcyBseQnXeg
	 cdetR6k8489KOQMuyJjDJNMLdva0pz4TW4fo0dDUzUd/v0eyt+QKL2IXG8z9bA8DhIROz
	 FuwEnu+c9mw8rx4CiAHqdknpC8rTowaMVop3PFrRS6sCXi/pG1iJegY73/g8ltGcukQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:From:
	 In-Reply-To:Cc:Date:Message-Id:References:To:X-Mailer;
	bh=f4rz92oe7zsSXS4PXFhkNgbzAs7A3rdwxugDbJF9vKc=;
	b=RHajqViGiYs++tQAIGoQwZG+ECJezkl0bFl1BHlghC2gBrPqdTEHNxFOXMnDlbmdmFsh
	 3cpzc5ZlGSt39JtRauNpkxXX+d5Yg/CyTXmTE+09VuFWwzpLAtNSidR1Gz4wu4LlBdxPL
	 I8Qmm1SHsi86I0585WmvR8IPAHJ2EVxGUOb9+iOnX5k8eTNHJQ9LT0osErpd0iVrqORS6
	 E4059RfR0rmjUql/C6XMo3ABexPBiML4TEwzRme9EwVvvaI0mflRzY8Sr/+XqJJqRukvD
	 k/flU8yFujS59RxwLw/jq+1fG5tgiO4m9T9z+bFj09B/U/yPOYiBlON4RU09DUht52w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yyk0Cx3H;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47946606A320
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47946606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yyk0Cx3H
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f560af6aeso239767785a.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283831; x=1793888631; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f4rz92oe7zsSXS4PXFhkNgbzAs7A3rdwxugDbJF9vKc=;
        b=Yyk0Cx3HKLra8y95TZm2yoiFtKwx25nqKKcAxwH1OiNjz70/bGRivKxk2241SP6u2U
         vtKdd5Zgrt4gYNHER9xZ2XQsW3n9Ak0LSwA3uFkPw7zUE+ga/9S8biwsK4OQ6sOlBMsG
         +FPTCMZ51EEMDnV4zc8p3lqLgLBJUrGnNG9A40e7v4LLKw7FmNtQ/7GwwneRJX0TkdOD
         nTu5qeCTuPKDThozRLrx0IW/2Lnien6SvzYBh1h96ur678P6HHc6GlkCUfnHIRkL7Xem
         IUf2O/G6baF0TE28kDvPfnkEl30nges3JBD/BlUdTeI7LHRAZsNRKoJMGzAU1Hl6PWe2
         Xt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283831; x=1793888631;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4rz92oe7zsSXS4PXFhkNgbzAs7A3rdwxugDbJF9vKc=;
        b=Fb27IQON7bHm0z28W1sLbcweRKKJeDL+9LoaiWfyTkt7Ta429Fw+gpGw+zTKdoyTyI
         4BU43+j7GNnUjBr/k6FOoGcjtU0BKkSm2Ga/AQvHeV1Ei0KDdgbdpO4Q9qQXFtSFHXTe
         +OPj9xy+PQl029Y/ZTyyeFg24PN6gjajstjpdNH2w5D3oz0Xbcefc+PGnkk5h1kO7oWb
         fy1W4cMV3CfzpxKwJlNHqhY9BGa+MsX17bl+zXTLzD38E3936OlRmb2g5qGpR5HVm8Ai
         S/PkVA+uT8i6g56ZBBFWW+At57nQD3UVzWOusTuBoy/3CW25zHQcpoz1TmQm/hWkpeXn
         CjYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRCSB9hXXZ+sz8EOWJEayqOhR4adzyrYMqwwuNoCCN+Svx09rxaCFL9M2qJ5t3gb5GLNI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7GEAC4OM/PYqTXbUyNAmScNoT/qHTiR/i7JwTe51Gbl63FW3m
	VoqLO2+2/oKsk00Dn/4mTGjAnEMgNqWqzNjRj83W9htwuvAzz1Q98bRF
X-Gm-Gg: AYBFou2JgXhQFe3PUya3ftaS/eVVjozT+W98tgb0neIOXYkcO3AD7L21tl+UqDmZ8Ag
	f3uZAVPpBNNh1pJhBGwxAcenHq9zIg172yIEWCr55IhEiju82Pwm8qflLepBBfIzS3AxTYSq4JS
	uyAYSf/Xr5hFUgIvpkc1+//oXszzp92HbqZ+5QfAFaXwY3Mp9gaBm4f4PtMnaIlqtVZkU9Bd+jw
	Pu6VUU7TH71DJaNtBw0yVfy08tuemahwvHlYdXwiXcSGWGJIQKHN5NgVYkicW7bAg5nkvH9yfCM
	LVlJsQBpShnxfn2dyh9PUAZxwq8blXK89pZpFeSuv13iTMTBdwfV8vAB6WHoL7dLKfuK9MRTwda
	bRipaFS4J2lNNu5vsM7hsZ0SnR61hEGK25s5k8eHdNeRvCCdk/MbxMsoBjQ15Q3UqUndkG3gU47
	4uXb1D3G1nuRxMgRL5fGQujY1ON2YIeP+XS8hHbq+AnXJ8Eykj1BpdLeQu7DSiy8nmDSbgHlbof
	CNvnEEkXmP3UHQoLzSNUi+ZkliJlmSJ+sXrO0fLtkdV/CipsHKV3W62zlA0U8Z+450HJWQvNEpF
	pjUVwOFow7soi1AoNsSRVfJk8j/wm5ytAH/0Lbw8N6exuWL1Fymev6a41JuhrnMNJWjOiWiYTBU
	uWlvihaxYIeeVyxvVZPxMnN2rInYJskn3kfJBpGTDq3zS2uI8e83NNQZaWCrG8YkunbgVsYJA5I
	xQ47k=
X-Received: by 2002:a05:620a:4010:b0:93f:24d4:ecf0 with SMTP id af79cd13be357-94408d81278mr810564385a.47.1793283831080;
        Thu, 29 Oct 2026 07:23:51 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b03e:6cb9:c1f9:7732:784f:faa9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0669112sm1553579485a.10.2026.10.29.07.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:23:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] worktree list: add --branch to select worktrees by branch
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <d0051192-8e86-403d-9aae-b988883ccfd9@gmail.com>
Cc: Jasper Mayone <me@jaspermayone.com>, kristofferhaugsbakk@fastmail.com,
 git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
 haraldnordgren@gmail.com
Date: Thu, 29 Oct 2026 10:23:39 -0400
Message-Id: <A0B73028-E3BF-45CE-8468-AA9B022C41F6@gmail.com>
References: <d0051192-8e86-403d-9aae-b988883ccfd9@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: iPhone Mail (23D8133)


> Le 29 oct. 2026 =C3=A0 07:14, Phillip Wood <phillip.wood123@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFHi Jasper
>=20
>> On 29/10/2026 04:46, Jasper Mayone wrote:
>=20
>> Is that change in behavior acceptable? A script that reads
>> %(worktreepath) would now get a path for a branch that is being
>> rebased. I think that is a fix, since the rest of Git already
>> considers that branch checked out, but I would like to hear if anyone
>> relies on the empty value.
>=20
> I think we can consider the change in behavior to be a bug fix.

If we=E2=80=99re doing this in order to usefully feed it to worktree-remove,=
 though,
do you really want to remove a worktree that is mid-rebase? I
would think that could have work you don=E2=80=99t want to throw away
without considering. (Besides which, would it show up
in --merged=3Dorigin? Hm.)

I suppose I would expect remove to fail without a =C2=AB force =C2=BB flag i=
f
the worktree is mid-rebase, but still.
