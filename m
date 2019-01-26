Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1FED1F453
	for <e@80x24.org>; Sat, 26 Jan 2019 11:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfAZLB5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 06:01:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52136 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAZLB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 06:01:56 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so14338654ite.1
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RB+tVPJ06q0qvaQ+O614oRxxCpZZ4P6Z876e2uJZO4Y=;
        b=HFkYdhDI3fTp2sT/cgyF+Q63qwt0IbLjAKDVjy7ESNQnruwdwhDB1IHQd3gDjTxFxi
         chPvlwA9TaLgs1fOh5GvtSANd26xaYyquzEmC903PILi7tj2kmNmYfg2Ru+4t4NcYS24
         cDF5rZhHVzZjQ+GNoicX7msfMvZFyQtM7aJl82K8mRkkrOG22EDNyr7jDpBhkdFr/n2b
         6cPWoYQiiLwS7bLL43aMTwARRbLTPQbRLiJZuNebkavylkt2Wj7E2vzx5xOtmOirR5wp
         4WvbBX0Z37D3AClkZgEWrBLU2qBFed7J5D2aGjN/i4sKiTGjp5tlbk6KJNmkvG2hQ7Oe
         LFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RB+tVPJ06q0qvaQ+O614oRxxCpZZ4P6Z876e2uJZO4Y=;
        b=dZ49r1oTn3K7dvjIie9INtcPB5wn71qt0C71hQuLNRG46AzahIJQK6bJKuSJWGWI13
         s/F3ZqKks+Lhu6QbonmTBtjysZSPRXyUrOY+47BKbwvGmpAbV42tPkNB1t9gtfRKW2C3
         jr2elGWeRc/fYesNQvL6uq1UUrBoEM27IR+ekxAdWZAqY8F81w1arCBiCtqKjDzInpi1
         8ID495Ffc2Zo+BgtYzUjfbAMFtvTP4Xb5xQmC//c7acwVRCcIlzIT6oMFfZ+vsCbS93E
         bDLWHYqKC1CaCjXXoonkyBze68AQ4Je9VZhP9MwzzhTTvli7OAY6sE3aODSOMmAjMcoh
         WqWA==
X-Gm-Message-State: AJcUukcJEnJlbUi+bIDjI3/mP6MfAjnqIgCBBe3DCtlUU8IeleGSM/+E
        OJOx23OweiDeAeZF5IDK12JVE8KcBkNhcnKBQtQ=
X-Google-Smtp-Source: ALg8bN6r+KcS9FoffVFj+fcXz1rtiLzVubbWhahYItf82PBnAVW17RXubqyEuYefhnCCumvcoy0287mUpoyxNhuJ2b4=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr6300313itk.70.1548500516056;
 Sat, 26 Jan 2019 03:01:56 -0800 (PST)
MIME-Version: 1.0
References: <CA+xP2Sax+thitfKv4hTtKTYPhfVXJxD_qoJxgkCyZFTzskP-Tw@mail.gmail.com>
In-Reply-To: <CA+xP2Sax+thitfKv4hTtKTYPhfVXJxD_qoJxgkCyZFTzskP-Tw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 26 Jan 2019 18:01:29 +0700
Message-ID: <CACsJy8Df6XM55ExRfCjpUQsv2Vm0cOwrSAyNf6net__uztMOGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Setup working tree in describe
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 26, 2019 at 5:44 PM Sebastian Staudt <koraktor@gmail.com> wrote:
>
> This ensures the given working tree is used for --dirty and --broken.
>
> Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> ---
>  builtin/describe.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index cc118448ee..ba1a0b199b 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -601,6 +601,8 @@ int cmd_describe(int argc, const char **argv,
> const char *prefix)
>      if (!hashmap_get_size(&names) && !always)
>          die(_("No names found, cannot describe anything."));
>
> +    setup_work_tree();

This forces worktree's presence in all cases and will die() if
worktree is not available. You need to check if broken or dirty is set
and only call this function in that case.

Though in my opinion it's better to call before we need it in the "if
(broke)" and "else if (dirty)" code blocks. That way you don't even
need to check if it's "dirty" or "broken". Does "broken" really need
this though? If it runs "git diff-index" separately, that command
should handle this setup_work_tree() already, or we may need to fix it
there, not here.

> +
>      if (argc == 0) {
>          if (broken) {
>              struct child_process cp = CHILD_PROCESS_INIT;
> --
> 2.20.1



-- 
Duy
