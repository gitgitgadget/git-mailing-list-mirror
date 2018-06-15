Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3BE91F403
	for <e@80x24.org>; Sat, 16 Jun 2018 19:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933051AbeFPT0W (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 15:26:22 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40716 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPT0U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 15:26:20 -0400
Received: by mail-pg0-f67.google.com with SMTP id w8-v6so2780843pgp.7
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 12:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :to:cc:subject:message-id:date;
        bh=1MeedmkfRXwnagT2xT4hfXYA/X36Eh5zxPTpNiTzWbw=;
        b=L82+MhFvJHgxEFfDTSxEuqKo10IBhu1wpha4g1jlwYsFqZ7+tAybbCFpw86LhlhdBV
         sryKmeLlSGks4177kFLiThtgG1Ffc2+ovlLUD6DDq8920cmnzSjE9oUQg+M0yskTkXFI
         ZR4HLnVMriauHbnQa4GgJWiNT50lWskc3lC4R6f1vU0jqw0qXX/zKw/k9lboEQ4hVber
         AUFNsp8lzII7xgBrevwWGj0MseqAicaFB5MdEjO9jVX8xNj9A/5QUMUR3uUvBV64KTa3
         xYsrUIQXVrhxJdH107XQYrpayn+xWx7MDYTB2kK8BbiUqDxfI1Z5hpK/w39DXfFnutUY
         Yx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:in-reply-to:references:content-transfer-encoding
         :mime-version:from:to:cc:subject:message-id:date;
        bh=1MeedmkfRXwnagT2xT4hfXYA/X36Eh5zxPTpNiTzWbw=;
        b=THgfYMoc2llTB4LvXfhZC1Gxyf5S+m9Bjin197tJHfgM3it18H/R3kwtnxYGi2m1Lm
         9kYFZ1v4aQb8qWeJAaPZ8CR98Y5wGPbvBrkHCxaj6NW1mkeAMjWTa36qFi8vO0hfLD6O
         fU4psm1cShxxNZizDauXmufgC2r5+/8lHBuKgi58gLLLWBE5bI7hUkUzd4lauxq8QPli
         8ijARgltO5e1raT16ZUtIBFAeYkax9iovvmfO0O7qy0oO0I5EDGOt5foWcFt7jfEhETZ
         h9Eo1fP9jV9iIn6V3sjeTm9LTxfKEar9tvpLnTBlulu0nxNP1SkGgWr47L6Gwe41+oJk
         gMRQ==
X-Gm-Message-State: APt69E1ycMuq1BuJR/W1sKu+bGNggIBADhFiNQOMk4HAg0+e2/0D0O/t
        hySPmdvVo4rELAPmf67O7roVu/03
X-Google-Smtp-Source: ADUXVKLiSaP1IevcolvEECKsPyAT9qPithcGsC6kM7XmTFW3wgGcGoHhaAggj19qYruZNIM5pNd/qg==
X-Received: by 2002:a63:6e08:: with SMTP id j8-v6mr5993996pgc.428.1529177179998;
        Sat, 16 Jun 2018 12:26:19 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id t13-v6sm12929005pgv.43.2018.06.16.12.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 12:26:19 -0700 (PDT)
Content-Type: text/plain
In-Reply-To: <pull.3.git.gitgitgadget@gmail.com>
References: <pull.3.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>
Subject: [PATCH 1/2] rebase --root: demonstrate a bug while amending root
 commit messages
Message-ID: <d59805a43ddaf4bbd4528a2b7afa9809eca9b86b.1529177176.git.gitgitgadget@gmail.com>
Date:   Fri, 15 Jun 2018 00:31:11 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Todd Zullinger <tmz@pobox.com>

When splitting a repository, running =
`git rebase -i --root` to reword
the initial commit, Git dies with

	BUG: sequencer.c:795: root commit without message.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Johannes =
Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh =
| 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git =
a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c65826dda..ca94c688d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -971,6 +971,15 @@ =
test_expect_success 'rebase -i --root fixup root commit' '
 	test 0 =3D $(git cat-file commit HEAD | grep -c ^parent\ )
 '
=20
+test_expect_failure 'rebase -i --root reword root commit' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout -b reword-root-branch master &&
+	set_fake_editor &&
+	FAKE_LINES=3D"reword 1 2" FAKE_COMMIT_MESSAGE=3D"A changed" \
+	git rebase -i --root &&
+	git show HEAD^ | grep "A changed"
+'
+
 test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on =
non-interactive rebase' '
 	git reset --hard &&
 	git checkout =
conflict-branch &&
--=20
2.17.0.windows.1

