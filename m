Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFAA2202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 21:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbdIVVlJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 17:41:09 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:55020 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbdIVVlI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 17:41:08 -0400
Received: by mail-wr0-f172.google.com with SMTP id g29so1800350wrg.11
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mDwWKsw08cKlxxwxaVSFODvPSoBWt5VdtomJbKzkd3U=;
        b=sGOzF7Sd67FGAP1wimh9nuAxc0yqxojZg1sixR9z7dEVp6flwVNJD+a0AJ+2R8hKAJ
         aCoL+CBdij5PFKOwiVKLN4qoGpp1AS8ARQRLIRHeUzFlb7BhZSWPpItujJdgYbfUoA+s
         PG0YyLBsXOUPZO1JuwSIuLEUtQ36kHCjAva5zOblow0zbzpzgzGqzr1e7KAw2/U2jVVR
         WdU2YXLpIk9mV5Q8ob6BtGneVqNbmbv7ZIxGf41s/gRypMlZgEPf9e36C3waEMRPc9cc
         RclvqnBmdNsUahaiWmhOD6fOQOrE3S9TWVEczQ8mxY8H29yd3Tqfvd9A1hhkdRpEsuKo
         RBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mDwWKsw08cKlxxwxaVSFODvPSoBWt5VdtomJbKzkd3U=;
        b=uFMU7TvZz8LTIBG3WYSMEytTCT7dRB5OMphYfIzzsdACjjcZZ2SKE3qh5ILn2nB/U+
         VTV0JAg8GP5P6Evwk0N57k5vsFCfCW79Ijc/l8QBcx9gxh4/9xPKQwoyzLBIhBZvhd7i
         Y6lashSSQXGqN6C+ySfIvbJnS11TPeHY3aM2KYTuy5lnzEfJ616r1UcFfyeDxdfhy+XF
         RizFTfEB8Gdi3lOmQK9u/1Rl274HtXR4CW4hMZdc/GUwciavaKZ6jQwoLgdoHMlfMvYH
         nliN1AIgDd8GUC1cPpVBzATlN6ees1SOjx2dLMnK8nx4jlOek51IOW994b58fFaylqZl
         dicA==
X-Gm-Message-State: AHPjjUgJ92idk+jGVJuH2VTVdsa4Q23JszPyWLzIxfiYVoE5R5Jd1yD2
        JygdFLEhS6J8mhL/tNbtIyeUvvaKPPv54ABxw9mnpg==
X-Google-Smtp-Source: AOwi7QCrp5uMyPgnnziXqPUBuRY9136rlzSBrnTRwadFclI0ES87l6FiXVPV6n1/JuNomzEUpclZV5DdCGyZI8ZCT3c=
X-Received: by 10.223.130.166 with SMTP id 35mr343733wrc.249.1506116467245;
 Fri, 22 Sep 2017 14:41:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.178.131 with HTTP; Fri, 22 Sep 2017 14:41:06 -0700 (PDT)
In-Reply-To: <20170922212525.kxldygbjrmjqu7ci@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <7a2d895c-df8c-1305-234f-7f8e2b271ec2@kdbg.org> <20170922042539.fs37bauiabfqcjx5@sigill.intra.peff.net>
 <CAGZ79kaUTdFi5LkgR6zKeb+CH8vpfPQRZf6bFqRfYY-YXy_TNA@mail.gmail.com> <20170922212525.kxldygbjrmjqu7ci@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 22 Sep 2017 14:41:06 -0700
Message-ID: <CAGZ79kYJH-4qb5hiT1C_aCFXLcdiJs5h+Z7Goz4trp52C5s3Lw@mail.gmail.com>
Subject: Re: [PATCH] git: add --no-optional-locks option
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2017 at 2:25 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 22, 2017 at 01:09:32PM -0700, Stefan Beller wrote:
>
>> On Thu, Sep 21, 2017 at 9:25 PM, Jeff King <peff@peff.net> wrote:
>>
>> >
>> > But imagine that "git status" learns to recurse into submodules and run
>> > "git status" inside them. Surely we would want the submodule repos to
>> > also avoid taking any unnecessary locks?
>>
>> You can teach Git to recurse into submodules already at home,
>> just 'git config status.submoduleSummary none'. ;)
>>
>> It occurs to me that the config name is badly choosen, as it stores
>> an argument for git status --ignore-submodules[=mode]
>
> Ah, thanks. I _thought_ we could already do that but when I went looking
> for the standard --recursive option I couldn't find it.

Thanks for checking for submodules there.

I personally prefer --recurse-submodules despite the longer name,
because a plain recursive option can mean anything in a sufficiently
complex program such as Git (recurse into the tree (c.f. ls-tree), or
for the algorithm used (c.f. merge, diff) or yet another dimension
I did not think of).

> So yes, I would think we would want this option to apply recursively in
> that case, even when we cross repository boundaries.

Regarding the actual patch which is heavily aimed at coping with IDEs
despite the command line being used, I wonder how many IDEs pass
--ignore-submodules and recurse themselves (if needed). Reason for
my suspicion is [1] which does pay attention to submodules:

>    Our application calls status including the following flags:
>    --porcelain=v2 --ignored --untracked-files=all --ignore-submodules=none

[1] https://public-inbox.org/git/2bbb1d0f-ae06-1878-d185-112bd51f75c9@gmail.com/

There might be another option to cope with the situation:

 4. Teach all commands to spinlock / busywait shortly for important
     locks instead of giving up. In that case git-status rewriting
     the index ought to be fine?

Thanks,
Stefan
