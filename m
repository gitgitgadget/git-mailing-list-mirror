Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08861F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeCCPjG (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:39:06 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34995 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeCCPjE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:04 -0500
Received: by mail-wm0-f66.google.com with SMTP id x7so8076589wmc.0
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JouuYjn542WcFafN5jPJFBj8d0q57B2Xdv4FD1iSKKg=;
        b=qM6cVbj43jQWqdlgTMtJzP4VqAhwZ2hBZVnbBirWuP+yNtwUr53XRh7c/aYC8fI5YO
         PwhH9ObalfwngEKWlbUStTMy6JXK1Rh7+mNA8jb42vfW+2ivIDhZ/vLQwUTr4ZgGomYg
         7mEamN2d4I5Erny3z9/XLwlkGJgzkQqNNRLw03Kq3h+wNXla1xrpuBMAEdPNISYzhFN4
         pigUDMkGUs+8mBQK9avqB1oSmge6wTCFLOi0qBFSpJ2kVueujeEh12XT3wAwVzE+pO4m
         +QnjCoOrRJa20/RJ1+giinA3SUr+AUQOXGI9WQUwRPP5WNuBaNoaa0JVrmH12PSE98Bz
         C/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JouuYjn542WcFafN5jPJFBj8d0q57B2Xdv4FD1iSKKg=;
        b=JwXkx70J0GNpzou0jP/Ow6ukW/kcUb0cPWinKUKoVFBvaZMGQnpb38LyuhftqR+PJq
         iyUHgKzsKc3zL8XAfYDNR/RoN4fG9vSw2HWxDbrtT9GzziliKbE+fcczmGZf367BcE/6
         cLahELpdeKwGHtRgorHWCgI9hp8hrxlUlVb2p2FUBNoVi3XVqfA9qQ5duSLBUmopkToC
         hZpV0J/BcdJO2kKI8s6Jc73YqkRvzwK6H9n7tqLdYney+frlbO+Q9J5Ef2JKt9WQRC47
         smnTjoZs/7M7DP08vm7dH4/srrq7y4qiYkC4lMDDHsIEmmRuoGT0Kpp+pQV6grRucaOs
         vItA==
X-Gm-Message-State: AElRT7GPa8PvYsqN+I00wTLYswQdbQqwUV4RmJimj5f9LB5nqUgN7yQP
        J5zI1NyO2P9vvgdnPGHdCXBZRwyO
X-Google-Smtp-Source: AG47ELtUlkEi2BMAneas/X9RXkQUVdWOZWhNXOA7MlM/surGBRgwtvRU6MXmL7zf+646NwK0/iE2Fg==
X-Received: by 10.28.154.213 with SMTP id c204mr3922448wme.64.1520091540897;
        Sat, 03 Mar 2018 07:39:00 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:38:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/13] Git.pm: add the "use warnings" pragma
Date:   Sat,  3 Mar 2018 15:38:07 +0000
Message-Id: <20180303153817.20270-4-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180303153817.20270-1-avarab@gmail.com>
References: <20180303153817.20270-1-avarab@gmail.com>
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
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

