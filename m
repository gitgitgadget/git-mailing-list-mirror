Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C031F20356
	for <e@80x24.org>; Tue, 18 Jul 2017 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbdGRRXn (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 13:23:43 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35490 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdGRRXm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 13:23:42 -0400
Received: by mail-pg0-f49.google.com with SMTP id v190so16266351pgv.2
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 10:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PSvC7bv4urhMU7SapnR40HgCugPYX4lARULzWidYL/8=;
        b=NByNC+J9pUVCmxyK22UKPpGXTlU2+wP7cFSozObVe2wflYbRm33teU+8BK1bON3+Bx
         8FYxA7nUnNa7gmFcNIlvibgIpcUsVD034hG2BlwEjjNlhTkeh9O8vhXgcDd1NsRGw0ZP
         5+fHHRySDLEx46B6xInVpCYI4/y6FhhGfmostm3rtFmAzsmA+/ZOLLG8KgTD3jdiKBiq
         um1n4SFRohkeYF/5QP4+ytMiuBCjWwAC0mOu817nj9C7U66F8Ryg5kkqORUPRT5pIXTW
         M/J5h2AH8I748UA3i0gtXNY5RU1Ij9MsCHjU5nSAS021kT7MztgnQ2hd4EJGsP1xaRAA
         578w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PSvC7bv4urhMU7SapnR40HgCugPYX4lARULzWidYL/8=;
        b=oXO2sRxNHCxlMoQFjmjkhMQuXaT1ZNFMza4Ba+jsN1HveRXW8JqB9D02sNRzOw9QT5
         ta9/jVrDKXUV9/0FXaFJrTQQJ/BO2N8rQdiMEprNA61fMOQ4Vj73grSHksD8MSvk+qNU
         F6l3ygK1HTRen8C7LQavA7yT+JxOnwLPz6u1E1nIqlt9ijC7N9XlSSO+7A6pJNoqWuZ2
         KWD2grNUpCWQt6dAfFeT/JCJo/J1mTK665mvOoE99nO8Yw7EOD3/EfV/gQlthS+9Nx6x
         /EIQsUmepkRDZUxSVqZiqxSNURCZyVoenz+cAb+DYmri1rVz+Rg9iFvx668YipaynX+c
         +BNQ==
X-Gm-Message-State: AIVw113iyTbzxu0GGlsLdCWrL0B/tE0WJqjM4dnrjBMzkU2ZA3A8pGkt
        mqdUPwCiD1wrIXEiDOA=
X-Received: by 10.99.101.132 with SMTP id z126mr2830037pgb.64.1500398621964;
        Tue, 18 Jul 2017 10:23:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:44ee:1bb0:7d2b:7a8d])
        by smtp.gmail.com with ESMTPSA id s14sm6461466pfj.124.2017.07.18.10.23.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 10:23:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
References: <596ddaa620821_77f83e7330107c4@ss1435.mail>
        <CAGZ79kaPFDMn2K0f529-Crzv+vhU3XUMsSM6w3QV4RXKBv5s_g@mail.gmail.com>
Date:   Tue, 18 Jul 2017 10:23:40 -0700
In-Reply-To: <CAGZ79kaPFDMn2K0f529-Crzv+vhU3XUMsSM6w3QV4RXKBv5s_g@mail.gmail.com>
        (Stefan Beller's message of "Tue, 18 Jul 2017 09:59:20 -0700")
Message-ID: <xmqqa841fylf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I looked at this report for a while. My current understanding:
> * its detection was triggered by including rs/move-array,
>   f331ab9d4c (use MOVE_ARRAY, 2017-07-15)
> * But it is harmless, because the scan logic does not understand
>   how ALLOC_GROW works. It assumes that
>   done_pbase_paths_alloc can be larger
>   than done_pbase_paths_num + 1, while done_pbase_paths
>   is NULL, such that the memory allocation is not triggered.
>   If that were the case, then we have 2 subsequent dereferences
>   of a NULL pointer right after that. But by inspecting the use
>   of _alloc and _num the initial assumption does not seem possible.

Yes, it does appear that way.  ALLOC_GROW() calls REALLOC_ARRAY()
which safely can realloc NULL to specified size via xrealloc().

I'd be more worried about segfault we seem to be getting only on
Windows from this:

    git -C parent grep -e "(1|2)d(3|4)" --recurse-submodules HEAD^ > actual

in https://travis-ci.org/git/git/jobs/254654195 by the way.


