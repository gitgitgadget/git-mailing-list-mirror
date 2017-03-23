Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8335420958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935809AbdCWVE6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:04:58 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35670 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935721AbdCWVEz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:04:55 -0400
Received: by mail-vk0-f41.google.com with SMTP id r69so44856023vke.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QVGbBRmmvhIRdHK9EW2puiLRbIElnoqnfTAv4uhZfw8=;
        b=KLgrcNtI+0q2zJmWKo5sCsBeDuU/rykKjAD6LFn9yXNjwCPZ98MwAL7ATm1QRPXGIw
         3wLzwDt3EZp58MJ9yWC2jAYQtlHC2VVyRnKOrCWl1GA8V+5+9Bo2THrI5b+Zktk+RPiF
         ZuhBwT1SJqQIn1zL2A7Jh84sar7IV3qp1Vlp8Qsmwuz2pIQfhC5ICV5UpUfGx7RvOEdO
         zwtLDzthwAbCyUyfV9sJYg7DjxxyWVc5R4NYOjhcAZ477nEyw7L7iEWxT/HNm/NA+gFl
         JPMB8CeBj7gnIT7iS4tkxhChZBThkAiDtMEKkpKLkAcJfiY9aeIW7GrG1B/n0Q87ADRx
         sP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QVGbBRmmvhIRdHK9EW2puiLRbIElnoqnfTAv4uhZfw8=;
        b=d8mQBt9kRXdiA70BrYUcM7iKM7U9L7egj3++xtht/lJTm5qMx5ycwEtg97FwKZdEso
         hz+RLZB9qRpNxgTm35Ukm/AlNqUoUIMGzufpGl95Qasnbo1X92Oa9qrsADDM57tvXvqo
         8PhZfi1eOy22nwHesf8GttYE1GzBCR9EqkC/CPk8tLKJxUty+i8hBAtzmAhfQy/Zmhd7
         7+TjK+4OAt1goc5pkkMHZLnUGETzzn8vAE5rARiK0xUemnfu0pJ3wxdHEDSOzqnAfXlx
         t1KQQFt3uYRp1VgArxMK7DzJv1QLlVOTIyVcQUbM4C+n6jL4aLMTS3Bm04xURg6A6T/Y
         a9gA==
X-Gm-Message-State: AFeK/H1x0pRN3+DWSyy03C14D3NH1cctvFjySGjxNPhYzU7IndfxS+SQzw6c2+DZKVdrfeAqUMAULTqfJOB19g==
X-Received: by 10.159.38.109 with SMTP id 100mr2368042uag.63.1490303084264;
 Thu, 23 Mar 2017 14:04:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.6.199 with HTTP; Thu, 23 Mar 2017 14:04:03 -0700 (PDT)
In-Reply-To: <20170323193823.gxodwqv4eshgtqbc@sigill.intra.peff.net>
References: <20170322065612.18797-1-larsxschneider@gmail.com>
 <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703231716320.3767@virtualbox>
 <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net> <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com>
 <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net> <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com>
 <20170323193823.gxodwqv4eshgtqbc@sigill.intra.peff.net>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 23 Mar 2017 16:04:03 -0500
Message-ID: <CAJZjrdVN6W_yyAuM9Sbr0qnCtZ77Z89XbJ_s-g5V7n5+kdsV5w@mail.gmail.com>
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 2:38 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 23, 2017 at 08:26:15PM +0100, Lars Schneider wrote:
>
>> > I think we do build against PRs now. E.g.:
>> >
>> >  https://travis-ci.org/git/git/builds/213896051
>> >
>> > But it looks like we can turn that off.
>>
>> When we add a secret variable, then TravisCI will not build Pull Requests
>> for git/git anymore:
>>
>> "[...] we do not provide these values to untrusted builds,
>> triggered by pull requests from another repository."
>>
>> See: https://docs.travis-ci.com/user/environment-variables/#Defining-Variables-in-Repository-Settings
>
> Ah, OK, that makes sense. So we would only have to worry about our _own_
> code accidentally disclosing it. But that should be easy to look for by
> grepping the log (did somebody do that?).
>
>> However, I don't think that is a big deal because git/git doesn't
>> support Pull Requests anyways. Plus, if a contributor is interested
>> in TravisCI results, then the contributor can setup TravisCI for
>> their own fork easily.
>
> Yeah, agreed. It's not like we are blocking the merge button with a
> failing status.
>
>> > Hrm, it does mean that people have no way to test on Windows until the
>> > branch hits pu. Which is not ideal.
>>
>> I agree it's not ideal. But I think it is an improvement to check
>> pu/next/master/maint continuously :-)
>
> Oh, I agree this is a step forward from the status quo. I just wondered
> if we could do even better.
>
> As a side note, I've started having travis run on all of the topic
> branches in peff/git, with the idea to get early feedback on OS X
> problems (and now hopefully Windows ones). My two issues so far are:
>
>   - I have a lot of work-in-progress branches. I put "-wip" at the end
>     of the branch name for my own scripts. It looks like I can put "[ci
>     skip]" in the commit subject to convince Travis to skip them, but
>     that's a little annoying. Is there any way to skip based on just the
>     branch name? I couldn't find one.

I think you can "safelist" (whitelist) branches to build with regexes:
https://docs.travis-ci.com/user/customizing-the-build#Building-Specific-Branches

>   - The OS X builds seem to regularly time out. That at least marks a
>     "!" in the build status screen instead of an "X", but it's a lot of
>     noise (and it misses the point for me, which is testing on OS X; I
>     already build regularly on Linux).

I suspect this happens because they don't have a lot of macOS runners
- I've seen those jobs wait for hours (even on private jobs) before a
runner gets freed up.

> -Peff
