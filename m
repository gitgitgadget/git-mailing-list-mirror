Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE0D20248
	for <e@80x24.org>; Thu, 14 Mar 2019 19:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfCNTM5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 15:12:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39430 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfCNTM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 15:12:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id p8so7095850wrq.6
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=fKSUqyiBnzlMG3aHujxqg9/REET+rJvTr2ehKz41x2s=;
        b=SILGbVuD1vRUt2A1Aa8sKWgwf3hlfSykYp7ndUeUseGtezyPK8xAU4hrH8IGh6EmvL
         4vpIdru2Qjea6iR/XgZMjULEn/VpLNb3SRJJOZqQj9N8lXNukhh4nTNP8R0x+LlDh4yX
         zjaXBIcDzlhqYsT1yk9rIz2ecMZyngxDxvvc66A5lkfUdH3D3QLcl3bljHHDR9K6cSGl
         bBgvjCIxqIJn184H9d6sYa0z6UIb4k3KuDnp9xWq5qded0y9WTEy5/uZYl7vLN7PWtAF
         u2QtVdAFeDznS1n2iRsFNFTlTwJsDTS7RLnvuGc5mlNzMmHbIV7LxTIXv/uXTNySoqXi
         we3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=fKSUqyiBnzlMG3aHujxqg9/REET+rJvTr2ehKz41x2s=;
        b=jsbFYflLFnTDGnnUdaHVn4PkajJ8aW6phOfhuEcTM0UIFzIj478iAJgUEo5RqhTAzy
         PDLNP4GiDRk227jRzYLZiRldkYUTg67amIIg7ew/N/CLoz3ce0DpmXd8r/4qZoAF4zgd
         6jmBj8wJR5RFrpLXdfcglakcu7MEjY+I04uN6H9Nhx00BCxMQIViK4cnGPFFoQUdy4gE
         A6oryossx13gRakUrCLUJL35yo4ebhww5804gFitPf8J1ZvJ81aHrHn2k73jur33qQ7+
         IG2Dx54G16jrMK+o4kW8gRr0jsl8Zp3b3WbvCYX3A7XUdsBwjAP9BeQ524LWkdgN0Mow
         MoXA==
X-Gm-Message-State: APjAAAXJ1l2zhfCwtFlF7vKMpBPb8XkMQEXb4L2d6YAgMAhJ+pdrrMtv
        j3u9W87xh/ukqdq5XDJEuyidpnpBgLWz9g==
X-Google-Smtp-Source: APXvYqxe9BR8Va8PZu9yC1z9HNHrxG8BL0kpqy5EsRUwgOWzONFBOX6LnIgTunc7O3hsjHn325HojA==
X-Received: by 2002:adf:ecc6:: with SMTP id s6mr33337544wro.144.1552590774222;
        Thu, 14 Mar 2019 12:12:54 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id a2sm20328788wrr.60.2019.03.14.12.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 12:12:53 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/2] merge: tweak --rerere-autoupdate documentation
Date:   Thu, 14 Mar 2019 19:12:33 +0000
Message-Id: <20190314191234.25553-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190314191234.25553-1-phillip.wood123@gmail.com>
References: <xmqqef7a9hbx.fsf@gitster-ct.c.googlers.com>
 <20190314191234.25553-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Spell out --no-rerere-autoupdate explictly to make searching
easier. This matches the other --no options in the man page.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-merge.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4cc86469f3..6294dbc09d 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -83,7 +83,8 @@ invocations. The automated message can include the branch description.
 If `--log` is specified, a shortlog of the commits being merged
 will be appended to the specified message.
 
---[no-]rerere-autoupdate::
+--rerere-autoupdate::
+--no-rerere-autoupdate::
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
-- 
2.21.0

