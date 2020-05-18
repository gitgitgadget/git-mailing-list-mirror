Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB7C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72C720643
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="APL8VuMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgERTho (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 15:37:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59501 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgERTho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 15:37:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D1564B068;
        Mon, 18 May 2020 15:37:42 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=HnKkr945xWKfFWdOaDXSRfyyMZ8=; b=APL8VuMP+X8SS/sPedex
        CqdUBSWV8KiM2xN77Q3dWwe+BPbM4VAqt+mLPsideAHM8+/dWO72eNzMefEdDN1e
        X5L92mUAq3Ml7wp86Z3fWnEyAG1Tz2FfcVqj/A6gshsT+yf1x3bGesKC8t3vgUl5
        DnMY/Ot8qjMr6Bz9DlU5b1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         q=dns; s=sasl; b=hBQlXXyjy9gSM300VtyqIwIIA1CoT+Ice9xenW0+KkXthx
        lFzgDKopu/XfiYVr4ibMZ+MFBc5wEIp3juO7v0YgIy3yfCffvkrXfdpEx1tE99Nr
        WE/DcJqr92KGFaBEhAx+pcXcmtkKbRzaAY2vFSVbzu2jPAajzNU/oHLVlStNE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 543AC4B067;
        Mon, 18 May 2020 15:37:42 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.84.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2C0E4B066;
        Mon, 18 May 2020 15:37:41 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH] git-bugreport.txt: adjust reference to strftime(3)
Date:   Mon, 18 May 2020 15:37:36 -0400
Message-Id: <20200518193736.19320-1-tmz@pobox.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
X-Pobox-Relay-ID: 0A0586C8-993F-11EA-A1A6-C28CBED8090B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strftime(3) man page is outside of the Git suite.  Refererence it as
we do other external man pages and avoid creating a broken link when
generating the HTML documentation.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Hi Emily,

While building 2.27.0-rc0, I noticed a broken link crept into the HTML
docs for git-bugreport.  I believe this change matches most of our
existing references to external man pages.

Some are enclosed in backticks, while most are not.  My first instinct
was to use backticks.  I avoided that to be consistent with the majority
of other references.  But I didn't look closely to see if newer
additions use backticks versus older changes do not.

The current "link:strftime[3]" tries to create a link to strftime named
3, which doesn't seem like what we want. :)

Thanks,
Todd

 Documentation/git-bugreport.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugrepor=
t.txt
index 7fe9aef34e..9edad66a63 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -46,7 +46,7 @@ OPTIONS
 --suffix <format>::
 	Specify an alternate suffix for the bugreport name, to create a file
 	named 'git-bugreport-<formatted suffix>'. This should take the form of =
a
-	link:strftime[3] format string; the current local time will be used.
+	strftime(3) format string; the current local time will be used.
=20
 GIT
 ---
--=20
2.26.1

