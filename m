Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01752C433E9
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 22:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B5A650A9
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 22:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCEWSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 17:18:52 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43]:38668 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhCEWSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 17:18:25 -0500
Received: by mail-ej1-f43.google.com with SMTP id mj10so6457223ejb.5
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 14:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xy0hv/3LKf2IJ34jYgoYSFrUVS7d6eW+heh3bDU3vMU=;
        b=WwQy3Xggo4qDH4XrSYdZkBgRgKpojTjFjz7Jo2Lazbq/YSw67NfEJHphykC093g4wD
         p0gTEvloDepMoRAbvVS2qjeW9WBsICnF7YkuUx5DF2M7eKxvb6bWAXzw2YRZhCwlLwJY
         uytaS7D0HIBgo7kLCaMbLN6hWOYzOPOBKTP9sBvlxTEPW/m2cseF8ytL5hL+nutvCrM0
         uK9yTDnAhaQanzHmXDu5ffSvpXdew779KIcN9Wd2aW3wScGRTC3peUr1j4Vs3I6P+fnI
         r3/vo/JSS0mE9gbaLqrU+KRIxamgisKtsZLV8hQPX22OMToRXSlRN3mq2fki4u3y+yiE
         GtGA==
X-Gm-Message-State: AOAM532at4q1BqyrAH+rUb8HluhE4Fp7CDWJjOJGVlZbSrcEqWqCTk5F
        XnYR8wBC13YzUCItS8vbpbhshb+G34q4kIuxeq0=
X-Google-Smtp-Source: ABdhPJwpE2/wQvXQF02xC/n2LNsd+bSOxs3FVDOrjbuxlWs/tsCmvfETRJajUNq7sSTomH7pSYtLJohjS9f1YY39/Fk=
X-Received: by 2002:a17:906:d8c6:: with SMTP id re6mr4196882ejb.311.1614982703888;
 Fri, 05 Mar 2021 14:18:23 -0800 (PST)
MIME-Version: 1.0
References: <4210f5f1-dd7e-f425-6ab2-e220a33e82bf@discourse.org> <xmqqa6rh9sph.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6rh9sph.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 5 Mar 2021 17:18:13 -0500
Message-ID: <CAPig+cSRKJUhwMagx_h21pJbBiX9paA5cvDbudDNcRVea6g3Mg@mail.gmail.com>
Subject: Re: "git diff-files" command reports differences that don't exist
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Brown <michael.brown@discourse.org>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 5, 2021 at 4:50 PM Junio C Hamano <gitster@pobox.com> wrote:
> This is totally expected behaviour.  In general when you are working
> with plumbing commands like diff-files and diff-index, you are
> expected to do "update-index --refresh" upfront.
>
> A plumbing command "git diff" has an equivalent of "update-index
> --refresh" built into it, but the plumbing commands are designed
> to be used in scripts, and in order to allow scripting programmers
> to avoid making unnecessary "update-index --refresh", e.g.

Did you mean:

    A porcelain command "git diff" has an equivalent...

?
