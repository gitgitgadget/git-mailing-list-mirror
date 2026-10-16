Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D14DAF90
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165878; cv=none; b=AuxdMh/orJmL0zqV4IGrMkcYf1Kx20L/OZ79gwG2y6IfxYpd2zUO6W7Otnr7guJAtQaDG9KsMnz/9SbOZKNvEKi6969Vs2VsXZEQYesI9cPKNB2J5GIk0E2MrFWKp4kgYz2XER64fgAz4+VlKbBcVNLsf/3DZmefkqxWYaPm4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165878; c=relaxed/simple;
	bh=JuxLaPtGJMxPWmN4uGQH9RgMf6+q/20Z7z6FkTWzA6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qjHStXjnDH6603GRVuwe8z2hqibhiohPb0LZlhAXjvYP4wTAMvQWYCchy61YsUQnjfSbvGbZ7l1fqwGkyWYXv8l6RXpuem6fIsTmA6Lyc2ccmT3X2JcdavQGiNdYMrxzMwvLWrtO1iw8+9/H3Og9ywUt2Op6BHMdUhomtxQnpwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L41aj0Fd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=byLFS2OT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L41aj0Fd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="byLFS2OT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4FD821400131
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:51:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 16 Oct 2026 11:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792165876; x=1792252276; bh=V53hHwuTqk
	SZ+N9QhFeqiJsd5yifyHpjkkQ/WPMsEWY=; b=L41aj0FdDoTY9rqbqpyExoqiiP
	bGQ6YN7cZRmMhFq/BaNckKF0ZqLHBCtW83O1UFentkc4aWE+qLkC9uHym9GNG/5F
	9+k3h9/Fcey/gnt3qQn/7GZp/t7kqf/reRMpXkNYZa96mzscD/I0fdLvlcOS/DOV
	lg7ubqUT++co3ZJZxpKgEt/NVTZD/VInCoFOWw9UG4ue+y1doqFjJCiIvq3/X5gY
	nVQBM1moubICB9tpD/0SYykuA5hE5TUSIPt/PMBj5InKdb6i6gC0CanipfPY+jd+
	kuwNmamMgENDQzGn42Jz+djHc4Kkt2Wq0xwQGwOmdu1ySXfenb+00cnw8KqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792165876; x=1792252276; bh=V53hHwuTqkSZ+N9QhFeqiJsd5yifyHpjkkQ
	/WPMsEWY=; b=byLFS2OTs1bd8ta2F6siyDM/xW7VjZaeZD88dkh6175H5SNFURE
	55Hw9hfezGD1kgmCqnO4Lk+f7uWzIjG9UW1gjQkkgQdEmOCuGe84JpQcPiLBX0jG
	XY/dy64AbUNzLr5PWlVleZ/zkeQSIdSIEG2FESaKGSGAcFdwEGURHVkKDoiPF6Gu
	H7WU1Ked+WnKooSlstwpC7ixZQGeccu6EOUDsRLklN88033fCZqGel9CixyGuAzb
	nFK2bD8vN2s5f/r2PPUYleTkO3Tl46tZLJaaIOe+KmrC7+gz+UBpcWrW6yONnUMp
	EsdrOGhm/eXwVMwsW8ZemVomrS/gSg/ioyw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792165876; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:k+unjn40YgZz2IFxU6qkFiIA3fCC+h8J9lGzvC3l0HVSwko
	m3Z5+gWzt77X7G0R6Cv6yGTWBoWDmWwlPAzw12dZcIfEhURqASCL/VFwyRx3GO+o
	G5al/lZY9HnS+6kZwf8DuBSrXkbm/FPAZ4Ck9P4gEuznZpH1LxVUvmmv3MA4yuJl
	488MTnNwdw3GG3oF3FD6Gi2j8E9Xe8YVz5upvHXbuUu1RbMr0LcwliI6ofQXEAxW
	VR3b08cflpcqFqDhbFAmG/Zge5308f8sglIbVCx+A1TgVxSsoVojlwGp8374vjRQ
	I11BRW6mZvtvrgFAWHDjk24QiphmIoxGjC3K1iQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:bX/znUne7Nz/fVa7vJr/jRIwBVwPcnX27i5ObL3V4BU=:JuxLaPtGJMxPWmN4uGQH9RgMf6+q/20Z7z6FkTWzA6k=;
X-ME-Sender: <xms:9EfSalFqEMEWWs-4jkah0hA-RbFfBFaYTNCFSDkbscyDcA3zrlDlDA>
    <xme:9EfSahXLXJe8KOiYwNZigZEjr6Y07zMQfHUYA28T9cGPjlmoaBd2VxQmyOBi4hoWo
    mZKxkwARFRh2fR5y7gsNKuRR9WJl_1o-93xF1Ot8YEg_xnroIN-0VA>
