Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97AF81F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeBYTrY (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:47:24 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:51452 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeBYTrL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:47:11 -0500
Received: by mail-wm0-f51.google.com with SMTP id h21so13651899wmd.1
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jZU/xvB9oCpFJ8FG1eTaaKje+Iu9zGjhvXi49mUWLVY=;
        b=Vzn1SWzUcYhkXFn0sMogmC1J05V79eMHdw8sQUZ25XOmhdcHJA1CDhuiTtTvrLZAnT
         o1uTS95sW+ZrySYgkDjkkCpIsQUewK99AoH+MSyg5Fca9LpoRCu+h449hqjWfk5bp5pB
         l9FW9B1aH3D0Ij+PawtOM7jj9SuG/7477PV3mQ7jBI/2DVIXUAyuoTmBTSVaVLD/56k4
         9kyO3hTgipF4x2snBnt8QTcrZBpPYn2KHtoMCsB4npHbTEd8PrINDU8+k04o8Z3g8GXA
         ZrrFUOEx4gZefclWzi++WbgxS/bnO5ckkO3ry+5PyiXboB3UEbwinSBNILu8h4byom5l
         9oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jZU/xvB9oCpFJ8FG1eTaaKje+Iu9zGjhvXi49mUWLVY=;
        b=BZkvN4b3nkfPPkjSg47hQMnvk7fEn/vArqiROhw4BGysyOC+dyhwO0pwGe8ibvK/p/
         jSDI/tLTTjlXfjnXMLuClsyJ4IsaPr5GGtdTgpBIGmNNDkI76PwM3EDCi7A3BPlW61TO
         7xaqdeGxzw3zZ2hp7ium68VdxSoJDlgj0jLM7mXJ2vpEMRXObWU0lUSKCsKqhAmO/wAP
         ciq4YFMflM5CkROoQIEpc3FTxwUCi7Tu47J+TkqcBFsZh5yEKM4J3DIP7l6pIg0fdvHk
         PMcKs32l5TqFu2IZAE42byvNou37VWzc79qOHipu/qACeD/84Hb3iAz4Ed/T2wPhO/GG
         qFXw==
X-Gm-Message-State: APf1xPCShvhJ4IIQBwuHCa21cLH8NufVD8uQSxB+9syHeN7awbikoZkF
        TIrf/v8DO7tMh3DCqMLtPllKcdYa
X-Google-Smtp-Source: AG47ELt1H5qXmI3Amli9seMaWazXnhmIn291zU6wWhDGZAF5Te7jNXX1Llvf1Q3WOIVKole7sfosJg==
X-Received: by 10.28.241.2 with SMTP id p2mr6195108wmh.105.1519588030297;
        Sun, 25 Feb 2018 11:47:10 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b66sm4394003wmg.28.2018.02.25.11.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 11:47:09 -0800 (PST)
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
Subject: [PATCH v2 08/13] perl: update our copy of Mail::Address
Date:   Sun, 25 Feb 2018 19:46:32 +0000
Message-Id: <20180225194637.18630-9-avarab@gmail.com>
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

Update our copy of Mail::Address from 2.19 (Aug 22, 2017) to 2.20 (Jan
23, 2018). Like the preceding Error.pm update this is done simply to
keep up-to-date with upstream, and as can be shown from the diff
there's no functional changes.

The updated source was retrieved from
https://fastapi.metacpan.org/source/MARKOV/MailTools-2.20/lib/Mail/Address.pm

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git/FromCPAN/Mail/Address.pm | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/perl/Git/FromCPAN/Mail/Address.pm b/perl/Git/FromCPAN/Mail/Address.pm
index 13b2ff7d05..683d490b2b 100644
--- a/perl/Git/FromCPAN/Mail/Address.pm
+++ b/perl/Git/FromCPAN/Mail/Address.pm
@@ -1,10 +1,14 @@
-# Copyrights 1995-2017 by [Mark Overmeer <perl@overmeer.net>].
+# Copyrights 1995-2018 by [Mark Overmeer].
 #  For other contributors see ChangeLog.
 # See the manual pages for details on the licensing terms.
 # Pod stripped from pm file by OODoc 2.02.
+# This code is part of the bundle MailTools.  Meta-POD processed with
+# OODoc into POD and HTML manual-pages.  See README.md for Copyright.
+# Licensed under the same terms as Perl itself.
+
 package Mail::Address;
 use vars '$VERSION';
-$VERSION = '2.19';
+$VERSION = '2.20';
 
 use strict;
 
-- 
2.15.1.424.g9478a66081

