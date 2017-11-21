Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10AC62036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdKUXKL (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:10:11 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45864 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdKUXKK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:10:10 -0500
Received: by mail-lf0-f68.google.com with SMTP id f131so8038772lff.12
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=REoDZKaKuginTkgHJTJo7R48p887MR/jDCr3Lv+6QUQ=;
        b=sO8rGgrg14Xu8lAaB4uysouKVxjDu/fvsQOe50vklVzLPvt2roW8QkI8+u3F7SCtuZ
         ms3iuCEsxlyd9AsPIe6wXU0wwNlQn/rkoWvP71AlJvHBjUIUFpyfqSMBmIzWq9CafQu5
         3TXhSy7ursWzvbcsfWLLC23RXWR8qudiHifXqDSa3ZeGXbcFa4v2bmBFNlLaUsL/pjWv
         SflaWLIBqnotoQg6UlclcVkefQoGIDUBP1OuPqyl9AJhX6Oo9eJPDYXd6yqaEF6AJ8Bc
         qL7mG8Nh3mppZOzr5Mu4C9+b+Jx7utTz+TGJ4SbilWEvciOzjNbwu5cY9YlPa4jx1vVF
         dkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=REoDZKaKuginTkgHJTJo7R48p887MR/jDCr3Lv+6QUQ=;
        b=GkjOgWPoihTW6h+pCZHxxwT9bd2ZU2ugeI7Wp8MtZ2+o176rjPDMKl3FpWwNxu2ET0
         Uk/lNlgXjRm3pj+wblGhbO+qqX1LyQtKQfxocSn7XZHhjw3ix3WTIgvj3nA9ToQUwGbG
         kDi9nGZnaFiukshFCX0NWBOGrHLzSVM0AXgi5+i+lPyuQT9h8Ua3qXXcntZZfZ9SWER8
         KMrXJlgBiUYbV+t9oqPnkVAjK0EcAyaNaKWhrfmplX+bJa/wByJ8z2g4yeq5Z2EYDeU5
         bFEopuzIE7aJ5iD2spMHpB7t5I9XjNFTwQOKeLMJK4QKyS8UkgjcldExILXFOCVpLijC
         iCxA==
X-Gm-Message-State: AJaThX7s/f29iQ8hRnIMZQggRJRl5pBgQCGyXH7/3wUlKdFJAwCXavyr
        A4m/AaVP1PCH9CBFjKhkUt+9SMHw0wwVGyil78kjag==
X-Google-Smtp-Source: AGs4zMaXoMKpegIANMfIiBdttcjAb2bSBMWrPrZGkY5tb2MuypnwhsNQ8F/Q+pnbX9Z1v0qS9hi33k+NF2q7VUn4DxE=
X-Received: by 10.46.66.69 with SMTP id p66mr1523357lja.18.1511305808662; Tue,
 21 Nov 2017 15:10:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.179.22.16 with HTTP; Tue, 21 Nov 2017 15:09:48 -0800 (PST)
In-Reply-To: <CABURp0qadq2cAwR_Nk76J8RqpQk4DZwtnu6aS5hR=LjVD-dGgA@mail.gmail.com>
References: <CABURp0qadq2cAwR_Nk76J8RqpQk4DZwtnu6aS5hR=LjVD-dGgA@mail.gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Tue, 21 Nov 2017 15:09:48 -0800
Message-ID: <CABURp0p71fdytYqj3nhhij1APdEY-inmTMbQ8aiF-J-hKd-c0w@mail.gmail.com>
Subject: Re: stash: learn to parse -m/--message like commit does
To:     Git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hm..  Sorry about the formatting here.  It's been a while.  I'll try again.

On Tue, Nov 21, 2017 at 3:07 PM, Phil Hord <phil.hord@gmail.com> wrote:
> `git stash push -m foo` uses "foo" as the message for the stash. But
> `git stash push -m"foo"` does not parse successfully.  Similarly
> `git stash push --message="My stash message"` also fails.  Nothing
> in the documentation suggests this syntax should work, but it does
> work for `git commit`, and my fingers have learned this pattern long
> ago.
>
> Teach `git stash` to parse -mFoo and --message=Foo the same as
> `git commit` would do.
>
> Signed-off-by: Phil Hord <phil.hord@gmail.com>
> ---
>  git-stash.sh | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 4b7495144..1114005ce 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -76,6 +76,12 @@ create_stash () {
>   shift
>   stash_msg=${1?"BUG: create_stash () -m requires an argument"}
>   ;;
> + -m*)
> + stash_msg=${1#-m}
> + ;;
> + --message=*)
> + stash_msg=${1#--message=}
> + ;;
>   -u|--include-untracked)
>   shift
>   untracked=${1?"BUG: create_stash () -u requires an argument"}
> @@ -193,6 +199,12 @@ store_stash () {
>   shift
>   stash_msg="$1"
>   ;;
> + -m*)
> + stash_msg=${1#-m}
> + ;;
> + --message=*)
> + stash_msg=${1#--message=}
> + ;;
>   -q|--quiet)
>   quiet=t
>   ;;
> @@ -251,6 +263,12 @@ push_stash () {
>   test -z ${1+x} && usage
>   stash_msg=$1
>   ;;
> + -m*)
> + stash_msg=${1#-m}
> + ;;
> + --message=*)
> + stash_msg=${1#--message=}
> + ;;
>   --help)
>   show_help
>   ;;
> --
> 2.15.0.471.g17a719cfe.dirty