X-ME-Received: <xmr:9EfSasJjPazhF9I6Eaxmv3NJFZFn615Vne21z8sLGgb6iwlek-J9OWomkLh7AfboEAadymGBv1QHue1hzQjwloO5xL6AfW1DwHUi>
X-ME-Proxy-Cause: dmFkZTGcfaZDuf7wKBzmcw7BCuKnmrpnOTwzW/5EyO74noJiVlIEnPIgYCfVH4sLYoRNH6
    8JnK+Pyk5MvmLOG8QwoQs4kkrnXIqDbY/HVimRu/x2tZQwLQCGzdHeikxsGMIgNRGRhNX7
    PcCVmKrwY8uK9VOBVbEvAhkebYyyt0rsMnSHLzsvfv4FAdIB57uj24OpeJnlPDi8WA/cXI
    TLBfdl1jxPIaMvsUBQKQkpygx7gp3XpwwCO0FpuL8IB6res2wNsE/pvx5M3tz6WEv2fIkg
    ER+PBOKZMZ4OBpvUtzQOUY6cD4HRh5fQUAqLuLk1dCiFze0pjuEAR/dtKK7RqicS2wGnQu
    anvJPbHI/9jkgxcfCSB2t3uCbqRnZL3n5N5qF6NwCOoMsy6fq5XQD7mDgJ3zSgoZjnTxkX
    c+UW6n87HQ4eLvUkRWh7h241nApuyATKy+iQ0C+MKPEphmFOS5LVvR4KbiekeJYOWgeBwt
    7Z+hI0YfEVgSczMs6rFwKs6rwyHktm0ahaYAFsGsQ5jW7ook/KwQeIxPkInSHlC/hagNre
    fuAG5F8YsQa1+ty5l4xMsjMTa6VQBqjnnF1zXZ1qHpNCINDoH+tWySAZKaxXWa6tnEQvRR
    /uZS1iS6xLLYtMBVtfPJMfVoXuKmPasNu222T48cXzPdfKCZiLMClkyTMCfA
X-ME-Proxy: <xmx:9EfSap_Tu4kIEJPqBDhDT2Ik4AFKB5UV462Ww_9oEGE0D91CHD-uOw>
    <xmx:9EfSanIq7woYQmB81OwwJBSo3dkxLGNSHTlZcoS7yMj_4GgE04noRA>
    <xmx:9EfSamnMpdPwWGFdKbz2N3j3jh6bRNH8OUr6rV4H7ckVUZfnvqlc5Q>
    <xmx:9EfSajNy9RkgMJhPkYtYRAremFdJ7TrlHtOuW21viGD008r3akLaRA>
    <xmx:9EfSanoQGLOGNCRxwzkooavk-CGa2PzUfcop2cyctZoqJAWXnjMPJ1PA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 11:51:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Raj Ojha via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Raj Ojha <rajojha047@gmail.com>
Subject: Re: [PATCH] describe: use Q_() for pluralization of commit and tag
 counts
In-Reply-To: <pull.2257.git.1792058069306.gitgitgadget@gmail.com> (Raj Ojha
	via GitGitGadget's message of "Thu, 15 Oct 2026 09:54:29 +0000")
References: <pull.2257.git.1792058069306.gitgitgadget@gmail.com>
Date: Fri, 16 Oct 2026 08:51:14 -0700
Message-ID: <xmqqzewdhcel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Raj Ojha via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Raj Ojha <rajojha047@gmail.com>
>
> In `describe_commit()`, debug messages print the number of commits
> traversed and the number of candidate tags found using basic `_()`
> localization format strings:
>
>     _("traversed %lu commits\n")
>     _("found %i tags; gave up search at %s\n")
>
> Because these messages display an integer count of items, using `_()`
> fails to account for languages whose pluralization rules differ from
> English (such as languages with multiple plural forms).
>
> Replace these calls with `Q_()` to allow gettext (`ngettext()`) to choose
> the grammatically appropriate singular or plural string depending on the
> integer count.
>
> Signed-off-by: Raj Ojha <rajojha047@gmail.com>
> ---

Is this convergent evolution or something?  The similarity to
https://lore.kernel.org/git/20261013204351.428800-1-antekborowski11@gmail.com/
is striking.

It's not like anybody who sent a change on a piece of code
automatically owns the area to be improved, but we would love to see
more collaboration and a better use of the lore archive to find
similar effort being made before people send patches.

  https://lore.kernel.org/git/?q=describe+Q_


>     describe: use Q_() for pluralization of commit and tag counts
>     
>     In describe_commit(), debug messages print the number of commits
>     traversed and the number of candidate tags found using basic _()
>     localization format strings:
>     
>     _("traversed %lu commits\n")
>     _("found %i tags; gave up search at %s\n")
>     
>     
>     Because these messages display an integer count of items, using _()
>     fails to account for languages whose pluralization rules differ from
>     English (such as languages with multiple plural forms).
>     
>     Replace these calls with Q_() to allow gettext (ngettext()) to choose
>     the grammatically appropriate singular or plural string depending on the
>     integer count.

You do not want to repeat your log message below the three-dash
line.  It wastes everybody's time.

> diff --git a/builtin/describe.c b/builtin/describe.c
> index c0abc931a5..1a7317c811 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -481,10 +481,16 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
>  				label_width, _(prio_names[t->name->prio]),
>  				t->depth, t->name->path);
>  		}
> -		fprintf(stderr, _("traversed %lu commits\n"), seen_commits);
> +		fprintf(stderr,
> +			Q_("traversed %lu commit\n",
> +			   "traversed %lu commits\n",
> +			   seen_commits),
> +			seen_commits);
>  		if (gave_up_on) {
>  			fprintf(stderr,
> -				_("found %i tags; gave up search at %s\n"),
> +				Q_("found %i tag; gave up search at %s\n",
> +				   "found %i tags; gave up search at %s\n",
> +				   max_candidates),
>  				max_candidates,
>  				oid_to_hex(&gave_up_on->object.oid));
>  		}

Both the log message and patch text look cleanly done.

Thanks.
