Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30DBA1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeBEUX3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:23:29 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39655 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeBEUX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:23:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id b21so18436wme.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xNXDTPFFE5vXmTW80m3N6kLMuVSAgDCY2o9p1vbElhU=;
        b=RZkke66Ip2OYTx45wsgVwfCnu1hW6IqyIMei4PKVF06jKc+vnV9OQ6psXrVI+vKAK6
         OejcVlN0LVv+BRI/Q3mbiEurFNFNwJrGQLr7bs7ko7b1mJ0X0qBIU+IOeqtMIHiZOfTV
         JW3bXd34//1dBXzDizXsoAwUK5qXJ/YDHBQuysm80ysbRgoM1DWGi6Vx72OEzpfiKZJx
         mBLfuDxvTGDpc5CeOExVKtgRiEEb9I4KBVW48ADG35dTUvYo2LR7UJr6nnC6stsghqFD
         8ioC3Pe/eime6aKbUV5ioxBPNR1gouetBKJWAixl9KoJtOqBw2Rj0Evxt4fb7HGXFzrM
         LajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNXDTPFFE5vXmTW80m3N6kLMuVSAgDCY2o9p1vbElhU=;
        b=idRJK6at4rOQA+N4+vZitK72mVQS7PxDh8QtTEs+kV0PGezhJk58g6s0AWEhB7dnSG
         rDjqMdX3f4ti2PSq8SQv8zmuTApd9x7qI/iwJC3K2H5xnCc90Wvf60vuq2+p9GuPfS5C
         vh3iklTa+9fLEcCCnv70UKoSdYRFfKpb6RKYa/QKL0/ppxU0NOxGomz3x/p6LMjg05nF
         E6fQRqerEgGbhTW/dSKaB6bhmyjAcieQny/yjRmelG+1fziaDenl30hqe2+VL/LQRQfl
         zhoCnkVHz0oq7bZYWrphJEqJYP01QLxC6R25svK6Zvvnpdukesf5DK0zlItm+vmH7qlr
         0jiw==
X-Gm-Message-State: APf1xPBEGDpeezuJjLbNaL1AEqgf7Ro8G+K7XWBA4HuNoOjIKfqj6ItZ
        Ayyy+ZgFeJnHkrq1rPPabKU=
X-Google-Smtp-Source: AH8x224OtjH2m7sDAUmzUE96x3CErMPPMY4GxhxQVzmnISUNvbhGYLtAMWFFHm1A0Z9wNsGkiLGX4A==
X-Received: by 10.28.168.3 with SMTP id r3mr11871wme.92.1517862207011;
        Mon, 05 Feb 2018 12:23:27 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id a6sm13296263wri.10.2018.02.05.12.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 12:23:26 -0800 (PST)
Date:   Mon, 5 Feb 2018 20:23:32 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] worktree: teach "add" to check out existing
 branches
Message-ID: <20180205202332.GE2130@hank>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
 <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180204221305.28300-4-t.gummerer@gmail.com>
 <20180205021833.GB17847@duynguyen.dek-tpc.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205021833.GB17847@duynguyen.dek-tpc.internal>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/05, Duy Nguyen wrote:
> On Sun, Feb 04, 2018 at 10:13:05PM +0000, Thomas Gummerer wrote:
> > -	if (opts->new_branch)
> > +	if (opts->checkout_existing_branch)
> > +		fprintf(stderr, _(", checking out existing branch '%s'"),
> > +			refname);
> > +	else if (opts->new_branch)
> >  		fprintf(stderr, _(", creating new branch '%s'"), opts->new_branch);
> 
> I wonder if "creating branch" and "checkout out branch" are enough.

I thought printing the branch name might be a good idea just to show
more clearly what the dwim did.  Especially if we ever introduce new
heuristics, for example to cater for the case you mentioned in an
earlier email [1], I thought it might be helpful to also print the
branch name.  Especially because it makes it clear that the dwim the
reporter of the github issue hoped for didn't kick in at this point.

That said, I don't really think the branchname is of much use for my
usage of 'git worktree add', so I may be overestimating the need for
it.  I'm happy to remove it if that's preferred.

[1]: <CACsJy8D9LS7e=cVE3Fq2qOnxK5++nFg2vjuhkNtRO-Bx0X1j6w@mail.gmail.com>

> > @@ -423,14 +427,25 @@ static int add(int ac, const char **av, const char *prefix)
> >  	if (ac < 2 && !opts.new_branch && !opts.detach) {
> >  		int n;
> >  		const char *s = worktree_basename(path, &n);
> > -		opts.new_branch = xstrndup(s, n);
> > -		if (guess_remote) {
> > -			struct object_id oid;
> > -			const char *remote =
> > -				unique_tracking_name(opts.new_branch, &oid);
> > -			if (remote)
> > -				branch = remote;
> > +		const char *branchname = xstrndup(s, n);
> > +		struct strbuf ref = STRBUF_INIT;
> > +
> > +		if (!strbuf_check_branch_ref(&ref, branchname) &&
> > +		    ref_exists(ref.buf)) {
> > +			branch = branchname;
> > +			opts.checkout_existing_branch = 1;
> > +			UNLEAK(branch);
> > +		} else {
> > +			opts.new_branch = branchname;
> > +			if (guess_remote) {
> > +				struct object_id oid;
> > +				const char *remote =
> > +					unique_tracking_name(opts.new_branch, &oid);
> 
> Deep indentation may be a sign that it's time to move all this code to
> a separate function, maybe dwim_branch() or something.

Makes sense, I'll factor it out.  Thanks!

> > +				if (remote)
> > +					branch = remote;
> > +			}
> >  		}
> > +		strbuf_release(&ref);
> >  	}
> >  
> >  	if (ac == 2 && !opts.new_branch && !opts.detach) {
