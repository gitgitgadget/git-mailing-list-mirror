Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DD41F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeBYTrB (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:47:01 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52824 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeBYTq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:46:59 -0500
Received: by mail-wm0-f66.google.com with SMTP id t3so13648128wmc.2
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JouuYjn542WcFafN5jPJFBj8d0q57B2Xdv4FD1iSKKg=;
        b=MCQRBA+txKeqoCK4htVBq5bRIB+eaS6J15P5CNPwcepfQeKOKxylATmdppdnxFkxs9
         v2m2hy3VROKJ9D5mickAGYPFeMaorGT3x0fi+2nN5UxjWxE+pZduzR6f50aFgnqlB4xD
         0oMU1uEZMz7glv+cjR8fAx9rMeTOM5quCLJwsnBnRrkmedBbjepit6hZoyT1HHjC49aK
         oFgxs6hKe/HaQ26HnSIf9DomAUOsiZYbHMjT7pOXHF7OVXY7j3lA7bkubKIGpHanqU1f
         EwtuKFoQrP0S5kmqq1vaJVbqHwe4szACPnU5zY+M3Y1LXfAo7Pz5LyqWi1irtZLCVYbO
         7/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JouuYjn542WcFafN5jPJFBj8d0q57B2Xdv4FD1iSKKg=;
        b=B2l3YqHCPX1K3wQJ1iTvT2WXzD9OPXlPgIQlDuYEmAqpOmmo1ignJQWA4u+ke10/nk
         p7MwLCEFrFso0TQtEpQ0P6dc6oCVENuiziR2mJuBaG/MrvLzU1JmUXf0W6UMopGWQgJu
         GKEyf3YcEQo2RagXH8AM8L93kFzjqjC8yPAh0Od5Fy/2bLp+TGOjDmydfkOpr2N5lX3G
         plBxahTYOGtfcGhHZDMYgBAsVuYeJdsssrwwuoL3kXTtJNiQiwkjN/MAhfg3YsGLa/Di
         TSwLYIoNzYIm9gLmKMzRG16oOMfbmb4SoQhtExmwjA/cRFNtzzw4m7Xnk9nPJmt8jzHj
         OC6g==
X-Gm-Message-State: APf1xPC38bDJSkQMN97rnBJtV8ATBNiqgF5JHONXiCy3xB1585NeOU31
        esvKdyFNTIbFtbGBQQ2CjzS01dNN
X-Google-Smtp-Source: AH8x225kQcaew4RarK39WLt7fifT3MQJoe+KgdVM8zrRTBu/y6PpmteD34SfhUGMvq479eh8fufWQA==
X-Received: by 10.28.52.9 with SMTP id b9mr7382693wma.114.1519588017546;
        Sun, 25 Feb 2018 11:46:57 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b66sm4394003wmg.28.2018.02.25.11.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 11:46:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/13] Git.pm: add the "use warnings" pragma
Date:   Sun, 25 Feb 2018 19:46:27 +0000
Message-Id: <20180225194637.18630-4-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
In-Reply-To: <20180214222146.10655-1-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend Git.pm to load the "warnings" pragma like the rest of the code
in perl/ in addition to the existing "strict" pragma. This is
considered the bare minimum best practice in Perl.

Ever since this code was introduced in b1edc53d06 ("Introduce
Git.pm (v4)", 2006-06-24) it's only been using "strict", not
"warnings".

This leaves contrib/buildsystems/Generators/{QMake,VCproj}.pm and
contrib/mw-to-git/Git/Mediawiki.pm without "use warnings". Amending
those would be a sensible follow-up change, but I don't have an easy
way to test those so I'm not changing them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git.pm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/perl/Git.pm b/perl/Git.pm
index 99e5d943af..7ec16e6dde 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -9,6 +9,7 @@ package Git;
 
 use 5.008;
 use strict;
+use warnings;
 
 
 BEGIN {
-- 
2.15.1.424.g9478a66081

