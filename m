Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD041F407
	for <e@80x24.org>; Thu, 14 Dec 2017 12:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbdLNMbC (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 07:31:02 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39825 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbdLNMbA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 07:31:00 -0500
Received: by mail-pf0-f194.google.com with SMTP id l24so3507568pfj.6
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 04:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QFLdKCGnLcTJmKEHG3Vc+Z+KefQElfm4yTtjT1nBBxA=;
        b=HOb8LJGTJauPGuKpmTEnj+tsvt3QxkMJpDh2VwELLbXDG20zLhMiO8Trv+PX9EBX5M
         jCNF9GFCuD7LeuIFapQuxzr41BmatKzEtpPpQCeFcUqhj8yXo1NGom+F1JJ1z9jtrHyG
         ruYNUQMIRlNgGZl5iB4H0eJNXIgAE/c2HUq4BzWriir5pCA3LkuHiH5HWJDw5ubAXxT8
         Jl7eojTaSXbXVQ0iLpK6YnkdGtjQrDK19Cujdd/mZYT5pYx1V6vlG5Zcn4W0QuA2YAzS
         GDiX+6vtVHAw3WKdqegR/w8r4SNkoIIFSahTD0oniTlqqmkFIlOfUxwpEKP3ljUvfiuX
         fkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QFLdKCGnLcTJmKEHG3Vc+Z+KefQElfm4yTtjT1nBBxA=;
        b=FAxppHru1V33dP71uW7ILzQhhxwcs6b21uV0qwsFFHRkV4v0DpM28LtrrOLhJ5Yf2R
         e79MYGtNGtY3BuF3xaj9nM4iBJNWfYh6ECv5Z6l192o88gVLkoM9i0vHrPw34U5pQTyR
         nEZE55ubMRIUA36essvJc9fruSuRL9YSPMwVSaqbGl5rHsSMMLHD0nm7soy+w6JdOLwJ
         d7zRVLDD6CgNY9rJMjo2AzfVVDUkRpkKXLpTqRk9qmkfxYM9yY+709s4IUdS8xRv2DNR
         9alQslFBQCHdkgrXj+Lzo8TOfrV6ajHfqFoinX5BTDexYYVvgbDQwu4w2aM7dKGfDXGQ
         eoug==
X-Gm-Message-State: AKGB3mLBVWCUDio5K2MfT83Un/7bvef8gIEsl/P6+FRcU4SS/nFjRbUE
        V5hnuHv/3kBhSeiB8EiOvoo=
X-Google-Smtp-Source: ACJfBouHa9zAu+I7YWB6C5B+4otSJ+4s0Fzra1zZyaLYl1uoTpnyN0xqyNFUzSGjCTxNf8YEOBIkAA==
X-Received: by 10.99.130.74 with SMTP id w71mr8243183pgd.31.1513254660410;
        Thu, 14 Dec 2017 04:31:00 -0800 (PST)
Received: from localhost.localdomain ([106.203.33.3])
        by smtp.gmail.com with ESMTPSA id k9sm6604775pgo.53.2017.12.14.04.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2017 04:30:59 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v4 2/2] Doc/check-ref-format: clarify information about @{-N} syntax
Date:   Thu, 14 Dec 2017 18:00:27 +0530
Message-Id: <20171214123027.9105-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c
In-Reply-To: <xmqq609olg1p.fsf@gitster.mtv.corp.google.com>
References: <xmqq609olg1p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the N-th previous thing checked out syntax (@{-N}) is used
with '--branch' option of check-ref-format the result may not be
the name of a branch that currently exists or ever existed. This
is because @{-N} is used to refer to the N-th last checked out
"thing", which might be a commit object name if the previous check
out was a detached HEAD state; or a branch name, otherwise. The
documentation thus does a wrong thing by promoting it as the
"previous branch syntax".

State that @{-N} is the syntax for specifying "N-th last thing
checked out" and also state that the result of using @{-N} might
also result in an commit object name.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---

Changes in v4:

		- updated the commit message
		- made changes suggested by Junio

 Documentation/git-check-ref-format.txt | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index cf0a0b7df..8172a6b9a 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -78,17 +78,21 @@ reference name expressions (see linkgit:gitrevisions[7]):
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
 With the `--branch` option, the command takes a name and checks if
-it can be used as a valid branch name (e.g. when creating a new
-branch).  The rule `git check-ref-format --branch $name` implements
-may be stricter than what `git check-ref-format refs/heads/$name`
-says (e.g. a dash may appear at the beginning of a ref component,
-but it is explicitly forbidden at the beginning of a branch name).
-When run with `--branch` option in a repository, the input is first
-expanded for the ``previous branch syntax''
-`@{-n}`.  For example, `@{-1}` is a way to refer the last branch you
-were on.  This option should be used by porcelains to accept this
-syntax anywhere a branch name is expected, so they can act as if you
-typed the branch name.
+it can be used as a valid branch name e.g. when creating a new branch
+(but be cautious when using the previous checkout syntax; it may refer
+to a detached HEAD state). The rule `git check-ref-format --branch
+$name` implements may be stricter than what `git check-ref-format
+refs/heads/$name` says (e.g. a dash may appear at the beginning of a
+ref component, but it is explicitly forbidden at the beginning of a
+branch name). When run with `--branch` option in a repository, the
+input is first expanded for the ``previous checkout syntax''
+`@{-n}`.  For example, `@{-1}` is a way to refer the last thing that
+was checked out using "git checkout" operation. This option should be
+used by porcelains to accept this syntax anywhere a branch name is
+expected, so they can act as if you typed the branch name. As an
+exception note that, the ``previous checkout operation'' might result
+in a commit object name when the N-th last thing checked out was not
+a branch.
 
 OPTIONS
 -------
@@ -116,7 +120,7 @@ OPTIONS
 EXAMPLES
 --------
 
-* Print the name of the previous branch:
+* Print the name of the previous thing checked out:
 +
 ------------
 $ git check-ref-format --branch @{-1}
-- 
2.15.0.531.g2ccb3012c

