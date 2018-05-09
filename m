Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 908771F424
	for <e@80x24.org>; Wed,  9 May 2018 16:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965492AbeEIQ4R (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 12:56:17 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:42074 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935232AbeEIQ4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 12:56:16 -0400
Received: by mail-vk0-f46.google.com with SMTP id j7-v6so22123974vkc.9
        for <git@vger.kernel.org>; Wed, 09 May 2018 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H60sl8oE7z8P9K7zA3oxRp+tt07OWyK1CXI8io14rxM=;
        b=C+DkS9R7typH2qwSHX7ZbKi6znA1KY07a5TTUfPSyx3bRyPevOhIgjqH3C3CzODRXJ
         KFXOLSvfICWS50W2xnFnH4c6yUCdJg8fLQPlYcMdN0Yigu99ZhiGRun5gFLaLk4TVbcE
         ziy04gJ5sR5scsew5H5xFcQlUTSn/UGkd82fGavCrEW49IvYJfcSYoLpLkCPtKdTlN9K
         YhPXignuaAF2Jp/f8lQsbXl6o3wLystF0XwWtb8svKk1Pq8h8f44/dv7lcIxhWqwMK8x
         NGhPKgS29ZytYP0WHFn/9QmeXBLgweh3Jk2I05GXPcoU7YZv7luy4Ov5StkCdUyJzSm6
         EFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H60sl8oE7z8P9K7zA3oxRp+tt07OWyK1CXI8io14rxM=;
        b=s86gjbNOjql0NBfPr9EELczmFkTrteL/kWLqbN3kZUdvGh/NIMAmCtd5/3GqNaETiD
         2FIaKGN34bj7pNcicXQWFimoOxJ5J+MtRqkNuOmuyVtwch8WyW63a7t3VKv8UsubyO4K
         l6NmnqlB21/M7Tlr4Ama7wFqgiLO4NybbAgzd2Bi+YP5AT2nB0spCYwnB+QdPQ3sf9Zv
         +xYxZ95/1GH10i3DjcGBCFemZiWCeq4wEF9cZq4rJgpQifNDAhFJDj1sOwVTAI7ofT+W
         Qo4mCBaFRsNkwlcQ4tgi1K0VGKN2SxbO6kJFvSlFoRK6mOjG0wm/mUxFiD7oVMAAb8Td
         5zbg==
X-Gm-Message-State: ALQs6tAexMpUUrx3b3KUadUH5ilzbcUg/x3ppU02HM4QZDjF/dH8w9eS
        FKoTFaCO1GE8UafRXZfMCAX/oNPqr1/QAGlSWpI=
X-Google-Smtp-Source: AB8JxZqJKCxYC49joZOe2AdDnuNtsOKuwl749uN7kKoRiOYhhsYP4Zo79KE/S+jWozlaoeXeo08yw5h1KLXSwwVzazg=
X-Received: by 2002:a1f:a54:: with SMTP id 81-v6mr34747774vkk.184.1525884975012;
 Wed, 09 May 2018 09:56:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Wed, 9 May 2018 09:56:14 -0700 (PDT)
In-Reply-To: <20180509144213.18032-1-benpeart@microsoft.com>
References: <20180509144213.18032-1-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 May 2018 09:56:14 -0700
Message-ID: <CABPp-BEkQN55diiovv+33P=Ouk+FcK8N4p85EZZqVmw-mxuL1A@mail.gmail.com>
Subject: Re: [PATCH v1] add status config and command line options for rename detection
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

Overall I think this is good, but I have lots of nit-picky things to
bring up.  :-)


On Wed, May 9, 2018 at 7:42 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> Add status --no-renames command line option that enables overriding the config
> setting from the command line. Add --find-renames[=<n>] to enable detecting
> renames and optionaly setting the similarity index from the command line.

s/optionaly/optionally/

> Notes:
>     Base Ref:

No base ref?  ;-)

> +status.renameLimit::
> +       The number of files to consider when performing rename detection;
> +       if not specified, defaults to the value of diff.renameLimit.
> +
> +status.renames::
> +       Whether and how Git detects renames.  If set to "false",
> +       rename detection is disabled. If set to "true", basic rename
> +       detection is enabled.  Defaults to the value of diff.renames.

I suspect that status.renames should mention "copy", just as
diff.renames does.  (We didn't mention it in merge.renames, because
merge isn't an operation for which copy detection can be useful -- at
least not until the diffstat at the end of the merge is controlled by
merge.renames as well...)

