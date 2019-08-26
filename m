Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9921F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbfHZSnX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:43:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39119 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732685AbfHZSnX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:43:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id b1so16185577otp.6
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PnexhLheFTj14s6zOoWVVAzTWeS2nWYIk/gqFTfOzD8=;
        b=VRJxD9ifMwcVvGJKw7t8bK3yYMU/Ezr32agb6btEdtNQsDWmmLaJ9ewYVyFqOVHpoN
         Z/A8Fe3CSHOSlNE4n1WnPlTxgevTAFvNfGfPZNl1he+GjFic78Iyg3Uvg5uUEEhmPI9d
         /iWtpEgbgBEmUGOc0pKc0az517M01mS7w/jPmgCboMZyS4wx75p0PisdvjyMEZiFZDi6
         dDO2bJj35ZbejGf999YOQi5Gzk3p1XpsNUFzZaqfQZXSyiJc1lKxdB7jV14jpOfDVVgo
         sUcol/T3JztWIlM31/b+2DRb8yFKCMgyLAcQarEsqTOaOyFTeXxhvEk7M77C05oZQow+
         hZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PnexhLheFTj14s6zOoWVVAzTWeS2nWYIk/gqFTfOzD8=;
        b=WAnulgWQxOOUV5zgB8PD65o+Cs7zxOaG8xSvb8bzzGbNEo1+yAyDmevCVJ93GObxPm
         TwOqOYn1sTjK7cAsYvbuQ0ULQztpP2sZCs5Tev6BQh750FZxuAV5Iob/RC6INjmk189u
         Crb/fek39Jld8JFah+c2R1L82TXLtCGyy1q7PFtenokMwosr+if1XnfaM105GejjByVi
         1aKllQKzj6oBztTHICk7+zkhxq1A5L+smpb1RBZe/jv8HMok3hFroG/DMZsQD6UX4cJ6
         BXilVZh4o3Y3eUoibbhjcyq61FUwV7se/C186vqRzSOSLKfdxjtQvNCgVpD5S0lwM/mD
         06VQ==
X-Gm-Message-State: APjAAAWPJy6G5/DLKr9ygJ2efKtY3dJDJ4q//kWwtte1+bWJxO9qtc42
        hKPGEw2zqZSjya42utQaBi37w//jYW4C+GXorDg=
X-Google-Smtp-Source: APXvYqysQI3zHSh5jwjn6g6HaOKRZR2jGDff+H3Qvmx497zQhKIUyvKtNXxygh13mBHB4Ml3/xuRgDUSyWUCvvx7wI0=
X-Received: by 2002:a9d:65d4:: with SMTP id z20mr15255297oth.314.1566845002145;
 Mon, 26 Aug 2019 11:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
 <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org> <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
 <34935414-4e69-114b-7a32-f94514e3679d@iee.email> <xmqq5zmkkn4a.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zmkkn4a.fsf@gitster-ct.c.googlers.com>
From:   Albert Vaca Cintora <albertvaka@gmail.com>
Date:   Mon, 26 Aug 2019 20:42:56 +0200
Message-ID: <CAAQViEsL+X5ZYmmSjG1JBksGjthHCUyWa3525b8dN7u1XAbvJg@mail.gmail.com>
Subject: Re: [Feature Request] Option to make .git not read-only in cloned repos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 4:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> And directories (e.g. .git/objects/) are not made read-only for
> obvious reasons.  Read-only files inside a writeable directory can
> be deleted just like read-write ones can be (iow, the "delete
> permission" comes from the "write permission" of the containing
> directory) so "rm -r .git" should "work" just fine (depending on the
> definition of working, of course---it is discouraged to throw away
> your work).
>

It "works" for some definition of work, but it asks for confirmation
for every file, which is a pain. I'm on Linux.

On Mon, Aug 26, 2019 at 4:27 PM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> Why don't you wrap your clone in a script that calls chmod -R u+w .git after the clone? This seems like a pretty trivial approach regardless of your workflow. This works in Linux, Mac, Windows (under cygwin-bash) and anything else POSIX-ish.
>

Wrapping `git clone` should work as a workaround. Although if that
doesn't break anything... then why were those files read-only in the
first place? :)

The fact that, from a formal point of view, those files are immutable
doesn't seem to justify them being read-only (or, at least, doesn't
follow any convention): there are plenty of immutable files on any
system (eg: all binaries and libs, application assets like images and
icons, pid/lock files for daemons, etc.) that are not made read-only.

I can go with the workaround, but I'm still inclined to think this
option should be built in into git.

Albert
