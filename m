Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C561F404
	for <e@80x24.org>; Thu,  8 Feb 2018 13:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbeBHNxT (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 08:53:19 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:37079 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeBHNxS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 08:53:18 -0500
Received: by mail-lf0-f45.google.com with SMTP id f137so6510607lfe.4
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 05:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u6MqRh295VtZmVk3pahr7lFdv2zrw7BU9WpbJi45p94=;
        b=EzBydgzU/GiWPGGesh/dwXxMCiYEAd1UM1VGrzgRmvdRVlCKo/bCzKdO+OSjAOc7hT
         3YlwRBQPQhpQBoYinrJaU6UlEDIuAfBxB/j7zotvZcA6u7SdLKsdp88IlGASFeg025P9
         TOQWdAJUH4IvwpvY0M5uCDoJu0zWGHAfGOfR4e2AinOpJVw7Sc+tVv4D0sRsw2cU6buo
         R4OKdnLu6oASz6eWGz1uUax/W1kUj42PIK+eaMmC8YdQE0xYZi4AydoLI78QwprLtLbw
         c2rPogbdO5yO+YL2Ar9kP6ZQ/BG/DmZZT8PXnv21ISEjdfNr/DIClHbeUGH6lgJhXzBO
         Hm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u6MqRh295VtZmVk3pahr7lFdv2zrw7BU9WpbJi45p94=;
        b=bvMA/6xN83kj6YVQbpdC+e9W0HEvRRvtPKv8d/BIkjSii02deAj2t8NPti+LdIC/fO
         4oRi/juViSMJcZ8T/DQxue065YuGEZ4arFBBBC1eHmIEomPaDiDO7RCj76hmH2B3+Bb7
         VdsYs+g2Y3pETzynq16Rzz4oshxjBQNbtTl/e/afHz3KeW/44e5bcY+LaCxQBvRsO9ic
         FlYWKwGjnTrwSqb9gLr3YHncjzVId1vMqJ1uRSsAL55p+YXxaWQJP2fQzb9gfHOjSnh/
         lSOCfOXm3KOVsphIE6Rm1/89euI4luYipj5HQRn8KVxHpUIarQvh1OED3Fr8unTyQzIs
         lxIw==
X-Gm-Message-State: APf1xPBzwP2ezznDvFTb78m1TMQJDN6OmmEjIMYJuKMMOwKkA+J5DIey
        gEITYNl7quS60+u/YQhOfdokB8DIiF7GwtdGtRg=
X-Google-Smtp-Source: AH8x2279blIiURGI8jjW4yTIW+2NPm/bL5/OcA5rCH7vPdCSoBP+lJD2OPhnDbr8qOXMIzLY4O2o7sUM6HMgkXUKOh8=
X-Received: by 10.46.125.3 with SMTP id y3mr570979ljc.23.1518097996885; Thu,
 08 Feb 2018 05:53:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.125.26 with HTTP; Thu, 8 Feb 2018 05:53:16 -0800 (PST)
In-Reply-To: <xmqqh8qvb7h4.fsf@gitster-ct.c.googlers.com>
References: <CADfK3RWXDuE=hYD==4sHXO1iJeOiVDOp7hBqhBtSn7gnQ+x7Qg@mail.gmail.com>
 <CADfK3RU4WJLV9EtieWYQzzRBoJkpyE+w178WQk+wj6soFwKW7g@mail.gmail.com>
 <CADfK3RVJdk3zK7+eE45-PSkb=_v86wrC0TzY+hUmAkfO0Dea=w@mail.gmail.com>
 <CAGZ79kafgyOujDM4BsXdDUnP+iFk5mp2bYnX-Q65khW-weEhUg@mail.gmail.com>
 <xmqqy3kfq6a9.fsf@gitster-ct.c.googlers.com> <CAHqTa-0kdkDUjH1nw=4JPAivtyL84zfZ5t8Dj1UYXPrMd7Poqw@mail.gmail.com>
 <CADfK3RXOqB7wKnXCWxgyDeov-Y7rVQiWFUa_hKZk=j9ReY9JDQ@mail.gmail.com>
 <CADfK3RWAcb0m+m_U51JLA9tNyru_7XEsfy55i5EUsKh98jGFtA@mail.gmail.com> <xmqqh8qvb7h4.fsf@gitster-ct.c.googlers.com>
From:   Stephen R Guglielmo <srguglielmo@gmail.com>
Date:   Thu, 8 Feb 2018 08:53:16 -0500
Message-ID: <CADfK3RV1qo_jP=WD6ZF2U9bH2Xf+GJWbC9T4a3YK+C08O0O50Q@mail.gmail.com>
Subject: Re: Bug Report: Subtrees and GPG Signed Commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 1:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Given that all references to this shell function seem to do
>
>         sometree=$(toptree_for_commit $something)
>
> and then $sometree is used as if it were a tree object name, I can
> understand why the lack of --no-show-signature in the original
> breaks it when the user has show-signature configured.
>
> It probably makes more sense to replace the "git log" with something
> more appropirate for the job, like
>
>         git rev-parse --verify "$commit^{tree}"
>
> though.

Junio,

Thanks for the feedback. I read the documentation on `rev-parse` and I
agree it makes more sense for this case. I've modified
`toptree_for_commit()` to use `rev-parse` instead. However, there's a
few other calls to `log` that I'm not sure can be replaced. For those,
I've kept `--no-show-signature`, making this require at least v2.10.0.

Below is the full diff against v2.16.1. Or, for the GitHub-savvy among us:

https://github.com/srguglielmo/git/compare/8279ed033f703d4115bee620dccd32a9ec94d9aa...srguglielmo:4b92b4494da057ed52c2ff8c329457a1c294d135

Thanks,
Steve

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index dec085a23..9594ca4b5 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -297,7 +297,7 @@ find_latest_squash () {
     main=
     sub=
     git log --grep="^git-subtree-dir: $dir/*\$" \
-        --pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
+        --no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
     while read a b junk
     do
         debug "$a $b $junk"
@@ -341,7 +341,7 @@ find_existing_splits () {
     main=
     sub=
     git log --grep="^git-subtree-dir: $dir/*\$" \
-        --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
+        --no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
     while read a b junk
     do
         case "$a" in
@@ -382,7 +382,7 @@ copy_commit () {
     # We're going to set some environment vars here, so
     # do it in a subshell to get rid of them safely later
     debug copy_commit "{$1}" "{$2}" "{$3}"
-    git log -1 --pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
+    git log --no-show-signature -1
--pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
     (
         read GIT_AUTHOR_NAME
         read GIT_AUTHOR_EMAIL
@@ -462,8 +462,8 @@ squash_msg () {
         oldsub_short=$(git rev-parse --short "$oldsub")
         echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
         echo
-        git log --pretty=tformat:'%h %s' "$oldsub..$newsub"
-        git log --pretty=tformat:'REVERT: %h %s' "$newsub..$oldsub"
+        git log --no-show-signature --pretty=tformat:'%h %s' "$oldsub..$newsub"
+        git log --no-show-signature --pretty=tformat:'REVERT: %h %s'
"$newsub..$oldsub"
     else
         echo "Squashed '$dir/' content from commit $newsub_short"
     fi
@@ -475,7 +475,7 @@ squash_msg () {

 toptree_for_commit () {
     commit="$1"
-    git log -1 --pretty=format:'%T' "$commit" -- || exit $?
+    git rev-parse --verify "$commit^{tree}" || exit $?
 }

 subtree_for_commit () {
