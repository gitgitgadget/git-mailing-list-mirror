Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D541613D8B1
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951622; cv=none; b=PSpAUtRo7cjVnKfYWYI9zE5nu6n9+cTLKeK+d/0+30cEyG6yKTBRCAvn06kzbXVKqTUZuRmaF9FZQPccYeyKygAgyLhX7wEB62RAOkwzURV7TgnESrcFw2ElibxWLqQ1OKZoGZ2aDcFHsrXAH3faKwMsgDYXiMp61I28U1Llvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951622; c=relaxed/simple;
	bh=iGU81/TKRPhasrEYKQRueAQB6Cj+kxIokWMXkzNGxN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKBJ7wB/qAFRihzkCPejQyfg4tdVQDgJVhShd383dksg3Jf5KtCNlXvKbmgSv/UD9UbPnx3gZ+Z840Msru/IRWs3wme2YLQEGPHDXd02je00m0b+wJsAJ2LJ2W1c4d+R/f84VTSBsXSAJf2Tx/nHs50N/4dnDK4gDR2RoG5YEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Sr8pZbwu; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Sr8pZbwu"
Date: Mon, 13 Jul 2026 16:06:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1783951612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YexbE7vFQPX3CmVpk4s9ibLFjz9mQDWX2R5PtbtSp7U=;
	b=Sr8pZbwuClos6eIc+w/SYFfCJCiBojtxusHyO9bT89zamGmyqVzC19OIvuTEEQLWPaZHkr
	oHElprc+oWgnWRRhWOuOZXyX/rkIxSBnxkoIMwUq4hm6EGx1xHIxwNYGwu2GS+p0Rkdjmq
	vCN7RZ6fL6f3QC/KrTaOKFrAZ+25eiAmhrQ2qpteZHgWkOK27bwxIityG1dBX2bWzoJmAX
	XlT2Vl5CWe+kMWqrY4yANHLCddJL/ssO1mBw9/GdX6jytstX3wKuCCb95blpg1tGPDX54I
	WmWuGvDYhMWNUUg1pQVRB9IKskYtmYIW/PC7305krudLspegTtDDdSJMu99WwA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, ayu.chandekar@gmail.com, 
	chandrapratap3519@gmail.com, christian.couder@gmail.com, gitster@pobox.com, 
	jltobler@gmail.com, karthik.188@gmail.com, krka@spotify.com, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v10 7/7] graph: add --[no-]graph-indent and
 log.graphIndent
Message-ID: <alTuevrGiK3bwh31@exploit>
References: <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
 <20260713-ps-pre-commit-indent-v10-7-82ddab26bc96@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-ps-pre-commit-indent-v10-7-82ddab26bc96@gmail.com>
X-Spamd-Bar: -

On Mon, Jul 13, 2026 at 12:44:42PM +0200, Pablo Sabater wrote:
> Some users may prefer to not have graph indentation.
> 
> Add "log.graphIndent" config variable to graph_read_config() to read the
> default preference. By default is graph indentation is true.
> 
> Add --graph-indent and --no-graph-indent options to overwrite the
> default preference.
> 
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  Documentation/config/log.adoc       |  4 +++
>  Documentation/rev-list-options.adoc |  8 ++++++
>  graph.c                             | 10 +++++--
>  revision.c                          |  9 +++++++
>  revision.h                          |  2 ++
>  t/t4218-log-graph-indentation.sh    | 52 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 83 insertions(+), 2 deletions(-)

[snip]

> diff --git a/revision.h b/revision.h
> index 569b3fa1cb..49e1380b80 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -314,6 +314,8 @@ struct rev_info {
>  	/* Display history graph */
>  	struct git_graph *graph;
>  	int graph_max_lanes;
> +	int no_graph_indent;
> +	unsigned int graph_indent_set;

These are both boolean values and could be set to be 1 bit wide.

Other than that LGTM.

Thank you for the changes.
