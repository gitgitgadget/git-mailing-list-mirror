Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AE10F9
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736381900; cv=none; b=HxY+szkPq0qv3jdTrJQE/LRuDRowN6drvd2H7CvagtbUpq5GgeBOjqLq689tJOuWbLwCKethA96lTwQCHEam258YxC/X1NQQ7LKMZH6joKj21Ubw+TaCvUgfbz3k0QBtjcuW5pP6ytl6zaaRJruzU4iN9QXBLZtgmubNeiqMPPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736381900; c=relaxed/simple;
	bh=eBtP2QhgYlhUVj8cl4Ql6XeMP/ZChFuBXev4EXl7XnA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IyQNUPBMwAEizEQOo3bZd3wQ0Okmqv73YYmX7QrBF/B07wbCvMO12nV+yPHjffG+dKi/OLu1/z8hq+lQZwOMbstlWKZItG5xHgXD0bNTkUXNJ7R2PrmiezMbAiPM6oUrxlgm7SJujS+vJ03FFwGUVYgUb8kl9iJHVxmfytlq2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=dlGhGt3i; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="dlGhGt3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736381895; x=1736986695;
	i=johannes.schindelin@gmx.de;
	bh=U42nTlBPkrsf2puGQFTzsmVSwuJ9rPI3bsDNMCz9CNY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dlGhGt3iHtXUxZKinpBB+E3qfL7jQYiJo0K4Dua4C2CP6GBlxKw1hsKpmIx1iW8o
	 J0PRttTCtRq1wqeAThKmbD8yq7dRWlpFnymDT6K+RFR7Oc6Yy4dLVlglU9jZ5R1Lp
	 niKuHXSrZ/1kBUGcHLLsLnFNVK1mtkw0M4IeCxJ4m0Ze4vif5KkboFvhvF6veEPyu
	 tzbB4+t5b9eTyzFgoSvEEBKCyTKWpnVRzAIBPFEH90oSdm77mhXxkRkF9AmmCRyqn
	 8Usjp1mPMOubzlMWssxSojUMVsqiPs9s2F7e4+lHjrOz9Gp2vfshW9vqgRgksKX04
	 72sMMbV+obwAmRX8iQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.7]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiacR-1tyfc82dGh-00k2yX; Thu, 09
 Jan 2025 01:18:15 +0100
Date: Thu, 9 Jan 2025 01:18:15 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>, 
    Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH] help: interpret help.autocorrect=1 as "immediate" rather
 than 0.1s
