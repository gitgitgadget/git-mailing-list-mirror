Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FA811706
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896225; cv=none; b=DMpi8lFsFfks25Cr1m9ahW7m2uKzzAZpN2XYye9fxzPEBwK9p8AJ9AialqPK+6H96f0m6v+YwlWOTebLu+Cv+h7qT/AoHrZEdOqa1ghHyCNNPHl/3RzQXOO7+EgDSTYW0HU2M67apTCDv9MgloJ5D1q48Hk2Kw+uP6/leCqfL84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896225; c=relaxed/simple;
	bh=M4bnmB63Xzi9oMnTotP0iIdKwyG3FPA3MkcWVZs9OIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKuCoCXLL5vsgNMSfVUcU8jKbVvlk9m3TMa+TnuAV2foaNYKEf2IcbSA9hXTEKj4dPRCEXEGiHsfek/GbD4x9uMb9/IjJrYuLrrECxvDT7z6JY3ab8nn06PIBkyQqsz4R6OfG6Snh2Lptrm/nTHFCpQq6vP849zkpvu1ahwI3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=gTnJWxHe; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="gTnJWxHe"
Received: from [192.168.3.191] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 4097E60136;
	Wed, 14 Feb 2024 08:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1707896220;
	bh=M4bnmB63Xzi9oMnTotP0iIdKwyG3FPA3MkcWVZs9OIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gTnJWxHeXbJvadigVbQVuipsgpuGHu27UoOwz1RY4Z+6CiiO4E1CMJiytq/T9iguw
	 23UYXsgMN7b448stzxgkGWNB1A4uc3WodKkmoIsrrMW6SP4usJgcW1m7B1ZcUTE90C
	 qT3EyqFRYm6qLOHDCIbNNw9WtMlmtkixWO4Kl4AwdjiP1P5Gc7dvv4vuQGZxTdsxZS
	 EySjPfxxQsBk5N41/qBfkV03FxyqM/6l7Q191HGrhCJEqCXlu746o08qOADhns+ZvX
	 ETXlNB6PPmAdccZ5rzJR/7pyWY1t8aeMcVt+ZH9r+aRYVv5uhc048s2YwJL061HhbO
	 kAPh5e1sDM4pg==
Message-ID: <6e33b2b2-f0b1-46ba-bbd8-3ae4c87d35ba@free.fr>
Date: Wed, 14 Feb 2024 08:36:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff: mark some diff parameters as placeholders
To: Jiang Xin <worldhello.net@gmail.com>, Git List <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
 Alexander Shopov <ash@kambanaria.org>, Jordi Mas <jmas@softcatala.org>,
 Ralf Thielow <ralf.thielow@gmail.com>, Jimmy Angelakos <vyruss@hellug.gr>,
 =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Alessandro Menti <alessandro.menti@alessandromenti.it>,
 Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
 Daniel Santos <dacs.git@brilhante.top>, Dimitriy Ryazantcev
 <DJm00n@mail.ru>, Peter Krefting <peter@softwolves.pp.se>,
 Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>,
 =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
 Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
References: <1e33662683b43e93889b4b3493a0edc2e3483920.1707888478.git.zhiyou.jx@alibaba-inc.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <1e33662683b43e93889b4b3493a0edc2e3483920.1707888478.git.zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Some parameter placeholder slipped through...

Le 14/02/2024 à 06:31, Jiang Xin a écrit :
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> 
> Some l10n translators translated the parameters "files", "param1" and
> "param2" in the following message:
> 
>      "synonym for --dirstat=files,param1,param2..."
> 
> Translating "param1" and "param2" is OK, but changing the parameter
> "files" is wrong. The parameters that are not meant to be used verbatim
> should be marked as placeholders, but the verbatim parameter not marked
> as a placeholder should be left as is.
> 
> This change is a complement for commit 51e846e673 (doc: enforce
> placeholders in documentation, 2023-12-25).
> 
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>   diff.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/diff.c b/diff.c
> index ccfa1fca0d..c256ef103e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5599,7 +5599,7 @@ struct option *add_diff_options(const struct option *opts,
>   			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
>   			       diff_opt_dirstat),
>   		OPT_CALLBACK_F(0, "dirstat-by-file", options, N_("<param1,param2>..."),

This line also needs changes:
N_("<param1>,<param2>...")

> -			       N_("synonym for --dirstat=files,param1,param2..."),
> +			       N_("synonym for --dirstat=files,<param1>,<param2>..."),
>   			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
>   			       diff_opt_dirstat),
>   		OPT_BIT_F(0, "check", &options->output_format,

Thanks

JN
