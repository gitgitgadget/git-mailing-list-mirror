Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B91853
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731484070; cv=none; b=M4JTU8Hfpm9PRbbDZKpSjGEC0gGYslucp8gdO/GAoa9hVT6wl8M2lA5Nfy9Av3T49L+BpZlehhB+/UoTkageMvJda+iVA00LM+90v4JWm42rzCIV5n0TqmrRmK1WU037cJK2+f5oMH3n3ChFPURuCZppsLdudUEEx3ItCHfTOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731484070; c=relaxed/simple;
	bh=yps4isDpy5wOdd3Ii+anCovrMo/Cjih6J7gIc5+TmoA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CzVl4dSKkE0hVaa3mlE/07HsMPuOfZu37eT/QbRmD2BxWiGaveFDCjiHbaV8JMn926wIZTg2HlWYP2mxsx8PgvhsxbqSnFrjbjnBYzOjqPByweJWFmzx7GuQP1oe+rxsgUpoUrlRF0sJokl1+I8DAbUzMShFCvXYOs0Ls1JfLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=rGE8ENv1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="rGE8ENv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731484061; x=1732088861;
	i=johannes.schindelin@gmx.de;
	bh=yps4isDpy5wOdd3Ii+anCovrMo/Cjih6J7gIc5+TmoA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rGE8ENv1s2pH+5U1QgqO1FGTpiTYmFFVzrs05TS0oz0vnsryL8BhtC9WIojMfqY8
	 V2oRxHm7hRvCvrnuVz54Iu6C5pt/IQ4Q77lzpaK0R0hTzfMSEvxjDVZYfYtDQlgDn
	 mI3fV7pg0PlHD4zkKZshpUgmdlaL2sVXT1L34NwhhOiE6SG4ntxpmNi5vGHS9/2k2
	 1hbT0/E1kWBXE0bZi84hUqPAO3c60sHm8RkWqj3Kta1ShCC8C5gxG2NdWr+zElKXD
	 pL2UVdath2Z43ASf8dX6nsgY3T/Pn7+mnPm4MDO45x/K2E7bSK3sw7MZux9ccYBbm
	 fSkteAUlh01VcVHsJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.196]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Ux-1tyP660ySR-010JYS; Wed, 13
 Nov 2024 08:47:41 +0100
Date: Wed, 13 Nov 2024 08:47:41 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Beat Bolli <dev+git@drbeat.li>
cc: Tobias Pietzsch via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>, 
    Tobias Pietzsch <tobias.pietzsch@gmail.com>
Subject: Re: The health of gitk, was Re: [PATCH] gitk: check main window
 visibility before waiting for it to show
In-Reply-To: <ddee92a7-3d1e-f869-9cc4-72b70eee0dd5@gmx.de>
Message-ID: <71af9e7f-84b2-437e-7167-2dd0add02f1b@gmx.de>
References: <pull.944.git.git.1610234771966.gitgitgadget@gmail.com> <bdaab72b-37f4-658a-716a-d6a958b6f709@drbeat.li> <ddee92a7-3d1e-f869-9cc4-72b70eee0dd5@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LNiu+JrNdCibhq6alItMeJ34b6jcb6dcjnA54vVIU5LFgNKAHrq
 ksTXwJE14rg0SzPk1pjnAiU6qguLefbgvnMl3/jlK7yiSVFnOsUmRNptdWBTS5m8b1NO3ud
 Fwnim5kFJxn3R05BxefTUYHvQ85E+9/NJ9s+wkyCMpb1R/imWHe/mqBGHmi3zc7T6g5FR1R
 EGhs9xLw8i315OC/W7Itw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nbOnMZ9WXhY=;w4nKcHRfwsybqItzPAdQpGZdvrc
 H8+RaJcSflYhGOET0OsuiuOnbex/idpjU+fwVpACNd4aH8HjniCiwmlOGc4ac/OIsHJfBDYkC
 sK7leqFdcJV9kfBMqxPyv57UaXoW4T3MNbKQMv3qhPvTvN48zHbWThJPpYpABwqiQ68ZL/+Bj
 L62bZz3/o9519j+OO6hK/XLkhD2JrQuda5ZELmkIb6u9605BYhiz/17OtUGqd/1quZVk2aojX
 tSwTYolZMInh6ZbQUjDMsMvuH9jwhSKoklCSne9kLqlDv5YviiySKv9mCcdX3S9vSvbxNNjFy
 NwZ9MlAsEN30ck0gyaJ1xXDOlX9FB8kgjLACmpskIgxTAJ5l15GP8kq/S9YjODoULhpceExL+
 SxSjuQXec6RejMghgZ0tQpA2TsjGbZQwe+nGn7A+h31POTfALxXLGmPusRHiSU5andITDsvgH
 jtv9qSySoki05XrIxyi7+LHfNGh8nYmaWFEwBmceEQBKT4Qvkc0VDoY6V+wlgCslPR6vGGvP1
 WFiM5byTqc7zXkf0CWqZoLcgy/8eodTt3WQ2Rh4CVLTAJaAdVtJXFWsJvOFMWIplJ5p5NNl+Y
 8jd2oBgZMyqP0czXaNnqKiglBOHho1uQ9Lf3iKqVDtKJOTGEEF68b5BUFxPkyodj0uuhCCmbA
 RFDXW7VNwyXeNhAS3NI9VLVgiEvnKSMZ6alg2tfgUlz0D+Rih6wZ+8JOsJJ3iZXH2rNMdccAH
 AEaKmIvLFhEifT7f/Q24RdL9sUOoQlIx2WjuWWfs3UnkxA1STfZTPkHp9qQLqJ1bpsoB3PLd+
 ahscwVhp5bRVH/e4IBU0dh6Q==

Just one quick additional note:

On Wed, 13 Nov 2024, Johannes Schindelin wrote:

> This morning, I woke up to find a new PR in microsoft/git
> (https://github.com/microsoft/git/issues/704) that cherry-picks the patch
> that was offered in this here mail list thread. That patch is almost four
> years old, i.e. just about ready to enter pre-school and to learn how to
> read and write. Yet apart from Beat's confirmation that it fixes a real
> bug, this here patch has been treated with silence.

Even Homebrew is waiting with bated breath for that patch to be picked up:

- https://github.com/Homebrew/homebrew-core/pull/68865

- https://github.com/carlocab/homebrew-core/blob/a236345fdfbb37465edc0b5a0ad1a51dcbd84423/Formula/git-gui.rb#L19-L26

Ciao,
Johannes
