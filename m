Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC41E495
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796472; cv=none; b=WZCKxNyxiVxbWmw7vlmUlM1iwVCK1ksKTXpNEv/N/aOXReBvtkfsHRIf4ABmrzCW+VwWwhLivqfjai1maRwK7p/jASNmGP7vpw0giK79tVpuHKjf3/hdZcwcwjs6tTTLmPEjEJ8mAl5V+EiN80V5w3C1d0xinAhlouVV8pxeUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796472; c=relaxed/simple;
	bh=+SvggxI3pFtRkW1cXdl88CJ+ihZyDMjQcGalN+kROBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRj2yJ7Bc2QjTmmA1F4yaKJeNp6Xorqey9kf0RIyYWxT51MdItT/9mDW9kGGrkNiDyVWay5SZanfoy3rlYk/OU3g8HrWzkYIssCOJe73agB5t/f5tMGGCxMxcr53c50QdLLDDFZgEubwfvZXGCtVVsxeJc+/8h4P0mexFjlszQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TreFzLLl; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TreFzLLl"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfa7faffa6cso3023182276.0
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717796469; x=1718401269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=REPE9pPHrDDTyyxlDiUlscsuQuyXcg6kB3xPce67f9Q=;
        b=TreFzLLluSDd44wQ329FEhhLp1/XTiz0BB/eSgPPLJjc0eecImal9OHWBcolTngxYW
         sWqv3yM48nQxIfTKriW1Cd1i1aopNiQ69zC6IQ2w1MttuNO2dMT9TLwjuWCcf2L84lbA
         CH8yfRUaLNIqwbPFJMDfT9xRs0AI2q8163a38KLrbaKO+Ow/LyF/I4NDpQ3K4PesMswM
         8fokvKFCLPz/n7VIEF2lIOZCUMakJVAh0H9Peu8BhTXHdmd8v2m6m/ttSmfw7Vr0WmT2
         qEobLylCXIa20JdS+ArdNtPw4UGVIA+O9GXuLRrnY3aWAmoobDdRuB/mJD8k0tKjco5F
         3Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717796469; x=1718401269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REPE9pPHrDDTyyxlDiUlscsuQuyXcg6kB3xPce67f9Q=;
        b=YEnSQgtSX7dE2kYjbmbwl23OFdgTHmKBrJOSgp04NUzwjCu47g5xgp2Ayh/YcCtj/g
         YNbReoagNZqZ145eRvFBq4pKNWxWKEVSIbrbS58by0JvJY/QiGAcESAWMclILTKssCHw
         vsS5zMF3X2xeAXlqMQVLZwDoyzmMcc9FmClNi/gyRNmMlakhGhD4bweLRJCkWwMIUvx5
         +zcgrCK2CsQehvr0xzNKvf3ym9r1b+1mMALDQ5Q0ue5vrrlDBoTYwQA8G/MnVVFfy7xn
         1KGk6vGvlRH5ZfgAdHeWiNkhbdFsuBu8iypuMD5ik5oZWFNUrNqk5gX4M9q8hMMHEuXT
         KjQw==
X-Gm-Message-State: AOJu0Yy07TeJdQKB29AsD0rESnL8ysjoJMU2WzZP8PIBPm1a5ykFLeJi
	nO2CG8Lg68ljgeFI8w12QZ+hPatjyGA8x8x7o9MLJqTyUnFpOcQ7xFF7YWpdShZQ3tHFIN5UKEO
	5kyc=
X-Google-Smtp-Source: AGHT+IFHIiRMf9YvcftXcBYHW5GLOZvzpr0sDXsY2ZFSLfqxYorHVDOd+60Gw90E2dBksOIGyPoizw==
X-Received: by 2002:a25:ec0a:0:b0:dfa:6c3b:ec03 with SMTP id 3f1490d57ef6-dfaf65927f4mr3879604276.5.1717796467876;
        Fri, 07 Jun 2024 14:41:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038aa38e6sm15901381cf.44.2024.06.07.14.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:41:07 -0700 (PDT)
Date: Fri, 7 Jun 2024 17:41:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] commit-graph.c: remove temporary graph layers on exit
Message-ID: <ZmN+crXyZOze122U@nand.local>
References: <cover.1717712358.git.me@ttaylorr.com>
 <25324fea5b7c7f748d7f4e1e40299c0af04006e8.1717712358.git.me@ttaylorr.com>
 <xmqqa5jwg1aj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5jwg1aj.fsf@gitster.g>

On Fri, Jun 07, 2024 at 09:33:56AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > @@ -2133,8 +2132,6 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
> >  		char *final_graph_name;
> >  		int result;
> >
> > -		close(fd);
> > -
> >  		if (!chainf) {
> >  			error(_("unable to open commit-graph chain file"));
> >  			return -1;
> > @@ -2169,7 +2166,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
> >  		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1]);
> >  		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
> >
> > -		result = rename(ctx->graph_name, final_graph_name);
> > +		result = rename_tempfile(&graph_layer, final_graph_name);
>
> Before this rename, after the close(fd) we saw in the previous hunk,
> there is one early error return when we fail to rename the base
> graph file.  Do we need to do anything there, or an unfinished
> tempfile getting removed at the process termination is sufficient
> for cleaning up the mess?

We could explicitly clean it up, but we'll do so implicitly upon exit,
so I think it's fine to leave it as-is.

Thanks,
Taylor
