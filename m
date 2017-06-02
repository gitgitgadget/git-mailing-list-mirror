Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A58DC2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 20:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdFBUNC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 16:13:02 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38675 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdFBUM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 16:12:59 -0400
Received: by mail-it0-f49.google.com with SMTP id r63so29877476itc.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZOYEGDD4cQl/gWyGJyjr/lSEfE0DsNNSzmU5CMSOZ3Q=;
        b=i8j13NudWZIF1qLoaXqIQDq6n/SLtOGTlIzeVK39kOK7tGjgiiQ64/uS5QAsBQ3xWh
         sUtbHoUDXgHo25a5zK9KVoL6AfrvKKKBfTKtEzTaaQ21iFeqN6q0mfWnztBxI/gJESR+
         RCT5hsKNMnrTHBqowdVDgkgaEQ3TYzqAWq+XsA9A/a0oXnQ33nxJ2wbneRn28T+YtFOo
         XRMwzk5wdyh5HSZFkAcx9omwL0iolIvWJmnBmSq2KQO7oUYL6GU2klIaJul3A/ElbwFZ
         dPFVN8Rphpo9a4eTutmRuagqVl1CMIJ+cglLq4KFLG9uLDo4/HtvpXEW9t0xgBJVdaFi
         gsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZOYEGDD4cQl/gWyGJyjr/lSEfE0DsNNSzmU5CMSOZ3Q=;
        b=RCXyUahTupW+DEv0l/SyWHLXLBYXKQMGF9b+4kw3fke50Q0hTa6UGfrDsdzCNGHIpF
         BMx0BNtoeae3DVvOWIWudZC0Arq/uQDTUi4dJ9Kcjw8J6kqc+GCEgMKt8Uoafs+2GgQ3
         TsszcFkEeK87sB71sVW2J2WHvvxZUsh5e2PfaPqeLoA66PjIpbqkihrVUyapPnaB4/Ea
         Negjac2hEDfL1ptwaBXME65Wz3ImuPxO02UbGx0naY4KA28Q10r1AWcTPw09V5jTHxYM
         L7DH+eU9f5/Hva7F/atsdLzvA8Z4RII9lpigfY0m/zP/b9zqCPht2wHorG+ZJX/1yS3l
         /wZw==
X-Gm-Message-State: AODbwcCpmF+sYb8ZnGH9GhuUpdPAo3jCRrT8GxO/uMtngAqn1255W4DB
        ysunSz15d+ASvnYjJEBwpvLo6TlYC19D910=
X-Received: by 10.107.178.215 with SMTP id b206mr6071573iof.50.1496434378755;
 Fri, 02 Jun 2017 13:12:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.148.208 with HTTP; Fri, 2 Jun 2017 13:12:36 -0700 (PDT)
In-Reply-To: <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
References: <20170602103330.25663-1-avarab@gmail.com> <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 2 Jun 2017 22:12:36 +0200
Message-ID: <CACBZZX61uqRsB8p+VdA=DZEt6Aa9bA+c4zTa5-ngmG8G4U3U4Q@mail.gmail.com>
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 8:45 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 02, 2017 at 10:33:30AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> When the tested repo has an index.lock file it should be removed. This
>> file may be present if e.g. git-status previously crashed in that
>> repo, and it will make a lot of git commands fail. Let's try harder
>> and remove the lock.
>
> If your git-status is crashing, you probably have bigger problems (and
> need to clean up the original, too).
>
> But I think a more compelling case is that there may be an ongoing
> operation in the original repo (e.g., say you are in the middle of
> writing a commit message) when we do a blind copy of the filesystem
> contents. You might racily pick up a lockfile.
>
> Should we find and delete all *.lock files in the copied directory? That
> would get ref locks, etc. Half-formed object files are OK. Technically
> if you want to get an uncorrupted repository you'd also want to copy
> refs before objects (in case somebody makes a new object and updates a
> ref while you're copying).
>
> I don't know how careful it's worth being. I don't really _object_ to
> this patch exactly, but it does seem like it's picking up one random
> case (that presumably you hit) and ignoring all of the related cases.

It's not a perfect solution, but it seemed not to cause any harm, and
would allow us to just do what you mean. I can't think of a case where
we'd care to preserve the index.lock in our perf copy, of course the
test may fail due to various other reasons, but at least it won't be
due to this reason.

This is just something I happened to run into locally because I had a
stale index.lock, but FWIW at work I have a git updater running on
tens of thousands of machines that has to handle various edge cases
(e.g. the machine ran out of disk space in the middle of an update, or
something was kill -9'd).

The leftover index.lock is quite common, the second most common "index
is hosed" error is "fatal: index file smaller than expected", but
solving that is more invasive, you need to rm the index and reset
--hard.
