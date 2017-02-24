Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CDC820257
	for <e@80x24.org>; Fri, 24 Feb 2017 13:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbdBXNPM (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 08:15:12 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32894 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbdBXNOu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 08:14:50 -0500
Received: by mail-pg0-f68.google.com with SMTP id 5so3098851pgj.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 05:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwunmTvajuRNKaUQms2LaYYUZvynhLdA6q32RgEiXK4=;
        b=jncJBQJ7aZHOS0Vtdosp7TmtnutpGxqxIS5Y/KzNYWatK5ejguG4U2tgwUFP40xaQl
         w0YJVFrU76oowy9ItFhDBHZIvivbyQkXVsjKM0UavhbXSvcaATFsZmhUqegIocXRIHGF
         MGrFKWvSO+5giaElegDCyaVRFCOaimEBV+D6vZx/ALFfFOyFQDTp7omvA5y46Q7zF/WC
         rrP+63CMYRhzkRGN4DyFiRRAsZG2yXcqYg/T23vGgJxGS8veN4dm/wB7dq6PBMUFv9I6
         hJ3wHD6WPrp4FlHmbciUsINa4xp94JZ6X6QMjY00lgF1hky3dNxUCwDuAtVshaWns1to
         Brhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwunmTvajuRNKaUQms2LaYYUZvynhLdA6q32RgEiXK4=;
        b=ZwzNBx4or1c1yu9+awb8RJ5TS9prsOFr8ixm6UTrgkPa4nWBjgHGCTc4vWZEb8lx0C
         Ol0sa4zGK7rd+g5qcCTs0VMgYjTUqN2OWBXYHG1Q3Zg38ZOOLLRDBsR5pZKR6jS7V240
         wC9OArvdMpn3aLw3s3rxS+2nZCJeq31JrEwee9aAWFWDZeKD+4XCNCY27jkDt1GgzkjD
         XX9BiHMeATwvNHvNAWsK/Sq9MQVBaIcBlZD75JR3EJwqWMUfz/IxbGBA81EW/jgUZcTz
         oZBZQLbLcXloSxfW46Ib4RA1ve8tGSEAMg1/CUctqzRP6FbAvSxqTr8RLt09LH02YKrI
         nADw==
X-Gm-Message-State: AMke39kVikWOyC2ohUwqpS0pBKC05ZJ9g4NzSbbTenEu2DZhOHyIebBvwLzN+Nm66KKSlQ==
X-Received: by 10.99.96.135 with SMTP id u129mr3379438pgb.216.1487942089232;
        Fri, 24 Feb 2017 05:14:49 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id x30sm15302872pgc.67.2017.02.24.05.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 05:14:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 24 Feb 2017 20:14:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 0/1] Conditional config include
Date:   Fri, 24 Feb 2017 20:14:24 +0700
Message-Id: <20170224131425.32409-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170224131425.32409-1-pclouds@gmail.com>
References: <20170223122346.12222-1-pclouds@gmail.com>
 <20170224131425.32409-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6 has lots of text changes, most of which I shamelessly copied from
Junio's, with some minor edits. The biggest edit is the mention of .git
files, which is probably a good idea since .git files are used by
multi worktrees and submodules.

I could not move the "notes about matching" block into the gitdir
block though. I needed to indent it once (not twice like the "for
convenience" block) but my asciidoc-foo did not manage it so I settled
for "a few more notes on matching _with gitdir_" without moving it.

Code changes include renaming include-if to includeIf, and using
expand_user_path() instead of rolling my own.

Nguyễn Thái Ngọc Duy (1):
  config: add conditional include

 Documentation/config.txt  | 61 +++++++++++++++++++++++++++++
 config.c                  | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t1305-config-include.sh | 56 +++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)

-- 
2.11.0.157.gd943d85
