Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9257F1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 12:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbdAYMvk (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 07:51:40 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34760 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbdAYMvh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 07:51:37 -0500
Received: by mail-pg0-f65.google.com with SMTP id 3so1906041pgj.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 04:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+xAjFl2Oc8M09upx41HH9NaMs1Nb3THVH6TLGq3P64=;
        b=C6XEqT6KQQuydWhe4T7M+jjrmLnZAIeAP9sm8naQ5+2DNUKT2x4tdgf2K4fE/5t1T2
         sy+J87m8Wqf0Sm2a28De7bZ+kclfCD5hSkJijn/bRPaRbhvzLq9Tkr45lsurf+hvR2wC
         1g3VU6e8zdAJr7bzUnm5gRQijyb1Fnnqm6MCgrnkyzyu9zKbYnWBjJpNl0taWMTEF3Zx
         GbHsPQ9/+8hOO7zsT4cecb8tz12Fo+Jj23DCHCH/doas/ajnEAyf4X34Xy/Y0RBqW2Oe
         uhALEJbPN1MIRy2QGzKsAEvu9ElGHLVyl0jEbkhfh9+ycnNxP9GllAwA45qZporyhgZ8
         KEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+xAjFl2Oc8M09upx41HH9NaMs1Nb3THVH6TLGq3P64=;
        b=T7pMEYEBsYBkOsCGn0NiFtfGyW7bxGQgPhgyCO843/GlS10nwOkwRvGT1L4txJLm1i
         BP7alHiaEaF6otQldNnRhY0SSXlaMuLcfCzFj57kCrI1UgI+q+Idwa8eRLSDRtgZR7G1
         PeyYyO2RHv6dTFEiLQeW0wtKDW0Mht8Il7pn0enFoAfaePPZCy6k3UDGQV8vvwK6bvJX
         LQyffox01u6iHkuKVyicXyrredlLqV/Rdg6V7qRy7hVQAYhi9i7xie8qWvdlha4p7wff
         TXYrr4bQikwi4HPTmI7nSlRiIw/Xc5u6unr9AJGvwcCaXgF7nLVM6wC11CsrrhXQWL1m
         ndTA==
X-Gm-Message-State: AIkVDXKALGb9a0x/wGmh8PAz7JJI0oOJlg2Ss76/voV4R2Z6g3IJAG5c0Y06EKHONzU9ww==
X-Received: by 10.84.176.1 with SMTP id u1mr3411736plb.71.1485348681816;
        Wed, 25 Jan 2017 04:51:21 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id r8sm1106364pfi.82.2017.01.25.04.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jan 2017 04:51:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 25 Jan 2017 19:51:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, jacob.keller@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/5] Prep steps for --decorate-reflog
Date:   Wed, 25 Jan 2017 19:50:49 +0700
Message-Id: <20170125125054.7422-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm still half way through implementing --decorate-reflog that can
select what refs to decorate using --branches, --remotes, --tags...
But I want to make sure I'm heading the right direction first since
I'm not really sure if this is the right way (implementation wise).

This series does not really implement --decorate-reflog. It shuffles
revision.c code around a bit so thay the option can be implemented
later. The most controversal patch would be 4/5 where --exclude
behavior is changed slighly.

Good? Bad? Horror hooorrrible?

Nguyễn Thái Ngọc Duy (5):
  rev-list-options.txt: delete an empty line
  revision.c: group ref selection options together
  revision.c: allow to change pseudo opt parsing function
  revision.c: refactor ref selection handler after --exclude
  revision.c: add --decorate-reflog

 Documentation/rev-list-options.txt |   1 -
 revision.c                         | 206 ++++++++++++++++++++++++++++++-------
 revision.h                         |   4 +
 3 files changed, 173 insertions(+), 38 deletions(-)

-- 
2.11.0.157.gd943d85

