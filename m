Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1941C3306
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389391; cv=none; b=JSD0XXqExqPvbxQXhYw0X5EC8GJlLhHkU4SBBTfRt4PujI+BpUqZmTkGwwnO8+stPUHgtQCh6qDoW1OyJF1ju4d7KPoA4BTMPcjTARBqjE+65wzCeq5wjimPW6MS6J88a0cd9iSac85gKyWsomrPGmDiuR/hujy2GvM4of6hSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389391; c=relaxed/simple;
	bh=O7rxuIztl69xzDNX5rcQiBFBAH8If4v1s8weyEJL1ZY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WOGPxZQTIiY82Xcx4CQWTpjtdn/JxIkUCMgT5qYJfwzFvXnS7IJcq9dz+PTq6w3+3A9ZEtTimewH4NlOwyrRhKsM7v85GCNzE5KHoBFOC7Iht/Gy42AhYpKrZKh+D94Ee84XQKAVDdYxOAqwhJiKhiPM2IgaQ88a4g1engU9akU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=plmRbBXN; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="plmRbBXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751389386; x=1751994186;
	i=johannes.schindelin@gmx.de;
	bh=cdoNpNx8A45HAzcyhWTzyD0Iu16WCHNbqtLb98K6f+Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=plmRbBXNkoQtnm2XwRaCIqH0Gy/ZFnEhFGk1t0A8Q5K7BvpduwGh2xWO8AyJhvM/
	 RpVnZrT1wqqBnf+93fpy8RH07fKARaeBOtPEz7nFFdJk2p18ENY/0kTSKqHSfwA58
	 BEe/huxK708jxLueelB0ImbKS4KwlMB2pGA5YiHIHAeLjQkrb1GBHMqjO33dAIYw7
	 2QP0GsG+ljIwxuaYw+cdqVCpgdlx6Y8B6nfd0dULKIhHoSAFrZtMPE/ogvLxNE517
	 VpwCh343leLd3tnXj8TBXgqC2y6NQFE2z2mBljRG3xowvjKYKt8CgjIj49hfmQZP/
	 5oBPwNjI+YJVdst/pA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.20]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiHl-1uLR1p1iRj-00N9CB; Tue, 01
 Jul 2025 19:03:06 +0200
Date: Tue, 1 Jul 2025 19:03:04 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Aditya Garg <gargaditya08@live.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Why git on windows pops up Git Credential Manager inspite of
 having set a credential helper in .gitconfig
In-Reply-To: <PN3PR01MB95976A4B664ECB1EEB80D215B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <aefd8c42-f9ba-9af8-c0ab-a341a690fae1@gmx.de>
References: <PN3PR01MB959737CFDDC39898364CBE34B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <610f64a5-015e-b2d8-03ea-78bb623f6af0@gmx.de> <PN3PR01MB95976A4B664ECB1EEB80D215B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N2fzQx+XQ614mgLJB22V8Ez1ROtQTxF2EHg06jVOXR58Ok8XJ9U
 A3KGMI7jnL/U4CXJTihnQoggNifbOPa4h+oPl1yF2a8yW7gay03rE7BoSk3tb4WEMo1UDBx
 qwKK2sXj314/mg7eoZ5cFm0usZSqf/XcVRrDZ9a/ssREO3nSct+rRkkLEPhRyEVKa1JksM9
 FUGv5JLpkM+lPR13aOz+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M2tBhwtSOPs=;+UMrYFLK25YuacwYMR+JYSo8Ygz
 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
 FstLSUyiz4Q==
Content-Transfer-Encoding: quoted-printable

Hi Aditya,

On Tue, 1 Jul 2025, Aditya Garg wrote:

> On 01-07-2025 10:11 pm, Johannes Schindelin wrote:
>=20
> > So the trick is to call `git config set --global --add
> > credential.helper ''`
>=20
> I wonder if this is a bug in git for windows?

No, the actual trick is for me to read the manual page myself ;-) The
option is called `--append`:
https://git-scm.com/docs/git-config#Documentation/git-config.txt---append

Ciao,
Johannes

>=20
> PS C:\Users\Aditya\git> git config set --global --add credential.helper =
''
> error: unknown option `add'
> usage: git config set [<file-option>] [--type=3D<type>] [--comment=3D<me=
ssage>] [--all] [--value=3D<value>] [--fixed-value] <name> <value>
>=20
> Config file location
>     --[no-]global         use global config file
>     --[no-]system         use system config file
>     --[no-]local          use repository config file
>     --[no-]worktree       use per-worktree config file
>     -f, --[no-]file <file>
>                           use given config file
>     --[no-]blob <blob-id> read config from given blob object
>=20
> Type
>     -t, --[no-]type <type>
>                           value is given this type
>     --bool                value is "true" or "false"
>     --int                 value is decimal number
>     --bool-or-int         value is --bool or --int
>     --bool-or-str         value is --bool or string
>     --path                value is a path (file or directory name)
>     --expiry-date         value is an expiry date
>=20
> Filter
>     --[no-]all            replace multi-valued config option with new va=
lue
>     --[no-]value <pattern>
>                           show config with values matching the pattern
>     --[no-]fixed-value    use string equality when comparing values to v=
alue pattern
>=20
> Other
>     --[no-]comment <value>
>                           human-readable comment string (# will be prepe=
nded as needed)
>     --[no-]append         add a new line without altering any existing v=
alues
>=20
>=20
> Or you meant by --append as per https://git-scm.com/docs/git-config
>=20
> I anyways manually added `helper =3D ` line and now it works well! Thank=
s a lot.
>=20
>=20
