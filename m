Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC2D1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 15:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfASPqZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 10:46:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36136 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbfASPqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 10:46:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so14109828ljk.3
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HY/wpF6cFWgXVYNcWFolMlXf9dj+IkGzYXD1/V15FvU=;
        b=Bo1Gi3ZxVtSTCBXQh9XPQzuyRCKkx3KM/99eo7V3nu+Aa5jN8hdEaZ06vxZKWxOabO
         kysfMC2Tg8bUxaySnI7pnqBiucrln9XXCGbIzHgRzL9LrKCUYzGXpim8qNBc5sNa0BqN
         Z/VGJPnn7YoaeTsHhsGC83AdiGkk7jkjxOqjFUZx+7xhqWNbncfoM5yX/FntXIqSUDm/
         FXEg+d6d4m9cpQ8H65p1MifjiAubhRlmtYHy6DeqGGlrLsFSW5zlEZvvL1jOouQiOA0l
         dT04Dg3uWrKz0XiPcHOKv3tcEGt9mJTw9Kgcn9wT8BuoPCyA8qPJ/hIuxZe68UxrJBd6
         FtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HY/wpF6cFWgXVYNcWFolMlXf9dj+IkGzYXD1/V15FvU=;
        b=tgRp2Nn+6KhKKFfeH3huA1b5Qo6wqe5jSicYwqoMUtSC9EkHNeEsrjkDj0eqCsZ+9J
         R1xU2O2nZBDt4gMQfGDlgVYu620zqBTX2nfABAKo8kO0gMFVOYShk5KFCbFnM8kI33uP
         Jtc2lP6rq2dchePUThxuWHy1pMk/cUiS5vq5LsfBAxwEyhw2YK81+SpjqM2i2P3Cxs4H
         xfjwPqR0/SN+aGn1KThJ+D0x9954ABPvyZDwWNAjTalFYNxmHFAdK8G2AnhQ4xRSSa2o
         5xljTx39OEmhH6SII2fyfoOTdwQALoh+9bU8t4eJBUfaKE/52/84/aOvjHWl2YHyMOP0
         22vg==
X-Gm-Message-State: AJcUukdlRfYhgCerZONOVXDQO1lLLEbvxcMhxpO4Oz9CJoI3vs5vhGrn
        to0JAFaY59w339KTMMXLeki770Dw
X-Google-Smtp-Source: ALg8bN7mZjzoJ8fuFu/vCycLQ7iuROg0xFLD3Dadu/llT48wDsfYP9BxDfPU2rkRDxX/DoYQBFvukg==
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr15651275ljh.174.1547912782105;
        Sat, 19 Jan 2019 07:46:22 -0800 (PST)
Received: from localhost.localdomain (78-66-223-92-no2204.tbcn.telia.com. [78.66.223.92])
        by smtp.gmail.com with ESMTPSA id x204sm1331444lfa.5.2019.01.19.07.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 07:46:21 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] commit-tree: add missing --gpg-sign flag
Date:   Sat, 19 Jan 2019 16:45:51 +0100
Message-Id: <20190119154552.12189-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1.98.gecbdaf0899
In-Reply-To: <20190119033530.4241-1-brandon1024.br@gmail.com>
References: <20190119033530.4241-1-brandon1024.br@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

Thanks for a v3.

On Sat, 19 Jan 2019 at 04:36, Brandon Richardson <brandon1024.br@gmail.com> wrote:
> -		if (skip_prefix(arg, "-S", &sign_commit))
> +		if(!strcmp(arg, "--gpg-sign")) {

(Same nit as Junio about the missing space after "if".)

> +			sign_commit = "";

Nice. ;-)

> +			continue;
> +		}

