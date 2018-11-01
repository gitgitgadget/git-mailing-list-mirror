Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 912B71F453
	for <e@80x24.org>; Thu,  1 Nov 2018 15:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeKBAoy (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 20:44:54 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34988 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeKBAox (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 20:44:53 -0400
Received: by mail-it1-f193.google.com with SMTP id p64-v6so2613378itp.0
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBM+NiEw1jByi0qUToPLI5q9IYDfsci0ef2nK1ipxFU=;
        b=KSEJrbriKZA9RGjtPJcv/X5xSlsuzMZezRaDWMdL0iwk3ppmpFtfvKed0hzZOOfm80
         R85pHAeF/XPFKArSKST8nLTqeO0egunq8eXQVPMKvzIydIt9BASyRHMvOiF3/js4QFqS
         Krf9oVhC9wmEI573C5FLIWvzWHDrNp7NZjHuXXbkITAhuv+7/f8HmpQtIvl4gKeEl488
         pUoq1KBf+LDIZxmAvJRgOG3jIjqz1ttG6wlMsthiWDAvaNApOHR9LmtLFVtxf15Zxo8Z
         EkX3QVvbQB8LLiOo2qEEXXiyqtYSa4zKkWyoT1A4NZh9X3I3Y9bjNMl5h8QRJBgVAQNT
         SYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBM+NiEw1jByi0qUToPLI5q9IYDfsci0ef2nK1ipxFU=;
        b=W6vW9muEPhGl9OahiXgFCoVjT6e+GOx+5fmD6kzuULxGsv+fvpyWgrcEKrx4jDVpj1
         jXoqxRfTNe2/O2MvC9vTdFUTlfzS28kalEpgoLCwbd1pOlhvJh4l9ewXxsLuyobzpzVz
         Zgmc+552m2c+5eKLvcN0p39jSy7fUZiTQM0YXt72x6ZOoyu4lAJ4fM0Ssa3AMrrQtcif
         uSv18SxOGhm8ginKV5FxUlYncAhps34FxkpncRj0QHZsiaBl2pyqQBcxoK0ckgVCptYq
         AaJ3uEuhcHvrUiTweLhGW7pjD41PlzDQojdaNEGHeFlW4I8uV38LzwCaF9gJ81g4NzY0
         bRMg==
X-Gm-Message-State: AGRZ1gIRgwuHJJdXv2VeJMju8A/rsAaBc3KZuudivS6Eix/bke67W8rP
        aZzMm433ZpnrynnHP5XT95VmxQ329w88LflBreQ=
X-Google-Smtp-Source: AJdET5de1hWfvWo9BLTmrmsQjYlnDmgejXQReD2KcBiOs6DYt4x2sdk568MpGXUcxdQYls/+vw+j8fUZkp/VuKP4JZM=
X-Received: by 2002:a24:b64b:: with SMTP id d11-v6mr5220083itj.10.1541086884126;
 Thu, 01 Nov 2018 08:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com> <72331ce9275ce995009fe8dd3d586bb9d71f2cbf.1540881141.git.liu.denton@gmail.com>
 <CACsJy8Ajc0qWw3RLak1PRPXvQzMHjaFuWJ6BPkhiVg=7fQvCnA@mail.gmail.com> <xmqqk1lxvaj6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1lxvaj6.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 1 Nov 2018 16:40:54 +0100
Message-ID: <CACsJy8AowaAW91wGMYbC8aTOB1NoqQN-5NGx=qUCHp0i6zQRDA@mail.gmail.com>
Subject: Re: [PATCH v2] completion: use builtin completion for format-patch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Anmol Mago <anmolmago@gmail.com>, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 1, 2018 at 2:42 AM Junio C Hamano <gitster@pobox.com> wrote:
> >> @@ -2080,16 +2071,19 @@ _git_send_email ()
> >>                 return
> >>                 ;;
> >>         --*)
> >> -               __gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
> >> -                       --compose --confirm= --dry-run --envelope-sender
> >> -                       --from --identity
> >> -                       --in-reply-to --no-chain-reply-to --no-signed-off-by-cc
> >> -                       --no-suppress-from --no-thread --quiet --reply-to
> >> -                       --signed-off-by-cc --smtp-pass --smtp-server
> >> -                       --smtp-server-port --smtp-encryption= --smtp-user
> >> -                       --subject --suppress-cc= --suppress-from --thread --to
> >> -                       --validate --no-validate
> >> -                       $__git_format_patch_options"
> >> +               __gitcomp "--all --annotate --attach --bcc --binary --cc --cc= --cc-cmd
> >> +                       --chain-reply-to --compose --confirm= --cover-letter --dry-run
> >> +                       --dst-prefix= --envelope-sender --from --full-index --identity
> >> +                       --ignore-if-in-upstream --inline --in-reply-to --in-reply-to=
> >> +                       --keep-subject --no-attach --no-chain-reply-to --no-prefix
> >> +                       --no-signature --no-signed-off-by-cc --no-suppress-from --not --notes
> >> +                       --no-thread --no-validate --numbered --numbered-files
> >> +                       --output-directory --quiet --reply-to --reroll-count --signature
> >> +                       --signed-off-by-cc --signoff --smtp-encryption= --smtp-pass
> >> +                       --smtp-server --smtp-server-port --smtp-user --src-prefix=
> >> +                       --start-number --stdout --subject --subject-prefix= --suffix=
> >> +                       --suppress-cc= --suppress-from --thread --thread= --to --to=
> >> +                       --validate"
> >
> > I have no comment about this. In an ideal world, sendemail.perl could
> > be taught to support --git-completion-helper but I don't think my
> > little remaining Perl knowledge (or time) is enough to do it. Perhaps
> > this will do. I don't know.
>
> So "all", "attach", etc. are added to this list while these similar
> options are lost from the other variable?  Is this a good trade-off?

Not sure if I understand you correctly, but it looks to me that the
options in git-send-email.perl are well organized, so we could add
--git-completon-helper in that script to print all send-email specific
options, then call "git format-patch --git-completion-helper" to add a
bunch more. The options that are handled by setup_revisions() will
have to be maintained manually here like $__git_format_patch_options
and added on top in both _git_send_email () and _git_format_patch ().

So, nothing option is lost and by the time setup_revisions() supports
-git-completion-helper, we can get rid of the manual shell variable
too. The downside is, lots of work, probably.
-- 
Duy
