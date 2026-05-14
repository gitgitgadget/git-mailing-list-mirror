Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206C401A36
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768934; cv=none; b=VvclixckUXno8uAijyaP9Df+a9YCzLvfsrWu708l8LDw49P52uqLWDFIu5Jqo37FdxAr9Kqrq7a9WnnvaR57cjridIl7uLNR6ZC7jk+K2zDDgi0bC/+4FFJbUg3N0G9ffL11yhKYndh1NApPY/QDSUIivX0xRARqXwKw6lkXy2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768934; c=relaxed/simple;
	bh=zSwEQnY9/0YzZElQrAy47wOMpn4EPl5+m1FgpFQly4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHUlVZFC+3dsowdQPAYF9QJRPxkeNzbPu90kl3GWb0DUB76xU0Y9D6X3Gla1ES6cUIPvmY563py1nThoHxLPxW7T9Zqj+7CCzQHI9b8g8LuHky9Mz2yrjYGsrGWVj5RvoNCmbnUbFZpSlgPl+NY7NIrDJhVcV8RH2rla9F68R7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qsTo43oP; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsTo43oP"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b6c9fdb68cso73169926d6.2
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778768933; x=1779373733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZixOL4ZqDswk3X0usShl8fCai416x6Oy9hXP//Ypqo=;
        b=qsTo43oPavY+cZPiDUFUXcnLUI0GcKS8PtXOVuUxnOfZYtxLUaPbQ+EkhQLxk+4wCw
         glQPfNkCZXDEpv4omFAPzIUXbNCqS6MPzXZLthclmP2WicMt72dA8pPomA4FF6VIWlqH
         SAU79Mc0dK5LMd9LNzfyTmIqB8SF0got9g1XRqegAPzWKTaobW2eh9/ibFYN1aQL3TAC
         I4aKXyzuZN9pkwYagWKoPpYHY0NTao702K3TjyQ2Yj0JIkL1pylnh/2532A3E+LLTL8Q
         GNZcXZ4PmFA1uUovnzTcCBZYULWlZU989QEDV0L56hhFuTFtYR+hT2y7ttvUeatOmweU
         6m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778768933; x=1779373733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZixOL4ZqDswk3X0usShl8fCai416x6Oy9hXP//Ypqo=;
        b=RcYWL9A+UQOkK3WM2tEhuYM8WQp8AxF3L9gU4+zF89O5nxZANcRRBUaMvdC+jOTug7
         6xHzf39CeIHF5Z//MF+wDn4NixuxLltkqHH+SIlmxSwYHBCxXrc4To9DwfHjpSKGY5/H
         j7myA0JklKTMzR1/bnLNRcx9kX2W0lFB1l4rEyoMavepnKkWiG8y7z55pfI4/f3xmhoZ
         IppndXr76ERtA+NOR9a2Edj5rahs/jsaiqOYTWb25ZPKqeQdqpUtnewgTR6WXdCt3zNz
         X8jwfvV2amgnDK40MOKXWfHfCZG6pGlL2MNNLLvzVdIWiNXYHtgVbX2aJmVXdsa/BtEI
         J17g==
X-Forwarded-Encrypted: i=1; AFNElJ8KeEwTvR3NM5lQugMn60pAVr+mux83L2HISTtjJEelfLOL618JvJEgGJaCrcTi+OZ+QQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsz7UfhJvt5YRx7S4TLhQ+/sespCcwn4TxLv4eT7q+B4YQVS0/
	pAQO3EzQ5GwpEtVBATeplCssqmkpr2i4t9h5c97eIJBSVFREgEzXR4wz
X-Gm-Gg: Acq92OEHYklrrDO61YVIxQqHJG8cGAUIGIHofk7p+G8DqrAIrdtfrDpKFZCd4CCJ9TW
	ca6NzvdJN2jsEcUzk1ddMlWEOGvBn91xdev7JEFWdNtjMJD3fsDqFWXFidITMUf0/klkA66FRt6
	Y70Ptbih9/EZUJvSXE/6NELc8hsWjVPQ6+5+xxMQ/QnpfaxG311AE8pJrfQ0WUjX6k/Gv72/aDN
	xttHFbi8D5PfYvQs3Po6DbajMpQAucKBleZBmrqfVWUqX50o7siJnLFkH0A/cH/ocFiCtsaHvBx
	ckYMX1wqvBR3gskyNADZzr5oLeqFAEx/9HGFZV6YcS39NQk75g4Tuc/isdBoBOhCeMZfSDerN3n
	0J8xi0ejOEH4HoXphfewexEDYyjBiOmcOwd7ztTHWc5Vmrs/HJRUSALeEdRobnCF+DNn0XtXeRH
	V8TVHe6dnv9Ft1Uvf5mFxcB+eEHed9C0hSLA==
X-Received: by 2002:a0c:e004:0:b0:89a:9ef:1922 with SMTP id 6a1803df08f44-8c7dfdbbfc8mr106734626d6.40.1778768932591;
        Thu, 14 May 2026 07:28:52 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100::59a? ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b2dc468sm25121606d6.30.2026.05.14.07.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 07:28:52 -0700 (PDT)
Message-ID: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
Date: Thu, 14 May 2026 10:28:51 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] git-gui: robustify startup and fix environment
 handling
To: Shroom Moo <egg_mushroomcow@foxmail.com>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Aina Boot <bootaina702@gmail.com>
References: <tencent_DDD6467B3F6184562B51C23BB9DBB79EA409@qq.com>
 <tencent_66A1C2CDB9D5B764A5B4468D3F11845A2A09@qq.com>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <tencent_66A1C2CDB9D5B764A5B4468D3F11845A2A09@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 9:37 AM, Shroom Moo wrote:
> Shroom Moo (3):
>   git-gui: restructure repository startup
>   git-gui: disable gitk visualization when no worktree available
>   git-gui: handle GIT_DIR and GIT_WORK_TREE early
>
>
After careful consideration, I find starting off by fixing what is broken in git-gui about
using a bare-repository, and letting git core handle GIT_DIR and GIT_WORK_TREE, leads to a
much more complete and different solution. A patch series (attempting to) do so will follow.

Mark
