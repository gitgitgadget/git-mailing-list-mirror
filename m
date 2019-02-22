Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466741F453
	for <e@80x24.org>; Fri, 22 Feb 2019 04:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfBVExu (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 23:53:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33490 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBVExu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 23:53:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id h22so8058264wmb.0
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 20:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=sfzaNi8olj17vh4CaUCFrKcWbCRQQKjQJ70UB4sbpsg=;
        b=QBEfXJUE1Y1XPgMtHIhMQ0GQZUi2tgAQYWAP+WX32741Robj7a4YQHzhkMmmnWkWkf
         +viShKRm1iXRdPq9FTcY0yXwLBOyVR1FokdVvWqoKvzapbY8S0Rhjz7JL4HcLMa/4HBm
         r3jV0z+lLPzhz/S9crk7JweigcS89QWC7w2aeexndBEeTM1NyypXaDLkYGRo9C64XbQ5
         APWZ5SwRmFwAyNvWd2yop/u+rSlSLzHm2Ui5Zv+arsqqi7L4nrqKMQeip3I16VhOCu9C
         yeioPgVTI06BmVAc5jC49ede938CAgfG7A+33rayB3q9D3TdYcHZ4qxw4J1harlb5WFq
         SXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=sfzaNi8olj17vh4CaUCFrKcWbCRQQKjQJ70UB4sbpsg=;
        b=ah2DDp0yfzyvB73TNZZ3DtQ8HOwuYEXM3bngkiA9V5MrfKtiBQbF+yGY/c7bDbHlI8
         u5IvPxovyOzny+trYY+YzzAMFLdlx9bi/5lCt08ENbwx5cBMf8ZibFt7ZOaRXnGe+2Aa
         Su6XoHgBBi2SfGaybJL5leZ7QIYSqmYqUEXSyJMrJNo9qOpU6x1kWQB+5YmxAOHzsVQI
         /KKgXpG3YwO3P4mGYKiX+T1BO6TFZaFaJApQjsmh9cJIR9Edz2aewHt6YuTnQG6r4IRE
         E+upIKCYBZ4DTTb6NiGuLrSL0aInTXt7nm0imDkzfMzZAYub0PvaGOEp56f4T5SbwiOt
         AmGQ==
X-Gm-Message-State: AHQUAubmZHXi+NxiUyg3cPmTlRG4Ktw1EhQZLDtAiDdaXYqVKFHirsI4
        MMveGraKK0XMX14v3/UQiy0=
X-Google-Smtp-Source: AHgI3IaSoMLxZZRUcGOzIdEA80z040VRbzje7BXhlX8C7SE1dXprm2JARekHgH2/EOEV6WJBufNR3A==
X-Received: by 2002:a1c:a58c:: with SMTP id o134mr1049456wme.79.1550811228377;
        Thu, 21 Feb 2019 20:53:48 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o18sm1531684wrg.40.2019.02.21.20.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 20:53:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Slavica_=C4=90uki=C4=87_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 00/10] Turn git add-i into built-in
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Feb 2019 20:53:45 -0800
Message-ID: <xmqqef80s9t2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Slavica Đukić via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> This is the first version of a patch series to start porting
> git-add--interactive from Perl to C. Daniel Ferreira's patch series used as
> a head start:
> https://public-inbox.org/git/1494907234-28903-1-git-send-email-bnmvco@gmail.com/t/#u
>
> Changes since v4:
>
>  * rename print_modified to list_modifed
>  * the big change was implementing list_and_choose, which resulted in code
>    refactoring, i.e. separating list_modified and status_cmd and making
>    status_cmd use both list_modified and list_and_choose
>  * implement struct choice instead of struct stuff_item as main data
>    structure for list_and_choose
>  * introduce list_only option and implement support for !list_only users
>  * introduce highlighting of unique prefixes
>
> Note that authorship handling is slightly changed. In some of the commits, I
> used Original-patch-by instead of listing Daniel Ferreira as author.

Sounds good to me.

