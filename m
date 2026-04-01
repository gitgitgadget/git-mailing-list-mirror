Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421D33F383
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775071901; cv=none; b=TOFund3brugtJpmeHHXIyoV5cPvRcz2ngIVUXcyAqy8HUkhYk7kWxFOVTyOPs86HeDACT9oAmN1PIBMCBlES4IY3Kz5ITTT8ZmwLZbS/I4nPyE+egTb6pV7Gr5GG5xu1bGLxB6Nv1ld+SaXYwPodEXF7MRLhp9TPbuhJUlIV5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775071901; c=relaxed/simple;
	bh=Q9bMuBWJJSfa69JOOHCBXEn4FzFTrSc4nBBoJSpaYoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWom8LT82Rk40BDA8k86ImkglcIBKpA3HwUtgXCq660CTYr/VJhE66cBYR95FVStv6CMN4LIncjSORLbBR5H1aCf2d26/Yy4EDL9YsJI06qRFp8JvYYShYqPhkzvOVTr+KEKq6fyjTgFygIREG3Uw0GdqMJlmt5a7gfWifZdKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgxczxDL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgxczxDL"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a871daa98fso537175ad.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775071900; x=1775676700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RkisWHyEJXUGMP/hygMss73nte1CkgqjnrBccB7SiVE=;
        b=hgxczxDL8iDs4uk91BmJex/INvoOucFWTi4nTl/EJ9RCqPEkR6NC/0FWOB6DB5Jh6N
         aKMU5nrLzyVWAzTYbRL1YqRkD+J5rTM5e0cxXEe97kvq0fR0EIclDLYQGzcAGEeW2DXN
         /30MAlU5Q2SznNxBq2wGp2rK5nF5fzzv6t8bY6rrBWbZERr5hGk+gthtsHofIKXCTzUe
         K/PNIaNKEvhgmIo3BiB4XR4Yya/tSdofjuF2L/4WJ+5FS0Ib0riCOvWFcLEzKN+H7fux
         aM1QSbiDaRHSGxg0qJrzOMhReZtrd83altRk7deAchRctuolDbI/5P/iJ70AGcPFdzTL
         cqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775071900; x=1775676700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkisWHyEJXUGMP/hygMss73nte1CkgqjnrBccB7SiVE=;
        b=AllcF29wBzJvNefxlHEIh/8rL/I1BWqV4NOOwg2jv8v+bGnEokI0xIpz/PfdWcWI+i
         GpAlFxrrkaaJyIuUp+xmEYDDiJEmFZzsHMhOskdbInCj6HnwRbCfmciBmcfqvwBaYMdn
         X8zZuaSp2BmF034Feo5F3KpoypIThA8hjJhfVV3GUb4FW5ytPKW10xdhNG27bRZ9rNig
         5CbyqSNLKOrhKBsncDyyGeIFUOx4qu8kIk0amcpmQG3PIk+y6u7Z0FexojRWgOn5QOPl
         ZsNsqR2/R9Jmd6TgFatRm/uyXZ/6UdbZpL66omLJgqsWurfJLf2k7BBnPP9+DPa2mMBE
         68dA==
X-Gm-Message-State: AOJu0YwBIUdRtqSPUTDUyg6h0AXoRSMJE0Fpr5VPRG+Gi4OgG1Y1//0c
	YtIrlilE0A+/zz+PA5NI5I6ra4Xg4nkmsnrF7IuPw8WVl+XsSe+iXujE
X-Gm-Gg: ATEYQzzwBJZUh2sYutjETFXUD+tXgrKPINmqEZ+RYHJtlUB8F/7tWuwMyyHv5m0ew37
	/R5xirAIZ8kKf7mvXu7SvJPeTP/aEB5PO3EwVmKBP5CGiLbBOdeSk3g+nlzMNP21l4wzxTQZdgV
	9IuMe25C+HPmlMFZDcKOHbNy8TK3je+q3QXypnHd2uzabnQ1g6LEOCjeoKI9i1XkjmFbXOwsqqc
	/piHvuEPFf+z5Yk0URVJEBefhouvWOG7fWlEeLChQbr73TaYLQKFpZrcku1xSYiPIqoIpdt9I5o
	3DAuA/UIc8TyFDsUowduQEfz4kSxo0AA8wUw2wDlluei/fy11IUFT0GasHFblqr9eMRilsbOxUB
	b3Lkf1aQqrVmYh/VENR1PrQ4mkwxDlRI+bLrKuNbk3FykcctUgnbL1T7nKsSccdHmQ7UmEs05AT
	7er6E91/za8UmlLUxw6r9op6RMST3y1QY=
X-Received: by 2002:a17:902:bd46:b0:2b0:67a7:5c4b with SMTP id d9443c01a7336-2b269c44989mr34637535ad.28.1775071899582;
        Wed, 01 Apr 2026 12:31:39 -0700 (PDT)
