Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BEE31F6C1
	for <e@80x24.org>; Wed, 17 Aug 2016 06:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbcHQGqV (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 02:46:21 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:35009 "EHLO
	mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbcHQGqU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 02:46:20 -0400
Received: by mail-ua0-f180.google.com with SMTP id n59so158631336uan.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 23:46:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1LiOdtNpyR6ogOM0UfXOPkm/jUWAF6pKBKkQzOYx9xI=;
        b=CFnn1dhpI2Gq4hIP4oETZ5XbRjvbPs+RmkZnPzCFoV1+1XZbJy/0/VV0KtzhLgyAII
         SDMKDdA2haBl0F+rp0bWcpLlQ9Ru5PhQkNzoIeeaTyw7OvJsqVCAV/gUwvKYOityugDM
         b8ehJx+ETfPGt97EvmU4LRC88ww3s0FUOtvpf+GuKWmEWCIeYiv0JBGy525VVfbovy6R
         VrEnZ+/kdTwGDDYzw/HRYXQ2bEXexUMz0/xDwgfPqqBbw9lXnKziQXKPqhorzdZP7sX2
         UNMob70CRNdr5OYSF7v22Z5DFtYyD0hJvXs2X1mEYoqmt3hkXKvJRSal0RN6j8SLtG/L
         Njlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1LiOdtNpyR6ogOM0UfXOPkm/jUWAF6pKBKkQzOYx9xI=;
        b=anHGXkhZmjPzhEq/Oja5Za1ShXEBP/6WDppkO3lb4mXIDc+QPCUkj8FpL/MmPumoTn
         1tf7/N5c0VmedEsnjOV454cnlJv3QZdonaplvkGlG+picFLXwV+Fr8yN/rj4eo5sppxo
         EZhzTMN41FOl5mt9M8P8xusKRQydSxkhE2C3uYJzE15bdcx0ElGeriFZwN5Ew5dmqedV
         l9Xilw/T48SUkoSHOz7DPsv/0w4vxH96L828FynNMnO+7bcgn6aMPThQSYZA4tIqumno
         tw6aiuiOjqtK8O2cRgi8jzP+lcQp2DMdr75SxjGuAUTLBoZAthuLsZhx/I+oBwiXzbq2
         j+pw==
X-Gm-Message-State: AEkooutWAGXpxCBxv347epyZ33eswPTr9hddZBeHkOc8vv4qk9i2/2XA/UkLbZt7LIR/Og==
X-Received: by 10.31.6.202 with SMTP id 193mr13635954vkg.53.1471416379122;
        Tue, 16 Aug 2016 23:46:19 -0700 (PDT)
Received: from gmail.com ([2800:370:4c:3a70::3])
        by smtp.gmail.com with ESMTPSA id 89sm6395040uai.3.2016.08.16.23.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Aug 2016 23:46:18 -0700 (PDT)
Date:	Tue, 16 Aug 2016 23:46:12 -0700
From:	David Aguilar <davvid@gmail.com>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Luis Gutierrez <luisgutz@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
Subject: Re: git-mergetool reverse file ordering
Message-ID: <20160817064612.GA14619@gmail.com>
References: <CAD8hE_yzNZDPkxRy8s4Fy2_dZN5ppWzLM_2xc01C-VAdR1Pj_g@mail.gmail.com>
 <20160814034221.GB21057@gmail.com>
 <20160814103801.tpixnskdsf5ycj66@john.keeping.me.uk>
 <CAD8hE_xR2mB3=_oot9cWxmFy7z4oBhjABNOo3aJKN=bOw5ybzQ@mail.gmail.com>
 <20160817012554.GA12991@gmail.com>
 <18a1ef52-1c5b-4f0a-5da2-777e816a1e3e@kdbg.org>
 <882f5f1d-19a6-7b4b-7c6a-7347981fee72@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <882f5f1d-19a6-7b4b-7c6a-7347981fee72@kdbg.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 17, 2016 at 08:10:46AM +0200, Johannes Sixt wrote:
> Am 17.08.2016 um 08:05 schrieb Johannes Sixt:
> > Am 17.08.2016 um 03:25 schrieb David Aguilar:
> > > Hmm, I do like the idea of reusing the diff orderFile, but a
> > > mechanism for sorting arbitrary inputs based on the orderFile
> > > isn't currently exposed in a way that mergetool could use it.
> > 
> > Instead of using 'git ls-files -u | sed ... | sort -u' you could use
> > 
> >   git diff-files --name-status -O... | sed -ne '/^U/s/^..//p'
> 
> Or even better:
> 
>     git diff-files --name-only --diff-filter=U -O...

Nice!


> > > But, that sort is honestly kinda crude.  It can't implement the
> > > interesting case where we want bar.h to sort before bar.c but
> > > not foo.h.
> > > 

Note: I had a subtle typo above -- I meant to describe this desired
order:
	bar.h
	bar.c
	foo.h
	foo.c

which is not possible with an orderFile that has only:

	*.h
	*.c

But...

> > > If we did the sort option, we could have both.
> > 
> > I don't think that we need a new filter when the diff machinery is
> > capable of re-ordering files. We should enhance the diff machinery instead.
> > 

Reading the code more thoroughly, I fully agree.

Switching to a diff-files invocation lets us reuse the
diff.orderFile machinery and does not require exposing any
additional helpers.

While it would be *nice* if we had a way to sort foo.h before
foo.c and after bar.c, that's just a pie-in-the-sky idea.
Consistency is king.


The only thing that using diff-files doesn't address is the
rerere support in mergetool where it processes the files in
the order specified by "git rerere remaining".  This is why I
initially thought we needed a generic sort-like command.

That code path does not currently do any sorting (which may
explain why we didn't notice it if we were just looking for
"sort" invocations) but maybe that's an edge case that we don't
need to address initially (if at all).

Would it be okay for the rerere code path to not honor the
orderFile?  IMO if we documented the behavior then it would be
acceptable, and perhaps can be improved as a follow-up.

For the basic support the implementation becomes really
simple: switch to using diff-files instead of ls-files.

If we did want consistency in the "git rerere remaining" code
path, would it be acceptable to teach "rerere" about
"-O<orderfile>" so that we could drive it from mergetool?

I only suggest an option, and not config support, because I
would be hesitant to make "rerere remaining" unconditionally
honor the orderFile since that feature is diff-centric, while
"rerere remaining" is a different beast altogether.  Adding a
flag is a middle-ground that would allow mergetool to drive it
while not suddently changing rerere's behavior.


The patches could then be:

1. switch to diff-files, add tests, and document how
   diff.orderFile affects mergetool.

2. Teach mergetool about the "-O<orderFile>" flag so that it can
   override the configuration, and add tests.  It could be
   argued that this should be squashed into (1).

3. (optional) teach "rerere remaining" to honor the
   -O<orderfile> flag and teach mergetool to supply the option.

Sound good?


ciao,
-- 
David
