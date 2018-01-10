Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712A51F404
	for <e@80x24.org>; Wed, 10 Jan 2018 12:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934540AbeAJM55 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 07:57:57 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:41416 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934534AbeAJM5q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 07:57:46 -0500
Received: by mail-wm0-f68.google.com with SMTP id g75so26817655wme.0
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 04:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMtO3legTXzPJNt5siwIYEdSvzuRXgaLxunavtK82xQ=;
        b=VPZP0T4UaXKwulQTLhVj63bT7VO42RILmy8dnVuTswkossmsVT5XysGIHlNuDrvsrp
         QSDmZDLWFCgPbJD4v9h489iASX5Iu6+H5S2krSdRxQdwEKQGEjlKbPB7bDxrGU3VmL9V
         1TxIUgtPmxtNLny+6lVf6SLRuJTl5aqyk6psnMRxynEySM6xa8N6tPSBMGlfWq+vQHJu
         mlYmzAywf6Hs8Kj4awqoYj8PJyy6XuP+lnAoBaJnCsEfxTjke2J0sUa5h1o458QGQLym
         tshyBspMXPZM8dtBD4VZa+eWXWo9a+UJBqE4H6/nbaU8sd0mGDXRqtHGAjKn9hG7ru1V
         jKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMtO3legTXzPJNt5siwIYEdSvzuRXgaLxunavtK82xQ=;
        b=lYN4peGVKr+JSgyzIwEWaT9z8keDoIFy5hJt5ICcsy81RekPscBvzhNLus6STrgPck
         r1AkPO67qec442AgziBxsacFD3BeYdYdZQoQQkPtIM0BCAnBr1LyBMCjIy+vMMVm31Pa
         YrXLAjslAn2i8eT0q99uEU+0Sh9q1fqBqZFdARYwPj7ft1lfVmQDDIIAf1YAGQMzDoHE
         IKR87/JzvCYmF+v2QjgktP/ineMFE82GLGUmwVSqu8QP6mJbvME3D7Wx9+3q9LbnC74g
         g79uNjRUoZgY+q/i+dTEiH91UjnfjTrdMt5O5QsH8SvHFpH2fm4MlF3mH7UaOPL8sjsT
         JUKw==
X-Gm-Message-State: AKGB3mLXvwyqrNJ9wxpVodzkbUuPlFca8yWy5dIqZiHpKaCGWwdPkP0z
        +ZMnY3ua/2vxiiw7rzqFgHOvJZol
X-Google-Smtp-Source: ACJfBou/5bUXk3AdR+qTp7WGcxdWaTQVttHiBkxtIJMSu8zO/iusioXNMtM5U1AHLp4GwuA2+rIfjg==
X-Received: by 10.28.58.200 with SMTP id h191mr16683621wma.79.1515589064431;
        Wed, 10 Jan 2018 04:57:44 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p29sm22722530wmf.20.2018.01.10.04.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jan 2018 04:57:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] cat-file doc: document that -e will return some output
Date:   Wed, 10 Jan 2018 12:55:53 +0000
Message-Id: <20180110125554.12582-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180110125554.12582-1-avarab@gmail.com>
References: <20180110125554.12582-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -e option added in 7950571ad7 ("A few more options for
git-cat-file", 2005-12-03) has always errored out with message on
stderr saying that the provided object is malformed, currently:

    $ git cat-file -e malformed; echo $?
    fatal: Not a valid object name malformed
    128

A careful reader of this documentation would be mislead into thinking
the could write:

    if ! git cat-file -e "$object" [...]

As opposed to:

    if ! git cat-file -e "$object" 2>/dev/null [...]

To check whether some arbitrary $object string was both valid, and
pointed to an object that exists.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-cat-file.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index fb09cd69d6..f90f09b03f 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -42,8 +42,9 @@ OPTIONS
 	<object>.
 
 -e::
-	Suppress all output; instead exit with zero status if <object>
-	exists and is a valid object.
+	Exit with zero status if <object> exists and is a valid
+	object. If <object> is of an invalid format exit with non-zero and
+	emits an error on stderr.
 
 -p::
 	Pretty-print the contents of <object> based on its type.
@@ -168,7 +169,7 @@ If `-t` is specified, one of the <type>.
 
 If `-s` is specified, the size of the <object> in bytes.
 
-If `-e` is specified, no output.
+If `-e` is specified, no output, unless the <object> is malformed.
 
 If `-p` is specified, the contents of <object> are pretty-printed.
 
-- 
2.15.1.424.g9478a66081

