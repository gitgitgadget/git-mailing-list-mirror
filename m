Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD14C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJLVnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJLVm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:42:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A453C1217DE
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:42:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c24so77952pls.9
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SxBbFAtt62/SvY9e9+nVnOlCBdHRV0j64UHWDL89544=;
        b=TeLATwriG4RMZiY5PG12qWw/nnxL/uQocAp6jqbIQxoNRpE2CEW9EEruX+1SJ0m1Bk
         prbYEImSVFxUg6BR/whZQ8AwaljzLpROfnABn8pHxUNfkBVa7ULOft4dMjd/eRed8k1L
         6FbAgoEqLqf1nNfmkerJ4o2qr6TKe9r+hwR6XrHo//44JZl71sQHeslsBgVjRUW3n1Zf
         8SlXXL7c8i3ZbMjagjvFgk5gFhaCqgSN1KOWSExX8xbKNF8gsTBqnkA1tOchC378nli1
         zzwzDtg1yDTy/XmzNwGjXsgdhEqjIAL2kKrLfCLfUaCpfPaG6fe3y7b1NtVYjAIZ1iE3
         R+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxBbFAtt62/SvY9e9+nVnOlCBdHRV0j64UHWDL89544=;
        b=xaNenhwZPxwg0P4uOacutqaC43j9bzL7YnOeWNgyPOK1mf13S0FtoMPRxJmXbFEqXy
         hQK3pZagATjdE0OAi3lZL333GMNMmUEMTaAooGgEofEyLuFZi0F+/vesJ6NI1N1UROOM
         IlI/rYFcFCUg2VJdAPTjdPCerRTM8fArj4wKW3Rckqi1iBFlKktf+qHb8eIUgMomfFwO
         5mU29py1A6vwHSCkl1e1f0xsijllk4ZpEaafe16sDK9bdP7FIQKVunOBRTgkDwbTBNlY
         ibqVi8ccVc6U4EtWgED3kvJZo+wtIbIFVk+4SEecnC+jVtR0rvJxeT3HCynUZZTGXUAW
         XLuQ==
X-Gm-Message-State: ACrzQf2zRfzL0M9IIjivHqBXXMD6gpI79a74G98TGwJS9mOXZ8WTkYeo
        9vP1peEOr8tgUzopXNTMujjVXpngprIwRP0Rs9uzbQ==
X-Google-Smtp-Source: AMsMyM5mOOZtLapW4IrhI6B7QFm8aSGs779gcaOD1f0ns5QZ992NXxUHp/0wAxZ+mtsRQ0JbC0WaPRqSpGcT+zrsxkQ=
X-Received: by 2002:a17:902:70c4:b0:17c:f9fe:3200 with SMTP id
 l4-20020a17090270c400b0017cf9fe3200mr31984664plt.1.1665610976034; Wed, 12 Oct
 2022 14:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
 <xmqq7d14k9uh.fsf@gitster.g>
In-Reply-To: <xmqq7d14k9uh.fsf@gitster.g>
From:   Ignacio Taranto <ignacio.taranto@eclypsium.com>
Date:   Wed, 12 Oct 2022 18:42:44 -0300
Message-ID: <CAAHd=zd2fRAiW4tZa-yCie3tGMzcmye-75_b1tcYtMTyf1Li2A@mail.gmail.com>
Subject: Re: About git reporting missing newline for symlinks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That was very well explained, thank you.

The problem seems to be that some people interpret this message as a
real warning since it's often a good practice to always end text files
with a newline (at least on *nix systems).
Of course this doesn't apply to symlinks at all.

On Wed, Oct 12, 2022 at 6:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Ignacio Taranto <ignacio.taranto@eclypsium.com> writes:
>
> > So, both git diff and git show display "\ No newline at end of file"
> > for symlinks.
> >
> > I think this is related to how Git renders diffs, IMO it shouldn't
> > display a warning about newlines for symlinks.
> >
> > Am I making any sense here?
>
> Yes, but not really.
>
> It is not "warning" at all.  The users want to know when compared
> contents do or do not end with an incomplete line at the end, and
> the "\ No newline" is the diff's way to give that single bit of
> information to us.
>
> And the contents of a symbolic link typically is a single incomplete
> line, so it is expected to see "\ No newline" when comparing them.
>
> This is important as "git diff | git -C ../some/where/else apply"
> should be able to recreate the change in the current repository
> (which may have change to or addition of a symbolic link) in the
> other repository, and "git apply" on the receiving end must be able
> to tell that the symbolic link it needs to create in the other
> repository must not have an extra LF at the end.
>
