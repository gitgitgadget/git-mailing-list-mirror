Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66932657A0
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996286; cv=none; b=CA6nZLrRBTSHrkjkR8Pn7m3nmWKHwYIqkQ0CbjiQVPNjhIRldJZRUpjC2gK7m6vGtTXs1BZUrzjLN0zZSSGZrDKHfFkYjD1Zko7EqHQYa0y/7M921JRYuiFdJkPhUpLug/h1FkN0mBFDBV+UeMkWtTewmtaKSaYMgs7UlLaofjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996286; c=relaxed/simple;
	bh=E+fIYkOvC06v2kROqHfKS7Oeds92cVVNUyRcdfE0ATE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IR2k7Hig98S3NiViUPvd56iQXC2q2OkPIOePIr3pVAmx3pjkI/5xrzWE1aqfzLQisT1M4VUIWjM/z9LkFAeBjp4Ilcku2xgyNISyuht8KES4iT+7N8UCeR4ZlvlAxBgtNIj978fj1v7dvHAqXKPuA9glny3B6WbUHgKgCDxrZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9A2XbyC; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9A2XbyC"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3122b70439so86455066b.3
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 03:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707996282; x=1708601082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phsl0qIZxTO+nM3gi/pDe3F/6k1bd81g1hlRWNLK3nA=;
        b=i9A2XbyC3bfJuJvaGk2NCh7c4xsICKZP9Z3dyKBGrwltw0iHNTwrM4e73q/jA2vSnK
         8dUX9BYK2/ASOXLD7BUmi8aK7sTCun04eta18eXulJaPflEW8o8gAlZ28BmVGkFEhOt8
         is5bzJRt23HwxEyc07IxY3k7bWPLdNSm3cKtPaUETQZ4Pu+GW/WA/G0dCtijQFu1ZdFU
         I5UCP/n1pd8io0U177oOPyy4+xUjDtfOa6bsFWOZAGsamAw43ARFYSXKWxWyrwWbaswn
         hCV5K+Vf1i3RWe6S+wUtdz0YRcm7ylmCBcbY776vPZmnV4nRja8ej3+A29oUAKO+vnyi
         6dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707996282; x=1708601082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phsl0qIZxTO+nM3gi/pDe3F/6k1bd81g1hlRWNLK3nA=;
        b=mnMwSncVI6znnX50EPN5Idjb2i+xdZpRaqyCCxsj/feIPP9ysIbRRMftgKuAgcBtcj
         2VvLd0h2VhtxIB3hT83LmB/E42v4yqEu3+loc8xijzJ9JEGWwrwlDWTy3IuoKV7wqSRj
         1rre1/Yg1AaCSP2OLhqHlGeJLpv67wAMiZY0REsUiBNW8qFEIc5/q+iioOu/Ph2OD5Tu
         NNfX7qoLDeM9Se4GXlz9+khULcLPvZL30W5gUgYr+jJH2z+zKF0Ka/b2qwpdqTNcWuLZ
         6ZeZuyYjm6UWdhUNvqCJ7oMLgxgU5Je9S4XQa+hfxaz/84AjbfpL8LEsM2Eeku6Rjbpb
         QR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6IUeLd8kx3xecMXtn7DmgrH8JTkFiGr0RfQISOOx46kShLSOa8OUxSD7U2PhzZ9FRw4F5Gz/TdmhDga2vDluyILNy
X-Gm-Message-State: AOJu0YzRagKucQOB2n8A4nXIDAMefQ0aXbbZTKZppgmXHFIsqb4CwEYQ
	/xUzw2YYIGvm0II7Ygt6Z/kNa3vGK+9lhCEfQ4bTMAfH/Z+qhUqj
X-Google-Smtp-Source: AGHT+IE/UMe8sz53sDj/M0x4kqwX8ZQ5d/tXuOpKN4fqCr99IPLUigCYxueVQSXCo05oocTRmeOQJA==
X-Received: by 2002:a17:906:1c8d:b0:a3d:63ba:2b76 with SMTP id g13-20020a1709061c8d00b00a3d63ba2b76mr1123307ejh.33.1707996282195;
        Thu, 15 Feb 2024 03:24:42 -0800 (PST)
Received: from [192.168.3.191] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id sn24-20020a170906629800b00a3db46018a4sm7604ejc.71.2024.02.15.03.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 03:24:41 -0800 (PST)
Message-ID: <3e3d733f-d7d7-4dee-9ee9-d52ea215b36f@gmail.com>
Date: Thu, 15 Feb 2024 12:24:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] fsmonitor: determine if filesystem is local or remote
Content-Language: fr
To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24gWyBd?= <avarab@gmail.com>,
 "Glen Choo [ ]" <chooglen@google.com>,
 "Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
 "Taylor Blau [ ]" <me@ttaylorr.com>, marzi <m.ispare63@gmail.com>,
 Eric DeCosta <edecosta@mathworks.com>
References: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
 <d26de10866662a5bcd16d562cd1063dedd21cf02.1707992978.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
In-Reply-To: <d26de10866662a5bcd16d562cd1063dedd21cf02.1707992978.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Le 15/02/2024 à 11:29, Eric DeCosta via GitGitGadget a écrit :
> From: Eric DeCosta <edecosta@mathworks.com>
> 
> Compare the given path to the mounted filesystems. Find the mount that is
> the longest prefix of the path (if any) and determine if that mount is on a
> local or remote filesystem.
> 
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>   Makefile                                |   4 +
>   compat/fsmonitor/fsm-path-utils-linux.c | 195 ++++++++++++++++++++++++
>   compat/fsmonitor/fsm-path-utils-linux.h |  91 +++++++++++
>   config.mak.uname                        |  11 ++
>   4 files changed, 301 insertions(+)
>   create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
>   create mode 100644 compat/fsmonitor/fsm-path-utils-linux.h
> 
> diff --git a/Makefile b/Makefile
> index 78e874099d9..0f36a0fd83a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2088,6 +2088,10 @@ ifdef HAVE_CLOCK_GETTIME
>   	BASIC_CFLAGS += -DHAVE_CLOCK_GETTIME
>   endif
>   
> +ifdef HAVE_LINUX_MAGIC_H
> +	BASIC_CFLAGS += -DHAVE_LINUX_MAGIC_H
> +endif
> +
>   ifdef HAVE_CLOCK_MONOTONIC
>   	BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
>   endif
> diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
> new file mode 100644
> index 00000000000..c21d1349532
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-path-utils-linux.c
> @@ -0,0 +1,195 @@
> +#include "git-compat-util.h"
> +#include "abspath.h"
> +#include "fsmonitor.h"
> +#include "fsmonitor-path-utils.h"
> +#include "fsm-path-utils-linux.h"
> +#include <errno.h>
> +#include <mntent.h>
> +#include <sys/mount.h>
> +#include <sys/vfs.h>
> +#include <sys/statvfs.h>
> +
> +static int is_remote_fs(const char *path)
> +{
> +	struct statfs fs;
> +
> +	if (statfs(path, &fs))
> +		return error_errno(_("statfs('%s') failed"), path);

For the sake of simplifying of the work of translators, would it be wise 
to change this to

+	if (statfs(path, &fs))
+		/* TRANSLATORS: %s('%s') is a libc function call */
+		return error_errno(_("%s('%s') failed"), "statfs", +				path);

and generalize this to all other messages?

Thanks,

JN

