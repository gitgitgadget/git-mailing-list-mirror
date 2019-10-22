Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B941F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 07:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388018AbfJVHqx (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 03:46:53 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:38067 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387929AbfJVHqx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 03:46:53 -0400
Received: by mail-vs1-f51.google.com with SMTP id b123so10692081vsb.5
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 00:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6s7E65XjdFm/LkuU4U/8CCR9+jBjvK48wWF6LKyrYw=;
        b=emM5DJ0gTjVlMXTG7E2Xq0aMsdpQE68WuU6tIIxH6phmw2crPMLivFWTEmDstze1dz
         CsAINXwbSzeSn58mYl1EW92sXk4o2Dtvs/K0xhycz9Jhn+3o01X2Z4SS5W4hDdEPhmdA
         OUCfhdghOMgMIDJ8mRkfCxFKsLR41T13qK102HlBfGwLMf8mCf5KVQqAjYa/jMvq0U6t
         SJKHYSu9jldwoFn0LjLAwqtgKvXB1OLCd0SPl22/FqgimfbYH1MHRGDavDHzAdTTzvuq
         muyfULFsnrtadUPICINRgppLkrEosSvjZIPwkt3g2I9RBo6isZMHQ+EiKlnPFIkolNDk
         /HGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6s7E65XjdFm/LkuU4U/8CCR9+jBjvK48wWF6LKyrYw=;
        b=kc2LYEnynTWHVwpRCyOLfI6hYjpuUlf7iCJ3839YeFYTXrpDwRp7lSsBsIVH0R05TT
         VCT59qVUAUNrhyErw2rI83WiJ8jxlK9SdD+nVcSHumJuUPVyI91oIBLLBZrVLiBRAKcU
         TB0OsXZnAqvGnUojn8BEnDBfthom5oYQBNzh5YKngeio9F7Gs2BFrMg0Of3NrRb9xrBX
         h7OveCysTQP1D64IKcixQypgb+n7AwMv9moj1uahaeCicUyb1qjy+dK1I8hCrsD0HfrU
         8DMRmosaLfghPvhxKUr08H7Mienyjoltw1NGJO3oTw+L1MzCq7RrphSx1pzzQjCzhtQF
         0RoA==
X-Gm-Message-State: APjAAAXGEuYkhts+baSHs2nPZ/U2p5WFYYvUMQvbj41heWJf8XivwRGd
        FlwzfhhuwsTDeOL/bFuqz8/cYL9nYTGq4xPwyO4=
X-Google-Smtp-Source: APXvYqx1yOUAwQYKvO7Eak7gS36V/hDs0fMvroCCNJca1pzfrF3rIoS0+r3Mm4bGIP6WZKy0K5b+z29jPWSNIjHcKpY=
X-Received: by 2002:a67:2c4d:: with SMTP id s74mr1083683vss.75.1571730411854;
 Tue, 22 Oct 2019 00:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190819214110.26461-1-me@yadavpratyush.com> <20190828215725.13376-1-me@yadavpratyush.com>
 <20190828215725.13376-5-me@yadavpratyush.com> <CAKPyHN0Kh8eKjzXink3YtE6wRrOgpzTYyPmLnbpbxPt3LFsvig@mail.gmail.com>
 <5b62b4a7-67ad-9e5f-d4a1-9dce7bcfcb6b@kdbg.org>
In-Reply-To: <5b62b4a7-67ad-9e5f-d4a1-9dce7bcfcb6b@kdbg.org>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 22 Oct 2019 09:46:40 +0200
Message-ID: <CAKPyHN1V+gDdL=9eGvHmC7sv_bJPwv9kCvDu2f8sL_kPhAzRAg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] git-gui: allow undoing last revert
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 9:35 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 21.10.19 um 11:16 schrieb Bert Wesarg:
> > Dear Pratyush,
> >
> > I just noticed that the 'Revert Last Hunk' menu entry is enabled in
> > the stage-list. But I think it should be disabled, like the 'Revert
> > Hunk' and 'Revert Line' menu entry.
> >
> > Can you confirm this?
>
> Technically, it need not be disabled because the hunk being reverted
> does not depend on the contents of any of diffs that can be shown.
>
> The entry should be disabled if reverting the stored hunk fails. But to
> know that, it would have to be tried: the file could have been edited
> since the hunk was generated so that the reversal of the hunk fails.

But the "Undo" changes the worktree not the stage, sure it indirectly
also changes the view of the staged content, but that is only a
secondary effect. As I only can revert in the worktree list, I think
we should be consistent and also only allow to undo the revert in the
worktree list.

And I think it is independent of 'does the undo apply at all' question.

Bert

>
> Not sure what to do, though.
>
> -- Hannes
