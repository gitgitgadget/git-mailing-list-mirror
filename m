Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638D41F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfBARaa (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:30:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32774 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbfBARaa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:30:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so5044541wmh.0
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Gbyr8v3uTXi7PL7jhNpteu9rYJFaad3lhV79yhtyBiI=;
        b=Gjtg30mZqocIfjF3Ijbn9WCgvJyJICvTYmfTAToPajLiEcb+6FTj5fskLBEchu8sfA
         WhIfPFZMAVcxB0zu5Z9H/WVa5vT2g6ZNoeODAficdLnNECqEdQWvF6Ui+uUMMY4K1Xxc
         rAXu6UurxYveAGqXX/Y4cNQIH0mu60hBJBhFiP2IIAC/aHS28zidZf3a1gCQgloYvVhp
         bXukmNHXr1rdZ0la6I4Z63gdwIolfYRinPA9XTyFnGLjBLsRToDtHd0azWcJxg7LMV9l
         N5z+bJF4Y4DtziaFHc8gxRfU/4TbtsAiUC6lmggMkkpqZZicB3H7KWXIM+Ko9oZdEMV8
         d2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Gbyr8v3uTXi7PL7jhNpteu9rYJFaad3lhV79yhtyBiI=;
        b=LfPJeXceRxj0kUS/GOyBTdA5HK1HMBwKUmJZkRU+AYDtT+OrjHe0HC6CEzetLGDC/Z
         TgUreCyyvqcbIx1V5pJ6EcLr+2LcdlVROC2d+++0S1MCHP3uP1PRRZB8RwmBj14Ui6qC
         PWRHvLHFZOhjJzXkaccffdZWU77LH7nFq7UsEXmmT1gGwrxHlQOqkrE56LmNLzWjADYp
         yEGV1suj55UTJrHUSphz54FLM9qQB89CGnZWfnN3wAqRvfb5zaJ9e2J0A2GfTa2lVMm9
         MOorDHRs05L8hxtdnbH0p4u/D6NIGJSlyNdMQMwJxP4nQQSiSnCVhuNGBDnPTf2EXFX9
         nVZA==
X-Gm-Message-State: AHQUAuYRvTYl2cL8ppO5IzF9dy2YfA1c/UXIpiEEAbfe6UBE929OpCiP
        Zr8ahSO1zGlchlKnzYc8KBA=
X-Google-Smtp-Source: AHgI3IZChoJ5+XWX4MnTIwbOqojOH6JWrU9UbJIfQdDjSf+steSxY/ubAQkpF9mWJQ2ASjFZV3aZaQ==
X-Received: by 2002:a1c:1d8e:: with SMTP id d136mr3266036wmd.98.1549042228096;
        Fri, 01 Feb 2019 09:30:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b18sm8320987wrr.43.2019.02.01.09.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 09:30:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michal Nowak <mnowak@startmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: Broken interactive rebase text after some UTF-8 characters
References: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>
        <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net>
        <23c60f2f-43ff-94ec-6100-861c655ec80b@startmail.com>
        <8c43e31b-01d8-a1c5-d19c-8efd0e5c1714@talktalk.net>
        <505c2e2e-c9bc-aa57-c498-2acced0b8afa@gmail.com>
        <2cbb5818-643d-bafd-6721-91e0d291a5fd@talktalk.net>
        <xmqqimy41pdu.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1902010835210.41@tvgsbejvaqbjf.bet>
        <747726ae27ff52509f831c9615f2b102.startmail@startmail.com>
        <nycvar.QRO.7.76.6.1902011530440.41@tvgsbejvaqbjf.bet>
        <eda7b1c4-5fd6-5440-8998-75eab9f73e47@startmail.com>
Date:   Fri, 01 Feb 2019 09:30:25 -0800
In-Reply-To: <eda7b1c4-5fd6-5440-8998-75eab9f73e47@startmail.com> (Michal
        Nowak's message of "Fri, 1 Feb 2019 17:24:26 +0100")
Message-ID: <xmqqpnsbzaa6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Nowak <mnowak@startmail.com> writes:

>> You already have that example. Just take the UTF-8 text in your original
>> bug report, put it into something like
>>
>> 	int main(int argc, char **argv)
>> 	{
>> 		char utf8[] = "... your text here...";
>>
>> 		printf("%.*s", (int)(sizeof(utf8) - 1), utf8);
>>
>> 		return 0;
>> 	}

When replayed literally, this is not a very good test.

> {global} newman@lenovo:~ $ cat printf.c
> #include <stdio.h>
> //#include <gettext.h>
> int main(int argc, char **argv) {
>   char utf8[] = "Gergő Mihály Doma\n";
>   printf("%.*s", (int)(sizeof(utf8) - 1), utf8);
>   return 0;
> }

And this is replaying it literally.

The current working suspicion in this thread is that the platform
printf("%.*s", num, str) emits up to num "characters" starting at
str, which is an incorrect implementation, as it should emit up to
num "bytes".  

Notice that the num in this case is the byte count of that utf8[]
string.  That number is always larger than the number of "characters"
for a string with multi-byte character(s) in it.  Let's say that the
sample string has N "characters", and it is N+X "bytes" long, where
X > 1.

If the suspicion is correct, i.e. the way the printf implementation
is broken on this platform is that it shows up to num "characters",
then the call is asking to show up to N+X "characters".  The buggy
printf shows all the available N "characters", notices the string
stops there, and finishes.  So you won't _see_ the bug with that
test program.

Instead, use something like this.

        #include <stdio.h>

        int main(int ac, char **av)
        {
                char utf8[] = "ふabc";
                printf("%.*s\n", 4, utf8);
                return 0;
        }

With or without gettext or i18n, the output must end with 'a' followed
by a newline, and you must not see 'b' nor 'c'.  Otherwise your printf
is broken.
