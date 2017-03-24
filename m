Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFDCD2095E
	for <e@80x24.org>; Fri, 24 Mar 2017 11:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbdCXLHb (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 07:07:31 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35618 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757213AbdCXLH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 07:07:27 -0400
Received: by mail-it0-f65.google.com with SMTP id y18so1381982itc.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QmPytgVqdVkTDKxyjcYvTWKgzF+TVfMBmZNvnBiNOuw=;
        b=C0ddWfn4+LSyKoI5S8ZIXOfQ7LH89S/ebkMRmahNsjz2Tyi2dqVYsSiNaaFyUocCJc
         RPiqHjYMXnNzVBFrAtgH3V9OEJhVOCWL8fu0MxBOI9JzeNwq/NZ0cWhNTESCAXY7jZt0
         E1RKqvDKw4i4XGlCGMn1vaGvSL0LMYomlOYGg6VHyIzWNcqnuuiEQWuL9TUWQ9FmQg9W
         H86PdX7KEGWqyvk0ob1Bl8xUfwcjMi1zMYZkwuBHPngraAdpn/tzcqp7ww+ZM5/ivl8x
         WgZznxUlhLcF0oLRnb/Mw7TVVAMf+B0GtkEmqgG5DTQkc+O60LqUDzOugv9g+dsagOpL
         58mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QmPytgVqdVkTDKxyjcYvTWKgzF+TVfMBmZNvnBiNOuw=;
        b=ZEfy+NVSN3MfET/KW4xk6t8L57Kv7l4xTnBnkxapZT/bWwpXrrr6noTanNdO2II4as
         tduKT1iApfM3RsH+3Vhm730iMv5SwdZRUd0AFWKDImigJxlIMId8Dd0dG6sqrFbCAQrP
         Ijpb4IDYRkH8uQJP3/qxKtJQBwrNQR8MHV8Mbk4vEmvK14hVZkGSfIi7ulzGeY6e6mKs
         mGNN2/224VxXiH19OLORqXCBS6kTzi1+QF9xYMSzyBAtlIUp7L//KRgj1whTvNFeqA4E
         8onEnhQirEDJlETOYiCy9nmzCF5JnxMcpDZuPJNyF6iN1W2GpqzxweQOZwn5puz4eRYN
         3xew==
X-Gm-Message-State: AFeK/H1K49MNV+nNRPf6cWT4pprKRGeMFnU3P5JVmDMm2QQIqKMvOtODhKSubVAzfImhhX/mCMFBuHIvMclHRQ==
X-Received: by 10.36.95.85 with SMTP id r82mr2274389itb.91.1490353621788; Fri,
 24 Mar 2017 04:07:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Fri, 24 Mar 2017 04:06:41 -0700 (PDT)
In-Reply-To: <xmqqtw6j8e7f.fsf_-_@gitster.mtv.corp.google.com>
References: <20170323120326.19051-1-avarab@gmail.com> <xmqq1stoexmb.fsf@gitster.mtv.corp.google.com>
 <CACBZZX7vW0TkbrBvLvKWnY=UpHNHzzQ7wuwhEhNOjCCjzPVMjA@mail.gmail.com>
 <xmqq37e3brxz.fsf@gitster.mtv.corp.google.com> <20170324004858.GE20794@aiede.mtv.corp.google.com>
 <xmqqtw6j8e7f.fsf_-_@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 24 Mar 2017 12:06:41 +0100
Message-ID: <CACBZZX5xKaOBY8nWAbnLGyRiHW0MnFsEeF5ehpVCviyWc1mb3w@mail.gmail.com>
Subject: Re: [PATCH] branch doc: update description for `--list`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 5:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The paragraph begins with a sample command line `git branch <name>`
> that has nothing to do with the option being described.  Remove it,
> but use the space to instead show that multiple patterns can be
> given.
>
> Also mention the unfortunate `-l` that can be easily confused with
> it.
>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-branch.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 6a17ca591a..514b0d0b91 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -142,8 +142,13 @@ This option is only applicable in non-verbose mode.
>         List both remote-tracking branches and local branches.
>
>  --list::
> -       Activate the list mode. `git branch <branchname>` would try to create a branch,
> -       use `git branch --list <pattern>` to list matching branches.
> +       List branches.  With optional `<pattern>...`, e.g. `git
> +       branch --list 'maint-*'`, list only the branches that match
> +       the pattern(s).
> ++
> +This should not be confused with `git branch -l <branchname>`,
> +which creates a branch named `<branchname>` with a reflog.
> +See `--create-reflog` above for details.
Looks good to me.
>  -v::
>  -vv::
> --
> 2.12.1-432-gf364f02724
>
