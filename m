Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B81225403
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776865550; cv=none; b=NFM4PF/LF0PrxKJbZxtqEQz6js6he36prU7/U78LV2LH0Uh3I7Moqr/SRhzSb806eaZRwOahTCufiGoVoLlG1Olqjog/JfxFSLVthtyeesYk3AE0/nRaTJ8NTmGPhriyR5+fJXAW41t/OBBur8hzdOjT3m6G402d6ltWcF2wHYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776865550; c=relaxed/simple;
	bh=WmJ5/iyZlb1iaRH4jrY0ZEkmPC//9LrJvolKXlf//1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrmdd2JQWfnwwrw9sc65juQCj5eg9fButYmBJTZAAOsPzbvQqH77qFHaCE+YEC6p5PShGPUDyMaB11P0xmleM/S0s1uGJaFP9Ibm6D8aTo3WAaHGwMi3RmbTDpdk5z9vHqyF5zfzyhBjmcbZ+xQ2A8wUP8LmULKdJJQqjbK0f/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Di0OXQTR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di0OXQTR"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso58222395e9.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776865547; x=1777470347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sgdvUSjjJUTdo4NFsySdFxjXCyAAUx+CTr06L5OSpIw=;
        b=Di0OXQTRCY1NKgs/FLEIDU6hLfeeugELijDkQo2z3F0dXr3fpLFK6VbYgwvZ8d69ks
         lcxgfIbbtXHDZVryH4KsDcL6dXW1nI6SNYDIU1DkokOe/LF9G4drO+P4+MROx52LQfjI
         EgzK37S4/jLrgjDe03QALm8u68RpyAq1Glbj48Qwh864gUsrMJ08goZnZ5vCD6HlE/O9
         JfIhwHiaZufQ2aNTmZNW+g62XUNnkjxbN1RfzPj2jhSC71YsjX2c2zq12ZglXLYqGVil
         0B+KZJaLmoahz2ggOn2YQp5b08xeA6YgbbuZ7OVZS82o7j0zd9807wWQi+agxTNuPN2F
         viKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776865547; x=1777470347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgdvUSjjJUTdo4NFsySdFxjXCyAAUx+CTr06L5OSpIw=;
        b=JdzSfXkFtE3XGDD9DVCcpnz3DGasCj3VqGwUdbgx88kXu2RTWvPjaVWdvv7nxBAODz
         pEo43MY2/nHNsMdtcIYRwr0WoIwgaTqKRoflYf57Vs2weRcnDu9rkEZ26zcZfe8bKu19
         tGwA6Tv6x7p7plCUSZR4IuGSxtf6QjBQwEaYieXj32G+RM9o2lZYtLHYlfAp0XfQ/VgX
         EqwUy21CnsT/8Ggqh/cdTeYj7J5QWdlClhBIvq4U5W3rdH0Jm1qpf/UyCHpy4kBzwuJD
         cao4mcaEfUvpYHnoYSyq1SSvW3Hvqm4M5IlxvoUIP8lPxSpLP8zOvw+ZUoz4wqq9mn62
         9RAA==
X-Forwarded-Encrypted: i=1; AFNElJ+9/TXVVQU0HaIFyQ8iI1Wpbq8V4tS1R1bEWq1qF9i8+1TpgzDGnP0emKdcIKnKSbPApkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY57+49vvZ2LXQWkb+XepeWJLU4wrvBln3l4UyF03QBc9yJde8
	wFV28Peyp0+vAF37gL18kDeQWlMrKVF4XwpReL54WUg/ZkTnR3JeBwRONNhXDA==
X-Gm-Gg: AeBDiesTBEzfEwWPKVFRqss87wwgYL6TzmkpakkOzj8HXqrWU8dguweAeI7JW4d8vpc
	zk7IUWj26RwF0J5bdwmEgcQQn0k5eC7kctlbZULti0wzRv7AQ1unoXQIkJHlQuTI1hm0Kle3mi/
	ld6Fkiqg1OBR1qvX4TVgvGIRG0uZ8Ig8fWlxv1NHqpgzWzZKGjrf2uj9mTjiILjY2kTQ8O/kMYv
	PWqvgDg4aCZQtwNcDhb5ETMLeHCQgSHeDZFH0YI0prgvgpxTnKHad+Xptee5TlWCGwqsgeaUArf
	wjzfvxRwQkWYSInUqLVc8VYCVqY6lM7Qq19zCClIYZTePrLJ19k3UW6ZgSNhQePg/Nstu/noYmd
	Kk+yMXD9AT5tQ3byuHz6hKRHddza+ajlaz+9SkTEkEM9Azckas1lzqKby/5jyzQEOVUsAeqTreI
	x8rPrxTNCVqVx6PsDgKaswaaMbbxVPXZYFKtvZ2YqeDLTI72SGE0CoHWyGpU4xI3BRu567R4htd
	bCmmHEdN5k9bw==
X-Received: by 2002:a05:600c:a410:b0:48a:5821:6006 with SMTP id 5b1f17b1804b1-48a5821692dmr72321335e9.4.1776865546903;
        Wed, 22 Apr 2026 06:45:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55b8baaesm199150245e9.10.2026.04.22.06.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:45:46 -0700 (PDT)
Message-ID: <0557838b-214d-4e8f-9cbd-bc342563e9ba@gmail.com>
Date: Wed, 22 Apr 2026 14:45:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] generate-configlist: collapse depfile for older Ninja
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com>
 <20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Toon

On 22/04/2026 08:21, Toon Claes wrote:

Thanks for the excellent commit message which I've trimmed.

> diff --git a/tools/generate-configlist.sh b/tools/generate-configlist.sh
> index e28054f9e0..f5f42492c6 100755
> --- a/tools/generate-configlist.sh
> +++ b/tools/generate-configlist.sh
> @@ -44,7 +44,9 @@ then
>   	{
>   		printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>   			"$SOURCE_DIR"/Documentation/config/*.adoc |
> -			sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /"
> +			sed -e 's/[# ]/\\&/g' |
> +			tr '\n' ' ' |
> +			sed -e "s/^/$QUOTED_OUTPUT: /" -e 's/ $/\n/'

I don't think this use of '\n' portable. The sed man page [1] says that 
'\n' matches a newline in the pattern space, but does not mention it 
being supported in the replacement string. We do have an existing use in 
t4150-am.sh:"am newline in subject" which does

	sed -e "s/second/second \\\n foo/" patch1 >patchnl &&

However if I add "cat patchnl" it shows the subject line is

	Subject: [PATCH] second \n foo

so sed has inserted "\n" rather than a newline. Indeed looking at the 
commit message for that test it is testing a fix that c escapes are 
printed verbatim introduced by 4b7cc26a74 (git-am: use printf instead of 
echo on user-supplied strings, 2007-05-25).

I've not tested it but I think

	sed 's/ $/\
/'

will insert a newline. Alternatively we could do

	printf '%s' "$QUOTED_OUTPUT: "
	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
  			"$SOURCE_DIR"/Documentation/config/*.adoc |
		sed -e 's/[# ]/\\&/g' |
		tr '\n' ' '
	printf '\n'

That leaves a trailing space at the end of the line but I don't think 
that should matter.

As I recall, the depfiles created by gcc have all the dependencies on a 
single line so this should be widely supported and I agree with Patrick 
that we should do this unconditionally.

Thanks

Phillip

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html

>   		printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>   			"$SOURCE_DIR"/Documentation/config/*.adoc |
>   			sed -e 's/[# ]/\\&/g'
> 
> ---
> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
> change-id: 20260421-toon-fix-almalinux8-102de9138294
> 
> 

