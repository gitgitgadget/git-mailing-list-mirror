Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACDD21F744
	for <e@80x24.org>; Sun, 10 Jul 2016 11:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbcGJLFL (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 07:05:11 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38335 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbcGJLFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 07:05:09 -0400
Received: by mail-it0-f47.google.com with SMTP id h190so41925180ith.1
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 04:05:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jAy0gZLw2JRzOxAEbwNfx8FBSM1BvoZ8a2bYrRMcUdY=;
        b=mUR/BjkeKLet22hR1npz71Ct7X6iad/oJGBip8oKUqbYozrNkdDzXsuxpHl23o6tR8
         bRPe7v7S/sDfEQsJQ3mz26vS4dDUJR8pSn24zaewpWOcMcUfrDeuohX7Z3nh2N+oCo9c
         B7Bss0ioH8haaMEXP2RJ2gXLaGM1VrQE6yed2iupoZyZwCzsIbwnPp8EZPbJNj5TXlSr
         P5E3oZfVFyMngD9HnIL48SnQ5clkpOnr8iFZJGRSEnHBOIrf6GqyN9LP/dT/H+PSwV17
         vl9FNGJ5cBd8d518UHwjUgrBU54zPkb5InrhOyZRnbP4dIFp0QtoI+jQJFJDVAYk8aAH
         cb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jAy0gZLw2JRzOxAEbwNfx8FBSM1BvoZ8a2bYrRMcUdY=;
        b=VCdaztfB1egd9xRziFrWDpWkjqD851MmTttIpQeu0ikAz6yQi4CpHoLgjqdlkxCS0n
         dCpuF3R8Lz4P1tVbrSPmnFk6rKeKORNRfXzoFnvZRzKB+EOrKnYYdjdJDDUnSegcChDV
         7kueD69R8ZEutO1qJe9PB2S98ZWawZRxvaNKPADb83g8sPwX/mhsqiVBVKhHktUKBJ9U
         m301vWPR7ZsFMhqtoxSEjz7AS9+V9NFGbBzl6zAD4W+HJB/TgBiGLrFAptwblPC6EtoI
         ipon9sM8X/RPHfmhfnAyadaJnJQjT9LVnHi+y86K9q++v+FpxzWOVmnGYWOEu/0vGhot
         j9tQ==
X-Gm-Message-State: ALyK8tLiWkOCPvcmX0S/HlUfnsWwn3bTHFOGo9CJjCJ9SPbReF2kdd9OSsXR/hxKvWd6CEx3era8OgLkU0k5Jw==
X-Received: by 10.36.33.22 with SMTP id e22mr6118299ita.42.1468148708687; Sun,
 10 Jul 2016 04:05:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sun, 10 Jul 2016 04:04:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607101255300.6426@virtualbox>
References: <20160708025948.GA3226@x> <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
 <20160708064448.GA18043@x> <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607090928500.6426@virtualbox> <20160709140931.GA3185@x>
 <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com> <alpine.DEB.2.20.1607101255300.6426@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sun, 10 Jul 2016 13:04:39 +0200
Message-ID: <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Josh Triplett <josh@joshtriplett.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 12:59 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> >> Now, how about special-casing *just* these legacy files in gc: HEAD,
>> >> FETCH_HEAD, MERGE_HEAD and CHERRY_PICK_HEAD? Any new transient refs should
>> >> live in the refs/ namespace, which is already handled.
>> >
>> > That seems workable as well; in that case, we should also document this
>> > (in the git-gc manpage at a minimum), and explicitly suggest creating
>> > refs in refs/ but outside of refs/heads/ and refs/tags/, rather than
>> > directly in .git/.
>>
>> Not just outside refs/heads and refs/tags. It has to be in a specified
>> namespace like refs/worktree/ or something (we are close to be ready
>> for that). We could update the man page about git-gc shortcomings now,
>> but I think we should wait until refs/worktree (or something like
>> that) becomes true before suggesting more.
>
> We have a precedent for a ref that is directly underneath refs/:
> refs/stash.
>
> IMO that is okay: depending on the use case, we would need multiple refs
> (like refs/notes/*) or a single ref (like refs/stash).
>
> The important part is that the new refs start with refs/, and if they are
> to be transient, start neither with refs/heads/ nor with refs/tags/.

No, the point is, refs subsystem needs to know which refs is per-repo,
which is per-worktree. So far the rules are  "everything under refs,
except a few known exceptions, is per-repo" and "everything directly
under $GIT_DIR is per-worktree", which work fine. But if you allow to
move per-worktree to "refs" freely, then the "known exceptions" will
have to be updated every time a new per-worktree ref appears. It'll be
easier to modify the first rule as "everything under refs, except some
legacy exceptions and refs/worktree, is per-repo".
-- 
Duy
