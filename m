Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F38C203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 16:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbcGYQWM (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 12:22:12 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35366 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbcGYQWL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 12:22:11 -0400
Received: by mail-lf0-f65.google.com with SMTP id l89so11381227lfi.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 09:22:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzVWup+kh/raDfItyivze3RnLcFLkb6Dr0JKr2gOnpg=;
        b=QTO44uHC+V/0Za4+LAx96z7k6ZkrPCw1dwed/ZR3gn3/vgmdKGPldy4A05cDrwnMhw
         Yc7mrT3YckfLQF9HZ1JOv2DdUYNPNzURanIXpGDb11VrGj07PtidoZoVUiOLuwK0dSLP
         tg2wB3nSSW5h65BiNr6fyt52NfljsJvifr2Yheo34LaGQNYM55TlW/Ce1VCC3dx8WmZk
         XTAhkdoZiVahDtKX8fP22EOG9r2AouRwFvz/xedv5FH0guSvAN7djN7/9oq2AEDIVyOu
         L8Wh00OuoZK9iZ/MzrXvI8FUNoTb8UT+W4EKRf8+0+RDATchpeBYF22XwaD08n4T2z3l
         knsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzVWup+kh/raDfItyivze3RnLcFLkb6Dr0JKr2gOnpg=;
        b=MisLzUp7jfcS/lrOi2w2Gs+OQRX4tvFuFO6+A4I1hLTk7wXEcmNLWm2dJqLw/IjIXi
         bILjedx5K3iM6LGwvGJP+OuLIye9yjMz1sDb3HxoiwDtg5guBk74oYGEeKSxj+IC5GkP
         8zbNLeuRt+w6py9iTpt/sPvYOQP29VJGfpzE/9pnyGI10QinkqgPSj/zHVnW7hIlRwkn
         f6f3MVq9STg5azwYYXgw1/ut305S3onl74xAnbV81auI5+S7t3+kKIhwjfb+OdmBijZK
         ae+9XQmQbVVPG7BVUBYmw0KCnfDXUCArEtuet/L4N2juULXKTcHgjxS1JwN6Hz4pYLpW
         SYOw==
X-Gm-Message-State: AEkoouvM42o5vIKPlj5q26hNGo8Ggp9rA4W8jSsXvgWRm177iPw266kO1dja5UTKLzUxzQ==
X-Received: by 10.25.165.71 with SMTP id o68mr6783752lfe.95.1469463729659;
        Mon, 25 Jul 2016 09:22:09 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id c12sm5697603lfc.40.2016.07.25.09.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jul 2016 09:22:08 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	e@80x24.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] config.mak.uname: correct perl path on FreeBSD
Date:	Mon, 25 Jul 2016 18:21:25 +0200
Message-Id: <20160725162125.15734-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It looks the the symlink /usr/bin/perl (to /usr/local/bin/perl) has
been removed at least on FreeBSD 10.3. See [1] for more information.

[1] https://svnweb.freebsd.org/ports/head/UPDATING?r1=386270&r2=386269&pathrev=386270&diff_format=c

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Tested with fbsd 10.3, kvm image. But I suppose it's the same as real
 fbsd.

 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index a88f139..4cd62bd 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -203,6 +203,7 @@ ifeq ($(uname_S),FreeBSD)
 		NO_STRTOUMAX = YesPlease
 	endif
 	PYTHON_PATH = /usr/local/bin/python
+	PERL_PATH = /usr/local/bin/perl
 	HAVE_PATHS_H = YesPlease
 	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
 	HAVE_BSD_SYSCTL = YesPlease
-- 
2.9.1.566.gbd532d4

