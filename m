Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403BDC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2400561CAF
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbhF1UBE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 28 Jun 2021 16:01:04 -0400
Received: from elephants.elehost.com ([216.66.27.132]:41318 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhF1UBC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 16:01:02 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 15SJwP0n031099
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 28 Jun 2021 15:58:25 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Jeff King'" <peff@peff.net>
References: <60bfadc0aca09_1abb8f208fd@natae.notmuch> <60da10df509f0_1b95d2089c@natae.notmuch> <029001d76c4d$f3277550$d9765ff0$@nexbridge.com> <60da1c8de0ca7_1cdb420832@natae.notmuch> <029101d76c54$9f713c50$de53b4f0$@nexbridge.com> <60da2692e8029_1d6fc20855@natae.notmuch>
In-Reply-To: <60da2692e8029_1d6fc20855@natae.notmuch>
Subject: RE: How dow we educate our users to configure less?
Date:   Mon, 28 Jun 2021 15:58:19 -0400
Message-ID: <029701d76c57$f4d42f60$de7c8e20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLK5VbO1QXZ22LbQIM9Dq3E2wuv8AGhat+SArgTc9YCRJzpcAI2PCR1AgaYml+o7ArnkA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 28, 2021 3:44 PM, Felipe Contreras wrote:
>Randall S. Becker wrote:
>> On June 28, 2021 3:02 PM, Felipe Contreras wrote:
>> >Randall S. Becker wrote:
>> >> On June 28, 2021 2:12 PM, Felipe Contreras wrote:
>> >> >Felipe Contreras wrote:
>> >> >> It has been suggested that we "educate our users" to configure
>> >> >> less in the right way, instead of colorizing man pages ourselves [1].
>> >> >>
>> >> >> The question is *how*? Nobody has answered that.
>> >> >>
>> >> >> This is a continuation of the thread below.
>> >> >
>> >> >> I am still waiting for an explanation.
>> >> >>
>> >> >> How does the user properly colorize man pages for both man and
>> >> >> git in a way that works in all distributions?
>> >> >
>> >> >No response.
>> >>
>> >> I think you're looking for something does not exist because it is
>> >> platform and environment dependent.
>> >
>> >Yes, but there's always some common denominator.
>> >
>> >> There are two ways to configure git to work with 'less' on NonStop
>> >> and neither is identical to Ubuntu or Windows.
>> >
>> >But I'm not talking about configuring git to work with less.
>> >
>> >Once you have less configured, how do you add colors? For example how do you turn bold into red bold?
>> >
>> >> Don't even get me started on what less does in a TSO/ISPF
>> >> environment where everything is some single colour on black unless
>> >> your emulator supports 3279 emulation.
>> >
>> >Is it even possible to add color there? I'm talking about platforms where color is possible in the first place.
>> >
>> >> >It's safe to say at this point that nobody knows what that configuration would look like.
>> >>
>> >> Nobody, perhaps, knows how to do this on every platform in the
>> >> known universe 😊. There is no "one way" to do this consistently everywhere.
>> >
>> >In the platforms where color is supported, and you have less, what does this do?
>> >
>> >  LESS_TERMCAP_md=$'\e[1;31m' LESS_TERMCAP_me=$'\e[m' git help git
>>
>> This only works in bash/shell. So if you are not initiating from a shell, you cannot use this technique.
>
>I know. The technique is not the point. You can use whatever technique you want to get LESS_TERMCAP_md and LESS_TERMCAP_me set
>on the environment before launching `git help git` in whatever way you want.
>
>Now, clearly that technique would vary platform by platform, which is precisely why I'm proposing to do it inside `git help` itself [1].
>
>Clearly this would work on every platform that has less and color and it's technique-independent:
>
>  setenv("LESS_TERMCAP_md", GIT_COLOR_BOLD_RED, 0);
>  setenv("LESS_TERMCAP_me", GIT_COLOR_RESET, 0);
>
>Would it not?

Less is obviously used across the board (git log, git help, etc.). The assumption of the same starting point for all situations is not valid. For example: my own environment runs git from the following starting points (in order of frequency):
1. Cygwin (bash, yay, easy).
2. OSS (Posix-like, bash, easy).
3. Jenkins (dumb terminal, no colours or else the output gets messed up).
4. GUARDIAN (Not at all Posix-like, I have to supply my own environment variables and the terminal emulator is not vt220 compatible).
5. USS (Posix-like, bash, easy).
6. TSO/ISPF (Not at all Posix-like, I have to supply my own environment variables and the terminal emulator is not vt220 compatible).

In the case of 2-4, this all happens on the same system. Same with 3,5,6. So I have to maintain multiple "less" profiles to maintain output sanity. I cannot do this using .bashrc or .profile because those do not apply. If I had to suffer a single definition set within git, I would lose my mind.

Admittedly, I am in a highly complex situation, but it is a real one (ok, two because of a diverged path between NonStop and MVS) and there are hundreds in a similar situation.

-Randall

