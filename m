Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFACC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 20:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA94D61CF2
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 20:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbhF1U7e convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 28 Jun 2021 16:59:34 -0400
Received: from elephants.elehost.com ([216.66.27.132]:51853 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbhF1U7d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 16:59:33 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 15SKv2nw035374
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 28 Jun 2021 16:57:02 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Jeff King'" <peff@peff.net>
References: <60bfadc0aca09_1abb8f208fd@natae.notmuch> <60da10df509f0_1b95d2089c@natae.notmuch> <029001d76c4d$f3277550$d9765ff0$@nexbridge.com> <60da1c8de0ca7_1cdb420832@natae.notmuch> <029101d76c54$9f713c50$de53b4f0$@nexbridge.com> <60da2692e8029_1d6fc20855@natae.notmuch> <029701d76c57$f4d42f60$de7c8e20$@nexbridge.com> <60da2e775c3fb_1da1f2086c@natae.notmuch> <029901d76c5d$6137bc80$23a73580$@nexbridge.com> <60da363b3c532_1dcf420821@natae.notmuch>
In-Reply-To: <60da363b3c532_1dcf420821@natae.notmuch>
Subject: RE: How dow we educate our users to configure less?
Date:   Mon, 28 Jun 2021 16:56:56 -0400
Message-ID: <029a01d76c60$24ad0ce0$6e0726a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLK5VbO1QXZ22LbQIM9Dq3E2wuv8AGhat+SArgTc9YCRJzpcAI2PCR1AgaYml8Cl6Re2AJlmnZkAqP2EH8Cc3aSH6ibd3KQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 28, 2021 4:51 PM, Felipe Contreras wrote:
>To: Randall S. Becker <rsbecker@nexbridge.com>; 'Felipe Contreras' <felipe.contreras@gmail.com>; git@vger.kernel.org
>Cc: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org; 'Ævar Arnfjörð Bjarmason' <avarab@gmail.com>; 'Jeff King'
><peff@peff.net>
>Subject: RE: How dow we educate our users to configure less?
>
>Randall S. Becker wrote:
>> On June 28, 2021 4:18 PM, Felipe Contreras wrote:
>> >Randall S. Becker wrote:
>
>> >I'm saying the **opposite**. I'm saying this should be done in builtin/help.c *not* .profile.
>> >
>> >> Admittedly, I am in a highly complex situation, but it is a real
>> >> one (ok, two because of a diverged path between NonStop and MVS)
>> >> and there are hundreds in a similar situation.
>> >
>> >My patch [1] should work in all your environments.
>>
>> Your patch will work in the environments but not in the use case I
>> tried to explain. I do not want a single configuration of less colours
>> in .git/config or ~/.gitconfig. That is not going to work in my
>> situation. I have multiple less colour values that would apply within
>> a given arbitrary timeframe. The configuration depends on the specific
>> terminal type set in the environment, either dumb, vt220, t653x,
>> xterm, cygwin, all of which may happy in short succession. I do not
>> expect it to be practical to change my git settings to conform to this
>> patch, so I am trying to point out that I do not see how it can solve
>> my issue.
>
>Are you talking about color settings? If so, what are the values of
>LESS_TERMCAP_* that you have configured?
>
>> The current support, using the TERM environment variable, which is
>> passed to git in all situations either by the system itself on through
>> scripts as is the case with Jenkins, is mostly sufficient for less and
>> git to find its appropriate termcap on all platforms that I use on an
>> ongoing basis (Windows Cygwin, NonStop OSS, NonStop GUARDIAN, Ubuntu,
>> MacOS, MVS, USS, Jenkins). The NonStop GUARDIAN environment does
>> present some paging issues that do not work correctly in some cases
>> with some terminal emulators, but that's the emulator's problem, not
>> the termcap specifically.
>>
>> So what am I missing?
>
>You still have not explained why this would not work on any of your
>environments:
>
>  setenv("LESS_TERMCAP_md", GIT_COLOR_BOLD_RED, 0);
>  setenv("LESS_TERMCAP_me", GIT_COLOR_RESET, 0);

I am not saying it will not work technically. Suppose I have a terminal session using t653x, which is not vt220 compatible - meaning it does not use GIT_COLOR_BOLD_RED or even have the concept of bold red) and do a git log or git help. I have another session using vt220, which works as configured. I have a third session running in Jenkins that keeps things up to date and is a terminal type dumb. Your patch appears to imply that I need to run git config to change the values associated with colours to make things work, correct? So how do the three sessions all work simultaneously or do I only get to use one of them at a time and reconfigure when I want to use a different terminal?

