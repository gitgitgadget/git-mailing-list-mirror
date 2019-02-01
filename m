Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4C61F453
	for <e@80x24.org>; Fri,  1 Feb 2019 16:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfBAQPw (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 11:15:52 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:46532 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfBAQPw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 11:15:52 -0500
Received: by mail-wr1-f49.google.com with SMTP id l9so7640866wrt.13
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=XNDZkJwPWNzCLfRGdCLdiJh5ex/Lvi8zZ8KTqbNCf/g=;
        b=iCsQiIZLPWsqfMY8gGXSXCpmoF0vvjDxkIk7ZQx1MTul61vI6m1lWfOejQ3gHjqOir
         Z/WC+2tALt9NvoW+5LR2wtnX+I7ryrKNcgY1hkLxJmanjO0agSVmDK8n0Yp+9+P3OqyD
         7OrmG9hvhw0rymC/1CbUd3OV3Cm2YVHtd4ZziPxSuOKJAIgzOFN8HDD+7iNHxwA1vSVV
         icd5HbRh76jvW+sHuogIo+J5odrrYSpqPQg+UwSsYJoZ6U8FY9oq4Srb9//JYXhEw0N8
         iWFGVBaefw+EHC1Ub+SW+QOE6t+kPq2Q16TN2YWiMiCv2llQxynsmdO7C8++AyIwAL8a
         rIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=XNDZkJwPWNzCLfRGdCLdiJh5ex/Lvi8zZ8KTqbNCf/g=;
        b=Jm0mjHb9tX4xPzRTbTReShUSR9gIgbviN570WD6PlwOAFNARDi3Hp+yMp5DScMD2EW
         jQI43y0ZoeULB/YMsWaCtRZqKtJ0HJqYUsr0rqAfsds22QxWt9YEGESesTK0XHL9WAJW
         YA6CA7DLXDoBLiylPzYrWNKjarFfX5aE1uQG5euR8P5IHWXwNNBA2YmUglLxUj/QQi+D
         8KNzCE55w2NT7HXgdUEzHGWV5OdGxBzwy1Q1OD7NNMDR9puSt/d0QDmblCiQXVv230X6
         d7WvaXTEk2qnJg+RNqoktDQw+sKC6xNcwks/NciKUPtTpsXdlEidZyWYXwvmj2s0rcaC
         BCMQ==
X-Gm-Message-State: AJcUukezWeupo5g2NnOtEJPmtEbEuvLaeDn9XYL1TrTcobL/zAU180n1
        vRVaFPl/gSXTaUeEsHDq3wDPxQOm
X-Google-Smtp-Source: ALg8bN4RGi6123O/mY+Rl7H2tO1XMtT4GOSaNBM16RG3U7PhAUWOhNCKToEBbphSy/dpEvuPmB3Pgw==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr40893725wrm.239.1549037749759;
        Fri, 01 Feb 2019 08:15:49 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.gmail.com with ESMTPSA id w80sm2750447wme.38.2019.02.01.08.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 08:15:48 -0800 (PST)
Subject: Re: Broken interactive rebase text after some UTF-8 characters
To:     Michal Nowak <mnowak@startmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>
 <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net>
 <23c60f2f-43ff-94ec-6100-861c655ec80b@startmail.com>
 <8c43e31b-01d8-a1c5-d19c-8efd0e5c1714@talktalk.net>
 <505c2e2e-c9bc-aa57-c498-2acced0b8afa@gmail.com>
 <2cbb5818-643d-bafd-6721-91e0d291a5fd@talktalk.net>
 <xmqqimy41pdu.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1902010835210.41@tvgsbejvaqbjf.bet>
 <747726ae27ff52509f831c9615f2b102.startmail@startmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c71f63cb-d956-96f5-4770-581a3b6b5543@gmail.com>
Date:   Fri, 1 Feb 2019 17:15:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <747726ae27ff52509f831c9615f2b102.startmail@startmail.com>
Content-Type: multipart/mixed;
 boundary="------------209DE3EC992342C092EC2371"
Content-Language: fr-FR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------209DE3EC992342C092EC2371
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Michal,

Le 01/02/2019 à 10:06, Michal Nowak a écrit :
> Johannes,
> 
> On Friday, February 1, 2019 at 8:38 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Thu, 31 Jan 2019, Junio C Hamano wrote:
>>
>>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>>
>>>>> Are we misusing C formats?
>>>>
>>>> The C standard and POSIX both say that the * refers to the maximum
>>>> number of bytes to print but it looks like it is being treated as the
>>>> maximum number of characters on OpenIndiana.
>>>>
>>>> Johannes - Perhaps we should change it to use fwrite() unless
>>> printf()
>>>> gets fixed and we're sure no other operating systems are affected?
>>>
>>> Avoid such a rewrite, as "%*.s" that takes (int, char *) are used in
>>> many other places in our codebase, if you can.
>>
>> Yes, this would be painful in particular in cases like
>>
>> 	master:advice.c:101:           fprintf(stderr, _("%shint: %.*s%s\n"),
>>
>> where we want to write more than just a variable-length buffer.
>>
>> I am curious: is libintl (gettext) used on OpenIndiana? I ask because
>> AFAIR fprintf() is overridden in that case, and the bug might be a lot
>> easier to fix if it is in libintl rather than in libc.
> 
> here you can see the full output of the OpenIndiana git build: https://hipster.openindiana.org/logs/oi-userland/latest/git.publish.log.
> 
> From what I see there, libintl was found.
> 
> If you believe this is illumos libc bug, it would be cool if someone created an simple testcase, which I can forward to the illumos developers.
> 

I attached a test case to this email.  You can build it with `gcc
test-case.c', and run it with `./a.out'.

Output on my Linux system:

    Before setting locale:
    Expected output:
    áaaa
    Actual output:
    áaaa

    After setting locale:
    Expected output:
    áaaa
    Actual output:
    áaaa

Output on an OpenIndiana system:

    Before setting locale:
    Expected output:
    áaaa
    Actual output:
    áaaa

    After setting locale:
    Expected output:
    áaaa
    Actual output:
    áaaaa

> Thanks,
> Michal
> 
>>
>> Of course, it might *still* be a bug in libc by virtue of handing '%.*s'
>> through to libc's implementation.
>>
>> Alban, can you test this with NO_GETTEXT?
>>
>> Thanks,
>> Johannes

Cheers,
Alban


--------------209DE3EC992342C092EC2371
Content-Type: text/x-csrc;
 name="test-case.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="test-case.c"

/*
 * Test case for OpenIndiana '%.*s' bug
 * Build with `gcc test-case.c'
 * Run with `./a.out'
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <locale.h>
#include <libintl.h>

static void compare_output(const char *str, int len) {
	puts("Expected output:");
	fwrite(str, len, sizeof(char), stdout);

	puts("\nActual output:");
	printf("%.*s\n", len, str);
}

int main(int argc, char **argv) {
	char buf[] =3D "=C3=A1aaaaaa";

	puts("Before setting locale:");
	compare_output(buf, 5);

	setlocale(LC_ALL, "");

	puts("\nAfter setting locale:");
	compare_output(buf, 5);

	return EXIT_SUCCESS;
}

--------------209DE3EC992342C092EC2371--