Also, do these two config settings only affect 'git status', or does
it also affect the status shown when composing a commit message
(assuming the user hasn't turned commit.status off)?  Does it affect
`git commit --dry-run` too?

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -109,6 +109,10 @@ static int have_option_m;
>  static struct strbuf message = STRBUF_INIT;
>
>  static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
> +static int diff_detect_rename = -1;
> +static int status_detect_rename = -1;
> +static int diff_rename_limit = -1;
> +static int status_rename_limit = -1;

Could we replace these four variables with just two: detect_rename and
rename_limit?  Keeping these separate invites people to write code
using only one of the settings rather than the appropriate inherited
mixture of them, resulting in a weird bug.  More on this below...

> @@ -1259,11 +1273,29 @@ static int git_status_config(const char *k, const char *v, void *cb)
>                         return error(_("Invalid untracked files mode '%s'"), v);
>                 return 0;
>         }
> +       if (!strcmp(k, "diff.renamelimit")) {
> +               diff_rename_limit = git_config_int(k, v);
> +               return 0;
> +       }
> +       if (!strcmp(k, "status.renamelimit")) {
> +               status_rename_limit = git_config_int(k, v);
> +               return 0;
> +       }

Here, since you're already checking diff.renamelimit first, you can
just set rename_limit in both blocks and not need both
diff_rename_limit and status_rename_limit.  (Similar can be said for
diff.renames/status.renames.)

<snip>

> @@ -1297,6 +1329,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>                   N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
>                   PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>                 OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in columns")),
> +               OPT_BOOL(0, "no-renames", &no_renames, N_("do not detect renames")),
> +               { OPTION_CALLBACK, 'M', "find-renames", &rename_score_arg,
> +                 N_("n"), N_("detect renames, optionally set similarity index"),
> +                 PARSE_OPT_OPTARG, opt_parse_rename_score },

Should probably also document these options in
Documentation/git-status.txt (and maybe Documentation/git-commit.txt
as well).

Not sure if we want to add a flag for copy detection (similar to
git-diff's -C/--find-copies and --find-copies-harder), or just leave
that for when someone finds a need.  If left out, might want to just
mention that it was considered and intentionally omitted for now in
the commit message.

> @@ -1336,6 +1372,27 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>         s.ignore_submodule_arg = ignore_submodule_arg;
>         s.status_format = status_format;
>         s.verbose = verbose;
> +       s.detect_rename = no_renames >= 0 ? !no_renames :
> +                                         status_detect_rename >= 0 ? status_detect_rename :
> +                                         diff_detect_rename >= 0 ? diff_detect_rename :

Combining the four vars into two as mentioned above would allow
combining the last two lines above into one.

> +       if ((intptr_t)rename_score_arg != -1) {

I don't understand why rename_score_arg is a (char*) and then you need
to cast to intptr_t, but that may just be because I haven't done much
of anything with option parsing.  A quick look at the docs isn't
making it clear to me, though; could you enlighten me?

> +               s.detect_rename = DIFF_DETECT_RENAME;

What if status.renames is 'copy' but someone wants to override the
score for detecting renames and pass --find-renames=40?  Does the
--find-renames override and degrade the 'copy'?  I think it'd make
more sense to increase s.detect_rename to at least DIFF_DETECT_RENAME,
rather than just outright setting it here.

> +               if (rename_score_arg)
> +                       s.rename_score = parse_rename_score(&rename_score_arg);
> +       }
> +       s.rename_limit = status_rename_limit >= 0 ? status_rename_limit :
> +                                        diff_rename_limit >= 0 ? diff_rename_limit :

Again, combination of variables could allow these last two lines to be combined.

> +                                        s.rename_limit;
> +
> +       /*
> +        * We do not have logic to handle the detection of copies.  In
> +        * fact, it may not even make sense to add such logic: would we
> +        * really want a change to a base file to be propagated through
> +        * multiple other files by a merge?
> +        */
> +       if (s.detect_rename > DIFF_DETECT_RENAME)
> +               s.detect_rename = DIFF_DETECT_RENAME;

This comment and code made sense in merge-recursive.c (which doesn't
show detected diffs/renames/copies but just uses them for internal
processing logic).  It does not make sense here; git status could show
detected copies much like `git diff -C --name-status` shows it.  In
fact, a quick grep for DIFF_STATUS_COPIED shows multiple hits in
wt-status.c, so I suspect it already has the necessary logic for
displaying copies.


I looked over the rest of the patch.  Nice testcases.  Adding a couple
more testcases around copy detection could be useful.
