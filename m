Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9155C1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031770AbeBNWWH (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:22:07 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:56276 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeBNWWG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:22:06 -0500
Received: by mail-wm0-f43.google.com with SMTP id a84so14216583wmi.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjraNJAb72oM5PJtn6ph2aKFOPIFFq7/s6Oio1LOeoU=;
        b=khauLQVlqYmYV4LCcI+6+yfoj6i659B3HkRRpmjP18MTggFXK9EwI4LAV6yk3Gtgxy
         9G+//PEt5c9JlnO0Cc8Ywgckkcvf/lYEcChj4s/NuX6RUrLqoCo/3ETsEWKqpmBbFEyR
         gsEeTognWocOvbsEMG0nB21hMDqXxXGTUy3bJzguIWSbAECejg0uHoo7sB6yAOa41F1j
         KDM18WViBzmoWADfBbWbgAki/5an3+x7mOKEALybpzWD8j3zTg104jjAfdlhEKjW1xv6
         QjsvwWiCyqoHh5l0TdXzWWBvCdYzEq9+pyG6NirYqjLccsZKeiK3PsaXrj1Q84iuUCfX
         +tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjraNJAb72oM5PJtn6ph2aKFOPIFFq7/s6Oio1LOeoU=;
        b=MZpulJWaPeAtyZTBQaNgtftSh3r1K55L2p9hpMTr/2czoJaCX9DF0CBeQE5d6CcWWY
         xM68ZLSJiqdWtQ6hA3Odkkv1yKXEzv/3jGK+EVPs66RedoP8KyhrUfN6puZfNUTnpG4O
         7RMqARNDjSB4afP4YwH2W43MtdGzqugR6vfwLrpr6UJ1jDG+xCDC56su6DIlnXYxl92z
         DklT6KK4+OiHYdkVRI/yvmmUeUASeNHdviJRhPLtJ3FqNDSvAlcpUKIuUcBYXUiekVIN
         i7AgaIe9KE62im6Lq2sGmRiUb2kajommdogS6xFYo4zTxTBXOAk3rm6h4oRUj6w3RoLq
         zVQg==
X-Gm-Message-State: APf1xPALCblvYDUd+VsbKAEHAnMSvPfUz3xag55ZbgTPM0AtitBgxf1K
        mKSOmK19hTBDY5FcuihTlx1h7+/i
X-Google-Smtp-Source: AH8x227Hab748CqS6+yqn3F1IESsDM7eoOUP/nLfbKHENaOCy1oGdcWRBHlM79DTOYC1NqEmh4Et6g==
X-Received: by 10.28.89.5 with SMTP id n5mr404037wmb.18.1518646924718;
        Wed, 14 Feb 2018 14:22:04 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a14sm13191356wrf.22.2018.02.14.14.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 14:22:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/8] perl: *.pm files should not have the executable bit
Date:   Wed, 14 Feb 2018 22:21:39 +0000
Message-Id: <20180214222146.10655-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
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
set, this should not be the case with *.pm files, it breaks nothing,
but is redundant and confusing as none of the other files have it, and
it's never executed as a stand-alone program.

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

