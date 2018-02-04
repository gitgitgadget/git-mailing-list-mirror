Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD8551F404
	for <e@80x24.org>; Sun,  4 Feb 2018 19:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeBDToX (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 14:44:23 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38621 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeBDToV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 14:44:21 -0500
Received: by mail-qt0-f195.google.com with SMTP id z10so37198396qti.5
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 11:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=nJ5uJJVP+abcMJNY+egX7eI94r71GpmFC+bVDBWw3PI=;
        b=ETHRhTQqh5s9egrxD4qcVfvsQvRgLJ5t9QA67AWA3CvGvU8hlQn4rhqayEvCUWaDgN
         SGN5xYpcVcypofKNeWOx9yj8kjPxyUjQUSiaz2YPMj1tOz0hKc/ca/obrsA83SGYBjB6
         cgWxQyWvl6KAbeKGyvOwSKSYCaFU2caVgOrFjXbqBKpV1Jo6nFGdjEWZnJiXiXE+7Qov
         TNGf1pDgHDo0m5e3dJEOq9mLFTc1qbSWRarVVnjZjw/AYGzm98VN4m9yH4pusD+btiKs
         g3FnV+365zgfLyWfZ32bdXZPZqvDqiUJzwpQ94N/ipEFDSlJOkbMvuer2AuzkLM8C8aG
         iPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=nJ5uJJVP+abcMJNY+egX7eI94r71GpmFC+bVDBWw3PI=;
        b=px/X5JDdR7nauZe7cJgeo7YaMOmNZYmpzfVutj4AFLHpi08ijKA9oxCwqYr0Fb3v7D
         G/4p6P4jlkLBXVZv1QYtcxasDN/qkhsPGo+C1IyZVzkHvnnzc4+b+8FaFKF+nBOcbvL5
         jdJJzpo5Cm2bssu6jG/tOBdDOroZGbwdWwG19nMon5FukQMq2iArUmhOmsbN+HOJEizJ
         Ev9JTAuq/1SyaAl8QL8mzTyD62dTks6EFULoOQ5qKpHrVwwYjfS2Pw3srrRB2K1b0G98
         xJsctgGJmpGrGhUVIpRhN27GEvCg4WuL7eczb3MMIkFtBMYZESxAvSLSe3w9naEn8wdd
         hiWg==
X-Gm-Message-State: APf1xPD4rkxdOtcTVEl1pjMGjoTN7UCZycfvhCdQbT8mRMqaLhbNES2j
        ZCywRHDhiF6qCkpir64ITnK8gBavmM1Ga75cp6s=
X-Google-Smtp-Source: AH8x224Ok6lmPpmAzHUGw/pIgAXUdu/LYhlxJeQWtDoS7ykPcgmxFElI8JjAUOgX2jmRcwhVo6EClqXKfU5PozUxtPk=
X-Received: by 10.200.82.8 with SMTP id r8mr9247789qtn.75.1517773461280; Sun,
 04 Feb 2018 11:44:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sun, 4 Feb 2018 11:44:20 -0800 (PST)
In-Reply-To: <871si0mvo0.fsf@evledraar.gmail.com>
References: <772ae5fc-5f92-3494-613a-a44c0073e8d7@lucaswerkmeister.de>
 <20180204183037.23162-1-mail@lucaswerkmeister.de> <871si0mvo0.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Feb 2018 14:44:20 -0500
X-Google-Sender-Auth: oT37YKq9bYTtdl-HddQihHizkBs
Message-ID: <CAPig+cQrG4MchSrgCYeyFf9__XxeEfZ-QGy7Gpzufe0abmbEug@mail.gmail.com>
Subject: Re: [PATCH v4] daemon: add --log-destination=(stderr|syslog|none)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Lucas Werkmeister <mail@lucaswerkmeister.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 4, 2018 at 1:55 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sun, Feb 04 2018, Lucas Werkmeister jotted:
>>            [--inetd |
>>             [--listen=3D<host_or_ipaddr>] [--port=3D<n>]
>>             [--user=3D<user> [--group=3D<group>]]]
>> +          [--log-destination=3D(stderr|syslog|none)]
>
> I micronit, but maybe worthwhile to have a preceeding commit to fix up
> that indentation of --listen and --user.

The '--listen' and '--user' lines are in the "alternate" ('|') branch
of '--inetd' so, as Lucas points out, this indentation appears
intentional, thus seems okay as-is.

>> +--log-destination=3D<destination>::
>> +     Send log messages to the specified destination.
>> +     Note that this option does not imply --verbose,
>
> Should `` quote --verbose, although I see similar to the WS change I
> noted above there's plenty of existing stuff in that doc doing it wrong.

As you mention, there are plenty of existing offenders already in this
file, so probably not worth a re-roll (perhaps Junio can fix this new
instance locally), but certainly good fodder for a follow-up patch.

>> +                     } else
>> +                             die("unknown log destination '%s'", v);
>
> Should be die(_("unknown..., i.e. use the _() macro.

No message in this source file use _(...) yet so probably not worth a
re-roll, but definitely something for a follow-up patch (by someone).
