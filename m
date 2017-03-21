Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C176F2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 22:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbdCUWvD (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:51:03 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:32772 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758062AbdCUWvB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:51:01 -0400
Received: by mail-pg0-f41.google.com with SMTP id n190so100091933pga.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 15:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i0xNaTr+1LtT0YsQ059KsusE/Gm4Rc+hmqMXKjioZmM=;
        b=crmDsGirtPm9vlh8l4d+PWujf6OhpcDMAt8JzdwYZIMD7ZCmi26ouFWt56vHGlxHp5
         VNUGdKilp92zpnax0bBZ/m10qZq3wr7/tnYFRt6Oze2xYrP04EQ3xfeO7y8TWTmjDe02
         FfJyBScxosoewBrpgsKNTiCNFFlVFC/wVyJKObKfCYPd1ZxEzvMhOUALIK4SdE7Y0jnA
         VWnRy1b9CZ5kYqPNfZiui3Qywc+QPbnzpGOU0VatdZM+BRDt/Uk57on7hTk6K85gUAAj
         2l82aLEFTgMPwjNm8R61w/cQYm+3QnEiLxvTw8IXlQQrtrMY4k745wZy8l+m1OO8j0vv
         RUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i0xNaTr+1LtT0YsQ059KsusE/Gm4Rc+hmqMXKjioZmM=;
        b=ov23ZQU4k/STMv1VpWgV1tsyv34JK+1eOj+UWxQ1KZkX5Mw+mVFTcduI1d5o4ni1Fr
         Q1mnYobb6+lrcUAzJA1FVXQMmAFzd7PP07ADbW89/XHxkGxC2MsXnXRhfoPNEOGDv3ir
         wiFKKw2Gnl6Razv2n+AuFo6Ie9z6AeQMnMcYmsBwoFnwD6c7B3XE+pFzIC+3wkELEMOa
         Y8fNHGri9A8EwkpWeYgdMnjbPDP8mrAeHWDpDJV8a5vACIlGo1g0PuCDjnRessmV8fE9
         k3RmtQk/G17qqb8AiKYr4BjA/4BN5MMXFi11KYEGWrsdGElDsiAULNF51Gl6KB4ei0dk
         B+ew==
X-Gm-Message-State: AFeK/H3sJy3uQTNw9Jz/zKNow5jc321ZRWQs/Ki3LvkqoySHyNSQXAKYSJ2HFhHcXuXjH5oDEF8bOTTHcG3naCTo
X-Received: by 10.98.69.86 with SMTP id s83mr43195619pfa.232.1490136655004;
 Tue, 21 Mar 2017 15:50:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Tue, 21 Mar 2017 15:50:54 -0700 (PDT)
In-Reply-To: <xmqqvar2mevi.fsf@gitster.mtv.corp.google.com>
References: <xmqq37e7t902.fsf@gitster.mtv.corp.google.com> <20170321185139.8300-1-sbeller@google.com>
 <xmqq7f3invr6.fsf@gitster.mtv.corp.google.com> <CAGZ79kbjsm1p+Ag5Q8fii3ncbxSsVLYRwGP=Va=btx8Tfy3aOA@mail.gmail.com>
 <xmqqvar2mevi.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Mar 2017 15:50:54 -0700
Message-ID: <CAGZ79kYfrKRbs40UH73VCgMsJgFyh1aG5ZrYMj3O_wGdu6rSUA@mail.gmail.com>
Subject: Re: [PATCH] builtin/describe: introduce --broken flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> AFAICT, someone is (was?) using a version of Git that doesn't contain
>> f8eaa0ba98 (submodule--helper, module_clone: always operate
>> on absolute paths, 2016-03-31). So then the submodule paths were
>> made absolute paths on creation of the Gerrit repo.
>>
>> And then someone moved the repo and the absolute paths broke.
>>
>> Even after an upgrade of Git to its latest and greatest version, the underlying
>> issue of having broken submodule paths remains in that case.
>>
>> So there are a couple of ways forward
>> 0) as an immediate fix, manually fix the absolute path or make them relative
>>
>> 1A) have more error resilient tools in Git
>> 1B) have a tool in git (e.g. "git submodule fsck-setup") that rewrites
>>     the .git file link and the core.worktree setting to be relative and correct.
>>
>> I think we should do both A and B, I decided to go with A first, specifically
>> "git-describe" as that was reported to not work well in this situation with the
>> given broken data
>
> Sounds sensible.  I would say that we should do less 1A (i.e. hiding
> problems under the rug) and more 1B.  Of course, making the problem
> less likely to happen in the first place would be more important ;-)

Agreed on not introducing bugs as often. For (B), I wonder what the
right place is.

Maybe "reset --hard", in combination with "--recurse-submodules" would also
fix these submodule path issues. The made up "git submodule fsck-setup"
sounds like it would only detect (and not fix) the problems. But these absolute
paths issues are known how to fix, so a "fsck"-y tool may convey a wrong
impression.
