Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E8D1FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 11:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1169131AbdDXLPN (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 07:15:13 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34592 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1169061AbdDXLOa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 07:14:30 -0400
Received: by mail-io0-f176.google.com with SMTP id a103so187579712ioj.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GMOvDiGggI/Wd7qoGscModVJQ0CUyL6Ghz701ZdCVRg=;
        b=LwNMVnZygDmhHJftl99+YZijq0qKn0ZhOsR9LBUumKQBsZ1nPJrGHM7w19yYrcO3HS
         XZww3XZ/As8aNT+d0CVBY38pA6yALYOg5f22vup8Gs4Fwfvsj+6xhCTI6+rEMaMypDTX
         b0dFp6UbYtlCnQPkEqTxOzoqidgG+DChjQeqooLnbzQXsJhfFV0kPuJOxpuAk+bfZFzG
         06tMT0YSEhfLb5FHaLpNstC7UkEPxbs0IEKNfZ4URNfSAMHcm6bpLEBuSxE9yYUJijtT
         xatiC4/7BEiblTOU5BkUKvYES2ks7Bsea1IHJO4A8o7lYeLY4HnWlmgTESlN+Ew28+/8
         iZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GMOvDiGggI/Wd7qoGscModVJQ0CUyL6Ghz701ZdCVRg=;
        b=L8NQDM5XQ8+1dx1I8xa0DDQ9Nxpcc19Io9/iblpooct5KOLoI0hS0PjI4UwpQCGiKd
         A/+nXZoawaU0SU0cNvO/zpxkLYEiH8d1f87EzuFS1hyVYRK3ZPGT9ATmz0mPJmiuW1kq
         WpsoeW+uyncTaiw+aLwZ8ZbixGi1RqX491XYaNl6YewaIC1epCSVYs2I5mDEJNk9zgbQ
         PMea7j6rNbiTFD/lRRMeQze26Ih5xL3Nu6d6INF4VjoguoQjD2p30WdkwePzPrmlDaxi
         18BWMUdmfoncW2xFr0z2usauXqNIHwb5aCqAjDIIrTDpoZJTAyPL97CMOSk5RWIqsE4M
         IXkg==
X-Gm-Message-State: AN3rC/4vPhb4oAhVck/BTh3bD0f98w09qpQpcPBEQluhJ6uRQ7Qj8xKR
        xoNs9DwXM5hTqGTazI9f8/CT7DPNHg==
X-Received: by 10.157.18.144 with SMTP id g16mr267873otg.10.1493032468739;
 Mon, 24 Apr 2017 04:14:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Mon, 24 Apr 2017 04:13:58 -0700 (PDT)
In-Reply-To: <xmqqh91i7bdy.fsf@gitster.mtv.corp.google.com>
References: <20170420101024.7593-1-pclouds@gmail.com> <20170420101024.7593-2-pclouds@gmail.com>
 <xmqqh91i7bdy.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 24 Apr 2017 18:13:58 +0700
Message-ID: <CACsJy8CCsZWAQJwRQQAYerGLgiaGMZesGZPi4NJvkOtEB0m7MA@mail.gmail.com>
Subject: Re: [PATCH 1/6] worktree.c: add validate_worktree()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 9:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +int validate_worktree(const struct worktree *wt, int quiet)
>> +{
>> +     struct strbuf sb = STRBUF_INIT;
>> +     char *path;
>> +     int err, ret;
>> +
>> +     if (is_main_worktree(wt)) {
>> +             /*
>> +              * Main worktree using .git file to point to the
>> +              * repository would make it impossible to know where
>> +              * the actual worktree is if this function is executed
>> +              * from another worktree. No .git file support for now.
>> +              */
>> +             strbuf_addf(&sb, "%s/.git", wt->path);
>> +             if (!is_directory(sb.buf)) {
>> +                     strbuf_release(&sb);
>> +                     return report(quiet, _("'%s/.git' at main worktree is not the repository directory"),
>> +                                   wt->path);
>
> These messages come without telling what they are.  Should they say
> that these are errors?  Or does the severity depend on the caller,
> i.e. why they want to know if a particular worktree is valid, and
> sometimes these are errors and other times they are mere warnings?

I'll save the error in a strbuf and let the caller decide how to
present them, which gives better context (e.g. "unable to move
worktree because ...")

>> +             }
>> +             return 0;
>> +     }
>> +
>> +     /*
>> +      * Make sure "gitdir" file points to a real .git file and that
>> +      * file points back here.
>> +      */
>> +     if (!is_absolute_path(wt->path))
>> +             return report(quiet, _("'%s' file does not contain absolute path to the worktree location"),
>> +                           git_common_path("worktrees/%s/gitdir", wt->id));
>
> It makes me wonder if this kind of error reporting belongs to the
> place where these are read (and a new wt is written out to the
> filesystem, perhaps).  The programmer who wrote this code may have
> known that wt->path is prepared by reading "worktrees/%s/gitdir" and
> without doing real_path() or absolute_path() on the result when this
> code was written, but nothing guarantees that to stay true over time
> as the code evolves.

This is almost like fsck for worktrees and for now only be checked
before we do destructive things to worktrees (moving, removing..).

Yeah we probably should do this at read time too (after checking if a
worktree is locked, and skip the next check because wt->path may not
exist). But we probably want to either make this function cheaper, or
we cache the worktree list. Probably the latter. It's on my todo list.
-- 
Duy
