Received: from bsmtp3.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE8303C97
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774776718; cv=none; b=AvNHhb5QL/bsEJ/1L1Af9OkhyoO8JzBd8WtBT4gql2L7xN4HbicmMyrCqPXPjL30ghFU+L9hlWVaFGiSXcd3l1iU078YPFYvcUfSVWTfDP6ZZLLMQfPQY/NFr64ORv9P8ETRI5yga6IRXVBBmbU8ODyPJaWVNg/cEBCmkGLDl+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774776718; c=relaxed/simple;
	bh=6CfLzlZOXqz5T640lDmpBv7C/d4oTktmC0WjPcAp/cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqejxxOUCZIIqsBV5n7urO3lmHMRk5vapuYw8Sfqo+nImspNxg9E5B9sMTwrwqg4vC09bmROBzeXmWjymNYvpxr6RD/ya7VieSV3KrGrP2cxY97wdvTlc/yFUoWq12CPmaTVRa/3Rpuy8ytcICee4fPgPSegK33TbL+Cu6wLm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4fk8KC3TLmzRnlV;
	Sun, 29 Mar 2026 11:31:43 +0200 (CEST)
Message-ID: <08f1c2b1-5f2c-40e9-ba87-f45cae6af541@kdbg.org>
Date: Sun, 29 Mar 2026 11:31:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] [GSoC] userdiff: adding typescript pattern
To: Dhruv Arora <a_dhruv@outlook.com>
Cc: Dhruv Arora via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2251.git.git.1774734004.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2251.git.git.1774734004.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.03.26 um 22:40 schrieb Dhruv Arora via GitGitGadget:
> 
> Description
> ===========
> 
>  * Add builtin userdiff pattern for TypeScript files. Recognizes function
>    declarations, class definitions, arrow functions, and method definitions.
>    
>    * Handles common modifiers like export, async, static, etc
> 
>  * Added tests for the typescript pattern in userdiff.
> 
> Dhruv Arora (2):
>   userdiff: adding typescript pattern
>   fix(userdiff): sorted pattern and tests
> 
>  t/t4018/typescript-class-method         |  7 +++++++
>  t/t4018/typescript-export-default-class |  7 +++++++
>  t/t4018/typescript-export-function      |  7 +++++++
>  userdiff.c                              | 15 +++++++++++++++
>  4 files changed, 36 insertions(+)
>  create mode 100644 t/t4018/typescript-class-method
>  create mode 100644 t/t4018/typescript-export-default-class
>  create mode 100644 t/t4018/typescript-export-function
> 
> 
> base-commit: ce74208c2fa13943fffa58f168ac27a76d0eb789
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2251%2FDhruv-0-Arora%2Fuserdiff%2Ftypescript-pattern-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2251/Dhruv-0-Arora/userdiff/typescript-pattern-v1
> Pull-Request: https://github.com/git/git/pull/2251

Javascript and Typescript are related languages, if I am not mistaken.
It would be appreciated if the new language driver could be used for
both. Then the driver's name should be the superset language and the
documentation (missing, BTW) should mention that the driver can be used
for both languages.

We have had a number of submissions for Javascript or Typescript drivers
in the past, but none of them were followed through to be integrated.

Typescript:

https://lore.kernel.org/git/20240404163827.5855-1-utsavp0213@gmail.com/
https://lore.kernel.org/git/pull.1746.git.git.1721061218993.gitgitgadget@gmail.com/

Javascript:

https://lore.kernel.org/git/20240301074048.188835-1-sergiusnyah@gmail.com/
https://lore.kernel.org/git/20220403132508.28196-1-a97410985new@gmail.com/
https://lore.kernel.org/git/20250604094100.80598-1-derick.william.moraes@gmail.com/

Please review these submission and the responses that they received.
Perhaps you can find inspiration for improvement from them.

-- Hannes

