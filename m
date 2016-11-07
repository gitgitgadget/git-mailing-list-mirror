Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A374E2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 22:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbcKGWOA (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 17:14:00 -0500
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34680 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbcKGWN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 17:13:59 -0500
Received: by mail-yb0-f195.google.com with SMTP id h184so1473929ybb.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 14:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SZHJapt7NlsZSUhYAbwJkyB2oVmuDdOnDt11GS9Atzw=;
        b=AuwHWfOInSWXsc7Jp6dPkBPcHM2SHoGQ80SKWMNoshfF532x/RLqoZsr4ctVuP2a2V
         x4oRztv/UXMTdL9wy3JEhA8d6Pz2vrnjpcUqngUfqs3o+fVN5pYVo8d148v8RhLVjKLn
         IRxs8WLKIUSfzUO3g72Sqr3x7atdngnvLZww2d/1nMRHcs/xaP0OKWAjHtJ3dgwW9w03
         NYkcYvujq08eL55wZITTsNxbYqY7Hlq///KiUXkRczV/bm+wdcYjXq50LBpQQNB3ayt4
         Csy3jWduz9HM/qGGj/NAlc48GYQWUdEzn48nuTqOZvVldxvwvlNSLa7aQ4fEe68yu1hV
         buhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SZHJapt7NlsZSUhYAbwJkyB2oVmuDdOnDt11GS9Atzw=;
        b=AjRlX3OGObIUxpqxtb/Yzuek/5iEf4DUP5A75rjB9Nag3BWoYDRGss89k3y/79vjRA
         V1dIClfgbeVDgrXNStvDxY2cctFZrvzc/iPMejbXAXVXZ+cFAr5rYfXs/ZsczD5QJddr
         xkvsU5VzSkrLVcriC+LrDaNlBaApX21IbdGA7FgZ8bbC9h3fNDEK6+h//6RCHm/0rp2p
         duYo4aNB/JEfhlHrt+AJcxBi3ZPmA4mrpB59qz9RnzWbxnZ0g8X/1Rv9s3+ABaqaqtPl
         dPiusjW8m92gGnoQT0ockfEiITT2nrxxsDCX300LKcZBC8LAMK/jKVuBHAkYmBzkXOvf
         KveA==
X-Gm-Message-State: ABUngvehkRAySEqeFEmnubTpn+zyDs0Apmt6We+/hZ4XNaeXi0By5Mv7MlMvjGlbApjfh7kdN70kWfW5XsHtUQ==
X-Received: by 10.37.53.213 with SMTP id c204mr8651588yba.57.1478556838495;
 Mon, 07 Nov 2016 14:13:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Mon, 7 Nov 2016 14:13:38 -0800 (PST)
In-Reply-To: <e09a5309-351d-d246-d272-f527f50ad444@jump-ing.de>
References: <de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de> <e09a5309-351d-d246-d272-f527f50ad444@jump-ing.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 7 Nov 2016 14:13:38 -0800
Message-ID: <CA+P7+xrSb0bEC4dvEXKGLdhnunO9oyU685t6VCwd0Sj-pnOT0w@mail.gmail.com>
Subject: Re: [PATCH 1/3] gitk: turn off undo manager in the text widget
To:     Markus Hitter <mah@jump-ing.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2016 at 10:57 AM, Markus Hitter <mah@jump-ing.de> wrote:
> From e965e1deb9747bbc2b40dc2de95afb65aee9f7fd Mon Sep 17 00:00:00 2001
> From: Markus Hitter <mah@jump-ing.de>
> Date: Sun, 6 Nov 2016 20:38:03 +0100
> Subject: [PATCH 1/3] gitk: turn off undo manager in the text widget
>
> The diff text widget is read-only, so there's zero point in
> building an undo stack. This change reduces memory consumption of
> this widget by about 95%.
>
> Memory usage of the whole program for viewing a reference commit
> before; 579'692'744 bytes, after: 32'724'446 bytes.
>

Wow. Nice find!

> Test procedure:
>
>  - Choose a largish commit and check it out. In this case one with
>    90'802 lines, 5'006'902 bytes.
>
>  - Have a Tcl version with memory debugging enabled. This is,
>    build one with --enable-symbols=mem passed to configure.
>
>  - Instrument Gitk to regularly show a memory dump. E.g. by adding
>    these code lines at the very bottom:
>
>      proc memDump {} {
>          catch {
>              set output [memory info]
>              puts $output
>          }
>
>          after 3000 memDump
>      }
>
>      memDump
>
>  - Start Gitk, it'll load this largish commit into the diff text
>    field automatically (because it's the current commit).
>
>  - Wait until memory consumption levels out and note the numbers.
>
> Note that the numbers reported by [memory info] are much smaller
> than the ones reported in 'top' (1.75 GB vs. 105 MB in this case),
> likely due to all the instrumentation coming with the debug
> version of Tcl.
>

Still, this is definitely the lions share of the memory issue.
Additionally, this fix seems much better overall and does not harm any
other aspects of gitk, because we only read the widget so there is as
you mentioned, zero reason to build an undo stack.

Thanks for taking the extra time to find a proper solution to this! I
think it makes perfect sense.

> Signed-off-by: Markus Hitter <mah@jump-ing.de>
> ---
>  gitk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitk b/gitk
> index 805a1c7..8654e29 100755
> --- a/gitk
> +++ b/gitk
> @@ -2403,7 +2403,7 @@ proc makewindow {} {
>
>      set ctext .bleft.bottom.ctext
>      text $ctext -background $bgcolor -foreground $fgcolor \
> -       -state disabled -font textfont \
> +       -state disabled -undo 0 -font textfont \
>         -yscrollcommand scrolltext -wrap none \
>         -xscrollcommand ".bleft.bottom.sbhorizontal set"
>      if {$have_tk85} {
> --
> 2.9.3
>

Nice that such a simple change results in a huge gain. I think this
makes perfect sense.

Regards,
Jake
