Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D8E1F576
	for <e@80x24.org>; Tue, 30 Jan 2018 08:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeA3IGU (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 03:06:20 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:40678 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbeA3IGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 03:06:20 -0500
Received: by mail-qk0-f176.google.com with SMTP id d18so9010152qke.7
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ciIKTKt7VcwC2jui3cvav1byeiPLcsMp6M7abIo7Hc8=;
        b=SCGlQ/x8qjrvUXl0uWxQA7mAuRLg7ExXoYiGgIxsLEAY5UvG2xM8NdnBZaxWW0Tv6U
         fGAIYCbTThNxvAwfNe0Ez2Yu1/LrzlRvpR8i7x920ubxRc2EbRsM9/UWLX6vYcixkaBS
         mKrfJMhjKhOtX2jtLljVPhFFqaXqhIokGSl6BobUsHL2NBldlx0vGVjGnXqxOStmwS/B
         HarmEeqPfxV9ZTUqDV+Z48d9aP/zrUAEyzyDTEtnGnld5zxqmcoqLnRve81Pi1FxSjbu
         iY2JEFGhHE/Xq+VJtsLB1pkR7v0Oj9nqZYQ5WnB85GoxCBngmMk1LMUBKFWy+N7LGcLG
         B8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ciIKTKt7VcwC2jui3cvav1byeiPLcsMp6M7abIo7Hc8=;
        b=j7QfzvhTB0SjonR/Lo/9Oj/Tp3O2qGahy/w7tmVNMvJj9HR4XWxqh6urOWfRzJiS1O
         DZcr08FBM7k7ie5UhSo8Qvh52eHo3S0YLnxsmoMm5QY4hX8utHwpwBjE0nCdeBYwbY4/
         hLWLg4zVYraAzMYGYSWBJDCA1lGE55tFIN3Dffp5IBd0/rxp/cwW4PF9CSXQRBMqtl2l
         /wlT5XBorkM43mllQkPJsmMvMc6kgiCdfT1UgQa5tWpsQOpzpw89pjuLG8XYs1GHhb9s
         uYCSECpv5xP225y0mhVmBUAL2p+DSdgoQXHaAxp7xq15QaJaMEw0Huz3cy/1aW9O44gy
         zhPQ==
X-Gm-Message-State: AKwxyteQ2KuJtJSyi6WtK1BGJF6YRloklqSIkiqhCMiT8gOwPdKGQzxb
        k59a572UlRgS5uWLBTBU3Sn10doZPzEV1DXL4w8=
X-Google-Smtp-Source: AH8x2248WTlAddJVplBz1kiaK7I+2B8Kze49LthCtNG2Saxf1u386vA3bCUxSAMXr1crFWBan1JLbLOl4du7zRLAXhE=
X-Received: by 10.55.123.69 with SMTP id w66mr40106392qkc.326.1517299579186;
 Tue, 30 Jan 2018 00:06:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Tue, 30 Jan 2018 00:06:18 -0800 (PST)
In-Reply-To: <36281a14bc9f9a53e6c1bead561e3c93744047a8.1517266437.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <cover.1517266437.git.johannes.schindelin@gmx.de> <36281a14bc9f9a53e6c1bead561e3c93744047a8.1517266437.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Jan 2018 03:06:18 -0500
X-Google-Sender-Auth: iu84BhDrU6PYVisCYEsgA94yuK0
Message-ID: <CAPig+cSkzetewFio+4ECnXiizH_KFGEZPZVdzHYGcKL_yvLcSg@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] sequencer: introduce new commands to reset the revision
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 5:54 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> [...]
> This commit implements the commands to label, and to reset to, given
> revisions. The syntax is:
>
>         label <name>
>         reset <name>
> [...]
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -1253,7 +1266,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>                 if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
>                         item->command = i;
>                         break;
> -               } else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
> +               } else if ((bol + 1 == eol || bol[1] == ' ') &&
> +                          *bol == todo_command_info[i].c) {

This adds support for commands which have no arguments, however, now
that the "bud" command has been retired, this can go away too, right?

>                         bol++;
>                         item->command = i;
>                         break;
> @@ -1919,6 +1934,144 @@ static int do_exec(const char *command_line)
> +static int safe_append(const char *filename, const char *fmt, ...)
> +{
> +       va_list ap;
> +       struct lock_file lock = LOCK_INIT;
> +       int fd = hold_lock_file_for_update(&lock, filename, 0);
> +       struct strbuf buf = STRBUF_INIT;
> +
> +       if (fd < 0)
> +               return error_errno(_("could not lock '%s'"), filename);

Minor: unable_to_lock_message() can provide a more detailed
explanation of the failure.

> +
> +       if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT)
> +               return error_errno(_("could not read '%s'"), filename);
> +       strbuf_complete(&buf, '\n');
> +       va_start(ap, fmt);
> +       strbuf_vaddf(&buf, fmt, ap);
> +       va_end(ap);

Would it make sense to also

    strbuf_complete(&buf, '\n')

here, as well, to be a bit more robust against lazy callers?

> +
> +       if (write_in_full(fd, buf.buf, buf.len) < 0) {
> +               rollback_lock_file(&lock);
> +               return error_errno(_("could not write to '%s'"), filename);

Reading lockfile.h & tempfile.c, I see that rollback_lock_file()
clobbers write_in_full()'s errno before error_errno() is called.

> +       }
> +       if (commit_lock_file(&lock) < 0) {
> +               rollback_lock_file(&lock);
> +               return error(_("failed to finalize '%s'"), filename);
> +       }
> +
> +       return 0;
> +}
> +
> +static int do_reset(const char *name, int len)
> +{
> +       [...]
> +       strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
> +       if (get_oid(ref_name.buf, &oid) &&
> +           get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
> +               error(_("could not read '%s'"), ref_name.buf);

Checking my understanding: The two get_oid() calls allow the argument
to 'reset' to be a label created with the 'label' command or any other
way to name an object, right? If so, then I wonder if the error
invocation should instead be:

    error(_("could not read '%.*s'"), len, name);

> +               rollback_lock_file(&lock);
> +               strbuf_release(&ref_name);
> +               return -1;
> +       }
