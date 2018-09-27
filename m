Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB69B1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 16:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeI0XHk (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 19:07:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40073 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeI0XHk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 19:07:40 -0400
Received: by mail-io1-f65.google.com with SMTP id w16-v6so2393469iom.7
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjuwWglFDJOKZYuk4382ALgHwGC3ZGn/l6ZTFjSYRp4=;
        b=Epf+vrdYeM2FXVjI5xebfA9XsRQ5BlvKzKxfas3Z1hr/rBD7vNdypPVAiv/KVzjUOE
         HBPvwr9ggC31yIECEp/vpx4SkyYgGh/StEFtbUJqzo5fElrXRMUFBo36gjh0NI3o02H/
         z3tM9s7LFj10WTPeyIy0Y9Rj7j2sWKsc/Z4iD3JSa87QoaX47z6emAkbeApl+wsZId7e
         uRvgMD0pRb/puVoIh8hrO8sDY5XlT1L8t9WlnezemkoSA4Qq3yvKE/IWM/wFUllNFX05
         A3JFnExKQd93+JHNxtm+yot9atIjwrgD/TUJAmM0lzvcosIjCM+exSetifCM3tgUFKE3
         vT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjuwWglFDJOKZYuk4382ALgHwGC3ZGn/l6ZTFjSYRp4=;
        b=UN1odBt1LwKySyeZvt7sHHT9yHzFWMjLbptT6tSusjIuCXEobGafaHy4u3SYpZ0AoJ
         D5aaXtB1X9afDghr6zP1zMos1uZPByW5i6SbjUSPumUm+BhNqWFyq//WcpboIVDFV/gQ
         tOvDePeELPm0N8vb1LPr4VvJEdelxTq3FL2F5gN1Db2OE9cAm82f0T/qfDw8mZ/W2LWB
         yN/8t75s0N6qDkFdSPTru0O8hwE2IVRbXmnddUjMUx9xUh8BVScp0t60eicZLla7EKSD
         kPdUtpyfDuxH8D0SOvb9e86GpelfFjFaArTM4iedagSYpCIML4XEZxYfi1+ejS+AnH5/
         sJCQ==
X-Gm-Message-State: ABuFfojlvfsAl60n8YFAQdtg28rBFT1i5wOBb8ggosse2HQyTNzRfYwf
        lSX28lVofRjdqHlYPn+GABfPlcYYBkmfAjDzxac=
X-Google-Smtp-Source: ACcGV60tYu9M1dKPM93on0zXrYV6GZ/uQK0afJjEDO67Z74dbsJqw1WYS1YFM6B1hovOxeZ3eq+nmQHoDCJ2++N7DHU=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr8705942ioe.282.1538066911767;
 Thu, 27 Sep 2018 09:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180927072043.19130-1-newren@gmail.com>
In-Reply-To: <20180927072043.19130-1-newren@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Sep 2018 18:48:05 +0200
Message-ID: <CACsJy8BPf+ctPs9rHeC+mf9btcPQiW35kA5T81J=66tzF67Pyw@mail.gmail.com>
Subject: Re: Triggering "BUG: wt-status.c:476: multiple renames on the same
 target? how?"
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        andreastacchiotti@gmail.com,
        =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 9:20 AM Elijah Newren <newren@gmail.com> wrote:
> Subject: [PATCH] commit: fix erroneous BUG, 'multiple renames on the same
>  target? how?'
>
> builtin/commit.c:prepare_to_commit() can call run_status() twice if
> using the editor, including status, and the user attempts to record a
> non-merge empty commit without explicit --allow-empty.  If there is also
> a rename involved as well (due to using 'git add -N'), then a BUG in
> wt-status.c is triggered:
>
>   BUG: wt-status.c:476: multiple renames on the same target? how?
>
> The reason we hit this bug is that both run_status() calls use the same
> struct wt_status * (named s), and s->change is not freed between runs.
> Changes are inserted into s with string_list_insert, which usually means
> that the second run just recomputes all the same results and overwrites
> what was computed the first time.  However, ever since commit
> 176ea7479309 ("wt-status.c: handle worktree renames", 2017-12-27),
> wt-status started checking for renames and copies but also added a
> preventative check that d->rename_status wasn't already set and output a
> BUG message if it was.  The problem isn't that there are multiple rename
> targets to a single path as the error implies, the problem is that 's'
> is not freed/cleared between the two run_status() calls.

Phew.. so technically it's not my fault, I just helped expose the bug
with my BUG() line, probably.

> Ever since commit dc6b1d92ca9c ("wt-status: use settings from
> git_diff_ui_config", 2018-05-04), which stopped hardcoding
> DIFF_DETECT_RENAME and allowed users to ask for copy detection, this bug
> has also been triggerable with a copy instead of a rename.
>
> Fix the bug by clearing s->change.  A better change might be to clean up
> all of s between the two run_status() calls.

You clear s->change just before the second call, but perhaps you
should do it right after the first. It seems other code authors were
already aware of this sharing "s" and worked around changing
s->use_color at the first call site, it seems neater to keep all this
temporary fixes in just one place:

    saved_color_setting = s->use_color;
    s->use_color = 0;
    commitable = run_status(s->fp, index_file, prefix, 1, s);
    s->use_color = saved_color_setting;

> A good first step towards
> such a goal might be writing a function to free the necessary fields in
> the wt_status * struct; a cursory glance at the code suggests all of its
> allocated data is probably leaked.  However, doing all that cleanup is a
> bigger task for someone else interested to tackle; just fix the bug for
> now.

I agree. Keep the bug fix to the point. Cleanup and stuff could be
done later (and perhaps try to run all the heavy "diff" just once
instead of twice like this).
-- 
Duy
