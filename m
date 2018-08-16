Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6264E1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 15:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392155AbeHPS4X (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 14:56:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44682 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbeHPS4X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 14:56:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so3765209lfb.11
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAVZ+5TQWN6KxENkfUNLy9WM8IyB/KrLjcUZXKbEiRk=;
        b=vQFYWNOT81LintCAptbN0podnYFzyRKWEv2DtE9y6rh960ykGCK0zuT633Q9C/drhX
         uZPBTBWo8o8RZtZA5UoThz4jfLFQ0fYHAgqRZsRFhCPmA8jeht0gc8ERMhVb9qOQ9Y9s
         W/3Dg8qzmkOpM7tEQNRJJ+uQT83Eo9qcbAuoeCqhgnOKUH/z4eIoAEK0Vlse0rknM2Hb
         x/ZWwMCWrEd0PixRXve0NoKD1f/QmNJl91b76hfXBu3aHQ4aYj+e5Jnj86wLSToGRKrH
         91Ld3eZUF5W60KYXSFGQjnxhLPcBGMx5aXK4E6ipKQoCdX+Y2Fo/c5+Cp+u6AP2IC+t5
         0Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAVZ+5TQWN6KxENkfUNLy9WM8IyB/KrLjcUZXKbEiRk=;
        b=tMq2Hfxd7wKoVCZmuiTmXyBuUD/EAQE1V9t8v+nSInxzz2L638x2jAH9We2ySuIeaY
         okTUInAD3chZmK2005wcKDGuvaTQXkXEgrvo18dkueDroYIsDAuBdZG0gJc29mchJvth
         acezrf0Tnz100ITbSh4xhTRjlMH9FClJWhnkitGJVr31bJZ9GJjdea4e2iFThilcUM/y
         PodzWgdvJXdhfj73R0NC+sd9ldohwVSs+dj+gH8DmahpFziXP0bLmstOUfchnNGR22ns
         CSC123UKCAaiB+OlFhJq6gVZk/EyFrjKQxKHJL+xLF1e0sibx6KRxDT2oeDNsWp6OCRX
         tM+A==
X-Gm-Message-State: AOUpUlGUta492B4isFLYt1pE66gPJEGCEEeJQb30YlOXtwH00v7qee7N
        FXTjIlrTD2EofAw1so7eZgknNtoD
X-Google-Smtp-Source: AA+uWPxSroBkVLdVYz4iy+nQ/hHyyPXdbRNBeR0IXL8GsUfOEi2X71GUyuI2k7fWuBxjT8LFcmFqeQ==
X-Received: by 2002:a19:ec04:: with SMTP id b4-v6mr20283456lfa.91.1534435021749;
        Thu, 16 Aug 2018 08:57:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h4-v6sm4922247lfj.69.2018.08.16.08.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 08:57:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com, tboegi@web.de
Subject: [PATCH] config.txt: clarify core.checkStat = minimal
Date:   Thu, 16 Aug 2018 17:56:47 +0200
Message-Id: <20180816155647.10459-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <CACsJy8AYQL3oDLyt14eJ1emynngqKQv9GXju56gU9u4mHrFHOg@mail.gmail.com>
References: <CACsJy8AYQL3oDLyt14eJ1emynngqKQv9GXju56gU9u4mHrFHOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of this key does not really tell what 'minimal' mode
checks exactly. More information about this mode can be found in the
commit message of c08e4d5b5c (Enable minimal stat checking -
2013-01-22).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fd8d27e761..5c41314dd5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -466,6 +466,8 @@ core.checkStat::
 	and work tree. The user can set this to 'default' or
 	'minimal'. Default (or explicitly 'default'), is to check
 	all fields, including the sub-second part of mtime and ctime.
+	'minimal' only checks size and the whole second part of mtime
+	and ctime.
 
 core.quotePath::
 	Commands that output paths (e.g. 'ls-files', 'diff'), will
-- 
2.18.0.1004.g6639190530

