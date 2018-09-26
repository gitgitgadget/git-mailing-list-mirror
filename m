Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E516B1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 09:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeIZQFF (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 12:05:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44087 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeIZQFF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 12:05:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so5650685pgu.11
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7EYW7r410HBerm7nzDM4OqDH8ZdWjJQ3oLZ8l9g8x/c=;
        b=eoXh/AOUQeb2KJ420gbKbosLgrsdRp3K7zBp1oux+6eQXYmqAYsGQa8VJbox6745cj
         tEtTWgt3Bbd5it8AOBp+VyyA+a3Amyd1hVQy5l65rvMrFrTLPm31/bCoySLLsUq0beGj
         7epDTW3PzfkcfsLd7W19S/dsEWv8QGVupowjZKDvfcectuE20+hdYq/zSujdyXdFzs5D
         TIW2g0/CJuOaEMLJusYyVcjHQX4+5EvLlH6ifLjqp3BCHCBLDMmV7ErXD+MdiamdVDbp
         Ap6X/pm8G7nwpRuWeo7y0ZTOgazAwP9pvfLfd1B7e5uyT+fnGkBnqwG/3J1M62Kwhwgw
         di2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7EYW7r410HBerm7nzDM4OqDH8ZdWjJQ3oLZ8l9g8x/c=;
        b=ZANX3IRLOKmkoCeqbfwQbcWvDY0fiel/mK/lNPFkdar4sm2WCx2EwKZoGLh/ixbJte
         FMbC5sMg7WGiUphwd3kT6X8rCOa2SsbV8yz9Lde0Lz1R2QY/4va61AIcjLIqZzGrpFfF
         ex0bH2Tx/g1suPtkmmVIqJWD2LC06JNNRC4gAKheWkwo32bRcM99TBNqEgD/tBJUHrEJ
         t2E5uzZ8IZCKUbiaApNV+AEolI0CD0PIgf9HcoV5jBJxKhw0ubVS7ezJXmrYlHSJNV80
         N5Ug+YbemkVmYnFVtCIQI1r28HlGvoXXbE2i3SrEnHBxZFBvzHPbZq/Tit/6cBx0HUCF
         2few==
X-Gm-Message-State: ABuFfohrVWCwBnUYwEFFHY42+OYgjMhxBd9SIzgPKDRedBWIwyFZR9xa
        rXR12aDaUD/Am/bSuayQ1FHB+zkfyH4ZnIwJI+M=
X-Google-Smtp-Source: ACcGV61m0wYfY9pEZq8UyRy4daZS8kasCGTNjrYX2typbOmONORuADd+eETW1xvNLknnFt9a5VXuTwSBx3OeHCcHcuM=
X-Received: by 2002:a63:6507:: with SMTP id z7-v6mr4910567pgb.200.1537955575771;
 Wed, 26 Sep 2018 02:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
 <CAN0heSrhaaP0ds8K92g9w5DAnbwuq8mM6WLKrTQ7e_a8Fku9KA@mail.gmail.com> <CALOYryEMB5HoCXbVKnc49KLkk2ySZjn4DG9RbJjQAvPn1H5K6Q@mail.gmail.com>
In-Reply-To: <CALOYryEMB5HoCXbVKnc49KLkk2ySZjn4DG9RbJjQAvPn1H5K6Q@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 26 Sep 2018 11:52:42 +0200
Message-ID: <CAN0heSpUhzbTjceVhBxk_jjE=vOAVTzXGFQ=UL9Y+muJHe0S6w@mail.gmail.com>
Subject: Re: t7005-editor.sh failure
To:     Alexander Pyhalov <apyhalov@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 26 Sep 2018 at 11:00, Alexander Pyhalov <apyhalov@gmail.com> wrote:
> As for sign-off, do I understand correctly that you just want to know
> that I'm the original author of the code? Yes, it's so.

Right. Plus that you agree that the code (the commit) may be
redistributed basically forever.

> I see this on OpenIndiana in
> https://github.com/OpenIndiana/oi-userland/pull/4456 , when running
> test suite.
> Not sure why it wasn't noticed earlier, as 'trash directory' is used in path.

My first theory was that my shell and that of other developers was
"modern" or "clever" enough to realize that the space belongs to the
filename, so it just takes everything to the end of line. Whereas your
shell would be "dumber". I see now that you have a newer bash than I
do... Maybe this cleverness can be configured (at compile-time?), or
maybe something else is happening.

> execve("/bin/bash", 0x007EA898, 0x007EA960)  argc = 5
> 2655:    argv: /bin/bash -c ./e\ space.sh "$@" ./e\ space.sh
> 2655:     /export/home/alp/srcs/oi-userland/components/developer/git/build/amd64/t/trash
> directory.t7005-editor/.git/COMMIT_EDITMSG
> 2655:   execve("./e space.sh", 0x005655C8, 0x00564008)  Err#8 ENOEXEC
> ./e space.sh: line 1: $1: ambiguous redirect

> Shell is bash, as you can see (GNU bash, version 4.4.23(1)-release
> (i386-pc-solaris2.11))

I came up with the following commit message. What do you think about it?

    t7005-editor: quote filename to fix whitespace-issue

    Commit 4362da078e (t7005-editor: get rid of the SPACES_IN_FILENAMES
    prereq, 2018-05-14) removed code for detecting whether spaces in
    filenames work. Since we rely on spaces throughout the test suite
    ("trash directory.t1234-foo"), testing whether we can use the filename
    "e space.sh" was redundant and unnecessary.

    In simplifying the code, though, the commit introduced a regression around
    how spaces are handled, not in the /name/ of the script, but /in/ the
    script itself. The editor-script created looks like this:

      echo space >$1

    We will try to execute something like

      echo space >/foo/t/trash directory.t7005-editor/.git/COMMIT_EDITMSG

    Most shells seem to be able to figure out that the filename doesn't end
    with "trash" but continues all the way to "COMMIT_EDITMSG", but at least
    one shell chokes on this.

    Make sure that the editor-script quotes "$1".

Martin
