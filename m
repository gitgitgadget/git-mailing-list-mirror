Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7221F461
	for <e@80x24.org>; Mon, 15 Jul 2019 12:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfGOMlM (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 08:41:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33877 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfGOMlM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 08:41:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so16798329otk.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2019 05:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=l56rNZfyBtPwY4vJ74uTdwDcH4ZPPd9eudWW+B7T0yc=;
        b=b2wUKCCLkgtdeDeHGx9oG+dEWkwCm2/SPcEoVFr3H+B4NpqBKsj49vQzX7IS76f/JA
         qXjZticvI/yTimz0Y3lt/atccDiXxzCLnjlqiWdOIpL2RW6zN0cX9/C54VZLihGygPMR
         mEb3xrXB7BRpmVHVxOIAH1VrnL68k4OI/MGHdqIjSG10aNfGDsfDwFunlXLoa41NHvuN
         hD/fnnK1mMoC3UA9BjqcKSapIKnSwD3LwscEic9foqHNzaOOBwKHhCwacJYVV7LoihSX
         rWT1cxd9cgOliHAtIVobHjAYkD0YLILiMtLdTpVIV/69vo9tDihR3TYVTqkI0/gCVnXG
         F35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l56rNZfyBtPwY4vJ74uTdwDcH4ZPPd9eudWW+B7T0yc=;
        b=dJERufJxu//7zdg36getLjjkhlCRyNcSWlasXd9uz9WzGFVe+5M1p1MsH3wVNV93Al
         dpnAbqhzcc0XT0bRv6WRuVxkymlDWy2AYAzCFylOUc2hEKtkKxqYHv7uq5GLknoxudT2
         XFCsmSztQhGp7Ngp4TlRzbVTBY6M81p/H5NmjriPYzfJ9C3qKszY9xVJ42ocdv7c/B4w
         Rr2uSvu22pFFXR1Z906h0jTHgC4tCY42qXP2BjBsOp0MbhfWJNNLeY3gTiV6X4P5uCog
         psbfqASpJGT4s3R/m3rzvVl31rqQDQXBUTEVrdLZB1ULt4GGSETBx6cf8T8Pfg2tEzl4
         O7eg==
X-Gm-Message-State: APjAAAW+FP6+aaWFHYERVHYw04yPoF7NmuJx1N8nj2cxVgIocIwZH6tU
        i6AM1qAMNvIx12wW2ZQFdh2B0tFr
X-Google-Smtp-Source: APXvYqzD3JhrBCqMpa1fEZmC/IDgdMUGu1MzzgSNyl+wz6hpPWwv/p7J/8TnXJPbzI1fMNGyjpXdEg==
X-Received: by 2002:a05:6830:105a:: with SMTP id b26mr18813787otp.351.1563194471593;
        Mon, 15 Jul 2019 05:41:11 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5c00:b322:c4d8:3df5])
        by smtp.gmail.com with ESMTPSA id q17sm6085893otf.54.2019.07.15.05.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 05:41:11 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v3 0/3] document deprecation of log.mailmap=false default
Date:   Mon, 15 Jul 2019 07:41:03 -0500
Message-Id: <20190715124106.12642-1-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on the discussion of the previous patches, we concluded that
changing the default will require a transitional period.

As such, I have introduced a deprecation warning that is printed when
the log builtin commands are used.

Thanks to Junio and everyone else for providing feedback on how to
proceed.

New in version 3:
- Split interactive session detection in auto_decoration_style() into
  it's own function.
- Defang the tests in a more efficient way.

New in version 2:
- The warning is disabled when `--format` is used.
- The warning is disabled when not called from a controlling terminal.
- Tests which fake a controlling terminal have been defanged.

Ariadne Conill (3):
  log: add warning for unspecified log.mailmap setting
  documentation: mention --no-use-mailmap and log.mailmap false setting
  tests: defang pager tests by explicitly disabling the log.mailmap
    warning

 Documentation/config/log.txt |  3 ++-
 Documentation/git-log.txt    |  2 +-
 builtin/log.c                | 26 ++++++++++++++++++++++++--
 t/t7006-pager.sh             |  2 ++
 4 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.17.1

