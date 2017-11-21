Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2BA202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 00:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdKUAaa (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 19:30:30 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:41741 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdKUAaa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 19:30:30 -0500
Received: by mail-qk0-f176.google.com with SMTP id f63so9828544qke.8
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 16:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9oID5x9n2VCozybkMXffxh8k9Aj5Yjg+qX1QkhNW6CI=;
        b=usDZQhSt4W+mESlme/GxyvEr6HnG9irT/eGWDHPYlDrlPBMvKElXAvuaANTTbwH3Lf
         KIBR0cINURONpcY7ZBDd8YB+vinfrUzoutzub18gESNzW0D6OT4mFWTgh00fl3BX+RIV
         lNxyiiIjscCmDaPn7thuKj+ZaQmrrwpNS0aouJs/o8I91wkr40rIXytMhjDQ4QYIB1e5
         Bfc9XU/YNPmyBTHs29wjeLzfqZW9RWyPabFOV8Dx6SXM7BrlX8d53sRQK/Asc53shsg0
         3qiQogD/cPMOsugOK6fVDuuqnUuZ7QM0trysHui6/SYpGg/cgm85SOBchkSUoH3gj84i
         HjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9oID5x9n2VCozybkMXffxh8k9Aj5Yjg+qX1QkhNW6CI=;
        b=DwetT8Rk3oS76apgMPKLii3KdSo6Z/2xbwDsLpHeZV3VwvxxzMRHbCZAbyvCBPsyRC
         lgDMWJNi6HJ+1QiFS+5AkwA4Z8GvUoETTMWc7s5Mke4wzOA9Dt57dq1n9pN2WW8BQqmg
         RSu737QvEOrXcOmSreTc7ZbPAb7lwmiGbRPP2bkmEv3wtNO+JXH+2HiLHRaLeRIyG79l
         VBr8QogYPi63zsWXmPj1p2UMqBfIuxZyHDfpupdCitqUlebZ3ZDWtGnWbYbE+4LO07tl
         /AL19TGCUeRzvpzSN8EavSPUilrX5eP2GQuJZAw2YcyW8EUduA3OR++dd9vO9moV9Pfz
         Ne0w==
X-Gm-Message-State: AJaThX5kOoZsaRwo2QCzqaX5ggFiGFJvBLkYkyt1gfcM7AGVqakaDnaH
        159oVYIZxIRotXeZi2N3IKCo8kLL6SsKpkXdwN8=
X-Google-Smtp-Source: AGs4zMa4UjYinxWX2V7+fQN9InNz3l4umT7lYZTrQz/PXPlUM6mDDchfPcv3kQl/Deq9irEoqyUaw+83Y7v09UYefNo=
X-Received: by 10.55.42.75 with SMTP id q72mr24173707qkh.57.1511224229394;
 Mon, 20 Nov 2017 16:30:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Mon, 20 Nov 2017 16:30:28 -0800 (PST)
In-Reply-To: <D810DA8B202742B38343EBB44BD54A1D@PhilipOakley>
References: <20171116154814.23785-1-alex.bennee@linaro.org>
 <CAPig+cSh0tVVkh0xF9FwCfM4gngAWMSN_FXd2zhzHcy2trYXfw@mail.gmail.com>
 <CAPig+cSbRrGnyDkunMFiFXbWRMAsGyuAL-0FpP1QTtjSUSY2Hg@mail.gmail.com> <D810DA8B202742B38343EBB44BD54A1D@PhilipOakley>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Nov 2017 19:30:28 -0500
X-Google-Sender-Auth: MUd8NO7180MSk35tHZrcVGmHOIk
Message-ID: <CAPig+cQvjX4MxttytKu=et2tBz5QoaDNtp10oqvynDJGYLxUWQ@mail.gmail.com>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
To:     Philip Oakley <philipoakley@iee.org>
Cc:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 7:07 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Eric Sunshine" <sunshine@sunshineco.com>
> On Sat, Nov 18, 2017 at 9:54 PM, Eric Sunshine <sunshine@sunshineco.com>
> wrote:
>> > --- 8< ---
>> > diff --git a/git-send-email.perl b/git-send-email.perl
>> > @@ -1724,7 +1724,7 @@ sub recipients_cmd {
>> > -    open my $fh, "-|", "$cmd \Q$file\E"
>> > +   open my $fh, "-|", "\Q$cmd\E \Q$file\E"
>> > --- 8< ---
>> >
>> > However, it's possible that might break existing users who rely on
>> > --cc-cmd="myscript --option arg" working. It's not clear which
>> > behavior is correct.
>>
>> The more I think about this, the less I consider this a bug in
>> git-send-email. As noted, people might legitimately use a complex
>> command (--cc-cmd="myscript--option arg"), so changing git-send-email
>> to treat cc-cmd as an atomic string seems like a bad idea.
>
> A while back I proposed some documentation updates
> https://public-inbox.org/git/1437416790-5792-1-git-send-email-philipoakley@iee.org/
> regarding what is (should be) allowed in the cc-cmd etc., and at the time
> Junio suggested that possible existing uses of the current code would be
> abuses. I didn't pursue it further, but it may be useful guidance here as to
> potential real world command lines..

Thanks for the link. I had forgotten that discussion, but re-reading
it brought most of it back. Given how the discussion ended -- with
valid use being that --cc-cmd names a program which accepts a single
argument -- then the above patch to recipients_cmd() might indeed be
desirable.

And, the documentation is still lacking, saying nothing about that
single argument passed to the cc-cmd...
