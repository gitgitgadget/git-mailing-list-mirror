Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761E41F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 11:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeKYV56 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 16:57:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37456 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKYV56 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 16:57:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id u3-v6so5197787pfm.4
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 03:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NE15V4BugNsidQbWnpJB2MFG6OZK1FdSZH48YVgt4v4=;
        b=rBojA2GlTzm0R+DLYkpyFtt5MNTPWHgy18HQ5dq0/ksACQfXpRaK6yj9zVcyV9d6Yo
         gP68cR3zd/kamn0SD0oA7RkIpHo5s/eT8m685qnQmdvUntapQOxxPYAG9wh52/tlPjDt
         LT8ro4pHmFdMDAvoCwAU+dKEFOltuB20vmeUzucKErPXTilX3AxqcRXml7oo1Qv9RIdr
         xW1FJgYfdR6X5YaEoZMo5LWNMpgzaoa3xADuNVoIZpNe1npvBwAjHrliT8gGifkCBMVd
         /EeDSImB7nG5qWYLC2xr58NSHeB7zqNMrjL4d5B2ZripKGtohgbHzOG8W86y212rEO/H
         dFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NE15V4BugNsidQbWnpJB2MFG6OZK1FdSZH48YVgt4v4=;
        b=XF9L+qOP5Q5I+Bg6BzzOJ6DBD5RivflAWFXbGRERMLTHdp72HhQXoNINoBFw6DTtj8
         LMxsoFlJKdrXZ8HeB4979kNQjSAwlZBfalw09LIX3ULp+ElpcPdQjSRYKqNy3bRbzVwM
         X3Bi1O+JlzJRuBoGMk+xfb1u105B/sXKSwaUOS0poXsVYFbZueAJCvZiWWxQNHsvm3F5
         grI5bDAzFOuFVIn0GpdK4CNJQV3uqAFLojJ+nld1cERtXXz75YDgc4Xrh7xf6z1s8+nN
         Z7fgihiDU9+wUi+6D902yTNnwQRcs7Dk623YJ0BYrOEC6Zu1XowQhyifRBdlvROcOTrx
         gYnw==
X-Gm-Message-State: AGRZ1gIFNX5wRRhPH/z427O65CzV3CzNKVrMQxMaS071QF3EpFlpBuak
        JP0MCX6BkvM5xXgcb3QTf8Ou+aJm
X-Google-Smtp-Source: AJdET5fWXvy2DBgsLPxbNEEXj2b0vkJIpIhgfl9IKKuG3Su8WvP+vYejceg1lhSd31rtKkMUcdSIHg==
X-Received: by 2002:a62:1095:: with SMTP id 21-v6mr22792172pfq.227.1543144028419;
        Sun, 25 Nov 2018 03:07:08 -0800 (PST)
Received: from localhost.localdomain ([136.179.21.64])
        by smtp.gmail.com with ESMTPSA id h15sm21154301pgl.43.2018.11.25.03.07.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Nov 2018 03:07:08 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 4/7] config.mak.uname: NetBSD uses old iconv interface
Date:   Sun, 25 Nov 2018 03:06:47 -0800
Message-Id: <5841455b55d7e14f962659ce3bf36c1f04162268.1543143503.git.carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <cover.1543143503.git.carenas@gmail.com>
References: <cover.1543143503.git.carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

prevents the following warning :

utf8.c: In function 'reencode_string_iconv':
utf8.c:486:28: warning: passing argument 2 of 'iconv' from incompatible pointer type [-Wincompatible-pointer-types]
   size_t cnt = iconv(conv, &cp, &insz, &outpos, &outsz);
                            ^
In file included from git-compat-util.h:275:0,
                 from utf8.c:1:
/usr/include/iconv.h:46:8: note: expected 'const char ** restrict' but argument is of type 'char **'
 size_t iconv(iconv_t, const char ** __restrict,
        ^

it is set by optional configure at least since NetBSD 6.0

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 36c973c7e6..59ce03819b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -246,6 +246,7 @@ ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
 		NEEDS_LIBICONV = YesPlease
 	endif
+	OLD_ICONV = UnfortunatelyYes
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
 	USE_ST_TIMESPEC = YesPlease
-- 
2.20.0.rc1

