Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C345D1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 23:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKOX2O (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 18:28:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44517 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfKOX2N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 18:28:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so7360613pfn.11
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 15:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3WWihGE0RbB9T/ZryiwuQlCP8xaXri4cgk4sPxJJMic=;
        b=OKivnVNS0h0+VB7Oml24wI6/2A/ksv8/0Ht40Yotxq0/7XwoGBCAi8zqORypPVk05N
         D0PiZ5tjCQVSU5Q6sTIxWUGGvfSEGYxifzuoSCHl8guxklhNVOl9tR7kI2qzVuHwqpTS
         OCkbSiZw6V7ZhWu0W0DC5oBYANEfaJbDFmvIBze8dRg2pLnBh7IXMsEvr79PLGipsOSs
         hd74Od61N8w9cS44eNcwYSq7ztUOwKi5eqKaNSZCCBck3SrKftuCvKIWCQ5bmKHmP++T
         Ef2ERJFvtzcQkTiLR87Sy3pFlGfKX39zOeMFMeBFUp+tv6B9UX/4+AQdrIpQ21j5zk6r
         9Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3WWihGE0RbB9T/ZryiwuQlCP8xaXri4cgk4sPxJJMic=;
        b=ERVW9+2COg8Ntci0ONKEk8oidrhtiJrdr7TAR8j080a/YM4pNybKvRGPFezsTtU5vq
         70akD7Le+jf5FZumxnu58wlbwNuUl6JCo3roq03EUAf6mSLiOQWJpcfeuuWSSSRluvtt
         btiMgEFrqxY5f7GrskgRNwDCgIjovtng+1Ba5GRnoci4bV0DTsCTNK3qTFfPk6TS970C
         eN2IHVjF30ZuqbBIStt+w++VRVx+FWnoD9rGMslP+0lwYl9M8oT+187nlW5kke9ROEHw
         TWe71lx+ugsVJr6e7zsF+rSXoAqHu31WnfyfvIFuIBdMx3fxuQvcj3OBsI4rZsB+BqGM
         FMew==
X-Gm-Message-State: APjAAAW0qGQYB3bWEg8zwn8rizb4MTbsYOIJdP4yW0cTWDFwN+XsETGL
        ijsOjFg6Yy7/ThBtdObgzwOcOkgpkJg=
X-Google-Smtp-Source: APXvYqy5sbKa8/pHvgUkQGoJL/+nMPneTxSH8L3DdkaC5ya9MjhU4D/7HSr4nYrmM1Lm36hJqfSP4A==
X-Received: by 2002:a62:545:: with SMTP id 66mr20047082pff.1.1573860490759;
        Fri, 15 Nov 2019 15:28:10 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id z7sm13438974pfr.165.2019.11.15.15.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 15:28:10 -0800 (PST)
Date:   Fri, 15 Nov 2019 15:28:05 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly <heba.waly@gmail.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 15/20] parse-options: move doc to parse-options.h
Message-ID: <20191115232805.GF22855@google.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
 <3d1e7e72efca06d18606b6f9dd8c3b6771dfde06.1573034387.git.gitgitgadget@gmail.com>
 <xmqqh83bi10h.fsf@gitster-ct.c.googlers.com>
 <CACg5j27=t_tC4AqNz6tSdsgbDKECq1p+OwS=ydak7d94q2PHZg@mail.gmail.com>
 <xmqqblthfxho.fsf@gitster-ct.c.googlers.com>
 <CACg5j25ZO3+=EHYm5-Yp_LKEQA00EH=FAhOeP_TqHw8anCUDEg@mail.gmail.com>
 <xmqqv9rl5q0w.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9rl5q0w.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 08:37:35PM +0900, Junio C Hamano wrote:
> Heba Waly <heba.waly@gmail.com> writes:
> 
> >> Note that the quality of the latter is quite uneven.  The one I
> >> noticed perhaps is exceptionally well-structured (even if some of
> >> the details of its contents may have gotten stale) ...
> > ...
> > Back to the main issue you raised in the beginning: lets look at two
> > different scenarios before and after moving the docs, the first
> > scenario is the one you've been through trying to look for
> > PARSE_OPT_STOP_AT_NON_OPTION, luckily you found it in
> > Documentation/technical/api-parse-options.txt and the doc was pretty
> > useful for you. But if you were looking for PARSE_OPT_ONE_SHOT
> > instead, which is not documented in the doc file, you'd have ended up
> > in parse-options.h with no documentation, even searching for the enum
> > parse_opt_flags itself won't lead to anything useful I assume.
> 
> That is a longwinded way to say that the Doc version is outdated.  I
> am *not* advocating to keep it up-to-date just like the header (I've
> given up on that), but if it were kept fresh, then those who looked
> for ONE_SHOT would have the same ease to learn where in the larger
> picture it fits, like I did with STOP_AT_NON_OPTION.
> 
> It is not like "In the header file, it is likely that we can keep
> these up to date more easily.  A dedicated file in Documentation/
> hiearchy may be able to offer you a much better structure, but may
> not describe the option at all.  Which one do you want?"  At least,
> it should not have to be.  That is what I meant when I responded to
> your earlier
> 
> > So my proposal for this matter is to investigate the possibility of
> > using a doc generators that'd extract the documentations from the code
> > to a single doc file per library.
> 
> Extracting is just the necessary first step.  It would probably need
> to let us leave notes (in the header file used as the source of the
> documentation) to reorder things for ease of reading through.

I think doc generation from headers is a reasonable goal, although a
much larger one than "get rid of the worst offenders in
Documentation/technical".

> 
> > last version of this patch, if we're trying to look for either
> > PARSE_OPT_STOP_AT_NON_OPTION or PARSE_OPT_ONE_SHOT, we'll find that
> > it's a member of parse_opt_flags, searching for the enum will lead us
> > to ....
> 
> ... which is what I found to be a frustrating experience of being
> forced to jump around to hunt for the necessary pieces of info
> sprinkled in the header file to form the overall picture, that a
> simple flat-file text document would have much easily given me
> (i.e. go back to my original post).

For what it's worth, I tend to agree that api-parse-options.txt is a
particularly well-structured documentation page. I like that one and
refer to it often.

Having read this back and forth, my own take is something like this:

 - Like Junio said, the quality of the the contents of
   Documentation/technical/ ranges from useless to excellent.
 - It's true that moving documentation into a header denies us some of
   the nice organization of a freeform doc.
 - The nice thing about headers is that we can reorganize declarations
   however we want, and if doing so makes the code more readable, then
   I think we should.
 - But, if we won't get up to the same level of readability as the old
   doc, then I don't see a reason to "throw the baby out with the
   bathwater," so to speak. It seems like api-parse-options.txt is good
   enough to stay.

By the way, this does make me start to wonder about the feasibility of
linking in documentation generated from code comments, or other sorts of
trickery to get the best of both worlds. But again, that's a very
different task from "get rid of misleading or useless docs". :)

For now, maybe it's enough to add a link to api-parse-options.txt at the
top of parse-options.h. Part of me wants to say maybe we should
duplicate the per-function briefs into the header too, but then we have
two sources, and a single one is easier to keep fresh.

 - Emily
