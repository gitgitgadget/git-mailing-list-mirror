Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CC2C4167B
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4720A610CA
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhJ3Vek (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhJ3Vea (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF98CC061570;
        Sat, 30 Oct 2021 14:31:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r8so9409120wra.7;
        Sat, 30 Oct 2021 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zTOAbGiXMDMrVo6LHSEbGk+d+upm/hKuHyk8QuhAkbc=;
        b=HTvQxSBrFdZCXfCK6aLSk1/nDLr7LugjW7tas5lBGeWcaIwDB59HOQ9V9334Tj56Lt
         xyPNtusIKR8O11inkh7Ir21vKhQdppQLX93Of4lgbpNjmdPy8ulX7xr+u+fivnVXubby
         pxtERmgMmY6C9yDgow+ZOOPIYfUxamuZzA2IPUiV6VhlXuvOiGnaQDtxN6RLBUH7iC9a
         aqMvsrkQT3nJE8PhlwLsJDVhqF+8zu026Y7R+4g3Bi67zCcaP19gge1pD9LnxiFE8DBa
         f8OCriY/0dl/Rzz+zFVFDguh6Hl2GSx1uSo6ED5AG9VD+DUtuS8fRFrM3AC55qC6dkM8
         ykmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTOAbGiXMDMrVo6LHSEbGk+d+upm/hKuHyk8QuhAkbc=;
        b=3qrjKVbP0A+IJFKs3DeMX7KWVEmQtxJ+H11NveGSGWilKUVhuP0ze3sMvYGtvg8CBs
         TBmGLSLDvJ1qtbO9LEMFKAktEQQEY7+IxS3Im7e8S7i9QQyylN3JVCiSSnDC6xKDqoBe
         1InV9JcRLxLzRD0/RAFb+xMrBjNi2oZV971MuDnTOyHy73egaioc/Aiw84QUdmNcI1S/
         ih1ra6uUoLFrhesuZs2OvuVu1ZlRbOd+G4Ls4JvpQs5ySRqW2UjhjRtdBlXfp9gzUQ9n
         ahCjweTEIFBzG0FKyCkb/1uAo9SxzTuHxqwkZU+IdbcUvpVD1cFZnzjj9W0fTFLIVrom
         dHog==
X-Gm-Message-State: AOAM530wtSSUVUDwvvNgEzZcXvcKmir3hJcRkrLhY/P81mbtyZwGNIbX
        +HG2LwmWWvT5G19URORWXzc=
X-Google-Smtp-Source: ABdhPJxE6FtFA28GvexsJmFiRg8hF66uN+5B6T6H7TkGOobePn48ueH0gOyegfuusOwBs135s5zTuQ==
X-Received: by 2002:a5d:5915:: with SMTP id v21mr24758307wrd.270.1635629518330;
        Sat, 30 Oct 2021 14:31:58 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:31:58 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 05/22] iopl.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:15 +0200
Message-Id: <20211030213131.140429-6-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/iopl.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/iopl.2 b/man2/iopl.2
index f0a241b97..7a348fb78 100644
--- a/man2/iopl.2
+++ b/man2/iopl.2
@@ -37,7 +37,7 @@ iopl \- change I/O privilege level
 .nf
 .B #include <sys/io.h>
 .PP
-.BI "int iopl(int " level );
+.BI "[[deprecated]] int iopl(int " level );
 .fi
 .SH DESCRIPTION
 .BR iopl ()
-- 
2.33.1

