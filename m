Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5FA01FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 08:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbdCIIIi (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 03:08:38 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36292 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbdCIIIg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 03:08:36 -0500
Received: by mail-lf0-f67.google.com with SMTP id g70so3995371lfh.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 00:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YL9rthl/oAzv5vDTfD8EyH52G0JNz89EKRD3TlAxmNk=;
        b=NbGdEmFxGGQ4c3+VCNBtcI5c8t9z0A1/Y6UyjXvImFp6BMWlItMauTUBR5l4nzXGwt
         nZ2AOl2zAkDBWkMSDW2Fd2J8P43qFFSI9Bs+3NSzbkB8JT5YMrH8XJvS8d1VMF4inBbF
         7TbYBBbWRp1Thb3mBpzeu9zwJqBo6CO6iYsGkrbqy370M/bipVOqVeiHqFQsNDK5TCyE
         xxlYlLxKqF0GQuEmWTyolaQXbauckCPtHo/yu479l7GXQGksVeUWgIJon0suGwdmOkru
         cyhOPyjsg02a0NBnFe1sptSuFeuKY062HG385fzYKjxWHfGh8L4b+4+z6IZWMrxGbhC/
         +dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YL9rthl/oAzv5vDTfD8EyH52G0JNz89EKRD3TlAxmNk=;
        b=QbEiK/zW1rzWH0Ansa+Zu+FMSw96kKbCPyr26olKqinaSvzI5Rle1R9UhJFT4L9IJy
         YVsUfm2tweBLfz4UeUxTKlFBkfB7Q+Hb0OBYtoinplFnRbnRvU10IWcJjwso+5iWlDkF
         ViDFFFbEVIKbd/srzkvKTbi895iBhYQ2yI/i96x0zkEkaHmMinfUZJRLEhVp+HILa1ti
         Fxp88BU/qldaTtn/t85gsZuiGSyo7ETy7TX4vdGgH+Jui2EjrJQhB8DN9Ej3Kme0NhsB
         JD9kFjnCHF9EcEbroF7XtJR+thb6xTZjBSjp0zE8PLCx0yEkME2N2BPO1RC23qROC8vn
         gL+A==
X-Gm-Message-State: AMke39npeTaROHazUzKPbpBqRvQk5oDReLsJMOmZ6vSqZGJnpJwNcrM4P5XZ65PArbQ0oYDD5JDq7+ItfNWXRQ==
X-Received: by 10.46.14.1 with SMTP id 1mr3645611ljo.60.1489046914012; Thu, 09
 Mar 2017 00:08:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Thu, 9 Mar 2017 00:08:33 -0800 (PST)
In-Reply-To: <0102015aae7b8536-00c57d0a-1d48-4153-a202-87c4ea9e0e19-000000@eu-west-1.amazonses.com>
References: <0102015aae7b8536-00c57d0a-1d48-4153-a202-87c4ea9e0e19-000000@eu-west-1.amazonses.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Mar 2017 09:08:33 +0100
Message-ID: <CAP8UFD0GtRdjCMcbhjgA0rVaAMFtyto8JxfqbivODarBB0eK8w@mail.gmail.com>
Subject: Re: [PATCH] t2027: avoid using pipes
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 4:13 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> The exit code of the upstream of a pipe is ignored thus we should avoid
> using it.

You might want to say more specifically that we should avoid piping a
git command into another one as this could mask a failure of the git
command.

> By writing out the output of the git command to a file, we
> can test the exit codes of both the commands.
>
> Signed-off-by: Prathamesh <pc44800@gmail.com>
> ---
>  t/t2027-worktree-list.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> index 848da5f..daa7a04 100755
> --- a/t/t2027-worktree-list.sh
> +++ b/t/t2027-worktree-list.sh
> @@ -31,7 +31,7 @@ test_expect_success '"list" all worktrees from main' '
>         test_when_finished "rm -rf here && git worktree prune" &&
>         git worktree add --detach here master &&
>         echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
> -       git worktree list | sed "s/  */ /g" >actual &&
> +       git worktree list >out && sed "s/  */ /g" <out >actual &&

I think it's better if the 'sed' command is on a separate line.

Also you may have used just "out" instead of "<out" in the 'sed' command...

>         test_cmp expect actual
>  '
>
> @@ -118,9 +118,9 @@ test_expect_success 'broken main worktree still at the top' '
>                 cd linked &&
>                 echo "worktree $(pwd)" >expected &&
>                 echo "ref: .broken" >../.git/HEAD &&
> -               git worktree list --porcelain | head -n 3 >actual &&
> +               git worktree list --porcelain >out && head -n 3 out >actual &&

... as above you use "out" not "<out" in the 'head' command.

>                 test_cmp ../expected actual &&
> -               git worktree list | head -n 1 >actual.2 &&
> +               git worktree list >out && head -n 1 out >actual.2 &&
>                 grep -F "(error)" actual.2
>         )
>  '
