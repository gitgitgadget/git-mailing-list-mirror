Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCB31F404
	for <e@80x24.org>; Fri,  9 Feb 2018 21:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752934AbeBIVOy (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 16:14:54 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37829 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbeBIVOx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 16:14:53 -0500
Received: by mail-qk0-f194.google.com with SMTP id c128so11712311qkb.4
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 13:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=8uu7g46fqJ/VPQohne5q6x+AnorVGrGjvw+Mu9Pqm04=;
        b=hzPyC7PGwhFIFntwQdm24N18tf7OSejdAcRZs6pHlVT7F6OffLpx11Rbf50ocpq8gB
         lOarjajg75YbKTclN1Tq3Q1eghDJAPl9mryohA1yUedoJzOUX7ACbyXbvihJO6U3aVSC
         +fribgUj1f46I2WYmPAOt8Qg0BKA3qAMZVxDVWh8QZ9x3W6c/H00GrDEPcsNH9KlNv8M
         iavjH8xzFQWoybMBcNPercTcA/yTM3dJ7X7+w6smDaw6YtRBDgUiMf809YGgzWfJ9P11
         fLAnvNiHwk9pj9naXOVHpXRhIeyIwKGIid/jcU9dKEJEGAillEMHXF6mEiom9ussEvCh
         +6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=8uu7g46fqJ/VPQohne5q6x+AnorVGrGjvw+Mu9Pqm04=;
        b=XyJH0OywCDASjMM2Rn4x/SxrUwUtLhahrQZJlSkCl3qnn4Si199ZfLgv3EcCtQAcAF
         t39J8UF6Jf/8DMAuphP0zs1u+DvPt4t3+42UtyiqYDk/s90OxjGVv1XxMxSyNcEhBUar
         hmIRotVhvCV9gEe5/cuuWr7DOb3eRwC3dgY3wt7hdGDQSfOHAEz4v1NvqI4lPJUmW8Fa
         au4wD7B7tF/qTD/2vAA1p4VQv8jxqEbKR83YpZnWZP34qccoXHLKc/bdKtCjnAoaGJ49
         O+zIKtsNN+HNuOwsn7gRLWrzH+bCIV86NNtshLjfv3c4b0YU2rbkm/qnqT0zzv7eI4ln
         QOrg==
X-Gm-Message-State: APf1xPBqXUpbHJxmePgNkNmaQpux6w/mAZlxMfg21JVLS2Xn6Nh7Es2M
        Pr4deIGQOPDd0f1wWR6sRcSPG9mlc5ZJYBZSZaw=
X-Google-Smtp-Source: AH8x226EhUGjiQ4PtzSSMwVLwuS3OFkZYSa6Gyl6T2CVxwjqesf88hu63EepHs3zEnfAFUa1GTONfd0y0Hf+J/6mQNI=
X-Received: by 10.55.221.198 with SMTP id u67mr6178998qku.91.1518210892415;
 Fri, 09 Feb 2018 13:14:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Fri, 9 Feb 2018 13:14:52 -0800 (PST)
In-Reply-To: <20180209202733.GA18966@sigill.intra.peff.net>
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com>
 <20180208161936.8196-12-avarab@gmail.com> <CAPig+cS4xhyYSnUHXshB=2SPYELe_HXUwxL-OGU4zx=PMFXdqg@mail.gmail.com>
 <87zi4ikjyr.fsf@evledraar.gmail.com> <20180209202733.GA18966@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Feb 2018 16:14:52 -0500
X-Google-Sender-Auth: M5n2YyR1JYLzN3QGiGOazmcztTo
Message-ID: <CAPig+cSVgzp4CdmzmGo6j31Tiv6Yf3o1EA6gcv_z9gdKvicsyw@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] fetch tests: fetch <url> <spec> as well as fetch [<remote>]
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Daniel Barkalow <barkalow@iabervon.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 9, 2018 at 3:27 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 09, 2018 at 09:05:00PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> >> +               key=3D$(echo $1 | sed -e 's/^remote\.origin/fetch/')
>> >
>> > Faster (thus more Windows-friendly) assuming that $1 always starts
>> > with "remote.origin":
>> >
>> >     key=3Dfetch${u#remote.origin}
>>
>> Tests fail with this and I'm not excited to be the first user in git's
>> test suite to use some novel shell feature, no existing uses of
>> ${u[...].
>>
>> I also think stuff like this is on the wrong side of cleverness
>> v.s. benefit. I can't find any reference to this syntax in bash or dash
>> manpages (forward-search "${u"), but echo | sed is obvious, and it's not
>> going to make a big difference for Windows.
>
> The "u" isn't the magic, it's the "#". I.e.:
>
>   key=3Dfetch${1#remote.origin}
>
> and it's used all over the place in our scripts.  I'm not sure why Eric
> wrote "u". :)

Because I was testing the expression interactively in the shell and
assigned to a variable arbitrarily named "u". When I copy/pasted the
working expression from the shell session into the email, I stupidly
forgot to change the "u" to "1".
