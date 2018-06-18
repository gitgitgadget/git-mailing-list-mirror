Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 784141F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936284AbeFRTxk (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:53:40 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39738 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936120AbeFRTxj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:53:39 -0400
Received: by mail-pl0-f67.google.com with SMTP id f1-v6so9591105plt.6
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OAFLUyiLcNRblUvO1pSwHHoEyepsjY7LsGjKk7ysPJk=;
        b=QAdmhHGu7KP96qAJyB4Mx6FuCitHpWEH+1PvsmSt4MnGM1v77wdIKwhf0JlTJKgIJ+
         92mubzMKclJZB0fy4hX8K1Y2CaOHoQHdUnyW0VX8cXFnmfoSyrxitK8U5uavJQLFB2mz
         B537C4SCurXqgK3X4Fpw4D9k9qahYkqsARjGudqlg2a6KefiH6QSNG739B0WwlI4SGWG
         N+Nf+S0er9lvpSNo6AVOpXIZveEgUD6FJL9fPjqeAXl+9WR9WF6/xnIGZQStBJweXjdA
         z9LN74upwANVnOy9X9qjX+MdPHTacJ2i6EioZRpNT/u+WtV2QjobUkSUTSykBCbBNZmR
         A7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OAFLUyiLcNRblUvO1pSwHHoEyepsjY7LsGjKk7ysPJk=;
        b=lrXTuD90HZjsH/KlIHWU2FtwYQJVRGEiQTGfiWDkYNnwDkVeXnOQMOtKIPkhbjfFvm
         PFc/u/i/h6UC0GOUVVN2K3gFULO0kJpYadVamgHvRqMlO491c/30RVW1bOOelAHine70
         CCZW/w/DNMEaY3DoZGpuOLHec7byQFrhQAKRiGGqfySC9VEz25p3zRRTIdDxsgcEEOLj
         fPhrVPx59b0P0gi4MT/PNZCAJMj+06bLTwDVLsNNUNzwnirwIK7Mn5Oe/t0tCUmaI2Nw
         ybgXKQiW0dDrtdWMUsNSpruqEg3oVjOQBPtYHY2PQMZ3fSf76JbMWlPe1KLjhIb8hL5i
         VuCQ==
X-Gm-Message-State: APt69E0o5tInJkuqArxr4SUQZvaucwCdeabp2xPxsKd7/IoMn46kQyYD
        o+XzjA4TKxlXqNZvmLNh0MIt6g==
X-Google-Smtp-Source: ADUXVKLymSuSeKRNUBaGwVGhRoThVfB/r94kBSmR/C18g9E46uOkf48UGJc1cwKoh3rDFlZz1VzovA==
X-Received: by 2002:a17:902:292b:: with SMTP id g40-v6mr15710582plb.273.1529351619047;
        Mon, 18 Jun 2018 12:53:39 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id h10-v6sm19791278pgn.42.2018.06.18.12.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 12:53:37 -0700 (PDT)
Date:   Mon, 18 Jun 2018 12:53:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     sbeller@google.com, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
Message-ID: <20180618195336.GE73085@google.com>
References: <CAGZ79kbB0Tv8wb_7j0=OdQqGU78KHp3JzuCeD01JTF4EHwOH0w@mail.gmail.com>
 <20180618194750.137341-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618194750.137341-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/18, Jonathan Tan wrote:
> 
> This would cause different behavior. For example, if I run "git fetch
> refs/heads/master refs/tags/foo", I would expect tag following to work
> even if the tag's name does not start with refs/tags/foo.

I understand that some people *may* want tag following, but really its
confusing from an end user's standpoint.  You can fetch a particular ref
and end up with a bunch of tags that you didn't want.  Aside from that
my biggest issue is with performance.  The ref filtering was added to
cut down on the number of refs sent from the server, now we're basically
adding them all back no matter what (unless a user goes and flips the
default to not fetch tags).

I think we're probably going to need some people other than us to
comment on how this should be handled.

> 
> > > @@ -359,7 +359,7 @@ static struct ref *get_ref_map(struct transport *transport,
> > >                 refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
> > >
> > >         if (ref_prefixes.argc &&
> > > -           (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
> > > +           (tags == TAGS_SET || tags == TAGS_DEFAULT)) {
> > 
> > Oh, I see. This always asks for refs/tags/ whereas before we only
> > asked for them if there were *no* refspec given. Maybe we can
> > change this to
> > 
> >     refspec_any_item_contains("refs/tags/")
> > 
> > instead of always asking for the tags?
> > (that function would need to be written; I guess for a short term bugfix
> > this is good enough)
> 
> Same answer as above.
> 
> > How is the tag following documented (i.e. when is the user least
> > surprised that we do not tag-follow all and unconditionally)?
> 
> It's documented under the --no-tags option in the man page for git
> fetch. I'm not sure what you mean by the user being surprised.

-- 
Brandon Williams
