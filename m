Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C453210186
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381281; cv=none; b=q7lswHWtlEatfD3SCpCjYMIWDOUoglRAhnRaN0Osihf0n43nsYbdNPoVAxNIfFpONf6zfVFpbmPDt7UcKuLyLTwT1JOkMeDef7tc3HdzQ09wXlrA6W5lLln+Wu8njRFxsRtbfvaGgAcF13gDvTPojX2zxNQvLZlSvtZBuPCa3FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381281; c=relaxed/simple;
	bh=yyuBqbL0YNFq9DiMHw1rE7QftQYP0JqDN2TqlOyVX1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRiPU/2l6EWAFczCnvko04fxa9VKlb1fBANCzRkFSAk5c6a7KZFCUIjhbcQns9KXa+HxrmaWnUNkRE8rVuEhwrGB5z1528FDOMSFYXqr/ko3cmDWD49js6AzOcK3su5VVRbE6ojDkBBxBkg1diF6911eyOqhfewx9CdRTin/GGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auAs4BCL; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auAs4BCL"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fc0c06e1deso3569213eaf.1
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739381279; x=1739986079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bT7FsO9jIhVIMSqVnO76riYIqPbCVzDT/D51nbl19uo=;
        b=auAs4BCLWECbeMxprCVOA+asQ78cHBXVGWc6tgETGIXGkNjK4/aGSQojeHO0d8bd2X
         nS9HfyBIBmgpEX1dFqgBAhz7pT3RV+8x0W6vhzpTDH0mja/2GILLsUa0+ucVoNLVyuCe
         7v285r4J3kFLA1kCvuE31irsl43/ZCKsOgspzZDe/9QXOqvN8r+wrtvDA2dcBwpVQWQX
         23RWxmf2yMgwvk6zer8q+aPoH2l9nBJ4B+IFREMp5wlQy3Yf9pzWm2DfzBHFDYWjlvup
         YC87OcNNRpAGOCeQTyb8Jg1yAkVFGUOZ6hdBl+87ely1/JrI/T27dzpfj03QrMXP6wQS
         wS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381279; x=1739986079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bT7FsO9jIhVIMSqVnO76riYIqPbCVzDT/D51nbl19uo=;
        b=wjlJAdAK11bRAFicHL5q8ncnfFqLexW0gmKXBja9tAE6ICHa2B13owqUEjX99Pm6Vi
         ZQ7V0WWD6tu28NppgrnUoumOkKpOKnIVaGco/Xv8UG+YKYuYCVzbF5aZMFLV2lVVWteP
         CfDBC99Y/LxWDLfsk9t6mT8rmad4YQpcEHoxDQBiEb6aoBVuqxdN2B7jtpTRz3TQQRFi
         QTg4AuUtj+9ePCxlzkOwtPte1xx7WE7LKeGy+tn2gB3jmERTYD9C4DHZT6ZBUWvbdR82
         DMU0VQFXDYIBMuxdzFFhHNponJWPa4ofY87LnRhBCLLyZaiGOOJMaQQ86TVWYXipKxJV
         /DtQ==
X-Gm-Message-State: AOJu0YyRv0T1EN8ZCgfR5boFOdN3A0Z0ScgmcIjGRNb8yLgUv59mvMNh
	fFfSuEs7ZarHA3i2yiF/x00RAdrmLn3+UmnL6PlNSh5h7rExO8tr
X-Gm-Gg: ASbGncsNDBkxyhDX7BoyziB1JpnFZsffIbNQMEotwxX+W+fWLlUIVqzWTRyAY9EwUSv
	qLvqTud3z3+W8Y87Wt5h4LUOyEWZvUbL0CMN+QmZM7pEClMOUhJZ5oDMlm7wJOVAARZAWEunpO0
	MCkZMYtcpdXOTl6OD3IqETqtp50A9AUtoJ+T9SYteN5z/mk4jIDNzprnJXu7n4ch7fxC4J34gRl
	U0Qwgy105u3hK389qLu52C2ert0ux8YcduzSeoqJudjpacz7GBFA2PE5Do0I6gXYuqpedOz3mf9
	jad1uxc7
X-Google-Smtp-Source: AGHT+IEfbZf+4nuqqvMcgwTV5KqCwDo9m9qVx6TgGFbtSoiRiQcCIqbA/G+B/k4huDDVoHX+9mYFaQ==
X-Received: by 2002:a05:6870:6107:b0:29e:70c7:a3f7 with SMTP id 586e51a60fabf-2b8dac9133dmr2333807fac.4.1739381279351;
        Wed, 12 Feb 2025 09:27:59 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2b8a0bb67fesm2910477fac.39.2025.02.12.09.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:27:59 -0800 (PST)
Date: Wed, 12 Feb 2025 11:24:55 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 1/3] diff: return diff_filepair from diff queue helpers
Message-ID: <3vqcdil4qdam2pcb3mjruuda2kgph3arzhwswnlugtqykmc6zm@7jiwkyqty5lj>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-2-jltobler@gmail.com>
 <Z6xomFk_Sb18UMFo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6xomFk_Sb18UMFo@pks.im>

On 25/02/12 10:23AM, Patrick Steinhardt wrote:
> On Tue, Feb 11, 2025 at 10:18:23PM -0600, Justin Tobler wrote:
> > The `diff_addremove()` and `diff_change()` functions setup and queue
> > diffs, but do not return the `diff_filepair` added to the queue. In a
> > subsequent commit, modifications to `diff_filepair` need to take place
> > in certain cases after being queued.
> > 
> > Split out the queuing operations into `diff_filepair_addremove()` and
> > `diff_filepair_change()` which also return a handle to the queued
> > `diff_filepair`.
> 
> One of the things that puzzled me a bit is that we keep the old-style
> functions, where the only difference is the return value. Wouldn't it
> make more sense to instead adapt these existing functions to reduce the
> amount of duplication?

This is what I considered doing initially. I noticed though that both
`diff_addremove()` and `diff_change()` are stored as callbacks in
`diff_options` as types `add_remove_fn_t` and `change_fn_t`. The diff
options configured for pruning use `file_add_remove()` and
`file_change()` instead. Returning `diff_filepair` doesn't seems to make
much sense in the context of `file_add_remove()` and `file_change()` as
no filepairs ever get queued, so I opted to factor out the logic into
separate functions instead of adapting the function signatures for all.

This may not be the best option, so I can also change it if that is
best.

> At the same time, while we're already at it, do we maybe also want to
> adapt the functions so that they get the `diff_queue` as input instead
> of relying on the global queue? That would make them more generally
> useful and be a step into the right direction regarding libification. If
> so, it would indeed make sense to also rename the function into e.g.
> `diff_queue_addremove()`.

Thanks for the suggestion. I'll adapt the next version accordingly.

-Justin
