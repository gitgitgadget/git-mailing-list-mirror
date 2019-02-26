Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799CA20248
	for <e@80x24.org>; Tue, 26 Feb 2019 00:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfBZA0x (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 19:26:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53291 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfBZA0w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 19:26:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id e74so682199wmg.3
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 16:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9vzRKvwGNszBCWl0xynz6wQvHytSZbm5ybB6pgFv9Z4=;
        b=bhuw39JheYX292rc0d0SkqgBy2nioYhNQfP+aXe1621vti5BW/+6gxG/vsdF+j467y
         XseVP3NA3dnnvittgNVtGOAHkIlqOvVqJrnCgdEu9abD8t0G6hXm0ig5wDg6ZFJoMSE8
         7UZVPnxEnT9WOF7+ilTiwrdyVF0tvHEYTo25kTn3QjkbD789fLWWVa7m7VMCnH9Wpd94
         PFqZS4v3D3dSbZOmSjYsRLE/pz7EAh8XhQCbRf58DC7neZxnsWP/QPm+1y1qXclH1B2z
         q2NQ3AeWGLWpyjipFmLcj82UiZdoYPhesgzxihPrc6D6asNAK+W7Bdc7AokQ61PcuLE3
         YbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9vzRKvwGNszBCWl0xynz6wQvHytSZbm5ybB6pgFv9Z4=;
        b=HK4WGQLJgSMSW2RNy6jj46V8kUBSmsfJX2RE78pUlHUua0MxFhX5DWXliILGgym66X
         scbiFfFBcwhk2k2/hTUYI9l1Nbr13ek9I5xbf9RWdkycSLINnAnWB99TgIkrJy86H50i
         TsHtLTxuhaTNYzFj1t9IKG4BUneaA54Vbc+xBKyaxmx05pyBz9iKiQ4OzgrcfsRT52mq
         NW4OfVporzROgG5+L5u5+oHAtHctnkY/WTIt2DJW2UlkN9Q9fVG72iqj5T9xPhqFs4qp
         aJ2jFBWvaD37362MRpx/Vrs950kSuAqG7StfByR+U7FOJLRCZnFFEl/E4O/9/cTDEWle
         uwzA==
X-Gm-Message-State: AHQUAuYHezohdmbMNtwsyYxuYsaBk8dh/yQuf00b7x1IFDhMXfNzzU+n
        OSnS8uJGPQckotlGaYVH8j0DHFybIV0=
X-Google-Smtp-Source: AHgI3IbsSeR3AQOGubWF2yDRt2YjQe7mlUmho0vkm1BR+gnhyRrlA+KMZYV2CF+iN0AqiZmbl2l/UQ==
X-Received: by 2002:a1c:80c4:: with SMTP id b187mr730886wmd.23.1551140810514;
        Mon, 25 Feb 2019 16:26:50 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm11745708wrt.14.2019.02.25.16.26.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 16:26:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [WIP RFC PATCH 4/7] clone: test for our behavior on odd objects/* content
Date:   Tue, 26 Feb 2019 01:26:22 +0100
Message-Id: <20190226002625.13022-5-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
References: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've implicitly supported .git/objects/* content of symlinks since
approximately forever, and when we do a copy of the repo we transfer
those over, but aren't very consistent about other random stuff we
find depending on if it's a "hidden" file or not.

Let's add a test for that, which shouldn't read as an endorsement of
what we're doing now, just asserts current behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5604-clone-reference.sh | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 4320082b1b..6f9c77049e 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -221,4 +221,64 @@ test_expect_success 'clone, dissociate from alternates' '
 	( cd C && git fsck )
 '
 
+test_expect_success SHA1,SYMLINKS 'setup repo with manually symlinked objects/*' '
+	git init S &&
+	(
+		cd S &&
+		test_commit A &&
+		git gc &&
+		test_commit B &&
+		(
+			cd .git/objects &&
+			mv 22/3b7836fb19fdf64ba2d3cd6173c6a283141f78 . &&
+			ln -s ../3b7836fb19fdf64ba2d3cd6173c6a283141f78 22/ &&
+			mv 40 forty &&
+			ln -s forty 40 &&
+			mv pack packs &&
+			ln -s packs pack &&
+			>.some-hidden-file &&
+			>some-file &&
+			mkdir .some-hidden-dir &&
+			>.some-hidden-dir/some-file &&
+			>.some-hidden-dir/.some-dot-file &&
+			mkdir some-dir &&
+			>some-dir/some-file &&
+			>some-dir/.some-dot-file
+		)
+	)
+'
+
+test_expect_success SHA1,SYMLINKS 'clone repo with manually symlinked objects/*' '
+	for option in --local --no-hardlinks --shared --dissociate
+	do
+		git clone $option S S$option || return 1 &&
+		git -C S$option fsck || return 1
+	done &&
+	find S-* -type l | sort >actual &&
+	cat >expected <<-EOF &&
+	S--dissociate/.git/objects/22/3b7836fb19fdf64ba2d3cd6173c6a283141f78
+	S--local/.git/objects/22/3b7836fb19fdf64ba2d3cd6173c6a283141f78
+	EOF
+	test_cmp expected actual &&
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
 test_done
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

