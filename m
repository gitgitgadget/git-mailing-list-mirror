Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0E520D09
	for <e@80x24.org>; Tue,  6 Jun 2017 07:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbdFFH44 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 03:56:56 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35269 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdFFH4z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 03:56:55 -0400
Received: by mail-it0-f42.google.com with SMTP id m62so85959924itc.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UzcLJD6NXcOOCWIBPTgXbWYGNCeoUZY24cxHhwxya9o=;
        b=Kohx6IpxcbRRVx9dWn3T08A79YAuSHwsGMd1eYxxJmz60JgObC86ZvfQjoVXQu9PnE
         xLZWD5ou6BdUjGIyiJLkalefiZ74DuRCkuddzuko362aYfdQU0KeqsUiEcvyHNQKHCGi
         Pb2WG1xwUodqYBtoQLMh2MpGAjMEtvVyays71C8wUlpBb/+kpLSGq/sl/iwaZB8thOqj
         XKw7Tekjpj8+sQgwfw9V9Ba46Uoz0c6engBijtqFcnF6Hsofz69rYUsqSz5IrP4cTD7w
         7t29LK14zBVsGrFeO7v6mvlE2R98QD0dKN+WPSAUscxylwrJtKXGock0aAiOmbZL1qR9
         evrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=UzcLJD6NXcOOCWIBPTgXbWYGNCeoUZY24cxHhwxya9o=;
        b=G2OfnYF3Ud5DZ4baHxaXtDP5SuUDoKWwegbvHtkuULbzZwG/lIVqJ3y0UZ8vpRiRkE
         loNvI0fqyP24Stl0aX1/cgIUP//IB8Dec5pZwhkMR/q2m5lTShWcm+GaY28gcVC1f08j
         d+iYVP2DwtOfoXe7aiURZ/F+hWmroB4AXJN/HH9edHgLDLi9dTXcJ0/dK6iQXFLxItw/
         s3f7F3qPObEqGavdyCnT/lNKjLLbILlbduBkbv6Czne7i8cNZAG+N32U+Lnr38CIrUCw
         8V/73il6ZmVipoVriEsr4h7NtlGZH1rY+Jz+c9t+ItW7K8oUHIYCyIdTQE0tQiZc/E6R
         hH9g==
X-Gm-Message-State: AKS2vOxPOVwFWSDDJ474N8rZBC3ybyjDy4YPCErz//bpwqXMjDg20zM6
        vWwd/54iZHPONxjwttvh2lSF5N69neA3z5g=
X-Received: by 10.107.11.215 with SMTP id 84mr9272810iol.231.1496735814653;
 Tue, 06 Jun 2017 00:56:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.33 with HTTP; Tue, 6 Jun 2017 00:56:54 -0700 (PDT)
In-Reply-To: <CAE5ih7-+EzUhjXCCOu_oELof_2X_qf5snoqUZyuRNqEu+p=ewg@mail.gmail.com>
References: <CAPRL90JeQ3i1m7ydYzTCFgtZ4cC+gYEXFeAKvCuAVwPLXpsgXg@mail.gmail.com>
 <CAE5ih7-Nmy2J6zO9mx7g=L7Ey9PnVUcD3wnXBN4_0znwOHaUeQ@mail.gmail.com>
 <CAKOu8-2iBV=sAP0WeRMQFT+0y5cJ1g6A3bQ5x=D=8q9ocxnBVg@mail.gmail.com>
 <CAKOu8-0DG_wQf4ch_MH=rjAncg1iP=uA1U7XHgXe7JNrEJSkGg@mail.gmail.com>
 <CAE5ih79VCpmMmaq0AEW=5HeOmVdpjpSmh=1CheUZbqvbNfBFbA@mail.gmail.com>
 <CAE5ih7_yt4zjju3F34gUTKLPip9T98ow=shZY7EPe3yE8gk32Q@mail.gmail.com> <CAE5ih7-+EzUhjXCCOu_oELof_2X_qf5snoqUZyuRNqEu+p=ewg@mail.gmail.com>
From:   =?UTF-8?B?0JDQvdC00YDQtdC5INCV0YTQsNC90L7Qsg==?= 
        <1134togo@gmail.com>
Date:   Tue, 6 Jun 2017 10:56:54 +0300
Message-ID: <CAKOu8-2mB=fcFUd86vdK+z==0bX3rUvY-VuNjQ-C6t++uik8YQ@mail.gmail.com>
Subject: Re: Git p4 sync changelist interval
To:     Luke Diamand <luke@diamand.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-06-06 10:49 GMT+03:00 Luke Diamand <luke@diamand.org>:
> On 6 June 2017 at 08:00, Luke Diamand <luke@diamand.org> wrote:
>> On 6 June 2017 at 00:29, Luke Diamand <luke@diamand.org> wrote:
>>> On 5 June 2017 at 19:50, =D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=95=D1=
=84=D0=B0=D0=BD=D0=BE=D0=B2 <1134togo@gmail.com> wrote:
>>>> 2017-06-04 14:09 GMT+03:00 Luke Diamand <luke@diamand.org>:
>>>>>
>>>>>
>>>>> >
>>>>> > The problem, as I see it, is that before syncing changes in the giv=
en
>>>>> > range, p4 task does not sync to cl1 version of the repo, and applie=
s
>>>>> > commits to the empty repository.
>>>>> > Is it a bug or my misunderstanding of how git p4 should work?
>>>>>
>>>>> Possibly I'm misunderstanding what you're doing! Can you give a
>>>>> sequence of steps to show the problem?
>>>>
>>>> What I meant is:
>>>>
>>>> 1. Create p4 depot
>>>> 2. Add first.file (CL 2)
>>>> 3. Add second.file (at CL 3)
>>>> 4. Add third.file (at CL 4)
>>>> 5. Modify first.file (at CL 5)
>>>> 4. git-p4 clone //depot@3,5
>>>>
>>>> In this case first.file, will not be represented in the repository.
>>>
>>> Hmmm, it's not working right for me. Although in my case I seem to be
>>> missing the second file.
>>>
>>> It's fine if I don't use the revision range "3,5".
>>
>> It's also fine if I do:
>>
>> git p4 sync //depot@3
>> cd depot
>> git p4 rebase
>
> It seems to be something to do with the code around line 3395 that says:
>
>     if self.changeRange =3D=3D "@all":
>         self.changeRange =3D ""
>     elif ',' not in self.changeRange:
>
> It's finding a lower revision number with which to later call
> importHeadRevision(), but that only seems to be called if the revision
> range does *not* have a "," in it. As a result, we never actually call
> importHeadRevision() and so files end up missing.
>
> The obvious fix of fishing out the "@3" from the "@3,5" revision range
> works in this instance, but breaks some of the regression tests.
>
> Luke

I did the same change before and it worked for me. I'd like to find
out if it is a bug (I think it is), a normal behavior or am I doing
something wrong.

So according to what you say, it is a bug.

Andrew
