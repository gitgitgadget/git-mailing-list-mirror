Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D48B61F454
	for <e@80x24.org>; Fri,  8 Nov 2019 16:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfKHQ7e (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 11:59:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36136 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfKHQ7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 11:59:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so7878502wrx.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 08:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9FW2CW2PSB+eXMujlq2a1zbaHsjmewEid2VTSIwG7kg=;
        b=TjqMVUh/AFWcPr5oskAcKtBuFmP1qSYKyrsr0TAwKFHYOsqr2kJg5POopjwUN929Bd
         gTgcUhgvMauXhS1vAPWWoWyHUoGsRPF4v6T74wZxQTNQVlZikQXDgaMcOmiyXixmQ7GJ
         vvFIqz7FZk7nXaC3TpqCDlnpacbKli0VOxA1kfC+h2EgyQ3uyHd2f0WqdDKjuhDXS4w9
         l0aMZNZ5+fHOGIud91tNWB1ICrf0xMccdWodgGJRTxPB43K+3M0x82ezMVl7HVwMYDUy
         O2QG/rbaCjQ5XUSpleaKXvKCDO2ky5vVV+0dl1/rXGvN3UbCLgCDGPhmyrTsqhhaB8u9
         CXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9FW2CW2PSB+eXMujlq2a1zbaHsjmewEid2VTSIwG7kg=;
        b=Zn0SAQDd173k48+nmBMDViXktpnw19hMhHD6iSxTQ5oAX9zwEb4EzAiuIrK/CNBHTQ
         Wr+CMkXxrq2x9SILTFzZ3mSar+dU1SNcH71NNf8oIx/wzFnzFKguKPy4Hip6D64OF7rH
         H31e3TGlXwVLaIMr0QgmfE643M0HjGyOjn1PeX/QVtHO5bY+GaiXtVcWCAQDf2Zgas1y
         UZLvayWXEq4zK+km17w+gORICxZpaMdyz9affHFPjigLO8nYS0h8DUO0/syTAB3pMl4n
         40QjzAtJ7CVd3Fe+juFw2BOdpub0dH+txNumz9Iyj0m11cJF/QOnbBIDfpBQOT2+nS4L
         rsEw==
X-Gm-Message-State: APjAAAU62c4Ns3fz6xzmplpRM+Itxt8Spj/u99gTtr39K2ePUCWs4Lvr
        qfhbtsq1wJFJrT9+Uh743GY=
X-Google-Smtp-Source: APXvYqxGApPylAMbsCNgHxrr4N5xJMY/w8PiYzzjWZWLHuLLMnKAmX6kKbHSrpJGEzkt+gfhvMcLtA==
X-Received: by 2002:a5d:5391:: with SMTP id d17mr10132118wrv.382.1573232371304;
        Fri, 08 Nov 2019 08:59:31 -0800 (PST)
Received: from localhost ([95.149.189.152])
        by smtp.gmail.com with ESMTPSA id w4sm2511556wrs.1.2019.11.08.08.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Nov 2019 08:59:30 -0800 (PST)
Date:   Fri, 8 Nov 2019 16:59:29 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Grzegorz Rajchman <rayman17@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] git stash pop --quiet deletes files in git 2.24.0
Message-ID: <20191108165929.GB3115@cat>
References: <CAMcnqp22tEFva4vYHYLzY83JqDHGzDbDGoUod21Dhtnvv=h_Pg@mail.gmail.com>
 <20191107184912.GA3115@cat>
 <xmqq7e4bp06l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e4bp06l.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/08, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > On 11/07, Grzegorz Rajchman wrote:
> >> Hi, this is the first time I report an issue in git so I hope I'm
> >> doing it right.
> >
> > Thanks for the report.  You are indeed doing this right, and the
> > included reproduction is very helpful.
> >
> > I broke this in 34933d0eff ("stash: make sure to write refreshed
> > cache", 2019-09-11), which wasn't caught by the tests, nor by me as I
> > don't use the --quiet flag normally.
> >
> > Below is a fix for this, but I want to understand the problem a bit
> > better and write some tests before sending a patch.
> 
> OK, thanks for quickly looking into this.
> 
> The commit added two places where refresh_and_write_cache() gets
> called.
> 
> The first one at the very beginning of do_apply_stash() used to be
> refresh_cache() that immediately follows read_cache_preload().  We
> are writing back exactly what we read from the filesystem [*], so
> this should be a no-op from the correctness POV, with benefit of
> having a refreshed cache on disk.
> 
> 	Side note.  This argument assumes that no caller has called
> 	read_cache() before calling us and did its own in-core index
> 	operation.  In such a case, the in-core index is already out
> 	of sync with the on-disk one due to our own operation, and
> 	read_cache() will not overwrite already initilized in-core
> 	index, so we will write out what the original code did not
> 	want to, which would be a bug.
> 
> The second one happens after we do all the 3-way merges to replay
> the change between the base commit and the working tree state
> recorded in the stash, and then adjust the index to the desired
> state:
> 
>  - If we are propagating the change to the index recorded in the
>    stash to the current index, reset_tree() reads the index_tree
>    that has been computed earlier in the function to update the
>    in-core index and the on-disk index.
> 
>  - Otherwise, we compute paths added between the base commit and the
>    working tree state recorded in the stash (i.e. those that were
>    created but not yet commited when the stash was made), go back to
>    the in-core index state we had upon entry to this function
>    (i.e. c_tree), and then add these new paths from the working tree
>    directly to the on-disk index without updating the in-core
>    index.  Notice that this leaves the in-core index stale wrt the
>    on-disk index---but the stale in-core index gets discarded.
> 
> Then the code goes on to do:
> 
>  - under --quiet, refresh_cache() used to be called to silently
>    refresh the in-core index.  34933d0eff made it to also write the
>    in-core index to on-disk index.  OOPS.  The in-core index has
>    been discarded at this point.

Yup, this is certainly my bad, we shouldn't be writing the discarded
index of course.  I don't think what we were doing here before was
correct either though.  The only thing that would be called after this
is 'do_stash_drop()', which only executes external commands.

I think the original intention here was to replace
'git status >/dev/null 2>&1' from the shell script, which as you note
below did refresh the index.

From what you are saying above, and from my testing I think this
refresh is actually unnecessary, and we could just remove it outright.
I'm still trying to think if there could be any way refreshing the
index could be useful (before I introduce another bug here
inadvertently).  If I can't come up with anything I'll send a patch
with the corresponding test case removing the 'refresh_cache()'
completely.

>  - otherwise, "git status" is spawned and directly acted on the
>    on-disk index (this also has a side effect of writing a refreshed
>    on-disk index).
> 
> So, I do not think removing that discard_cache() alone solves the
> breakage exposed by 34933d0eff.  Discarding and re-reading the
> on-disk index there would restore correctness, but then you would
> want to make sure that we are not wasting the overall cost for the
> I/O and refreshing.
> 
> I think the safer immediate short-term fix is to revert the change
> to the quiet codepath and let it only refresh the in-core index.
> 
> > index ab30d1e920..2dd9c9bbcd 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -473,22 +473,20 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
> >  
> >                 if (reset_tree(&c_tree, 0, 1)) {
> >                         strbuf_release(&out);
> >                         return -1;
> >                 }
> >  
> >                 ret = update_index(&out);
> >                 strbuf_release(&out);
> >                 if (ret)
> >                         return -1;
> > -
> > -               discard_cache();
> >         }
> >  
> >         if (quiet) {
> >                 if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
> >                         warning("could not refresh index");
> >         } else {
> >                 struct child_process cp = CHILD_PROCESS_INIT;
