Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1D4C001DB
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 16:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjHDQp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 12:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjHDQp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 12:45:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EA3B2
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 09:45:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C6CE1A44E8;
        Fri,  4 Aug 2023 12:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0MOw2foN/NDb
        deCe7nu//J+/GyYcFrI3kCBIfS5px+0=; b=gvKt/D3guCRdITVrZYVZ/iO5GCMH
        S5QZGDf42xM0CimRLsgEO/yYpsQ4RPUtemmF4KDEK3JtzDak5BkRkpY5rVc7yFPs
        IO89NtgUQC5Kdh6B0b2C/WjC40OtCFIHw12uwNllMWPElWWyD/SLg3T3U0gsR0aJ
        zWJfes6f7YRmbOc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91C851A44E7;
        Fri,  4 Aug 2023 12:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4FEC1A44E6;
        Fri,  4 Aug 2023 12:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Matthias =?utf-8?Q?A=C3=9Fha?= =?utf-8?Q?uer?= via
         GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH v2 3/3] docs: update when `git bisect visualize` uses
 `gitk`
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
        <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>
        <042271990895c4cfdedb20c3aed3d4141df610bd.1691122124.git.gitgitgadget@gmail.com>
        <CAPig+cTE__6B3RNbew8sHQQC3ELi9YAArYX5ofXRpMPBzZfmrw@mail.gmail.com>
        <DB9P250MB06922EB40B40F07DBAA1441EA509A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Date:   Fri, 04 Aug 2023 09:45:52 -0700
In-Reply-To: <DB9P250MB06922EB40B40F07DBAA1441EA509A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer=22's?= message of "Fri, 4 Aug 2023
 07:54:34 +0200
        (CEST)")
Message-ID: <xmqq1qgi3ge7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 608FA444-32E6-11EE-B3EA-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias A=C3=9Fhauer <mha1993@live.de> writes:

> On Fri, 4 Aug 2023, Eric Sunshine wrote:
>
>> On Fri, Aug 4, 2023 at 1:22=E2=80=AFAM Matthias A=C3=9Fhauer via GitGi=
tGadget
>> <gitgitgadget@gmail.com> wrote:
>>> This check has involved more environment variables than just `DISPLAY=
` since
>>> 508e84a790 (bisect view: check for MinGW32 and MacOSX in addition to =
X11,
>>> 2008-02-14), so let's update the documentation accordingly.
>>>
>>> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
>>> ---
>>> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.=
txt
>>> @@ -204,9 +204,14 @@ as an alternative to `visualize`):
>>> -If the `DISPLAY` environment variable is not set, 'git log' is used
>>> -instead.  You can also give command-line options such as `-p` and
>>> -`--stat`.
>>> +Git detects a graphical environment through various environment vari=
ables:
>>> +`DISPLAY`, which is set in X Window System environments on Unix syst=
ems.
>>> +`SESSIONNAME`, which is set under Cygwin in interactive desktop sess=
ions.
>>> +`MSYSTEM`, which is set under Msys2 and Git for Windows.
>>> +`SECURITYSESSIONID`, which is set on macOS in interactive desktop se=
ssions.
>>
>> Micronit: SECURITYSESSIONID is not universal on macOS[1]; some people
>> report its presence in iTerm2 and HyperTerm, and perhaps even Apple's
>> own Terminal (although it's not defined for me in Terminal on High
>> Sierra). Perhaps just say "may be set on macOS".
>
> I've just checked in Terminal on Ventura and it isn't set for me either=
.
> I'll reword it.

I'll locally tweak "which may be set on macOS" for now.  It should
be good enough for the upcoming release, right?
