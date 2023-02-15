Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F360FC64ED8
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 02:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjBOCkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 21:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjBOCkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 21:40:14 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A9E30E90
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:40:12 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id ch10so19377184qtb.11
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q7tdXt6dDDWV7wL4N2Xt76V3tOuDw396GDpWKvHpFs=;
        b=kMiQ7DVZMR2eDf55fJrLrWsQ0bEgZV0ZoqbYv9ljKYw34IHtm07BWS/1vUt73oiP77
         FokJ8dN1axM33iqwX3KfJkEfIH96oiYIqdgHhhmMWLrBKqaq6OywAnVKOQJufEidx/VB
         0IWH2LxIfY1QcdXWZvRRVbYG87wDXNlitS5XDLn+ZTIu0NqxkY58jwlImKnSvaaO/Xxw
         5UODixE9oqMpF2dxscnnspB8qFQNMWOkXSOzWd+rH1mC7n48IxXFuATYvlxh1iv/20VX
         w0MZJL6p//xX0nXEN2DcbsPnyQbzfcRq83bRtzIGq7Wk217G/9LLjfKXKwLGeeSmPlzP
         GvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Q7tdXt6dDDWV7wL4N2Xt76V3tOuDw396GDpWKvHpFs=;
        b=0baeI/388+bzImwUhTazPuMpxN+Gk/yiAW9v5y+fQGyovZ5rDfPByasaT0VTq3rOwy
         LEXUAESDD+N4WajJIOkFXKl5Jt9m4o4Za4RShhiMFEqJx6CaId7zYOj4tVOlI6KRwBBY
         EJI9KbbWjDD/pkjqxOGN8CLl2laLCB9begVmiS9Z49ZWhHNP52ojyKyeJGzk3i64yCQ3
         wXOcS0RxfdyRFe52PaA/CDkGi4G0JI78m57o7m7tYtyLaw3IFdFc0LzQoKkvPqmKdxqZ
         mwBl/KNG9u05QTzE3uwdVSNOy7NPa5c8p/CMg6bXchw+wThpJOqbRFkuo91JFbY3POaz
         hRBA==
X-Gm-Message-State: AO0yUKWUDrN9Eor2n2SanuX96eIpPrMCEK/njMYB1OcZ1z+n4LCMf4ka
        qDz0W9pLDglYkj5Kb5PLbdVI1zjduT9hpQ==
X-Google-Smtp-Source: AK7set8FE6JC1AMEDaajCMgUUOQ23dlhXv57eTdpwCKVbGSoXpZMbbbIOe/5D2s+XPwJt4mjAhNy4Q==
X-Received: by 2002:a05:622a:15c4:b0:3b8:6075:5d16 with SMTP id d4-20020a05622a15c400b003b860755d16mr673732qty.56.1676428811505;
        Tue, 14 Feb 2023 18:40:11 -0800 (PST)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id e184-20020a3769c1000000b0073b69922cfesm1069734qkc.85.2023.02.14.18.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 18:40:08 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v6 0/3] t4113: modernize style
Date:   Tue, 14 Feb 2023 21:39:50 -0500
Message-Id: <20230215023953.11880-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209154417.10763-1-cheskaqiqi@gmail.com>
References: <20230209154417.10763-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

different with 5 :

1.change the commit message to be more succinct.

2.
use  

test_write_lines a b c >file && 

instead of :
 
{
    echo a &&
    echo b &&
    echo c
} >file &&




Shuqi Liang (3):
  t4113: modernize test script
  t4113: indent with tab
  t4113: put executable lines to test_expect_success

 t/t4113-apply-ending.sh | 75 +++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

Range-diff against v5:
1:  4d55e522a6 ! 1:  cb29da5d42 t4113: modernize test script
    @@ Commit message
         where the test_expect_success command and test title are written on
         separate lines. Change the old style to modern style.
     
    -    for example :
    -    -test_expect_success setup \
    -    -    'git update-index --add file'
    -    -
    -    +test_expect_success setup '
    -    +    git update-index --add file
    -    +'
    -
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
      ## t/t4113-apply-ending.sh ##
2:  cb997bc422 = 2:  09efa23ba4 t4113: indent with tab
3:  726d2fcb47 ! 3:  0169cbd402 t4113: put executable lines to test_expect_success
    @@ Commit message
         t4113: put executable lines to test_expect_success
     
         As t/README says, put all code inside test_expect_success and
    -    other assertions. This script is written in old style,where there are
    -    some executable lines outside test_expect_success. Put the executable
    -    lines inside the test_expect_success.
    -
    -    As t/README says,use "<<-" instead of "<<"
    -    to strip leading TABs used for indentation. Change the "<<" to "<<-"
    -
    -    for example:
    -    -cat >test-patch <<\EOF
    -    -diff a/file b/file
    -
    -     test_expect_success 'apply at the beginning' '
    -    +       cat >test-patch <<-\EOF
    -    +       diff a/file b/file
    -    +       --- a/file
    -
    -    As t/README says,chain test assertions.Chain this test assertions
    -    with &&.
    -
    -    For example:
    -
    -    -cat >test-patch <<\EOF
    -    -diff --git a/file b/file
    -
    -    + cat >test-patch <<-\EOF &&
    -    + diff --git a/file b/file
    -
    -    This script is written in old style,where there are something like
    -
    -            echo x >file &&
    -            echo y >>file &&
    -            echo z >>file
    -
    -      Change it to this stlye :
    -            {
    -            echo x &&
    -            echo y &&
    -            echo z
    -            } >file
    -
    -    In order to escape for executable lines inside the test_expect_success.
    -    Change ' in executable lines to '\'' in order to escape.
    +    other assertions. This old test scripts have setup code
    +    outside of tests. This is problematic since any failures of the
    +    setup code will go unnoticed. Therefore, move setup code into the tests
    +    themselves so that failures are properly flagged. t/README also says,
    +    use "<<-" instead of "<<" to strip leading TABs used for indentation.
    +    Fix it. We should chain test assertions(t/README). Therefore,Chain
    +    this test assertions with &&. What's more,take advantage of modern
    +    style. Use test_write_lines instead.
     
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
    @@ -1,2 +1,3 @@
     +	+c
     +	EOF
     +
    -+	{
    -+	echo '\''a'\'' &&
    -+	echo '\''b'\'' &&
    -+	echo '\''c'\''
    -+	} >file &&
    ++	test_write_lines a b c >file &&
      	git update-index --add file
      '
     -# test
    @@ -1,2 +1,3 @@
     +	 c
     +	EOF
     +
    -+	echo >file '\''a
    -+	b
    -+	c'\'' &&
    ++	test_write_lines a b c >file &&
     +	git update-index file &&
      	test_must_fail git apply --index test-patch
      '
-- 
2.39.0

