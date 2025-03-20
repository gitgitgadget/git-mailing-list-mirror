Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20083199237
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478446; cv=none; b=Kh1CumYxJ+R4m6aVKW8pmDbMxqAFtS9nWaS5Lbhtl7z5F8hGOo0Xf0DGFQO7Hu17yNArp3KHa544wPujFnKsUJHU9IvHcLOlFKPqiIiC236K7cdXrQ/VXAg6wuOn/9zK6DipPJ/P9vbEcCrSdVsPC94urRhFdaq7eOhkpxX6HoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478446; c=relaxed/simple;
	bh=zCJCHXFzPITdZlS/kowiN6Wqe18Ll4xQrt7teewWagc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3bDL1PwBvcQvZDjmsjkHqT4bNKUA64/K+sdSKq+9hmd0yTY5IHPPMvcZ5scyRaPQZQ9toPQMdTyfhbnOhtZxdF7OTYYATnh4sCNQrY7qQUrAClMvO2XzoP0hui9HF9HEZrb2S06M31uh3Af2CrCb/IZu+TfraP7atEbRX+OCcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cR4R2pPW; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cR4R2pPW"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c2303a56d6so96635385a.3
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742478443; x=1743083243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+53EQnB2GbNq6t55sJD4V3bDqsFcglawGWYKvPoLN44=;
        b=cR4R2pPWe0erUjaJQk6zqcn5nOq7t+KsI08uFGgDYKzBBpY1ED7hODHPWY+OaWF+OU
         GcjakY7/jyHRfc+MjKzS/NxffFvXMpDL26a6cnfl/TU7VWKx/cMsK/NbFG4BsjXjlg8S
         2BjMEYEfFUrI4Os94WdDKAjeVTkobl9nzGeWAkBeqb8OR+MMXpdr6XDsqnd6mNEGFwD8
         sieh1jJeKIj5mVnfltpdzl3QBPZKJnoxTHbqs5vVn2kk10WF3yhXiOfNncvLuvZ7rwS3
         1xYiQf9Di6cbafme5dUDDGksbJhCWd0Sl2YdDjuqm+dM/nZWqp1xosMF3BsOQw/zXB1B
         KGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478443; x=1743083243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+53EQnB2GbNq6t55sJD4V3bDqsFcglawGWYKvPoLN44=;
        b=O0DslsQjpI02BNOj6Kg2FHyfZNBp1pwEhgsasCXkUOYhS6thbKfSIEZDg7ZTzYP/mP
         p0zAMVjmkN6hMGIwkJxYYTsNGHTXQJzYswNoc5PLpZl7n+Zsw68go4bBrt5z4TUg/JhJ
         epNcdduVEkWpNkcVrZT3nLfelKcVe6SQmO0oepZgEdR+yuTeycsX4aMB79kGTWQWH1l9
         hG7zMtzwiuVWwKJtBvzfy2D28tUI2s/5aLlby/I/gdVAmXCIPT0MXJS5jyof1b4wGZuj
         iPrJ1m9li4HxN2uU6qHA6m0JhCDxHsl/ZxA0AH3tO4I3zL+hl1TSWYLcpCqb0UyDNA9y
         NoQQ==
X-Gm-Message-State: AOJu0YxuY0hspTnfITl2544P+E84JfwbVgoLQgh/OjOSOBE7NxWvYz9j
	jxs/0a7HoacfrSf4hbVE7kkIUjYGyhksmEjMu3e2bwfmW9YhEA6x2xl80QLXB6tTaLmYjqeVUX4
	mFIE=
X-Gm-Gg: ASbGnctQv+DSRjJY0IoAulVA4UKaNgnWb99vGTfJ6wKPnB5qyQOQ73C9Y1dN4sUGHt8
	g0+otvg00NVatBhQyZ3MyS0GUbT/VKpaXAPNNZwWqpaKaEKxOsGFy/6qdpKe393ynbrtqh+1D0H
	bA6FnTIHVeKZATYBagzypZBFLc/aa1wwjOwCcG7tLHhz/rdNEwY9oA2qcvrafjsR2hObEZFmTSC
	kg0IYpj87/Ve9NdXpTdbz7QkTMxM/Xvt+T+lwEONYQFf9B0efDPXs6dfOD9DR0dcG2unimd/JPg
	5gU7gtJ+x+EMITaBIxfbaqEA/w1F1V7GETYtTQMpUsDabOtn6n5PIRD+NBxIFVQAMPN6yLyPqFs
	0p6Jpj63oDljrdm8D
X-Google-Smtp-Source: AGHT+IGYYgBma/hUHQiU8L2JjpUQgOqsFoBvDir6A5WEN6KkW7ltcoULmubxhxlemE/Yp5JRsGfgtQ==
X-Received: by 2002:a05:620a:400a:b0:7c0:c469:d651 with SMTP id af79cd13be357-7c5a84dbb39mr907127485a.57.1742478442778;
        Thu, 20 Mar 2025 06:47:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d89b8fsm1006560285a.105.2025.03.20.06.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:47:22 -0700 (PDT)
Date: Thu, 20 Mar 2025 09:47:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: Possible venues for Git Merge 2025
Message-ID: <Z9wcY/55BoMsaEnt@nand.local>
References: <Z9vuiCnKcMRRXHOR@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9vuiCnKcMRRXHOR@pks.im>

On Thu, Mar 20, 2025 at 11:31:36AM +0100, Patrick Steinhardt wrote:
> Hi,
>
> given that this year is the 20th anniversary of the Git project it would
> be great to host another Git Merge so that the wider community can come
> together and celebrate. Taylor and I have been chatting about this
> opportunity a bit to figure out what we're going to do this year.
>
> We have been discussing two different options:
>
>   - Hosting in the US in San Francisco at the GitHub HQ.
>
>   - Hosting in the EU in Amsterdam colocated with the Open Source
>     Summit Europe.

Sorry for the miscommunication on our part! Let me clarify some of the
details around where things are with Git Merge planning:

I have been looking into various option for Git Merge this year to
celebrate the project's 20th anniversary. After exploring a number of
options, GitHub has secured the budget and space availability to host
Git Merge at GitHub HQ in San Francisco over a couple of weekdays in
September!

We haven't finalized exactly what those two days are yet, hence why I
haven't sent an announcement yet to the list. As soon as we finalize
what those dates are, I'll send an announcement with the details
(including the dates ;-)).

Please expect that from me soon, and I am very much looking forward to
seeing as many people in San Francisco to celebrate as can make it!

Thanks,
Taylor
