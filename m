Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A943C1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 16:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbeFKQGX (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 12:06:23 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39916 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbeFKQGW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 12:06:22 -0400
Received: by mail-oi0-f66.google.com with SMTP id t22-v6so18364779oih.6
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmLfkyhoZftJFMp59BfW5245Z1HzuGlz2enVOLzSZIQ=;
        b=GcCPHGyfzW+0lJ7ORLhkJp04Onj/DSysUndGym/5X1LisUJeeLXPtcusoHL5mjk3/1
         GDBdASvKDo2zWZ+urigenJv5TG7Rx2YCXbQBTtU4ye74BVsk5y/t9oCRbdN8p/QPuOPr
         jI/Ip6u7jwE1HiEnKOHCUvt3/NbIy7jP6i+qoBzhhO8wBdVcC/r3+ROemV/KaB1wMQE+
         CE8OBxgMKjR5SIp3P/Vz5j5J3UYXYPENeHzwfOn1KQUiSm6N/fMTZXM/Jeemj2JOD9TT
         P5Z28zUQ/ExiSUqBuiP98XwTZuNidlLVCGBX+1muagaXNAhJ/CaRL3IEJdk2T3kahsa9
         XTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmLfkyhoZftJFMp59BfW5245Z1HzuGlz2enVOLzSZIQ=;
        b=fluYsifhibsDVIUYEhc+ePIQSlHGMQU+6FVAF6GibdtAlDsN1ipdEsW44NzzzHDZ07
         LG024tTuqg3sD1tuUrEPwbtWyFP5acX26P3cfQSZbpUB7kngYH8zjdDHF56kQsbs8pfL
         4jJthQ3lJS9LEP/4WoAqU957ZPQQy7TMLw30FUFW8p5NxmlekYZd6cJUuRdpGtcZFFO/
         rRA1qB2vE0pCL510sOAGje33r3ii9LnEBf4ONKuEaIfjZ06s1rKRMKgPMGmrD+J7UjZp
         qe1TXjA9MFEj1Hx9MyXwxCzQ4ASMtZ76JS4UUtl0Hi+nG4MTjm1A6TsQVX9x69MDJ8+U
         UX3g==
X-Gm-Message-State: APt69E1f6qZQz7+BO+7jDzwtEbfiKpK61oSXBw2132DPklHmVoFjCO/K
        ZriHcT2dlNuJ5bxwGxSOYbdDA2VmIMo3NVui6Fg=
X-Google-Smtp-Source: ADUXVKJiuOuo+HteHrdUV9sQLKZpAzAm8IRCarIcVFUXUJtxRpWrMRJkt+EVT5rFpnsDYA7rVngpyUJhyI0M/IaCKwU=
X-Received: by 2002:aca:52c5:: with SMTP id g188-v6mr9199920oib.228.1528733182348;
 Mon, 11 Jun 2018 09:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180606073933.14755-1-pclouds@gmail.com> <20180606165016.3285-1-pclouds@gmail.com>
 <CABPp-BEngspJMEpwoiTq7SCdsQt7fOT_uePS3c6nRxTVqOnNeQ@mail.gmail.com> <CABPp-BGa+v2x1oeitVDMkQf3qFWx6kUT4wdWhCxjWwPyaW=3bg@mail.gmail.com>
In-Reply-To: <CABPp-BGa+v2x1oeitVDMkQf3qFWx6kUT4wdWhCxjWwPyaW=3bg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Jun 2018 18:05:55 +0200
Message-ID: <CACsJy8Ba74iSPf4_zFxuV=_uNJgL6Z2QunOvAvi3qab-6EWi5g@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] Fix incorrect use of the_index
To:     Elijah Newren <newren@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 9, 2018 at 9:58 PM Elijah Newren <newren@gmail.com> wrote:
> I read over the rest.  Found a small grammatical error in a commit
> message.  Found multiple places that still need conversion, from
> pushing up &the_index usages to callers of ll-merge.c and sha1-file.c
> instead of having them in those files, to mixes of _cache_ and _index_
> functions as in apply.c and merge-recursive.c.  However, Duy pointed
> out there was more work to do,

Yes. This is just fyi, 40 patches later, i'm down to leaving the_index
in three files outside builtin/: merge-recursive, notes-merge.c and
transport.c. Even after the conversion we may need some more follow-up
patches because it now shows places where we should _not_ touch the
index at all, which may involve not simply passing NULL index_state to
some functions, but fixing them up to tolerate NULL index_state. So
it's going to be a few patch series until the_index is gone for good
[1].

[1] but like cheap horror movies, there's always a sequel:
the_repository is still spread in many places and hides dependencies
in the same way. We can't do anything about it though until struct
repository conversion is more or less complete.
-- 
Duy
