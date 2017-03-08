Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A275202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 14:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdCHOjf (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 09:39:35 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34416 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdCHOjU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 09:39:20 -0500
Received: by mail-vk0-f67.google.com with SMTP id r136so1395375vke.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 06:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wLN/RnrQ4TlzY/gT4PH1wszui25SjNGQ7j7ARL7F1bk=;
        b=HdSetLkHyGC1COqlzgiKIXdrM0DmpK7aHfuEktrFcODhePiPzDxLfaFcZTXspU4OKH
         ZhzSDij4mpgm0c+OINjiXbw0wyARX3gKPpO82aXX0Zi6DMjA+y/1rtaO1svpnlXsxdg4
         y/kEkOEz+3G2qSehfh3E+gEKX73s8O+KgPxQHgV05JvzNSrFseaefGJv8sGRvdghE0ut
         g8v4RT6OgWLn9PndLPEJ7MGCTYTcJzO9nF3xeLmV29ClvThMd159jDY/ETaZ9IAKGO9d
         ElMiwgEPDsV4SYN+NANhW8pJBy6m3yRVN0xUN49ol5LIaDzixtT7bqYMRGVpCggy+cUe
         2PAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wLN/RnrQ4TlzY/gT4PH1wszui25SjNGQ7j7ARL7F1bk=;
        b=NwVoWh/E4iMjRuCAz/G4imx9Yw4yhFmi4hcxwBEzLv3bYfryxI6LLdQkv8UX10XeHu
         fteTP86A/0TsqyWtjTtT9iThmjEpVGb1Xhjqk0xr/kpa00K9gkr8Q6RuWThhHNkB5r9F
         68Tazfrv6EBhqx9fBf54ZzsyUkya9TMeZG590/7YzrzdVzMZLXEVRePv4Sz1Mc/8tlbS
         2a2qgj8HrbRFo1wbuzIGDL2bZOUVZvj20oro8HE2Aqc8Y7PEp+/rbf6y2iwSvq5qcc/5
         p2wr8aVvD5HN2LcwfE9S4Sz2VnlJ5X2Q7Nio/M5M6RrjWyFhFl8G/PhH9FysY5Mk+v89
         5wyA==
X-Gm-Message-State: AMke39nQGGvCj8AVDElXyWSCAmjPZOw33cqchNWRspp3mNt5QQohm14BfqN0BiG0ocez9rT0ljEGrMIezx3bHg==
X-Received: by 10.31.72.67 with SMTP id v64mr3143929vka.37.1488979947620; Wed,
 08 Mar 2017 05:32:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.87.218 with HTTP; Wed, 8 Mar 2017 05:32:27 -0800 (PST)
In-Reply-To: <20170308060334.6ilcjgaxgycuhpxu@sigill.intra.peff.net>
References: <CAME+mvUe7itzg7JLu9_131smzHHE0JsN-z7q8_dTY1qEdugYWw@mail.gmail.com>
 <CAGZ79kaYi1OLuOKvbCmDrMCq0fZnO2Ry7JML=Puwmx6TTtEYog@mail.gmail.com>
 <3026648b-a26c-bc67-62dc-170217d6c2ca@kdbg.org> <CAGZ79kZhfRiUQndEGB=b34WMCPv0KDjpDix0Ly85aFeyOQAwWA@mail.gmail.com>
 <20170308060334.6ilcjgaxgycuhpxu@sigill.intra.peff.net>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Wed, 8 Mar 2017 19:02:27 +0530
Message-ID: <CAME+mvUzR6--AeUff6yGZ69GN-hE6AyDP-CkdFxnFAwccpn2yg@mail.gmail.com>
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

On Wed, Mar 8, 2017 at 11:33 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 07, 2017 at 12:52:49PM -0800, Stefan Beller wrote:
>
>> On Tue, Mar 7, 2017 at 12:39 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> > Welcome to the Git community!
>>
>> >
>> > Actually, being a *micro* project, it should stay so. Not doing all of the
>> > changes would leave some tasks for other apprentices to get warm with our
>> > review process.
>>
>> right, so just pick one file.
>
> I also wonder if we really want all invocations of git to be marked up
> in this way. If the primary goal of the test is checking that a certain
> git command runs successfully and generates the expected output, then I
> think it is a good candidate for conversion.
>
> So in a hunk like this:
>
>    test_expect_success 'git commit-tree records the correct tree in a commit' '
>         commit0=$(echo NO | git commit-tree $P) &&
>   -     tree=$(git show --pretty=raw $commit0 |
>   -              sed -n -e "s/^tree //p" -e "/^author /q") &&
>   +     tree=$(git show --pretty=raw $commit0 >out &&
>   +     sed -n -e "s/^tree //p" -e "/^author /q" <out) &&
>         test "z$tree" = "z$P"
>
> we are interested in testing commit-tree, not "git show". Is it worth
> avoiding pipes there? I admit the cost to using the intermediate file is
> not huge there, but it feels more awkward and un-shell-like to me as a
> reader.
>
> -Peff

Thank you everyone, for reviewing my changes. And as said in the
reviews, I'll send a single patch file as my microproject, leaving the other
files as low hanging fruit for the others to look at. Also, I try to include as
many suggested improvements as possible and will also remember them for
my future patches.
