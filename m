Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246D71F42D
	for <e@80x24.org>; Thu, 31 May 2018 23:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750756AbeEaXZG (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 19:25:06 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41625 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeEaXZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 19:25:05 -0400
Received: by mail-yb0-f193.google.com with SMTP id l2-v6so8158225ybp.8
        for <git@vger.kernel.org>; Thu, 31 May 2018 16:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X3oG7S7fTVjYvtK/3buQxf3raB1y9mChH80DUJgsp14=;
        b=bQmA3a7MLaYvPqWN1y8PG/z7rTcMcAqB/7L841mqlFZqYglLO3Y2/cRzYHwDv/2KmM
         9A6xCTfBXOKt0yP9p7U/q3xA0BYFK1IZM+dVsK4A6y/9llJesjSg8ZCULQEvEOHnSgYN
         FGNxnD4s5TGi2brZpVxyZpkmQSKIviFB1xCcO2Yf2b74ZFwklswkkM7sYcXJvkZDBgPM
         8zNAs26fMhInMfYLWwWbdlfbgVmKc/fC1CuiRxbFbxwGawTXbsviw0awwz5U0f0Q0jX1
         DS/5vYMRtuKHhM0YtktthEW2C9SKgP6TOZq6hGkwKqM44MJEk0fFdHA8H6g1b4jSrvZA
         XrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X3oG7S7fTVjYvtK/3buQxf3raB1y9mChH80DUJgsp14=;
        b=VNjLwzEQWqxS3SK7pydoFMwNPEQT5YX9Ji7i+YjowCj3e7cTWr4/NR/0IP4fXfSXOc
         Y6e41tl7gV0lguqlnJmQMp9VUV9ICXxwKg+UzbkmxHpMsm9+DeK9J37EeMiC0jhR+9+d
         GvP01t3hkC/wce+Rg+5+QpSSDZddN04yEcqlT1j1dvov1cukSHR7/nJLEYsp4Z47e2v8
         dmwuSv2HSqVDLOtZCxCPQjr+4DzaF8/jX3ByK2jyT4TwLr+Q9FgVIZDwSDE5e5nHGeT6
         T0rPP9Mrzs3l+DlemK2/lNVzL/b4s3G774O6y7zmAIGxP6NyEKHrYzsFmSAk1guP3jgy
         nHCQ==
X-Gm-Message-State: ALKqPwew9hUP5KcUXR2r3iRML0Z6A+H3PxApzhiivBjWkncW7Z7puU8Q
        Zl450n7m2p+BBSukSsDRxDLcrN5buXZDRoU6a1fawA==
X-Google-Smtp-Source: ADUXVKIiLSGQNvXS4jJvKb26QkZu2mvgNgRuLVefY9pRuUqinw1mbqvi0A0oeSidmlAWYAyAgNf9NUMhzQzkMLAjdEw=
X-Received: by 2002:a25:dfca:: with SMTP id w193-v6mr4923206ybg.334.1527809104794;
 Thu, 31 May 2018 16:25:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 31 May 2018 16:25:04 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805311907280.19720@localhost.localdomain>
References: <alpine.LFD.2.21.1805311235410.15130@localhost.localdomain>
 <CACsJy8CP=1_bHAzs+mveaJvbOOzr9vny-2xz6kM4cEcCYWmOOw@mail.gmail.com>
 <alpine.LFD.2.21.1805311323220.17047@localhost.localdomain>
 <f27d8344-4acb-3e87-3bd9-b23b21c4b82a@kdbg.org> <alpine.LFD.2.21.1805311907280.19720@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 May 2018 16:25:04 -0700
Message-ID: <CAGZ79kZ9x2OWU+qfZRckZFAdy1KFqttAZqkJwbzsvQfqUokg3A@mail.gmail.com>
Subject: Re: is there a reason pre-commit.sample uses "git diff-index"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 4:09 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Fri, 1 Jun 2018, Johannes Sixt wrote:
>
>> Am 31.05.2018 um 19:27 schrieb Robert P. J. Day:
>> > On Thu, 31 May 2018, Duy Nguyen wrote:
>> >> git diff-index is "plumbing", designed for writing scripts. "git
>> >> diff" on the other hand is for users and its behavior may change
>> >> even if it breaks backward compatibility.
>> >
>> >    ah, this was a philosophical underpinning i was unaware of. i
>> > see occasional explanations of git porcelain versus plumbing, but
>> > i don't recall anyone simply stating that the plumbing is meant to
>> > have a long-term stability that is not guaranteed for the
>> > porcelain.
>>
>> So, there you have it. ;) Plumbing commands offer long-term
>> stability. That is not just philosophical, but practically relevant.
>>
>> >    in any event, this does mean that, stability issues aside, "git
>> > diff" would apparently have worked just fine for that hook.
>>
>> It may have worked just fine. You should still not use it.
>>
>> Didn't you say that you are teaching git and hooks? Then you should
>> teach the right thing, and the right thing is to use plumbing for
>> scripts.
>
>   sure, i agree, but i don't recall *ever* running across the claim
> that the "plumbing" commands had a long-term stability and backward
> compatibility that the porcelain commands did not. is that mentioned
> anywhere?

`man git`

LOW-LEVEL COMMANDS (PLUMBING)
       Although Git includes its own porcelain layer, its low-level commands
       are sufficient to support development of alternative porcelains.
       Developers of such porcelains might start by reading about git-update-
       index(1) and git-read-tree(1).

       The interface (input, output, set of options and the semantics) to
       these low-level commands are meant to be a lot more stable than
       Porcelain level commands, because these commands are primarily for
       scripted use. The interface to Porcelain commands on the other hand are
       subject to change in order to improve the end user experience.

One example that Junio seemed to worry about was 940a911f8ec (log:
if --decorate is not given, default to --decorate=auto, 2017-03-23), as git log
seems to be used pseudo-plumbing-ly as there is no good and equally powerful
plumbing command, so the likelihood of git-log calls in scripts out
there is high.

So maybe the community should strive to be more aggressive about
changing the porcelain interface for the better.

One thing that we discussed internally for example is changing the
output of the porcelain output of fetch, pull and push to give less
cryptic output, but rather a one line progress bar (and only show errors
when they occur). I think that would be an improvement, as I don't think
many people care about the exact numbers of objects transferred in
a push/fetch, but rather want to have an estimate of the time left for
example. Also a one line progress bar might save some precious screen
real estate.

Stefan
