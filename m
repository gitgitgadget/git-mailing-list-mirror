Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CE4F1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 23:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfBQXe4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 18:34:56 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:7464 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfBQXe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 18:34:56 -0500
Received: from [192.168.1.12] ([92.29.15.245])
        by smtp.talktalk.net with SMTP
        id vVxUgERuw4EosvVxUglWrA; Sun, 17 Feb 2019 23:34:53 +0000
X-Originating-IP: [92.29.15.245]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ff5JO626 c=1 sm=1 tr=0 a=9anTPZJWX8pnfAL1p5p6vw==:117
 a=9anTPZJWX8pnfAL1p5p6vw==:17 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8
 a=vZxbLtyPAAAA:8 a=lCr3sc1wseVbmNHtN_EA:9 a=uOyBHKj0Es2mBTtG:21
 a=nXtF0oKf28CCrlPZ:21 a=QEXdDO2ut3YA:10 a=xts0dhWdiJbonKbuqhAr:22
 a=YIznc7gRMHvxYRuyG5Sm:22
Subject: Re: [Bug report] git diff stat shows unrelated diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Git Mailing List <git@vger.kernel.org>,
        vincent.guittot@linaro.org
References: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
 <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
 <xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com> <20190215185202.GA28019@dev-l>
 <CABPp-BEmPQb4Q_38S2A_68m+Cu75VDDD2UV0qWBDjL1OUAug9Q@mail.gmail.com>
 <xmqqzhqw4xqe.fsf@gitster-ct.c.googlers.com>
 <ad85402e-0ad2-4f4d-3b66-9250115072c0@iee.org>
 <xmqqr2c84ohn.fsf@gitster-ct.c.googlers.com>
 <dca9622d-c8e7-abcb-2e13-73bd8bb9dd84@iee.org>
 <xmqq1s473x63.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <d2127f77-9124-0e01-e96b-b6a1650ebc59@iee.org>
Date:   Sun, 17 Feb 2019 23:34:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq1s473x63.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfFHRMsjqhYlVDF++VKTMT6qSQvFECmAahU6ThK0ztatSXF2UK1ycxgIJWG1ljwCCXUyPML/WVZTjiYvv4o0DMi80GDD2QzcYV/2faXJYn/6B01Nr+UwV
 yPrVccp7FW4hpDe+HZ2lPDBNyUlvaE4PD5dFBQbM857fwdlX/jsFRrCZPUJnrQQsTJ0+3kbksitt7/69b5wUWcKNu9asCp+k+ST3PVOryM5GoPrUUYS5NWkm
 83sk2RFQG+dW/AWUrrHQJolDyl35Q7XsmsEIzMI09G1KYtHOPscTav3qeayBObXOSWRyrqavcfi1qdIljUH4qdkVuhIkPusr23b97MUUWuQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 17/02/2019 03:34, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
>
>>> Those who do *not* opt into that "early warning" configuration dance
>>> would eventually be warned whenever they type "diff A..B", and the
>>> timing for that eventuality is not under their control, so quite
>>> honestly, I do not see much point in "giving users the chance".
>> With the opposite hat on, not giving users the choice does seem unfair
>> to those that are trying to keep up. If we are warning (in the release
>> notes) of an upcoming deprecation (in the code) then it does seem
>> helpful that users could buy into the deprecation early, and at their
>> convenience, to assist in the unlearning of an old habit, which can be
>> much harder than learning a new habit, hence my comment.
>>
>> You are right that those who neither notice nor care will be surprised
>> later, but we shouldn't let that limit others.
> I still do not quite get where you are coming from.  Are you saying
> that those who do not opt into the early warning may get 2 cycles
> (just picked out of thin-air) of deprecation period, and with an
> optional early warning feature, those who feel that 2 cycles is not
> long enough to train their fingers would spend 3 cycles and they
> will be helped than without?

It was my understanding that the end point would be total removal of any 
options and the typing of the double dot would be an error. Given that 
hard end point I was looking to ensure that users of double dots have a 
manageable route to unlearning old bad habits. Thus the first phase 
would be opt-in, the second phase opt-out, and on the third final phase 
it would be a non-optional error (assuming your first comment in [1]).

>
> That line of thinking sounds somewhat ridiculous---where does it
> end?  If those who opt into would find it sufficient to have 3
> cycles to train, there may still be people who feel 3 is not enough
> and want to have 4.  As we make it longer, we'd cover more people
> and at some point we'd reach the point of diminishing returns.
The length of the phase 1 is your choice, but having a zero length (as 
some discussions implied) felt too short. For me, one cycle of users 
'opting-in' to do their testing and training given a deprecation 
notification would be sufficient.
>
> Wouldn't it be even better, and far simper, to just extend the
> deprecation period to that many cycles to make it long enough for
> majority of users' needs, without any early warning option?
>
> The thing is, once you train your fingers,
To train the fingers, and to check local scripts and aliases, the user 
needs feedback, preferably at a time of their convenience (as opposed to 
being a time of inconvenience), so assuming they have been paying 
moderate attention to the release notes, providing the opt-in phase 
gives them that.
>   it does not matter to you
> if the deprecation warning is still there, as you'd not be typing
> "diff A..B" at that point.  So I am not sure who you are trying to
> help by the early warning option.
>
> Thanks.
I do note that you had indicated at the end of [1]: "I am not sure if it 
is worth the deprecation cost, though.", so this may be a bit of a mute 
point anyway.

Philip

[1] <xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com> "then eventually error 
out when two-dot notation is used"

