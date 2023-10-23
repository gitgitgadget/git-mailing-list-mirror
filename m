Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162A18E31
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qnNlIOV7"
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D88EB4
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:34:55 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d0ea3e5b8so25281246d6.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698089694; x=1698694494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nG4s+VkDvSljy1aayXKK60tVixGsHBNMbVotUPvYJM=;
        b=qnNlIOV73U2zsWrqDFHp14l9zzcK4FgWHm9eA+hJdazYEW3aE3beSXlgf686CE83M6
         v9kgpm0xcH6CZVvES91i0t1scufkHohn3JpeeDV2fBrg8HSor9jbjrCXSwb+XFN4xu0O
         O55HgDPHpbZz0KWoMKBPSXfImOS6n3UJI53RfzaPubyYC+yINN2PTAMaYXG3l6EW7d8u
         uehFeGTyAUtuWtU8ogIXfKovfUV8STdf4L0i3H+kKHuQp2lMpJObTPbgBVd57MxkGok/
         nhCHuCzD49QtyerbEk/P3XVxJfpmtK5qobsCi/oNNaLS1jFjK3Sg6snzJQcjeanorFGM
         3Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698089694; x=1698694494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nG4s+VkDvSljy1aayXKK60tVixGsHBNMbVotUPvYJM=;
        b=X1EBSx7oo0hZHJjhFlEJPZLF8wjOglBIV711ZDiVy6+mnMRrFHUC7raRcizZUH8UPf
         /Qc3RvbIQt2Ca/oJEVJ5Sjs7/8z4GEXUJI/4TPs8VOt+8B7hXc9uXp63sVLpAG1aS4Nn
         PNrsT7nZgdRgn3RzN4pSD6ViTWYfrqIhbstakAE7+M7/UX4tXvgpjATwuhUQ8AyR7OZi
         KxSwtbrWKEtfn9gr/k3+hFotsd546l3KPBCRaLiRWvloiWtCAi+e0ldlzbaaf905CP1t
         sTU5IvwuX4J3ndbk/CtkD1XsJ0lszCCAM8J5zz/1mhgYc44PJDXeWpMn4ET4HY2iDmGj
         Rmuw==
X-Gm-Message-State: AOJu0YyTgv/lgem/ggjh5LvZ7JpXXp29uVcqFGYt+hjGfOopYqdHsAyZ
	GrySYmIXhloYdMZpGgAV/UMcsg==
X-Google-Smtp-Source: AGHT+IEgetoYYHFzshvEMQ+r+Ct4zGOzo7hLDRuNW0G0iZ1sWouG2ip12QaRyY+AwXaK0JzZLpEi+Q==
X-Received: by 2002:ad4:5de7:0:b0:66d:2b1b:acfa with SMTP id jn7-20020ad45de7000000b0066d2b1bacfamr13820291qvb.50.1698089694453;
        Mon, 23 Oct 2023 12:34:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w14-20020a0562140b2e00b0066db331b4cdsm1198759qvj.86.2023.10.23.12.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:34:54 -0700 (PDT)
Date: Mon, 23 Oct 2023 15:34:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com
Subject: Re: [PATCH v3 0/5] config-parse: create config parsing library
Message-ID: <ZTbK3QTJYXxYj/M6@nand.local>
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
 <cover.1695330852.git.steadmon@google.com>
 <xmqq34y9jho2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34y9jho2.fsf@gitster.g>

On Tue, Oct 17, 2023 at 10:13:49AM -0700, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
>
> > Open questions:
> > - How do folks feel about the do_event() refactor in patches 2 & 3?
>
> I gave a quick re-read and found that the code after patch 2 made it
> easier to see how config.c::do_event() does its thing (even though
> the patch text of that exact step was somehow a bit hard to follow).
>
> However, the helper added by patch 3, do_event_and_flush(), that
> duplicates exactly what do_event() does, is hard to reason about, at
> least for me.  It returns early without setting .previous_type to
> EOF and the value returned from the helper signals if that is the
> case (the two early return points both return what flush_event()
> gave us), but the only caller of the helper does not even inspect
> the return value, unlike all the callers of do_event(), which also
> looks a bit fishy.

I had similar thoughts while reviewing.

But I am not sure that I agree that this series is moving us in the
right direction necessarily. Or at least I am not convinced that
shipping the intermediate state is worth doing before we have callers
that could drop '#include "config.h"' for just the parser.

This feels like churn that does not yield a tangible pay-off, at least
in the sense that the refactoring and code movement delivers us
something that we can substantively use today.

I dunno.

Thanks,
Taylor
