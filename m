Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E1A2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdKUXfg (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:35:36 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:41876 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdKUXff (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:35:35 -0500
Received: by mail-qk0-f171.google.com with SMTP id f63so14466916qke.8
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hAlcuCiNH1XWxHYg0rMfcMxKTeFfAh7wHY6d61Dai/U=;
        b=URACRQR0aJQ/y5rEhlB2NRG18gPrycxyENC4q44CO9KQ6XqCEHiDVspViw7SP8u7V+
         iZ/2AmJbFqDy5Bpz1KqEwA15zooFvT+g0G3KqgXGNFz42KqO1YmFptFzYO3JxDLy6asA
         Y0FmdABkLEwaLeeL7477j1uAqWH3xg+K/5sulfRedNEHX30o/MaKvU6VHuFQbDxSf+2Z
         OLIosGiyYz2NnxHieTCI4Mx2sfXwdV9Ne7nAHQi3oDNmejlRs4ZkeJug1/+Rp0bpXKRn
         p1KsKHD/Pi/S7XnYJwvMPg/XAmQ1ltTuEyyhqm2M86HfBo6x30K2izjtKZ1e77m+6XOX
         pf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hAlcuCiNH1XWxHYg0rMfcMxKTeFfAh7wHY6d61Dai/U=;
        b=esGL65AlY4IHU2QvW7v7R1mkzwMp0kqt935fwsWAL6T5BmFtrVMcRERFt30Jp4dIwV
         Z898bWE+uNnVIOLrcchbq7udBkCCvaNnPs1prDB3OX/clOHQTAAeQ1dRzpquQDj2aS/H
         bNVdz86EIT/Otm4q0JRFtARZuABfP4xihaYgzlGtKDWrIJ9CAVZO1+yikiVzpMdIRIxd
         NhPzgcQrit9jHsKQw9fPBfhFtMa+7NFFoT6x/okB+JuDV6/dSSez0f+KcTgCNcC09X0x
         JA3T7R6dYPxEU8DrCabAvJzBokb1KiwuO9EnEc7wC7l94oUAWJtaMFOUd7KLS2yZT3Wm
         W2lg==
X-Gm-Message-State: AJaThX6CwApdDJIIkb80ymOAr3IvP3S77mCiFeIXkGgsQZ8ah1mezINr
        h/3fjydPwkiWVZySllriqzPbONSkNASI0u3SB3mWBA==
X-Google-Smtp-Source: AGs4zMatK8WJwp2q1oftB2Ovo41ITubyLMQT5l5CVICLd9GG4Ul/HVbXNW5bGKTqPjz0TDZdoEZmJUXdB4fB09CMuyo=
X-Received: by 10.55.143.134 with SMTP id r128mr17268875qkd.320.1511307334940;
 Tue, 21 Nov 2017 15:35:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 21 Nov 2017 15:35:34 -0800 (PST)
In-Reply-To: <55af5442-c22a-342e-edbd-02a776228345@web.de>
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de> <9c3462e3-2d1d-05bc-9f7d-4bc93d32e7ff@web.de>
 <CAGZ79kZxiEPE4LPEo-eb4Ta4bYXVr9xQM0dFeiJk9XXKU4AR+w@mail.gmail.com> <55af5442-c22a-342e-edbd-02a776228345@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Nov 2017 15:35:34 -0800
Message-ID: <CAGZ79kbL-oXPTgB+tzAUEVJ7K=F44883bW1u93UYgp4kp8r=fA@mail.gmail.com>
Subject: Re: [PATCH 6/6] grep: show non-empty lines before functions with -W
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 2:07 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 20.11.2017 um 21:39 schrieb Stefan Beller:
>> On Sat, Nov 18, 2017 at 10:08 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
>>> Non-empty lines before a function definition are most likely comments
>>> for that function and thus relevant.  Include them in function context.
>>>
>>> Such a non-empty line might also belong to the preceding function if
>>> there is no separating blank line.  Stop extending the context upwards
>>> also at the next function line to make sure only one extra function bod=
y
>>> is shown at most.
>>
>> Can we add another heuristic, that checks for common function body ends,=
 e.g.
>> if the preceding line contains '}' but is not commented (the line doesn'=
t
>> contain '*/' '//', '#'), we have a strong hint that it is a function, no=
t an
>> additional comment.
>
> C comments containing "}" as part of the text would only be shown
> partially, e.g:
>
>         /*
>          * Not shown because of the curly closing brace in ${PATH}.
>          * Shown.
>          */
>
> Two examples in git's repo are in refs.h and sha1-lookup.c.
>
> Before diving deeper: Is it worth it?  Does the heuristic in this series
> produce excessive context often?  Enough to be annoying?

We'll find out... I was just spurting out my thought of the day.
Sorry for the noise.
