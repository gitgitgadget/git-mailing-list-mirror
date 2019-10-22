Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38B11F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 08:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbfJVIRk (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 04:17:40 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:42096 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387928AbfJVIRj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 04:17:39 -0400
Received: by mail-vs1-f47.google.com with SMTP id m22so10713030vsl.9
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 01:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fxa5Pbg31ZX1W2IfBRPsvc7wzQJzGHqTD4vNHpfCak8=;
        b=a0f4/feOVYiYUm+dbySZY1ZeJuwNYtBibT3vifg9T2XQRfTlBUh7zg4enF8i/kQgJU
         4cnAhuVdW7ECAmpuc5aScZxgzpZv6c4beZahsqwUSVB1T9cEOZT9/em4BlXAik6LwlRB
         oDgN9pu/1IgUP2jTI1pJSFixx80mbrwk8SIcICp3Wkf4rWCbKBYySGR6psUXpgv7uXlz
         dIHe1ASJCuCLJrEtai78A9XvOxJDyJT7JmunlF8RzQsJv3H5BfqVve6ksyySyn4194Au
         Y1lrdWjqqNmLgBHy/ecZT2jjefOBzxK/tCiyGsJhkWuHYw+41agvznCNUCxuvtdOUVsa
         taMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fxa5Pbg31ZX1W2IfBRPsvc7wzQJzGHqTD4vNHpfCak8=;
        b=pUCCh4Kus0qThXFvFXmd16UIydv1qidolov9mDOwTDfUu+vV8oZxSZmNUHhCWzgsOq
         peJ9C2B7Yx7m9Trwn3JET+QybxXB6oNOPDphDmsPt+Q7/hl/A//sv59lu3J89GmO3E73
         WtUFyqzuwGEhO/LNe8u7Mwx9D1uRO+yWeM2lhHISVvUm6FSgmnwqfeam0tpfFsGxvXxr
         JIjP0UMz9mDDBy9Y3RpAezSOuE3awAfOxqn+joId5qMa0vBMCJD9fYCb6vRztOI5ADZD
         npmieMYdZ934nGZr8tOXbcd67YqasyvY78f+SYVMniG0pz2dnNN7I6Lx91bUneonBH9/
         QtRA==
X-Gm-Message-State: APjAAAV2mhBXJpDow5mKeCrDIR5Y8Pl9kEbdE+GeE61yfYEsugVk/pO2
        HZHYZZQFqdySB3JpQU4mjFtPp+u230jYzSWpYUgHkm7z
X-Google-Smtp-Source: APXvYqw+dXuKxGEV59oeM727k+cnZSCivnqnC5mcI7uvktoqS0zIOU6OmPV+rG7IVQiwoF6beCFBcqbPobx5lfyQCP8=
X-Received: by 2002:a67:f7c9:: with SMTP id a9mr1011793vsp.85.1571732258594;
 Tue, 22 Oct 2019 01:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190819214110.26461-1-me@yadavpratyush.com> <20190828215725.13376-1-me@yadavpratyush.com>
 <20190828215725.13376-5-me@yadavpratyush.com> <CAKPyHN0Kh8eKjzXink3YtE6wRrOgpzTYyPmLnbpbxPt3LFsvig@mail.gmail.com>
 <20191021190448.34vs3zsqvqc5hryl@yadavpratyush.com>
In-Reply-To: <20191021190448.34vs3zsqvqc5hryl@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 22 Oct 2019 10:17:27 +0200
Message-ID: <CAKPyHN2b1=2GefMDB987h5J4zXN7YWGsyLw7FADs+M5CgEUYow@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] git-gui: allow undoing last revert
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 9:04 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 21/10/19 11:16AM, Bert Wesarg wrote:
> > Dear Pratyush,
> >
> > I just noticed that the 'Revert Last Hunk' menu entry is enabled in
> > the stage-list. But I think it should be disabled, like the 'Revert
> > Hunk' and 'Revert Line' menu entry.
>
> I'm not sure what you mean. There is no "Revert Last Hunk" menu entry (I
> assume you are talking about the context menu in the diff view that we
> open by right clicking).
>
> My guess is that you mean the "Undo Last Revert" option. And you want it
> disabled if the diff shown is of a staged file, correct?
>
> I'm not sure if disabling it would be a good idea.
>
> Say I revert a hunk or line while the file is not staged, and stage the
> rest of the file. This would mean that file is no longer in the
> "Unstaged Changes" widget. Now if I choose the file from the "Staged
> Changes" widget, I get the option to undo the last revert. If I hit
> that, it will put whatever I reverted in the "Unstaged Changes" widget.
> So, now part of the file that was reverted is in "Unstaged Changes", and
> the rest in "Unstaged Changes".
>

Sorry for this confusion.

> IIUC, this is what you think should not happen, correct? What's wrong
> with allowing the user to undo reverts from anywhere?

The 'Undo' changes the worktree not the staged content,.

>
> The way I see it, it doesn't really matter what file is selected or
> whether it is staged or not, the action of the undo remains the same, so
> it makes sense to me to allow it from anywhere.

It would make sense to undo the revert on the staged content, if there
are no more changes to this file in the worktree. I.e., you wont be
able to apply the 'undo' anymore to the worktree file if it is not
listed anymore. Though even that case should be able to implement.
Though the undo is currently not bound to a specific path. This may be
the cause of our different view. I though the undo is bound to the
path it was recorded, thus also would only be available when showing a
diff on this path again. Therefore I think, having the 'Undo Last
Revert' in the context menu may not be the best place to begin with,
or at least indicate that this 'undo' operation does not necceseritly
operate on the file currently shown.

Bertt

>
> > Can you confirm this?
> >
> > On Wed, Aug 28, 2019 at 11:57 PM Pratyush Yadav <me@yadavpratyush.com>
> > wrote:
> > >
> > > Accidental clicks on the revert hunk/lines buttons can cause loss of
> > > work, and can be frustrating. So, allow undoing the last revert.
> > >
> > > Right now, a stack or deque are not being used for the sake of
> > > simplicity, so only one undo is possible. Any reverts before the
> > > previous one are lost.
> > >
> > > Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
>
> --
> Regards,
> Pratyush Yadav
