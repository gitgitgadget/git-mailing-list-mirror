Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA055382
	for <git@vger.kernel.org>; Sun, 24 Dec 2023 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="oV8QtJUk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703425369; x=1704030169; i=johannes.schindelin@gmx.de;
	bh=EUuHGQ7HOlC8cWnYzfGHFkw/6PghHyM9S28k+D1KCls=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=oV8QtJUkeDf2dNUkFi+MUrkt/WE+gd2ui+OAglD0dQhXCbux/lfm0yi3vcHqDEJs
	 lYqeE2JjiciAaZUCtFgIf7OjeR1akHyf9wKQJtFhZ/DaABi6HBMc3vrD6+jpJuNyP
	 yO6OLvC+ftg3t8qClvnSj2yrqjNHmEG+MyM8TTeKVW43cNqmqIkUtdQW/+Ihe1O1T
	 wLmeRv+k9uHZyGrXHZEhACczKk3MWV/hqLkwTOa0Mzbnr4kPpLnwXiEBJH4gBMCPl
	 n+vSFO4IQ4NaNqDPGVo8f4NgO07xgHTM67x1qbceOpiIx6d/7sD6Bfdoku0DWOhIQ
	 lntgnpBe/A/akitFOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMbU-1rVdq11ltk-00ELum; Sun, 24
 Dec 2023 14:42:49 +0100
Date: Sun, 24 Dec 2023 14:42:48 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
    Chandra Pratap <chandrapratap376@gmail.com>, 
    Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v3] Teach git apply to respect core.fileMode settings
In-Reply-To: <pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
Message-ID: <82dadb69-5016-dec6-3699-4d994ea7929d@gmx.de>
References: <pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com> <pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nmzzHYDOcJ0tn0lNhFgh6Oii+Y2pejoh5NwrxXt0C/rSGpGLDqi
 a9eAmYU8EBTd38sA0Sl31t/XR5vv4WP7EFTYne+LKqwo+aphUhI3vwTaxRg+kMN2ntLfs9p
 +CFovWByFk6MUugEDMroBcUZim+bfo75XV0dcWm+jXD/6WPh0Lo+E6OkPQlIb/dTkuLP53v
 E5MuiOTv9HwxnTF/5WgXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5sl3+M8YijE=;9KlKGCl5hSoMQWJz2V3cuWZkTNK
 3NvUKlRUrESKHxNoFNVMB3oP7jgYVyQv3Ut3PnRbdlC/NUoetToSqh/OAQDhia6hQ0Zz44sgW
 OkrPY1MyIhFqNOJ8X+jU8JrMFcW86UPTiNAf7W7WlOFwrUo4Mwcs7RkNJfVQU8/x6xeaVN///
 5VOJ5ogkD1tFwEKHp5DQfMC6LlKigiIMU+ZPNlMN2TMH09npgp5gfvM9pTtyPH4fpcc3Bs9rC
 9dp4hAzQvO0EcQIFss4dUPIIMZDqWOxc9sfzD3RC7sl6DHb8dkb+yKKisQQKBWvScC+J1eamr
 J/qVTunADXEYMZMGhTER8eTgej45UT76Bua8mkOtoA2W/1kdp+0Nu5D5fzzCo4Q6P9PaZCisz
 IQn73ETrMZ+e9M7zzawjlO+lD7fDi45fWHMYVTcirB9nsebCL/28kq12srZOHFOSy1+HQERrC
 8N3LCQ3nnPJY3n6Rf7W6ammXl+SBaE1KE/Walz7GHyA0Qm1IRRIkNZ/ujZLDV0bRvM6KCi03E
 sILB9HPCoujlWjDh26XzfvnmwZ2eykwRexTCEHhgU1bJMHhomdVrMHml4vU4KO8bCYo2nrVIP
 WYiKBylRWH86UlPMKalxQowNHmFjslZui9SM0TuNn74CTpZfdwiSoSyvnQDyGtcZ7s/Ghzmpq
 olcQ1FZKsp0bUp0AqjHYdv8azlKLyZQFYJ3DWvXe0irUUZtaBxNWEoi0dg7JfQHIAx/8FQobO
 4Cjq32AP8iRclhgFYrPjDPnQu0SvuAZJxPTNtGpD/LciqZA/uWNw2tuPdbKwunHZ2fykakCCK
 kn2qIiHO9+mOgVMUrUWapBWOlG5rLWngOwffK5mws2lCFnhpiG3F3sK/C+vSh/mR43xmUJMAf
 vmYim0V4Ahm1/nHZ84GDDDf/kvSQ/QKW5iD3GHKR0aAh91VpehTG0fL3BDS/JhymUe4AaSeCq
 F97PIA==
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 20 Dec 2023, Chandra Pratap via GitGitGadget wrote:

> diff --git a/apply.c b/apply.c
> index 3d69fec836d..58f26c40413 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3778,8 +3778,12 @@ static int check_preimage(struct apply_state *sta=
te,
>  		return error_errno("%s", old_name);
>  	}
>
> -	if (!state->cached && !previous)
> -		st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
> +	if (!state->cached && !previous) {
> +		if (!trust_executable_bit)
> +			st_mode =3D *ce ? (*ce)->ce_mode : patch->old_mode;
> +		else
> +			st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
> +	}

I noticed a CI breakage in t2106.3 in `seen` that seems to be caused by
this, and I can make it go away with this patch:

=2D- snip --
=46rom 5c2a709b629d396528dabe2f92bf3d4deb5bbdb2 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sun, 24 Dec 2023 14:01:49 +0100
Subject: [PATCH] fixup! Teach git apply to respect core.fileMode settings

As pointed out e.g. by t2016.3(git checkout -p), if the patch is to be
applied in reverse (`git apply -R`), then the `old_mode` is actually 0,
and we must use `new_mode` instead.

While at it, add some defensive code to ignore `ce_mode` should it be 0.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 apply.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 58f26c404136..5ad06ef2f843 100644
=2D-- a/apply.c
+++ b/apply.c
@@ -3780,7 +3780,9 @@ static int check_preimage(struct apply_state *state,

 	if (!state->cached && !previous) {
 		if (!trust_executable_bit)
-			st_mode =3D *ce ? (*ce)->ce_mode : patch->old_mode;
+			st_mode =3D *ce && (*ce)->ce_mode ? (*ce)->ce_mode :
+				(state->apply_in_reverse ?
+				 patch->new_mode : patch->old_mode);
 		else
 			st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
 	}
=2D- snap --

I guess you can slap on that `Reviewed-by:` footer again, after all... ;-)

Ciao,
Johannes
