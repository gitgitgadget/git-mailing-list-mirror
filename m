Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6297B1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 20:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeKKGXo (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 01:23:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41293 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeKKGXn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 01:23:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id e22-v6so2451387pfn.8
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 12:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJ+Fr9rrepr8DZNjqWgMuIIQbm7vSGRF/QKm/G6py4c=;
        b=JeI3KpFIJtW9s0khVxAMThtQE/u5io3R4oMOgaJDQPl5LrAQqERqDH9PIHNeMcytv8
         42zpVTT4WIG6fTJC55yFgOuho9wBPG4oaqsv0vAlAROuVrq6kzlfEUDpb47bbrXHYgw5
         HqHcRWV68s9CRKV761/sQidX2ZJrUabw45/ZsEtZp6GLPo5fd1k2dkqcf4nTH9rw+lME
         Fk/K1qju3SmIZj3N9rj3IWrtoksk9JUBZNhCeDjh7eFGdYKMDrehvyQ7blpzSk290Oyz
         Oi7Q1UuIwsA20nRIcfF3Do7L51iaZCrR9qBpy4EjBjS9EOC8NpXBZLWBiuPHwhA0eR1C
         IQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJ+Fr9rrepr8DZNjqWgMuIIQbm7vSGRF/QKm/G6py4c=;
        b=TyMHsRCN49ohlt+CjJ9uRJYdH0W6UwmIrZW+6CXDJfVlps6oqV4YFy4BOx7K+RH8TL
         Odoposmz3h0u/koGU0S7Kq3RENVjsDnXwzqYZ12j/fS681djLmbOUR6QtdIo1ltkQSaW
         WAZifOFzpmAHrD9HB06zet3oypaqe2CeaCnW64/HuqGPMR8txZQKdjPuPYellgmXMDbZ
         lY6NBrJpoeBbLZit93fZM8gkfFN9U3RW0zM9szek3aP0juZmRWXhDmZ+dbeLvLoSHVO7
         ehc1CxW/PksjhBuq5T7xuuucX+0GIW0zFIFm00ClzvjL1BLQj5utxPBc/Me3yfDI6tNl
         fhBA==
X-Gm-Message-State: AGRZ1gK9p/a5sNmRrV/q/0EUdrqV8NaD84+wI0zpypqyNT1DvCFNjFg5
        JDzSgUvDhB4vpWY89Yr3mQOjrb/HRHWtiMI1+ZyDyQ==
X-Google-Smtp-Source: AJdET5e/8mCvHYFwJy8bKQAv09PJs7fDlz9/k/j439yJC1+ZPKXfTVN6JqXBrcQgHB3eaZz8eCZ01IXlTV153rhdHi0=
X-Received: by 2002:a62:cfc1:: with SMTP id b184-v6mr14048967pfg.162.1541882247665;
 Sat, 10 Nov 2018 12:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20181108205255.193402-1-sbeller@google.com> <20181110001052.101290-1-sbeller@google.com>
In-Reply-To: <20181110001052.101290-1-sbeller@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 10 Nov 2018 21:37:13 +0100
Message-ID: <CAN0heSqOehMfhpa62MqWtQjOsr4OAgFYU+0J=ds1uZNjP2LeOQ@mail.gmail.com>
Subject: Re: [PATCH] coccicheck: introduce 'pending' semantic patches
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 10 Nov 2018 at 01:10, Stefan Beller <sbeller@google.com> wrote:
> I dialed back on the workflow, as we may want to explore it first
> before writing it down.

Makes sense.

FWIW, this iteration looks good to me.

Martin
