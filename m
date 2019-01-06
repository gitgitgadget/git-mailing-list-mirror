Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564BE211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 18:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfAFSc3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 13:32:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46664 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfAFSc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 13:32:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so41051546wrt.13
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 10:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CX6mDNdVnpOa8qASSBgI89ddpus1FRf6aCKRfDnB49s=;
        b=dNoeRjXh9aHvlqYAW5WxziqqjYI4ikOYUuMQ8S0Qz6mXk5WWLR1lCW/dYBhzDO8hjC
         QwsyYvD+FvYuwx/+3Kyw4TV2WI7gFHu/nyfKTLfHwHTc5Pkip/xA66yPQ642yAzMHcm7
         /GHA/8lei9iNitE841w4LLSAEIWlRU9fm6jrhpkA4rHdLqA4M38rhjLJ6a30o5hqm500
         HECMinbRTjyo+WLYkJwP070yr6SpNBFBpsUQgJu02Q5UmjtJjCwcOE437VmCg9I+STa0
         4EVMbbTgA8DhwFsJClO1sG6DyU4QfkglomGAOcAdES03ouN3fb0NbyON3n4dg/0b0nw3
         Cd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CX6mDNdVnpOa8qASSBgI89ddpus1FRf6aCKRfDnB49s=;
        b=NSul2y6qUVXdxrKgszjinkeXAP57qPiDcQP0hmpzbUHBBJFwKhiPyNFVr+FdFUXUiu
         PgUy9oE6x9ne1b0pmxQtZZItGx/abgLWcDIdNI5DbxvgnZjp4UePS27ReMWcShd6IiE6
         A8biRVjyNyWn8iO7P2MUuYsgItU4rUKeSpRPvy51e3D35H5jh7112ej0u1Q9vKKhaGRt
         nU9j2MaSLZ75y7ti2fvJmtOn8SR2o2NfMhJmidXcpwdtmE9tqtsBxNenPiM1OOWDHnNM
         YdLa0sEcg3MxXeIaCuxLPBzXqfYWMuM/QDLSz1uhpeM9KWv+LNPGuiM6WkarcUDaMWuf
         kNMw==
X-Gm-Message-State: AJcUukd3AioPiWXEXc6ARucOIq2pZcitCUoPF/2aEbfGnCM9EznmLrna
        lOiAS4yPag7KBZZ5OHl/EPo=
X-Google-Smtp-Source: ALg8bN5FiEh8jBHMOThywszgXEd45BFF9AiI7c3Q8eXucF4BZfDhdSCVIaPi4Uz82n1mgSI3KyJflg==
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr51707522wru.177.1546799547548;
        Sun, 06 Jan 2019 10:32:27 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id g129sm6024825wmf.39.2019.01.06.10.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 10:32:26 -0800 (PST)
Date:   Sun, 6 Jan 2019 18:32:25 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 8/8] checkout: introduce checkout.overlayMode config
Message-ID: <20190106183225.GH25639@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181220134820.21810-1-t.gummerer@gmail.com>
 <20181220134820.21810-9-t.gummerer@gmail.com>
 <xmqqo98yiq8i.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo98yiq8i.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/02, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > In the previous patch we introduced a new no-overlay mode for git
> > checkout.  Some users (such as the author of this commit) may want to
> > have this mode turned on by default as it matches their mental model
> > more closely.  Make that possible by introducing a new config option
> > to that extend.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  Documentation/config/checkout.txt |  7 +++++++
> >  builtin/checkout.c                |  8 +++++++-
> >  t/t2025-checkout-no-overlay.sh    | 10 ++++++++++
> >  3 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
> > index c4118fa196..53f917e15e 100644
> > --- a/Documentation/config/checkout.txt
> > +++ b/Documentation/config/checkout.txt
> > @@ -21,3 +21,10 @@ checkout.optimizeNewBranch::
> >  	will not update the skip-worktree bit in the index nor add/remove
> >  	files in the working directory to reflect the current sparse checkout
> >  	settings nor will it show the local changes.
> > +
> > +checkout.overlayMode::
> > +	In the default overlay mode files `git checkout` never
> > +	removes files from the index or the working tree.
> 
> Technically the above "never removes" is incorrect.
> 
> 	$ mv COPYING 1 && mkdir COPYING && mv 1 COPYING/COPYING
> 	$ git add COPYING
> 	$ git checkout HEAD COPYING
> 
> would remove COPYING/1 from the index and from the working tree to
> make room.

Right, that's a case I didn't think about.

> Because I think that a bit of white lie like what you wrote would
> help readers understand the key point of "overlay or not overlay"
> better than an overly precise description of the reason why the
> removal in the above three-liner case is the right thing to do, I
> think the text in the patch is good enough at least for now, but I'd
> mention it in case somebody else can think of a better phrasing to
> covey the same key point without being technically incorrect.

Maybe it would be enough to say "... `git checkout` never removes
files, that are not in the tree being checked out, from the index or
the working tree"?  It is more technically correct, but dunno making
the sentence harder to read is worth it.

> Thanks.
