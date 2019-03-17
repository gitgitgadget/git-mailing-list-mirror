Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9580420248
	for <e@80x24.org>; Sun, 17 Mar 2019 10:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfCQKP6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 06:15:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32901 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfCQKP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 06:15:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id i7so6170714pgq.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 03:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6tLa8EVqiBAi/50IMuEGPwdytGLpbHW67KzH7vRf1Ms=;
        b=ABQ/JyDcaKLDaVVoIyOUoyRLhPhDvoTRmEafKZnqG1foNu1IZDN/LsETKSRFU5tMn+
         f6xhLI3KYKUDhyMVeegsh/HfEkf/QlC2Io4DHCgRZ2XxQ6wvOVei3GbN97sRZ60GEJ3R
         0igaaDCWMhoFlAtWO5YzRqoc12EqMCuwfeMX/yV2RuaWlQBQ5vokz7NlrwRgYnNSdFJ2
         F0doDWnECgPZNZMOEqgJjJ4+qD1ZI9rPJTH2xOp5N3eh8P+gDavmb+5VqbZWceiScYvB
         7NK+LBnuX8hvet1Z8fkYaDM3LfMXnvFwR9VUDtGK2DKjhwMK5R27DFf+t67ddCJYN6Hp
         80hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6tLa8EVqiBAi/50IMuEGPwdytGLpbHW67KzH7vRf1Ms=;
        b=Z5CrSgV2y9ictBGI+/9yYatJ3Y33QCKAxS1LKyt0FPlYv363GNhx+Qe/aZ/QUz7NjV
         Bw8uOrbQLPaGSfrMxoqszwLg48KiJMdn8jC9iQKQf1sAR4NVttWXmF5qfA829vKO9WRX
         nuon2MOBlKtTDHiAyW9VeF6XJTrwb9q5NnwstAcg5N91/8b1eW3SAShWjQT+Usbh10J8
         lHZoU8zwu0KiZyCI8Uu0psd8qGQ4n65R4RjWMG2HQZJahoLKtPLN9eEtkJrHIFOL55Z+
         Aguq634Y2Nr4/z2LPHgurNGVuMBUKLmxTaCiAEEh1sI0KdSp0K9IW/aAfVTU9FYDYjZH
         WQiA==
X-Gm-Message-State: APjAAAXBKYz+vyvhwcn2CLLyI8ApbL+bFpldicWXSWfRVv9OjYA5lOIz
        dYj3WCLKrmqsFS+nq/Z+i46HjuON
X-Google-Smtp-Source: APXvYqwtcHk1gpeJ0taJKZiFOSAorO3MIyGluhJoyVzzfUzC2PQ7wufegTwkZFwthw5N0x3PoBpXxg==
X-Received: by 2002:aa7:8157:: with SMTP id d23mr13486218pfn.67.1552817756139;
        Sun, 17 Mar 2019 03:15:56 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id f65sm11881909pff.21.2019.03.17.03.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 03:15:55 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:15:53 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v8 01/11] t7600: clean up style
Message-ID: <08426189b5a29b376581eb0172e52222ab22387a.1552817044.git.liu.denton@gmail.com>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1552817044.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This cleans up the 'merge --squash c3 with c7' test by removing some
unnecessary braces and removing a pipe. Finally, unindent a here-doc for
style.

Also, remove stray spaces after "> " for style.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7600-merge.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 106148254d..a9620cd991 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -233,17 +233,17 @@ test_expect_success 'merge --squash c3 with c7' '
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
+	git cat-file commit HEAD >actual &&
+	sed -e '1,/^$/d' <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 '
 
@@ -683,7 +683,7 @@ cat >editor <<\EOF
 	cat <"$1"
 ) >"$1.tmp" && mv "$1.tmp" "$1"
 # strip comments and blank lines from end of message
-sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' > expected
+sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' >expected
 EOF
 chmod 755 editor
 
@@ -814,7 +814,7 @@ EOF
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