Received: from localhost ([42.118.191.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbc58sm5096005ad.78.2026.04.01.12.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:31:38 -0700 (PDT)
Date: Thu, 2 Apr 2026 02:31:34 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSoC PATCH] backfill: auto-detect sparse-checkout from config
Message-ID: <buisigjsw3zrcy6bqaic2zefypq37kimju32eufquppsvkgkvx@cqd3cwj6an6t>
References: <20260331112516.772635-1-vikingtc4@gmail.com>
 <xmqqo6k40wbl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6k40wbl.fsf@gitster.g>

On Tue, Mar 31, 2026 at 09:59:10AM -0700, Junio C Hamano wrote:
> Trieu Huynh <vikingtc4@gmail.com> writes:
> 
> > git backfill currently initializes the `sparse` field in
> > backfill_context to 0. This causes the command to always perform a
> > full backfill by default, even when the repository has sparse-checkout
> > enabled in its configuration (core.sparseCheckout).
> >
> > Because 'sparse' is explicitly set to 0 at initialization, any later
> > logic intended to auto-detect the setting from the repository
> > configuration becomes dead code, as it only triggers if the value
> > is negative (sentinel).
> >
> > Change the initial value of .sparse to -1. This allows the command
> > to correctly fallback to the repository's sparse-checkout settings
> > when the '--sparse' or '--no-sparse' options are not provided on the
> > command line.
> 
> The author of bff45557 (backfill: add --sparse option, 2025-02-03),
> where this .sparse member originates, CC'ed for more intelligent
> input than my review can offer ;-)
> 
> 
> > Add a test case in t5620-backfill.sh to verify that 'git backfill'
> > automatically respects the sparse-checkout configuration without
> > explicit flags.
> >
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> > ---
> >  builtin/backfill.c  |  2 +-
> >  t/t5620-backfill.sh | 15 +++++++++++++++
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/backfill.c b/builtin/backfill.c
> > index 4b2db94173..0f31844ce7 100644
> > --- a/builtin/backfill.c
> > +++ b/builtin/backfill.c
> > @@ -124,7 +124,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
> >  		.repo = repo,
> >  		.current_batch = OID_ARRAY_INIT,
> >  		.min_batch_size = 50000,
> > -		.sparse = 0,
> > +		.sparse = -1,
> >  		.show_progress = -1,
> >  	};
> >  	struct option options[] = {
> 
> I am a bit confused by this change.  What's the difference between
> using -1 (which you picked) and 1 as the initial value for this
> member?  From the proposed log message, I would have expected a new
> code that says "ah, we notice, from this member being -1, that the
> user did not specify --no-sparse or --sparse, so let's figure out if
> our working tree is sparsely checked out ourselves and set it either
> to 0 or to 1", but there is nothing like that in the code.  It seems
> that the updated code relies on the fact that this part of
> do_backfill() only cares if .sparse is zero or not, and ...
> 
> 	if (ctx->sparse) {
> 		CALLOC_ARRAY(info.pl, 1);
> 		if (get_sparse_checkout_patterns(info.pl)) {
> 			path_walk_info_clear(&info);
> 			return error(_("problem loading sparse-checkout"));
> 		}
> 	}
> 
> ... relies on get_sparse_checkout_patterns() not to do any harm when
> the working tree is not sparsely checked out.
> 
> I am not sure if we want to call it "auto-detction".  It looks more
> like "default to --sparse, relying that --sparse is a no-op in a
> non-sparse working tree" at least to me.  Not that it is necessarily
> wrong, and when people do "backfill" knowing that the working tree
> is sparse, I am sympathetic if they prefer to keep the sparseness,
> so such a change of default may be beneficial.
> 
actually, the logic IIUC here is:
- first, ctx.sprase originally is set to 0.
- then, it check user's options. Assume, there is no option passed,
still 0.
- then, it check repo's config (core.sparseCheckout (default to 0 in
enviroment.c) but it doesn't since the guard:
	if (ctx.sparse < 0)
		ctx.sparse = cfg->apply_sparse_checkout;
- evenly. ctx.sparse still 0 eventhough in case the
core.sparseCheckout = 1 (git config core.sparseCheckout true)

IMHO, this change set the default value to -1, then it can fallback to
repo's config value if user has no-op passing (default to 0 (full
backfill if user doesnt intent to config previously either).
> Derrick, what do you think?
> 
> > diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
> > index 91b5115732..a1a8d736db 100755
> > --- a/t/t5620-backfill.sh
> > +++ b/t/t5620-backfill.sh
> > @@ -149,6 +149,21 @@ test_expect_success 'backfill --sparse' '
> >  	test_line_count = 0 missing
> >  '
> >  
> > +test_expect_success 'backfill auto-detects sparse-checkout from config' '
> > +	git clone --sparse --filter=blob:none \
> > +		--single-branch --branch=main \
> > +		"file://$(pwd)/srv.bare" backfill-auto-sparse &&
> > +
> > +	git -C backfill-auto-sparse rev-list --quiet --objects --missing=print HEAD >missing &&
> > +	test_line_count = 44 missing &&
> > +
> > +	GIT_TRACE2_EVENT="$(pwd)/auto-sparse-trace" git \
> > +		-C backfill-auto-sparse backfill &&
> > +
> > +	test_trace2_data promisor fetch_count 4 <auto-sparse-trace &&
> > +	test_trace2_data path-walk paths 5 <auto-sparse-trace
> > +'
> > +
> >  test_expect_success 'backfill --sparse without cone mode (positive)' '
> >  	git clone --no-checkout --filter=blob:none		\
> >  		--single-branch --branch=main 		\
