Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A65C43467
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 19:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A523A20714
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 19:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VPDr3j+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbgJRTtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:49:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62634 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgJRTt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 15:49:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 73FF510FFB1;
        Sun, 18 Oct 2020 15:49:25 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=LtiCfcSykfJWemVW++l9OxmNM
        pg=; b=VPDr3j+IUO2EdjHk9AObjty/wjlGSg+hG2JaEhR/1cxQ7/+wUAMI3oTjV
        s3Yikpsv9TU0jm0xsgLIy7bjslEIV7G4R0xbmjST52qtlfA3a46YrMJ3Xjg/FG+7
        l2DKY7fdm/gSjxfSfZ+ocnmxpu6Eugbs/6s8jOfwCf3WJADp6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=HKjffBDkN/Xl886w66u
        o/TbSKuaVqYTKkx/z+tndmwsL7Z6CWYZ2dKxl85RqLMgVnjTP/BDH4ppctiPNzjG
        7ieb4bI7U9xngKi72H9jSf6+PcJcqUsxq3oYW/pHOEk+1gURCIG5LMH9w70Czf/1
        9LPVqjdLQOYHe6EliQg4RIjo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59F9C10FFB0;
        Sun, 18 Oct 2020 15:49:25 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9623110FFAF;
        Sun, 18 Oct 2020 15:49:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: [PATCH v2 2/3] Documentation: clarify and expand description of --signoff
Date:   Sun, 18 Oct 2020 12:49:11 -0700
Message-Id: <20201018194912.2716372-3-gitster@pobox.com>
X-Mailer: git-send-email 2.29.0-rc2-130-g9dc1ca14f3
In-Reply-To: <20201018194912.2716372-1-gitster@pobox.com>
References: <20201018194912.2716372-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 04EE18F8-117B-11EB-B537-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Bradley M. Kuhn" <bkuhn@sfconservancy.org>

Building on past documentation improvements in b2c150d3aa (Expand
documentation describing --signoff, 2016-01-05), further clarify
that any project using Git may and often does set its own policy.

However, leave intact reference to the Linux DCO, which Git also
uses.  It is reasonable for Git to advocate for its own Signed-off-by
methodology in its documentation, as long as the documentation
remains respectful that YMMV and other projects may well have very
different contributor representations tied to Signed-off-by.

Signed-off-by: Bradley M. Kuhn <bkuhn@sfconservancy.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/signoff-option.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-opt=
ion.txt
index d1c6713774..fbff8dd5be 100644
--- a/Documentation/signoff-option.txt
+++ b/Documentation/signoff-option.txt
@@ -3,12 +3,16 @@ ifdef::git-commit[]
 endif::git-commit[]
 --signoff::
 --no-signoff::
-	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
+	Add a Signed-off-by trailer by the committer at the end of the commit
+	log message.  The meaning of a signoff depends on the project
+	to which you're committing.  For example, it may certify that
+	the committer has the rights to submit the work under the
+	project's license or agrees to some contributor representation,
+	such as a Developer Certificate of Origin.
+	(See http://developercertificate.org for the one used by the
+	Linux kernel and Git projects.)  Consult the documentation or
+	leadership of the project to which you're contributing to
+	understand how the signoffs are used in that project.
 +
 The --no-signoff option can be used to countermand an earlier --signoff
 option on the command line.
--=20
2.29.0-rc2-130-g9dc1ca14f3

