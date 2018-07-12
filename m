Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDE31F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 20:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbeGLVAd (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 17:00:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36969 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732583AbeGLVAd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 17:00:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so7389817wmh.2
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kacGVkRoZwvCAzlKnreNC+8MrBsjeIbWKLGyyFKFh/w=;
        b=EGzUeD6b7Z1RW7FlnB3M+dnKtcNNxDGUdZcZzM9HjFNnHA7JZj882Pq1Tq4oeFEfqM
         1FMvLioydbdVzOGRr58qSaHsi6ZlsusZYgWy0GQQlKO/X7f+BTfTa5diK06ipsaAa5vw
         MH5IMjxpij2bgmTCvwrI0lYgXpbWf5AQrHbFo6KHlAMPb3I1qxlOs5JGyQPv3bhcEOrG
         YI/fU6nMrNJHC/+/ESjM8G0GMA1t/Wy6HYzWXqhVmBryqfBHZhQATJfgKxSt2t3gDiqY
         Qw5lfXITl7sBUysnHunyqZS21VCTKFYmFKV9E6UVvnPo+D03W8G7qCJ9aqSFcjCBDn3w
         xZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kacGVkRoZwvCAzlKnreNC+8MrBsjeIbWKLGyyFKFh/w=;
        b=oIHZe4aeeHQvLYx0nKYzD0pCRcvOdjbqdaHlBmohQEEys93jfa/e7Lq6W5Yf74843n
         M0oc8TRtgvw3LEOHw7wmkQU6Rwtf2py3+tMHmmKcjMKua+StSvJDdYNRJ4RNFYuAMotO
         FIdtpWOcI9XNBLyVcxEg/7xF+U1U1Fh3UgEaCU2nnk9BWvJY7JuTIMuwfJRcQIYb6HpT
         5hN2mAQDm/+9wlZ2nJMyu2TNbU7pkjulKvhDV6Uueu/AOvmT/rnIx2W3sFCakaK6AzHo
         rupvxtitOkipY4idvD0nItILGEqjtCl3CQ3psgPQ3jcrOYtSPXH56NHiAnLnElWooUQD
         dY7w==
X-Gm-Message-State: AOUpUlGTYHokRyyr/r73g4gQh7ItQmdFYPDfnGelP5HEm/FPYlRcm/UK
        brMAKQpA2r6jwlfk5NwtBkdM3FAx
X-Google-Smtp-Source: AAOMgpfv6Br2rbyZ+ldW076e0bP1UiG/pOZsNBlccDymbV7AZb272Cw3LRoiI35YQueQkfuvcRUT2A==
X-Received: by 2002:a1c:5dd4:: with SMTP id r203-v6mr2269692wmb.29.1531428556334;
        Thu, 12 Jul 2018 13:49:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 185-v6sm9611017wmw.23.2018.07.12.13.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 13:49:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Akinori MUSHA" <knu@iDaemons.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script properly
References: <86a7qwpt9g.knu@iDaemons.org>
        <xmqqa7qww6uk.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 12 Jul 2018 13:49:15 -0700
In-Reply-To: <xmqqa7qww6uk.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 12 Jul 2018 13:13:07 -0700")
Message-ID: <xmqqr2k8uqlw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I _think_ the right and safe way to fix taht is to do something like
> this:
>
> 	test -f .git/rebase-merge/author-script &&
> 	(
> 		safe_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL ... &&
> 		eval "$(cat .git/rebase-merge/author-script)" &&
> 		test ... &&
> 		test ... &&
> 		test ...
> 	)
>
> That way, we won't have to worry about GIT_AUTHOR_* variables
> getting modified and affecting the tests that come later in the
> script.

It turns out that the use of subshell is *essential* for this test,
as GIT_AUTHOR_* variables are exported and must remain so.  unsetting
and reading back may allows us to ensure that shell variables have
the expected value, but then they are no longer exported, which will
mean later tests will use whatever random author ident the person or
the 'bot who is running the tests, not the one expected to be used
by the test author(s).

For tonight's pushout, I'll queue this on top.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 12 Jul 2018 13:23:02 -0700
Subject: [PATCH] SQUASH???

---
 t/t3404-rebase-interactive.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 2d189da2f1..b0cef509ab 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -81,11 +81,13 @@ test_expect_success 'rebase -i writes out .git/rebase-merge/author-script in "ed
 	set_fake_editor &&
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
 	test -f .git/rebase-merge/author-script &&
-	unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
-	eval "$(cat .git/rebase-merge/author-script)" &&
-	test "$(git show --quiet --pretty=format:%an)" = "$GIT_AUTHOR_NAME" &&
-	test "$(git show --quiet --pretty=format:%ae)" = "$GIT_AUTHOR_EMAIL" &&
-	test "$(git show --quiet --date=raw --pretty=format:@%ad)" = "$GIT_AUTHOR_DATE"
+	(
+		sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
+		eval "$(cat .git/rebase-merge/author-script)" &&
+		test "$(git show --quiet --pretty=format:%an)" = "$GIT_AUTHOR_NAME" &&
+		test "$(git show --quiet --pretty=format:%ae)" = "$GIT_AUTHOR_EMAIL" &&
+		test "$(git show --quiet --date=raw --pretty=format:@%ad)" = "$GIT_AUTHOR_DATE"
+	)
 '
 
 test_expect_success 'rebase -i with the exec command' '
-- 
2.18.0-129-ge3331758f1

