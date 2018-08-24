Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC35E1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 21:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeHYBcv (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 21:32:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47073 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeHYBcv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 21:32:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so8538065wrc.13
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WpI+6ioZyLIlJtX3ayGMwl0JWcCZvvXK01NCjB7Ar3w=;
        b=Ib5TGAra4OeGXLJN68fiYNXsZNjmxrAqFhz3+a5aldauCiezMdQ1p1gZubcJyQC9jI
         I+GDjOige5sMmPkOKrEepAler258xZ9at3OAQsiUbBen+D1/u1tW7q5hkTMjyL2PXZ9n
         43X6maCj1OD7lnuCUrdEhyWtLhg3zG3zzMXTR3pf7fsuwz87bFk8iSdkATNDBtc+NVfn
         Sqozw6Hzea9Qd43vMBDxDgt9ZsyAJW8QWbI9nBQM5JHdp519ecoq77lofN8SY4rz0YfH
         tAksRozVtgu23cHuM7BIL10eAqvi7t1bH/oi4jZqLTQj8MnP11tF6z/nYbiNpz+jQI4g
         PJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WpI+6ioZyLIlJtX3ayGMwl0JWcCZvvXK01NCjB7Ar3w=;
        b=mM3R6RMpSRa0TsR4UoA/57Wrnh/IcxoT5IhZgSHfOYtta5ix3e9nqhGjbbhF9+yv48
         3iFhHpP6DShR54q88KjEBgPx5Lq32lmpikxbM8VU47YfgSAy4XB7pOh/F/+P2IvYbgtt
         Mzl/M+Hnq33wDQzdvIUgtJnaYldxT0j63yYzrYshAx5dzwzum/HF1ezf1JfUmBf2yQZd
         K9FQCbPg08y95NQclraT1PKVf2m/njX+H84myfgol0ysygvk9HoO46wMDvBSwzgaKNzM
         6DWfLLtyzE6j+fI3N/az6gNRAMnv5IDx2eeuTtNUKGnRcRg3YRx2qvyKZlFa3cLfT9iI
         EwxQ==
X-Gm-Message-State: APzg51BaLixPJH/qK4wiFUR8+OJY8F45ETBHW6ffg9QrZZrcSbpbhaaW
        F95XfojTmjSlqYrB3UiaK2E=
X-Google-Smtp-Source: ANB0VdYZJOJ9GKN98/ikOKihzb5zrWlOX1EFM/D1HfwlzO3BKa8TOsnyXfsIcSC2LFmaURNCl5rKHg==
X-Received: by 2002:adf:eb0d:: with SMTP id s13-v6mr2294634wrn.174.1535147781765;
        Fri, 24 Aug 2018 14:56:21 -0700 (PDT)
Received: from localhost ([2.29.27.208])
        by smtp.gmail.com with ESMTPSA id v133-v6sm3943093wma.36.2018.08.24.14.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 14:56:20 -0700 (PDT)
Date:   Fri, 24 Aug 2018 22:56:19 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 10/11] rerere: teach rerere to handle nested conflicts
Message-ID: <20180824215619.GH13316@hank.intra.tgummerer.com>
References: <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180805172037.12530-1-t.gummerer@gmail.com>
 <20180805172037.12530-11-t.gummerer@gmail.com>
 <CACBZZX6xvsZ4K86b53ura6zENs2p0SBjwYYG=h0TNem3wnEbuQ@mail.gmail.com>
 <xmqqsh365qt0.fsf@gitster-ct.c.googlers.com>
 <20180822203451.GG13316@hank.intra.tgummerer.com>
 <xmqq4lfmm7pb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lfmm7pb.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/22, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Hmm, it does describe what happens in the code, which is what this
> > patch implements.  Maybe we should rephrase the title here?
> >
> > Or are you suggesting dropping this patch (and the next one)
> > completely, as we don't want to try and handle the case where this
> > kind of garbage is thrown at 'rerere'?
> 
> I consider these two patches as merely attempting to punt a bit
> better.  Once users start committing conflict-marker-looking lines
> in the contents, and getting them involved in actual conflicts, I do
> not think any approach (including what the original rerere uses
> before this patch) that assumes the markers will neatly form set of
> blocks of text enclosed in << == >> will reliably step around such
> broken contents.  E.g. it is entirely conceivable both branches have
> the <<< beginning of conflict marker plus contents from the HEAD
> before they recorded the marker that are identical, that diverge as
> you scan the text down and get closer to ===, something like:
> 
>         side A                  side B
>         --------------------    --------------------
> 
>         shared                  shared
>         <<<<<<<                 <<<<<<<
>         version before          version before
>         these guys merged       these guys merged
>         their ancestor          their ancestor
>         versions                versions.
>         but some                now some
>         lines are different     lines are different
>         =======                 ========
>         and other               totally different
>         contents                contents
>         ...                     ...
> 
> And a merge of these may make <<< part shared (i.e. outside the
> conflicted region) while lines near and below ==== part of conflict,
> which would give us something like
> 
>         merge of side A & B
>         -------------------
> 
>         shared                  
>         <<<<<<<                 (this is part of contents)
>         version before          
>         these guys merged       
>         their ancestor          
>         <<<<<<< HEAD            (conflict marker)
>         versions
>         but some
>         lines are different
>         =======                 (this is part of contents)
>         and other
>         contents
>         ...
>         =======                 (conflict marker)
>         versions.
>         now some
>         lines are different
>         =======                 (this is part of contents)
>         totally different
>         contents
>         ...
>         >>>>>>> theirs          (conflict marker)
> 
> Depending on the shape of the original conflict that was committed,
> we may have two versions of <<<, together with the real conflict
> marker, but shared closing >>> marker.  With contents like that,
> there is no way for us to split these lines into two groups at a
> line '=====' (which one?) and swap to come up with the normalized
> shape.
> 
> The original rerere algorithm would punt when such an unmatched
> markers are found, and deals with "nested conflict" situation by
> avoiding to create such a thing altogether.  I am sure your two
> patches may make the code punt less, but I suspect that is not a
> foolproof "solution" but more of a workaround, as I do not think it
> is solvable, once you allow users to commit conflict-marker looking
> strings in contents.

Agreed.  I think it may be solvable if we'd actually get the
information about what belongs to which side from the merge algorithm
directly.  But that sounds way more involved than what I'm able to
commit to for something that I don't forsee running into myself :)

>                       As the heuristics used in such a workaround
> are very likely to change, and something the end-users should not
> even rely on, I'd rather not document and promise the exact
> behaviour---perhaps we should stress "don't do that" even stronger
> instead.

Fair enough.  I thought of the technical documentation as something
that doesn't promise users anything, but rather describes how the
internals work right now, which is what this bit of documentation
attempted to write down.  But if we are worried about this giving end
users ideas then I definitely agree and we should get rid of this bit
of documentation.  I'll send a patch for that, and for adding a note
about "don't do that" in the man page.
