Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE69820437
	for <e@80x24.org>; Sun, 15 Oct 2017 11:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbdJOLIZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 07:08:25 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:48009 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbdJOLIY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 07:08:24 -0400
Received: by mail-pg0-f46.google.com with SMTP id r25so4608077pgn.4
        for <git@vger.kernel.org>; Sun, 15 Oct 2017 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gDLvWF4WwjbTIbwIUubvxGRuNJiTeFqJ7dYe0urRuHQ=;
        b=r+flBFzD6DVB/JIe/pPGqaxwRI8gtSX3F3oMKd92LREUJy3cjHwyUf12csU8gMBUMo
         mfao2r0BAO9Qb37P00LYpxPdWiAmj3yANvXnE//8/Aonx6k7gNJP+quIDMDmfGJ6AgpN
         7n9NZdSyRTIUUL/pJgQJyfuP0x5t+CRLTUGVnmFcl/575hEvedFiULxFtpVtQtsdxcT6
         PvN521xDfAAmXWnytC+WQ3lyqA17Lfvm0g2al3c+osLhQzdwRNw+IHTYpPslL4ZS08Nu
         bSwal8K3RtoiKzB+UcwgLJQ75ik1mIECKiAUYsCbLe6TvpdmXi9Rx6JRAX/X6aGCzBAs
         9Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gDLvWF4WwjbTIbwIUubvxGRuNJiTeFqJ7dYe0urRuHQ=;
        b=taG3Kdy4PvAFyqJqhiROlG7phBY35CTXVRZqmJqeeRjtGkMMJZmvdp4JUKJznknUiV
         zvg5Mv5mAeFIIMpbzw8zyEd+mjEmpYm4zA9VObcFbj4Q+dt2hiO2Ah1yQQKvZnlqoXS8
         16F8s58a3/tleNBMgrts7fSu6HdFDdPg1esDGbsb4OB5vaVWwP4ht4MZOKHHLWU32mvY
         /vqexKD/aKKdxTivNOb+UL3FnIRtwMSw2q8qy8fu4mmNpKFRVj+kxANxgnK7uctcJ/WX
         V70DdbjgRXF+XilDYrcCUjWyFUSijbHJUwIOgj8p8R3nAkrwyWcEwjSXpdNFC6wHgAfe
         oC0A==
X-Gm-Message-State: AMCzsaVpWLUIrZ3ckCxj1ueD0E+SbJZZGqdSHLztEGAPzPSDmGceZzxy
        gGWEnNM3pd6kbp9qtp1dgO8g9mNjlnDXgNlsG90=
X-Google-Smtp-Source: AOwi7QDBdCUE/PXt8TL2MFXxjmkb1AMgk6U8hWI1wMbcvZerMgmgjAZd0WcloVNt+vnvpLsd3vnr9DuHNr/C8tzpBUg=
X-Received: by 10.159.198.131 with SMTP id g3mr6167203plo.337.1508065703672;
 Sun, 15 Oct 2017 04:08:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Sun, 15 Oct 2017 04:08:22 -0700 (PDT)
In-Reply-To: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 15 Oct 2017 13:08:22 +0200
Message-ID: <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
Subject: Re: Bug: git ls-remote -h / --head results differ in output
To:     Thomas Rikl <trikl@online.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 October 2017 at 12:02, Thomas Rikl <trikl@online.de> wrote:
> Example:
>
> tom1 ~/emacs/spacemacs/.emacs.d $ export LANG=en_US.utf8
>
> tom1 ~/emacs/spacemacs/.emacs.d $ git ls-remote -h
> usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]
>                      [-q | --quiet] [--exit-code] [--get-url]
>                      [--symref] [<repository> [<refs>...]]
>
>     -q, --quiet           do not print remote URL
>     --upload-pack <exec>  path of git-upload-pack on the remote host
>     -t, --tags            limit to tags
>     -h, --heads           limit to heads
>     --refs                do not show peeled tags
>     --get-url             take url.<base>.insteadOf into account
>     --exit-code           exit with exit code 2 if no matching refs are
> found
>     --symref              show underlying ref in addition to the object
> pointed by it
>
> tom1 ~/emacs/spacemacs/.emacs.d $ git ls-remote --head
> From https://github.com/syl20bnr/spacemacs
> 07014deead544c51fa6a826e91fe2ef05bf04323 refs/heads/develop
> 8e1af145480d53e8d32cdff2c83291889903164b refs/heads/master
> 2450b7e276634ece07b6b7ec6ca6c287af86caf3 refs/heads/release-0.101
> 8dadfc1494544bb152e80c2a436e43bc3713b389 refs/heads/release-0.102
> d993a021847cde2c42865bab6afa8adbb2edda0b refs/heads/release-0.103
> 44d4525543b1f2a385142721d0cb16cd3b0be580 refs/heads/release-0.104
> 9f9faa404e3dec3e08cc73cf7b5a0439fc309800 refs/heads/release-0.105
> 8e1af145480d53e8d32cdff2c83291889903164b refs/heads/release-0.200
> tom1 ~/emacs/spacemacs/.emacs.d $ git --version
> git version 2.14.2
>
> on archlinux: Linux achse 4.13.5-1-ARCH #1 SMP PREEMPT Fri Oct 6 09:58:47
> CEST 2017 x86_64 GNU/Linux

The behavior you observed matches with the documentation in gitcli(7)
and is arguably correct. A lone "-h" prints the help/usage. But I would
agree that this can be confusing, especially when considering
git-ls-remote(1) on its own, without any extra knowledge about what a
lone -h should do.

So -h and --heads can only be used interchangeably if you have other
arguments. To see this, you could, e.g., try "git ls-remote -h -h".

Some more details. This looks like ba5f28bf7 (ls-remote: use
parse-options api, 2016-01-19). Before that, "-h" was handled internally
in builtin/ls-files.c. After that it is handled in the general
options-parsing machinery. See for example 5ad0d3d52 (parse-options:
allow -h as a short option, 2015-11-17), which explicitly wants to print
the usage-string if "-h" is given as the lone argument.

I'm not sure which is the best way forward here, or how many other
commands could have similar pitfalls. For example, the "-h"-flag of git
grep shouldn't be able to cause this problem.

Martin
