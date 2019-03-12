Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228B120248
	for <e@80x24.org>; Tue, 12 Mar 2019 23:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfCLXku (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 19:40:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41261 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfCLXku (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 19:40:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id p1so4551276wrs.8
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 16:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GUw660VkKqHjuSn0FflR1YD4jUT+BVsisBPuaR/wViw=;
        b=RKW9aLf7vzmpVZkNlBroWauKZyGZwDgyIKYzJdN/WggYU0tT89HJDM/7pJsqz4WPmb
         hhQ0JhgmUV0ooGIrrKfeMPzGrWohjD9n9gkP95E1mFyarKOnOiHqWMD3SP4pPq+1qNj8
         GHOwd/GA75wdWdmAfEblgAgBSHTzoWISkd+aNGIejVJt5Qvx8ReKT28bv70/JzN6Q9z0
         W9yDMae1GtyLgIpwHS7EnHBBHadYYI9lsglFIZYUkLxDxLxdFT54x0OmL8CyVfV5HkPf
         QSNPmUZeu5YSwIXIU6OP5bjPbXaMEUzGoifhRtAK6Y7NpRGBxOaCzxAYBFK6tNYzU+eC
         BUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GUw660VkKqHjuSn0FflR1YD4jUT+BVsisBPuaR/wViw=;
        b=rypzJTFd5vGSv9ExcuWNF9I1P3FYnrRcVpfkwAjT/6vCw/fiO8T/F6BdWostfKaNTq
         HTUV7MzPi46JiDjokMams+DwA6FVNzx8vaSXeuRNARzUFhSyEzwle0I4UF9blnUG2onS
         v9edhB/9EEvKAy6nBOQkSxotLasU3lz3p6pDEvIkRgjDoPtj8vVQD15EaYCwNrvCxAKj
         ZUWqlY9WjobVp8xN1U8p+48nioLyPl1dQnNHZeEzvj7SIIUWtijXECGZlTDcklL6sKTB
         apTKFN7ZoSF+JmtJH5FBz1PPjdPWQW/Qcq0zy1iSLfVo9WQGnBOzWOToJzZUQs2SrpWG
         mfTg==
X-Gm-Message-State: APjAAAWYiBL9jS8wO3uDo9pt50DT1PoWSg/jqRgfQZRGDib5fYjlkUL/
        CDuxFdltLRYTDVwgbXL0yxA=
X-Google-Smtp-Source: APXvYqz3dmsTrbYaeHSK9GkKUUx+K8kL7KbO+al5Wffm7sWHeQC6GmMQ8sphmSsUIdF4FuzNm0Df1w==
X-Received: by 2002:a5d:640a:: with SMTP id z10mr8194wru.224.1552434047992;
        Tue, 12 Mar 2019 16:40:47 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id t133sm182074wmf.3.2019.03.12.16.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 16:40:47 -0700 (PDT)
Date:   Tue, 12 Mar 2019 23:40:46 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v2] stash: pass pathspec as pointer
Message-ID: <20190312234046.GF16414@hank.intra.tgummerer.com>
References: <20190225231631.30507-1-t.gummerer@gmail.com>
 <20190225231631.30507-19-t.gummerer@gmail.com>
 <20190307191836.GB29221@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903081630040.41@tvgsbejvaqbjf.bet>
 <20190309182610.GD31533@hank.intra.tgummerer.com>
 <xmqqimwqmbba.fsf@gitster-ct.c.googlers.com>
 <xmqqd0mxkgvy.fsf@gitster-ct.c.googlers.com>
 <20190311214244.GB16414@hank.intra.tgummerer.com>
 <20190311221624.GC16414@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1903122323460.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903122323460.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/12, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Mon, 11 Mar 2019, Thomas Gummerer wrote:
> 
> > Passing the pathspec by value is potentially confusing, as the copy is
> > only a shallow copy, so save the overhead of the copy, and pass the
> > pathspec struct as a pointer.
> 
> Not only confusing, but also wasteful ;-)
> 
> > In addition use copy_pathspec to copy the pathspec into
> > rev.prune_data, so the copy is a proper deep copy, and owned by the
> > revision API, as that's what the API expects.
> 
> Good.
> 
> > [...]
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index 2f29d037c8..e0528d4cc8 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -826,11 +826,11 @@ static int store_stash(int argc, const char **argv, const char *prefix)
> >  }
> >  
> >  static void add_pathspecs(struct argv_array *args,
> > -			  struct pathspec ps) {
> > +			  const struct pathspec *ps) {
> 
> I see that you added the `const` keyword. While it does not hurt, I would
> probably not have bothered...

That's fair, I went with what seemed most common in the codebase.
More than half the parameters seem to be using "const struct
pathspec", so that seems to be the more common way if we don't require
the parameter to be modifyable.

$ git grep -F "struct pathspec *" | wc -l
81
$ git grep -F "const struct pathspec *" | wc -l
67


> > [...]
> > @@ -1042,6 +1049,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
> >  	struct index_state istate = { NULL };
> >  
> >  	init_revisions(&rev, NULL);
> > +	copy_pathspec(&rev.prune_data, ps);
> 
> This moved here... because...
> 
> >  
> >  	set_alternate_index_output(stash_index_path.buf);
> >  	if (reset_tree(&info->i_tree, 0, 0)) {
> 
> ... this `if` block could jump to...
> 
> 
> > @@ -1050,7 +1058,6 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
> >  	}
> >  	set_alternate_index_output(NULL);
> >  
> > -	rev.prune_data = ps;
> >  	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
> >  	rev.diffopt.format_callback = add_diff_to_buf;
> >  	rev.diffopt.format_callback_data = &diff_output;
> > @@ -1089,12 +1096,13 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
> 
> ... this point (the `done:` label is *just* one line further up, and this
> is a static diff, so we cannot just increase the context when we need to
> see more, unlike, say, GitHub PRs) and...
> 
> >  	discard_index(&istate);
> >  	UNLEAK(rev);
> >  	object_array_clear(&rev.pending);
> > +	clear_pathspec(&rev.prune_data);
> 
> ... we add this call here.
> 
> However, we would not have needed to move the initialization of
> `rev.prune_data`, I don't think, because `init_revision()` zeros the
> entire struct, including `prune_data`, which would have made
> `clear_pathspec()` safe to call, too.

'clear_pathspec()' doesn't actually check whether the parameter passed
to it is NULL or not before dereferencing it.  The first few lines of
the function are:

	void clear_pathspec(struct pathspec *pathspec)
	{
		int i, j;

		for (i = 0; i < pathspec->nr; i++) {
		[...]

So I think moving the 'copy_pathspec()' earlier is actually required.
It may make sense to make 'clear_pathspec()' safe to call with a NULL
pointer, dunno.

> Both of my comments need no action, and the rest of the patch looks good
> to me.

Thanks for your review!

> Thank you for going through this!
> Dscho
