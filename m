Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C751F576
	for <e@80x24.org>; Mon,  5 Mar 2018 09:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeCEJcp (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 04:32:45 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42041 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933494AbeCEJcj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 04:32:39 -0500
Received: by mail-oi0-f67.google.com with SMTP id c18so11516552oiy.9
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 01:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6Q25DAGnNU/OqnCKYYB4FpOkd++pAd5PqMlm+MeGWRo=;
        b=AqREdPM0CIPnAX4UTcwkcMEHDa4Fp05rPdrPU80PgzfIhrvmXVn1h4DWKSpfZ1O8Zp
         4//A5VOaqdzPzTJcLfYnnj5S8wHLJcaW/adG717R5t54qYtFY6ZexeAEqqSAuyvj7osq
         4+lsoyyCcM8m+7zo60qEl1V/AZfBzkABct1pE/NDolmgq9v7+YMiQdlQtG9S+EHtIDBV
         35wsw8OcpT0+uBpQYR0cdN11IOXJLXKQwYZIOniwwCsTqE8UheRhX/yFGNkFMhabm4+u
         k5ukiLHpQ/HwJVjedjRLkOweFk5YzOb056kk6Z88v6cuUCnVT5iDuLEXmnLmHayzOZla
         lV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6Q25DAGnNU/OqnCKYYB4FpOkd++pAd5PqMlm+MeGWRo=;
        b=S70il3zQRlPeXA3uZwk5STPKHJzu4yumTiVPVNEHlt0pmk5mAK0QsgxLmuZ0j9cwiS
         YP8nJnrOcRpLqKl/IMe57TOhNmPVX++9ObW7JuAIjH684a2ID6JIG/LN1cRFaBFUcAeK
         D6N2JXsAmATaW4jAnBBPS4FrPjPRk5j/aPHswr5+ymTBeXahGdMjTWKI7zi6q/tkjRZ2
         91K4fZW3aiDEO+aKNqJCaBDYhAyfcZRqM68qI5QqfsucnO4oiz3fvkJkmJcRC8ORC4Ot
         6QNaBJzff/IygOjqBQMfJCK7ADWFdbDs7IEcgFmmqTiQDddVfD0X7mL+bFmVn1FduKW8
         6rAg==
X-Gm-Message-State: AElRT7HWG9CbtG1vG1V1tQbEoECFW1c5MHBuWbZyPO8uxhIrS/a4CWZs
        mePLahz2R1nNiwmJ/vcmhpAYK8HEX+tzo/lSkVA=
X-Google-Smtp-Source: AG47ELtqtCIaQjYwAOH+wK5FB0IA3WvQvnmEusSXkV6g5k0ggTItgdkviuUUm5sCXtwOakxhf/0o6tkW/xwE6bSSgk0=
X-Received: by 10.202.212.147 with SMTP id l141mr9586445oig.32.1520242358699;
 Mon, 05 Mar 2018 01:32:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 5 Mar 2018 01:32:08 -0800 (PST)
In-Reply-To: <20180304052647.26614-1-sunshine@sunshineco.com>
References: <20180212094940.23834-1-pclouds@gmail.com> <20180304052647.26614-1-sunshine@sunshineco.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Mar 2018 16:32:08 +0700
Message-ID: <CACsJy8Ba+CbexdCTBeBNHr0URJfJM8PbAjeVEkYxbpCmEo3shg@mail.gmail.com>
Subject: Re: [PATCH] t2028: fix minor error and issues in newly-added
 "worktree move" tests
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 4, 2018 at 12:26 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Recently-added "git worktree move" tests include a minor error and a few
> small issues. Specifically:
>
> * checking non-existence of wrong file ("source" instead of
>   "destination")
>
> * unneeded redirect (">empty")
>
> * unused variable ("toplevel")
>
> * restoring a worktree location by means of a separate test somewhat
>   distant from the test which moved it rather than using
>   test_when_finished() to restore it in a self-contained fashion

Argh... You're right again :) This looks good.

>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> This patch is built atop nd/worktree-move-reboot in 'next'.
>
> I didn't get around to doing a proper review of nd/worktree-move-reboot
> v2 [1] until after it had graduated to 'next'. Although v2 fixed all the
> issues identified in my review of v1 [2], it introduced a few minor
> issues of its own. This patch addresses those issues.
>
> [1]: https://public-inbox.org/git/20180212094940.23834-1-pclouds@gmail.com/
> [2]: https://public-inbox.org/git/20180124095357.19645-1-pclouds@gmail.com/
>
>  t/t2028-worktree-move.sh | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
> index 082368d8c6..d70d13dabe 100755
> --- a/t/t2028-worktree-move.sh
> +++ b/t/t2028-worktree-move.sh
> @@ -75,7 +75,7 @@ test_expect_success 'move worktree' '
>         git worktree move source destination &&
>         test_path_is_missing source &&
>         git worktree list --porcelain | grep "^worktree.*/destination" &&
> -       ! git worktree list --porcelain | grep "^worktree.*/source" >empty &&
> +       ! git worktree list --porcelain | grep "^worktree.*/source" &&
>         git -C destination log --format=%s >actual2 &&
>         echo init >expected2 &&
>         test_cmp expected2 actual2
> @@ -86,10 +86,10 @@ test_expect_success 'move main worktree' '
>  '
>
>  test_expect_success 'move worktree to another dir' '
> -       toplevel="$(pwd)" &&
>         mkdir some-dir &&
>         git worktree move destination some-dir &&
> -       test_path_is_missing source &&
> +       test_when_finished "git worktree move some-dir/destination destination" &&
> +       test_path_is_missing destination &&
>         git worktree list --porcelain | grep "^worktree.*/some-dir/destination" &&
>         git -C some-dir/destination log --format=%s >actual2 &&
>         echo init >expected2 &&
> @@ -100,10 +100,6 @@ test_expect_success 'remove main worktree' '
>         test_must_fail git worktree remove .
>  '
>
> -test_expect_success 'move some-dir/destination back' '
> -       git worktree move some-dir/destination destination
> -'
> -
>  test_expect_success 'remove locked worktree' '
>         git worktree lock destination &&
>         test_when_finished "git worktree unlock destination" &&
> --
> 2.16.2.660.g709887971b
>
-- 
Duy
