Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7647E207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1039542AbdDUSHA (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 14:07:00 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36435 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423288AbdDUSGj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 14:06:39 -0400
Received: by mail-io0-f172.google.com with SMTP id p80so10408201iop.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YPDUglJGKftzuHm8Yu25RcHf78Un89rK4qFe8bQcAAg=;
        b=cN4tc70XLDz0PPb7itylSD0wUk1bT1k49wh1mjaghxv1c1bkvgxy8f12th13m/JzgI
         CxgozLg52LfcRnJ1//cvh/9x4bktaUg1RsIZXjfe2B9odrUd1Q2HxRCyT7ZJqXbWG6FB
         09kmsIRQFR5ttQAfsgFcc7p4QAOJTAffmnJX0sheWxF4mOUExTx33XFx0szjPw/rDIyS
         PGvYjeFPB5xm6STRef+C/uW5Gs1LjR1az+53eFHMnnIyxw71WiI3XK7S2neBCWayETtW
         ClQ36siY+vK7T1ZxsKDb/+fMMmItJbzA7P9u9iXLEJtdPCTkGEgIGxHXdK7auislEGV9
         eCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YPDUglJGKftzuHm8Yu25RcHf78Un89rK4qFe8bQcAAg=;
        b=YfC4SZ1C/77vt1LxqL9/6qSs18UnqVngJLDGOCgJercZk95KS9CTuZRp72gZTYPvPx
         qYyFgIF+Mo+VVLpA98uliynLv/CTMhrgn8IhvchqO5800xxorIZtPC3dGejw3+oj5zEi
         xyaRM4Wm31DIO81XIFNz94OWihKzzyAR10c4ajunC2Q5GiLGkh4/hJ5tnEGxw80eEd2J
         4ZaTKX4w4AX0Ox6hzNSiLHlsBbb8cqMbmJmeTKPuAmljFXt+xTBJj+dVke2J5pkZnCu+
         Ioioh6MZ3a8UqcigUEn3/uo0x+pPbkR6wn6U9pKzXWdluj61JOi2JR0GKQnv3P5ZGOn6
         4HEw==
X-Gm-Message-State: AN3rC/4RSycZFEMfLHZWTbTsuiyowB1Pz11Zx2X0ia/tyfFJ6x60JN33
        7G84vNfg3l/eA3J0eeTXGDZVJg1zLQ==
X-Received: by 10.107.46.215 with SMTP id u84mr10817538iou.147.1492797932226;
 Fri, 21 Apr 2017 11:05:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Fri, 21 Apr 2017 11:05:11 -0700 (PDT)
In-Reply-To: <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
References: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>
 <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 21 Apr 2017 20:05:11 +0200
Message-ID: <CACBZZX5h90jM4B8GOjt6-L+YNb7vR4qtxHmRwQMFCmHLHRqMKg@mail.gmail.com>
Subject: Re: [BUG] test suite broken with GETTEXT_POISON=YesPlease
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 4:54 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> Am 20.04.2017 um 23:58 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com>:
>>
>> As a refresh of everyone's memory (because mine needed it). This is a
>> feature I added back in 2011 when the i18n support was initially
>> added.
>>
>> There was concern at the time that we would inadvertently mark
>> plumbing messages for translation, particularly something in a shared
>> code path, and this was a way to hopefully smoke out those issues with
>> the test suite.
>>
>> However compiling with it breaks a couple of dozen tests, I stopped
>> digging when I saw some broke back in 2014.
>>
>> What should be done about this? I think if we're going to keep them
>> they need to be run regularly by something like Travis (Lars CC'd),
>> however empirical evidence suggests that not running them is just fine
>> too, so should we just remove support for this test mode?
>
> Right now we are building and testing Git in the following configurations=
:
>
> 1. Linux, gcc, stable Perforce an GitLFS version (used by git-p4 tests)
> 2. Linux, gcc, stable Perforce an GitLFS version (used by git-p4 tests) *
> 3. OSX, clang, latest Perforce an GitLFS version (used by git-p4 tests)
> 4. OSX, clang, latest Perforce an GitLFS version (used by git-p4 tests) *
> 5. Linux32, gcc, no git-p4 tests
> 6. Windows, gcc, no git-p4 tests
>
> 1-4 run the same tests right now. This was especially useful in the begin=
ning to identify flaky tests (t0025 is still flaky!).
>
> We could easily run the tests in 1-4 with different configurations. E.g. =
enable GETTEXT_POISON in 2.
>
> Cheers,
> Lars
>
> *) 2 and 4 use the wrong compiler right now. 2 should use clang on Linux =
and 4 should use gcc. A patch is on my todo list.

Great, thanks. I'll fixup the poison tests then.
