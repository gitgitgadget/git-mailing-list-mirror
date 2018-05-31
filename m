Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A621C1F42D
	for <e@80x24.org>; Thu, 31 May 2018 17:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755945AbeEaRmS (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 13:42:18 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36029 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755875AbeEaRmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 13:42:13 -0400
Received: by mail-oi0-f66.google.com with SMTP id 14-v6so12213551oie.3
        for <git@vger.kernel.org>; Thu, 31 May 2018 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MU9QHz9esV4FA/FzL70qfjyfoxNDdxrYKp3A7OSZw/g=;
        b=K7D3ChrNaFsqf6LujKp4P3tizNvb/+8AY6649dhP5VdzNVED5yShpsXtKRhwuXcNJs
         7eD3zP2W9NY5Wujtb/NmbOtRaKtrt8g+cSK2+zzy4z6WCxR1QjohcYG+M3vIrOJkJVHO
         bXs5MagkbyuXhycLeo+6ePBqB+WX/mK14/hbYK7cyEv2nd+mUukihQSvwezNLSm1siQs
         idAeDJsl7mNU9ZpzYYVvf/Dys5PyhUWZnpjrEDUdYszmQHyquRpnazzyz5TDSgfXku4Z
         fYKTzK+tSXrwYhJVZxexCVpGvEKtixMwMgRD+Wbb6rKzv3zqc3ATTJrLX31XdJev5JnB
         vvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MU9QHz9esV4FA/FzL70qfjyfoxNDdxrYKp3A7OSZw/g=;
        b=tzdp/WXsceUUKgpzjhzxmQ/8J1TPXKXU1pRLSiau/lErvFwPnrA8AByq8eVP0rCfuW
         +L/fOMCEwh8Kez/TpUM7IZD1BEqv1cjaa/6MUKCPdgpN5pp9bdaSOB1zI+TLKBuZhSpI
         aUb1DzJdO5yfqhErEtZFWOI7yurV0Ey3AfIlEmM++S5msGQ4pb8eCAAqppuw1axD5YZF
         9E915FQAriqGS6rNwb/1gkQN0T433koIBKg37ySzhrEyFIz64kaRttcCNFtAi6/agIj+
         rJl0OZae9HSClabCHFBtDpMJsZ91xC3yFl6NGrmVJVpwqEe63bTwaBmoIz1sS1PsjJ3L
         NENA==
X-Gm-Message-State: ALKqPwezXkzD1AGcEKBZ80Qw3aaL3Kh9AFkqZ7Yxdk3xl5Hu6wVioJ/c
        pRWntYXZnuN9hU+mbIOg/CKvRfzfsg0gcbAQpa8=
X-Google-Smtp-Source: ADUXVKLnltuIV6lVvxWPwDnVHSO8g/LAyhVEev7X8gArWIwEsNmL5p2kF7U83ITEO1llV+iOoQvMdF2J8dW1rEhssXk=
X-Received: by 2002:aca:52ce:: with SMTP id g197-v6mr2113344oib.228.1527788532967;
 Thu, 31 May 2018 10:42:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Thu, 31 May 2018 10:41:42
 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805311323220.17047@localhost.localdomain>
References: <alpine.LFD.2.21.1805311235410.15130@localhost.localdomain>
 <CACsJy8CP=1_bHAzs+mveaJvbOOzr9vny-2xz6kM4cEcCYWmOOw@mail.gmail.com> <alpine.LFD.2.21.1805311323220.17047@localhost.localdomain>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 31 May 2018 19:41:42 +0200
Message-ID: <CACsJy8Do6iqvv=XvOu4YoD07t0OjckrpvNeF+XnH__w2+a=Big@mail.gmail.com>
Subject: Re: is there a reason pre-commit.sample uses "git diff-index"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 7:27 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Thu, 31 May 2018, Duy Nguyen wrote:
>
>> On Thu, May 31, 2018 at 6:38 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>> >
>> >   was going over some hooks and writing some tutorials for some of
>> > the commit-related, client-side hooks, and was wondering (perhaps
>> > stupidly) why the pre-commit.sample hook uses, as its last line:
>> >
>> >   exec git diff-index --check --cached $against --
>> >            ^^^^^^^^^^
>> >
>> > as in, could this not be done equivalently with just git diff, not
>> > git diff-index? i just did a quick test and it seems to do the
>> > same thing, but i've never taken a close look at git diff-index
>> > before so i may just be clueless about some important distinction.
>>
>> git diff-index is "plumbing", designed for writing scripts. "git
>> diff" on the other hand is for users and its behavior may change
>> even if it breaks backward compatibility.
>
>   ah, this was a philosophical underpinning i was unaware of. i see
> occasional explanations of git porcelain versus plumbing, but i don't
> recall anyone simply stating that the plumbing is meant to have a
> long-term stability that is not guaranteed for the porcelain.
>
>   in any event, this does mean that, stability issues aside, "git
> diff" would apparently have worked just fine for that hook.

I think there are also stuff like config variables which can change
porcelain command behavior but usually not plumbing. Command exit code
may be another area where porcelain and plumbing differ. But in this
particular case, I think "git diff" works fine (but still should not
be used unless you're just writing a quick throwaway script).
-- 
Duy