>	# commit.gpgsign is still on but this must not be signed
>	git tag ninth-unsigned $(echo 9 | git commit-tree HEAD^{tree}) &&
>	# explicit -S of course must sign.
> -	git tag tenth-signed $(echo 9 | git commit-tree -S HEAD^{tree})
> +	git tag tenth-signed $(echo 10 | git commit-tree -S HEAD^{tree}) &&
> +
> +	# --gpg-sign[=<key-id>] must sign.
> +	echo 11 >file && test_tick && git commit -S -a -m "eleventh signed" &&
> +	git tag eleventh-signed &&
> +	git commit-tree --gpg-sign -m "twelfth signed" HEAD^{tree} &&
> +	git tag twelfth-signed &&
> +    git commit-tree --gpg-sign=B7227189 -m "thirteenth signed" HEAD^{tree} &&
> +    git tag thirteenth-signed
>  '

(These last two lines are not tab-indented, but indented by four spaces.
They were perhaps mangled by some copy-pasting.)

Running this test, we end up with three tags on one commit:
eleventh-signed, twelfth-signed and thirteenth-signed. So as long as
`git commit -S` works when we use the number 11, everything will pass,
and we won't really test what we wanted to test. We will verify that
`git commit-tree` doesn't choke on "--gpg-sign[=foo]", but we won't
verify that it handles it correctly.

(Just recently, it was pointed out on this list that `git log --count`
won't complain about "--count", but won't act on it, either. So such
errors are not unheard of.)

I looked into this test in a bit more detail, and it seems to be quite
hard to get right. Part of the reason is that `git commit-tree` requires
a bit more careful use than `git commit`, but part of it is that the
tests that we already have for `git commit-tree [-S]` right before the
ones you're adding are a bit too loose, IMHO. So they're not ideal for
copy-pasting... I've come up with the patch below, which you might want
to use as a basis for your work.

That is, you could `git am --scissors` this patch on a fresh branch and
`git commit --amend --signoff --no-edit` it (see
Documentation/SubmittingPatches, "forwarding somebody else's patch"),
then base your work on it, e.g., by cherry-picking your v3 commit.

I think you would want to add 2x3 lines of tests (3 for `--gpg-sign`, 3
for `--gpg-sign=...`). That would give you eleventh-signed and
twelfth-signed and you wouldn't need any invocation of `git commit` (so
no thirteenth-signed).

If you're not up for that, just let me know and I could instead rebase
your patch on top of mine and submit both as a v4. I think this has come
along nicely, and now it's really just about having a robust test.

Martin

-- >8 --
Subject: [PATCH] t7510: invoke git as part of &&-chain

If `git commit-tree HEAD^{tree}` fails on us and produces no output on
stdout, we will substitute that empty string and execute `git tag
ninth-unsigned`, i.e., we will tag HEAD rather than a newly created
object. But we are lucky: we have a signature on HEAD, so we should
eventually fail the next test, where we verify that "ninth-unsigned" is
indeed unsigned.

We have a similar problem a few lines later. If `git commit-tree -S`
fails with no output, we will happily tag HEAD as "tenth-signed". Here,
we are not so lucky. The tag ends up on the same commit as
"eighth-signed-alt", and that's a signed commit, so t7510-signed-commit
will pass, despite `git commit-tree -S` failing.

Make these `git commit-tree` invocations a direct part of the &&-chain,
so that we can rely less on luck and set a better example for future
tests modeled after this one. Fix a 9/10 copy/paste error while at it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t7510-signed-commit.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 86d3f93fa2..58f528b98f 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -49,9 +49,13 @@ test_expect_success GPG 'create signed commits' '
 	git tag eighth-signed-alt &&
 
 	# commit.gpgsign is still on but this must not be signed
-	git tag ninth-unsigned $(echo 9 | git commit-tree HEAD^{tree}) &&
+	echo 9 | git commit-tree HEAD^{tree} >oid &&
+	test_line_count = 1 oid &&
+	git tag ninth-unsigned $(cat oid) &&
 	# explicit -S of course must sign.
-	git tag tenth-signed $(echo 9 | git commit-tree -S HEAD^{tree})
+	echo 10 | git commit-tree -S HEAD^{tree} >oid &&
+	test_line_count = 1 oid &&
+	git tag tenth-signed $(cat oid)
 '
 
 test_expect_success GPG 'verify and show signatures' '
-- 
2.20.1.98.gecbdaf0899

