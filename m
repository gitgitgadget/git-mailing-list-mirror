Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D391F453
	for <e@80x24.org>; Fri, 21 Sep 2018 23:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeIVF2a (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 01:28:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44966 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeIVF2a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 01:28:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so11965609edb.11
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AlLQ/LOii2hPyA/4b+gnHj3ItksISFzQR204i3oKtSs=;
        b=AuQ09BIekxpbHYahpfzVi3uCmj72bcy/iMeYqiocNPwpjCgPIQjpFJR6TbVU9ebMeb
         K5SmMDpS2MRxEfSTnFAiY+x87cJDxgXBDLBnMMcFhILSDF3wy51OKrlr5PJ7KA1fTkPm
         wc8SBca2hoK0vUWaqCrSMnbMscbSAn04RCBWkqCLNRyOWgH4s14wyjuI+DxWqxpOq+CG
         /d3VT2S4Lws/j8ILLnCsD+tpd1dkCJBqzVt6D7MunPtQcxgSuMyVoR1mBB33boGm87wG
         GrIA4X44vn6GhnSBqEFk1cyKbcObMv4+UM1JbtkyKfSjUj1HAl+5hvqxaetUIx/ZVrGd
         v0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AlLQ/LOii2hPyA/4b+gnHj3ItksISFzQR204i3oKtSs=;
        b=LV6GxM38TLKZjFFVpJM3G1BF1YywOXr72+L4BjgXBC8CbdZ2XLpDMj/w+KTFEOpvtI
         GrXbyve1U9JkWmbOdUVo6RJh6bupL3lOVc3laMOGCvJ9Li/Fz9b07X7hwTMWEacJ9mRt
         Y0zBfgkXNrif4bvqDN9SMeus7+neOqPbyRvoE/kkAJsdDHkqECKQWD4/6ebwa2/1K04h
         x4no6wemA0S7POjZhLYGdBwqi8fJmcfrqvevzJeLYQg5xXMMzAm+trN0qbmfXvNSesL5
         1Xd24JL5ZmQP9oltEZL/JNs3aKhblHdzFznA7g1fnoYVMuyLAjlhJ1dIWdwoMukg7EYw
         5ZOQ==
X-Gm-Message-State: APzg51AJE0LheNSwfg+GSRwNNnV43nfpTvwktYT5y4j5E0jrbrC1g1Hd
        Xe2tRGAk+JjS6ZhN6BZyQb7yTOG1vqM=
X-Google-Smtp-Source: ANB0VdYxTAehNDahp8LYy1ivg3ykNliQ/JBpAVd6jcUBY2mW6hUCn/TK+L40oakG3rfhFyJtev51wQ==
X-Received: by 2002:a50:8a66:: with SMTP id i93-v6mr14541299edi.281.1537573040619;
        Fri, 21 Sep 2018 16:37:20 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id h24-v6sm2783262edb.43.2018.09.21.16.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 16:37:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Segfault in master due to 4fbcca4eff
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com> <87pnx6kjn8.fsf@evledraar.gmail.com> <62a46e49-e539-cbb8-4aaf-6f9b5ae6be57@gmail.com> <87o9cqkj6p.fsf@evledraar.gmail.com> <5e7e6519-21c1-daff-65a5-7d2ca5e1dbd4@gmail.com> <xmqqefdmyhe9.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqefdmyhe9.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 22 Sep 2018 01:37:17 +0200
Message-ID: <87lg7ujuc2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 21 2018, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
>
>> On 9/21/2018 10:40 AM, Ævar Arnfjörð Bjarmason wrote:
>>> On Fri, Sep 21 2018, Derrick Stolee wrote:
>>>
>>>>
>>>> This error was reported by Peff [1] and fixed in [2], but as stated
>>>> [3] I was waiting for more review before sending a v3. I'll send that
>>>> v3 shortly, responding to the feedback so far.
>>>>
>>>> -Stolee
>>>>
>>>> [1]
>>>> https://public-inbox.org/git/0bf9103c-9377-506b-7ad7-e5273d8e94fc@gmail.com/T/#u
>>>>
>>>> [2] https://public-inbox.org/git/pull.39.git.gitgitgadget@gmail.com/
>>>>
>>>> [3]
>>>> https://public-inbox.org/git/8d6061de-1654-577c-40c6-211dbd03aa36@gmail.com/
>>> Thanks and sorry for the duplicate report. I can confirm that applying
>>> the v2 of that fixes the segfault for the test case I posted.
>>
>> Thanks for the report! You are a good dogfooder.
>
> Thanks, both of you ;-).  I was aware of the issue and proposed fix
> but forgot about it when merging things down to 'master'.  Sorry
> about that.

Just a follow-up question, in your merge commit you just pushed to
"next" you say:

    Recent update broke the reachability algorithm when tags pointing
    at objects that are not commit were involved, which has been fixed.

And in Derrick's commit message it says:

    [...]but incorrectly assumed that all objects provided were commits[...]

I just wanted to double check (without having the time to dig myself at
this point) whether this bug was understood & tested for, or whether the
case I had was just /also/ fixed for unexpected reasons.

I.e. in my upthread test case I have two annotated tags pointing at
commits, whereas the merge to "next" says "when tags pointing at objects
that are not commit were involved", which I I assume means say annotated
tags pointing at blobs..., but that's not what I had.

Wasn't this just a bug fix that had nothing to do with tags not pointing
to commits, but just ones where we had the simple case of tags pointing
to commits, but they just weren't peeled?

I'm hoping for a "Junio skimmed the fix and wrote a merge message that
wasn't quite accurate" here, but maybe that's not the case and something
might be missing (e.g. missing test code).
