Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD671F404
	for <e@80x24.org>; Wed, 29 Aug 2018 22:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeH3CL0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 22:11:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34778 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeH3CL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 22:11:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id m199-v6so340927wma.1
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 15:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wFe6eMxOfQ8dOZ9jHQRNMtV5uwsMhYh0Ecxg91HWxPw=;
        b=of1BIYec7YoCtGuMys0V8g0suHXQzbBxdoVZjMCHZalrp5F7Q5mbRJEzptX6Yj7Y+l
         ilu84GZP13lTQij3GzxHG18EVGFcZVCqpIdU2O1iPnRvBdTLjZ96KVUxDnbYaKQuYSkx
         TZ+w1fGqrA0IXwCu3Go0sOPa6GZCuWLZMq/aeH+uFp7k48YnRCDuaKNh2tCO+IhuukWc
         CmH6EYwASDmkf4R2FrNIeel9PVz4zQ5TrGEW4GkE3k1VS4QmvRcc5CiQYPmnsObwumc3
         5u44O74c8V8A4stdLOLna5ZXGlwe58QNbJCCmkS+sfRi7Gf6OKB061b+GeSfkB8pw+Sk
         K6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wFe6eMxOfQ8dOZ9jHQRNMtV5uwsMhYh0Ecxg91HWxPw=;
        b=DxjKB9woXdXWzG968KSAtZuIkHRI4JOPyL9Gwm/wuTWkIWh5cgY51s7yJReByvL1Bc
         /9ZjVvdGuYLyjpgNxEeWecPAkrzrpeRrRfByJ8XQT5dshFSzVWddH6vcvOR6iWzAxhZ/
         11jWoNxh7gSmqyZ47p+dWGhZlquckhPnWPrNOg7dM22DO1dxl+Yi9wPODk8QdwDB+3Iq
         KB0PkLYdRuQqi0PaqfP1McP/FqFp29y4yHeJe5v1M8AitgQYEA4GENRGkYHwgnSQ9N11
         5TYIBwX56vcTNHhxe9L/DT2ov7z3ZVlNkg7uHv+I2B9jKNqSYIVj2r7DAm5zbHd1cZa1
         IeSA==
X-Gm-Message-State: APzg51DwAyVkikpu9KzHGkL09EqBagz0zeJmlEywefRCxo3L/839u9Rc
        T6/gD7JFkNcbbL5Ri0SdxZw=
X-Google-Smtp-Source: ANB0VdYTbAkpqlI7RvOf9y0/4SOLLquH73mBl08Y5cYi9frEIkIToiK+lPOMcVUKqabK/Q32wFNEYg==
X-Received: by 2002:a1c:398b:: with SMTP id g133-v6mr5044110wma.5.1535580748697;
        Wed, 29 Aug 2018 15:12:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a37-v6sm11825991wrc.21.2018.08.29.15.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 15:12:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, corrmage@gmail.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com
Subject: Re: [PATCH 1/3] t3401: add another directory rename testcase for rebase and am
References: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com>
        <20180829070613.11793-1-newren@gmail.com>
        <20180829070613.11793-2-newren@gmail.com>
Date:   Wed, 29 Aug 2018 15:12:27 -0700
In-Reply-To: <20180829070613.11793-2-newren@gmail.com> (Elijah Newren's
        message of "Wed, 29 Aug 2018 00:06:11 -0700")
Message-ID: <xmqqo9dkakl0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +test_expect_success 'rebase --interactive: NO directory rename' '
> +	test_when_finished "git -C no-dir-rename rebase --abort" &&
> +	(
> +		cd no-dir-rename &&
> +
> +		git checkout B^0 &&
> +
> +		set_fake_editor &&
> +		FAKE_LINES="1" test_must_fail git rebase --interactive A &&

Is this a single-shot environment assignment?  That would have been
caught with the test linter.

Perhaps squshing this in would be sufficient fix?

 t/t3401-rebase-and-am-rename.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
index 94bdfbd69c..13e09afec0 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -141,7 +141,7 @@ test_expect_success 'rebase --interactive: NO directory rename' '
 		git checkout B^0 &&
 
 		set_fake_editor &&
-		FAKE_LINES="1" test_must_fail git rebase --interactive A &&
+		test_must_fail env FAKE_LINES="1" git rebase --interactive A &&
 
 		git ls-files -s >out &&
 		test_line_count = 6 out &&
@@ -160,7 +160,7 @@ test_expect_success 'rebase (am): NO directory rename' '
 		git checkout B^0 &&
 
 		set_fake_editor &&
-		FAKE_LINES="1" test_must_fail git rebase A &&
+		test_must_fail env FAKE_LINES="1" git rebase A &&
 
 		git ls-files -s >out &&
 		test_line_count = 6 out &&
@@ -179,7 +179,7 @@ test_expect_success 'rebase --merge: NO directory rename' '
 		git checkout B^0 &&
 
 		set_fake_editor &&
-		FAKE_LINES="1" test_must_fail git rebase --merge A &&
+		test_must_fail env FAKE_LINES="1" git rebase --merge A &&
 
 		git ls-files -s >out &&
 		test_line_count = 6 out &&
