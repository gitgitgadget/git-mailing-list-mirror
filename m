Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F661F597
	for <e@80x24.org>; Tue, 31 Jul 2018 00:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbeGaByy (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 21:54:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45060 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbeGaByy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 21:54:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id j143-v6so9420663lfj.12
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 17:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O7RJnPI7S5md12fnVVXj5rWI4W/5AlniFKmJyEFBbKM=;
        b=IjwMpruFffdZ31V8MkCROv33bPxVaPiThj6nrDEFl5ukGj5L3FE8+UKOMzCZ34QTp3
         Ezx69HH+9yuDQuGcPKWxK8vYxrkbjPvu1F7EF2ejCHNu5k3ouP0qgScv06kQTROZDREC
         7jhjHg+y0lLvBulr7A1r69f/oPje9LoFKP6C3jOTqsZUFVSiCZIjQXJ8MJ169nN7NkC7
         WXFhgJ6dKUlk81uHRMpQiq2+ektKvLn+2P7TY9EAWeg4bVyoHBVQbTtx7haIMoSUuJtI
         T/odeZUJNCV41VBDU2blQbleXV2mnv57W9sNP1PqncUw2VLQR7bl15vBCAGg9xX63EJa
         3L7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O7RJnPI7S5md12fnVVXj5rWI4W/5AlniFKmJyEFBbKM=;
        b=UB6xZJ0vKSUc5q5WwEl9MIYAm56i/5W6bfmOhNNeWQULZVCxbHNvLwL3k01fPeZTsO
         qqDQ5e2064yAYZmX2zgeqU/Dl2OE0qNTQGD/R5HKxrefHK33Ij7lqvGwch0gmTtmQa0Y
         CmDYwMDxX4qxAMihJhRgNMqcuZqlKM39xwn/df25yLd1nRZpeZrGrYcoWe0O9mAGXpFK
         Grjjxgd3acck+Z2DaClSgDtzMOBm6Anp0YtmhuEozhKWMgBZkxBynpfgurRA9jKxQBhs
         cLc61etw86y7kH9oSxrhC3ORuHL+Y3ai2mpZzlO3h+cMnsuPYNB4d5fPh43ZKCXv0GT9
         IkEQ==
X-Gm-Message-State: AOUpUlGnknK3W4/vz2Iel2DFHYJsXQB5jpHP5MJHtmfOQ/eCGgub1QKB
        zu8XssIFEfWl3Pcswcdjh06IWrGLV3HURTRNunQ=
X-Google-Smtp-Source: AAOMgpeQn+qzD7VCOJfYT08DTiKkBzDidF2YVKieer0kKNmZuVj9eYm4bSVPmr2mSZsleR1p45kIZbW/WnlBabdm9XI=
X-Received: by 2002:a19:10c4:: with SMTP id 65-v6mr12111420lfq.113.1532996243886;
 Mon, 30 Jul 2018 17:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180605154501.13502-1-szeder.dev@gmail.com> <20180727174811.27360-1-avarab@gmail.com>
In-Reply-To: <20180727174811.27360-1-avarab@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 31 Jul 2018 02:17:11 +0200
Message-ID: <CAM0VKjmgx1v9n90qc9rd2uY0Ki51UJb2DvpbP3_mUj59E1NABA@mail.gmail.com>
Subject: Re: [PATCH] tests: make use of the test_must_be_empty function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 7:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Change various tests that use an idiom of the form:
>
>     >expect &&
>     test_cmp expect actual
>
> To instead use:
>
>     test_must_be_empty actual

Thanks for working on this.

> The test_must_be_empty() wrapper was introduced in ca8d148daf ("test:
> test_must_be_empty helper", 2013-06-09). Many of these tests have been
> added after that time. This was mostly found with, and manually pruned
> from:
>
>     git grep '^\s+>.*expect.* &&$' t

This command doesn't output anything as it is, it should be 'git grep
-E ...'.

Furthermore, it doesn't catch the cases when the empty expected file
is written as ': > expect'.  I see that you noticed and converted a
few of these, too, but running

  git grep ': >.*exp.*&&' t/

turns up some more.
