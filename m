Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F831F453
	for <e@80x24.org>; Sat, 16 Feb 2019 12:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfBPMrz (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 07:47:55 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:21288 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfBPMrz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 07:47:55 -0500
Received: from [192.168.1.12] ([92.29.15.245])
        by smtp.talktalk.net with SMTP
        id uzNngggEb6cDmuzNngLOro; Sat, 16 Feb 2019 12:47:52 +0000
X-Originating-IP: [92.29.15.245]
X-Spam: 0
X-OAuthority: v=2.3 cv=Cal2G4jl c=1 sm=1 tr=0 a=9anTPZJWX8pnfAL1p5p6vw==:117
 a=9anTPZJWX8pnfAL1p5p6vw==:17 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8
 a=WYJzc0_ZHCSmwuK1rrYA:9 a=QEXdDO2ut3YA:10 a=xts0dhWdiJbonKbuqhAr:22
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
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <dca9622d-c8e7-abcb-2e13-73bd8bb9dd84@iee.org>
Date:   Sat, 16 Feb 2019 12:47:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2c84ohn.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfERLPZrkv6ttceZw66sUuUXJN0IcPSSo+3d8+sAM3LYhxnWiCSIwRDfJtTyy8krp0KPj3xJTPrbqFoEttfzSyRs3wXxunO6dB8qwWdTD4hjEXs/lRVcD
 ES+JMoLAqdJfc6rx/BILXAcZVpBa/AbAHZAgjNgi8hp/aiDhBSTHukXdz3ifQlN2YUMkWI6iq8ur69QWCwO3WJFTJmMt5fvNQjMZvDHrNufz1N7H5IuRr3Ff
 fhhrtJMzqTc1fi91euowgh7cwE6f6LehImNhhQ56Rn1vXZczFeC7kMJUr0DYOd90ABh527Uga+Fz+zgEV5bBzmXm0o23nCeg5NZfXqS0FgM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/02/2019 23:32, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
>
>> On 15/02/2019 20:12, Junio C Hamano wrote:
>>> Historically, it was a mistake to allow A..B to be used for two
>>> endpoints, which was made back when we haven't thought things
>>> through.  That is why I stopped "warn to deprecate and then
>>> completely remove", as I do not think it would help people very much
>>> if "git diff A B" can be spelled with two-dots.
>>>
>>> But in a distant future long after that happens, by the time nobody
>>> remembers what A..B meant for "git diff", I do not think I'd
>>> strongly be opposed to reusing it to mean something different.
>> Would an option be to add a opt-in config to do the warning, rather
>> than start immediately at a deprecation warning?
> Well, anything would be "an option".  I am not sure it would be
> particularly a good option to allow people to "opt" into getting
> warned, only to get a chance to train their fingers not to type
> double-dot instead of a SP, earlier than other people, though.
The point of the suggestion was very much to provide users with the 
choice of finger training at their own time and pace, rather than being 
forced by the deprecation sequence to be surprised at an inconvenient 
time into having to respond.
>
>> It would give users the chance to test out their usage early should
>> the so wish/desire/notice.
> I am somewhat puzzled.  What are you trying to achieve by that?
>
> Those who do *not* opt into that "early warning" configuration dance
> would eventually be warned whenever they type "diff A..B", and the
> timing for that eventuality is not under their control, so quite
> honestly, I do not see much point in "giving users the chance".

With the opposite hat on, not giving users the choice does seem unfair 
to those that are trying to keep up. If we are warning (in the release 
notes) of an upcoming deprecation (in the code) then it does seem 
helpful that users could buy into the deprecation early, and at their 
convenience, to assist in the unlearning of an old habit, which can be 
much harder than learning a new habit, hence my comment.

You are right that those who neither notice nor care will be surprised 
later, but we shouldn't let that limit others.

--

Philip

