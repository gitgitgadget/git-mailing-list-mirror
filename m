Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038B420248
	for <e@80x24.org>; Tue, 12 Mar 2019 11:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfCLLGW (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 07:06:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38021 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfCLLGW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 07:06:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so2201325wrm.5
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 04:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oL5WT6fQYzctNUiJleGaCFicnL8KpKdnMALTwUWRBn8=;
        b=gLR0GzxV5RSiiOc8mOCUiQapBwR5pRNX1KrsU9wLB9s8jWV+Ke1n++nwUZuyMess17
         1eCMDF11KbXDDzBsCpdXUF5s85EiVcGn5hS/2ggMcPsOToobMv7Y257213aZqYLNqGHl
         obzxkvRU/LdWhiXMpTLjXuQbGZViuDp34pLYq/olVIf8oWxJHCaq2M6M+MBxL7tfYl2h
         wGq6pNOEGa0D/8YaVJSSM/Pb/nghy+X+9Z7vaDjkt22iNfdH4ISW+7K599KtEWvNfixp
         FxfwKa/XsTJ1WIBy5AK9haT4SUPb6k1jGp33hyDzZyV54oAh6ijxRmAwyq2Jwe2l+iWj
         a16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oL5WT6fQYzctNUiJleGaCFicnL8KpKdnMALTwUWRBn8=;
        b=It653oO4JO6uOKkhnSSdFVSvXe9XG0T4HwZJMWE0LrFmZbMntNM75q+Cj88zYinMd/
         FpZGeNEHt7/sEqEYQznTr2mdw4CAzSpEwmlONJ/mtNtJ9bb51TfUD7fMLIFd+Gr6+RF2
         ztoKlQ82VUwnTAW7DGzCRFwHPq2XEOx/NWYjiyK55vMmgS5e1dx43DbHorVhBf6wTC3M
         nOWOknQxQwvSCg1d49iMv/wW02MXehc9Se+secZELongMW3IINKpUfsbOT6lFP5ZVXLV
         uBd0+ovqFb44fWfNkzJMzUUhRhkp44gY1eaK7bUOk33g96vrlkyo9QOyjnAFJD73Elw1
         oVQQ==
X-Gm-Message-State: APjAAAUciko650+v2vSGnxUDQX5giDmm5brN260hfPV41r7/EhpntiLn
        WMOShhkH0vclcBF8PUYAsy4=
X-Google-Smtp-Source: APXvYqw0iB0dWtqK4DSRQgm0UVT5a5XQCt3GjvlBpeWGvCM4KK+ICjQG+bMj8R4UmVkoF+iVf50v3g==
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr10416261wrm.209.1552388779866;
        Tue, 12 Mar 2019 04:06:19 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-27-66.as13285.net. [92.22.27.66])
        by smtp.gmail.com with ESMTPSA id a9sm926270wmm.10.2019.03.12.04.06.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 04:06:19 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command
 'switch'
To:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com>
 <CABPp-BEBudobnduipQrSvyQWQ7Hb4WmmoptCQ+FyY8BRPp7_ZA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ca6f8e4b-d60c-877c-52e7-fb91c99cd3a5@gmail.com>
Date:   Tue, 12 Mar 2019 11:06:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BEBudobnduipQrSvyQWQ7Hb4WmmoptCQ+FyY8BRPp7_ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 11/03/2019 17:54, Elijah Newren wrote:
> A few other comments that I thought of while responding elsewhere in
> the thread that didn't make sense to include elsewhere...
> 
> On Fri, Mar 8, 2019 at 2:00 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>>
>> +-m::
>> +--merge::
>> +       If you have local modifications to one or more files that are
>> +       different between the current branch and the branch to which
>> +       you are switching, the command refuses to switch branches in
>> +       order to preserve your modifications in context.  However,
>> +       with this option, a three-way merge between the current
>> +       branch, your working tree contents, and the new branch is
>> +       done, and you will be on the new branch.
>> ++
>> +When a merge conflict happens, the index entries for conflicting
>> +paths are left unmerged, and you need to resolve the conflicts
>> +and mark the resolved paths with `git add` (or `git rm` if the merge
>> +should result in deletion of the path).
> 
> Now that Phillip highlighted issues with -m and -f, it's hard not to
> wonder about other corner cases.  For example, what if the user made
> some changes, staged them, then made more changes, then tried to 'git
> checkout -m <other branch>'?  That's no longer a three-way merge, but
> four way.  How does that work?  Does it just rely on merge-recursive's
> (poorly defined) choice of when to bail out and when to permit such
> craziness?

If the two-way merge fails then it does 'git add -u' before calling 
merge_recursive(), then any merged paths are reset to the new HEAD 
(which throws away newly added files, it should keep anything that is 
not in HEAD or HEAD@{1}). So any staged changes are lost.

>> +--orphan <new-branch>::
>> +       Create a new 'orphan' branch, named `<new-branch>`, started from
>> +       `<start-point>` and switch to it. See explanation of the same
>> +       option in linkgit:git-checkout[1] for details.
> 
> Sigh...does this mean --orphan will remain broken?  It has always
> driven me crazy that it leaves you with a fully populated rather than
> an empty index.

I've always thought that was weird.

> It seemed broken to me before I figured out the
> special usecase,

I haven't figured it out yet - what is it?


Best Wishes

Phillip

> though it still seemed like the wrong default (an
> empty index wouldn't surprise due to the "orphan" name, but a full one
> does to those without the special usecase in mind).  Oh well, that's a
> much smaller battle than the big picture of getting switch and restore
> in place, and I don't want to derail the bigger picture; anything
> using --orphan is a somewhat special case anyway.
> 
>> +You can give the `-m` flag to the command, which would try a three-way
>> +merge:
>> +
>> +------------
>> +$ git switch -m mytopic
>> +Auto-merging frotz
>> +------------
>> +
>> +After this three-way merge, the local modifications are _not_
>> +registered in your index file, so `git diff` would show you what
>> +changes you made since the tip of the new branch.
> 
> ...even if the local modifications were registered in the index file
> before?  Is this why Phillip's "x" was missing and how it avoided
> doing a four-way merge?  I guess it kinda makes sense, view from this
> angle, but I'm not so sure I like it.  Hmm....
> 
