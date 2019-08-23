Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B673B1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 12:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfHWMCE (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 08:02:04 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:37501 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730867AbfHWMCE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 08:02:04 -0400
Received: by mail-qt1-f182.google.com with SMTP id y26so10922499qto.4
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 05:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/zxYeH1sS0smPh56pWyzo6bOykdni+WetKPVzGHrhQY=;
        b=C3djTYbkZKp/mwSLzHYSmLFdxbXEbnMqIU/vsr4UnkiLTCJP4ylGfWEcm+2n4fcb8m
         ziFR/HHSKjL9iIE1jSGyN+uVHGtBMT6vSRkuthC/+u/fDES9k4BQUAxMJTBegtLAWLzi
         jUgt2lGloCkmYLWGnRYzRctesZA29m9pFJoXph4HI78B6Y3ZJwbPABSMHepaB6tr3+v2
         YJ7UJ2fTBsUrTubeQU1Y8byrLeTr5o1CFYjR33IAlGAg4vD8osN2uDzQTjlk5TmgSXzm
         xSXSpRV7uP+EkzGKmiz/FFyaz1b32oo2+7FpYTsmgfs16ZtP1vjUL7Evgemrv5oDuw0x
         0XSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/zxYeH1sS0smPh56pWyzo6bOykdni+WetKPVzGHrhQY=;
        b=X/PqMYrSYf/eQcwyd9oQGqo9Nzfjx9kwHs4rvm89YAqRyYpprR/BKP6ijfD3bqzBfX
         yomZWHmEIzf+qw9fKr3BXTfcLc03pLJo3AlzcdQWAUWFCv+sICkmyZDHkmZ4b4fBDaqW
         9dFL4VXNSik0qsgLjeJWR0AhWB4wtfHO6+IeF83hjuyVHpjb0qz+gKTKFB9t9EFPgMi0
         wRGYTRgcqVTtI3j/vjNidU48OszxPdFU8JzWdUs4lBCEDtliDNR3xrnpYAqZrp57Ti/H
         BF8Jg4fE7O7zDcwfQSccvrHsWyfV5mTR+eytr68GgnJaBZyEXUbro+TMkfgeNZ1EAwgG
         0wGQ==
X-Gm-Message-State: APjAAAWbDjLclv5V/REas6pZdDhB2uunKdd3Q2jCjuePS1wZ/8AnCImY
        v65IZ20NRAvHpoBA7PmHNYYchr4bPWGNeQ==
X-Google-Smtp-Source: APXvYqy+TH7t+vmUJSRXTfi3Y8rlg0SpKAU0rfkys2RCvPpNU5tBC24V1JahLH49DrWZcTXPU2oI7g==
X-Received: by 2002:ac8:2df8:: with SMTP id q53mr1222573qta.234.1566561723407;
        Fri, 23 Aug 2019 05:02:03 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:15df:50c4:43d1:68bd? ([2001:4898:a800:1012:c712:50c4:43d1:68bd])
        by smtp.gmail.com with ESMTPSA id p32sm1398369qtb.67.2019.08.23.05.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 05:02:02 -0700 (PDT)
Subject: Re: RFC: Proposing git-filter-repo for inclusion in git.git
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_9skA@mail.gmail.com>
 <xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com>
 <CABPp-BFK65qL4GCs5bFuiPPYwMCDYrxMyYejacVS89d2GK4nDQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a784a61e-1320-be1e-9dfb-d533a01827ec@gmail.com>
Date:   Fri, 23 Aug 2019 08:02:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFK65qL4GCs5bFuiPPYwMCDYrxMyYejacVS89d2GK4nDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2019 5:12 PM, Elijah Newren wrote:
> On Thu, Aug 22, 2019 at 1:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> Questions, comments, or concerns with this proposal?  Alternative
>>> proposals?  If inclusion is acceptable, are there any other tasks that
>>> need to be completed first?
>>
>> I do not want a discussion to begin with a Devil's Advocate
>> response, but anyway...
>>
>> Are we planning to go to all batteries included approach?  I have a
>> feeling that there are other tools (hello, "git imerge") that
>> equally deserve attention by Git users; are we in the business of
>> absorbing them all?  How big a project will our tree become, and how
>> much more activity would have to be haneld by the readership of the
>> Git mailing list?
>>
>> I'd rather see us shed non-core tools we already have (e.g. git-svn,
>> cvs import/export) out of git.git and have them as independent
>> projects.  But that may be just me.

Yes please! Let's make the repo smaller.

> Ooh, if you're going to open this door, then a proposal I assumed
> would be shot down but which I'd be just about as happy with is:
> 
>   * Remove git-filter-branch from git.git.  Mention in the release
> notes where people can go to get it.[1]
> 
[snip]
>
> [1] We'd still have to decide where to put it.  If no one else wants
> to do it, I could include it in git-filter-repo with the promise that
> it's there for backward compatibility for those that still need the
> tool, even if I recommend folks use filter-repo instead.

May I recommend an idea, which may be silly?

We could strip these "extra" tools out of git.git and place them in
their own repos. The hope would be that they could build on their own
and have their own test suites.

Then, Git distributors could pick and choose the components they
bundle with Git. Dscho would know more about this sort of thing as
he distributes MinGit, which strips these things out already.

The biggest question is: how do we make sure that as git.git moves
forward that we don't break the ecosystem? Maybe we create a new,
larger repo that contains all of these subrepos? This would give
the community more experience dogfooding our own repo-splitting tools.

Personally, I like the idea of 'git subtree' over something like
'git submodule'. Using 'git subtree' may mean that tools like
'git-svn' that may be hard to split into a completely independent
repo could live primarily in the meta repo with a source dependence
on the included git.git subtree.

This "meta-git.git" repo could then be more flexible in adding
new tools like git-filter-repo or even git-lfs and friends. Again,
distributors could select a subset to include, but we would have
one place to run CI builds and make sure the tools are not
obviously breaking as git.git updates.

Thanks,
-Stolee
