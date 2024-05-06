Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D584AECA
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022446; cv=none; b=cGRGZF22/VJhQARqVn46qRVcitfTcAXXZqnMgUT3ikwdT4QaY5UHsEjpOISYar+aPkeOV93WySKlXhC59JR8kSkWhVk5Fp8fOQxbxYAkzFTujX7ZbSMu3pJ/reUspiFf5wCv54N2j1IcqW8EvQYXKIEUn5ZgaaU4O1s0bK4ZvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022446; c=relaxed/simple;
	bh=8jYKxDEowcYu74ePUkHcY9p+T9+YrMHgY4G+TvPmTeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnpdyhXY7Ia3u2Rhy6uJyazyi/J+eAJmH+hlzZxxHhkpNgTSNUVuRYeXbigIXg9XWPBDeoq3R/56+o0qx9CuVTBjPJ6zk1CqNT9PJLZ5oVIkjex0WWhqWUuLQduAqGgg9ReZvjlgEz96Eu5DB1WB5THQtvN36vd/qURPKIIFuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLm+YvSM; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLm+YvSM"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f05c253669so639589a34.2
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715022445; x=1715627245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1huC7Nznci9TNxSTgtHwOj6+ZSft3q13/8rQNpedWA=;
        b=cLm+YvSMujbqU/9fhI5rqCxLALgjZZZagE2KK2/fyZJ08+CztPwn4qU53UuZEvaHCE
         UX14hYQLOKi2wC5Sb0cJmtO0aJ+mTXVpizZodIeYK03XnNwAwRLvrGQVQ0AopF9qNyIs
         sKuuPBuzA23h1EKMMhZTvyYIyTWDX7zaMDvGYakOzvyDjEb+NnR8P2x6hG1lrng+W3xF
         3lF01TrjnJMZ9bq0G3jIJqJMaHOgavbjLrChsbHo3Jm/dDC/A90wBwyhCZXGeMHtRh1w
         JLeoANLhdBSox5Z6TB2Olwk4FjWeNRmmpR6S1ycE452tC3t2N1krap4SjTw21GuBtUbQ
         hNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715022445; x=1715627245;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1huC7Nznci9TNxSTgtHwOj6+ZSft3q13/8rQNpedWA=;
        b=NjsAKFLhsom+fsvpWh05lDQM+iZAF7XY7Ak0SrNV3gJzR1KJR6Y542Qvdr8oDbJpSV
         nNl/YTKHDnrOSP6P3hmodtIp7pu8a2kevJHaG0MwKixDe9wwk8WCFgqIrCJf2+tKObOt
         af5ltxa/8yBo4Rp++EYpgQvcJJjQiHmtnKlk/16+USNbxpCTQKDwvQGnl1m39m2CWcNd
         6ys2QBPXf7MkLIyxzI2OrVzYbl8WFyBCAlTKuJvFQU5/IZZoeisWgLk7QUeGorSEHSEu
         UVLUjFG4THdub05EnalppFftyJ3CDUM39D+GmiCrEY5+cawOqWALNfNyQd1SO3+I/S/5
         PT3A==
X-Gm-Message-State: AOJu0YxXitOOee/0pE8EwQHERB13Fyfibb1tNfNiTfChQY7r2OCG4YOG
	dftneUknjinW2SflJhpqA90oWSc45NoLrf0zhQjjRKvO1tmOzeXc
X-Google-Smtp-Source: AGHT+IFAlav8sODxTrGTKgmti3HcvlW8GfAHzbDQjf9HUheS+fJ0rxd9aOTKZ+ewvT62njXPo73NUQ==
X-Received: by 2002:a05:6830:4b6:b0:6f0:7f8a:af06 with SMTP id l22-20020a05683004b600b006f07f8aaf06mr1708538otd.17.1715022444587;
        Mon, 06 May 2024 12:07:24 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id by5-20020a056830608500b006eee2ad5199sm2087092otb.16.2024.05.06.12.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:07:24 -0700 (PDT)
Date: Mon, 6 May 2024 14:06:04 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jtobler@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ci: fix Python dependency on Ubuntu 24.04
Message-ID: <7t2cqi643tvzjdeq4fddci2dqclgffkavps652cnf2swehx4uo@kng4bm5kvs6y>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Justin Tobler <jtobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cb8cefc20f373a3516695e7cbee975132553ea95.1714973381.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb8cefc20f373a3516695e7cbee975132553ea95.1714973381.git.ps@pks.im>

On 24/05/06 07:35AM, Patrick Steinhardt wrote:
> Newer versions of Ubuntu have dropped Python 2 starting with Ubuntu
> 23.04. By default though, our CI setups will try to use that Python
> version on all Ubuntu-based jobs except for the "linux-gcc" one.
> 
> We didn't notice this issue due to two reasons:
> 
>   - The "ubuntu:latest" tag always points to the latest LTS release.
>     Until a few weeks ago this was Ubuntu 22.04, which still had Python
>     2.
> 
>   - Our Docker-based CI jobs had their own script to install
>     dependencies until 9cdeb34b96 (ci: merge scripts which install
>     dependencies, 2024-04-12), where we didn't even try to install
>     Python at all for many of them.
> 
> Since the CI refactorings have originally been implemented, Ubuntu
> 24.04 was released, and it being an LTS versions means that the "latest"
> tag now points to that Python-2-less version. Consequently, those jobs
> that use "ubuntu:latest" broke.
> 
> Address this by using Python 2 on Ubuntu 20.04, only, whereas we use
> Python 3 on all other Ubuntu jobs. Eventually, we should think about
> dropping support for Python 2 completely.
> 
> Reported-by: Justin Tobler <jtobler@gmail.com>

Not a big deal, but the email is slightly off. Should be:
<jltobler@gmail.com>

Otherwise this patch looks good to me. :)

-Justin 

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
...
