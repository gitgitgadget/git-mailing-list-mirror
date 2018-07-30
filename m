Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675D01F597
	for <e@80x24.org>; Mon, 30 Jul 2018 19:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbeG3VYU (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 17:24:20 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:41740 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeG3VYU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 17:24:20 -0400
Received: by mail-it0-f73.google.com with SMTP id w132-v6so498638ita.6
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ssmQbQaAkCCvGeoqwcXLSBlKGGlP0OzxFUS5kEntAaE=;
        b=wR6eHbW1fn3kX/ALWMlznOC8odU4TPtGWsMlPenMe4oV67aH2KfSb/2Mir8OG5RcLt
         8M1wg61eLLNhc1GzTOcl6AWguFBoeWAtw3hpcMybedDMylaY8M86xde/Mp9R27wdenhW
         tzjHTDiA4mZZCsQ8qyyMlPVZl+MVTRLL+tLoaEiGGnJUSy725VsNRZQh/FO5ZqIyG6xs
         RGD0P/9CWDXLeNB0coSkxn30sU9TQtFBQ9UskXhDaCKAZk+CxXUDADUMliklh1y/NvuX
         5c2Vo/kmyHjQFq847ZUrgi0w4y99sjgMNKzzf9YwrKEhkKUno+cvLmJL2kb02jqHYQFP
         J22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ssmQbQaAkCCvGeoqwcXLSBlKGGlP0OzxFUS5kEntAaE=;
        b=qFzGj6drCSf308eBGTMqW0i/KFwdsmQQfCerICmSiT4xxJcOsxf5s1E99nXzqhYCG0
         Tl2/07+E1tfJZMnIsQoSDcSLvOsC5WAkDUQeDFARdMy9y5rlHXarT9SFIRCIBTEgOa9I
         SJ4pBW10/izbHjUjX2QaDvzZbDEt0S2U0V/kNBnDeXklkk+hoQB1iafzuANCSgTwrUZ2
         RQ5lV84S2/dtHiqbhIoJydTpWqz8QDsWR4mb05t3Rw2k7zzPXJC4qVKA98EVTpScGi4B
         U3lqe7W+ZzAouediQ3O2lHDSmAvz1roW4cb7rXIRDo9/FPDpIqdwz0SjCUem2XOOJwWN
         nF6g==
X-Gm-Message-State: AOUpUlEIJdghIbsMn+lqr1i03xjrUbTHhIlOLehBXUK6AirzL9bbJudt
        NlZxhQ4z5EV2t9rkmSSLTYVdvLUcAtDe
X-Google-Smtp-Source: AAOMgpctHa7X8Gp6DYcVK+Wk/RuQPgPoAYyawNmovX2TmlXDOBO7yhYSMoPT3Su/2OfKVwm5uQH9ZQHOpF63
MIME-Version: 1.0
X-Received: by 2002:a24:1f46:: with SMTP id d67-v6mr286350itd.49.1532980067379;
 Mon, 30 Jul 2018 12:47:47 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:47:29 -0700
In-Reply-To: <CACsJy8Cx7u5YtK6sPJ=HbAOUBXCrP7VOgMyoQ58SB6q_s4N7Gg@mail.gmail.com>
Message-Id: <20180730194731.220191-1-sbeller@google.com>
References: <CACsJy8Cx7u5YtK6sPJ=HbAOUBXCrP7VOgMyoQ58SB6q_s4N7Gg@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 0/2] Cleanup refs API [WAS: Re: [PATCH 2/3] refs: introduce
 new API, wrap old API shallowly around new API]
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, mhagger@alum.mit.edu,
        sbeller@google.com, stolee@gmail.com, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > I anticipate that we need to have a lot of back pointers to the repository
> > in question, hence I think we should have the repository pointer promoted
> > to not just a back pointer.
>
> I will probably need more time to study that commit and maybe the mail
> archive for the history of this series. But if I remember correctly
> some of these for_each_ api is quite a pain (perhaps it's the for_each
> version of reflog?) and it's probably better to redesign it (again
> talking without real understanding of the problem).

I stepped back a bit and reconsidered the point made above, and I do not
think that the repository argument is any special. If you need a repository
(for e.g. lookup_commit or friends), you'll have to pass it through the
callback cookie, whether directly or as part of a struct tailored to
your purpose.

Instead we should strive to make the refs API smaller and cleaner,
omitting the repository argument at all, and instead should be focussing
on a ref_store argument instead.

This series applies on master; when we decide to go this direction
we can drop origin/sb/refs-in-repo.

Thanks,
Stefan

Derrick Stolee (1):
  replace-objects: use arbitrary repositories

Stefan Beller (1):
  refs: switch for_each_replace_ref back to use a ref_store

 builtin/replace.c | 4 +---
 refs.c            | 4 ++--
 refs.h            | 2 +-
 replace-object.c  | 5 +++--
 4 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.18.0.132.g195c49a2227

