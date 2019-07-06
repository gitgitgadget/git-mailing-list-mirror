Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1211F461
	for <e@80x24.org>; Sat,  6 Jul 2019 16:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfGFQVT (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jul 2019 12:21:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40486 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfGFQVT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jul 2019 12:21:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so6422327wrl.7
        for <git@vger.kernel.org>; Sat, 06 Jul 2019 09:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+0TCN/1w5bsfWvut1kfXVbM4dUioIw1xg3BRGFQvTs=;
        b=GBIIhtIdrENt6FsMu1F/9yf0VCpDILzbYB55n68nmeu4l+sduPaOdhK5e5lP0Hs0eb
         n0uM/81MK9KclU9qG+8hsqTFxWBXjQskAGu+yFwrNhIHCrOLqlRlRkgYcVmSeV+U67vO
         z9nqJ2CsBQMMjTFWnMpAChjyZ8l66xWd8lYGIWQgd1UstfbzawxzjFhkQLKzI0XXihK6
         SEWDodtll2q0TkAkrLq5cELb8v++1r+VAG94f4+dTWgxOWKyxnOyrDx67JtFZatfBV7m
         fuFQwv1+BmCBtWrJN5ESyDzn5FnvVLE8HGHemVRXb0sQ5qGRPy+W70odATjy9nvOhc14
         +bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+0TCN/1w5bsfWvut1kfXVbM4dUioIw1xg3BRGFQvTs=;
        b=ZzHzwk7w4hCNjGVi7KecncKQbPy4nyaJrFjUsx2Rm8XtClIdxGKm8rrFGNC11ghxqO
         5kHT8zKPvoIBrhBBnAwzB3ABtd9SUWMR8ZNHpPWVBF9Yhr8MlGzlIwf3zJHgwHXitZSQ
         QaiA8hPI7qOx4H1GeRQfjPrIAICH40E4x47f4OMvvUy+0U59pQvGdm8QLKlrL8iKZ5Cs
         Trrogd9Py3yM7JxE4J+umw2bLXZGDeLhFRJY9LxADl8dJdBydBxc9X0AeNXvdIVtMdit
         YWnQUGwWl5RcCvVRba0jvrfwkaCSIus5Zw0Y0M57ezh+w/duDXPDevpIpt6UQfbVmHJI
         hHzA==
X-Gm-Message-State: APjAAAVPLIl6IoNZco+SrlZWJM9lxQj2NhTNX+nDAL8QzcJb2PgyF8xE
        oUHsJUJg+O2aYlBBBUhwCaFL+cW5
X-Google-Smtp-Source: APXvYqwS/WgJKiFAYHQ5/vWLx2jiUZH/TFGF6V8wjpoxXHekgZyhym3A+PKWC8pjjsRy3Lu0zKEHOw==
X-Received: by 2002:adf:9487:: with SMTP id 7mr9672714wrr.114.1562430076919;
        Sat, 06 Jul 2019 09:21:16 -0700 (PDT)
Received: from localhost.localdomain (x4dbd7982.dyn.telefonica.de. [77.189.121.130])
        by smtp.gmail.com with ESMTPSA id f7sm1468745wrx.53.2019.07.06.09.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jul 2019 09:21:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v1.1] ci/lib.sh: update a comment about installed P4 and Git-LFS versions
Date:   Sat,  6 Jul 2019 18:21:14 +0200
Message-Id: <20190706162114.21169-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.667.g5c3548c1fe
In-Reply-To: <20190706161648.20836-1-szeder.dev@gmail.com>
References: <20190706161648.20836-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A comment in 'ci/lib.sh' claims that the "OS X build installs the
latest available versions" of P4 and Git-LFS, but since 02373e56bd
(ci: don't update Homebrew, 2019-07-03) that's no longer the case, as
it will install the versions which were recorded in the image's
Homebrew database when the image was created.

Update this comment accordingly.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Sigh...  Same patch as before, but corrected a grammar error in the
commit message.

 ci/lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 288a5b3884..0c7171a173 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -163,8 +163,10 @@ linux-clang|linux-gcc)
 	export GIT_TEST_HTTPD=YesPlease
 
 	# The Linux build installs the defined dependency versions below.
-	# The OS X build installs the latest available versions. Keep that
-	# in mind when you encounter a broken OS X build!
+	# The OS X build installs much more recent versions, whichever
+	# were recorded in the Homebrew database upon creating the OS X
+	# image.
+	# Keep that in mind when you encounter a broken OS X build!
 	export LINUX_P4_VERSION="16.2"
 	export LINUX_GIT_LFS_VERSION="1.5.2"
 
-- 
2.22.0.667.g5c3548c1fe

