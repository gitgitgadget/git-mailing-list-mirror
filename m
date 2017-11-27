Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591E620C11
	for <e@80x24.org>; Mon, 27 Nov 2017 18:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbdK0SgD (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 13:36:03 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:32812 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbdK0SgC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 13:36:02 -0500
Received: by mail-qk0-f196.google.com with SMTP id 78so33697242qkz.0
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 10:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ysFBZ+5cz052qkt55kEvevVKRcuEU8Vm/ytnbHXiHOY=;
        b=DH8fNW1RAkKIixG0+LV31i01mpu83TR+Bs5+5GV3Iqbjd0whZDO3C+fSqzMPI/qnxf
         M5MRowr+LRuGMtOozofzQ43+SsbZuBS0xeS+ZodT8rjKkrtGjzPqpANnXCeQ6X25uUnZ
         rLizxvUkSK9PH1l0JGYvAc6AJ0iSlMFxQJq/n6sEqpNUkk+vmJiw6mRjRiRpji+gjjwE
         bv9xplgQOOH4Qga5jKikdRjNyB/BgLBXODmWpziP6eS6VFvggmhtLgA5sFbYCyRkqCxp
         /36tJDZPAclOonYhGyafA1/1MkZj8+QfWnSrm60pAPDyEkWav6TLQvKlTKxdpkd4ZXiY
         80IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ysFBZ+5cz052qkt55kEvevVKRcuEU8Vm/ytnbHXiHOY=;
        b=FuGyjF92p1sXYxiD9pIDvPXKiRLFHku4c1MQiZVOJRFRdC8lYuqxHfAE6B0vkJrJcw
         S8m3Fe8E3JVepXHJNBsDxLDPPrrK2l7Hzr6Besmyuu6FgKw57ajbLN3PIuup6wIbtX1H
         cfvQEl27zR2boiPgDRpAC03HLAkjQ0F9pwg+dG35eOtWbzKz2Qsx/UEbTcxe88rqnGWW
         +Tk81Vtsfdx7c/+J8qWCNO1cC3XpqZV830fV0c5FjHxHLeTJ52nmvmj1n3SNkMimSULI
         a1Rys/Nizcus3yQiRCexbCczOlXlq/JXhOhR0QM2yPppA/DA6kXCS3LvhvdGxO6vGar9
         +WaQ==
X-Gm-Message-State: AJaThX41Q1DtKmq2kS5FtD1erLKVBq1AuzMzT0ynU5cWb0cd7HBRUXwY
        E41bKGjD5AqYk25r19npx/nrS3Iy4yKZEFKNpcY=
X-Google-Smtp-Source: AGs4zMb+2vIM+HV0oRUiB8cqZvZR/xFhbOba+LR4yU6DiG7ooIco+sREBoGgxvkKuacbbHgjAHmi4tGntQW/TN6cU9E=
X-Received: by 10.55.58.14 with SMTP id h14mr55254532qka.132.1511807761347;
 Mon, 27 Nov 2017 10:36:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Mon, 27 Nov 2017 10:36:00 -0800 (PST)
In-Reply-To: <20171127134716.69471-1-lars.schneider@autodesk.com>
References: <20171127134716.69471-1-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 27 Nov 2017 13:36:00 -0500
X-Google-Sender-Auth: SF9MSU4k64UO9C2evoGxIk2KAZU
Message-ID: <CAPig+cSStSbckFi5K33z0WZThjNZC5Eb1Fb+ikrd5ZajM6mV3Q@mail.gmail.com>
Subject: Re: [PATCH v3] launch_editor(): indicate that Git waits for user input
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 8:47 AM,  <lars.schneider@autodesk.com> wrote:
> When a graphical GIT_EDITOR is spawned by a Git command that opens
> and waits for user input (e.g. "git rebase -i"), then the editor window
> might be obscured by other windows. The user may be left staring at the
> original Git terminal window without even realizing that s/he needs to
> interact with another window before Git can proceed. To this user Git
> appears hanging.
>
> Show a message in the original terminal and get rid of it when the
> editor returns.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/editor.c b/editor.c
> @@ -40,6 +40,35 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
> +               static const char *close_notice = NULL;
> +
> +               if (isatty(2) && !close_notice) {
> +                       char *term = getenv("TERM");
> +
> +                       if (term && strcmp(term, "dumb"))
> +                               /*
> +                                * go back to the beginning and erase the
> +                                * entire line if the terminal is capable
> +                                * to do so, to avoid wasting the vertical
> +                                * space.
> +                                */
> +                               close_notice = "\r\033[K";
> +                       else if (term && strstr(term, "emacsclient"))

You need to check 'editor' here, not 'term', and you should do it
before the "not dumb" terminal check, otherwise you'll never get this
far.

> +                               /*
> +                                * `emacsclient` (or `emacsclientw` on Windows) already prints
> +                                * ("Waiting for Emacs...") if a file is opened for editing.
> +                                * Therefore, we don't need to print the editor launch info.
> +                                */
> +                               ;
> +                       else
> +                               /* otherwise, complete and waste the line */
> +                               close_notice = _("done.\n");
> +               }
