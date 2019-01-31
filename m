Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B03A1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 22:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfAaWkZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 17:40:25 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:35558 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfAaWkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 17:40:25 -0500
Received: by mail-ed1-f53.google.com with SMTP id x30so3946823edx.2
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 14:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+Kaz4qSTMr598yayMHCY9udRvBY6A1P1dmBegGSSYBI=;
        b=inr6hqFVQn6C89HJa5Ymz7x61djtDIxxIB8U3K4/GkwfcTZykefI3ximLaYW7aNPsj
         eNTurTkWHb7EO8ssCcoa0mtb92iGA7frPsxRcGv/Nnsd8LzhZyqW9tgpfjBi+IMC+zhS
         Ti0jSA9IrcEGcaCZiXTPn4t0F/jYSpvNsK8HQnz/ahga6BYxhyAokbew/X5qscL/+2jv
         VIb7r6GqVAogxp4s+PeT8eAwkVXI2Ti0HTaPOaR8V9RetDBL8kUr/cOkWE1OIIwTvL72
         lNr4M3n/eClwhvqlw1DGqUv+wS9mRAJUSPD+NyQHcFMgwCjHyOMkcLXIkb1b35M/txAQ
         Z5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+Kaz4qSTMr598yayMHCY9udRvBY6A1P1dmBegGSSYBI=;
        b=ASY3QVKViPDoJC3Rxu94wHQcXXg3iXu3oJ3PGjx5Z8VISYYZO/GpguQ/eZbGyF7GsY
         24CtTgNbE7ivLkqvkgfGqVZFZSN8PjWPyhx0BO8Dk9GIPXJWW1EDN43ni/Vx5LYM09uj
         ZV59yriUjv5fuajmGt4+MhgEsw3iRiqQus435r5/EeoYF6QM8nlrQex85aZWC/XV/gHM
         2fBWHOirM/O77otqibIeDI0mKFq56IDbgOTSJlkAVWMn3HtlkRmZWbm86rU2Hq3weQNC
         kSHUZIeUXxe+F7RDKlFm93AQU+PTehL58gn9cjpGEpan8OU8fVyMXH8qRIERTlkfxFE9
         Q84Q==
X-Gm-Message-State: AJcUukdaDUGEEE4oYxftr6+Is5eySIW1zDBREdzY8wBCpuhqeyu/V73u
        ZROrQU3rJHY3AnsQ3mUMRAg=
X-Google-Smtp-Source: ALg8bN7GTFDVWCWN6C42k68jRuoBOMCVrfZ/WAyArz74tvwU51hVMr6TT/o3fpF7qSER6XX9jCToEA==
X-Received: by 2002:a50:9a01:: with SMTP id o1mr36978429edb.82.1548974423106;
        Thu, 31 Jan 2019 14:40:23 -0800 (PST)
Received: from evledraar (ptr-a4kmumi3cjyxp9zp488.18120a2.ip6.access.telenet.be. [2a02:1811:5182:c100:ea6c:e022:ac1f:78a8])
        by smtp.gmail.com with ESMTPSA id n11sm1597912edn.14.2019.01.31.14.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 14:40:22 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Cathles <rjc.live@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git annex possible bug
References: <CANny=+C+yj6J0P-W91kR2ehxLcT44pMOCzg=u+gpEiiCpQLaHg@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CANny=+C+yj6J0P-W91kR2ehxLcT44pMOCzg=u+gpEiiCpQLaHg@mail.gmail.com>
Date:   Thu, 31 Jan 2019 23:40:21 +0100
Message-ID: <87tvho30yy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 31 2019, Robert Cathles wrote:

> We use git annex and found an issue where one machine that had run
> 'git annex sync' and 'git annex sync --content' was not reporting any
> issues, but any other machines were report 99 issues when running 'git
> annex get'.
>
> The message for each file was that it was not known to exist on any
> repo. doing some searching I found 'git annex fsck' so ran that in the
> following fashion on the 'broken' machines: 'git annex fsck
> --from=LocalMirrorName --fast'. During this we saw git was updating
> the location log for nearly all the missing files. Running 'git annex
> get' afterwards resolved the issue and got the files. We found we had
> to repeat this on all affected machines.
>
> The machine that did the original sync was running git 2.7.4 and other
> machines were either running the same, or 2.17.1.
>
> A test I also tried: I copied one annex file from inside the .git
> folder of the original machine that ran the sync, and added it to the
> same location on a broken machine, then ran sync and get, and it
> reported 98 issues instead.
>
> Does this seem like a bug with git annex? Is there a possible gap in
> the way that git annex reports that all is fine - perhaps to do with
> the index? Or does this seem to be more likely an issue we created
> ourselves? Would there have been any other commands we could have run
> to resolve this issue or should have tried out first? (Apart from just
> deleting each of our clones and starting again)

This may be a bug in git-annex, or not, but in any case you've reached
the wrong people to ask. The git-annex tool is not part of git itself,
it's a third-party plugin.

You'll probably want to file a bug here:
https://git-annex.branchable.com/bugs/
