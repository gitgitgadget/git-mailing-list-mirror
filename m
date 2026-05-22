Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B3F3B895F
	for <git@vger.kernel.org>; Fri, 22 May 2026 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450871; cv=none; b=cKmfrarDrKqdsy7/KXican4PDJOvp7donUhlHc+bD3LAcwkAfC3tVrQl4Y3cMRTJLjzkJt5eXHZjCzhJAfGgl6TaHB8pd5F3MZAEqx3DSPEitqfwBPQcYr/G186XtUI3CLyADtri2yKkFCMqtdBkIlqS95bjJqcEHbUuY+xGxGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450871; c=relaxed/simple;
	bh=Yp9z7KEVXAzdS67ZnSeelNlspjhqopEuJQfjcqS0KoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyZ9RErlZxN5TOmtyYtwDUbUE1DtsGsGnq8bMrFxLvOPgWMLvPvwn9RdyIPjaiTZYhs1IzGGtkx4FXYV+AITRTvLsUnwQu9ZiwjxBsqqJGrN02WSY1f8avz4ZCgSLe6S870jFs5zivfYt9F3f5Ef5No1vtEE+YOI5WeCCIdUi8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOYnfpmA; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOYnfpmA"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-914b5f85129so63940085a.3
        for <git@vger.kernel.org>; Fri, 22 May 2026 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779450869; x=1780055669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6mv0zoAmHZqpxa46c//ojxYSc44KqYLV0izNQb70tc=;
        b=jOYnfpmA9ZusY8LNY8Lh5lAUhIrB0aa0ahnBad35gzefptMhiyfUwv/U62a9W4QvGl
         moIfvtFy5yWIu0cCjNfO8p6JC692OdurgaZRz+jA+kN55yU+c9rbQVN7tsmcf1UUlO9K
         Wqv/YjBpBV7W6zREQyLeVq1HORAD55TluRh6d2Xvq9Bv+PurhvPGC7dBm+6AoX+cMIV1
         YP1ePk0md0MzMdnoKRYBe5D2DmLSQQfVhLlqI3JGZ7cCPm1Csl3EvU8hliUrMkWpD7Up
         CEN8OL06qNcNfCBHnsgwcloxLDKNype86mzvGJZT019cDf9bHHh1fEGlAm2577ENUfGx
         jxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779450869; x=1780055669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6mv0zoAmHZqpxa46c//ojxYSc44KqYLV0izNQb70tc=;
        b=Juw3mTrghCbmVfGuMVn133J1HcGDMp8bSDTyHCn/60Fhc922/N3RNXrkVMWb8D/ghN
         LDdXHm9DS2zr7MFtN0QKRz3SbbktM1OLGxxO4ppjF0rrJDIMA0rRe+ojAIbapXJrSG9O
         0pCKRgCA++BEs8kWS3bR2/gXQyGiI7Gl3KOl8Mnhq1HddVRNwZza0k757/37Gak7WPTZ
         DxaqzfA24YTOOLlQ6pz3zwWsKzLroHfHiHCtx2pS4W99kmsAYOpQJMbZr7ot65qMrQ9f
         84cRyC5blh9qPPb9Wj97ScR0epD573JeEV8hT+kYvQzTv6EW1fJDApmzLnLQWmOEmK3Y
         fiOg==
X-Forwarded-Encrypted: i=1; AFNElJ/pYZiSJYhJQweXP49y/DJnLtHMVT4p9aBuS/IjkIge3Ynavp57ZoVTCUXNJTxALvC/UV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMYaRzx0F4/Cs8eImdBifBHGGSDHLVTUybLZLREpa03qYA5fFR
	zlgGu/vZBlqMcyQYVPtciYWjvzoeP0dEcXw8zHnH4qFU/piJSXMPqbUi
X-Gm-Gg: Acq92OF5bVtd2LdrWyP0OjWxBKdvtaGv+vwLCPywx0uGOX4dPfYL0HIi8jLJC0heltH
	GcAezu0xTdPpHU6t+ee5EU9P3voDJElP5YcmzY0GAOEhx5H8E6s3r8et2qeUhxIIILmsxQVutMO
	WU9iLoT5gx3C7Y1iHUobnRXEevJh43Te9SQJ8rzIAeED04I2WxwImDnjjlNRdbh0LMUEyTdSUQD
	0d2TDFBT4wzNTD4Vy4k+I7i9xtwVGCgGOEiJJus9GZCjTD+T/Cyl1F0eoKFohQInhl5aJAbRJwB
	LRGxNU93PsOxbIU4CZwtMh9jjS9z4Zx1mPizhHZO37MstXdRUbTqrrdW1lUUKJs+GU1AiiUGSLh
	XborIZFbnwU6LbXz4emPQqOFrZEbEYxBYWH5vZSDVTNp2LqnajLz/PUtky9Y6R8it7klaGBqWYf
	dq/cOfYy/98Q/lhuTHoJxe+FrWQmrfw74me5BTVhItdO0o6Z+NK+160orLfISNo8JPahBYIuk5S
	RtLQXvoPg==
