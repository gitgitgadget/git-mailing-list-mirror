Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEC1C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 19:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbhLMT4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbhLMT4M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 14:56:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0B1C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 11:56:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so32259018ybp.11
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 11:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to;
        bh=CrrC0a5lwTAZrYfREMheAAahNPI+3MijAJWS0BT27Fw=;
        b=Q+Np8CftPoQPSQdaj5VaELPk5l93oj0YeA65237+wBHHrxk6jsY8H6mXkf0mq5zqa5
         R/EWeJXuOLOKMwp43+jQT1Pn80b9cKJkKqu+QaULVGCetWmVuKaKCvzGA1F5TUGfr66Y
         t/BL2obW5UyyeL+bAZlzaprHdTERMez01BB9IocuV95XTpgqaz3lx6IBlFyZyWnIZZ1T
         xNE/FXZ5SrMNjQewG26PflTV1cR+rKeQkkIb+n93vHVGCAF0ANhObfKXI3+ypmBiXxDm
         GBz8hukc1qoEOA1KBua7UJHIQv7e2X0XZtqPOQB9MDnbJc5/fZhzwWbJWe1oGTd5qzdm
         lzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=CrrC0a5lwTAZrYfREMheAAahNPI+3MijAJWS0BT27Fw=;
        b=Xt+nFOwItqmXI7i8mdeu/AwRNa7L7qCYjmnZtrMmY1+vKlWTm16vozPsRNORDiKcOU
         ACvUZxt140Y97tEnne6/BfZsIOZQoLn91EuWR9nxvfYaNAkSxCD2EzVyBGNPItZ4dFDG
         6dFJE2ova0zPPLzoyROugHhMLLLyV4412ozmF5KSQYjfNIWJe/B1S3f/yAm7nLSSDOpn
         0Imwc+AdcuHpHwRuXDiK41JqXtP7K1YaBGrsqthv/MfHHwQXJNNWIJWrn+2Qap+8xW64
         lqx6bFyJpC1PepLUTFV6OgA6TRXqj0JerL/8DbbmnDO8aNKDhOOwQY0w7fbHOS8rPIto
         +g8w==
X-Gm-Message-State: AOAM53229b2zwyL4rbKVJWCKa87cxGwwBmz+IzIlyh6illFt0s2kl+Tb
        3tDX6dy9qfaBinLlH9Betm683uapLnqhVEn4xgXCtQhNwi0XCRXWPjv51R2Kz3eKqUZWW2R2eTA
        bP3Jw9wj85aR23cy7wd5bxIZJ0RJuI/uMSF7TGbgVxg3aRrx8f7b+1028TV31ID4=
X-Google-Smtp-Source: ABdhPJy/mwneZDl2mMd7Xb2Tmy6SItRULHr1QhZZav9piU+QdblDBu26qgLbjD3NQidNOBXJS9m0hdF8Exdl6w==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:323c:e811:1713:53ca])
 (user=steadmon job=sendgmr) by 2002:a05:6902:120e:: with SMTP id
 s14mr672402ybu.161.1639425371736; Mon, 13 Dec 2021 11:56:11 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:56:09 -0800
Message-Id: <25107068cbbf8c9ce6886e66e25dff19e072583f.1639425295.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] l10n: README: call more attention to plural strings
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In po/README.md, we point core developers to gettext's "Preparing
Strings" documentation for advice on marking strings for translation.
However, this doc doesn't really discuss the issues around plural form
translation, which can make it seem that nothing special needs to be
done in this case.

Add a specific callout here about marking plural-form strings so that
the advice later on in the README is not overlooked.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 po/README.md | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/po/README.md b/po/README.md
index dcd8436c25..fd1e024dd3 100644
--- a/po/README.md
+++ b/po/README.md
@@ -219,7 +219,10 @@ General advice:
   they're part of Git's API.
 
 - Adjust the strings so that they're easy to translate. Most of the
-  advice in `info '(gettext)Preparing Strings'` applies here.
+  advice in `info '(gettext)Preparing Strings'` applies here. Strings
+  referencing numbers of items may need to be split into singular and
+  plural forms; see the Q\_() wrapper in the C sub-section below for an
+  example.
 
 - If something is unclear or ambiguous you can use a "TRANSLATORS"
   comment to tell the translators what to make of it. These will be

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
2.34.1.173.g76aa8bc2d0-goog

