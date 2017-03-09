Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB9F720314
	for <e@80x24.org>; Thu,  9 Mar 2017 05:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750739AbdCIF0y (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 00:26:54 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33271 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdCIF0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 00:26:53 -0500
Received: by mail-ua0-f193.google.com with SMTP id f54so8084811uaa.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 21:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dAs5f0pXr8/pDnYvB25Y0hwt7ixbbYrZZUjVYad9BAQ=;
        b=S2Id00zSbARIdSs57QtfHV0/sa3TQacZEMPIy1/SeB6Vr+r0vK1vbH/N0m6ddQNS/j
         bg/iNsuhk1A0m7rgihmGq9gvXJYsAosfMXoMDDJkfqR3gjGQKvf4BsE6TO9QjOsN1bza
         s6XLt2WilaYmlbtJKvkOfzpB7qeBmr+kpjg1q+r+tQdS1FbHnOhVPyrPQjRZJwGSib0T
         nI2nfy5BfDsEEewcWKvOe+bfdZGK37II0L1Sa9MtQm+Bp2pvH4UfbSAZewTDTYzvFn+y
         5aqxcMdK1jclGnqiSQzGFRCYF2PCcubUUBXVzC+/jgrgqFeLePX9mS4wT/sqjS53+hyN
         EWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dAs5f0pXr8/pDnYvB25Y0hwt7ixbbYrZZUjVYad9BAQ=;
        b=P7kRTC2sxV1nbsCm7OYy5hgnOSX6hq4L6RfeaYrBpn83dlXUtLdJNsJkrGz9YXiwE6
         bc7q2dI6xoX9l7UDpbx1j0mspqgxV8mus/htCm+xK4Dpn4UA38+AvQkJY/tdlK/nhP3+
         diXWOvys1txGaymrf+9i+HaQX48kenM19SSGGvEaeEgsY9EKspjhv1/Yf2hI/K6u1zzn
         qnIl6A7OEU/TRv3uD3HmkQxytqnRo0KFC4Pwj9TeDN5QkJEyobym09BjVGT5TM1cqFmv
         1NBtXPnyN3+99/8IzzR8j7/fRpG+f49R+XUvXCvPeFX/24wMLh9JW+rKMllKvHonFs7i
         cCPA==
X-Gm-Message-State: AMke39ldLnOteSNkEKHnuVa22oF1g1WyBAuswLr0pCHWY0wLkXYFzUu7O46VDvF7q5zJ4fVTkIizz+pZB0rs2w==
X-Received: by 10.176.74.30 with SMTP id q30mr6679740uae.4.1489037212234; Wed,
 08 Mar 2017 21:26:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.87.218 with HTTP; Wed, 8 Mar 2017 21:26:51 -0800 (PST)
In-Reply-To: <CAME+mvUzR6--AeUff6yGZ69GN-hE6AyDP-CkdFxnFAwccpn2yg@mail.gmail.com>
References: <CAME+mvUe7itzg7JLu9_131smzHHE0JsN-z7q8_dTY1qEdugYWw@mail.gmail.com>
 <CAGZ79kaYi1OLuOKvbCmDrMCq0fZnO2Ry7JML=Puwmx6TTtEYog@mail.gmail.com>
 <3026648b-a26c-bc67-62dc-170217d6c2ca@kdbg.org> <CAGZ79kZhfRiUQndEGB=b34WMCPv0KDjpDix0Ly85aFeyOQAwWA@mail.gmail.com>
 <20170308060334.6ilcjgaxgycuhpxu@sigill.intra.peff.net> <CAME+mvUzR6--AeUff6yGZ69GN-hE6AyDP-CkdFxnFAwccpn2yg@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Thu, 9 Mar 2017 10:56:51 +0530
Message-ID: <CAME+mvWRSEJ6kp4MpELx20DkeR+pDED-KGB2o6yQ-26FmLvqWw@mail.gmail.com>
Subject: Re: [PATCH] t*: avoid using pipes
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have created the required changes and submitted a single file patch.
Also I tried my best to include each of the suggestions in that patch.

https://public-inbox.org/git/0102015aae7b8536-00c57d0a-1d48-4153-a202-87c4ea9e0e19-000000@eu-west-1.amazonses.com/

On Wed, Mar 8, 2017 at 7:02 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> On Wed, Mar 8, 2017 at 11:33 AM, Jeff King <peff@peff.net> wrote:
>> On Tue, Mar 07, 2017 at 12:52:49PM -0800, Stefan Beller wrote:
>>
>>> On Tue, Mar 7, 2017 at 12:39 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>>
>>> > Welcome to the Git community!
>>>
>>> >
>>> > Actually, being a *micro* project, it should stay so. Not doing all of the
>>> > changes would leave some tasks for other apprentices to get warm with our
>>> > review process.
>>>
>>> right, so just pick one file.
>>
>> I also wonder if we really want all invocations of git to be marked up
>> in this way. If the primary goal of the test is checking that a certain
>> git command runs successfully and generates the expected output, then I
>> think it is a good candidate for conversion.
>>
>> So in a hunk like this:
>>
>>    test_expect_success 'git commit-tree records the correct tree in a commit' '
>>         commit0=$(echo NO | git commit-tree $P) &&
>>   -     tree=$(git show --pretty=raw $commit0 |
>>   -              sed -n -e "s/^tree //p" -e "/^author /q") &&
>>   +     tree=$(git show --pretty=raw $commit0 >out &&
>>   +     sed -n -e "s/^tree //p" -e "/^author /q" <out) &&
>>         test "z$tree" = "z$P"
>>
>> we are interested in testing commit-tree, not "git show". Is it worth
>> avoiding pipes there? I admit the cost to using the intermediate file is
>> not huge there, but it feels more awkward and un-shell-like to me as a
>> reader.
>>
>> -Peff
>
> Thank you everyone, for reviewing my changes. And as said in the
> reviews, I'll send a single patch file as my microproject, leaving the other
> files as low hanging fruit for the others to look at. Also, I try to include as
> many suggested improvements as possible and will also remember them for
> my future patches.
