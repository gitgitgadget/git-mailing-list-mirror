Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE541C70
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126848; cv=none; b=JM/rWMlJKP24NVHHFpqLR/MzA3Um4aHMiVguvPMW/+H+f1k2b+rji84Nyq1WrcTKo8NlWYN9/GdtH3nGFnvSxhluRP1tEOppMSBLMT/DdyNJOjo+sbCiISGxbUwoP6R+w1vxtWPGSHwh774MlSUY+SHr4Ik4lac3GdsWW5Mgo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126848; c=relaxed/simple;
	bh=FDK/nJIr3B8Msq4it7hBhT7Vofp5idn7xzgS/lxptN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GPpq8yAmb87h8cWuoQM8bL263hN+wAXZKC8Fc4LJArX1pW4ZKEN+8L2QtDYGChSeK5vTr3P1f+wEy0TTct9ws8vT2+ny8ycfsB5B6rZatZ6wJ9orar7PQ9ly1bLZpbvPq8EMk6MvrGxygp6fqgmVhIFDq4syhbX31pCF+2A0FQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByzYO6Oa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByzYO6Oa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4147d09eb8aso5001085e9.1
        for <git@vger.kernel.org>; Fri, 22 Mar 2024 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126845; x=1711731645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBkCLDLSeSDBCIEJ28KH+2sOzZlvAwB6zfgPPfsrXtA=;
        b=ByzYO6OajtnYYiFYjB7XjFNRnc8b/6HWrcALe/UM5+moBGuIQwjFaJjuyZXJBMkdu9
         WJ5aXAzCuUM1feoW/ZUUY0LiuoPlI6YUfSVsGV+LWAeP6qqKQN31CXHgsgx6R9V0Hv1j
         tGy0VEsRSCwC8A4DtDPqirLwubZ4WXGwjLGtPXP7uK3TrMzw+vTe+CSVWfLjMGVR0gQx
         XIgK+OHYgGBPjAp/PyCmwn25qNgpxFrhPiBHiU4BUGjYoAiDsizy9ddjGvLaXmMHyHR+
         G5o4Ou/PhdjHBqL+5KSDHtgI4o1ZdZ4gdVgsBnVchzUcX2XOgS0fLablVJfOrhkZB3qh
         cJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126845; x=1711731645;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBkCLDLSeSDBCIEJ28KH+2sOzZlvAwB6zfgPPfsrXtA=;
        b=kPBD72x8GhLDcez5jbV1h5hkGAhEcWvzwgnQLsd5VpfIJ0TiplmXSkatON52WmuKQA
         2bgrn7VVkAJiK9rd6rCl5N7yim8X8jxaaWvUS/vUhu5cRDyxDQ2Trqsnb+uc0vXfpzTE
         RlUrctERHWN54mXNwDEgn9aATiOTePP/ufs9iE15In1MxbWLIkv3IrnT3H2Om4RFNQ8p
         hsz0pugH7tNXKYS0yynt6a0/3LLmZKLNwq0IMdb4PP5NvoBMHXez5Dn+b/I/E4pWP4HV
         FJv6jdTmXQgk+yqw9oyJp6hVn0qIRx8RoTNrsLr+1Byf0ET6KjmyKksJnDttxJUvC+bJ
         D7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCX3xE/T1ttCt7bE4WJaWgOtuANuoYYPErScI4SEyatUa9gaNphtceLLPzRzz1ULOyRUx6zeiLcicP0y/bDhIRDvvJCe
X-Gm-Message-State: AOJu0YzOi7/4w0uzSW3T3vX/3A/ZXtp++T3J/gVLkx/zZUuGL1zMvO/r
	uCyK//9SzeXESAN+tiS8fLGu9gGOGukVDx4os0LtNk7WswlScKw3hmLQZ880
X-Google-Smtp-Source: AGHT+IF2eSrfELq6bfElTRsoSURmzBxEzvZK4EBJcxdMTeS3G6C6eyATlqetfqjB5UPPHFWEmkYtuw==
X-Received: by 2002:a05:600c:1c26:b0:414:c64:f3d0 with SMTP id j38-20020a05600c1c2600b004140c64f3d0mr1854466wms.27.1711126844977;
        Fri, 22 Mar 2024 10:00:44 -0700 (PDT)
Received: from gmail.com (181.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.181])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c0a0f00b004146b00cd9csm51322wmp.11.2024.03.22.10.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 10:00:44 -0700 (PDT)
Message-ID: <0ad0371c-c6ac-4ccb-b9a8-b30715f74308@gmail.com>
Date: Fri, 22 Mar 2024 18:00:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Worktree shares a common remote with main checkout
Content-Language: en-US
To: Bill Wallace <wayfarer3130@gmail.com>, git@vger.kernel.org
References: <CA+2m0i8E5Qnj520LXitoE49U_8V17v_NUnrqcRfzHz0cA_ONSQ@mail.gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <CA+2m0i8E5Qnj520LXitoE49U_8V17v_NUnrqcRfzHz0cA_ONSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Mar 22, 2024 at 10:50:30AM -0400, Bill Wallace wrote:
> This issue is just to fix an easy to make mistake when working with
> multiple remote origins and worktrees, where it is too easy to push to
> the wrong remote origin because one can't set the default origin on a
> per-worktree basis.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> Used
> * git worktree to create a worktree
> * git remote add to add a custom repository
> * git commit/push to try to push changes
> 
> What did you expect to happen? (Expected behavior)
> Expected to have the git push recommend a remote origin that matched
> the worktree, but it defaults to 'origin' all
> the time, which means I need to checkout a clean clone from the
> specific origin I'm making changes for so that I don't accidentally
> push to the default origin.

Interesting.

Can you please describe in a little more detail the new behavior?

It may be obvious, but not to me, but what should we say in these cases:

  - 'git [-C <custom_worktree>] status'
  - 'git [-C <main-worktree>] status'
  - 'git [-C <custom_worktree>] branch --list -v -v'
  - 'git [-C <main_worktree> branch] --list -v -v'
  - ...

I'm sure there are others that I'm missing.  If you could explore and
describe them, perhaps with sketches, it would be a great help.

Thanks.

> What happened instead? (Actual behavior)

> Suggests 'origin' as the default origin - which is CORRECT for the
> main git branch, but I want to use worktrees to allow working against
> several remote origins, with the default being determined by which
> worktree I'm in.
> 
> What's different between what you expected and what actually happened?

> Suggested 'origin' for the --set-default rather than allowing me to
> define the origin I want, for example 'wayfarer' as teh name of my own
> remote that I have cloned on github.  The default origin is still
> supposed to be 'origin' for pulls/naming, but when I push, it needs to
> recommend the matching origin.
> 
> Anything else you want to add:
> This is a bit of feature request, but the reason I'm listing it as a
> bug is it makes it very easy to make a mistake by pushing to the wrong
> origin for a new branch.
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.31.1.windows.1
> cpu: x86_64
> built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 22631
> compiler info: gnuc: 10.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
> 
> 
> [Enabled Hooks]
