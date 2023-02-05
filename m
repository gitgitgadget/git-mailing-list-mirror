Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F47C636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 14:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBEOx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 09:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjBEOxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 09:53:25 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE6644AB
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 06:53:24 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y2so3653289iot.4
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yds/P6BQMPTc2+LJgC6HCmf8d8+mrU01zbVtKkjpqSw=;
        b=ecBkBFmqA+KhRtXsaK/Pn7umBps9BmgoRt0ODimeafUCuz3vAyNX520N3vFW36YX+X
         ukxVftgGkiazZJ5KsdJl1eB0AwVgW23+X00M09NxxdNEWbywhXDannqDxq2gM8p8uwaT
         HzcaHFLxTK9Uey/VnPZ3/lgsji3EMoyI2UoO4R2KemN2LjN2hCQqHeBAcWFc2Wx+U16h
         WieNlTywLgbZNv6Hs7juVVknIF8G5UvYzTkl6F6UpzV0Ou7wHGAoL9N48chEsW8ok63h
         +mtd7C6tNXmgNoSdNRLzoeeZk9hbIOBgIHb9e+9GuBzRoGv0yZZ9NA/06KpBWptt+Ryu
         vrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yds/P6BQMPTc2+LJgC6HCmf8d8+mrU01zbVtKkjpqSw=;
        b=vR1Gwk2Bto31uyKMW/oGn8h/XzKKPN+QvyRJaecrvJtpvkr8rjeZ8jYTWviUbrm9x6
         S3Vo0ac1GTQbw8Q8AfPmiNGe8C9S9JNuu/4HWB3FIO+F2VHuraE5t/kTDTL95e3Q36nA
         PvQf4TaPHj/fZb1rkYkZ9T+1wv6g8jyHGV4ZPa9PpeBnayAOSgI7a3p6hw1Kx9Bx+WAa
         SBki52osb0m75wENgxoPjcmDffFdYuzwtxLj9CuIgjlG0ASr8v/x6d0/oKqdUzbmPT8s
         uE1ffY103UFlDUWx4e2ogj+FKBu0HVMqM7l3xGfXGT+/DdA8ts0GKXzHnM2ayHWgnC7I
         ZnwA==
X-Gm-Message-State: AO0yUKURj5rxnr9wTsxufpm3VKy6kCK9MaxsnoFAfzYcws1yOCuhZ7g2
        4AoASbQZZBvAwGWVr4Xv+A/JxdpEVVF2HQ==
X-Google-Smtp-Source: AK7set83z9oeQyVdcCVyUXpJxy8pZl9O2eg9vOaS+H2RupAhFKmAXio6B+Jf/LgI1nCjruGCMRx/cQ==
X-Received: by 2002:a5d:8456:0:b0:71c:1516:1b09 with SMTP id w22-20020a5d8456000000b0071c15161b09mr10206843ior.0.1675608803249;
        Sun, 05 Feb 2023 06:53:23 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id q18-20020a056e02097200b00310a5b8504asm2518227ilt.36.2023.02.05.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 06:53:22 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, rybak.a.v@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 0/3] modernize style
Date:   Sun,  5 Feb 2023 09:52:42 -0500
Message-Id: <20230205145245.11078-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202171821.10508-1-cheskaqiqi@gmail.com>
References: <20230202171821.10508-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

different between V2:

1.change the commit massage in t4113: Modernize test script and t4113: indent with space.

2. Put the executable lines inside the test_expect_success.Mention the new style problem cause 
by this change,which is change the "<<" to "<<-" to strip leading TABs used for indentation.

Shuqi Liang (3):
  t/t4113-apply-ending.sh: Modernize test script
  t4113: put executable lines to test_expect_success
  t4113: indent with space

 t/t4113-apply-ending.sh | 79 ++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

Range-diff against v2:
1:  d7d52f1f79 ! 1:  3d40bcce13 t/t4113-apply-ending.sh: Modernize a test script
    @@ Metadata
     Author: Shuqi Liang <cheskaqiqi@gmail.com>
     
      ## Commit message ##
    -    t/t4113-apply-ending.sh: Modernize a test script
    +    t/t4113-apply-ending.sh: Modernize test script
     
    +    Test scripts in file in this script are written in old style,
    +    where the test_expect_success command and test title are written on
    +    separate lines. Change the old style to modern style.
    +
    +    for example :
    +    -test_expect_success setup \
    +    -    'git update-index --add file'
    +    -
    +    +test_expect_success setup '
    +    +    git update-index --add file
    +    +'
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
      ## t/t4113-apply-ending.sh ##
2:  d9e5a54e32 ! 2:  5c55b208a8 Test scripts in file t4113-apply-ending.sh, files "test-patch" and "file" are created twice.
    @@ Metadata
     Author: Shuqi Liang <cheskaqiqi@gmail.com>
     
      ## Commit message ##
    -    Test scripts in file t4113-apply-ending.sh, files
    -    "test-patch" and "file" are created twice.
    +    t4113: put executable lines to test_expect_success
     
    -    Make the second creation of the files its own step
    -    'setup for apply at the beginning'.
    +    This script is written in old style,where there are
    +    some executable lines outside test_expect_success. Put the executable
    +    lines inside the test_expect_success.
    +
    +    As t/README says,use "<<-" instead of "<<"
    +    to strip leading TABs used for indentation. change the "<<" to "<<-"
    +
    +    for example:
    +    -cat >test-patch <<\EOF
    +    -diff a/file b/file
    +
    +     test_expect_success 'apply at the beginning' '
    +    +       cat >test-patch <<-\EOF
    +    +       diff a/file b/file
    +    +       --- a/file
     
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
    @@ t/t4113-apply-ending.sh: test_description='git apply trying to add an ending lin
      
     -# setup
     -
    - cat >test-patch <<\EOF
    - diff --git a/file b/file
    - --- a/file
    -@@ t/t4113-apply-ending.sh: echo 'c' >>file
    +-cat >test-patch <<\EOF
    +-diff --git a/file b/file
    +---- a/file
    +-+++ b/file
    +-@@ -1,2 +1,3 @@
    +- a
    +- b
    +-+c
    +-EOF
    +-
    +-echo 'a' >file
    +-echo 'b' >>file
    +-echo 'c' >>file
    +-
      test_expect_success setup '
    ++	cat >test-patch <<-\EOF
    ++	diff --git a/file b/file
    ++	--- a/file
    ++	+++ b/file
    ++	@@ -1,2 +1,3 @@
    ++	a
    ++	b
    ++	+c
    ++	EOF
    ++
    ++	echo 'a' >file
    ++	echo 'b' >>file
    ++	echo 'c' >>file
          git update-index --add file
      '
     -# test
    @@ -1,2 +1,3 @@
     -b
     -c'
     -git update-index file
    -+test_expect_success 'setup for apply at the beginning' '
    -+	cat >test-patch <<\EOF
    +-
    + test_expect_success 'apply at the beginning' '
    ++	cat >test-patch <<-\EOF
     +	diff a/file b/file
     +	--- a/file
     +	+++ b/file
    @@ -1,2 +1,3 @@
     +	b
     +	c'
     +	git update-index file
    -+'
    - 
    - test_expect_success 'apply at the beginning' '
          test_must_fail git apply --index test-patch
    + '
    + 
3:  01a5c3285e < -:  ---------- use "<<-" instead of "<<"
4:  cf2b2ca5a0 < -:  ---------- t4113-apply-ending.sh used 4-column indent with space,fix it in use tabs for indentation.
-:  ---------- > 3:  02b661279f t4113: indent with space
-- 
2.39.0

