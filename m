Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794676486;
	b=E1ifVKfsy5QffhTHR0JxS7ZgWF+/mImg/hoDtNn5YHSU0sU3dFO9f/tRGQmwimiN6K9v
	 UtiXHyrpFlKwY9qN89SV9VgVUD/AIeD9/cecfO9sOBd1oomAnXmiI24+TRDB2y4z6CjnX
	 NveBnBWhYwUERv8MkCDDKXGYt1vesV7KzZ8Bbdbi1DWwA1/PKAiXVt1Oy6wQbwEEhhR2s
	 8jsUcEwWqRPSR82TZDSupp/lZnXJb5bPFQezwUyjJIO5uL72zQtWCD29j9jL6/WoTOIDT
	 Gp8PvQbAbkWr2ti8vKszPzQlOt+HQZtg248V+aQBYrzwNIEPZj1odlWSMGweosw+0tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794676486;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=w/+ZmgtRkLBcS6QGuKaYQte2GwIED+OU7WdfcIAWgn4=;
	b=qtp45bWn8SF1nQFzpO5TtDsHZxukIYWZgWHeNqXEaAbIj/2V/FNP0D3aSCdoYjyY2MaZ
	 Ry0i1yCCGbTy5daw0c9EzyjLISpWiAFyQYsSF7MgU6wdpkXoe7z8OF2UgxdMDNP6bcYn8
	 vCs1B7HjRaV9ps3m1P7aHO11C1FbKKixwlLQnEML5lHAFxLCD2Rp6pZZBEiNbTZaM5bbY
	 SbuLiHofS2oKwV/1AF6YNJ8opiogsFAwLI6pyd58g+3of8y/Ute3Yl40vLyIVNqv04jO3
	 GUUTZf/drZgoeI7ZBeozNJiE/5w8qvExl+LI9HwZojnSvVROsdCmENZ5qd8qtJcJXyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=e7k1Vdex;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2D606A32E
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 17:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F2D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=e7k1Vdex
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6AEHEc1c012038-6AEHEc1e012038
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 14 Nov 2026 19:14:38 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xSHKo-00GdOc-HK;
	Sat, 14 Nov 2026 19:14:38 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sat, 14 Nov
 2026 19:14:38 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id fa49ef05;
	Sat, 14 Nov 2026 17:14:37 +0000 (UTC)
Date: Sat, 14 Nov 2026 19:14:37 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
CC: <git@vger.kernel.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>, Jasper Mayone
	<me@jaspermayone.com>, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v7 4/4] branch: let --delete-integrated find branches
 merged onto changed files
Message-ID: <20261114171437.DqB_k%taahol@utu.fi>
In-Reply-To: <4b5485584e218e6136835c02a4e9b01ef9a5c574.1794662670.git.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v7.git.git.1794662670.gitgitgadget@gmail.com>
 <4b5485584e218e6136835c02a4e9b01ef9a5c574.1794662670.git.gitgitgadget@gmail.com>
User-Agent: s-nail v14.9.22
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
X-ClientProxiedBy: ex19-06.utu.fi (130.232.247.46) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaXEgACRoJBAwGBxoMDxoNBigP
 BQkBBEYLBwVIWEhaSFlcSFlbWEZaW1pGWlhfRltYSFBIWEhYSFxIWEhYSFhIWlhICg0GRgMGBwoEDSgPBQkBBEYLBwVIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhI
 W1pIAxoBGxwHDg4NGgAJHQ8bCgkDAygOCRscBQkBBEYLBwVIWEhZUUgFDSgCCRsYDRoFCREHBg1GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=w/+ZmgtRkLBcS6QGuKaYQte2GwIED+OU7WdfcIAWgn4=;
 b=e7k1VdexH8hLQKVmp0ol2Am+KqDfLaf2pU/4lgYeN9JmVLYHltQRe4UYCxMbrJhRLaaKq8cUjBdG
	lEpOQ05TLzIjl8o0y4VG5sRHlSI/lAp92hBqsoJ24Q5mNJNVcG2xG4HE5KsAVzPUka2mJelpR8mc
	ypd+A0HnBKhbdsDn728MIUXt4+1Ey46ScZP2Oy1++2EpS7GHyyeaDXbyrPnkPvN+9jgwRy2Ka0Bn
	vLTvPYpyDZQXowQabg+ehRjgXr2JShXx60to1uZkiOGq8sa/B6W9TgfjJ74qSS7A9CREOIVcrloP
	kqJJgzup4lpSeKo8bQM0tuOAbu8kyVIIpn2sSA==

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> wrote:

> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> A branch that upstream integrated with
> 
>     git merge --squash topic
>     git commit
> 
> after upstream had also changed the files the branch touches is still
> kept by "git branch --delete-integrated". The squash commit has neither
> the branch's version of those files nor the fork point's, so the
> previous check cannot see that the work landed. This happens all the
> time on hosting services, where the "Squash and merge" button on GitHub

Nit: that sentence scans a bit awkwardly.  Perhaps something along these
lines would make the idea more clear?

	This happens all the time on hosting services such as GitHub,
	where the "Squash and merge" button lands...

> lands pull requests this way while the main branch keeps moving. A

Hmm, I'm not sure if I understood that.  What is "while the main branch
keeps moving" trying to say?

> rebase merge onto such changes looks the same.
> 
> For each such file, merge the branch's version into the upstream one
> and treat the change as landed when that leaves the upstream version
> unchanged. This has to read the files, so in a partial clone it may
> download blobs.
> 
> The merge uses the attributes of this repository, from the working tree
> and the index, the same as a merge run here would. A merge driver that
> only the upstream repository has is not seen. In a bare repository only
> info/attributes and the global file apply.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  Documentation/git-branch.adoc | 13 +++--
>  builtin/branch.c              | 72 ++++++++++++++++++++++----
>  t/t3200-branch.sh             | 95 +++++++++++++++++++++++++++++++++++
>  3 files changed, 165 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
> index 6be28c8a4e..489a9d5fd0 100644
> --- a/Documentation/git-branch.adoc
> +++ b/Documentation/git-branch.adoc
> @@ -240,11 +240,14 @@ remove it anyway.
>  	Like `--delete-merged`, but also delete a branch whose changes
>  	the upstream already has even though its commits are not there,
>  	as happens after a squash or rebase merge. Such a branch is
> -	deleted when some upstream commit since the fork point has its
> -	version of every file it changed, even if those changes were
> -	later reverted, and the message names the first such commit.
> -	It does not matter who made that commit. The same rules for
> -	which branches are kept apply as for `--delete-merged`.
> +	deleted when some upstream commit since the fork point has all
> +	of its changes, even if they were later reverted, and the
> +	message names the first such commit. It does not matter who made
> +	that commit. A file counts when the commit has the branch's
> +	version of it, or when merging the branch's version into the
> +	commit's leaves it unchanged, which reads the file and may

Err, what exactly is the antedecent of that "which"?  (Okay, I think the answer
is "merging", but I had to read the sentence again and again before I saw that.
Can we make the passage a little easier to grasp?)

> +	download blobs in a partial clone. The same rules for which
> +	branches are kept apply as for `--delete-merged`.
>  
>  `--dry-run`::
>  	With `--delete-merged` or `--delete-integrated`, print which
> diff --git a/builtin/branch.c b/builtin/branch.c