X-Received: by 2002:a05:620a:2a08:b0:8b1:2853:673f with SMTP id af79cd13be357-914b48e5aeemr503820085a.15.1779450869229;
        Fri, 22 May 2026 04:54:29 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8cd260sm100834885a.2.2026.05.22.04.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 04:54:28 -0700 (PDT)
Message-ID: <eb748327-6652-4477-82bb-9db9f8388ec0@gmail.com>
Date: Fri, 22 May 2026 07:54:28 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] git-gui: guard set/unset of GIT_DIR and
 GIT_WORK_TREE
To: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-2-mlevedahl@gmail.com>
 <e5a9a410-bf62-4afd-9560-2dea01fe936b@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <e5a9a410-bf62-4afd-9560-2dea01fe936b@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/22/26 4:06 AM, Johannes Sixt wrote:
> Am 20.05.26 um 22:24 schrieb Mark Levedahl:
>> 2.54.0.215.g4fe990ec16
>>
>> ------ 8< ------
>> Subject: [PATCH 2/2] git-gui: operate git commands without GIT_WORK_TREE
>>
>> The manual page of the git command states about the --git-dir option:
>>
>>    Specifying the location of the ".git" directory using this option
>>    (or GIT_DIR environment variable) turns off the repository
>>    discovery [...], and tells Git that you are at the top level of
>>    the working tree.
>>
>> Use this to our advantage:
>>
>> - Set GIT_DIR in the environment to the value that was discovered, so
>>   that the invoked git commands operate on the same repository
>>   database that Git GUI uses even after it changes the working
>>   directory.
>>
>> - After changing the working directory to the top level of the working
>>   tree, ensure that GIT_WORK_TREE is not set, because, as per
>>   documentation, all git invocations from then on will assume that the
>>   current working directory is also the top level working tree.
>>
>> - Remove the now obsolete GIT_WORK_TREE dance when subordinate Gitk or
>>   Git GUI are invoked for a submodule.
>
> 2.54.0.215.g4fe990ec16
>
> ------ 8< ------
> Subject: [PATCH 2/2] git-gui: operate git commands without GIT_WORK_TREE
>
> The manual page of the git command states about the --git-dir option:
>
>    Specifying the location of the ".git" directory using this option
>    (or GIT_DIR environment variable) turns off the repository
>    discovery [...], and tells Git that you are at the top level of
>    the working tree.
>
> Use this to our advantage:
>
> - Set GIT_DIR in the environment to the value that was discovered, so
>   that the invoked git commands operate on the same repository
>   database that Git GUI uses even after it changes the working
>   directory.
>
> - After changing the working directory to the top level of the working
>   tree, ensure that GIT_WORK_TREE is not set, because, as per
>   documentation, all git invocations from then on will assume that the
>   current working directory is also the top level working tree.
>
> - Remove the now obsolete GIT_WORK_TREE dance when subordinate Gitk or
>   Git GUI are invoked for a submodule.
> 2.54.0.215.g4fe990ec16
>
> ------ 8< ------
> Subject: [PATCH 2/2] git-gui: operate git commands without GIT_WORK_TREE
>
> The manual page of the git command states about the --git-dir option:
>
>    Specifying the location of the ".git" directory using this option
>    (or GIT_DIR environment variable) turns off the repository
>    discovery [...], and tells Git that you are at the top level of
>    the working tree.
>
> Use this to our advantage:
>
> - Set GIT_DIR in the environment to the value that was discovered, so
>   that the invoked git commands operate on the same repository
>   database that Git GUI uses even after it changes the working
>   directory.
>
> - After changing the working directory to the top level of the working
>   tree, ensure that GIT_WORK_TREE is not set, because, as per
>   documentation, all git invocations from then on will assume that the
>   current working directory is also the top level working tree.
>
> - Remove the now obsolete GIT_WORK_TREE dance when subordinate Gitk or
>   Git GUI are invoked for a submodule.

The manual page is incomplete: if the repository has set core.worktree=/somehere, that is
the root of the worktree and the current directory is always ignored. git rev-parse will
report /somewhere as the answer to --show-toplevel regardless of current directory, even
if inside the gitdir, and even if GIT_DIR is used.

The user can override with GIT_WORK_TREE, and if so we must keep GIT_WORK_TREE in the
environment if it was set. So, an alternative for deciding when to export is

if core.worktree and GIT_WORK_TREE are both set AND GIT_WORK_TREE != core.worktree
    export GIT_WORK_TREE

If the user set GIT_WORK_TREE empty, git rev-parse will throw an error so we would never
to far enough to try to export that.

Mark


