Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14D61EB5CE
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438628; cv=none; b=DaIux7QZhd/Yg/IyanynlyJczKdB/29CLcBmA9uAqbN5QTy+MCZZ8+53SzMVCAkRruzTbYeov3xxziZrZ4wH6Nc29mvUlQluDV7Jkg+IPfz+cnPExHpU5xhsiOlC4c14+oOfCkZcqCIS5ojuK2Ik3fyMNKL0aP80zyY2wHMOaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438628; c=relaxed/simple;
	bh=YcvnJMtXZ4/+L3VglysSwB504JPAtcismyxQ6GigHFw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjheqynUQES+UBmCbC240UvRHJDcGv9QsXRSrhlJZiWlCLePADzWL0u0mF6nrrTcYVpmW5ZS+ywPVNcjny7aZbUQ66eaMmpGxum42ynveTpEMPBay9edm5WEABKO8Rbczt63UMza3n4lNpMQx+9AxEearl/c5hnP7M4owJu6HDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eO3EuetS; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eO3EuetS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1769438621; x=1769697821;
	bh=YcvnJMtXZ4/+L3VglysSwB504JPAtcismyxQ6GigHFw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eO3EuetSrfirSzGtN0/TeHar4ZgI0n6MVbUggRNwtZfIOS6YEJK2uffuckayD8wHu
	 DkeAi95tthsPSKp63pYRPETZ2j/iYxP2Z2g/XoSF5ItndUA+OnlCgp2ggqEniYJ1ot
	 WDKmPfkd/BWJ0wpmzxIsm8KNVon3X6v5SyqkEQNhqA8g3IxUuIpaS6AbLtxsg9Gc+O
	 QvvKV5pG3GsULZktO3PwZo5W//PIpEc+3Yttess6F3Q4/bZHW9v1R+c5/L/uSUVpPJ
	 tDcE7sZ/KlK9wS2OLIc9WME3rLZhPKfawqZZR2KmoQP/GL0WPXJjRTqr9J4BJMRe7R
	 yQl//aeglSjhQ==
Date: Mon, 26 Jan 2026 14:43:36 +0000
To: Johannes Sixt <j6t@kdbg.org>
From: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: git@vger.kernel.org, Chris Idema via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] diff.tcl: fixed alignment of tabs in git-gui diff by using spaces
Message-ID: <sYbEiapPid30QZ89paQ6hF_v4BjKnAqUTOt_ImBEfFYBlMVU9uoGwZbKqSkk7aZVxGPrqVXbb58Ogppnw0gQEbH1gwRfBmx3HC2AECWjGkY=@proton.me>
In-Reply-To: <07014d88-67ed-498a-8cc1-423c77972fd7@kdbg.org>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com> <01d0faaf-99fb-42a4-befd-bb7f359809bc@kdbg.org> <Lj9kojJwK1ZAtvE5nj6rTq5EXf1-QhsRlmBDM9YntbYeWb3J07mlbM-njNco2XT1pSPXsNVbo9Uc5kJOHihb11odjthYN4YtuhVdNwxSIqk=@proton.me> <07014d88-67ed-498a-8cc1-423c77972fd7@kdbg.org>
Feedback-ID: 177675452:user:proton
X-Pm-Message-ID: 1c37efc59ff23d27129523e8160587ac1c750507
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> So, you mean that if the tab width is set to 4, then the tab stops are no=
t aligned anymore?

Indeed. It's probably due to the + character shifting everything by 1 chara=
cter.

> My suspicion is that the patch text does not match the actual file conten=
ts, and so the commands fail.

If you select and copy the text from the window with you mouse it won't mat=
ch the patch. I didn't know people used it that way. I use it as a way to r=
eview my changes before staging.
I don't know if there is a way to make it that when you copy it will copy t=
he original text and no the modified text.
If not then we should come up with a better way to align stops.

-- Chris

-------- Original Message --------
On Monday, 01/26/26 at 14:59 Johannes Sixt <j6t@kdbg.org> wrote:
Am 26.01.26 um 14:32 schrieb GitHub Chris Idema:
> Here is how you can reproduce the problem:
> mkdir test_tabs
> cd test_tabs
> git init
> echo "" > test.c
> git add .
> git commit -m "initial commit"
> echo -e "int test1\t=3D 5;\nint test11\t=3D 6;\nint test111\t=3D 6;\n" > =
test.c
> git gui

So, you mean that if the tab width is set to 4, then the tab stops are
not aligned anymore?

>> Do "Stage Line/Hunk for Commit" still work after this conversion?
> I'm sorry but I don't know what this means.

These are commands in the context menu of the diff panel. They extract
the text from the widget and massage it into a patch. My suspicion is
that the patch text does not match the actual file contents, and so the
commands fail.

-- Hannes


