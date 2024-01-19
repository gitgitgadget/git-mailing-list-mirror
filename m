Received: from st43p00im-ztbu10073601.me.com (st43p00im-ztbu10073601.me.com [17.58.63.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE88F6E
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650692; cv=none; b=iEDXykHpOOqoqZO9l8PkBrWSe84GB7Bm5Vd+hT2lqFH844K4ov4Zxm/5V3DlMVhlKkudw3+yGcNdRa239IzB0Gu+ANT073dBwKUFRZh9Ec7BO1qHLwNTwmftaMnMSyVJsJKqyoJssEk/p+WkcY4YX6paakKP0nx+LwL/boHyhpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650692; c=relaxed/simple;
	bh=g+95XzZQtGAR6mOSDstouRCmlgLaneAJNhJrfmUsoig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3BeA/gb2CgKC8r5d8LM1GJxpBjugvjDgVWZj6AXhiQm9oasNi6oe4ZYSdAM9cZkJuMAPZKtRgfGG+i8de7xJLEB2KzJu6bHRIpn3wJJ0beXoOTnvsRgMbCi1sOsx3sajHo78JcnERUlvQdvU2drn74+ZxNezgwwvzjky9SoKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=L4TamP/7; arc=none smtp.client-ip=17.58.63.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="L4TamP/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1705650689;
	bh=Cd5Z0KoZqUC92erLkvJJslu7BEe+HDaewBdpGFjHWtA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=L4TamP/7NnVTk8w908W5zfgvZZGZG4XltvDra1EoaO32Mxcp+6U1Btix9PN0RzAkp
	 MJmTUMwKXFnGAhQ5IAEqqpUHvB1hW9SKI6FPoym9swJ0UIQ5DHDggHSTuuHOH3IUAr
	 x/1Mk+MMtT6d7gKTUAR9SXDDl0foWNQK9amjtsIG1xdUJT2v7DmsRC9m4Jcx5cz8AE
	 ry3xfl88NokiCTyyxpE/Go9fEYupM2ACkDOtH7gwSybbMyILg1lQ9LBPRPSORTlNec
	 IT2yVrn1bKbEoD79pv9rIH6Haad7Y+m4PJ3XQdv6I/ngLqnkukAO+TGtgr7Ecefdgb
	 7py7kET5Cr9Tw==
Received: from [169.254.185.66] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id A639E18011F;
	Fri, 19 Jan 2024 07:51:28 +0000 (UTC)
From: Sebastian Thiel <sebastian.thiel@icloud.com>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Josh Triplett <josh@joshtriplett.org>,
 Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
Date: Fri, 19 Jan 2024 08:51:26 +0100
X-Mailer: MailMate (1.14r5937)
Message-ID: <4421D442-1BB2-4C89-834F-9E70F4CF360B@icloud.com>
In-Reply-To: <CABPp-BF4Bfr3Hfy7atehHvbQds63+GXO9XPJAW3Mb7dvMcCkDg@mail.gmail.com>
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
 <xmqq8r5gfc3j.fsf@gitster.g>
 <CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
 <xmqqsf3nl2b3.fsf@gitster.g>
 <298F7067-D572-433F-A7DD-5256B43B97D7@icloud.com>
 <xmqqwms6qwr3.fsf@gitster.g>
 <F214D88E-6837-4EAB-896E-DF8CFC315EE7@icloud.com>
 <CABPp-BF4Bfr3Hfy7atehHvbQds63+GXO9XPJAW3Mb7dvMcCkDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lW2Y2alIw2g6tqzfUmUeM7Jdi60cjgmd
X-Proofpoint-ORIG-GUID: lW2Y2alIw2g6tqzfUmUeM7Jdi60cjgmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxlogscore=883 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401190027

Yes, indeed I was a little confused when making the "git commit..." based examples,
thanks for correcting them.

>
> Reminds me of https://www.emacswiki.org/pics/static/TabsSpacesBoth.png
>
> ;-)
>

😅

> Besides, if for a specific file or filetype, accidental additions are
> more important to protect against than accidental nuking, then can't
> folks achieve that by simply using
>
>     # Don't let older git versions add the file
>     .env.secret
>
>     # For newer git versions, override the above; treat it as precious
> (i.e. don't add AND don't accidentally nuke)
>     $.env.secret
>
> In contrast, if protection against accidental nuking is more important
> for certain files, one can use just the second line without the first.
>

I am glad I can pull my initial proposition of 'having both syntaxes' off
the table to side with this version - it's gorgeous.

It's easy to forget that the search-order when matching ignore patterns
is back to front, which makes this 'trick' work.

If the insights gained with the last couple of emails would see their digest
in the user-facing documentation, I think precious files wouldn't only become
usable but would also allow projects to make the their choice during
the transition period during which some users will inevitably access the repository
with a Git that doesn't know about precious files yet.
