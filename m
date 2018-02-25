Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6DB21F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeBYTqz (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:46:55 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39769 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBYTqw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:46:52 -0500
Received: by mail-wm0-f46.google.com with SMTP id 191so13411791wmm.4
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=knDQcw/4YYGv2KKiSmNCArusf+YvhFPb7mvYz5TKUKk=;
        b=rbYTcBdcBzdGaGTqyFGo2Et7bBYXkrEkJ+R2BbAgdS0dk81RHg5aXmtUW/fP9R6QNK
         aGAJ7pT6F7W5OgIfgoffqnckj1yD9GhOYEWUUCmK1wQZvAfBF+T73sadjsWzgOfdpuBd
         zAko53k5h9YnN/MmFDCgJn/pHyke6Sg4ONMXiFK4+hhpvm9Whf8EBSKjZUNUBk1nhONK
         4Ub77yRcCEOAHgkZfqpP2PmdALr1cAszRwQsABFmWgzv0K2vqn7uDrPlta6TsE9O0sqK
         eCbmphxmzBMixi/+65B689J4a3ZQuPP/C9hCIsk+1vDpHyEl5fg94/S3yuLqvTAFS5Qm
         lNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=knDQcw/4YYGv2KKiSmNCArusf+YvhFPb7mvYz5TKUKk=;
        b=nVwdm9ZxxlAOVlZNahEU3OwI+WX1y7ZnMPWqjLkZW/4ILYkRWzduUn0Jdu4tViXLv4
         vbE9bKqW+l/acFmFy3lbPJraRfH+OZCt8jG36bLmNwhcJAHB0cqznR9+eYJrG+sHr3Fj
         4oaFLbUi9Rga5uvd8iKsaQ0fuhnWP7hKOWX8RsIOjNfPIpb6QQFMNvdM/3Qu4VN4jj/m
         8Yv7+dzkfkdQ2c55gwHGUug3ZYteTUOYiVIc80HHTHVa8UcfkV7FhAJXKElQz5C/2AXu
         TiF2UIi2G37UZSq+QbfAxDeMQ7r9CiKnngTByBIAseLAyAydjK0ZozLt8x4Fks6EWKgA
         yzhA==
X-Gm-Message-State: APf1xPCqzLQmfK5aHyRVuDhytaUniGM9SfoA7Fx6/MntlsGap+nfKr+d
        P6fcyq1c60OrzMMXlx9++gtqj5c3
X-Google-Smtp-Source: AG47ELufiQuvZ2RwkCU1kP6sc6O+VLcB9ndw8Y0uIefV4oDOpxk45eMzmMKr8B9bO0f9BKi+WO8VdA==
X-Received: by 10.28.55.72 with SMTP id e69mr2889918wma.86.1519588011284;
        Sun, 25 Feb 2018 11:46:51 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b66sm4394003wmg.28.2018.02.25.11.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 11:46:50 -0800 (PST)
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
Subject: [PATCH v2 01/13] perl: *.pm files should not have the executable bit
Date:   Sun, 25 Feb 2018 19:46:25 +0000
Message-Id: <20180225194637.18630-2-avarab@gmail.com>
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

The Git::Mail::Address file added in bd869f67b9 ("send-email: add and
use a local copy of Mail::Address", 2018-01-05) had the executable bit
set. That bit should not be set for *.pm files. It breaks nothing but
it is redundant and confusing as none of the other files have it and
these files are never executed as stand-alone programs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git/Mail/Address.pm | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 perl/Git/Mail/Address.pm

diff --git a/perl/Git/Mail/Address.pm b/perl/Git/Mail/Address.pm
old mode 100755
new mode 100644
-- 
2.15.1.424.g9478a66081

