Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51F51F404
	for <e@80x24.org>; Tue, 27 Mar 2018 06:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbeC0GOh (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 02:14:37 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:39436 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeC0GOg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 02:14:36 -0400
Received: by mail-io0-f181.google.com with SMTP id v13so26111034iob.6
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 23:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=spO8yFtGEibqvxzWAfUuCFCOcAVEVlitUOibn1suAGk=;
        b=gms/4qBFwzp8QG3/eeWHjMHc5BFqxAeQAJ7uQvr5AZt1zjJzXtXxd81ycDlWnb9Wwl
         3sxZojDYpE538TjL4kTmw37/W1kHGsrXxFnNTcC+z8RMwHoYeQMU+SwT2z72Jg58xNz6
         hT+nceXgvnjutpe/1eTPBaOhtajUNwAIf98/30IitdIgozxhwnkNNRtQNJ1vUcnJHdlC
         IIW0ZW2kkfcbOLWrWR8sdBKMeAcCOBO26PbNzQps6AVg/8XxxjLBrIF4gmXqpErSKnbH
         CS7aIXuldMSVH5hCX6nd8sH+B6r88ids/ptDKoUFMkTGL5CP24zVq60GcW9hgz2nM8gn
         WA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=spO8yFtGEibqvxzWAfUuCFCOcAVEVlitUOibn1suAGk=;
        b=LXoAHHKq/T5jL8NTgkiUzGxdfIN06ABX1zARi7zE9S/sjFKPqvYbXxRsVtAQ5vfJ96
         Wda/yump07H8m6lX09mtsq5sBFcK1hfEb37ko6yLhuK8xTPAQvVzSjcfnL/+iWP8A1MT
         6oxgmI/PEcSxq8EbNGok9f+ZsHfnik5s7WksosMiZhplbf/34A4ZsNOelvyTwEmKNiVh
         uBywANo/WaXJK4an3U1f3eFGVnOAaAKS90nLGOUfG9sU1ci+otAz7UmSskC8cOFeWeQq
         e19qhemD5J+JMOJjuQYrOBkU82R9Twp5WJDgvoyrxBdcbXlpw+QjcN0aKvPmF+rPqkUv
         g/qA==
X-Gm-Message-State: AElRT7HLsKL09qiizvOISBXPAU4MmrUPd+T5AOCoeBgktYuRBlIdK7eh
        XbBURfz+aIzdBA4gSM0qsysvMJIvgOrXkCLAoSTf0g==
X-Google-Smtp-Source: AG47ELshzgBoC1waJOdteplRTkcxCuztP4mlQiVekbU2UCto0mbkMVJVtO9QbjHvQg77QwqwoEyswhfjb2aIr8CFPw0=
X-Received: by 10.107.93.20 with SMTP id r20mr41937384iob.53.1522131275729;
 Mon, 26 Mar 2018 23:14:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Mon, 26 Mar 2018 23:14:35 -0700 (PDT)
In-Reply-To: <ad524ce4-8be2-4d14-44cc-2fbc9ff60b79@gmail.com>
References: <1521576562.2188.10.camel@gmail.com> <CAP8UFD3NKCSN8mVDiCUzvor5uZh4nFCAw4T0zgxpvHLf9AWmyA@mail.gmail.com>
 <1521760546.11809.20.camel@gmail.com> <CAP8UFD3bRaPke8MvubZ3+v6RrY7K7Peip1dpQ2LG9kxKoXcmbw@mail.gmail.com>
 <6603149f-776a-fde8-5d11-a7d9d6d37e96@gmail.com> <CAP8UFD2y605FQeiymO2JNxy7MXs=-vRcN-Z2ri1=ttDF8kccvQ@mail.gmail.com>
 <ad524ce4-8be2-4d14-44cc-2fbc9ff60b79@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 27 Mar 2018 08:14:35 +0200
Message-ID: <CAP8UFD2Rx2Ykc1VNfqRy=UduNb5n6rQzrwTnZW7LZb1hvcBocA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtHU29DXSBDb252ZXJ0IOKAnGdpdCBzdGFzaOKAnSB0byBidWlsdGluIHByb3Bvcw==?=
        =?UTF-8?B?YWw=?=
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 4:38 PM, Paul-Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
> On 25.03.2018 12:46, Christian Couder wrote:
>>
>> On Sat, Mar 24, 2018 at 8:31 PM, Paul-Sebastian Ungureanu
>> <ungureanupaulsebastian@gmail.com> wrote:
>>>
>>> On 23.03.2018 19:11, Christian Couder wrote:
>>>
>>>>> * Ensure that no regression occurred: considering that there are plenty
>>>>> of tests and that I have a good understanding of the function, this
>>>>> should be a trivial task.
>>>>
>>>> There are a lot of things that the test suite doesn't test.
>>>
>>> Hopefully, by first adding new tests, any eventual bug will be spotted.
>>
>> I was thinking about things like memory leaks that tests cannot easily
>> spot.>
>
> I will do my best and follow best practices in order to avoid any memory
> leaks. However, to make sure that my code is really leak free, I will use
> Valgrind, which is already integrated with the testing framework.

Yeah, but it's still not so easy even with valgrind for a number of
reasons. For example it's difficult to test all the error paths, and
there are also some memory leaks that we accept when we know that they
happen just once and that we are going to exit soon anyway when we
should free the memory.

>> Ok. Feel free to resend another version of your proposal.
>
> Sorry for not sending the whole proposal again. I decided to send only the
> changed parts because the proposal is quite big and I wanted to avoid
> sending the same thing over and over again.

It's up to you, but but fewer people might review it.

> One thing I did not mention in the previous reply was that I also added a
> new paragraph to "Benefits to community" about 'git stash' being slow on
> Windows for a lot of users. I consider this alone to be a very good
> justification for this project and doing this project will be very
> beneficial for the Windows users.

Sure.
