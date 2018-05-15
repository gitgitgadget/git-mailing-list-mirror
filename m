Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F366B1F406
	for <e@80x24.org>; Tue, 15 May 2018 16:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbeEOQoo (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 12:44:44 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36606 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbeEOQon (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 12:44:43 -0400
Received: by mail-yb0-f195.google.com with SMTP id o14-v6so281501ybq.3
        for <git@vger.kernel.org>; Tue, 15 May 2018 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9oC5pna7qlFY5VFGEJm3awEDpirlWtlwop2PxRm8SlA=;
        b=ZVD7TY5uE358wZLHkkHG1SGjak3EmcM/Y92yg3AVCi/HYPyYCCKUp4yXw59+WGiA91
         K2BUF7GKpFLSmXwsrjrVQ6wxeNfjRmD0lH/qoLWeOuMTipDD0mAPu91nyaLDBnuB2qBw
         dIOBbVb8lHbUMB1tsJNPXRtuZBjLPIsLADXX6YPNDS2emdk0TwolIq/8gpDm0vH+80VN
         F3b2EjgoQ8pGHQ1TPuBq+oWg0PVNH9SqR91gFXxvEXqs2C4JOC+g2VnPIxTUFJ1V0waM
         4uA9PxoHWMeufbVKWTSfH2nxKHMgMPxxnMMCSOk7cUbEhxFjmvty1VWgY+IfNms0Gn1u
         PG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9oC5pna7qlFY5VFGEJm3awEDpirlWtlwop2PxRm8SlA=;
        b=FIq3LeYCtR3zEqIyTahvF9floyCvxl4pF48WWT9LCFMSojOO3OIpiHvqaavjpWcxEg
         mEhefCTaM/VWIyrYlB1P0udNdmCbh2rwnwSBjRi/0CinPku0uTwPnT/36QMC2uzv7m8T
         kG0skMhtR3jJhF75gWCFW9rv0k02Ehoo8ZOd6ituw25iY6k2y+ciS6y/Cow+qReZT5d3
         BWp0PC/UjXhqKJekhvRVhOU7eAkJgBzJsoqF/ti0+NAj6tmG9YqQsN1MIaumM0OKlVtJ
         y5aC0Sy643NE3fLC6bh7caxJsWvGFhNwjB4WgMKjyoLd8K8ZV2e1SQitJBNauWyyQ9pA
         YYtg==
X-Gm-Message-State: ALKqPwcyUl1wclEb0OOft9UZJa5hB06hUz37nu6bR7ueQ2MHdBW8r8v+
        PD81c3PqE7tWIoTglViHyU5JFenhoEsCMo6pZmH1RA==
X-Google-Smtp-Source: AB8JxZpM4tH141ILjVsms6Ys3FcVE0OPQCVeNAiCmmnDC2i9fZe5AozqWU/pD+KSC7Aude3mbwBEq3mvr6jsnruVeu4=
X-Received: by 2002:a25:3bc5:: with SMTP id i188-v6mr9347266yba.352.1526402682600;
 Tue, 15 May 2018 09:44:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Tue, 15 May 2018 09:44:42
 -0700 (PDT)
In-Reply-To: <CACsJy8AcG6zGa9vLCwm2B4ishyJVWdFQ2YV0FOZTor_0x8Q64g@mail.gmail.com>
References: <20180515010425.149200-1-sbeller@google.com> <CACsJy8AcG6zGa9vLCwm2B4ishyJVWdFQ2YV0FOZTor_0x8Q64g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 May 2018 09:44:42 -0700
Message-ID: <CAGZ79kYYy-r+Zs_6yg1ZVRNsBcTUdPWE=FeHrp_=0cV0Uf_GfQ@mail.gmail.com>
Subject: Re: [PATCH] grep: handle corrupt index files early
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Antonio Ospite <ao2@ao2.it>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 15, 2018 at 6:13 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 15, 2018 at 3:04 AM, Stefan Beller <sbeller@google.com> wrote:
>> Any other caller of 'repo_read_index' dies upon a negative return of
>> it, so grep should, too.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Found while reviewing the series
>> https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/
>>
>>  builtin/grep.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 6e7bc76785a..69f0743619f 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -488,7 +488,8 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
>>                 strbuf_addstr(&name, repo->submodule_prefix);
>>         }
>>
>> -       repo_read_index(repo);
>> +       if (repo_read_index(repo) < 0)
>> +               die("index file corrupt");
>
> _() the string (and maybe reuse an existing phrase if found to reduce
> workload on translators)

sbeller@sbeller:/u/git$ git grep -A 1 repo_read_index
builtin/grep.c:491:     if (repo_read_index(repo) < 0)
builtin/grep.c-492-             die("index file corrupt");
--
builtin/ls-files.c:213: if (repo_read_index(&submodule) < 0)
builtin/ls-files.c-214-         die("index file corrupt");
--
builtin/ls-files.c:582: if (repo_read_index(the_repository) < 0)
builtin/ls-files.c-583-         die("index file corrupt");
--
dir.c:3028:     if (repo_read_index(&subrepo) < 0)
dir.c-3029-             die("index file corrupt in repo %s", subrepo.gitdir);
--
repository.c:245:int repo_read_index(struct repository *repo)
repository.c-246-{
--
repository.h:70:         * 'repo_read_index()' can be used to populate 'index'.
repository.h-71-         */
--
repository.h:119:extern int repo_read_index(struct repository *repo);
repository.h-120-
--
submodule-config.c:583:         if (repo_read_index(repo) < 0)
submodule-config.c-584-                 return;
--
submodule.c:1336:       if (repo_read_index(r) < 0)
submodule.c-1337-               die("index file corrupt");

I think this is as good as it gets for using an existing phrase.
None of them are translated, which I would defer to a follow up patch
that translates all(?) of them or just the porcelains.

Thanks,
Stefan
