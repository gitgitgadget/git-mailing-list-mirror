Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2040.outbound.protection.outlook.com [40.92.90.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9636944D
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705562356; cv=fail; b=iOsVAiFMezNuMEaFIO60NVixCqIoSS9IaLm3JDV/a33+lLVGFCg0QcK4+5yj07aimIXaCt9+X4s81A0gsxli+DQAuNMxG2SCr0w0VHjAuuiqlZX0G2yyHhPdbO0ex3pOwOfwt2Uvn7tEcEYckcOKX6Dd6b4uwb9I6jlPR9NFGTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705562356; c=relaxed/simple;
	bh=5YwJvMP62Ny5jg2mpPq8RfFI5ZMDFt2Q0w0a+v6Ba+s=;
	h=ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:X-TMN:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=OU3xLPmPGPXP7o2+bS6B4gurnmXM+5wvf9wtbNTeLuMIsuwAuDS1dMegFOckI3XlAyixtgvn+H4Xd0aykhiF2QPbKOV0JtUBxkyHx8l68PfJ9ZAooeEa9cDTeo3i8VMHxtmg5WzcBjQCPOuktj/46JoAf4iiImIsSvjDTG3G3lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; arc=fail smtp.client-ip=40.92.90.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3POIpb21Pw/KHQ3/yR2xuYQnVOQFv++EC4QkGRq7+HCVQkFJDac/jDhgjGbMgcq9F8sR0lpT4ys5zGUfYHvZWP2yAtJgdnLo1/BGcdeeMWb5lopnwsDvDOsCfaz6k6EYdNgjbJFEBCMGKQnPTdDzZc0aOngYFgkDVYUY5F5UNKp+jVMvciSLXBHMw7TN0yRHsE2ZzqpGsAdiF3eVe4qX2hh9FgAhe6Yzvcz4Fo1xD5lEsRMJND0wq4JrqbqLpm9D75hkiL3y2mhZGafgdK0/FWXvX9VVMao7/ek3Y9qOFSZGAk2CgCzgicAqTXXg4XkY53mdRdGCX20oosgOp6vdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzvm4nrMtOn7tuu/LwVbQAMGUgqWw/Y6e4SCrveF9yk=;
 b=ebtJ1ANEwr/b50i02nNy+PoMXjnKXyP/z6pGow/7Rzrd/1HJ/cF8V+6gkVxNn0Ac+lkQf0X20YWQ7ocsevpmWvzB7KqMl68kXRioeAPxLkUj0FC0TJdqBInj4qAuJEz464LGwEpAqIDyoNCalLf/DWb06UZEoHNioP2aBpGx4UB22sVihDh9KgtPyWoos1M6JiIR2sLT8v68N27Z6r2oskXtpp7P+OMxTMYgH5LgP+1bVqsFJJj5RA1YAZ7I+OxcuS77rQfF7BYKQ4udMeHjqYngHMM5TgGcXljFiHgBfKDD/gcNlEz9F1hWGrEBE6xw3Wox75qzs9qt4twh1s2vIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by DU0P250MB0411.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:343::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:19:12 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9ab0:984c:98b0:1982]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9ab0:984c:98b0:1982%6]) with mapi id 15.20.7181.029; Thu, 18 Jan 2024
 07:19:11 +0000
