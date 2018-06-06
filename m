Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9E191F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933574AbeFFRC7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:02:59 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45019 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933029AbeFFRC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:02:57 -0400
Received: by mail-pl0-f65.google.com with SMTP id z9-v6so4189128plk.11
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nkcGL0GyNngA29XW9lOs/e0/L128U58MmJ9tG3BW5Cc=;
        b=bYCL7JfI0w+gqxl4PqLhfY0xRboK+at1snNBG96GvEpr1M6oMrEbVHuWEqat22Usfl
         DPVIWhl1qLxvLfQ4mKxjivcnPHpys8ROApjqhmDmDtWNAEe9wpVXr3Fji9RsHuAKghqo
         IwfajP51clX95aZ9Wy4sLgNscWqr67+Bjm8s/+TAa6MwV7F0y9Gd9SrE3NspzgNRHW2R
         Fc31CfcWJzS2lI7I62PqN2RrYN7iFbmExqSYkKDrOFMaWkSAFpucObgjQg0wP2rrn84b
         bTq3KwhIm7uhqimMiljPtH3dZYxliQaL/3bGa6I0+mkCHSbka7zayv3LybKclyHs0USV
         YOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nkcGL0GyNngA29XW9lOs/e0/L128U58MmJ9tG3BW5Cc=;
        b=ELMXxZyX6kMNdxvGGLLuqZrDAfpUZ8CEyQ5y424fdHNJQaYTo3bGQ3/4inZ8+oBi+G
         sax0lYavemTkl9p1JkNcJ0145cg3LzoXtA3yErcvUlbxMDht4pzMCbIh6Q8Ulb8pGY26
         J43VVILgg05tJyZGflUaqzzf24gIcu2OycwOiBZDVl/h0+NDGgePa8U4DOOWAXnAKqg4
         jRZNqxqkXqtKvJoc2bmWc08pr13bNbwUPx4JWzU7fHrVq1iTh+gXH3rFTTMk0Yf/Hc2u
         Bks0bMjevnH2VHq6HA2tNcCuceJd+75RYilf6yub/5+1qkG9g0EpnDHpi2wDRNQT06BW
         Gdrg==
X-Gm-Message-State: APt69E2mldPSx03/pgoMTNR2jcW/shsiZfV4v6PpIOivaVT2s23YfQfL
        05pi/sQusvy0eoRUXJEDfrbo8Q==
X-Google-Smtp-Source: ADUXVKLCWRMpTEKcYIf7S6cRMgAG07EBgqfV9Gfw5JlYzUSJki3xDEpxwYqwnR55VscMFmCL0+GwkQ==
X-Received: by 2002:a17:902:680c:: with SMTP id h12-v6mr4107187plk.113.1528304576288;
        Wed, 06 Jun 2018 10:02:56 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id u1-v6sm24216874pfn.59.2018.06.06.10.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 10:02:55 -0700 (PDT)
Date:   Wed, 6 Jun 2018 10:02:54 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 07/20] attr: remove an implicit dependency on the_index
Message-ID: <20180606170254.GK158365@google.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
 <20180606073933.14755-8-pclouds@gmail.com>
 <20180606165051.GH158365@google.com>
 <CACsJy8AZdOQGimhg00ZGwv=ESquDaLae_poj1Au_hE5kaW8ksg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8AZdOQGimhg00ZGwv=ESquDaLae_poj1Au_hE5kaW8ksg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06, Duy Nguyen wrote:
> On Wed, Jun 6, 2018 at 6:50 PM, Brandon Williams <bmwill@google.com> wrote:
> > On 06/06, Nguyễn Thái Ngọc Duy wrote:
> >> Make the attr API take an index_state instead of assuming the_index in
> >> attr code. All call sites are converted blindly to keep the patch
> >> simple and retain current behavior. Individual call sites may receive
> >> further updates to use the right index instead of the_index.
> >>
> >> There is one ugly temporary workaround added in attr.c that needs some
> >> more explanation.
> >>
> >> Commit c24f3abace (apply: file commited * with CRLF should roundtrip
> >> diff and apply - 2017-08-19) forces one convert_to_git() call to NOT
> >> read the index at all. But what do you know, we read it anyway by
> >> falling back to the_index. When "istate" from convert_to_git is now
> >> propagated down to read_attr_from_array() we will hit segfault
> >> somewhere inside read_blob_data_from_index.
> >>
> >> The right way of dealing with this is to kill "use_index" variable and
> >> only follow "istate" but at this stage we are not ready for that:
> >> while most git_attr_set_direction() calls just passes the_index to be
> >> assigned to use_index, unpack-trees passes a different one which is
> >> used by entry.c code, which has no way to know what index to use if we
> >> delete use_index. So this has to be done later.
> >
> > Ugh I remember this when I was doing some refactoring to the attr
> > subsystem a year or so ago.  I really wanted to get rid of the whole
> > "direction" thing because if I remember correctly its one of the only
> > remaining globals that affects the outcome of an attr check (everything
> > else was converted to use the attr check struct.  I always got way to
> > far into the weeds when trying to do that too.  I'm not expecting that
> > from this series (since its way out of scope) but maybe it'll be easier
> > afterwards.
> 
> It's not that much easier. This direction thing is still global by
> design. It would be great if we have something like Scheme's parameter
> (aka. dynamic scoping iirc) then we can still scope this nicely. Git
> does not live in such worlds.

Yeah i realized this after sending.  Either way thanks for simplifying
the global state by getting ride of the index global.

> -- 
> Duy

-- 
Brandon Williams
