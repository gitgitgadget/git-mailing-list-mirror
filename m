Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DADFF1FCCA
	for <e@80x24.org>; Tue, 27 Jun 2017 07:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbdF0HSk (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 03:18:40 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37314 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbdF0HSj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 03:18:39 -0400
Received: by mail-it0-f44.google.com with SMTP id m84so10974878ita.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 00:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8J7+ByHbbFKEML9x9f1pK5FXDp5tX4p1wt9X/9Faao0=;
        b=TvgmbgyhOthKH+TJFgJFe0wVv7u/c5QnPnLFI8yqYhrdQgkuqugBw4PHIN1Q1X9CkJ
         e3fP8FrAPTBnWY+c5XnaIImqAp9P/PfOGNReQjZiYtK0SnVH/zdWM8HdkFydtl7UFAS8
         AA23C85au4T2STHkGhjn66MEves773rtfC6Uy/NUxBY9vlTgAdlBsPofFpIYX6i1u9AD
         8314ZMZeeuo8w43Ufee5SDRC6r99dledjFrTMbEk+jT2LI3WRIax3UV6OYH+TC/b/4Ex
         PA4RRNV+kviqqEtA6pwm4ZYE/A59NOYU1q+g9DkfoiYv67jqNXOpO8z4jPqk4+6Csqsf
         qiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8J7+ByHbbFKEML9x9f1pK5FXDp5tX4p1wt9X/9Faao0=;
        b=LSwfb2EKudKSmtrDGYDvcPBpVU8o5S94TDdBlfLP9YSjJdBRtTJGa56XW4vDQmKgaW
         g/jqWUumaaE+UnwA8/GXZTU1cA3at80GgdG9fNSKLHp4aSBxuxuBPcLyV/ysxXl7g/NU
         SolzQ3TKzFpq+iVQcAMn5c2q1LaxhVxEbq1Ck3TM33LAj6sFgOs7VpITAprx6wX+eOZ5
         umdJqU6f6HgVBh6Lg4m8BJ34szWKWu9wsoUDD58WxrwMKTinnnxqZhirHtWZ7ePLacZu
         gUAdulY88YdcygBn6vGi6FpVjY/scE4R5J9IjT5wkcrljakaj6rRs3nMmErg7h5X/SC4
         Lpgw==
X-Gm-Message-State: AKS2vOxvk0aqAuzoOfTnMHoZjfQ5XAzhcWi0/RVvz7j59e+h5hRAKCqT
        cWAeBKu7qTTuik8q0XA7dQUR/uLzvA==
X-Received: by 10.36.210.194 with SMTP id z185mr1952945itf.112.1498547908628;
 Tue, 27 Jun 2017 00:18:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Tue, 27 Jun 2017 00:18:28 -0700 (PDT)
In-Reply-To: <20170626231108.23640-6-pc44800@gmail.com>
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
 <20170626231108.23640-1-pc44800@gmail.com> <20170626231108.23640-6-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 27 Jun 2017 09:18:28 +0200
Message-ID: <CAP8UFD1mdgtHWt0CD32O=jXPkGLBiba-41DUchT4WT7CheH4bA@mail.gmail.com>
Subject: Re: [GSoC][PATCH 6/6 v2] submodule: port submodule subcommand
 'deinit' from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2017 at 1:11 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:

> +static void deinit_submodule(const struct cache_entry *list_item,
> +                            void *cb_data)
> +{
> +       struct deinit_cb *info = cb_data;
> +       const struct submodule *sub;
> +       char *displaypath = NULL;
> +       struct child_process cp_config = CHILD_PROCESS_INIT;
> +       struct strbuf sb_config = STRBUF_INIT;
> +       char *sm_path = xstrdup(list_item->name);
> +       char *sub_git_dir = xstrfmt("%s/.git", sm_path);
> +
> +       sub = submodule_from_path(null_sha1, sm_path);
> +
> +       if (!sub->name)

In the previous patch "!sub" is used before "!sub->url", so we might
want to check "!sub" here too.

> +               goto cleanup;
> +
> +       displaypath = get_submodule_displaypath(sm_path, info->prefix);
> +
> +       /* remove the submodule work tree (unless the user already did it) */
> +       if (is_directory(sm_path)) {
> +               struct child_process cp = CHILD_PROCESS_INIT;
> +
> +               /* protect submodules containing a .git directory */
> +               if (is_git_directory(sub_git_dir))
> +                       die(_("Submodule work tree '%s' contains a .git "
> +                             "directory use 'rm -rf' if you really want "
> +                             "to remove it including all of its history"),
> +                             displaypath);
> +
> +               if (!info->force) {
> +                       struct child_process cp_rm = CHILD_PROCESS_INIT;
> +                       cp_rm.git_cmd = 1;
> +                       argv_array_pushl(&cp_rm.args, "rm", "-qn", sm_path,
> +                                        NULL);
> +
> +                       /* list_item->name is changed by cmd_rm() below */

It looks like cmd_rm() is not used anymore below, so this comment
could go and the sm_path variable might not be needed any more.

> +                       if (run_command(&cp_rm))
> +                               die(_("Submodule work tree '%s' contains local "
> +                                     "modifications; use '-f' to discard them"),
> +                                     displaypath);
> +               }
> +
> +               cp.use_shell = 1;

Do we really need a shell here?

> +               argv_array_pushl(&cp.args, "rm", "-rf", sm_path, NULL);
> +               if (!run_command(&cp)) {
> +                       if (!info->quiet)
> +                               printf(_("Cleared directory '%s'\n"),
> +                                        displaypath);
> +               } else {
> +                       if (!info->quiet)
> +                               printf(_("Could not remove submodule work tree '%s'\n"),
> +                                        displaypath);
> +               }
> +       }
> +
> +       if (mkdir(sm_path, 0700))

Are you sure about the 0700 mode?
Shouldn't this depend on the shared repository settings?

> +               die(_("could not create empty submodule directory %s"),
> +                     displaypath);
