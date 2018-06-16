Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0609F1F403
	for <e@80x24.org>; Sat, 16 Jun 2018 19:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933078AbeFPT0Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 15:26:24 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46447 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933027AbeFPT0W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 15:26:22 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so6344124pff.13
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :to:cc:subject:message-id:date;
        bh=8OsARHN2Xwd++3GNpI9Q4ATDq5TkkdyooA1ScTxhzgA=;
        b=E/EtJp58TeD/HpJIy6L8eJN1vBhf7xExP084gOEMmvDzbuGj9Tnk/j2hUZVARVLLas
         QuunTin4UCwEBsRe9RFnfOMApRNNIEZrGp+m5FGZS1BzKq4eb/532cLFCuvGZP1op/Nu
         jGZytgmT1UNl4ySK8f9fgd50D86HTWvqN86YJnEfb2DE28uUxh4MLv91IFleeP5U5pT8
         iu7BMZQ2017XthbNbvnhyJabEc1QEGaJaxbg7luYG1CNqphcfr2DMaFFPdRg4SSto3jX
         EKvXOBiR2Tize7tIpMZl+5LT8XsqBiJws8OvRu67xpD3u9E2qABokoEKXZL1SmPuZNOs
         6v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:in-reply-to:references:content-transfer-encoding
         :mime-version:from:to:cc:subject:message-id:date;
        bh=8OsARHN2Xwd++3GNpI9Q4ATDq5TkkdyooA1ScTxhzgA=;
        b=aNFbBrlOpNLGOiWL3ZmIwr+sz+vI/j/V+S5LAmQp/6aLi8IbqFXHX+DkU7BiUVIypn
         5dckOseT8i39IDuzD+XdTWkKVXSPppUHj8765QHJe217QZDezi4+fE9pl2H/T4r/tCw/
         9Hl4x5ar4NyT8lvtvKXoY8H0hcQnOBr6ZWtT8zu1oEAYw2kG28v9aPNhIC1egfXOzKbX
         YfGjZ+MSeu12W2FO/U3lJ/XYFmSt8T1lNjOgE+EOu6C7Ic/qHDPULn7n2rJK/ZARZZTs
         D4WJ9moWBLXgi1IZA6tCC7EjwaaJ4EKYCTG7RvoRSLADD84ySHMAdnfwaBKGUdngNGU9
         3FRA==
X-Gm-Message-State: APt69E1T/uPGBwM5SN3cpO5DgvRTQaUKuzSvST6OTinEJ8RKhXXIsAmu
        XmSONsIOrPpooc9tWksAht/XvrVg
X-Google-Smtp-Source: ADUXVKKOWnDqrGbu5kFcRh3lDZREeUQgIEDxEq9EmY9pbO5TN94XSiNOV99KiU9i5DOK/XHnwV8IQw==
X-Received: by 2002:a63:4d14:: with SMTP id a20-v6mr6083482pgb.46.1529177181378;
        Sat, 16 Jun 2018 12:26:21 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id l85-v6sm19306429pfk.79.2018.06.16.12.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 12:26:20 -0700 (PDT)
Content-Type: text/plain
In-Reply-To: <pull.3.git.gitgitgadget@gmail.com>
References: <pull.3.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] rebase --root: fix amending root commit messages
Message-ID: <6f492ded5c4b9ee82501433d5a5227bc3e546c31.1529177176.git.gitgitgadget@gmail.com>
Date:   Sat, 16 Jun 2018 21:00:38 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The code path that triggered that "BUG" really does not want to run
without an explicit commit message. In the case where we want to amend a
commit message, we have an *implicit* commit message, though: the one of
the commit to amend. Therefore, this code path should not even be
entered.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                   | 2 +-
 t/t3404-rebase-interactive.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c=
 b/sequencer.c
index cca968043..4034c0461 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -784,7 +784,7 @@ static int run_git_commit(const char =
*defmsg, struct replay_opts *opts,
 	struct child_process cmd =3D =
CHILD_PROCESS_INIT;
 	const char *value;
=20
-	if (flags & =
CREATE_ROOT_COMMIT) {
+	if ((flags & CREATE_ROOT_COMMIT) && !(flags & =
AMEND_MSG)) {
 		struct strbuf msg =3D STRBUF_INIT, script =3D STRBUF_INIT;
 		const char *author =3D is_rebase_i(opts) ?
 			read_author_ident(&script=
) : NULL;
diff --git a/t/t3404-rebase-interactive.sh =
b/t/t3404-rebase-interactive.sh
index ca94c688d..e500d7c32 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -971,7 +971,7 @@ test_expect_success 'rebase -i --root fixup root =
commit' '
 	test 0 =3D $(git cat-file commit HEAD | grep -c ^parent\ )
 '
=20
-test_expect_failure 'rebase -i --root reword root commit' '
+test_expect_success 'rebase -i --root reword root commit' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout -b reword-root-branch master &&
 	set_fake_editor &&
--=20
2.17.0.windows.1
