Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB32420248
	for <e@80x24.org>; Fri, 22 Mar 2019 23:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfCVXWx (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 19:22:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46870 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfCVXWx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 19:22:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id s81so2208017qke.13
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 16:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3WXEr/6pVWhCvDNLtoEgQA3zfSOCN0wpPK3KquBOY4=;
        b=Xy4eCGefArLFkLl5lm0EyNah+0+rbJm99AfdhqGRUudGBavjKndz7LwgLDRH79v37d
         8fBVWpbBe1cieQ19VC111q7fQPXAVU5QVjjvcM1DJKoU5R+UtzXkhjsAVPVzW8W36l8C
         qYMHY2Xds1QQ5oiqo7uLXsewDEkuaSXAzJqSPAhHSMlbrLKEhUSOYZVuDktWgfr2sNaW
         iLfNDLuYDO3eT38tkX+WTKpsYt5KFW+hoP8BoIdhcnsgq0996eTGFTnRsP5CLXVkrQcQ
         0lf2CeTl3AjuekXDT5V0La9tQqfx60VXy0xdBwTEwH5RbctVPEg4jYdupOwteHSd+lln
         7hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3WXEr/6pVWhCvDNLtoEgQA3zfSOCN0wpPK3KquBOY4=;
        b=nsqW9RzL1t5vH11Yx/gQ5ObIw1C4Jcx9vH+SuC+6mXJkSAgBsfotzBytYTqJbq+8qn
         aFpoGu4cvwgI5R4+5fUT9CkirB7JeyCLkXfvOfVtyF8jWE7zqu3MBIeud3n2uq3CgRsP
         a2E5umFVbRW2/SCbi5sE0WboCCH99i+2KP+w3h/BRMXc+7Tx8HwYxS1r7UHesXcPktwT
         dLj6EzB5CW1j3+2UK7lOe29EtnsKx2qkcBjiSb3f7x39Q9t3a5tG1blx6lrOrYqe7VvA
         120/ZrxW3pYSExh4Qgdmct1ZbvzRxvVpV/aTISpwsYICQ/7Zys/noFzmbngEeNLhS3R0
         WvZA==
X-Gm-Message-State: APjAAAWBvJeZ/aZ3iNo5rr9i4+7nau9rjB6bSuvib+augKJVugnJZ+dE
        bmc1fufDH1HQfezSuaHxXQo9Y2u9cww=
X-Google-Smtp-Source: APXvYqyxhsVv0lyVtUJ6kR+wQd6ZokwmlD8rW/jOSO3/Df5x5tdNGV1apyLWZrz2SleWCAHrNRJakQ==
X-Received: by 2002:a37:664b:: with SMTP id a72mr10161485qkc.57.1553296971632;
        Fri, 22 Mar 2019 16:22:51 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id i68sm5002765qkf.42.2019.03.22.16.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 16:22:51 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com,
        Alex Riesen <raa.lkml@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v4 1/7] clone: test for our behavior on odd objects/* content
Date:   Fri, 22 Mar 2019 20:22:31 -0300
Message-Id: <20190322232237.13293-2-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322232237.13293-1-matheus.bernardino@usp.br>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Add tests for what happens when we perform a local clone on a repo
containing odd files at .git/object directory, such as symlinks to other
dirs, or unknown files.

I'm bending over backwards here to avoid a SHA1 dependency. See [1]
for an earlier and simpler version that hardcoded a SHA-1s.

This behavior has been the same for a *long* time, but hasn't been
tested for.

There's a good post-hoc argument to be made for copying over unknown
things, e.g. I'd like a git version that doesn't know about the
commit-graph to copy it under "clone --local" so a newer git version
can make use of it.

In follow-up commits we'll look at changing some of this behavior, but
for now let's just assert it as-is so we'll notice what we'll change
later.

1. https://public-inbox.org/git/20190226002625.13022-5-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Helped-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t5604-clone-reference.sh | 116 +++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 4320082b1b..708b1a2c66 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -221,4 +221,120 @@ test_expect_success 'clone, dissociate from alternates' '
 	( cd C && git fsck )
 '
 
+test_expect_success 'setup repo with garbage in objects/*' '
+	git init S &&
+	(
+		cd S &&
+		test_commit A &&
+
+		cd .git/objects &&
+		>.some-hidden-file &&
+		>some-file &&
+		mkdir .some-hidden-dir &&
+		>.some-hidden-dir/some-file &&
+		>.some-hidden-dir/.some-dot-file &&
+		mkdir some-dir &&
+		>some-dir/some-file &&
+		>some-dir/.some-dot-file
+	)
+'
+
+test_expect_success 'clone a repo with garbage in objects/*' '
+	for option in --local --no-hardlinks --shared --dissociate
+	do
+		git clone $option S S$option || return 1 &&
+		git -C S$option fsck || return 1
+	done &&
+	find S-* -name "*some*" | sort >actual &&
+	cat >expected <<-EOF &&
+	S--dissociate/.git/objects/.some-hidden-file
+	S--dissociate/.git/objects/some-dir
+	S--dissociate/.git/objects/some-dir/.some-dot-file
+	S--dissociate/.git/objects/some-dir/some-file
+	S--dissociate/.git/objects/some-file
+	S--local/.git/objects/.some-hidden-file
+	S--local/.git/objects/some-dir
+	S--local/.git/objects/some-dir/.some-dot-file
+	S--local/.git/objects/some-dir/some-file
+	S--local/.git/objects/some-file
+	S--no-hardlinks/.git/objects/.some-hidden-file
+	S--no-hardlinks/.git/objects/some-dir
+	S--no-hardlinks/.git/objects/some-dir/.some-dot-file
+	S--no-hardlinks/.git/objects/some-dir/some-file
+	S--no-hardlinks/.git/objects/some-file
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success SYMLINKS 'setup repo with manually symlinked dirs and unknown files at objects/' '
+	git init T &&
+	(
+		cd T &&
+		test_commit A &&
+		git gc &&
+		(
+			cd .git/objects &&
+			mv pack packs &&
+			ln -s packs pack
+		) &&
+		test_commit B &&
+		(
+			cd .git/objects &&
+			find ?? -type d >loose-dirs &&
+			last_loose=$(tail -n 1 loose-dirs) &&
+			rm -f loose-dirs &&
+			mv $last_loose a-loose-dir &&
+			ln -s a-loose-dir $last_loose &&
+			find . -type f | sort >../../../T.objects-files.raw &&
+			echo unknown_content> unknown_file
+		)
+	) &&
+	git -C T fsck &&
+	git -C T rev-list --all --objects >T.objects
+'
+
+
+test_expect_success SYMLINKS 'clone repo with symlinked dirs and unknown files at objects/' '
+	for option in --local --no-hardlinks --shared --dissociate
+	do
+		git clone $option T T$option || return 1 &&
+		git -C T$option fsck || return 1 &&
+		git -C T$option rev-list --all --objects >T$option.objects &&
+		test_cmp T.objects T$option.objects &&
+		(
+			cd T$option/.git/objects &&
+			find . -type f | sort >../../../T$option.objects-files.raw
+		)
+	done &&
+
+	for raw in $(ls T*.raw)
+	do
+		sed -e "s!/..\$!/X!; s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" \
+		    -e "/multi-pack-index/d" -e "/commit-graph/d" <$raw >$raw.de-sha || return 1
+	done &&
+
+	cat >expected-files <<-EOF &&
+	./Y/Z
+	./Y/Z
+	./a-loose-dir/Z
+	./Y/Z
+	./info/packs
+	./pack/pack-Z.idx
+	./pack/pack-Z.pack
+	./packs/pack-Z.idx
+	./packs/pack-Z.pack
+	./unknown_file
+	EOF
+
+	for option in --local --dissociate --no-hardlinks
+	do
+		test_cmp expected-files T$option.objects-files.raw.de-sha || return 1
+	done &&
+
+	cat >expected-files <<-EOF &&
+	./info/alternates
+	EOF
+	test_cmp expected-files T--shared.objects-files.raw
+'
+
 test_done
-- 
2.20.1

