Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DE51F453
	for <e@80x24.org>; Thu, 21 Feb 2019 17:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfBUR4s (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 12:56:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41411 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUR4s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 12:56:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id n2so19450587wrw.8
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 09:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=D3FpEWDK7ODchfs8rk3Ns5KXZGzbbZcK4eWBppD3hhg=;
        b=iSbVwFpN44Eh2Yqr6vJ/NF8i50KvQtUWgHsnXPaTo30CYkVjjDN3dx3Ou/aaXFcxCw
         jVNq1lArmLnN8pjntsdJ3liIZ6ZXyDuCTR2WMCzD/xlTagcxib6otVqhiinx3l3lNvhm
         azLNlETHaS/n2ewSm8VHQSuHuLHR3j0JoNCG60CwoDAIYtWmnRmGyVvMb3zdh68uHpNn
         zCgSMkzY5Qzef4JTNh9djh5zhESpu3dC1v/lFhdSmiNH7FLmXUCYnL6uJs7Zuoglp9rN
         9QokzJ/SU++SX3SRdsXfXrhAHhm2xg7B7S1w2tGFfeybA7mal/RW2mYnUeosqf6O492m
         vS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=D3FpEWDK7ODchfs8rk3Ns5KXZGzbbZcK4eWBppD3hhg=;
        b=s5ZcUlh+rZDYDQVekOfE8VLBLYY4MSDszKcY7K3cYEPkUdgef0de05PG+GszzdG6UP
         GyPY3lUCv1mZ4kGwmV6RIS5nPxxWXLghgArEzE38C4T+bukgL+4M4CKAn1WpQPVLH1BG
         RBIrXCZZ4RwpwPVTHM4Li1HflkeochLEUwnFb5AO17CHkPaU2N5C/KxWDKld0FywExfV
         ltEEQXoE5pXPYuS9UWuLmk8r4GpTPGzYco0ni5YXAMCVfenGUA0XTglTUQsJiPRiEFRp
         YJyrDAhQkAk2L6n1GXejv4xzgIrDqu5pmpNparJEtj+5yuMuB1A2F4E8fL7tqGsz3Eg1
         IZZg==
X-Gm-Message-State: AHQUAubBLpmrs168ydIiW/BfzXn/6OZ8csvEaV0axtnmxcaAMSmrdfy/
        J/b1J2vAaHeDjmSs4WX4S4s=
X-Google-Smtp-Source: AHgI3IbDLuiMVkqyOD8va3O8i+EDe8Vd3huKuaw2MqwmbXIPRsaEW2V+wIl2Nizv7gjjha+ZkWQYPg==
X-Received: by 2002:adf:ba84:: with SMTP id p4mr29709621wrg.156.1550771805792;
        Thu, 21 Feb 2019 09:56:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f68sm16676556wmg.5.2019.02.21.09.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 09:56:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: Re: [PATCH v5 02/10] add--helper: create builtin helper for interactive add
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
        <304c3863b123e08536412019e881967bf01dc4a4.1550662887.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Feb 2019 09:56:44 -0800
In-Reply-To: <304c3863b123e08536412019e881967bf01dc4a4.1550662887.git.gitgitgadget@gmail.com>
        (Daniel Ferreira via GitGitGadget's message of "Wed, 20 Feb 2019
        03:41:29 -0800 (PST)")
Message-ID: <xmqqzhqpt483.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/git.c b/git.c
> index 2dd588674f..cb42591f37 100644
> --- a/git.c
> +++ b/git.c
> @@ -444,6 +444,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  
>  static struct cmd_struct commands[] = {
>  	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> +	{ "add--helper", cmd_add__helper, RUN_SETUP | NEED_WORK_TREE },
>  	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
>  	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
>  	{ "apply", cmd_apply, RUN_SETUP_GENTLY },

When adding a more complex replacement command we often cannot write
RUN_SETUP nor NEED_WORK_TREE here and instead do the job ourselves
in cmd_ourcommand() the hard way.  But because this one is only for
helping "add -i", we can let the git.c::run_builtin() aka "git
potty" do the hard part, which is very nice.

Makes sense so far.

Thanks.
