Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FACD1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 18:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeHUVe5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 17:34:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54138 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeHUVe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 17:34:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id s9-v6so3814093wmh.3
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BcxO/1sfKGevp2nUl9NPgfxfKOSsnr1egobA5WITjlE=;
        b=aJtoCj5IqVluYgpgAk8XU2lWfaOEjJQh+5Zgc1L8CQ/tfxe5511uZIAlFN5yqwIjhz
         hkj2gQ9WX+b8rt8sS8plPd+PPBWbhyfqGEf38K1kpjD4l3TKn/P8CrfTkMIZAla78x4a
         WxcT2LVtnO2wthXlDjRKX+usV2W4mFO901RrpoXd5kP3PTT6ZvrGVZW5/ijDGsMEHExj
         LPoy3m/DorBIYEIUVbX8JQsLwpubs74JONW1WOU3yxkPlM93HFUxhEC/9OjF08tc77ef
         u4Ui9QAtmntp3x/+fmq0bL46M/iOWeVBEQdm+SNtHSp5A/hFLHf3wIJtyjGMcBx6s+cs
         g1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BcxO/1sfKGevp2nUl9NPgfxfKOSsnr1egobA5WITjlE=;
        b=SBN692bjDHhfXCd5EKv4DIzHNiPnpBMMfv9B2ZYsmigVSB6Zqjvl+Eln49q2bVGK66
         LrRefUszHVhwGr+mR1qOUBa3gRBQ3kVYbLYGNsh2FiHC66GHaJcx+KFV0Ysg+YwPbCYj
         FF1fJ9nyaymYmFN975Eb3U37oM7ZQh/Efpw/Abldq+y8IY20S8Sg096NMiLx7WFI6eU/
         ZdXPFeAj1kTUR3I++8M5L+lr7VJIX7fdOpDEWl5qT7f7bhPf4YDJphcyL/JbdCex0yDV
         /WQ9ip50c9FsdwPgCdziAj1DnhKYY5+/zwwdcUGB+PU5tAblXtGOKFeZaedYzwHb3/uc
         wekw==
X-Gm-Message-State: APzg51ATMgpIXxtxDCWJaz1/JifmG5726ZoFLQ+SRRYiDe9pH2ub0fII
        uKU4yg8vPRIBM2BW8dZTlV4=
X-Google-Smtp-Source: ANB0VdbNcQpnTA0X1Z5c+EW/c8S9qYZttkrmfoogT9U1tOeewb8ANizQcBWHnMnhzNkxZMHtxrG5kw==
X-Received: by 2002:a1c:f306:: with SMTP id q6-v6mr284209wmq.111.1534875224163;
        Tue, 21 Aug 2018 11:13:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y128-v6sm3627681wmy.26.2018.08.21.11.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 11:13:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] Docs: Add commit-graph tech docs to Makefile
References: <pull.22.git.gitgitgadget@gmail.com>
        <ef5af2ccc7ea662a4059d118772cdbe282fc7e43.1534855978.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Aug 2018 11:13:41 -0700
In-Reply-To: <ef5af2ccc7ea662a4059d118772cdbe282fc7e43.1534855978.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 21 Aug 2018
        05:53:01 -0700 (PDT)")
Message-ID: <xmqqwosj8u5m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Ensure that the commit-graph.txt and commit-graph-format.txt files
> are compiled to HTML using ASCIIDOC.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index d079d7c73..841e4f705 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -69,6 +69,8 @@ API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technica
>  SP_ARTICLES += $(API_DOCS)
>  
>  TECH_DOCS += SubmittingPatches
> +TECH_DOCS += technical/commit-graph
> +TECH_DOCS += technical/commit-graph-format
>  TECH_DOCS += technical/hash-function-transition
>  TECH_DOCS += technical/http-protocol
>  TECH_DOCS += technical/index-format

Looking at what 5641eb94 ("partial-clone: render design doc using
asciidoc", 2018-08-14) had to do to make the straight text usable as
AsciiDoc input, I do not think a patch to D/Makefile alone is
sufficient; just quick skim of the source makes a reader notice a
block of text like this:

    Equivalently, the generation number of a commit A is one more than the
    length of a longest path from A to a root commit. The recursive definition
    is easier to use for computation and observing the following property:

        If A and B are commits with generation numbers N and M, respectively,
        and N <= M, then A cannot reach B. That is, we know without searching
        that B is not an ancestor of A because it is further from a root commit
        than A.

        Conversely, when checking if A is an ancestor of B, then we only need
        to walk commits until all commits on the walk boundary have generation
        number at most N. If we walk commits using a priority queue seeded by
        generation numbers, then we always expand the boundary commit with highest
        generation number and can easily detect the stopping condition.

which would give you two paragraphs that are typeset in monospace,
without giving enough visual cue that these two are the "following
properties" the previous paragraph talks about, like the original
plain-text does.

I haven't checked the "-format" document, but I suspect both of
these are easier to read in text than in HTML formatted without
tweaking the mark-up a bit.  It's not like we are not shipping the
text versions; let's not give readers HTML that is uglier than text.
