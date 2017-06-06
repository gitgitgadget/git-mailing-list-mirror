Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E86320D09
	for <e@80x24.org>; Tue,  6 Jun 2017 07:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdFFHt0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 03:49:26 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:32885 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdFFHtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 03:49:25 -0400
Received: by mail-ot0-f172.google.com with SMTP id k4so11275006otd.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 00:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gPSwPfB4JDY+bP19y3p8Ah47VPGIJDD3J47tT0yhXyA=;
        b=fyI43vTDjgY7ejJMOLXUUBMajZSKhgKdlvdypr4LRHiyXMizvRrEoJfE+fUvaQPYnl
         OODLRQawJC6fPi6s39jj+/UuCfxCuUBJ0Sw0RSQbJ1hgYfR8N7LDxOxboEKzLkJra0VX
         B4xTgxxdtZCbZRkDS7vWeNvWGNZ0a6nuIvAiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gPSwPfB4JDY+bP19y3p8Ah47VPGIJDD3J47tT0yhXyA=;
        b=RgoyGoSx7Arg8b+gPwIwS3uo354DFwyJjs8ucjUfwHaS4PzOPOruAj6aX+60E1I6yU
         u1diOrtnmrF3nVMOU/RgFJqXe6a0fwiSbeqH19MT3+0pcyJ3TNhQRZxAGKGj/x3ff/JR
         RKdLm+/a90eT2bHP5TFEfqubjaraSK8L68mRVaUs37tTDL8wkZfe0oIgDC3iDAMQXIED
         PXyrNIHHneO2vfmSSCv608NPfsuCe6qbf2hqLcZrwhTY58o0P+GNXxZKoFMM6JFw8Y+l
         Se7dBXGfLV0cVZwjsK6TpuJP/uE1G+oMctVRWYwZQ3O7QaNmXnrD6lqpjbR2l1nW+c+j
         nBig==
X-Gm-Message-State: AODbwcC7KHsWRzSplYkZXjo3ayfXYHLXcbzeDZuViR22yULpibPUF/uC
        ruyi0qsVnJlD6cPrsVPz6qyr0NqNYiaH
X-Received: by 10.157.11.18 with SMTP id a18mr12531979ota.253.1496735364490;
 Tue, 06 Jun 2017 00:49:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.62.71 with HTTP; Tue, 6 Jun 2017 00:49:24 -0700 (PDT)
In-Reply-To: <CAE5ih7_yt4zjju3F34gUTKLPip9T98ow=shZY7EPe3yE8gk32Q@mail.gmail.com>
References: <CAPRL90JeQ3i1m7ydYzTCFgtZ4cC+gYEXFeAKvCuAVwPLXpsgXg@mail.gmail.com>
 <CAE5ih7-Nmy2J6zO9mx7g=L7Ey9PnVUcD3wnXBN4_0znwOHaUeQ@mail.gmail.com>
 <CAKOu8-2iBV=sAP0WeRMQFT+0y5cJ1g6A3bQ5x=D=8q9ocxnBVg@mail.gmail.com>
 <CAKOu8-0DG_wQf4ch_MH=rjAncg1iP=uA1U7XHgXe7JNrEJSkGg@mail.gmail.com>
 <CAE5ih79VCpmMmaq0AEW=5HeOmVdpjpSmh=1CheUZbqvbNfBFbA@mail.gmail.com> <CAE5ih7_yt4zjju3F34gUTKLPip9T98ow=shZY7EPe3yE8gk32Q@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 6 Jun 2017 08:49:24 +0100
Message-ID: <CAE5ih7-+EzUhjXCCOu_oELof_2X_qf5snoqUZyuRNqEu+p=ewg@mail.gmail.com>
Subject: Re: Git p4 sync changelist interval
To:     =?UTF-8?B?0JDQvdC00YDQtdC5INCV0YTQsNC90L7Qsg==?= 
        <1134togo@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 June 2017 at 08:00, Luke Diamand <luke@diamand.org> wrote:
> On 6 June 2017 at 00:29, Luke Diamand <luke@diamand.org> wrote:
>> On 5 June 2017 at 19:50, =D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=95=D1=
=84=D0=B0=D0=BD=D0=BE=D0=B2 <1134togo@gmail.com> wrote:
>>> 2017-06-04 14:09 GMT+03:00 Luke Diamand <luke@diamand.org>:
>>>>
>>>>
>>>> >
>>>> > The problem, as I see it, is that before syncing changes in the give=
n
>>>> > range, p4 task does not sync to cl1 version of the repo, and applies
>>>> > commits to the empty repository.
>>>> > Is it a bug or my misunderstanding of how git p4 should work?
>>>>
>>>> Possibly I'm misunderstanding what you're doing! Can you give a
>>>> sequence of steps to show the problem?
>>>
>>> What I meant is:
>>>
>>> 1. Create p4 depot
>>> 2. Add first.file (CL 2)
>>> 3. Add second.file (at CL 3)
>>> 4. Add third.file (at CL 4)
>>> 5. Modify first.file (at CL 5)
>>> 4. git-p4 clone //depot@3,5
>>>
>>> In this case first.file, will not be represented in the repository.
>>
>> Hmmm, it's not working right for me. Although in my case I seem to be
>> missing the second file.
>>
>> It's fine if I don't use the revision range "3,5".
>
> It's also fine if I do:
>
> git p4 sync //depot@3
> cd depot
> git p4 rebase

It seems to be something to do with the code around line 3395 that says:

    if self.changeRange =3D=3D "@all":
        self.changeRange =3D ""
    elif ',' not in self.changeRange:

It's finding a lower revision number with which to later call
importHeadRevision(), but that only seems to be called if the revision
range does *not* have a "," in it. As a result, we never actually call
importHeadRevision() and so files end up missing.

The obvious fix of fishing out the "@3" from the "@3,5" revision range
works in this instance, but breaks some of the regression tests.

Luke