In-Reply-To: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
Message-ID: <7553dc2b-7b91-31c9-e86e-aa24d3bb4235@gmx.de>
References: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y909hlKhO1L7GHZZOsxHoiYYYylRThqgf6hPifWfWNLRHeVdHo3
 U/srgCDpSMYxgFGdykgZ5ZovKsBHPpKaojTtkjoRRAdYgZjIaZTFz6SUOhaE3sYmC66kOLD
 WK20PLCd9RIHKBYnQrHDCcDjtGyvnHn5+SlPmaFAb+42oDlFz5Jtg9lwjmFjlRECtnDOdJA
 5Jxsp51GcKf4eAOlW2ReQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vck0RNrf4po=;+mh00byzpRDWyKPSz+VKhu+kbAb
 iGR0+bA6QES0I3vjUEj9lisp9vDWGQRwtyjNkS7j5S2NkOt/jyqhlS7e9UGcL6khS5j7zk1L8
 yn0QoQ17I5Y9V+oJQ1y1uc3LU/Dk6k3Xegx4V+gCMQ1wblQNvzHAfRn4P53ThoxaZ63jcW0Ek
 lD27St2Bz/nCsoftl4oXn7dUSJ97ddFLCkGimy6cCxG73vYlSqdKMg+Ylzt+OghiaU2R6uEU1
 2TRNPt2bVWedkdkqqODyYbIoe552mEOdBdgCtLbOFUuxa4xA4EqGNWzWqgV5vPidvn2xT9Kx5
 IGCulN5/IzjExbkUByNHJ0uWuhySwSSG0r2cj8lDwHV5TKV2UlSURCU4nv1AtrGQEyrD5y0DE
 8rHpErmHOuuxKNDyQRdvTy5FocqcPFIW7Vm5jDGeLOkHOyrl2PRUFtyxB1BHr5EOuOgK3kl1Y
 r2EKOrdYrNLChu725IM3bjRVJ24MqoIgbQfKLLIXAonkzEGMWYgM17CFm1PB36ANsaE4P0ImN
 m8oHO6E4I5K2zmC5Daiigpnoc2HPZrVARonyn6nSg91Q0H2/MFSYGjnEzpww3gUoxdVjm5+Tc
 xlRHdZK+Zn4dZdG02kBuX2gXe54OE+4GGo0WKT0Kf9ko1dHygtVwUk/HBmKdZl+4yp128Ahci
 2YeEnrWuB4A9OWVXVjSmF2rtkdLVfwUEtPi7BRbRlW8n5eUdhUsTaB5YdHcptxbVpBV8gHYWe
 6VQenpirP0n4zH+GDdgA3I8yb716c66PvDhe+j78dNMBUHG3IZ47TCW4HkZO+Q8I6i5ZBiI7Q
 bI5icXJKJd+3TEnPJ1WJcbvWnJwoTP3DwSnFE9suNCfGfwNmdUIZyuiOq7ORZbekrdjsf37HB
 RIfUw4J041jM4NWiVP0Xba1NoZiOx9aY1XFB7Pca7JkjqcLDKrAH9STkZOe2hkvuWX/4BoZof
 hLg435nYI++jLjeqfsxoiR2Rliy+N0u5HLHcno0zC9n/o5cng6lqJyvH4zBddS565rCjt1+ti
 URiwRzuJB8SU8UxxwkYxjDRovknJc20Ui2J0dnSqd+aCs75LFBqwYYBOYZM61nLwybe0o2MIe
 fKne6fA0cfnIjDKSadtPv3mv88lzjJdZHPnm7kWNbFYESVVUoScFRqIb8trFp/jhzB++dPd08
 =
Content-Transfer-Encoding: quoted-printable

Hi Scott,

On Wed, 8 Jan 2025, Scott Chacon via GitGitGadget wrote:

> From: Scott Chacon <schacon@gmail.com>
>
> Many people confusingly set the "help.autocorrect" setting to 1 believin=
g it
> to be a boolean that turns on the autocorrect feature rather than an int=
eger
> value of deciseconds wait time. Since it's impossible for a human being =
to
> react this quickly, the help message stating that it's waiting for 0.1s
> before continuing becomes confusingly comical.
>
> This patch simply interprets a "1" value as the same as the "immedate"
> autocorrect setting, which makes it skip the 0.1s and simply say that it=
's
> running the command, which is almost certainly what everyone setting it =
to
> that value is actually trying to do.

Not trying to brag but I had no problems understanding this commit
message as-is.

> Signed-off-by: Scott Chacon <schacon@gmail.com>
> ---
>     help: interpret help.autocorrect=3D1 as "immediate" rather than 0.1s
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-18=
69%2Fschacon%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1869/=
schacon/master-v1
> Pull-Request: https://github.com/git/git/pull/1869
>
>  help.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/help.c b/help.c
> index 5483ea8fd29..e6576644b99 100644
> --- a/help.c
> +++ b/help.c
> @@ -568,7 +568,7 @@ static int git_unknown_cmd_config(const char *var, c=
onst char *value,
>  			return config_error_nonbool(var);
>  		if (!strcmp(value, "never")) {
>  			cfg->autocorrect =3D AUTOCORRECT_NEVER;
> -		} else if (!strcmp(value, "immediate")) {
> +		} else if (!strcmp(value, "immediate") || !strcmp(value, "1")) {

Makes sense to me!

For the record, I do think it was a mistake to treat number values as
"deciseconds" here, it is inconsistent with pretty much any other config
setting. But I also don't see any way to remediate this design mistake at
this stage.

Thank you for working on this and making the feature at least a little bit
more usable.

Ciao,
Johannes

>  			cfg->autocorrect =3D AUTOCORRECT_IMMEDIATELY;
>  		} else if (!strcmp(value, "prompt")) {
>  			cfg->autocorrect =3D AUTOCORRECT_PROMPT;
>
> base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
> --
> gitgitgadget
>
>
