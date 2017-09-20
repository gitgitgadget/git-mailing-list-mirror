Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8521A20A28
	for <e@80x24.org>; Wed, 20 Sep 2017 17:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdITRLh (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 13:11:37 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36117 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdITRLg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 13:11:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id f84so1426470pfj.3
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 10:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M/1gRX3TP7+0mx7YfA4bEv/2/VF3yk7H0uKjgldFO64=;
        b=InQkO8EO7PykhFX3LGQ0uFoOD9tvxZlxIbREoJt2D6p74o/b3+orOLxBC+STUBg8NU
         EvUHPegL9V8dC7D0EBBXGKfjcLrmk+X32HeAyj8hmIgibEbNzU30TSnTc4byXqSfK54Y
         bZu+ptBatursP2SiUPjm1dh2eWaaDkYJnKbbuwaI70Iy9LguMoCesDxYBVTACLUf6720
         3Tzm+jFnH09mCXKbRIh1nXwNgSydWYPAHFi0p+kxRyEFgiHuGyAHplfuDD1jlUti0vrn
         PSRAFwZjY3XBnVJz+n5UYMlJMkxK7HeVx3kH3npBQaCGtmpudOV2EPGnlSFNj5QWzW3D
         /8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M/1gRX3TP7+0mx7YfA4bEv/2/VF3yk7H0uKjgldFO64=;
        b=LGbRNOmdL2OcUryS/cXKqIEwuzTU2yKCVC16BF1LVaS7HchdrdlGXKbRXLpJvvYx+6
         7BVSNJWFAScXwi1+6W+aX4xw5dbRdTyPIs/haca7KcitDPtpeTOQFDbkEpLmqOEJktxO
         x+JzRyNBasoP5+z9nuxFwJi9pIczVO8rD5C2B75YksFE+05jDVk6GlHNofz66Q8U+cXm
         /nP+H1/KRUMy6xQzXN2LnMJf6BJGoMHcadqRF61BPGyYIPxLWqwa+vFpD6gJ4yRkEIqL
         fqHdrldEv4uJmE2F7iuvWbQm6yMSTvXexnnBhGneOcl/QhflklYUrC9uybYLl6kqz2gR
         FWaw==
X-Gm-Message-State: AHPjjUiJoI4XT++5j4CNa4yo/jXgFf2kehggf1i9aWd3oFYHnr8hI9zV
        faN4d9LqswnXCfaJzpbdsg5sJV6ughiNzyRFZsk=
X-Google-Smtp-Source: AOwi7QCUBjKvQeYCOWP0YCijEPB/ilHZtrSgA0PHEDUWeWyK/BOp9pwTkES5eJr2O9kTho1njCaEvFXqTW/JgBeEjbk=
X-Received: by 10.84.185.106 with SMTP id e39mr2720803plg.333.1505927495613;
 Wed, 20 Sep 2017 10:11:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Wed, 20 Sep 2017 10:11:34 -0700 (PDT)
In-Reply-To: <9cd0c22e-d044-b059-39d5-40b401b18b3e@gmail.com>
References: <20170915192043.4516-1-benpeart@microsoft.com> <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-6-benpeart@microsoft.com> <CAN0heSqFsm0BSUzufXjCKNv=JpRpUQzFA9GkKfA6nd_hPhW_qg@mail.gmail.com>
 <9cd0c22e-d044-b059-39d5-40b401b18b3e@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 20 Sep 2017 19:11:34 +0200
Message-ID: <CAN0heSoSLJox6xzVwOibjgaa7tj=L3Pm+0XxVr6LYBp3+t1x6w@mail.gmail.com>
Subject: Re: [PATCH v7 05/12] fsmonitor: add documentation for the fsmonitor extension.
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, David.Turner@twosigma.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 September 2017 at 19:02, Ben Peart <peartben@gmail.com> wrote:
>>> +--[no-]fsmonitor-valid::
>>> +       When one of these flags is specified, the object name recorded
>>> +       for the paths are not updated. Instead, these options
>>> +       set and unset the "fsmonitor valid" bit for the paths. See
>>> +       section "File System Monitor" below for more information.
>>> +
>>
>>
>> So --no-foo does not undo --foo, but there are three values: --foo,
>> --no-foo and <nothing/default>. I find that unintuitive, but maybe it's
>> just me. Maybe there are other such options in the codebase already.
>
>
> I understand the unintuitive comment but the other such options in the code
> base are just above the fsmonitor options as it is modeled on how
> 'assume-unchanged' and 'skip-worktree' work.  Consistency is certainly helps
> the intuitiveness as once you have learned the model, it applies in other
> places.
>
[...]
>
> For better and for worse, I choose to be consistent with how the options
> work (especially the untracked-cache option immediately above).  This is one
> weakness of reviewing patches via email - you don't see the patch in context
> with everything around it.
>
[...]
>
> I'm going to sound like a broken record here. :) The description favored
> consistency with the untracked cache feature immediate above this entry.  It
> is literally a copy/paste/edit.

Oh. Well, that's what I get for "reviewing" by e-mail. You are indeed
following the current style very well! Sorry for the noise.

Martin
