Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95358C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 05:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjBWFlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 00:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWFlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 00:41:19 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459CF47402
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:41:18 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id i31so4704322pgi.10
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU/OlCHASJkgodlmlZQGbUsxl9UdGHNXHXuA0+SwJ5o=;
        b=PH1UToehQ0L+tmbdqknH2bAn4S+uEaoqUpF8d4uyXPbIcqsDRGmNnrt8LFpiZcDpHn
         u6EyNeQ7RX27FnOknCsgye5pJ8aoui5p5DMtJX99xnLvOqnna7oJPfx+CrsXTouVC4em
         O3TUyzvz+dFFDI3Ug78H/Zuk5OEDlmGWSOSWqATLK5VpUvPtv525hJ6udL6Lk6u6cIHr
         tQt958grPdUpTLUuKXsCn50EEU+viOgXxpx3W7EHf69IX1UvDEcLiAB5q4RU11bqG9pF
         2jRA8JFjEsTBdx1Hmj6zcAnCGPJe+Yz1m8m/FJIq5t0jwrYRLQ1cuVeWQ0pVQoqwU7pM
         SUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AU/OlCHASJkgodlmlZQGbUsxl9UdGHNXHXuA0+SwJ5o=;
        b=pgq+SiBQDmAK0K1kmFpA80X3Muc9ACKJ/KiPcZBSGX3lcOHEWXx2XCbhztVAgDkXDm
         abbXutSI3TFtjZpO5G1LXBn88EXrdH3h841AKwJ5AeidVAeMAw2ER/dPtrrP0gBljp0J
         LcsxiVMgTMINJAVsIJjGQqxLH2Wg5v5bfziwvhMGtNWARXUyuJu80lxm1f2z0A/PJtB2
         +VvkgIqfMhu3cuGQY4uz0vFSf/OGicV7LIcItCePYm1nUfXusw6I44rUlytN5OVpRYmj
         +MWKWWukEmRvhmn1FqWqpggYkhNNaj0PCMt0N2tU+u+b5+/a0ImtpB96xTtAg6L5tlm2
         U9Lw==
X-Gm-Message-State: AO0yUKUiVfQlmOoeXVSV8MaiF056ibo7OgbqkvmmJy2Z7h4cqpvKmZlg
        dPY9yyZ5t5XiIcfOlC8AZmQM3palZ/C0Gw==
X-Google-Smtp-Source: AK7set9GyCh/VhD+IAjphp1OwAtA2+MUDrDbt6e4lS3Lt2VHXL6kIiHGyGnr+sEEeNljazJRJJEUdg==
X-Received: by 2002:aa7:9e47:0:b0:5b9:49a5:5de7 with SMTP id z7-20020aa79e47000000b005b949a55de7mr9495315pfq.31.1677130877532;
        Wed, 22 Feb 2023 21:41:17 -0800 (PST)
Received: from Vivans-MBP.lan (node-1w7jr9y92i5dgt19tzyticxhd.ipv6.telus.net. [2001:56a:740f:7b00:8020:1c0:b10e:fa81])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b0058d91fb2239sm7157453pfb.63.2023.02.22.21.41.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Feb 2023 21:41:17 -0800 (PST)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, nasamuffin@google.com,
        Vivan Garg <gvivan6@gmail.com>
Subject: [PATCH v2 1/1] MyFirstContribution: add note about SMTP server config
Date:   Wed, 22 Feb 2023 22:40:40 -0700
Message-Id: <20230223054040.30088-2-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230223054040.30088-1-gvivan6@gmail.com>
References: <20230222011317.97943-1-gvivan6@gmail.com>
 <20230223054040.30088-1-gvivan6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the documentation on using git-send-email, it was noted that the configuration
for sending email can vary based on your operating system and email provider.
However, it was not explicitly stated that you will need to set up your SMTP
server details in git's configuration file under the 'sendemail' section. This
information is critical for users who are new to using git-send-email and may
not be familiar with the additional setup required to use their SMTP server. By
adding this note to the documentation, the aim is to provide users with a more
complete understanding of the configuration process and help them avoid
potential roadblocks in setting up git-send-email.

Signed-off-by: Vivan Garg <gvivan6@gmail.com>
---
 Documentation/MyFirstContribution.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index ccfd0cb5f3..ca095283d3 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1001,7 +1001,10 @@ typical `git` install. You may need to install this additional package; there
 are a number of resources online to help you do so. You will also need to
 determine the right way to configure it to use your SMTP server; again, as this
 configuration can change significantly based on your system and email setup, it
-is out of scope for the context of this tutorial.
+is out of scope for the context of this tutorial. Additionally, note that you 
+will need to set up your SMTP server details in git's configuration file. The 
+relevant settings can be found under the 'sendemail' section (see 
+linkgit:git-config[1]).
 
 [[format-patch]]
 === Preparing Initial Patchset
-- 
2.37.0 (Apple Git-136)

