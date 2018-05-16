Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324271F406
	for <e@80x24.org>; Wed, 16 May 2018 15:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeEPPYq (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 11:24:46 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39313 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbeEPPYm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 11:24:42 -0400
Received: by mail-oi0-f67.google.com with SMTP id n65-v6so1070230oig.6
        for <git@vger.kernel.org>; Wed, 16 May 2018 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J0zP/PZRpuOpP+uO9TH4oU1GCQ3CYz1A/Ncfg4tnTag=;
        b=Z1CvGDLNb1wm3l4LvHxReXg4brONTPo+4FfrnJrK8TQ31l7cBgVoUFqsbd2SgRVFZe
         yPqSsovsKVZvb0hQJUEjjqcm41+mAJOQJktVrJvLAN6F1z3iDJcFKf1sEgm6qxQoGmRR
         CdG+lxXYwcAkmTd0guPUzNJElfzxsZaJUvJsG+gID1EfO0PH/lXN4qAfxonDZvPTkSOV
         MqZKKfEnuG2bq/UIsK2XPXEBtqZd7MUNwPfEJK2w+80KtdfLXCW0JJ3u/GH1N53bSST2
         qq0U0F6Csj3Ln2DCexuWoFmABi8kzzJEbapkhQSeSzKqNrZ4RyVhFNLIkHRpD0IHTWuU
         Hgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J0zP/PZRpuOpP+uO9TH4oU1GCQ3CYz1A/Ncfg4tnTag=;
        b=sVn8eyHPyb/GdaaWCzYEZJiCYVvyN11HIS2WxWynufuzdpm7wkawyMITjnh9Q7N7m0
         grnj+9igUjB4wYs+ZiBdARKT3x7md764kyVwYlCwXlz2ygsH1/CzRIHaGGuRYR8+42E9
         3Xvjm3kYGf3U6/i8sis4Br46YNeb5XR/b70c6xHv0COEji9J4sebAf38Y3JRnd2YnLe/
         P+AnUKWdH0hyKoLBce7abmCLNGs5R+JXcrOrbDEYVCym7I1c+MrFS+V3yfdr8an4HGQW
         3kHfsrPHA0TyuHfVIASCWHMgD/aZAfeBMaNmn29+PMW4zwKn4aIGr7gUFdHue4GRIgm1
         7DKA==
X-Gm-Message-State: ALKqPwdfcbxO3czdae3wlrhLXVaGMhOJqcDrOWVZdKkiVmp17oxoIZhG
        5ohNm01dDRKbOY/Sk2FpXWoGxUEQETKb9U2uyqU=
X-Google-Smtp-Source: AB8JxZqL448Sra/crvTyYhPclMZny0ZTXCvs8Gt6qMr4aIDT4nhtts0DnfNndWvPRUYZsjoHOknnUQdFWKd9fBoK8/c=
X-Received: by 2002:aca:ce42:: with SMTP id e63-v6mr927577oig.34.1526484281640;
 Wed, 16 May 2018 08:24:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 16 May 2018 08:24:11 -0700 (PDT)
In-Reply-To: <CAGZ79kYYy-r+Zs_6yg1ZVRNsBcTUdPWE=FeHrp_=0cV0Uf_GfQ@mail.gmail.com>
References: <20180515010425.149200-1-sbeller@google.com> <CACsJy8AcG6zGa9vLCwm2B4ishyJVWdFQ2YV0FOZTor_0x8Q64g@mail.gmail.com>
 <CAGZ79kYYy-r+Zs_6yg1ZVRNsBcTUdPWE=FeHrp_=0cV0Uf_GfQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 16 May 2018 17:24:11 +0200
Message-ID: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
Subject: Re: [PATCH] grep: handle corrupt index files early
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Antonio Ospite <ao2@ao2.it>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 15, 2018 at 6:44 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, May 15, 2018 at 6:13 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, May 15, 2018 at 3:04 AM, Stefan Beller <sbeller@google.com> wrote:
>>> Any other caller of 'repo_read_index' dies upon a negative return of
>>> it, so grep should, too.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>
>>> Found while reviewing the series
>>> https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/
>>>
>>>  builtin/grep.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/builtin/grep.c b/builtin/grep.c
>>> index 6e7bc76785a..69f0743619f 100644
>>> --- a/builtin/grep.c
>>> +++ b/builtin/grep.c
>>> @@ -488,7 +488,8 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
>>>                 strbuf_addstr(&name, repo->submodule_prefix);
>>>         }
>>>
>>> -       repo_read_index(repo);
>>> +       if (repo_read_index(repo) < 0)
>>> +               die("index file corrupt");
>>
>> _() the string (and maybe reuse an existing phrase if found to reduce
>> workload on translators)
>
> sbeller@sbeller:/u/git$ git grep -A 1 repo_read_index
> builtin/grep.c:491:     if (repo_read_index(repo) < 0)
> builtin/grep.c-492-             die("index file corrupt");
> --
> builtin/ls-files.c:213: if (repo_read_index(&submodule) < 0)
> builtin/ls-files.c-214-         die("index file corrupt");
> --
> builtin/ls-files.c:582: if (repo_read_index(the_repository) < 0)
> builtin/ls-files.c-583-         die("index file corrupt");
> --
> dir.c:3028:     if (repo_read_index(&subrepo) < 0)
> dir.c-3029-             die("index file corrupt in repo %s", subrepo.gitdir);
> --
> repository.c:245:int repo_read_index(struct repository *repo)
> repository.c-246-{
> --
> repository.h:70:         * 'repo_read_index()' can be used to populate 'index'.
> repository.h-71-         */
> --
> repository.h:119:extern int repo_read_index(struct repository *repo);
> repository.h-120-
> --
> submodule-config.c:583:         if (repo_read_index(repo) < 0)
> submodule-config.c-584-                 return;
> --
> submodule.c:1336:       if (repo_read_index(r) < 0)
> submodule.c-1337-               die("index file corrupt");
>
> I think this is as good as it gets for using an existing phrase.
> None of them are translated, which I would defer to a follow up patch
> that translates all(?) of them or just the porcelains.

If you have time, yes translate them all. I don't see how any of these
strings are meant for script. If not, just _() the new string you
added is fine.

With a majority of call sites dying like this though, I wonder if we
should just add repo_read_index_or_die() with die() inside. Then the
next person won't likely accidentally forget _()

>
> Thanks,
> Stefan



-- 
Duy
