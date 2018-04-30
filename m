Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1251215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 14:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754035AbeD3OBv (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 10:01:51 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:44050 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753922AbeD3OBu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 10:01:50 -0400
Received: by mail-qt0-f180.google.com with SMTP id d3-v6so10953134qtp.11
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=H0dcN7AgCh1PfjwbHRee/TkommnTv7GxeLx0epvg6Ms=;
        b=HaFmBcZBFiQ3uyu9rceDOtv22cz4n/Kp7NNUngRDBSMpdY9Cl2wYrZ9tYSPzLALcRq
         GeTmmcRjiaknBq0q4Pzxr1HejOZngjxYadSFZ9zB2l7a7C9YnBvUZNMwI4BhL6e7C/P5
         4hSA57JIsc80zJblKA4wQlRKERRBqDJGXLsaDP5L4/gzDajpti3x4OyBGdG+0Aig/hoX
         SbP7W8+YrDkddwoLAgXmhr2rsEHY604Z1s5C2aopOnt0GbnW0dHL70xqC8M3l0seDGme
         SQMGvQ+MtYJ4n9nMT3qqVvpaPZAlmux+6GC6gT4oX18NQKzuD0tvDaxVPpq5Yj7+S/1s
         EPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=H0dcN7AgCh1PfjwbHRee/TkommnTv7GxeLx0epvg6Ms=;
        b=gzSKbWqnCWgFuh85wPMaotFJCpa4NvMfm2Y/GGQtq+FXk7hLeSCV0omvQct3OBkKCk
         D0C8BmCK+GY0S21XTNvBsPxZZrpJTG2/temXSiAz3vl9xK3mCYcosSWUW4VqX9w+j348
         VUsX1YwHIN7UvjoBLFtqqZNGRcvPkJeI1v8jlAkiyfqdWF3x5o8rCISMGf0MUE0StXek
         E13HHYaSxpkcgq7L7RROmF5ZHdWhjd4ydLsnpw71GHvCx2mpWgvWFxuJTWPtQJwLugOD
         9N1+gyXRh3OFsBotLQ0SfKU1F8Bl8X/8PXm/4UbucYOXzRULFC8EvLk0O9KkgpUjvNRx
         JGxg==
X-Gm-Message-State: ALQs6tC1nU2EEh+KODNSpwPNtciEwQxmsjbZhLJWQGXgIcmdIUqH8Uct
        n8kUP0lPWkCKEA5LS1g9cAMsermE
X-Google-Smtp-Source: AB8JxZpvFRLq/KvuJbnC6cDmIpGPotKqUAhz/+jDlh48H6Vu/0+iqpfqCzZDI8gsE9KnFh7enRLa9w==
X-Received: by 2002:a0c:c90b:: with SMTP id r11-v6mr8472232qvj.202.1525096909141;
        Mon, 30 Apr 2018 07:01:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id y41-v6sm5896261qty.84.2018.04.30.07.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 07:01:48 -0700 (PDT)
Subject: Re: branch --contains / tag --merged inconsistency
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Ferenc_W=c3=a1gner?= <wferi@niif.hu>
Cc:     git@vger.kernel.org
References: <20180427160344.12724-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f73a956d-2782-11b3-f84b-67ce1e0ae047@gmail.com>
Date:   Mon, 30 Apr 2018 10:01:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427160344.12724-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/27/2018 12:03 PM, SZEDER Gábor wrote:
> Szia Feri,
>
>> I'm moving the IRC discussion here, because this might be a bug report
>> in the end.  So, kindly try these steps (103 MB free space required):
>>
>> $ git clone https://github.com/ClusterLabs/pacemaker.git && cd pacemaker
>> [...]
>> $ git branch --contains Pacemaker-0.6.1
>> * master
>> $ git tag --merged master | fgrep Pacemaker-0.6
>> Pacemaker-0.6.0
>> Pacemaker-0.6.2
>> Pacemaker-0.6.3
>> Pacemaker-0.6.4
>> Pacemaker-0.6.5
>> Pacemaker-0.6.6
>>
>> Notice that Pacemaker-0.6.1 is missing from the output.  Kind people on
>> IRC didn't find a quick explanation, and we all had to go eventually.
>> Is this expected behavior?  Reproduced with git 2.11.0 and 2.17.0.
> The commit pointed to by the tag Pacemaker-0.6.1 and its parent have a
> serious clock skew, i.e. they are a few months older than their parents:
>
> $ git log --format='%h %ad %cd%d%n    %s' --date=short Pacemaker-0.6.1^..47a8ef4c
> 47a8ef4ce 2008-02-15 2008-02-15
>      Low: TE: Logging - display the op's magic field for unexpected and foreign events
> b9cfcd6b4 2007-12-10 2007-12-10 (tag: Pacemaker-0.6.2)
>      haresources2cib.py: set default-action-timeout to the default (20s)
> 52e7793e0 2007-12-10 2007-12-10
>      haresources2cib.py: update ra parameters lists
> dea277271 2008-02-14 2008-02-14
>      Medium: Build: Turn on snmp support in rpm packages (patch from MATSUDA, Daiki)
> f418742fe 2008-02-14 2008-02-14
>      Low: Build: Update the .spec file with the one used by build service
> ccfa716a5 2008-02-14 2008-02-14
>      Medium: SNMP: Allow the snmp subagent to be built (patch from MATSUDA, Daiki)
> 50f0ade2d 2008-02-14 2008-02-14
>      Low: Build: Update last release number
> 90f11667f 2008-02-14 2008-02-14
>      Medium: Tools: Make sure the autoconf variables in haresources2cib are expanded
> 9d2383c46 2008-02-11 2008-02-11 (tag: Pacemaker-0.6.1)
>      High: cib: Ensure the archived file hits the disk before returning
>
> (branch|tag|describe|...) (--contains|--merged) use the commit timestamp
> information as a heuristic to avoid traversing parts of the history,
> which makes these operations, especially on big histories, an order of
> magnitude or two faster.  Yeah, commit timestamps can't always be
> trusted, but skewed commits are rare, and skewed commits with this much
> skew are even rarer.
>
> I'm not sure how (or if it's at all possible) to turn off this
> timestamp-based optimisation.

