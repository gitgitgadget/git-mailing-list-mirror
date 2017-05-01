Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2700E1F78F
	for <e@80x24.org>; Mon,  1 May 2017 18:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbdEASYJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 14:24:09 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35023 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdEASYI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 14:24:08 -0400
Received: by mail-pg0-f41.google.com with SMTP id o3so43049352pgn.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xJ9+SXu3vasWsBhJ+jymDR25V6ZVGHMOh8VOzfjgtik=;
        b=X/aBByFlMhLZeiKtuYjHQfvqMWqz+6BiyA2fhFVRBnHsuOt/o1HkM/Tr2yKTY1x2y8
         B+hjOiyQfKw98bCanbxpBtPOFS4yT4Hwh2PUdE6HsbOvJ0MuwIVPffhfMehatHEcd7lf
         7MCGA+CEmJxe3K6owEflPIoQ5Fkhlx+CbpveD/Ep5Alb4GGQ3xQ7VSIo1qB1QPo530Cp
         ilzQXMAZ0711SjJK9vMNlrgOhR/GtHX+bNuwGopdfbVgsiwQRXK6F7u2or6+u5trDL6o
         7AHkEVNEIpWNOdBJcWQo9PJmncYWoZr2mFbLHZRT2uee3au3j8viPctgZt9G6kgq69Ym
         xeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xJ9+SXu3vasWsBhJ+jymDR25V6ZVGHMOh8VOzfjgtik=;
        b=qTBfci84LMpduAb79LcY/yOfMf2VyJgvS4cRcB15uhsrGNHG0YC4uD9z3IAjR9axyq
         ydQwq3dgduV+2Esm01Iy9c3/EdepFGPMNG1iLO+OVudGTfJiNiArD4gQIvqHMdq6r3g6
         wp8ykzniFyXAsffHHIemFHQSduapzVkQeXDIqkyjU5oGG2qu5LGArk25dxUmX0AAVVJ+
         RNXb7rjCIaQG1Jas0OAKPG2GoDaFkwqTtKCre2Y3Of+FZhsPJy3IhdTcmHPeZFCINPuG
         rsrz3zoNQtahfdXvyOXINtAsB8E2Mrx9wyEZgX2of3pb7t3JNW4r9zanRVVirVzh9hqo
         LhaQ==
X-Gm-Message-State: AN3rC/65POsRMOTLf/BuiZ+g2OppXDnHRTk8N76hafuonih+WDk1vCDs
        W/IeHO3i4sGbPK8T
X-Received: by 10.98.88.4 with SMTP id m4mr28336691pfb.41.1493663047765;
        Mon, 01 May 2017 11:24:07 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6d87:7989:6a8d:cab9])
        by smtp.gmail.com with ESMTPSA id 186sm22044858pfx.72.2017.05.01.11.24.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 11:24:06 -0700 (PDT)
Date:   Mon, 1 May 2017 11:24:05 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 0/5] Some submodule bugfixes and "reattaching detached
 HEADs"
Message-ID: <20170501182405.GG39135@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170501180058.8063-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, Stefan Beller wrote:
> The first three patches fix bugs in existing submodule code,
> sort of independent from the last 2 patches, which are RFCs.
> 
> 
> 
> In submodules as of today you always end up with a detached HEAD,
> which may be scary to people used to working on branches. (I myself
> enjoy working with a detached HEAD).
> 
> The detached HEAD in a submodule is the correct in the submodule-as-a-lib
> case, but in case you actively want to work inside submodules, you
> may want to have proper branch support, e.g. when typing:
> 
>     git checkout --recuse-submodules master
> 
> you may want to have the submodules on the master branch as well.

I don't know why submodules were originally designed to be in a
detached HEAD state but I much prefer working on branches (as I'm sure
many other developers do) so the prospect of this becoming the norm is
exciting! :D
> 
> There are a couple of challenges though:
> * We'd probably want to pay attention to the branch configuration
>   (.gitmodules submodule.NAME.branch to be "." or "foo")

Yes, I agree.  If we have a particular name of a branch configured to be
tracked, then we should respect that and try to attach HEAD onto that
branch name.

> * What if the submodule does not have a master branch?
>   Jonathan proposed off list that we may just want to create the
>   branch in the submodule. This is not implemented in this series.

I think it would be fine to create the branch, just as long as it
doesn't already exist as I can't think of a negative impact of this
(aside from maybe having more branches in the submodules after a
prolonged time period?)

> * In case the branch exists in the submodule and doesn't point at the
>   the object as recorded in the superproject, we may either want to 
>   update the branch to point at the superproject record or we want to
>   reject the "reattaching HEAD". Patch 4 provides the later.

The later seems like the most correct thing to do.  It would be
unfortunate if I had done some work on top of the master branch in a
submodule (which wasn't reflected in the superproject), then done a
'checkout master' in the super project only to go back to the submodule
and find that all my work is gone! (Well not gone, but you'd have to go
into the scary reflog!)  It just makes sense to leave HEAD in a detached
state here as it prevents loss of work.

> Any other ideas on why this could be a bad idea or corner cases?
> 
> Thanks,
> Stefan
> 
> Stefan Beller (5):
>   submodule_move_head: fix leak of struct child_process
>   submodule_move_head: prepare env for child correctly
>   submodule: avoid auto-discovery in new working tree manipulator code
>   submodule--helper: reattach-HEAD
>   submodule_move_head: reattach submodule HEAD to branch if possible.
> 
>  builtin/submodule--helper.c | 12 ++++++
>  submodule.c                 | 93 ++++++++++++++++++++++++++++++++++++++++-----
>  submodule.h                 | 10 +++++
>  3 files changed, 106 insertions(+), 9 deletions(-)
> 
> -- 
> 2.13.0.rc1.1.gbc33f0f778
> 

-- 
Brandon Williams
