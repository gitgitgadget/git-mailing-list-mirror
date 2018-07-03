Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3077A1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 22:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbeGCWzS (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 18:55:18 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42738 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbeGCWzR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 18:55:17 -0400
Received: by mail-ua0-f194.google.com with SMTP id x18-v6so2278382uaj.9
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 15:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xK1KuUelDc6huOj4FsM2y0wpq/iD0Q8SH0IsI9BNuqI=;
        b=JZ38Dlm6sMA24MYdkJPeJQHFX8h+PW8HvDih+DWFlrhRwGc46qaSWaTaJtvNS72cSr
         oxnXJd4CWZScC/8t/P1yrXI3bzNrfQreiPx3SFokZQRnTGbzCLecfL82VYqJHjIIQx23
         IIUrRN9n2UphKs0bQ1Ftrsou06pBDTWRyCiuQ95fGB9w762GMw8rJ8ahKDEBGFfTJEGD
         lp3hhHVy3OpkoA9+NRPjsX8AbXhiSqQmkEI3bNJU2M+l1ZLO+2tDGSJadX33ROybLPA9
         tqy1BhRk1S9TI/+TFxb2bOPdUaNA2qeZ3RLfm5fJEqMioMh9KdVMGvMGxcWBQZ04rLT4
         Q31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xK1KuUelDc6huOj4FsM2y0wpq/iD0Q8SH0IsI9BNuqI=;
        b=SoEpH93tBpet6bTKLpt/0DR6/qPVz+ZVG5joMbEMce0ZJlpA3sFxWoWHkyIyyzkqah
         8qW65ixFLgg1P8xoNNRdSDo0YBPPF1cOrDudn4Qnuk6OClMT3nB/U29QywGi4u38UGS0
         w1JY9xrtjIxzCHPBRRcosD4zOqrTY3+n/eOWXOkKlUvBSbmy1f5h7qEs5Gph2VHYWAJy
         eGCK6a+C3EmSuilvp6wr2yxXXlChgqKSJc8RBTEd2m4mY9Ke9MyRt0QHJzSEYiTMCxuo
         eEpZ8Dd5UKPVgPAaM2cbJTMZ9qsgO6HJ7YM/L1JKevqRadx0LmluIFBHAf0lZQDGrTNI
         Qveg==
X-Gm-Message-State: APt69E37TDyVuWBt5ezuRBDpKFKm5z6U+OGaHjjr61rL5GpmoEbYglgO
        dKvzNqIIzMEfLAWMVFjU1XS0uwr62dsWCtdc7FA=
X-Google-Smtp-Source: AAOMgpeGnZPq893whu/wmPZXjXp4xbqgMkg7SZaZiuHMPmqqTJw4rSkqY6Xxy08wMQYkcKf5l3oT39cuf1ZBKeXllgA=
X-Received: by 2002:a9f:3666:: with SMTP id s35-v6mr10269406uad.94.1530658516497;
 Tue, 03 Jul 2018 15:55:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 15:55:16 -0700 (PDT)
In-Reply-To: <xmqqbmbonff3.fsf@gitster-ct.c.googlers.com>
References: <20180703035802.24060-1-jyn514@gmail.com> <CABPp-BFu+m-7Fyf4kj8hUO33vhAxKuAu5JnyL5Tzc7c6Kq+Hjg@mail.gmail.com>
 <xmqqbmbonff3.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Jul 2018 15:55:16 -0700
Message-ID: <CABPp-BGJjJGhOEBiJJ5J5rnMXfLndKgwU-4_JVqumBB81DUHpQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ls-tree: make <tree-ish> optional
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joshua Nelson <jyn514@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> On Mon, Jul 2, 2018 at 8:58 PM, Joshua Nelson <jyn514@gmail.com> wrote:
>>> use syntax similar to `git-checkout` to make <tree-ish> optional for
>>> `ls-tree`. if <tree-ish> is omitted, default to HEAD. infer arguments as
>>> follows:
>>>
>>> 1. if args start with --
>>>         assume <tree-ish> to be HEAD
>>> 2. if exactly one arg precedes --, treat the argument as <tree-ish>
>>> 3. if more than one arg precedes --, exit with an error
>>> 4. if -- is not in args
>>>         a) if args[0] is a valid <tree-ish> object, treat is as such
>>>         b) else, assume <tree-ish> to be HEAD
>>>
>>> in all cases, every argument besides <tree-ish> is treated as a <path>
>>
>> Cool, this is something I've wanted a few times.
>
> Hmph, is it, and why?

Default <tree-ish> of HEAD when nothing is specified is certainly
something I wanted.  To be honest, I wanted it for rev-list too.
Despite dozens if not hundreds of times of typing 'git ls-tree -r' or
'git rev-list' expecting to see the results for HEAD (just as git log
does), and getting git's error message reminding me that I need to
specify HEAD, I can't seem to get it through my head to remember that
I need to specify it.

> I'd prefer *not* to have such a DWIM in a command like ls-tree, aka
> plumbing commands, where predictability is worth 1000 times more
> than ease of typing.

Fair enough.  However, what if no <tree-ish> or <path> are specified,
though -- would you be okay with the HEAD being assumed instead of
erroring out in that case?