This is actually a bit more complicated. The "--merged" check in 'git 
tag' uses a different mechanism to detect which tags are reachable. It 
uses a revision walk starting at the "merge commit" (master in your 
case) and all tags with the "limited" option (to ensure the walk happens 
during prepare_revision_walk()) but marks the merge commit as 
UNINTERESTING. The limit_list() method stops when all commits are marked 
UNINTERESTING - minus some "slop" related to the commits that start the 
walk.

One important note: the set of tags is important here. If you add a new 
tag to the root commit (git tag MyTag a2d71961f) then the walk succeeds 
by ensuring it walks until MyTag. This gets around the clock skew issue. 
There may be other more-recent tags with a clock-skew issue, but since 
Pacemaker-0.6.0 is the oldest tag, that requires the walk to continue 
until at least that date.

The commit-walk machinery in revision.c is rather complicated, and is 
used for a lot of different reasons, such as "git log" and this 
application in "git tag". It is on my list to refactor this code to use 
the commit-graph and generation numbers, but as we can see by this 
example, it is not easy to tease out what is happening in the code.

In a world where generation numbers are expected to be available, we 
could rewrite do_merge_filter() in ref-filter.c to call into 
paint_down_to_common() in commit.c using the new "min_generation" 
marker. By assigning the tags to be in the "twos" list and the merge 
commit in the "one" commit, we can check if the tags have the PARENT1 
flag after the walk in paint_down_to_common(). Due to the static nature 
of paint_down_to_common(), we will likely want to abstract this into an 
external method in commit.c, say can_reach_many(struct commit *from, 
struct commit_list *to).

> FWIW, much work is being done on a cached commit graph including commit
> generation numbers, which will solve this issue both correctly and more
> efficiently.  Perhaps it will already be included in the next release.

The work in ds/generation-numbers is focused on the "git tag --contains" 
method, which does return correctly here (it is the reverse of the 
--merged condition):

Which tags can reach Pacemaker-0.6.1?

$ git tag --contains Pacemaker-0.6.1
(returns a big list)

This is the actual reverse lookup (which branches contain this tag?)

$ git branch --contains Pacemaker-0.6.1 | grep master
* master

These commands work despite clock skew. The commit-graph feature makes 
them faster.

Thanks,
-Stolee

