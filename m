Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188DA20899
	for <e@80x24.org>; Fri, 18 Aug 2017 04:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750729AbdHRECR (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 00:02:17 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35658 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdHRECQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 00:02:16 -0400
Received: by mail-yw0-f174.google.com with SMTP id n83so24573878ywn.2
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 21:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZUj4tGgp0YirPwN5lPROrQNQgycP+2tuCdP24VF7y5M=;
        b=nqBFwGhce4j5YOqtgTTAazM6KBths7Mm+zw2QBPFXSXv/PIxBVkCtwuIXNQgIJ/uG6
         X6s9r+nK82o1fElpAqsVEvYW5uTDM8ON43a44eoLXVavP0Pe9plopU3w3j1vSQmaW0Uf
         XxhYAv6nqCHqDdXytVU14/LbH40NUUnx2rNVcvIv+3E1BYnntA7tFQKSoCI7LGtQElJR
         412YSqzJan+JC26KIfRk2nFvy6vBZ8mqE6PmyP/zenR4XpRLTK/de5ILWryF2WdVd+rD
         CW4SUVsfagMjmBxkQihWkyRZn/aUu4Z+lHU/FhT6h+cD/wkywJJJqh3dGRvWDNDzj3CD
         HbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZUj4tGgp0YirPwN5lPROrQNQgycP+2tuCdP24VF7y5M=;
        b=T9tLo5Z41B+iKfSr/tFFWVZTUMqXOE6l5yPWdoSEuY7N97uMtoEbhRK/qnbJ5Y9TeF
         qBw+hGIsZRPwCxY/tRU3ShsyZ2pUXqLQ8Wm+1Wu55S+ZgPpTuq1x6GT8sLX7ymRufhb0
         Q96nXXe5rnUY0hodotv89/WHtMMqG/YRnrOo9OWWvKlbAmT/S7nJrXRwYkWXMmjTlw1v
         hJ81KXJ0j/KyX1OVUAFnuOO4w4G0hpYtak6SfEIO9DhXXFtcfnJRVT3J/sJIcDs+9NUR
         XU3KhooVJC80O8VT57UP1KMbsa1MqlSvSVW1ie7e7X/cOx+QnOgzycWRU4szGv2rHMwR
         4zGA==
X-Gm-Message-State: AHYfb5jhvZqp7DOtWX2eCKcl5FBIdZ+MF6azeZKX1O2xCClJRs2TUf96
        CW3Hx80lEhvhe/MERfjaEbNnDxWHgxqdOc1ZWQ==
X-Received: by 10.13.218.129 with SMTP id c123mr5898831ywe.175.1503028935887;
 Thu, 17 Aug 2017 21:02:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Thu, 17 Aug 2017 21:02:15 -0700 (PDT)
In-Reply-To: <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com>
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
 <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
 <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com> <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
 <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Aug 2017 21:02:15 -0700
Message-ID: <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
Subject: Re: Submodule regression in 2.14?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 7:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Are you saying this might be a design mistake and
>> the .update ought to be respected by all the other
>> commands? For example
>>     git reset --recurse-submodules
>> should ignore the .update= none?
>
> I have been under the impression that that has been the traditional
> desire of what .update ought to mean.  I personally do not have a
> strong opinion---at least not yet.

In this context note v2.14.0-rc1-34-g7463e2ec3
(bw/submodule-config-cleanup~7, "unpack-trees:
don't respect submodule.update") that is going opposite of
your impression.

>> When designing these new recursive submodule functionality
>> outside the "submodule" command, I'd want submodules
>> to behave as much as possible like trees.
>
> I think that is sensible as long as the user does not explicitly say
> "this and that submodule behave differently" by giving configuration
> variables.  Perhaps .update is one of those that should countermand
> the default behaviour of "--recurse-submodules"?

Maybe, I'll think about it. However there is no such
equivalent for trees (and AFAICT never came up) to
treat a specific directory other than the rest in worktree
operations.

The problem with the issue in question is however:
git-pull is a combination of two other high level commands
(fetch/merge), the fetch component already had
a recursive behavior, and that commit in question
added a bit for the merge component, so the UX
is hard to get right for both of them:

    git pull --recurse=fetch-only
    git pull --recurse=merge-respects-update-strategy

is what I'd want to avoid.

So maybe we can just respect the update strategy
before starting the local part.

Stefan
