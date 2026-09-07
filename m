Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8943D51E
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768859; cv=none; b=u2Uxe3X1X2TZTHg7LmUA1W19+lB21/WSZP+LvrxJhjUiPPm5cC2FftiTjgRgJiQCf6/Os9cNTIJ/KaK8ntDilNxbVu/ZaYpY7/C9lmboZGG04x2RemFkRqjuFUhyCxuJHQjq62TT8Krwx638AxpskRY4xRTvT0DlAyF31i7iWrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768859; c=relaxed/simple;
	bh=rWiWwixfpya8qoNh7Lch+TTrUaLhT4QQ3rinqlPhygI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/dv2PaeShRD8pOs9VW31YSfRDvVIxh2Z8g2QFqbPQGV/GQrqeIKLFAU8nUWYt2njzlja90Exdr1Ozr+zhd8P8uf9D0TaQ87RRdCdd04VLsKhJB+L8HMhd8DPFL2mOH/J9K3OxivtlddOemBRkfBnGZfYGK3F59zqdGrHBB81Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aRxjKvT0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xW61vDex; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aRxjKvT0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xW61vDex"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D679DEC024F;
	Mon,  7 Sep 2026 04:14:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 07 Sep 2026 04:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788768856; x=1788855256; bh=G9OmhrsZEY
	6ADAEjWwp5jzJLUBfb/0hbSwdtVkT5H+g=; b=aRxjKvT0uaKMt58m5o9/QNwuAm
	RUiMrZje30PTFnSKq4qHkYUaf2yEOu1Iz7i6OaWgJZHId9TnZikSfnbx/TJlkFyS
	WAGApCa97/SMwLRuybKZhwdtxbc7LRI6wMcIjbCZjGmnIJqbqN89XaDSapAm9y41
	upAFP6Oj2ASJYxVMzd8S+0y5dXG4OMkOps/B8xJLSc9DiMpJF5kOTZiI4isLLOWn
	+3V8pJ0JNQnHeo4mSDa1vOpCrRm0sVnoCbhYHoKUzaoPAlMBCxPoiQzBhSf42Khc
	WaBTo10VWgl4njKKdefk6g44TIBavOQVgCYunxhVTVXoXGQDntCXGqR24XrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788768856; x=1788855256; bh=G9OmhrsZEY6ADAEjWwp5jzJLUBfb/0hbSwd
	tVkT5H+g=; b=xW61vDexgh8WZj0/rh4RG+oem4NiKAm92TUytA3eNoYsr84CCNG
	FO5zc7V6rFs9RmlWgNgyP8AItevShVeA/PKYfPJBNb3RmDMmzRjB08D19YT6wXx5
	xoSinrGna0TYIBdA/AbALVG+Z1m4S/zNOUBSF2qrj0oaaMAM3GVVyJ3RjgzXHays
	ULC0QtO6oqdPY4S0hiT5okTDU6zmCiFh4eCwzrgLGXYx6qG9p2L0IKNaFR05k87K
	rzG0WQYhZwSt1S/zcCGTHGb4u7r2XCQK39JM2OQy6/8R1zwL/NqdwDUMu9CI/ODE
	IR+9GrkuHbMebpzpuwwjrN7E8AX2Tjuugcw==
X-ME-Sender: <xms:WHKeaoo6CBC0wRbQOYREkGBpI6P4Ryaft8x0Kw8dG3rhKRwPcpF8UA>
    <xme:WHKean9YPr-LgfHh0e6P6T-mDbOb2l2AB7ol1cvsOK5gUDx8ICr-XkDhgLOnFPgQs
    2a1HvInIlGK3hYZNyIm0W_gCEGYbJj3lxeTANQzruPMq3-66a0-9Q>
X-ME-Received: <xmr:WHKeakeXl44MfhD9aGbLzq4fqXbdd4UF5_lkvBWrWRvVrRIHUyGgVw>
X-ME-Proxy-Cause: dmFkZTEuDxWEFVPXKjjQlqUlDJ1t8NxWe/2y5zednXE80fnZrtD7msFqXRQTqY3RPW4P/X
    1DrH1hOT6DIqQ0n7novq3egSahQmIOphe/4ZyASFm2WxnOErn0usK9IBgPjEqxgmys7n4U
    J/1WAOVcvBQ70jEhctdPJO7vPz7AhAMvSYojUrJRN/OI8zqk8354KGIvuOWqc3F4EfeoGJ
    WQerx3YObOIx0HYPkMc7h56eZ8btKXkVG7uUz5ymPfeTOMPJ31ZAS0H7gxrAo0N6wEoQ6o
    5/mV8BXvmLkWhadca+2DTtntQtURa1sntdIo/dTdDsb1PFx/FCE6HOC2WNYIRUKIUMKNs1
    bgZ18rvrQBlikCl3ugnJi7TWgtorEuUyp3v/bj1Az7PX5j3/DgnkTh7+v6MDCPuloNsTPA
    Mfoc5jU9O/eZERrAeLq0pwPE1fMOt2nEnQS7nl4mUYT/ZlxQax8o5F882lOYSr+98DJzAJ
    pcD22toYfvBL3Pxllhu05fzYbAyNTYJ5I9LYCjTZzUdM+/6rS3ewfytJLG0fHqVTQRYYXC
    FQJZBknDWo09fwNfBEAeAsE4H3K1sca0RKlPm3tqjC1cJUoN5WbUOyLgE0zYy1uRsUZ7Nl
    bWjJYe5FLXop+8w1eedsErMU9vSge4z94R0i8HNY5QywHgNMSgeHLinDay8g
