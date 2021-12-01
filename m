Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2344C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 01:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbhLABpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 20:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345475AbhLABps (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 20:45:48 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE95DC061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 17:42:28 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 108755CB79;
        Wed,  1 Dec 2021 01:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1638322948;
        bh=MvaDLB6fLXnhl5DTwye7j82j6wUuvDLBPv8kwJAO3nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HbsLvky1ouDHGJ9trVognLDyHbeSsZCwV4s2ei/i9NKMl8nPgSLkw8DL/iT9mOqv4
         MFVALCU6utNE+/ABddl/EHEIjY9/gDAq528BesB4PUaRW9NGd3/DE743WA3bRN8Coy
         kmMVvxIuX45Qs2OmHL+J0FAnb9I1vt6DDJ/RoQ3GMusL5NqtAkUt3SizANB4uZB2jh
         0+2G1Wz2FU/4L1ZRIeKwZTnqHdWh9fH7Yw9KM5vFc4voGWh9QU5fvGtdvO+dYzkjjT
         aVJ2Pp7N8B6oedOK0ZoFugtjW0eqM9Lwg2CNb76gkFKT+Fc6+OcHFfMqIA/QeW7zvx
         m6eBE27FmbQTswaZEGOrRDkmE0hm01og/fv2hZ3Xz5VvvRLr3+6pE421jRsygq55Zm
         1kMaVBo5yGK3jun8/arYttx7WJlrivr1o22+hEytS5/lSnueqBl3ah0lge1nPchIUJ
         biVyqrvk9b1VXPMqKZF/YqdtPnZrN5q+eaTMkV3XJGKxhbi/RDL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/1] Add a test balloon for C99 support
Date:   Wed,  1 Dec 2021 01:40:49 +0000
Message-Id: <20211201014050.38002-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.0.390.gb44f4d0eb0c
In-Reply-To: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There seems to be a decent amount of interest in moving to C99 as our
base level of C support due to the many features it provides.  Let's add
a test balloon to make sure we haven't accidentally excluded any
systems.

Changes from v2:
* Avoid setting the main CFLAGS to avoid breaking FreeBSD.
* Set SPARSE_FLAGS again since it's now necessary with the main CFLAGS
  not being set.
* Add a mention of "-std=gnu99" to the comment.
Changes from v1:
* Don't modify SPARSE_FLAGS since it's unnecessary.
* Improve commit message to explain why we use -std=gnu99.

brian m. carlson (1):
  git-compat-util: add a test balloon for C99 support

 Makefile                            |  2 +-
 contrib/buildsystems/CMakeLists.txt |  2 +-
 git-compat-util.h                   | 13 +++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

