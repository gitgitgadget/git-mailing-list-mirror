Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E856B76
	for <git@vger.kernel.org>; Mon,  6 May 2024 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715026914; cv=none; b=A0LiTWY0eV/WaHfoYAUBs5yidljnIjr/hm4HVuf7arjccMvVp/m85kpIGXVPop5dPBdT57nuQcpqF15iAofEuV5WzuoOKEaVRB4vDkIT/cDrXMAkNIFZ37wYSXO1C7Qs0+D25SASTGBWUKsAofY4fBy+hFp91nN4qQvI1ag2a04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715026914; c=relaxed/simple;
	bh=J137pKj0j0TaJk96Qk/RBZDosuy/G+619oaYKIi5Oxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFrm32a9pR9kJqMbP9maEkBfWsuKxyXVYJZvQ7dVUNkT0Xv9Ab/ghQzrghIJv4hiOIpioUONUFropG4kxGxBbgYYKZTQhi6VpST/zm+U1E4L4FQDc1DAxffQ6jbdSoN2jxCLH5iU5HMDMLuRXdpptFD9SvpRhCw+h48PJ1zzI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZEn7KXWr; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZEn7KXWr"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c96fef64b3so630968b6e.3
        for <git@vger.kernel.org>; Mon, 06 May 2024 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715026912; x=1715631712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J137pKj0j0TaJk96Qk/RBZDosuy/G+619oaYKIi5Oxw=;
        b=ZEn7KXWrYif8nh41U8taeYhwaGALfoWM1k8XhwdJzzcVEeaH+F6WrRo+9IrByg9WZ0
         8ytX1bWTuWaVxOOpDqZ7sPnl/blT24gBh4aZAOM4/kNRaNN25h+QWTHK0sGveTqHQEbN
         5SR9BmLFyLAsSNLAvZY6h0GWJimZuou57sCzwEi4+YkL1KyzwrykcLQuK2+yUmMeoSjp
         uCCXbzh7K8GGBSJ2ToHm1plEFhp+POXnTC/IMudzu8aSCcwQfyQwo0R6XFvudNkzzESa
         XzCVmfrByjpvAYNu1YgDsW11vkqRlqc6CFOx1fzHNmLRuUz1nObQK7Wq50Ulm1JdAX3q
         4pfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715026912; x=1715631712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J137pKj0j0TaJk96Qk/RBZDosuy/G+619oaYKIi5Oxw=;
        b=XlfmjvubMcT1KDWCR9ai1GpyryzKYqfa83u2/pMyC5GPd/Uf8SfJJlmyrt1q8eotD4
         Ji8S55uMAbsv6RJtabJ2bwe3LR1686YjGXVFwZ5/uHkTqNbzFx1KEAAqhnAhbgqQ6QOE
         QdrDG1HbCbClUobrwUGkA91sD4MI4SKSvEpl2myXGYOwxJDY4D0yLGXT+YCRnuadosiI
         tM1schkhxLx2ubT6Ssju1XP/cd8HJsMiPLXKlXl9LvSpyvmYcNGs+8SZNkg8Qb/CGNbI
         8Typ20wBEXM1nHkHQnn870RZuwyebRuSzpEOfIFhU7XLASPS3ik1D0T3xfCo0wznxdOK
         Z6yg==
X-Gm-Message-State: AOJu0YzkvHDkTa1sItZIYloqyRMm5/aDsAPhDYmk3/VHKsyqKeN3GbaL
	xmTtn9CLp1G/jnA80HmAAEA1anNJQzvWOJeZuw3LcQbf58/vB46qW4XGJYxU9w0vFwQHgTDAoBw
	O5k0=
X-Google-Smtp-Source: AGHT+IERAcBlYEdqz5vUvIOPYZb+QppdBqjN1JYVOffXCfqcla5U9WHFRaJ7fp++IJQeOnEFcRhJ2Q==
X-Received: by 2002:a05:6808:6145:b0:3c8:2b77:789 with SMTP id dl5-20020a056808614500b003c82b770789mr11611040oib.5.1715026912066;
        Mon, 06 May 2024 13:21:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s13-20020ad4438d000000b006a0e04887edsm4004998qvr.73.2024.05.06.13.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:21:51 -0700 (PDT)
Date: Mon, 6 May 2024 16:21:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: Re: [PATCH v5 00/14] builtin/config: introduce subcommands
Message-ID: <Zjk73l5l6AqQOz6N@nand.local>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>

On Mon, May 06, 2024 at 10:55:51AM +0200, Patrick Steinhardt wrote:
> Hi,
>
> this is the fifth and hopefully last version of my patch sthat
> introduces subcommands into git-config(1).
>
> The only changes compared to v4 are some fixes to commit messages.
> Otherwise I'm not aware of any other feedback that would need to be
> addressed.

Thanks for the new round. I took a close look through the series, and
couldn't see any remaining issues. I appreciate the translation guide
you included in the documentation to indicate "git config --add" is
replaced by things like "git config set --append".

Thanks,
Taylor
