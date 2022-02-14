Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE03C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 02:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbiBNCIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 21:08:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiBNCIt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 21:08:49 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614BA54BF3
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 18:08:42 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 34C005A092;
        Mon, 14 Feb 2022 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1644804521;
        bh=lf3/yCEm7kanZRS/bGdCxuAjyuGYC9dggp2dhjG1/eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=X8V/QepK0uISb9hdGvYZ9GkJUW2iwzM0Y52NMid84VwlfxBvi39IFfbPRRPLcu8bd
         MFSGQ8V9872GsgZiWxs+trAYB+NO6N2SEoPCR6OlvLJO96jm1q71bfNfeBIXyTRdn/
         FGuvveTBTIxm3zO2qLGsuBBRzzq2473IfgEhEjhZQ7JDXSOH3PSA1M344OPaqM5h9n
         NmOq8ZYKnizGMxI5gOwlCb52UJ1F+mqvh50S4hzhttSUvMeAgQuLnNA+/nVBhu7Ukh
         XBVxIDSDXzzh5fapbmJ1HlQ46NMO5JrQ4eA/tCENunkGqGhTTK56QHs6RSGl/FjRP2
         qE0YBd4UZoVLAZRrINLljTOIlBMM2ls159WsIAPZFx2c2UZVO/F+fiv7R7nts4GKGg
         372p0pU3GvxdOyIdHSCVPTpODsXfM1B2ZkHswSseFVUl+o8wQJVStnLQfGzxdvxORQ
         OYCHQvAvss/J2kgsTMZ5JaLwUP2xsbK7/3RhQrI1YqdPnOWzLNU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 0/2] Improvements to tests and docs for .gitattributes eol
Date:   Mon, 14 Feb 2022 02:08:25 +0000
Message-Id: <20220214020827.1508706-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb
In-Reply-To: <20220111021507.531736-1-sandals@crustytoothpaste.net>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was answering a question on StackOverflow recently about the
interaction between text=auto and eol, and someone pointed out to me
that what I had written, which was based on the documentation, was not
correct as of Git 2.10 (and more specifically 6523728499 ("convert:
unify the "auto" handling of CRLF", 2016-06-28)).

When I set out to document the behavior correctly, I ran into the fact
that the tests, where I looked for examples of how this behaves, didn't
have any tests for some of these cases, and so I had some trouble
documenting this clearly and accurately.  So this series basically just
adds some tests for existing behavior so we don't change it (and so I
could figure out how it works) and then updates the documentation
accordingly.

Changes from v1:
* Correct documentation inaccuracy with respect to text=auto.

brian m. carlson (2):
  t0027: add tests for eol without text in .gitattributes
  docs: correct documentation about eol attribute

 Documentation/gitattributes.txt | 12 +++++++-----
 t/t0027-auto-crlf.sh            |  6 ++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

