Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B10520248
	for <e@80x24.org>; Thu, 21 Mar 2019 06:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfCUGxl (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 02:53:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43274 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUGxl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 02:53:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so3679340pfd.10
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oVZzTl2JlCGgMg7xahXxobM3HiiIN2E2+2vkHvDEUqQ=;
        b=WUM6I3t4HQVjihTkWO54IYZlEvXPH6WwOJEYblxOLSlAKENmiH+ck+k0YrCxFXFDSu
         qQfaaRXJweRwAYgfiTFJUnfFoDdQfgawciIz6BYPJhPJHSCsY84Eu0VZmL3mOKvNsBcC
         zI0AfZ8V9wwz33Vb4LAHVRXhtN3EBoGZjmFbzE9VJnTLTkm5Bj3xBqk5sKxsxzj4L4fv
         nXtKF38eIE7aRiIBTmiLELD1lBNNUJnIUDVTKWCbtrTqAE3pohwbh2dmfBI3MXMrbFWY
         CWWkYxmlOO+z5H6G25vpL5v+Vn7KGI5F4USQnScNOMS62Gfc3CD8nJTbQADiebFGda/j
         KX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oVZzTl2JlCGgMg7xahXxobM3HiiIN2E2+2vkHvDEUqQ=;
        b=J4zM52+SoFiHQJwqWQ/w4sNXoYo6qB+P6PTEoTQEXGD1k4x2L5uUXxoF3BG3KTLtgg
         zvJLm3FTSwZL04Ti1wGPRV3qCOyrsmyIEJ2JPIvKctnlPITjmQQjqQ+NUyvyLHhUNFU2
         2lETpgc5vWb7FeKCq1VXt8AVXDVyJA1ixB6LnPqkKkLK944UZLIMX/ii5wQWzvIYwxwQ
         ZH3ChXBBOePErwICnsVsD1PhyR/HiE2XVGqmxJvggsqZIUhcj0F+d9bCwJIz4IWve371
         tH9BAAYie4pIGY0prDx1hqWl3uyL4BlvW9bUol+GafjfG1f3vlpELWgNffgvcw8qxPq4
         PYRA==
X-Gm-Message-State: APjAAAWpG9AiwOQyBVSzS6U9dP63QYbjZisqEhAylt6xIZbUdDtQXqyB
        5ff+Ic52fJexHyO+msMbsOb0lofw8g4=
X-Google-Smtp-Source: APXvYqyrptLYNSDW4qwxQPHLMi1sI1dsivEA0FLIlgeo71M7S08eQYRnQ/ZQUTcEnNZ5GS3oo9CWkQ==
X-Received: by 2002:a17:902:2848:: with SMTP id e66mr2005512plb.181.1553151220308;
        Wed, 20 Mar 2019 23:53:40 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id i64sm5457323pfb.112.2019.03.20.23.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 23:53:39 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:53:37 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v9 01/11] t7600: clean up style
Message-ID: <3274886c16141fe1b5c228e02d75f623f79a0539.1553150827.git.liu.denton@gmail.com>
References: <cover.1552817044.git.liu.denton@gmail.com>
 <cover.1553150827.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1553150827.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clean up the 'merge --squash c3 with c7' test by removing some
unnecessary braces and removing a pipe.

Also, generally cleanup style by unindenting a here-doc, removing stray
spaces after a redirection operator and allowing sed to open its own
input instead of redirecting input from the shell.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7600-merge.sh | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 106148254d..2f4c2801fb 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -233,17 +233,16 @@ test_expect_success 'merge --squash c3 with c7' '
 	cat result.9z >file &&
 	git commit --no-edit -a &&
 
-	{
-		cat <<-EOF
-		Squashed commit of the following:
+	cat >expect <<-EOF &&
+	Squashed commit of the following:
 
-		$(git show -s c7)
+	$(git show -s c7)
 
-		# Conflicts:
-		#	file
-		EOF
-	} >expect &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	# Conflicts:
+	#	file
+	EOF
+	git cat-file commit HEAD >raw &&
+	sed -e '1,/^$/d' raw >actual &&
 	test_cmp expect actual
 '
 
@@ -680,10 +679,10 @@ cat >editor <<\EOF
 (
 	echo "Merge work done on the side branch c1"
 	echo
-	cat <"$1"
+	cat "$1"
 ) >"$1.tmp" && mv "$1.tmp" "$1"
 # strip comments and blank lines from end of message
-sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' > expected
+sed -e '/^#/d' "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' >expected
 EOF
 chmod 755 editor
 
@@ -768,14 +767,14 @@ test_expect_success 'set up mod-256 conflict scenario' '
 	git commit -m base &&
 
 	# one side changes the first line of each to "master"
-	sed s/-1/-master/ <file >tmp &&
+	sed s/-1/-master/ file >tmp &&
 	mv tmp file &&
 	git commit -am master &&
 
 	# and the other to "side"; merging the two will
 	# yield 256 separate conflicts
 	git checkout -b side HEAD^ &&
-	sed s/-1/-side/ <file >tmp &&
+	sed s/-1/-side/ file >tmp &&
 	mv tmp file &&
 	git commit -am side
 '
@@ -814,7 +813,7 @@ EOF
 test_expect_success EXECKEEPSPID 'killed merge can be completed with --continue' '
 	git reset --hard c0 &&
 	! "$SHELL_PATH" -c '\''
-	  echo kill -TERM $$ >> .git/FAKE_EDITOR
+	  echo kill -TERM $$ >>.git/FAKE_EDITOR
 	  GIT_EDITOR=.git/FAKE_EDITOR
 	  export GIT_EDITOR
 	  exec git merge --no-ff --edit c1'\'' &&
-- 
2.21.0.512.g57bf1b23e1

