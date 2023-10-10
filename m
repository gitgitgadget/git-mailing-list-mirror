Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EFBCD80DB
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 14:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjJJOCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjJJOCe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 10:02:34 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9362A4
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 07:02:32 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1696946550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxi//q3kUawtrMnVTVztuElRslJsB/Lyqx7lqAJE8PI=;
        b=FBo7gv23M0Ol2/Qw9ViA4KNynqMqrW3eeaWh4C0dcPAVy8ySR0XmtRWyWo0MbwuGxwahlu
        CXNmv3/6gSTLddTstFOdKjJY9WlL6PJoUWEJ1+y5lqV7VJwae3IbV+u4I20fWTLjO2dEjH
        xKYPSPvM84p6J2ka0cquT5PGF5q209qb+SwNJK/n60rEdBi2BVdUcg4JMmwTzJkTFHk39r
        JyluhpAfrxx0S/R3MjH+Siv+ryENMZTONNGXXlIInVX0AD/T6LM0MHmdlsqoAJLC4E1whC
        wfTCMcHpvAs/OOpIZ0BXeYrUUKU9s51het5fThWhaui1IuQzMidk/Y0AmBqacA==
Date:   Tue, 10 Oct 2023 16:02:29 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 11/15] replay: use standard revision ranges
In-Reply-To: <CAP8UFD213MwZmBuK0At5r0O8tHYDnxRTkw9AHak9RwDBdVVq_A@mail.gmail.com>
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
 <20230602102533.876905-12-christian.couder@gmail.com>
 <87legbsths.fsf@iotcl.com>
 <CAP8UFD1_67rNke1y-GV7qX46GXQkNJzw7fXfK=kkUjc-jb5S_g@mail.gmail.com>
 <f412f62bf830b38a296b59ac3470099a@manjaro.org>
 <CAP8UFD213MwZmBuK0At5r0O8tHYDnxRTkw9AHak9RwDBdVVq_A@mail.gmail.com>
Message-ID: <71ddf91938aee4d352f02826bec375e1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-10-10 14:44, Christian Couder wrote:
> On Thu, Sep 7, 2023 at 11:02 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> 
>> On 2023-09-07 10:32, Christian Couder wrote:
>> > On Thu, Jun 22, 2023 at 12:03 PM Toon Claes <toon@iotcl.com> wrote:
>> >>
>> >> Christian Couder <christian.couder@gmail.com> writes:
>> >>
>> >> > +DESCRIPTION
>> >> > +-----------
>> >> > +
>> >> > +Takes a range of commits, and replays them onto a new location.  Does
>> >> > +not touch the working tree or index, and does not update any
>> >> > +references.  However, the output of this command is meant to be used
>> >>
>> >> Small suggestion here:
>> >>
>> >> Takes a range of commits, and replays them onto a new location.  Does
>> >> neither touch the working tree nor index, and does not update any
>> >> references.
>> >
>> > I am not a native speaker, so I am not sure what's best here. I find
>> > your suggestion a bit less clear though, so until a native speaker
>> > agrees with it or maybe finds something even better, I prefer to leave
>> > it as-is.
>> 
>> I'm also not a native English speaker, but I spent about 2.5 years
>> contributing a whole lot to English Wikipedia, so I'd dare to say I've
>> honed my English skills rather well.  Thus, here's my take on this:
>> 
>>      Takes a range of commits and replays them onto a new location.
>>      Leaves the working tree and the index untouched, and updates no
>>      references.  The output of this command is to be used...
>> 
>> This is written in a concise yet slightly imperative way, which should
>> be suitable for the purpose.  I hope you agree.
> 
> I agree and I like it, so I have changed it to the above in version 5
> I just sent.

Great, thanks.
