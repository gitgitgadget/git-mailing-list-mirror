Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62AE71F454
	for <e@80x24.org>; Fri,  2 Nov 2018 04:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeKBNrG (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 09:47:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38010 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeKBNrG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 09:47:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2-v6so800572wmh.3
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 21:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=obSVLw47H5B+RG2UiMD7uhQPadg0qRqXklaMc2zd1w4=;
        b=K9EqZWh2Wipug2g7XWFvkhQZnOs/7+04kiNITeD04M+lRvLwgXwLRNRiCLjl/Lp2aS
         gUxClO+Z92hYCjhw2/6tZ5E2Y/AY+gSJKelCV7LsFNBwo+ztl68EzBjzwnrlvJoFpxxJ
         ckkfoDurN0ttLs17kiu2cYinLFwXFS6QK5Wt4c2H5UZCp4tOlvPwuJdFpKQ+FBWqhVto
         uJR5/lXPTeXKOLysMl+Gtr9bCKLgfWff1oIVd166ZxsEPaEG8vhWMGjJpywXO7LxLZmP
         jUVgxi4oeTuo+MO3x7/Q0M0KXaAQgpHM4Awk+tp5aDG11I36q2plWC5v6l4q7Cw/aXIx
         L27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=obSVLw47H5B+RG2UiMD7uhQPadg0qRqXklaMc2zd1w4=;
        b=ccTT5PmvWQGxQWSYsWc6OYdpUZgTDv7mmfU8NmtmnHd9YAITh7FoFs/L75pEo85rO4
         TuMniprXNx7oljxVUe8hfZNzaKap7+UaI2tUFXNdhKPXvzCQb9oHzhrNAJCw4xIyoyPK
         54KyT3ZbnVFL8+rSon9Ex7y735Kty0xQTfYbVykIEWXM1659qbhTrwGJovyHckPVn5aO
         63petNOtNGSfJbp/wYWDZ56CdUpkr+f6JKYfnCcBv/ojSjukWckliid7+i8RInmBOtZf
         Cyi2a8KW09wOdAulG5pEUcPb8bIycpjnyuL5BSqiATf6gLphcK58CzpbapxPxMOm+iIK
         Nmpw==
X-Gm-Message-State: AGRZ1gKdDPKV7nnBDq66RnjJMpuqedHhQOwC7QRVjKMHC5VkW/wVZU1X
        qbE58M1Kq3UDL0tpGWk59T4=
X-Google-Smtp-Source: AJdET5fjeI6ME0atJUaa3fi4YfB7dnuvE97yS4PIceyI0OO5Cj82WTWAcWwEjtT+O4mMW8gvi6khYw==
X-Received: by 2002:a1c:4489:: with SMTP id r131-v6mr67464wma.121.1541133677148;
        Thu, 01 Nov 2018 21:41:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k66-v6sm14759433wmd.47.2018.11.01.21.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 21:41:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Slavica Djukic <slavicadj.ip2018@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: Re: [PATCH 2/3] [Outreachy] ident: introduce set_fallback_ident() function
References: <20181101115546.13516-1-slawica92@hotmail.com>
        <20181101120029.13992-1-slawica92@hotmail.com>
        <xmqqwopwqj2g.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 02 Nov 2018 13:41:13 +0900
In-Reply-To: <xmqqwopwqj2g.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 02 Nov 2018 12:01:11 +0900")
Message-ID: <xmqqh8h0qefq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Rather than adding this fallback trap, can't we do it more like
> this?
>
>     - At the beginning of "git stash", after parsing the command
>       line, we know what subcommand of "git stash" we are going to
>       run.
>
>     - If it is a subcommand that could need the ident (i.e. the ones
>       that create a stash entry), we check the ident (e.g. make a
>       call to git_author/committer_info() ourselves) but without
>       STRICT bit, so that we can probe without dying if we need to
>       supply a fallback identy.
>
>       - And if we do need it, then setenv() the necessary
>         environment variables and arrange the next call by anybody
>         to git_author/committer_info() will get the fallback values
>         from there.

As we currently have no idea when builtin/stash.c becomes ready for
'next', how about doing something like this instead, in order to
help end-users without waiting in the meantime?  The fix can be
picked up and ported when the C rewrite is updated, of course.

 git-stash.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index 94793c1a91..789ce2f41d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -55,6 +55,20 @@ untracked_files () {
 	git ls-files -o $z $excl_opt -- "$@"
 }
 
+prepare_fallback_ident () {
+	if ! git -c user.useconfigonly=yes var GIT_COMMITTER_IDENT >/dev/null 2>&1
+	then
+		GIT_AUTHOR_NAME="git stash"
+		GIT_AUTHOR_EMAIL=git@stash
+		GIT_COMMITTER_NAME="git stash"
+		GIT_COMMITTER_EMAIL=git@stash
+		export GIT_AUTHOR_NAME
+		export GIT_AUTHOR_EMAIL
+		export GIT_COMMITTER_NAME
+		export GIT_COMMITTER_EMAIL
+	fi
+}
+
 clear_stash () {
 	if test $# != 0
 	then
@@ -67,6 +81,9 @@ clear_stash () {
 }
 
 create_stash () {
+
+	prepare_fallback_ident
+
 	stash_msg=
 	untracked=
 	while test $# != 0
