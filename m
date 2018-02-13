Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA9B1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 19:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965564AbeBMTpW (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 14:45:22 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:42898 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965313AbeBMTpW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 14:45:22 -0500
Received: by mail-yw0-f177.google.com with SMTP id e65so4555738ywh.9
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 11:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dr9SPaDb41v5eLWqPioptss4xxcv2tDTAwn0KU/pFcY=;
        b=IoEKjW7BPWnEYxNYbCnjIhyCH1w3Pch4dtJQVRrwrEzuZPF/mWqbV0q/52UTSbHweu
         oUZ5viQzHx5PE73UmqKh5HIlr8D8Q6tNr2fxeqq8zJQrqATNytmdI5fw589XWswHB7Rm
         8RE1Hlyh70Hv0EId2YW4hZfrSXkqQvibPGmGXftVj4TpIcoe75LUQ7L/D5o1T6AFpR2E
         Gxe09MCWQoYkuSiRvRyZfyu8O6rPHN3cCKRVANLf1UuTcRzXGae++Q2HsTWat3M3IYzN
         trepBlM55/b2qs73nLVE8flAYyLppRFP2xGx0TWV2Cwxtch9g+6MnRuVJdRf18KnAeCo
         6IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dr9SPaDb41v5eLWqPioptss4xxcv2tDTAwn0KU/pFcY=;
        b=isMNB5xohw7xlOp/9pDt/CZ0rqIMCEvNLrVcl8o5Qgv124/ySo/AIOcf5NomSY1JO/
         hNyZn0B15zJpuqh6hw6hIDbd1Fvszdfm314pMKcfP4iTenIvwPbR8vs6mc6bLlg2hG/F
         bB6wyUoVpdDS+66W0PyofppAO/ggprZkPjMEje0HnvRobYDeIokt6HB5CCQVQPapgILU
         jQr+IXTlx24D7pM1zJaTF/gF4RziKd/tIaB55mnAdnHxeF7foEfz8Ve0qpcWKqH2BxWm
         cdnhKkpUxVTuyVH68ml3jkfMgOT32oTrbDlI2A68rGg7drkRnqJaLVdVP34qBkva6P/A
         eShg==
X-Gm-Message-State: APf1xPDzRuhBZAiR9zW91BpaVCBO2DQCa4DQTSWmMKeLYONKKVI3Fw6F
        TmhsFGIwdRiF6Vk/1jiz1n2GRl6FJJ4/W06q8XOUyteQ
X-Google-Smtp-Source: AH8x225bv4JL0qpPFFLZJK0lqVC0w05xJHD+TwgAobRtxvVpX75V1JNtIQ90MIK0cQf1JAuyMKxKLa97CaKF3NSyoK0=
X-Received: by 10.37.101.11 with SMTP id z11mr1587382ybb.201.1518551121217;
 Tue, 13 Feb 2018 11:45:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Tue, 13 Feb 2018 11:45:20 -0800 (PST)
In-Reply-To: <8b8f6e8c-9077-793b-81d7-8769eee31e66@web.de>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235508.216277-4-sbeller@google.com>
 <xmqqsha9vmqt.fsf@gitster-ct.c.googlers.com> <CAGZ79kacD5Bevw==v3fbyWmz0FiDDM5ypkYuxHxbXJM62FX40w@mail.gmail.com>
 <xmqqsha5sywh.fsf@gitster-ct.c.googlers.com> <212094a6-f1bd-c4cd-01f9-e819a701cfac@web.de>
 <xmqqbmgtswuq.fsf@gitster-ct.c.googlers.com> <8b8f6e8c-9077-793b-81d7-8769eee31e66@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Feb 2018 11:45:20 -0800
Message-ID: <CAGZ79kYCwvs82xyWoxhVD-am0j8NE-6X3rQ=SbiZd1r_3_q4Qw@mail.gmail.com>
Subject: Re: [PATCH 003/194] object-store: move packed_git and packed_git_mru
 to object store
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 10:52 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 12.02.2018 um 22:48 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> Am 12.02.2018 um 22:04 schrieb Junio C Hamano:
>>>> Stefan Beller <sbeller@google.com> writes:
>>>>
>>>>> I thought it may be a helpful
>>>>> for merging this series with the rest of the evolved code base which
>>>>> may make use of one of the converted functions. So instead of fixing
>>>>> that new instance manually, cocinelle could do that instead.
>>>>
>>>> Having the .cocci used for the conversion *somewhere* would indeed
>>>> be helpful, as it allows me to (1) try reproducing this patch by
>>>> somebody else using the file and following the steps in order to
>>>> audit this patch and (2) catch new places that need to be migrated
>>>> in in-flight topics.
>>>>
>>>> But placing it in contrib/coccinelle/ has other side effects.
>>>
>>> Running "make coccicheck" takes longer.  What other downsides are
>>> there?
>>
>> Once the global variable packed_git has been migrated out of
>> existence, no new code that relies on it would be referring to that
>> global variable.  If coccicheck finds something, the suggested rewrite
>> would be turning an unrelated packed_git (which may not even be the
>> right type) to a reference to a field in a global variable, that
>> would certainly be wrong.
>
> Ugh, yes.  The semantic patch in question doesn't contain any type
> information.  I don't know how to match a variable by name *and* type.
> Here's the closest I can come up with to a safe and complete
> transformation, but it only handles assignments:
>
>         @@
>         struct packed_git *A;
>         identifier B =3D packed_git;
>         @@
>         - A =3D B
>         + A =3D the_repository->objects.packed_git
>

I'll need to play more with coccinelle. :) Thanks for this patch.

> Seeing the many for loops, I'm tempted to suggest adding a
> for_each_packed_git macro to hide the global variable and thus reduce
> the number of places to change at cutover.  Coccinelle doesn't seem
> to like them, though.
>
> A short semantic patch with a limited time of usefulness and possible
> side-effects can easily be included in a commit message, of course..

In the shorter reroll I moved the semantic patch into a subdir of
contrib/coccinelle, but in the next reroll I'll just put it into the
commit message.

Thanks,
Stefan
