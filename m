Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 864C51F453
	for <e@80x24.org>; Tue, 18 Sep 2018 17:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbeIRXFq (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 19:05:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35466 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbeIRXFq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 19:05:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id x20-v6so2612159lfg.2
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyehlpNBtR52vD8OafKh898C9gkn/0FBKOaTO9wRNNk=;
        b=DQgrU+LUFIxoXAzkek55y9KnOnbwG9F3VP41EFRhZaXnrEQPXtjPJYGtNntRmXXGXU
         VVfgJ+o1Cev5JTewDH2HcpeGrJl4a7vACkF1izHCjZo5Bgjq/Q2z7+/RmWWZ3W9BUVnD
         3e9n11C3TCDKswWa6iOz65zzVko0h8pZNcqQF5/mCJkyekYapOnBYAgdelSuyTTUsXaj
         1rnXqvXvPG8FlTYDTZ+KbTlF6PkM5tD1alE6rbq3ikqI9lP1SC0Ocddnl4LUq3bpYFRD
         iiT4YZuiL9/TKAnNVBVlccA51WL+PHP14zTCeWKrLN9BS6KTQlqxRwz0tlQHv9Ag6Qxw
         mJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyehlpNBtR52vD8OafKh898C9gkn/0FBKOaTO9wRNNk=;
        b=NKiaj77QHBuCp3ypTXN2v3YXCjc0/uUcf7nL67IPY9Des+wHVraIdfG5ix6ph+CACq
         FfzAIEESnm8f3Qu1whbZ5Cw0hvRwV8Dxcut3c9R+gqIkqNXRURyzbBIGLENEmDM8IJ5u
         NBFv5X9vwO0qfnq66v9XoQuTogKS52It4/oZC1RLPHs45VMlOOiPVZvwMCq/dtowwouv
         wzd1x+J7qlUrUdrQW+KGFdAkWLkRbRPNK6k6ztuG/wIdFMB1y2YfDfzCp1v0zcfYWlML
         pHaGcg89EVVRwDOMOaOpQMjTAe+IV5QR+hH1eChnRL41Mu4a8ZCPaqj9KWEq0WbjK/f+
         1Kpw==
X-Gm-Message-State: APzg51BYlRTutHNCgUiZOx0f2/rfegVDZZbpNxyDEnKZDRxllmP6v3B0
        xWs5UK9lQ6OcTGClgNaDMPniFSnX
X-Google-Smtp-Source: ANB0VdYu2+0L8pKB32FGVwJEfP6+7wnBLCWFcavKzFyNx/KVr7YjkxYRl9elEVwZONiTj276w1mcyQ==
X-Received: by 2002:a19:2583:: with SMTP id l125-v6mr6389347lfl.135.1537291927815;
        Tue, 18 Sep 2018 10:32:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm575382lfj.15.2018.09.18.10.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 10:32:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, smaudet@sebastianaudet.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] add: do not accept pathspec magic 'attr'
Date:   Tue, 18 Sep 2018 19:31:59 +0200
Message-Id: <20180918173159.30300-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180917015259.GA26339@sebastianaudet.com>
References: <20180917015259.GA26339@sebastianaudet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit b0db704652 (pathspec: allow querying for attributes -
2017-03-13) adds new pathspec magic 'attr' but only with
match_pathspec(). "git add" has some pathspec related code that still
does not know about 'attr' and will bail out:

    $ git add ':(attr:foo)'
    fatal: BUG:dir.c:1584: unsupported magic 40

A better solution would be making this code support 'attr'. But I
don't know how much work is needed (I'm not familiar with this new
magic). For now, let's simply reject this magic with a friendlier
message:

    $ git add ':(attr:foo)'
    fatal: :(attr:foo): pathspec magic not supported by this command: 'attr'

Reported-by: smaudet@sebastianaudet.com
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Since Brandon is currently unreachable, let's do this for now. I
 might eventually find time to go over pathspec code and see if I can
 add 'attr' support to the rest of the commands, but no promise.

 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 9916498a29..0b64bcdebe 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -454,7 +454,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	 * Check the "pathspec '%s' did not match any files" block
 	 * below before enabling new magic.
 	 */
-	parse_pathspec(&pathspec, 0,
+	parse_pathspec(&pathspec, PATHSPEC_ATTR,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_SYMLINK_LEADING_PATH,
 		       prefix, argv);
-- 
2.19.0.rc0.337.ge906d732e7

