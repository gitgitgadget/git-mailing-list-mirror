Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6096C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 02:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbiAKCTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 21:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243991AbiAKCTG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 21:19:06 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C38C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 18:19:06 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 913B95B227;
        Tue, 11 Jan 2022 02:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641867545;
        bh=YiMgJ0g+IwTuIQnQMrOIhYk3I0BD6/sJszzglZp1W4Q=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tpQI3is3kcP/nyaWkHmElq1It5NSN06UX0CHW2vwZUjYX8DZZd6y+bHBWHbaKamDM
         /Bk2t2mxGabhubvcdh1oET7X+UCTTdg645/x+hUgwKvH41QkyZOaKfwKPFlkw/5hL6
         NzFKxEhrfFhhucOOpLmxT39KG+nHAcepDZnSWBe2EPKgNBfrvYvOGg4l+2Aq390xXl
         KSAFCrnYyAXsNEA/jF6R0AMf6YH15opbprYI+aRwysB1/zs4IrPU+sE2e5x5GAAqq1
         Y90EG16tnwKs53WrVHLVBxnO5a+B2EclvN4TDd0M6zB7Cmk+fkjADW5TQC7TsCo8Wi
         f3adHvMX5FJBuyZGWH/8QeGn1dPNfckiJe5mHARXsoRjpPCL/FTtdpyY4tEnpwgFJl
         GBwlaXihzyjUk2fQ7NgadJDkEQul4CzxuEwfvCMKbVsSWTrM0pYIseOXqfj6yLaPK9
         K2BCEUgDIfHXg43m032MYng+QWJDZ4z27mjIAJIK7yaiXf+4Ax8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 0/2] Improvements to tests and docs for .gitattributes eol
Date:   Tue, 11 Jan 2022 02:15:05 +0000
Message-Id: <20220111021507.531736-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb
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

I tried to make the docs as specific as possible, since I needed them to
be specific and accurate here, and I felt like speaking affirmatively
about the behavior would be clearer than speaking negatively about the
behavior (I tried both).  I would of course be delighted to hear
suggestions on how this could be clearer or easier to understand.

I realize that 2.35.0-rc0 has just come out and so this won't be picked
up right away, which is fine, but I thought I'd send it out
nevertheless (mostly so I don't forget).

brian m. carlson (2):
  t0027: add tests for eol without text in .gitattributes
  docs: correct documentation about eol attribute

 Documentation/gitattributes.txt | 11 ++++++-----
 t/t0027-auto-crlf.sh            |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

