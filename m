Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC981F597
	for <e@80x24.org>; Fri, 20 Jul 2018 17:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388193AbeGTShm (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:37:42 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:51507 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388183AbeGTShl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:37:41 -0400
Received: by mail-wm0-f49.google.com with SMTP id h3-v6so9773472wmb.1
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 10:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jRB1Ocnqdix0sAobkKLM9iLcbXjsQTiDFQgzYe2LTWM=;
        b=vbis1h8UvixVKnuhjgLbV2Ed63wnOdoiEIKTao+/T+C1/lckXB9d+EJEn7S+yLYDwM
         BGUpU4nX+qyJm7cV1Vd7F/GSzbHI7khvEAcvw1bmTwRiG0uFb09kfcuXlnKimXqoS27z
         7cVxGh1jmpeGvFtu/eqqYGVz0viXsFXiLaggGTD6Yid82eNEFGXYqURQfh9IWuCvaobU
         e6OUYKeSsQJF8s7tO2kvZbL0x9ErEnv88QEqQGRN10RsuE11Bder5GM9VX+WY/PVRmXV
         kW4y34rthDQTPkUeUxgUSx+3rMHTB512uPPTXQE+qlPmBBoJmRkKaAld8gcXy4SA1G1P
         ZyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jRB1Ocnqdix0sAobkKLM9iLcbXjsQTiDFQgzYe2LTWM=;
        b=aMTojAuNOPDAn//yOZmyNhn2trUDWI+oyLtIaYQ2RUCSSUJ4noYo/2tvE/ZAuha588
         qCIT2I+9t3Yc3Fm2zEFWEpDt/reu8Cw9SDff46Pij4j31co1K3jD5NoBERtlrngAsi7o
         4kDQWxp5OVzN/TNQnFkmOzxVszVLC/561PAjgx3HiAKBBaiUCsRRFNDN5zwEspaEo26/
         WcpBLsL/2O2JkNeSScAnXeUhoiOy5OsnSy5h60fW0E0DpNoEFvcjrSLs/fONCBspd+g9
         XWiUcBIC2Ij82PMB5XGJL8qF/AJW9zwVpl6zYC1Ut8u/ErhJThjZ1I6wlf/WkrRwPEMe
         eINA==
X-Gm-Message-State: AOUpUlGGxz/02Ss0ghIpcUblUEnsNGrxBRamNnwTXXYozO3E24YRcd58
        VE5wIX0+hIAGEftLWRNVUh6TFcv/
X-Google-Smtp-Source: AAOMgpf1fnxIDPkEfdMuo3AzAGkpqApN1vJSHcf+AH20EvPgYSzXT04SdWMfOB2Qd5FiHnDK/XwqHA==
X-Received: by 2002:a1c:168a:: with SMTP id 132-v6mr2260265wmw.13.1532108900510;
        Fri, 20 Jul 2018 10:48:20 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.gmail.com with ESMTPSA id l6-v6sm1694387wmh.41.2018.07.20.10.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 10:48:19 -0700 (PDT)
Subject: ag/rebase-i-in-c, was Re: What's cooking in git.git (Jul 2018, #02;
 Wed, 18)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <e4aea192-2ed6-7715-6c66-63c873f5ce94@gmail.com>
Date:   Fri, 20 Jul 2018 19:48:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 19/07/2018 à 00:03, Junio C Hamano a écrit :
> * ag/rebase-i-in-c (2018-07-10) 13 commits
>  - rebase -i: rewrite the rest of init_revisions_and_shortrevisions in C
>  - rebase -i: implement the logic to initialize the variable $revision in C
>  - rebase--interactive: remove unused modes and functions
>  - rebase--interactive: rewrite complete_action() in C
>  - sequencer: change the way skip_unnecessary_picks() returns its result
>  - sequencer: refactor append_todo_help() to write its message to a buffer
>  - rebase -i: rewrite checkout_onto() in C
>  - rebase -i: rewrite setup_reflog_action() in C
>  - sequencer: add a new function to silence a command, except if it fails
>  - rebase-interactive: rewrite the edit-todo functionality in C
>  - editor: add a function to launch the sequence editor
>  - rebase--interactive: rewrite append_todo_help() in C
>  - sequencer: make two functions and an enum from sequencer.c public
> 
>  Piecemeal rewrite of the remaining "rebase -i" machinery in C.
> 
>  Expecting a reroll.
> 
>  The early parts of the series seem solidifying; perhaps with a
>  reroll or two, they become 'next' material?

I am working on new changes (rewriting init_basic_state(), and making
rebase--interactive a builtin), so it will probably need at least one
more reroll before being trully ready for 'next'.  It’s not completely
finished yet, I hope to send it Monday or Tuesday.

Cheers,
Alban

