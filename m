Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A561F403
	for <e@80x24.org>; Sat,  9 Jun 2018 08:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeFIInZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 04:43:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42476 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeFIInX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 04:43:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id c10-v6so1815178pgu.9
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 01:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d/v14jNI8zePt9M2+0ZDFNhgADRUuZjPJwFqLs6WUEs=;
        b=CnlGFLJxnONLGSCKuBBckj7Rph4ZQS2cyIwED8OefvKSPr3BBXHpoaB/XP51Dg8n1u
         wbLbXY+MaKIVxbu9iLUHRKozxyBwuYnXjUPbdEqGUWbatW1F6RH5PG5/TEH8kon0XRAq
         DVqMKzwipdjJ0t0SLt5Zw/1+JL51IOhWdoi9fcs+lBMuuXBjbER5aPLfZEJFf05JSG3o
         QR7ivwzZKhnI2s1myPCMpvlaOvV3Gq50PeRxkHk07t3h3sTILUfCLlwTJ5czKq/FRbaA
         BWbIofYryWf+EEcVaKX+bj+Df49hIDeh84XG3SmtSZFUJhW3jys/qj3HiIzn+Ocm0EuH
         zASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d/v14jNI8zePt9M2+0ZDFNhgADRUuZjPJwFqLs6WUEs=;
        b=GLmuKlN+l8F8j2KTsxIwqN/58OUo3TvLh0zxCASn13/O2fEakzsYi2NjL1g/jAfH3q
         DrdQuiNvwzd8SMTU8QbjaTTDo4UmecwcTIMd+BisMkos+UcBoStB6bs4UhWNKZ24gSUj
         O51evDKllS1ZKkd/VOgleyMJInsYbPWCAg+NzUWR4pT1aYlg+0apr7U/IK/JDD/ReSlD
         Ua0S6RIMmtAzFqRDEGUBnQooIcCBfD00Qh6fR8TRVuzxpcJf+bNYMyIJxyvLw4fhjev2
         +Kn8T6HxME+8t66khBsrbTztMkA+DaysjFJjUFoQBVNcLF0jYu9R3dAdQU55uTUKgjqr
         XZ4A==
X-Gm-Message-State: APt69E1FUGW/tnVXx2/XtRkMxHojqlTYO9/El/UqIConJILa0II+eRzT
        Sxe7dTHVz+wHcsNDeRvqhiEqdfgh7wlgNaG58Fk=
X-Google-Smtp-Source: ADUXVKLSb6g3d5BREArdO5O5CSSSbt3GUwfxf+eo4u8j7NLJuxyOrEIk77sVfgDlAtdVDsbbCvZhmbzxOw8IUymigR4=
X-Received: by 2002:a63:6dc3:: with SMTP id i186-v6mr8253716pgc.316.1528533803352;
 Sat, 09 Jun 2018 01:43:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Sat, 9 Jun 2018 01:43:22
 -0700 (PDT)
In-Reply-To: <20180608224136.20220-10-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com> <20180608224136.20220-10-avarab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 9 Jun 2018 10:43:22 +0200
Message-ID: <CAN0heSoaNotgsvbLv03tqRxC75rXzS6LvvnYBrS=f6pk-Y_x3Q@mail.gmail.com>
Subject: Re: [PATCH 09/20] abbrev tests: test for "git-log" behavior
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 June 2018 at 00:41, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
> The "log" family of commands does its own parsing for --abbrev in
> revision.c, so having dedicated tests for it makes sense.

> +for i in $(test_seq 4 40)

I've just been skimming so might have missed something, but I see
several instances of this construct, and I wonder what this brute-force
approach really buys us. An alternative would be, e.g., "for i in 4 23
40". That is, min/max and some arbitrary number in between (odd because
the others are even).

Of course, we might have a bug which magically happens for the number 9,
but I'd expect us to test for that only if we have some reason to
believe that number 9 is indeed magical.

Also, 40 is of course tied to SHA-1. You could perhaps define a variable
at the top of this file to simplify a future generalization. (Same for
39/41 which are related to 40.)

Martin
