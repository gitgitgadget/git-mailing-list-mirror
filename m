Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188591F404
	for <e@80x24.org>; Fri, 23 Mar 2018 22:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeCWW1m (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 18:27:42 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:40708 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCWW1l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 18:27:41 -0400
Received: by mail-wm0-f47.google.com with SMTP id t6so6065396wmt.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 15:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XEdR5NDYrMzXoiXaoUBkFORVO37io87AwuqG8qYjhRQ=;
        b=h53H4ks3ciaOImNiRTvRNSSh3q1Qx7DwBN7qK9lDzxsxUd/4FFYfr1mPNmky3O/asg
         gYSgABPobYUiL2ec6QHxFoiLACZLaGmbdeJCUrrc6AAvGzob/etXiYP1gD6Z2hy+gxm7
         vZ3J6wXfqlcDptlsI6R5+tyKcss82w3slezvBP1ZzBWDdatUNMKQ7oBJ9ylSWHgfoz1N
         cYU0wGOmW0plahaR1UV/zItN5OAX3Qi/okLRU1LSzkTKSn3YYupMouHGF8Y+GqDG7/n/
         eDMtLVvqDSw7xXA69dDz0mHq/hlc9sr/g7rkPyKdLT1CGsn7j9StR3YesEt+GQh/d6ug
         Ptaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XEdR5NDYrMzXoiXaoUBkFORVO37io87AwuqG8qYjhRQ=;
        b=IbAR5sxTOY1MxjSewGzkuMB+Lxce5gx+2E4rwm37hAw4sEVCJ14HNCdIfEQnktDp5U
         hcSPlxav84soA3DimCmt6btDGZe8giTJGtBoERtMSU+LMfXNMK3EUsOVzRyaLSxnTM9U
         SF1Qo73nQ8UkQ6o71V1UZhx8a3rpBzb2wxXOO55fErnoBQt+vOgasVCLzYlhbzfX2lac
         n9VBhwParQqQNqPcXBVYtmBvt1bJfeweIjCkTLrvVrBIJQZqrtkbHQvK66C8rPm1wIvX
         WRh8988fopomM0zRsoKsvABlY6xNZfBeke0ACK9r1pbglbMmmUkElZHr8xuuKqr+YClJ
         GlEg==
X-Gm-Message-State: AElRT7H3aD7pAMe//75H9sguyme97zhhUVhaLYaTAyei4pQ0zZ6Fg8LG
        vZ32c3Q8O/3h7pGq7gn9LuUYbQd4
X-Google-Smtp-Source: AG47ELulV86sKsiNGqalp7+ptYO8Eij9swdLzmYaL6DmLzrEXq7ZgvA2O1jBDJJ1qC8+J4Q6YwFncQ==
X-Received: by 10.28.107.5 with SMTP id g5mr7910439wmc.133.1521844059714;
        Fri, 23 Mar 2018 15:27:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m184sm9430639wme.40.2018.03.23.15.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 15:27:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     git@vger.kernel.org, gister@pobox.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
References: <cover.1521779249.git.wink@saville.com>
        <cover.1521839546.git.wink@saville.com>
Date:   Fri, 23 Mar 2018 15:27:38 -0700
In-Reply-To: <cover.1521839546.git.wink@saville.com> (Wink Saville's message
        of "Fri, 23 Mar 2018 14:25:21 -0700")
Message-ID: <xmqqefkah1gl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> Wink Saville (8):
>   rebase-interactive: simplify pick_on_preserving_merges
>   rebase: update invocation of rebase dot-sourced scripts
>   Indent function git_rebase__interactive
>   Extract functions out of git_rebase__interactive
>   Add and use git_rebase__interactive__preserve_merges
>   Remove unused code paths from git_rebase__interactive
>   Remove unused code paths from git_rebase__interactive__preserve_merges
>   Remove merges_option and a blank line

I felt that the structure of steps 5-7 that adds an identical copy
first and then removes irrelevant parts from both copies was a bit
unusual, but I do not think of a better structure I would use if I
were doing this series myself, and more importantly, the entire
series was a pleasant and straight-forward read.

Will queue and wait for input from others.

Thanks.
