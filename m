Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081091F404
	for <e@80x24.org>; Thu, 19 Apr 2018 14:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbeDSOMM (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 10:12:12 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:43276 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753549AbeDSOMK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 10:12:10 -0400
Received: by mail-ua0-f195.google.com with SMTP id s15so3520898uae.10
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9pz3XMw7t54kYzeKr95bKZOQsxFYLzKzTVzxevqfFtI=;
        b=ooxcqf1lCmdSLUN4JPh9Y8B5/q9YFNSiicqNR7ATSUQ4knXQqga/NMfpQ1A4A5vNT5
         31KViqM6rqw1uRW+EII4ObiPaJ82NUDIoOGEGATsvN9qkck/p5i/PIOn6Mj5VveuhcMr
         lHymFoiUPFPgIQq65d6ZhlX4G4OcR+1V4kzITUpalpGyln5P10r0bvF2gk3yA2/v6JcO
         GkrFNE0gDDQ3JizRpFYpSFybkdOUSvmFRnyyrIi43s5meaekdUXgrLV3/7TsS8QbnYzV
         QKY1waypmJu7iK4rB72zEfFYR2zSEFXIxlvgmGRdUBl4Ziuw6w6vx9wDoy6IZhrVQ1Hz
         YDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=9pz3XMw7t54kYzeKr95bKZOQsxFYLzKzTVzxevqfFtI=;
        b=RG9uBnkSxV3U7wRZdaTHaPjkabxZXPX6CiV8to4V7zUhcM67dm7tTT/Fpb6LjAKWJ4
         rvGzQx+q2JerywI6ibWY+9V5fQ70V+9ubDPgbO+A5wROCg22viECWq3iktFJqAynGVze
         b7L5zLPDEcREQpKfQNujUIV+hXDt5MlUrpiM8vCR5TDMpvePF3Ccy3cVEzYEDN6CRYOk
         SfMu9azJvlJ8IlGZt750nrdTGmhKjnQ2fT/x7o/ULBA88gFVD4ZFlzAA2x2wP7Gb1vyR
         7nFijniIi3iiCvm9y3E42O/HbZ7EZW1X/L6oyKwCisrqrnXLwmXe7LBX1y0RO8hGTFoX
         d1ZA==
X-Gm-Message-State: ALQs6tCghss8G/lOQ2ze9ixQe39lH9uJRdZ58bCuIhVqNzuRT6U+f6Rk
        +VgZbMs4g4s2bMJmz6+AtB3CmPuj/xpl7+Rsdws=
X-Google-Smtp-Source: AIpwx4+hZE3UTNjS+nLSUnxGLHMyrCdXIGUoEZnCyzhd6ohMa4Hv7DrOJf03tyo8JGSE9pRFsHTqp0EPdsSIBPRDojA=
X-Received: by 10.176.82.225 with SMTP id w30mr4951497uaw.31.1524147130182;
 Thu, 19 Apr 2018 07:12:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Thu, 19 Apr 2018 07:12:09 -0700 (PDT)
In-Reply-To: <20180409194955.GA22994@furore>
References: <CAGZ79kZzMDjKzuHn5ph+zMkh_9Zt_at37MssOjHvzJndUjt9yQ@mail.gmail.com>
 <20180409194955.GA22994@furore>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 19 Apr 2018 16:12:09 +0200
Message-ID: <CAM0VKjn3PQoXDStgB2_s2QQWeL8Z7e4UbrYMGPou0kdnXpfYwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] completion: Load completion file for external subcommand
To:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?Szeder_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 9:49 PM, Florian Gamb=C3=B6ck <ml@floga.de> wrote:
> On 2018-04-09 11:26, Stefan Beller wrote:
>> If Gits own completion script would be broken up by subcommand, would th=
at
>> also deliver an improvement in performance?
>
>
> As it is now, the completion script is quite big. On a system with limite=
d
> resources, the initial loading time can be long and the memory footprint =
is
> big, given that most users will just use a few commands. If you just use =
the
> "commit" subcommand, the first loading of the two (smaller) scripts will =
be
> slightly longer the first time (but not as long as with one big script, I
> think), but the footprint will be drastically lower. The whole script is
> 56kB big (without comments), after radically removing everything which is
> not connected to _git_commit, it is only 11kB.
>
> So to answer your question: Yes. My first intuition is, that by splitting
> the completion script and loading the sub-scripts dynamically, it will
> improve in terms of speed and overall memory footprint, at least for the
> average user that does not fire up all possible git commands.

While "most users" might indeed only use a couple of git commands,
they don't use systems so limited in resources where 56k vs. 11k makes
a non-negligible difference.  A system, where such a small difference
is significant, must be so thight on resources that the user will most
likely have issues running git anyway.

I don't know how much memory Bash uses to store completion scripts,
and it appears to be using a memory pool or something like our
ALLOC_GROW, making measuring its memory footprint with simple means
unusably inaccurate.  Anyway, here are some numbers:

  # Baseline, bash does nothing:
  $ command time -f %M bash -c ''
  2924

  # Loading a <10k script:
  $ wc -c ./git-sh-setup.sh
  9313 ./git-sh-setup.sh
  command time -f %M bash -c '. ./git-sh-setup.sh'
  3724

  # Loading our completion script; the increase in max memory
  # footprint is clearly not proportional to the size of the loaded
  # script:
  $ wc -c ./contrib/completion/git-completion.bash
  69413 ./contrib/completion/git-completion.bash
  $ command time -f %M bash -c '. ./contrib/completion/git-completion.bash'
  4092

  # The main bash-completion script, though slightly smaller than ours,
  # appears to be requiring much more memory:
  $ wc -c /usr/share/bash-completion/bash_completion
  67661 /usr/share/bash-completion/bash_completion
  $ command time -f %M bash -c './usr/share/bash-completion/bash_completion=
'
  5952

  # Loading both the main bash-completion script and our completion
  # script, which is where that memory pool/ALLOC_GROW-like thingy really
  # kicks in, as there is no real max memory footprint increase:
  $ command time -f %M bash -c '. /usr/share/bash-completion/bash_completio=
n
                                . ./contrib/completion/git-completion.bash'
  5964


OTOH, our completion script has a couple of nice properties that we
should keep working:

  - A user can simply run '. /path/to/git-completion.bash', and then
    completion for git commands will work.  Even without
    bash-completion package, even in 'bash --norc'.

    If we were to split up our completion script, we would also have
    to roll our own __git_load_completion() funcion.

  - A user building Git from source doesn't have to install the
    completion script, it can be sourced from anywhere.  And if the
    user chooses to install it somewhere, only a single file has to be
    copied.

    Currently we have completion functions for 55 git commands, which
    would mean 56 files to install if the completion script were split
    up.

  - Sourcing 'git-completion.bash' brings in all the latest and
    greatest.

    If it were split up, then sourcing it would only update the common
    functions, but not the completion functions of individual git
    commands.  So we would have to take extra steps to delete those
    command-specific completion functions upon sourcing the completion
    script.  However, we should be extra careful to delete only those
    completion functions that were source by the completion script,
    because users might have defined such functions in their
    '~/.bashrc'...


I don't think it's worth it.
