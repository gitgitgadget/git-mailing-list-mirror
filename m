Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A26C54EBD
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 18:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbjAFSZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 13:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjAFSZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 13:25:25 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FD22AC5
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 10:25:23 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso6026933pjt.0
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 10:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZtbmedCHcB6SJsR9yW+/YL3LjoH6oTr5PMdhj4GdS0=;
        b=jve/Ho8gXTNMDsJkUoFpJg0SUjvzCN4SWI3wzsQelZCNvZDsDwNnJG+mELP9kOa8/W
         HdStHmf8AGqWesYrMjOYVaYZ2FoYLUmj64RAF6Z/kjJz1zyJyiF3OzQgL1sWGkjuhkvd
         FWkvkmgAoN8DMKuj2a8UsVyQl/2/GlXbTsi6hOSGzGGGse20q9mOYQEwA1OB+nE+yxdi
         GD7mk290RqOdPNv75Vfwm/W2B+XRXpTqRM+XSuyA4GsKFaJcmKlVfKmTs51O+1WIxBAP
         PDPeQGNtFPDwI+bZhcILWZKITp8QUfibzDRv6N5hEgrA4FdsIyUNb5//ooCTJuT9Kgd+
         Kvog==
X-Gm-Message-State: AFqh2kpzIubM+fDK6QtoL63FRY2hWy4BYwy4SILxNkuzZlgxf3nfi4uK
        NcvN5n6KghHKge7ER0ihW4a885O2B+UA5VMuTq4=
X-Google-Smtp-Source: AMrXdXsEJTaHBUxtkG0hwFN1aUpBUe12/bwrlHidnLGqZjDNSCE0CYP5K6wVnBJR/r4J/GfVme2MWGprQi+q0gnxQNY=
X-Received: by 2002:a17:90b:48cf:b0:226:164f:522e with SMTP id
 li15-20020a17090b48cf00b00226164f522emr2438481pjb.22.1673029522830; Fri, 06
 Jan 2023 10:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20230106131304.20779-1-rybak.a.v@gmail.com>
In-Reply-To: <20230106131304.20779-1-rybak.a.v@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jan 2023 13:25:11 -0500
Message-ID: <CAPig+cTgUPWxMox_nSka52dML6_GHUUoY4HCtcq7+7J0oEyeNw@mail.gmail.com>
Subject: Re: [PATCH] *: fix typos which duplicate a word
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 6, 2023 at 8:16 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> Fix typos in code comments which repeat various words.  Most of the
> cases are simple in that they repeat a word that usually cannot be
> repeated in a grammatically correct sentence.  Just remove the
> incorrectly duplicated word in these cases and rewrap text, if needed.
>
> Reword code comment "entries exist on on-disk index" in function
> update_one in file cache-tree.c, by replacing incorrect preposition "on"
> with "in".

Thanks, these all look sensible.

> A tricky case is usage of "that that", which is sometimes grammatically
> correct.  However, an instance of this in "t7527-builtin-fsmonitor.sh"
> doesn't need two words "that", because there is only one daemon being
> discussed, so the word "daemon" does not need a determiner.

But...

> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> @@ -922,7 +922,7 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
> -       # Rename .git using an alternate spelling to verify that that
> +       # Rename .git using an alternate spelling to verify that
>         # daemon detects it and automatically shuts down.
>         mv test_insensitive/.GIT test_insensitive/.FOO &&

... this doesn't read as well following the change. It would read well
if you changed it to "that the".

Not related to your patch at all, but I notice in this test that the
call to test_when_finished() is commented out:

    # test_when_finished "stop_daemon_delete_repo test_insensitive" &&

which makes me wonder if it was commented out while the test was being
debugged but then forgotten, and that the script is now potentially
leaking a running daemon if something in the test fails after the
daemon was started, or if the daemon does not shut down on its own as
it's supposed to do. [cc:+Jeff Hostetler]
