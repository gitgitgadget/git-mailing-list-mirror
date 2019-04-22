Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705AA1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 19:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfDVTQb (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 15:16:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40164 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfDVTQb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 15:16:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id a28so9750892lfo.7
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 12:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWRAmWU3T6RvgUB4S1FLXdSBxcOr4BbPWF1+DxfN21M=;
        b=b/cCikW6/7oAsuiGCNja3JuRvVNHzUBeyBwLwk3WKfCSrXc3Z5F2VzClxLz5/MT3Pi
         5vMZPZDRktPDZi4aFxz+jSNfl+IR34esm/6tuABL2FLxdv8quCf8r3WB1I1+e8LzfHAd
         W0pf1M0utoLzt1NYIUd8kyeDz33klAfcFHsi9fyrjwa98H74D2272w2LnNvSX0JAWEvr
         TiwoBn+rn/B74v5NXPoihei74yoacLKcjql4j6SQVncm6nFPdRA6l5dGTlE2cdooRpEf
         6tIDU2T4kd7BupZyhkggLdcCBTYVW6xaAJ5aRU83LbWt5cO0kI8GoiFL9RdYcCGJKdyu
         V4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWRAmWU3T6RvgUB4S1FLXdSBxcOr4BbPWF1+DxfN21M=;
        b=ohOAA8GjtJ+sbngJLn9h6qbu8/PiKNro99BV29cQLByOphiVQjZcnUYkRprWbxZXXv
         kXDjG3H87RrVw0lV+RygxPopx/RiY+246DtW/HvXucu+yRCphIKHPzlPxlczo/6O1tGr
         PJnic9nXKN3rzVk4EGT1qsbSp06EMyl5OcNk3Wxa3TSKa7IsJ/CRONWCpXFvPpomuIZR
         58uXG5kJJQAzVJRk4tr78ffI5raFg+P8wdktg7dB/m91Nfe9qbwMiszYg0Q9J9AGBXDR
         rxB47WrgiVjeJ4ZbnkEL8jHsSdo79O7bzJlWmkj4JhlIRi+5TpI8V+3fYx7AK61U2Z+D
         M0Kg==
X-Gm-Message-State: APjAAAV/ljSdlu3kGeZx+hh8g3BWO0Vw3ek9xDHuZV/f8Cjhlhr/i/Kp
        fDJyPmRU4oxK+pm9ifxANvGuRaBo+Pftx7mogeY=
X-Google-Smtp-Source: APXvYqwWL/80Dt7LPJepPnjk/kTTCEydYuRkJU/cKu5cwA5Ofzmclg6UnelI8iNnLK9iMAblAQk8JjQbA6GjMryv7Qw=
X-Received: by 2002:ac2:4465:: with SMTP id y5mr11121631lfl.82.1555960588774;
 Mon, 22 Apr 2019 12:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190422000712.13584-1-phil.hord@gmail.com> <xmqqk1fm9712.fsf@gitster-ct.c.googlers.com>
 <623d6ebd-60c4-916d-6295-4c648dbf3932@gmail.com>
In-Reply-To: <623d6ebd-60c4-916d-6295-4c648dbf3932@gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Mon, 22 Apr 2019 12:16:16 -0700
Message-ID: <CABURp0r9DBxoxLjjynNj-px7mFBA5--ZS7SoNniNu7MLPZkqwg@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] rebase: add switches to control todo-list setup
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 7:44 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> Doing "git rebase -i master" and then editing the todo list has the side
> effect of rebasing the branch. Often I find I want to amend or reword a
> commit without rebasing (for instance when preparing a re-roll). To do
> this I use a script that runs something like
>
> GIT_SEQUENCE_EDITOR="sed -i s/pick $sha/edit $sha/" git rebase -i $sha^
>
> and I have my shell set up to interactively select a commit[1] so I
> don't have to cut and paste the output from git log. I've found this
> really useful as most of the time I just want to amend or reword a
> commit or squash fixups rather than rearranging commits. The script
> knows how to rewind a running rebase so I can amend several commits
> without having to start a new rebase each time.
>
> So I can see a use for --edit, --reword & --drop if they selected a
> suitable upstream to avoid unwanted rebases (I'm not so sure about the
> others though). If you want to rebase as well then I agree you might as
> well just edit the todo list.

I have the same need.  I plan to have some switch that invokes this
"in-place rebase" behavior so that git can choose the upstream for me
as `mergebase $sequence-edits`.  In fact, I want to make that the
default for these switches, but that feels too surprising for the
rebase command. I plan to progress like this:

    # --in-place switch is not supported; manual upstream is given by user
    git rebase --edit foo foo^

     # --in-place switch is added; now we can say this
     git rebase --edit foo --in-place

     # prefer in-place edits as default when editing
     git config --add rebase.in-place-edits true
     git rebase --edit foo

This --in-place switch would use `mergebase $sequence-edits` to find
my upstream parameter if I didn't give one explicitly.

This config option set to true would tell git to assume I meant to use
--in-place whenever I use some sequence-edit switch and I don't
specify an upstream.

I have written some of this code, but since I am running into
conflicts with next and pu, I haven't ironed it out yet.

Phil
