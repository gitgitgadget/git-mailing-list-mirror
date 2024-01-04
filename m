Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4A2C19A
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="sqPEDSdP"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-594bea92494so431965eaf.2
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 11:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704396030; x=1705000830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4c2572UnUZzes87s9JIZ1+YqtXQ3Itvx6N9NQnsCGk=;
        b=sqPEDSdPhErNoW2sAR5TBHzVfwIvWuPr+VOMzmjSTVlv/yVpc2HHrDnaHJTp8YzR2M
         nkPN6fEGUUxrbGD102GkTnHMiyNCNuMKSm/tqSpioz/v8y3+O9oyU3btao6Dn+4oAt58
         FV40TRpP9vwpTcfY2002aiyIZEz8WRtx+2WThw6aMYkqyyH0WTiuQSntMOQo0ARwaktT
         gGlIubWNU/S9JGPkydL4uC5tOEfyoSAFlhuV4WHtgrIYuVyDky31ODrGejuA8PQAZieb
         BBaE/rjX9eyiJMFRAqF9u96BRE/AhamJtTsTsYP7pjW5MCbDTQKnZCdo1wJoNBFuY0V1
         G0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396030; x=1705000830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4c2572UnUZzes87s9JIZ1+YqtXQ3Itvx6N9NQnsCGk=;
        b=isOKGvpjC28gk0l3uQnLFk06BpRqytEZ7ufTS88mtOmWfxp0e4szR0O9WG+9MBQl3y
         kXAB4+9CcXl7jU8Hbx59X4UMfrF8Py2DauUOCI5hex3S45mHbtpyz/iOF9u1zSyOk0ww
         UXcP05rv84rcK6fCLDxUFCpRytgSgFdvjhNfTREfBB+IuIUJfd7oi4j4orrEflDTYOgk
         y7ptOhwC0Ehh9XmP47iWdH/LBLyWKPXWpey+dST/Nx6Nuo4WjIUfCi6kXwA9I40IJy8Y
         2GlD9U/oAgK+RJJNeO7HIVD2gSyrzLqgHeYEosUxVqG5o4U/GymuHHjboG4Zd1gctr6O
         3FTw==
X-Gm-Message-State: AOJu0Yw9DZFZrH/MfgeN+eQ8ByHiI4Fji6oOE7OlMxYXD3tFK6FtwhaI
	W1ABuZ0X/BKiyM/XcMxGKve1lvPsYsdHexM92tECUfhTXwZbLA==
X-Google-Smtp-Source: AGHT+IFD9yRzId65rOvo7eYV3ax4nFJeYwnsU8QqAuYk2WZGweLg6r4kr8upOVVP3Ju9St3jgObmBA==
X-Received: by 2002:a05:6820:221b:b0:596:eb1:1014 with SMTP id cj27-20020a056820221b00b005960eb11014mr1197913oob.5.1704396029898;
        Thu, 04 Jan 2024 11:20:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ex27-20020a05622a519b00b004282dea946fsm51568qtb.69.2024.01.04.11.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:20:29 -0800 (PST)
Date: Thu, 4 Jan 2024 14:20:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] rebase: clarify --reschedule-failed-exec default
Message-ID: <ZZcE/Kw24YKlqSOT@nand.local>
References: <20240104080631.3666413-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240104080631.3666413-1-illia.bobyr@gmail.com>

On Thu, Jan 04, 2024 at 12:06:31AM -0800, Illia Bobyr wrote:
> Documentation should mention the default behavior.
>
> It is better to explain the persistent nature of the
> --reschedule-failed-exec flag from the user standpoint, rather than from
> the implementation standpoint.

The first paragraph looks good, and I think your wording is an
improvement over what's already there (though of course this is
subjective, and YMMV).

> +Recording this option for the whole rebase is a convenience feature. Otherwise
> +an explicit `--no-reschedule-failed-exec` at the start would be overridden by
> +the presence of a `rebase.rescheduleFailedExec=true` configuration when `git
> +rebase --continue` is invoked. Currently, you can not, pass
> +`--[no-]reschedule-failed-exec` to `git rebase --continue`.

The last sentence was a bit confusing to me. I assume you meant

    Currently, you cannot pass `--[no-]reschedule-failed-exec` [...]

without the comma between "pass" and "`--[no]reschedule-failed-exect`",
and replacing "can not" with "cannot".

Thanks,
Taylor
