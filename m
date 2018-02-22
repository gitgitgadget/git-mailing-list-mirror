Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6B31F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeBVSwn (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:52:43 -0500
Received: from mail-yb0-f193.google.com ([209.85.213.193]:38843 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeBVSwm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:52:42 -0500
Received: by mail-yb0-f193.google.com with SMTP id p77-v6so2090110yba.5
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wjsKDcN+r4RNNcsbNOCJvUlCzIomJ1LE2OwbRY4Wwsc=;
        b=C7Pcs+R6bg2ohNaIAXineN0mFtiiDO9w+AmyoTgbMfJF/e9RNa2czoT5NFqvRt/pAS
         YpSVjAIcsOW8bwkZCHnF4E5iNiAbZW/nxmIruXx9Zg8d8RVdFQ2XOwiXxd9R99+bPPxn
         5pfBo1toRN6rDCJlsdG2c6RyE5JG5X3XZ3kFl1cgL+HwhkRuJkDlQy/740m0ztUD54dG
         a7LZiuvOGiOy1MkYNdlBpfyDCkpmTIQRNkF99cP+oQVG4cBlHBi3pjyyIGfiZZpwtEoS
         KvJglUPA+x9HsTlzL3cbwW5hyPDx01++Iwly+qhx3JumCoeokCG9erJ7UyyG7nu9HQAa
         j67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wjsKDcN+r4RNNcsbNOCJvUlCzIomJ1LE2OwbRY4Wwsc=;
        b=pXectg3noM3+b12izFvRGKR8e0EtoB5mibtD1tMl/LBiYevrGNrfo8oPEcIPUq2Tqp
         +5URAeuW+brX1ufmvMdyb0tUqRnmwcC9egJ+xwi2liNMesnSs13OxYJf9T95X5y2tkuQ
         y0ZcHafC7OdLqJkOg1+bp+6SKTZoSzEdWYZcPq+s4THAiTgu5RxX7ZVgawyuG8Sw9GUu
         ToF355xucfR5H99u+UdpdRHmBnvT4iI7dPopwg51HrUs1qgG+0c9Bs6zUze6d/gBMF+D
         bnClLS4bwfcJz4aGHaJLtSg75NUoiBrYu/kiXFKZ4fd1Y3jOYUeaTEu/z886fmHHbib/
         9SFQ==
X-Gm-Message-State: APf1xPD8Fbf+stPftwEmGlBumD+1s81R5M87QlQBw/r0y77Ybra/695M
        6bhsuSC++VM5xFN4KBqNPZPeKIE5X4TgtQCM0/sGmg==
X-Google-Smtp-Source: AH8x226oMlLS3Kk9tneei7dpWB+uhGZ6Hl7I9Lg7s684RHYhfo3LGHi3kJurPIRRMfY02sgTgZoKtLhR+uOOMrjwBY0=
X-Received: by 2002:a25:b4d:: with SMTP id 74-v6mr5443977ybl.167.1519325561080;
 Thu, 22 Feb 2018 10:52:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Thu, 22 Feb 2018 10:52:40
 -0800 (PST)
In-Reply-To: <CADfK3RVMxv8RPYS34jhLq=0TievNwwKH2fgn=knPjxraXN=wUw@mail.gmail.com>
References: <CADfK3RXjK9ExcSLLxkbkDvb2o_U9+7Ykua5cHEXc9+uUU17z9g@mail.gmail.com>
 <CADfK3RVMxv8RPYS34jhLq=0TievNwwKH2fgn=knPjxraXN=wUw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Feb 2018 10:52:40 -0800
Message-ID: <CAGZ79kbyVAcVOJ0waD6Fi+9eEs1-gGySLY+A6Rs2_xxXMJbhLQ@mail.gmail.com>
Subject: Re: [PATCH] subtree: hide GPG signatures in calls to log
To:     Stephen R Guglielmo <srguglielmo@gmail.com>
Cc:     git <git@vger.kernel.org>, Avery Pennarun <apenwarr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 5:37 AM, Stephen R Guglielmo
<srguglielmo@gmail.com> wrote:
> On Feb 15, 2018 10:34 PM, "Stephen R Guglielmo" <srguglielmo@gmail.com>
> wrote:
>
> This fixes `add` and `pull` for GPG signed objects.
>
> Signed-off-by: Stephen R Guglielmo <srg@guglielmo.us>

Yay! Thanks for a patch!
I had to go back to the discussion
https://public-inbox.org/git/CADfK3RV1qo_jP=WD6ZF2U9bH2Xf+GJWbC9T4a3YK+C08O0O50Q@mail.gmail.com/
to really understand what is happening here. Can you give a summary
and explanation in the commit message?
(What is the current bug, how is it triggered, and why this is the
best way to fix it? That would be essentially repeating
https://public-inbox.org/git/CADfK3RWAcb0m+m_U51JLA9tNyru_7XEsfy55i5EUsKh98jGFtA@mail.gmail.com/)

Now that I read the discussion, I think the code is fine.

Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  contrib/subtree/git-subtree.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index dec085a23..9594ca4b5 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -297,7 +297,7 @@ find_latest_squash () {
>      main=
>      sub=
>      git log --grep="^git-subtree-dir: $dir/*\$" \
> -        --pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
> +        --no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n'
> HEAD |
>      while read a b junk
>      do
>          debug "$a $b $junk"
> @@ -341,7 +341,7 @@ find_existing_splits () {
>      main=
>      sub=
>      git log --grep="^git-subtree-dir: $dir/*\$" \
> -        --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
> +        --no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n'
> $revs |
>      while read a b junk
>      do
>          case "$a" in
> @@ -382,7 +382,7 @@ copy_commit () {
>      # We're going to set some environment vars here, so
>      # do it in a subshell to get rid of them safely later
>      debug copy_commit "{$1}" "{$2}" "{$3}"
> -    git log -1 --pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
> +    git log --no-show-signature -1
> --pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
>      (
>          read GIT_AUTHOR_NAME
>          read GIT_AUTHOR_EMAIL
> @@ -462,8 +462,8 @@ squash_msg () {
>          oldsub_short=$(git rev-parse --short "$oldsub")
>          echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
>          echo
> -        git log --pretty=tformat:'%h %s' "$oldsub..$newsub"
> -        git log --pretty=tformat:'REVERT: %h %s' "$newsub..$oldsub"
> +        git log --no-show-signature --pretty=tformat:'%h %s'
> "$oldsub..$newsub"
> +        git log --no-show-signature --pretty=tformat:'REVERT: %h %s'
> "$newsub..$oldsub"
>      else
>          echo "Squashed '$dir/' content from commit $newsub_short"
>      fi
> @@ -475,7 +475,7 @@ squash_msg () {
>
>  toptree_for_commit () {
>      commit="$1"
> -    git log -1 --pretty=format:'%T' "$commit" -- || exit $?
> +    git rev-parse --verify "$commit^{tree}" || exit $?
>  }
>
>  subtree_for_commit () {
> --
> 2.16.1
>
>
>
> Hi all, just following up on this as I haven't heard any feedback.
>
> Thanks,
> Steve
