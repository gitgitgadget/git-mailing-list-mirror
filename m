Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1326207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947791AbdDTVY0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:24:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32966 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947788AbdDTVYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:24:25 -0400
Received: by mail-wr0-f195.google.com with SMTP id w50so4635689wrc.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ek9SRIrMp28JyNExY1LVZ70lvR9VjOQkuLRQCU1exrI=;
        b=e9FNRslCkYRXSbQfAm7vtZzYJEeYsP/HuIu4v8ivgFmx19g82UA6bgtal1XQsdsIv+
         S4QF8D6PWEk2NfKb36woEjA+OoIl6PYQkviQj4mnQnNRgx7jIltPk95fMSKoRMM9k5Yt
         9Y9GbqJowy82PsDrE/9dS448So76Qv1qz8uapABBfxE3duLY+YzKKoQCHFfPFo7/vLUT
         yRkPMWuJOoe95CP5rZGjuYDM0VkCZqiFATkyfrce59QaNu6aerZNf5nHiC7GELG3p8Pa
         DT/QvtC57FCv5rBaGgREUIjZFIcpNEVst4FbF6CMS93sWtXnO2gtogo8g2WInpbnuMXT
         vckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ek9SRIrMp28JyNExY1LVZ70lvR9VjOQkuLRQCU1exrI=;
        b=YUZ+6MG04eo2IMb6FidVHN3JrnPz+5G5L6OIIGXDKvM6FOXa2ILOKFDcZvAx8qVYkD
         gQffrpabVWP7nHoidUYeBdUDBvcz9duAvt5369PhEQ1SZE7itORRTuxHx7IO2usSqLpU
         hqY3OLdJyja9tpOuLJkl7gktXCam4OFCSAUP/ZylmiNWXUBKbXsyhm8hIKliJZnmSxHH
         sRlLqMhWl4C1bozoiiqPBHl9Bg+DgJwTaO8Oc802w6B76WxROLl8yx9lczPjywCeOZd2
         tL9dMrsk88Cjys54+QCcE7Vdox8P7UGrkNtVNDHHafpJDBvGja/6MBbX762iFH9dw5Ut
         2IsA==
X-Gm-Message-State: AN3rC/74xQ4SCZBKJIPTRywf/taLz7pXXQHAwlyhLZ2T8MJlIt+nFrxk
        FdSln20L5+zxhA==
X-Received: by 10.223.163.68 with SMTP id d4mr9166069wrb.134.1492723458901;
        Thu, 20 Apr 2017 14:24:18 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k63sm442322wmf.9.2017.04.20.14.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 14:24:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/18] grep: remove redundant regflags assignment under PCRE
Date:   Thu, 20 Apr 2017 21:23:31 +0000
Message-Id: <20170420212345.7408-5-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170420212345.7408-1-avarab@gmail.com>
References: <20170420212345.7408-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a redundant assignment to the "regflags" variable. This
variable is only used for POSIX regular expression matching, not when
the PCRE library is used.

This redundant assignment was added as a result of copy/paste
programming in commit 84befcd0a4 ("grep: add a grep.patternType
configuration setting", 2012-08-03). That commit modified already
working code in commit cca2c172e0 ("git-grep: do not die upon -F/-P
when grep.extendedRegexp is set.", 2011-05-09) which didn't assign to
regflags when under PCRE.

Revert back to that behavior, more to reduce "wait this is used under
PCRE how?" confusion when reading the code, than to to save ourselves
trivial CPU cycles by removing one assignment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.c b/grep.c
index 47cee45067..59ae7809f2 100644
--- a/grep.c
+++ b/grep.c
@@ -197,7 +197,6 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 	case GREP_PATTERN_TYPE_PCRE:
 		opt->fixed = 0;
 		opt->pcre = 1;
-		opt->regflags &= ~REG_EXTENDED;
 		break;
 	}
 }
-- 
2.11.0

