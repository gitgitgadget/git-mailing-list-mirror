Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E231F954
	for <e@80x24.org>; Fri, 17 Aug 2018 14:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeHQRvw (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 13:51:52 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54846 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeHQRvw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 13:51:52 -0400
Received: by mail-it0-f66.google.com with SMTP id s7-v6so11567509itb.4
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WtqjBwDBXFNGGWejgP951YVmrSDAD8lzQCPHfUl6+FM=;
        b=VX4O04K2o8pwS2L82HM0S518eVzJytFqT4Xh92oB3T1o/tFV1kUVc5QIaOy90R4WrR
         cuSFBm3S9DG4xJxwPNhPWCC7X3o3+bJtfXBVj24JlmbeNFFwt4XxI/IEngTT2dp2Ky19
         lAs5C1kRKGX2jUCPUDBOc0FS72r8cWbqv01XNGIKZ6a26PlBtVyrFJLoIf2u9aBV3LgM
         Ij7dOXWKuWCgLFa5qQuKIE3e8cjo3KbhYavSEFBJRCIJtHjR0c/9H6YmAloW3qXv/Jkp
         xl9sgu3+o4gyH4Tz1ScrZQAKFNL05k6C6W92R4HvhglrsxgjYVF9HFY3NB2rV9f25WsS
         tcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WtqjBwDBXFNGGWejgP951YVmrSDAD8lzQCPHfUl6+FM=;
        b=MevTQCvrx5U1pAQ638Lqvjsx1o1xyVV6kl8jmk92ib6abhVh/CXtyD7dZXINbFltfW
         L3YOEA/owHBOtjitPk/PjNfADgbrnu3dHTlJGqnrSRfJ5XMi3b6vO6Wafm0TXe5SWgYl
         oBEkmfvJpaqLBdCGZRKRHWipu4wCf/BbzqD/Gq6ha71KCqes9dZeWpNFd5nRg5l113uN
         tvRUsPCNe1gJrSOuA7t8x+LXXz1Jf4D634AxkQS2mEabFJAdSgesL2IgO6qhhpeODzR0
         H95ddyiUID/lFAFpJgsFWqTaogTVuBQKs+rpjZ7ApPfLbeQiO0Y4nrPzOyC2EV9ylWul
         Ph8w==
X-Gm-Message-State: AOUpUlHrq1zkT3/FJrJgWlmLQkoL1b70ZBB08fNLXIEe+fgKKxc7kxP7
        ixPjytTTR8TranprfirC8nQL1ie5vPvynMNysw0=
X-Google-Smtp-Source: AA+uWPyVk2g0Hao4laBBFG17slRvj7fGv57IbQh8k85TFV2bbfAWRAUCWVufxu5hBarQPY9MjRw/kwsEPROnI5dsQUQ=
X-Received: by 2002:a02:c99:: with SMTP id 25-v6mr880278jan.97.1534517293038;
 Fri, 17 Aug 2018 07:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <69624916-f6ba-d4a4-e346-69498662905e@hadisafari.ir> <20180816151125.11803-1-avarab@gmail.com>
In-Reply-To: <20180816151125.11803-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 17 Aug 2018 16:47:46 +0200
Message-ID: <CACsJy8AtoftZL7dKCL2qpKvGHHcSXKj057CU3aCACUqUMgMp-g@mail.gmail.com>
Subject: Re: [PATCH] completion: include PARSE_OPT_HIDDEN in completion output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, hadi@hadisafari.ir,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 8:42 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> The PARSE_OPT_HIDDEN is, per the documentation of the "option" struct
> in option parse-options.h, only supposed to affect -h output, not
> completion. That's what the PARSE_OPT_NOCOMPLETE flag is supposed to
> be for.
>
> Since 2e29dca66a ("completion: use __gitcomp_builtin in _git_commit",
> 2018-02-09) we've been using e.g. "git commit --git-completion-helper"
> to get the bash completion for the git-commit command. Due to
> PARSE_OPT_HIDDEN this excluded e.g. --allow-empty and
> --allow-empty-message.
>
> Now, this wasn't a behavior change in that commit. Before that we had
> a hardcoded list of options, removed in 2e29dca66a ("completion: use
> __gitcomp_builtin in _git_commit", 2018-02-09). This list didn't
> contain those two options.
>
> But as noted in the follow-up discussion to c9b5fde759 ("Add option to
> git-commit to allow empty log messages", 2010-04-06) in
> https://public-inbox.org/git/20100406055530.GE3901@coredump.intra.peff.ne=
t/
> the motivation for PARSE_OPT_HIDDEN was to keep the "git commit -h"
> output to a minimum, not to hide it from completion.
>
> I think it makes sense to exclude options like these from -h output,
> but for the completion the user is usually not trying to complete "git
> commit --<TAB>",

Actually I do :)

> but e.g. "git commit --allo<TAB>", and because of this behavior we don't =
show these options at all there.

And it would be great if these options do not show up at --<tab> but
do when with --a<tab>.

We already do something similar to this with --no-<tab>. So this could
be another option.
--=20
Duy
