Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 603D91FC44
	for <e@80x24.org>; Sat, 11 Feb 2017 03:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbdBKDKB (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 22:10:01 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36682 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbdBKDKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 22:10:00 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so4369539pgf.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 19:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=M4Nxw6rINJtVCvikPjfQUzwZ6YJCu606zVVYpnyuA80=;
        b=s2/xxwBXFnRshy2nCEfzuBf6vLLvfwKjSywZmmxtZNEUU8OcHet1yOOQnbn0yKjtzb
         Lu93oP8JPmv0yfm2t6wkIMp84m0+OhT+3ohS/tOtyM76u3yH4qdhNzft6vGKWsUyTv+T
         W44s/vp3pioPutARshRJInpX6BOGKC6PNMDxGNUvasxiPjPO766EnF63UYZlmiQ5fSoK
         e3Uc28ZunK2SGCnm0hmeIeQ3wfdO9xWhrJMZxBnRBGUDLIFwP1BHX5BB0DOb2J0oPkP7
         1skw18pHnTW+HN9dgANvPrkJC7oJIAVgITbBFi8l6XflMqDsihUuCDC4UyoGWSRmcUqF
         H/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=M4Nxw6rINJtVCvikPjfQUzwZ6YJCu606zVVYpnyuA80=;
        b=BbRoXePqj5jV08wJCBzzkYlSXtFA4bLZlvy0Jz/NCx6KTd99j95xGBX8bVMmlBk51I
         kM7ZyP+IXUD4odAIRTHuCSo5um6TyZsV5lOx17NDUw2/hesQVwT+ijvF4TXkv7vGm2Z/
         3ff9nyW9Ujo888+4UWIzUEshN1Q8ipywT+VvzXXx6u5lKWRXRlmbGIqm0gbCwTCw5uVn
         +Z4zpzfIyiV7yPrcQtcXtxPBODz6bPhR0roVZ6vX5i96rmfQZBHGR0UE/smDMfbmTUIo
         SQ+cjpLpe/iQizzbkIy+xOqCaEeRqhMXU62vmAxZyOAE4OhRJ8wdomGmmMRvD7OPteXB
         +5lg==
X-Gm-Message-State: AMke39n97ovP1XJE1mm+ZTd8q0mpYZ2dkVTPL49PcmhDJup/B+zFvJbfKQ/CVqYmfH/lRA==
X-Received: by 10.99.66.193 with SMTP id p184mr14573615pga.213.1486782599440;
        Fri, 10 Feb 2017 19:09:59 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id p129sm1653957pfp.118.2017.02.10.19.09.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 19:09:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: fuzzy patch application
References: <CAKwvOdn9j=_Ob=xq4ucN6Ar1G537zNiU9ox4iF6o1qO7kPY41A@mail.gmail.com>
        <20170210205749.c72ajnld7zjfjkwj@sigill.intra.peff.net>
        <CAGZ79kaG=oqDM=1+rz_zk6Qn-7wAszxPnBtqrkAJS29_qT7SoA@mail.gmail.com>
        <20170210214850.2ok62xdmemgotwnt@sigill.intra.peff.net>
        <xmqqy3xdisos.fsf@gitster.mtv.corp.google.com>
        <xmqqlgtdiroz.fsf@gitster.mtv.corp.google.com>
        <CAKwvOdmvYiu4ApxL7jVh_0WZUMVeC2jJ4Q_Zs5Z5-J6GNH8DdQ@mail.gmail.com>
Date:   Fri, 10 Feb 2017 19:09:56 -0800
In-Reply-To: <CAKwvOdmvYiu4ApxL7jVh_0WZUMVeC2jJ4Q_Zs5Z5-J6GNH8DdQ@mail.gmail.com>
        (Nick Desaulniers's message of "Fri, 10 Feb 2017 14:56:11 -0800")
Message-ID: <xmqqd1epifsr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:

> For the dangers related to fuzzing, is there more info?  I found
> and old post on this from Linus calling fuzzing dangerous but
> from what I could tell about my patch that wouldn't apply
> without fuzzing, the only difference in bad hunks was
> whitespace that had diverged somehow.

If the "old post" is the one he explains why he chose not to allow
fuzz by default, I think you got all what you need.  Basically, he
wanted you and his users to make sure that the patch they are having
trouble with applying can be due to only insignificant difference
and it is safe to apply with reduced context, instead of blindly
accepting a fuzzy patch application.
