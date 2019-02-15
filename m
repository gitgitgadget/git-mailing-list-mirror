Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB0D1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 23:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfBOXcY (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 18:32:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54515 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfBOXcY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 18:32:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so11676978wmh.4
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 15:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ecp6XBE3l8N/0g7TYoErqMwPSR9gV7ipAo8a8alDZr4=;
        b=MGqwOS9ZSBGiZdM6UfVJlvCNVqLCgDX1mbKq9yoSVnEeXmtAbfXu+wAzDyxuoVCeIm
         asKvgy3wd7dCYJQL64ctJaDWpkMAquQ592A4C8pYr9rvEhP+o6dTCAVlTSPO/ODrLAhH
         /Nhm99+tDjbX4jch2PEqLAFx3D6rzrs+63AkcCuGNMS6d8AfCQmsWTvCsKmxcJpWOaDt
         gJvGsGZj0yNJUiUTGAKwfMxIKRrppxMWoerR0z+BLJNf7LZ9NxYJIEozJPNBYoEacPBA
         p6iYi4StYJcme65/kF0Xcjopep8fDoKjvMDMPVrOTg6GOqd434kb3USp9uKUigxH/lqm
         lqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ecp6XBE3l8N/0g7TYoErqMwPSR9gV7ipAo8a8alDZr4=;
        b=i4quuMm5tlMlwrNMDrmR9tzTV31WCxmGAJK0343dUBqbp44GvbBzRUCQCRYsP2boUe
         Yo37cuTsrXK/z5WMEO9C0/CBDJZrA06gY+9Oc9wTwS9cuZ8RdpQNNm0yR6y2RCgPYr5d
         Ah1J+92hZTz0PQjcznd+GGXC5mHe9pCsXmoa/kd/9xfJMYl4v+/eBSXse/B1/DX00k4N
         lKB0cHZ0YlTY8BDbZduG0KZdXinLi3fss1VIUPp4/mhUDhf0fVFGZkZDsez35F6xgzwp
         TWoQfPf2ZEBVr4zQDRmldIg+S6K/ev4fa70DJF1joMgZhInBP50N68drq1LgjLUq/kvp
         7jxg==
X-Gm-Message-State: AHQUAuZ/7wGEwLT794Oh1I3/ESz1jZvS9tlku1Lqqu9RfFs7TNrHpW0d
        GU1oB7eXAXIDVWxoSWB1MEk=
X-Google-Smtp-Source: AHgI3Ib3m0XP9b4VoOjJDUo1CHzHb/2fCkdVgQsDmElRtPcRACVODxvCkr4iE3q2LzRb2lknjdn+oQ==
X-Received: by 2002:a1c:7211:: with SMTP id n17mr8477342wmc.92.1550273541159;
        Fri, 15 Feb 2019 15:32:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u15sm10945230wmu.17.2019.02.15.15.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 15:32:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Git Mailing List <git@vger.kernel.org>,
        vincent.guittot@linaro.org
Subject: Re: [Bug report] git diff stat shows unrelated diff
References: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
        <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
        <xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com>
        <20190215185202.GA28019@dev-l>
        <CABPp-BEmPQb4Q_38S2A_68m+Cu75VDDD2UV0qWBDjL1OUAug9Q@mail.gmail.com>
        <xmqqzhqw4xqe.fsf@gitster-ct.c.googlers.com>
        <ad85402e-0ad2-4f4d-3b66-9250115072c0@iee.org>
Date:   Fri, 15 Feb 2019 15:32:20 -0800
In-Reply-To: <ad85402e-0ad2-4f4d-3b66-9250115072c0@iee.org> (Philip Oakley's
        message of "Fri, 15 Feb 2019 22:48:40 +0000")
Message-ID: <xmqqr2c84ohn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> On 15/02/2019 20:12, Junio C Hamano wrote:
>>
>> Historically, it was a mistake to allow A..B to be used for two
>> endpoints, which was made back when we haven't thought things
>> through.  That is why I stopped "warn to deprecate and then
>> completely remove", as I do not think it would help people very much
>> if "git diff A B" can be spelled with two-dots.
>>
>> But in a distant future long after that happens, by the time nobody
>> remembers what A..B meant for "git diff", I do not think I'd
>> strongly be opposed to reusing it to mean something different.
>
> Would an option be to add a opt-in config to do the warning, rather
> than start immediately at a deprecation warning?

Well, anything would be "an option".  I am not sure it would be
particularly a good option to allow people to "opt" into getting
warned, only to get a chance to train their fingers not to type
double-dot instead of a SP, earlier than other people, though.

> It would give users the chance to test out their usage early should
> the so wish/desire/notice.

I am somewhat puzzled.  What are you trying to achieve by that?

Those who do *not* opt into that "early warning" configuration dance
would eventually be warned whenever they type "diff A..B", and the
timing for that eventuality is not under their control, so quite
honestly, I do not see much point in "giving users the chance".