Date: Thu, 18 Jan 2024 08:19:10 +0100 (CET)
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] ci: make p4 setup on macOS more robust
In-Reply-To: <a5d725bea7b2cc2b8f66682920dbba016e89da9e.1705318985.git.ps@pks.im>
Message-ID:
 <DB9P250MB0692629640B05593B798E5A0A5712@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <cover.1705318985.git.ps@pks.im> <a5d725bea7b2cc2b8f66682920dbba016e89da9e.1705318985.git.ps@pks.im>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-TMN: [/S2QmxRqGc2eu9anZlTInc84h6Kpgk7u]
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <830e63e9-aaff-9827-b5ea-0d65af3c26b5@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|DU0P250MB0411:EE_
X-MS-Office365-Filtering-Correlation-Id: 754586f3-7395-449c-dbbb-08dc17f5c48d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3AxH1yCTLvS3Z2AGjEzScfI5N1LIOx7QuedVY6eisythz4u9jlHqOPFHOKlQHJTk1KBBP2rZOBCzwBdWaqygGE4cBtc29qhaSDshh5qUKs71BjayHN2BJOs5RLB2K8GfkQG5Yd89oqr9DSEnWMIUkF+yA4GVtgqwQxoUrXxxbN7rShHWr3rSXk3jR//T4b0LD8NfF9Tsd9IRxS6aiV+NnLxty4/iZTiT62Zp4746SEQLzrOH2Q7KHT82oqPjkoYtBK/QDoJaJw5eMkj82POqm0eeW7memUaGaTgM2c0OVXJ4Jlz0SA7GSBaxHk5ow2GBOEC/JG9cF0QrsL5IWcFrlG6GjBg3fQajf9+C6GkjH8xCOICL2oIbLWyla3hOjVCI6WG/0/bMzbNKNh8ZaTxKUXskyAtGnuEbk9twOa+IWEgNMqcHDCoAcL62enqmsiX2kFz5Ysqy534mw8vshpo51A0s5B8n4X/t1n2WT9SLjHuHgzE4yL2XvHJ5KBvIE4vi0iq6SDqKueBp+Gogs1CpQk51sw3OZs8NjeyblJHNCVdZK9rlPmqh1QbVccTTqq8i
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JsbWpj8RU9l/3a8tXizj+NbTTtDOLEEx37AID22fa8N6b6FMI88xJs1bARf/?=
 =?us-ascii?Q?yi60Op5tWFeP3UTCnrSCcs4+qUAL7TrpTyYe1uRJkP3KyaVBdP1CWflNI8ge?=
 =?us-ascii?Q?t3fyJ3/6p1njS3oC3XpeCXsYs1GzbwxXhbTcHrCOHWWK8YZPZ/rhO+4Seekl?=
 =?us-ascii?Q?onkmPTXJWn6+kokzF9DzvecNMwWp6R0NYzDR/3HfUJT/czxkbG+pjqCjRXRF?=
 =?us-ascii?Q?Z2D6inRGqiUuxWXSp95q9wTJuIsW3Badu219KcJ9IPUhoi5ngcTpTtomvZUG?=
 =?us-ascii?Q?ZrjSpFR+v0GoFPuhuJnKqforULwC7l2aeKbSanIZJ6YwxDyTJKCsg0PJRQpB?=
 =?us-ascii?Q?YIPZe7H4a/fwO7FdjEIklSCDp1ZVa469bDEt76fojensKo0jj/5pVwjgwwpP?=
 =?us-ascii?Q?3P+0vzf/EUmOLCsJlu/2DyQ+6qM5Yj4VqB3f9WRVTYgfIBsFPDgf1DYPf7d0?=
 =?us-ascii?Q?EytxfIi4r9ALF+OtwlvXlMdSM7Jlojp1g5/CwqQi1P3avq4JWeQYsy4ydIDQ?=
 =?us-ascii?Q?lmMXPqi30raapDfQUbhs0NUyx+WS31sYhztaMYvmNwuszH5dq6xuY+y7ONnl?=
 =?us-ascii?Q?jHDHlJ9b/dzU94lXuNpNTxMjvv2v5O1OIesqz5SBI4WRKgQDzGE5r14LgxhB?=
 =?us-ascii?Q?/sFe47Cb/Esh+F8WBctHXubmhJ+TQl+sDAzx/te5PrGVkTwAHdMIVwDKyl58?=
 =?us-ascii?Q?yMFzx/3HeoDmTMiZ+6tzVfPPjcrAg2zeT8t+zGnu8vHkN0dE2cKCTLNfXrvX?=
 =?us-ascii?Q?Gtpk/NmOGFUav7MowAeX+ma4lx5M9u4Cdd+Duod3yxaG0zANFeDqCPJkXSgY?=
 =?us-ascii?Q?4agGbE0cVZtQpJRM+EQlBRb4bSdHyej0KEsoNGrfDATmVXIkbPGQ5+5dMj5p?=
 =?us-ascii?Q?hZALuoG5gdlPD+Yn57SsjnuBQ7ieCaY54qJt3Swe3tIbRdNLIvvWU2I8rYEg?=
 =?us-ascii?Q?kSLSIkCOW/4nH42ZtN6zzKBP5/+djFXB8RMFL6l1Wjye1vXpNKQvM/1hs/+3?=
 =?us-ascii?Q?AGd5rioyFP/wMVo1aRSvpZ68ZrrCTAjNAfFKQAkItRp3Q0vWysixx6lYkg/2?=
 =?us-ascii?Q?16/UmskM+igdOh4WZuc1NH6vc92Tv7HjG71I59PnCvhrYgQiwZLfs0Gw3+sW?=
 =?us-ascii?Q?PcZTUej11X/IIDA6kBXcGCEX7WepESJb+A3CJLkeRSNJ5Ih7YqbTHDUreFfs?=
 =?us-ascii?Q?gvQRSGjIp2K/CGWS/GVehK2073Y6dsvMwC6tJg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-0fa01.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 754586f3-7395-449c-dbbb-08dc17f5c48d
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:19:11.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P250MB0411



On Mon, 15 Jan 2024, Patrick Steinhardt wrote:

> When setting up Perforce on macOS we put both `p4` and `p4d` into
> "$HOME/bin". On GitHub CI this directory is indeed contained in the PATH
> environment variable and thus there is no need for additional setup than
> to put the binaries there. But GitLab CI does not do this, and thus our
> Perforce-based tests would be skipped there even though we download the
> binaries.
>
> Refactor the setup code to become more robust by downloading binaries
> into a separate directory which we then manually append to our PATH.
> This matches what we do on Linux-based jobs.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> ci/install-dependencies.sh | 10 ++++------
> ci/lib.sh                  |  3 +++
> 2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 4f407530d3..b4e22de3cb 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -37,15 +37,13 @@ macos-*)
> 	test -z "$BREW_INSTALL_PACKAGES" ||
> 	brew install $BREW_INSTALL_PACKAGES
> 	brew link --force gettext
> -	mkdir -p $HOME/bin
> -	(
> -		cd $HOME/bin
> +
> +	mkdir -p "$P4_PATH"
> +	pushd "$P4_PATH"
> 		wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
> 		tar -xf helix-core-server.tgz &&
> 		sudo xattr -d com.apple.quarantine p4 p4d 2>/dev/null || true
> -	)
> -	PATH="$PATH:${HOME}/bin"
> -	export PATH

Didn't this put "$HOME/bin" on the PATH? And isn't the main premise of 
this patch that "$HOME/bin" is not on the PATH?
or is the issue mainly about where we modify and export PATH and was 
masked by GitHub Actions already having "$HOME/bin" on the PATH?

> +	popd
>
> 	if test -n "$CC_PACKAGE"
> 	then
> diff --git a/ci/lib.sh b/ci/lib.sh
> index c749b21366..f631206a44 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -344,6 +344,9 @@ macos-*)
> 	then
> 		MAKEFLAGS="$MAKEFLAGS APPLE_COMMON_CRYPTO_SHA1=Yes"
> 	fi
> +
> +	P4_PATH="$HOME/custom/p4"
> +	export PATH="$P4_PATH:$PATH"
> 	;;
> esac
>
> -- 
> 2.43.GIT
>
>