X-ME-Proxy: <xmx:WHKeahJSGX9eYqu_wXXwmsJkBo3AeyYFVkupwrzilp-huLKqUxKeiw>
    <xmx:WHKeakiUJDCFd4mIONy5YHpd9x_wzOEGe1_DJ_m4BinYMgLeI0Rivg>
    <xmx:WHKeavTW-X3c2tLtcn_-PlUX7oBpCTjUJcoZHIW-dPP3nf3zu55BLA>
    <xmx:WHKeauWZs8ZZYnpU7-yHQp1nsJuA-LFUi8Ejiflc2xXaJY-sSRcQfA>
    <xmx:WHKeaps0CkLP6NF9giJdrw8B3tHxjj4e-_qlsO8Pue0I2t9H9-_Vg9u7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:14:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bfcc4b83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:14:15 +0000 (UTC)
Date: Mon, 7 Sep 2026 10:14:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v2 2/3] sequencer: run auto maintenance once a sequence
 is done
Message-ID: <ap5yVFNEFm2vdP1B@pks.im>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
 <baab8d4876441ea883044c34bb5584631e30e1ec.1788537086.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baab8d4876441ea883044c34bb5584631e30e1ec.1788537086.git.gitgitgadget@gmail.com>

On Fri, Sep 04, 2026 at 03:51:25PM +0000, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> The apply backend of "git rebase" runs "git maintenance run --auto"
> from finish_rebase() once it has applied its patches. The merge
> backend, "git cherry-pick" and "git revert" do not run it when they
> finish. They create their commits in process, and only the "git
> commit" they spawn for an edited message or a resolved conflict, the
> "git merge" a "rebase -r" spawns and an exec command start it, in the
> middle of the sequence.

This paragraph just doesn't parse for me, it's really hard to tell what
it even wants to say.

> Run it where the sequencer finishes, so that every sequence ends the
> way the apply backend does, and so that the next commit can keep it
> out of the commands a sequence spawns.

Besides moving stuff around to prep for the next commit, what does this
change? Like, do we now run the command in cases where we didn't before?
And if so, what are the consequences of doing so?

> diff --git a/sequencer.c b/sequencer.c
> index 65afd100d9..67e1c38762 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5313,6 +5313,12 @@ cleanup_head_ref:
>  			return -1;
>  	}
>  
> +	/*
> +	 * We ignore errors in 'git maintenance run --auto', since the
> +	 * user should see them.
> +	 */
> +	run_auto_maintenance(r, opts->quiet);
> +
>  	/*
>  	 * Sequence of picks finished successfully; cleanup by
>  	 * removing the .git/sequencer directory
> @@ -5577,10 +5583,14 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
>  			res = -1;
>  			goto release_todo_list;
>  		}
> -	} else if (!file_exists(get_todo_path(opts)))
> -		return continue_single_pick(r, opts);
> -	else if ((res = read_populate_todo(r, &todo_list, opts)))
> +	} else if (!file_exists(get_todo_path(opts))) {
> +		res = continue_single_pick(r, opts);
> +		if (!res)
> +			run_auto_maintenance(r, opts->quiet);
> +		return res;
> +	} else if ((res = read_populate_todo(r, &todo_list, opts))) {
>  		goto release_todo_list;
> +	}
>  
>  	if (!is_rebase_i(opts)) {
>  		/* Verify that the conflict has been resolved */
> @@ -5698,6 +5708,8 @@ int sequencer_pick_revisions(struct repository *r,
>  			BUG("unexpected extra commit from walk");
>  
>  		res = single_pick(r, cmit, opts);
> +		if (!res)
> +			run_auto_maintenance(r, opts->quiet);
>  		goto out;
>  	}
>  

It's surprisingly many sites where you add the call to
`run_auto_maintenance()`. My hope was that there is a single exit path
somewhere that is used by both the "apply" and "merge" strategy that we
could adapt to unify when exactly we run auto-maintenance across both
backends.

Patrick
