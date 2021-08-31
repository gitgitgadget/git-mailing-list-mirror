Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93893C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710216054E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbhHaCRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239646AbhHaCRF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 22:17:05 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59AC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:16:10 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso20931721ott.13
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4va2b3vM2kT+S/AbKvuS3H0QrLXqtByb7DQkBPy8UY=;
        b=k7nXD9/kXdtc9pSbYj0/18Ux7QySiwjcDwxJxzV+eAUZAUH4XepdWzX3nZgWSJwFzq
         ZVBhWaDFEglNd8MNZxLoJoVNqt6E45wJ5EVUGAIiLv4KGB83OTE3AF8+ixxfjd6Z4kdq
         2awS/TR0MFCZblSO3HdfASYe97ZbdIgRwpPTDOces/32tIsTU2OR++ipIYxujAfkPehR
         ceAd4knOxYKLueAQ49fng7FFAwL+9yDEcDPsdFwfNvHQ+302HAkp07P+toeamctGYkvS
         y5nnbW76ieiYVYMfKo8whzyhvGasSp6nw8Zolm1rv0coAEfA3YtTMuCKym5uwEkrJOhW
         uiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4va2b3vM2kT+S/AbKvuS3H0QrLXqtByb7DQkBPy8UY=;
        b=uBM3lGvXXmoHL7kGUxWhQKu3Sbi3AUg6OF0chJB0Wp7hhoe1OYX773nrr1FsPTokpu
         RgLM6p3VE/0t6PWmzOK5c49mwWg1Xe8syoj6leO4vKdYyW9Z+L4TdMivO5yGJd0442Eq
         YS3rMqzMsOHL/gtzkrUt4SFbwQDNz99Vu1DQyZjiMor96hu3/K3gAz3XNP3x80V7wVpm
         LFaX8Kjx75rmD4g+LV+OJV+xYrfrGk91gARczPZMAQ3Q4ckRd905mUKTpes+04aG96BH
         JEX/uIt4XnNXHO9lOfmQpMp3jp+GVnfFKwSd7cQcXq6p5uc7yip8w3V3rK1uXHQ7zId2
         y/Ew==
X-Gm-Message-State: AOAM530t/x6b+LizddyYO4nJekM7cTzWDuPz/KX7h7h3q3F+tMaS8JZb
        tq7Roueyo9RNDtHAjvRzY3kO3F0akBEPkaxPCCs=
X-Google-Smtp-Source: ABdhPJxQQ58u0UK9qUA/awm9cTVl42In+OCs+V2MXhW9lcNb8kegcETaHQNM80/fsqFjliL9b0sPdnQpO90s7h+h0JA=
X-Received: by 2002:a05:6830:b8e:: with SMTP id a14mr21869166otv.162.1630376170054;
 Mon, 30 Aug 2021 19:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <c0557284-8f82-76cc-8c47-0b1bc9f2ce5a@rawbw.com>
 <CABPp-BFwvDY6-6pQ2MSPzAGafONjTEMNUkLwuRuQCJ_wx2ns2w@mail.gmail.com> <xmqqv93n7q1v.fsf@gitster.g>
In-Reply-To: <xmqqv93n7q1v.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Aug 2021 19:15:58 -0700
Message-ID: <CABPp-BFE_LB=MYcJ80g=6OjvcXh-SjR_9_ynVdX5i9ruGBqh2Q@mail.gmail.com>
Subject: Re: Git re-creates newly added directory when it is pushed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 29, 2021 at 5:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> Why does Git have to delete and then create again the directory when it
> >> is already there?
> >>
> >>
> >> This isn't a big issue, but it is very odd that git deletes the working
> >> directory.
> >
> > It was deleted by the rebase operation, because rebase (currently)
> > works by first checking out the target commit onto which it will apply
> > all your local patches.  That target didn't have the directory; the
> > directory was added by your local patches.  So checking out that
> > commit necessarily deletes the directory.  Then rebase applies each of
> > your local patches, one by one, updating the working directory as it
> > applies them.  Since your local patches create that directory, it gets
> > re-created by this process.
>
> This is one of the reasons why "rebase" (especially "rebase -i") may
> want to insist starting at the top-level of the working tree, like
> "git bisect" does.  Because running the command from a subdirectory
> works most of the time until it doesn't, people tend to complain why
> they should go up to the top-level before they can run the command.
>
> And this is why---it causes end-user confusion.

Makes sense to me; I'll submit a patch.
