Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C601F453
	for <e@80x24.org>; Fri,  5 Oct 2018 08:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeJEPOy (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 11:14:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40074 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeJEPOy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 11:14:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so8150680wro.7
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 01:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=NCewh7Q0RD0GmeMhw+NZEDeMwpbvH/FC5NXPYQkFlFg=;
        b=noeM5H0q439nOVHamKIQ5o6RWrsz3wIynhl4OsyfyUeR86MRAitQbWc393nexAPSEa
         NHPQNTFoFc92CBpElKQANJt9HCTx/37F00Y5VcNEGcM0VfHR6SgkqzRgrJY96/9m6Pbb
         2/TASf0DbT39C8UiXhwIQjTiSx9f/wBm680xLuA0RVINgm69/CVLZF8pWuxgVvUAmELF
         CIZ3uIl2cTqX19FhjUU2yGOz4/bByP4noeTBSfLlKpwmf5i6uyllKSSyxfqXSwSM3bJ1
         sioL5OHcmnMJLAiJL4jqR4Kpwwg3fHe5i8MjNsQpy+ztbuyPzjZ0osyvPvOiCRtKBtB5
         zCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=NCewh7Q0RD0GmeMhw+NZEDeMwpbvH/FC5NXPYQkFlFg=;
        b=IAnM7nkvlMwOs+4nGrGn22nfwOLAvmqu4H3VYQ020WZKmkPTSTM2lUgEZDliW4W+cs
         ZKbzbvz1xChi+cjWmLcGz/W+3rvh02acQz/Jrd74CQXqlH86Yc5Bay6wnHXJWkeKN8gJ
         FxE18eDx/hvaoxYed+Ov/3qygf9osAjugheAqB2+FCKZgFTQOFBZRMkjp+tmN+Ys1Nuh
         Ld0Gq88ncBhpgY/rN2bMNx1G4d+xG2iSxcqq68VOgYFyCdQ/IdrwSkGyzarV/pgKf021
         nVnLsOT94bsHOnZfyA4SNDyLnWrMI9iG1bOfdX6YOch4p96XMwsbCbf17zF0dokx4WVR
         t9MA==
X-Gm-Message-State: ABuFfojrNdcqKTZGOajHibPOExpibaJCuX6pFGjDFWtDKAHHEGUaWY/f
        lcEI9GDZk41rEbqQQSbY2Uj5P4vrghI=
X-Google-Smtp-Source: ACcGV61YfQ8E5glNVCreTsyTTsqZFgLXHcCmLD+/vIoBYeJwgxJ6kSAX42podiNfEoWLCvrP+9+QuQ==
X-Received: by 2002:adf:8523:: with SMTP id 32-v6mr7740453wrh.72.1538727436097;
        Fri, 05 Oct 2018 01:17:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v1-v6sm6303149wrd.24.2018.10.05.01.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 01:17:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Christoph Berg <myon@debian.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] grep: provide a noop --recursive option
References: <20180929140132.GA31238@msg.df7cb.de>
        <20180929145527.23444-1-avarab@gmail.com>
        <xmqq8t3k9qjs.fsf@gitster-ct.c.googlers.com>
        <ffc574a9-cf78-2dd5-084a-a6005547d363@web.de>
Date:   Fri, 05 Oct 2018 01:17:14 -0700
Message-ID: <xmqqmurszu2d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>
> Recognize -r and --recursive as synonyms for --max-depth=-1 for
> compatibility with GNU grep; it's still the default for git grep.
>
> This also adds --no-recursive as synonym for --max-depth=0 for free,
> which is welcome for completeness and consistency.
>
> Fix the description for --max-depth, while we're at it -- negative
> values other than -1 actually disable recursion, i.e. they are
> equivalent to --max-depth=0.
> ...
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 601f801158..f6e127f0bc 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -811,6 +811,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  			GREP_BINARY_NOMATCH),
>  		OPT_BOOL(0, "textconv", &opt.allow_textconv,
>  			 N_("process binary files with textconv filters")),
> +		OPT_SET_INT('r', "recursive", &opt.max_depth,
> +			    N_("search in subdirectories (default)"), -1),

Wow.  

I didn't think of this trick to let OPT_SET_INT() to grok --no-* and
set the variable to 0.  Being able to do this without a custom
callback is certainly very nice.

The patch looks good.

Thanks.
