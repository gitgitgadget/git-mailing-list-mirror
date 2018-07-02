Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835911F516
	for <e@80x24.org>; Mon,  2 Jul 2018 19:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeGBTtw (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 15:49:52 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:37661 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbeGBTtr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 15:49:47 -0400
Received: by mail-yw0-f195.google.com with SMTP id w76-v6so4693484ywg.4
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 12:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=18YiJ6ddiGfuO21GCKHTSO9IPbprirBH7R07NiD/NX4=;
        b=vfTdTALLU5vQgBUes9cEN78u7sXs8e61+GWLH8JdASjJPxH0NEa1NlK8hFpA/L2UxK
         HjSPUyHKJV1uJtiPqQh0A7a8ReHfTKr87mUxQPQB89SWUauWUfvs9nDAsItdBAmZVY+g
         mKksZHy+UeK1J5UjnaE+xRzQT0JVFiUNgL+QfVcGp2BLz6STbQ1wIi3L2b+LkGKWySKy
         arhYX+xzM9eCBFUHplnPDsW/HBP1WDVPY8LOTYd3fRBK6rVv4WBj6Ua9CY48jseX3les
         MdCvdn7EkSEfLVeSnUF8JjS5aA4V2vepCsMO8N+Sr78ozljMmSZ2Ry7l7ts2kNcEftI+
         Xokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=18YiJ6ddiGfuO21GCKHTSO9IPbprirBH7R07NiD/NX4=;
        b=qVdZdfM1FhdM18sMFcs6OpcDviH4d9QMP5wWiGxgHuxOCqKsE6ae0Hb7laQFcCJXtg
         VE3YtxZbh0jzsutxLleox0Zu7DWK/vUgMJ0nz/5FYp/ImX6lyfg0JctkxEI7HqYSgrGX
         Z1m7Y+0FxRY5VdXNEFwbwRkmm1V/jR0CeBIudMFCX/WvuLgzdA6hupHZmD5n6poqCAwu
         ab0jEWh2qpl5d8cF0QLqsgyeLG9ifxc9hplcIU/uvhz3F3j38d8CkQMvLn1r0KyxM9s2
         /WFC4QGDxx22QFQ8yDCLCqYizXwZjrVLqX7T4wmY/wqWHJvL95hK0Wyk9wXlILgzKiXb
         ByNA==
X-Gm-Message-State: APt69E3eDKgPFmJh2A8hzksCBVojPm+w+z9fV9JBOUDuPMJJsXWaT5Py
        3K5ySH3TTLx3Kxd470EEQFjYu+7qNy0zeECpBPRg4A==
X-Google-Smtp-Source: AAOMgpf4EygdTwru2se8X/91czhSHXINYU25+bKR6mWBFiPlvkOuriW8HOFAOmxkZnTnpCpIHcrvNobiLkapVMvt3AM=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr9310454ywj.33.1530560986637;
 Mon, 02 Jul 2018 12:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180702182521.EC55341BAC@mail.steuer-voss.de>
In-Reply-To: <20180702182521.EC55341BAC@mail.steuer-voss.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Jul 2018 12:49:35 -0700
Message-ID: <CAGZ79kbwbUSYDKVfxFyYX6LUW6xgBd7dSPethwP9w5Zz4ritdQ@mail.gmail.com>
Subject: Re: [PATCH] git-gui: use commit message template
To:     Martin.Schoen@loewensteinmedical.de,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Pat, in the hope of an answer.

See
https://public-inbox.org/git/xmqqd0z61xsv.fsf@gitster-ct.c.googlers.com/
on the state of git-gui and its lack of maintenance. Maybe Junio will
pickup this patch.

On Mon, Jul 2, 2018 at 11:35 AM Martin Sch=C3=B6n
<Martin.Schoen@loewensteinmedical.de> wrote:
>
> Use the file described by commit.template (if set) to show the commit mes=
sage
> template, just like other GUIs.

You seem to have looked at and understood the git-gui code, so
I have a feature request for you if you don't mind:
git-gui takes a commit message as a suggestion from git, for example
after a failed merge, when you open git-gui, it pre-populates the
commit message with

  <previous commit message>

  # Conflict: <file.c>

which git knows how to deal with as '#' is a comment character. However whe=
n
using git-gui to compose commit messages, these commented conflicts are not
cut out as git-gui doesn't know how to handle comments?

So it would be awesome if git-gui could either respect '#' as a comment cha=
r,
or rather 'core.commentChar'

>
> Signed-off-by: Martin Sch??n <Martin.Schoen@loewensteinmedical.de>

The encoding seems to be broken here, as I see '??' in your last name.

> ---
>  git-gui.sh     | 9 +++++++++
>  lib/commit.tcl | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 5bc21b8..6fc598d 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1611,6 +1611,12 @@ proc run_prepare_commit_msg_hook {} {
>                 fconfigure $fd_sm -encoding utf-8
>                 puts -nonewline $fd_pcm [read $fd_sm]
>                 close $fd_sm
> +       } elseif {[file isfile [get_config commit.template]]} {
> +               set pcm_source "template"
> +               set fd_sm [open [get_config commit.template] r]
> +               fconfigure $fd_sm -encoding utf-8
> +               puts -nonewline $fd_pcm [read $fd_sm]
> +               close $fd_sm
>         } else {
>                 set pcm_source ""
>         }
> @@ -1620,6 +1626,9 @@ proc run_prepare_commit_msg_hook {} {
>         set fd_ph [githook_read prepare-commit-msg \
>                         [gitdir PREPARE_COMMIT_MSG] $pcm_source]
>         if {$fd_ph eq {}} {
> +               if {$pcm_source eq "template"} {
> +                       load_message PREPARE_COMMIT_MSG
> +               }
>                 catch {file delete [gitdir PREPARE_COMMIT_MSG]}
>                 return 0;
>         }
> diff --git a/lib/commit.tcl b/lib/commit.tcl
> index 83620b7..168f696 100644
> --- a/lib/commit.tcl
> +++ b/lib/commit.tcl
> @@ -506,6 +506,7 @@ A rescan will be automatically started now.
>         unlock_index
>         reshow_diff
>         ui_status [mc "Created commit %s: %s" [string range $cmt_id 0 7] =
$subject]
> +       rescan ui_ready
>  }
>
>  proc commit_postcommit_wait {fd_ph cmt_id} {
> --
> 2.17.1
>
