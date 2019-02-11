Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7FB1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 09:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfBKJ5B (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 04:57:01 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:34300 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKJ5B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 04:57:01 -0500
Received: by mail-it1-f175.google.com with SMTP id x124so15516193itd.1
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 01:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6yoJwEhtbqKFBgdcOfoCCtqu/+eFwWMlfyQyoPDJJk=;
        b=aQeB54Mr0OgeZMpokvqlI4N5yh4DMtTZWkeFK1SOeiu2wPJQFhwS1EMEi+K3GfSlRm
         gewgcV39Kjiawc+2XdH/7hfsRGwOdxhDyaZcEu7e8CWJVSgcKlVxhlsbx9JAZzkP3q4D
         iAc1ujdrkx0Ri+t5DV8oNRbDUmuOH6Jb21stn2q3jskcewJ6Xaac5OOcD8WXp8+rfs9s
         NmO0B0q0NA+8CorgECz9oi4nP+ueX2Gp9IRLjYPfB1m8TFnBwpA5MtG9dshROLvW4+Yy
         8ad0dlbwu39dbAMuKtyZAs+VqsX7hEq30KgXnIH7jnkaWkBINvFCm4BzLJZhLARmp1Yr
         Xl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6yoJwEhtbqKFBgdcOfoCCtqu/+eFwWMlfyQyoPDJJk=;
        b=eG/XJOjbtmH21PmAPIhxzUNW6t12pX3sjOIPFjxwWf4Jqv5WiX0NjTveV0qmt2rgKk
         7nFTR0+f0SISAhUcHyKPoixMlHfKFLfFrPfJYaBSJjRZUpnDXs9wdz24EA729yCddyC3
         1ZY6R+Vo8KxkR+2/A67lGQoIli01/Ni1Mj+h4icX6qtj0bF3NLTDvLyqhanENnsTERh4
         4JzpVbhpMHd+IvzKBjQojeqv4P4MVajYy8zL/KhaA/p5eid8P6wzQNG2yD0OTnswCYrw
         8UVyvkCrlrTwBeki6vhuqZPGJtFzexIMaamlozWcAJUaU3TXFu8AFk6K3gruZeVst67g
         cyBg==
X-Gm-Message-State: AHQUAuaDK1jWXvu1CEQSZfeP+hgQ52wfKWgJGMnRwPhIPaoXbvoM52um
        WlCzzkfsBRy2hVyQZiLPyTxBzXon6s6MEHecd4ddXw==
X-Google-Smtp-Source: AHgI3IYBBTI5lMc2xq6osjCOtsI/550IkzBeh4DRK3p9GCHEQwDscW9y8jGCOSacUB4F+Hoi8WhHlK9ev+hOu9Wy5Aw=
X-Received: by 2002:a02:568a:: with SMTP id u10mr4660441jad.130.1549879020024;
 Mon, 11 Feb 2019 01:57:00 -0800 (PST)
MIME-Version: 1.0
References: <000801d4c174$05b76860$11263920$@nexbridge.com>
In-Reply-To: <000801d4c174$05b76860$11263920$@nexbridge.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Feb 2019 16:56:33 +0700
Message-ID: <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com>
Subject: Re: [Breakage] 2.20.0-rc0 t1404: test_i18ngrep reports 1 instead of 0
 on NonStop in one case
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 2:09 AM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> Hi All,
>
> I tracked down a breakage in t1404 subtest 52. The line
>
> test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists" err

The message does not match, does it? Here we grep for "File exists"
but the message you showed says "File already exists".

> is correctly working, but is reporting a completion 1.
>
> The verbose output, with diagnostics, is:
>
> error: 'grep Unable to create '.*packed-refs.lock': File exists err' didn't
> find a match in:
> error: Unable to create '/home/git/git/t/trash
> directory.t1404-update-ref-errors/.git/packed-refs.lock': File already
> exists.
>
> Another git process seems to be running in this repository, e.g.
> an editor opened by 'git commit'. Please make sure all processes
> are terminated then try again. If it still fails, a git process
> may have crashed in this repository earlier:
> remove the file manually to continue.
>
> Reported 1 from test_i18ngrep
>
> err contains (without the double quotes):
> "error: Unable to create '/home/git/git/t/trash
> directory.t1404-update-ref-errors/.git/packed-refs.lock': File already
> exists.
>
> Another git process seems to be running in this repository, e.g.
> an editor opened by 'git commit'. Please make sure all processes
> are terminated then try again. If it still fails, a git process
> may have crashed in this repository earlier:
> remove the file manually to continue."
>
> Which means that
>
> ! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
>
> is completing with a 1. Is that the intent? Any clues?
>
> Thanks,
> Randall
>


-- 
Duy
