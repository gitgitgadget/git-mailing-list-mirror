Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6B5420D0A
	for <e@80x24.org>; Sun, 16 Apr 2017 04:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbdDPEIM (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 00:08:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61637 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750928AbdDPEIL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 00:08:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99CE181F54;
        Sun, 16 Apr 2017 00:08:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=OQJV+xkLtu3aqho+LYj5ARBVGLY
        =; b=fx1Mver2M4os/+40DuoM9oBp1oqjs8u1mfzIt6Xd83nP2AVVvHBcnpk+qC4
        KEKRgrUJIllg/L6e0IipUv8f4+41esQMoWMSDblvC7D90YSBfrJlDHbem68M4JGa
        V4r3cNk9/XT5N3Yfg0g/7yvxxjCCoIHjfZa3Woefl4WGGioo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91ED681F53;
        Sun, 16 Apr 2017 00:08:09 -0400 (EDT)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EEEF981F52;
        Sun, 16 Apr 2017 00:08:08 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH] doc/revisions: remove brackets from rev^-n shorthand
Date:   Sun, 16 Apr 2017 00:07:57 -0400
Message-Id: <20170416040757.32104-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.12.2
X-Pobox-Relay-ID: 4CE662E6-225A-11E7-882A-E680B56B9B0B-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id; s=mesmtp;
 bh=OQJV+xkLtu3aqho+LYj5ARBVGLY=;
 b=iwyx3DzQzkkQ6Bx98HSJiv2qoGZjlae6cYqAmJOiADk8Nx6lnOEH0wonJ/aBEW18NcyXU4D2Qb8SaDwULEnjfGS/YbIafd4uQqN/IcfRva9MIpqYJOJ4XUYC2FBY6MWgjYaFbWx05NkRmBYva5314lBtKD3csAWW/Kn9oIEpgmY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Given that other instances of "{...}" in the revision documentation
represent literal characters of revision specifications, describing
the rev^-n shorthand as "<rev>^-{<n>}" incorrectly suggests that
something like "master^-{1}" is an acceptable form.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 Documentation/revisions.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 75d211f1a..61277469c 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -295,7 +295,7 @@ The 'r1{caret}@' notation means all parents of 'r1'.
 The 'r1{caret}!' notation includes commit 'r1' but excludes all of its parents.
 By itself, this notation denotes the single commit 'r1'.
 
-The '<rev>{caret}-{<n>}' notation includes '<rev>' but excludes the <n>th
+The '<rev>{caret}-<n>' notation includes '<rev>' but excludes the <n>th
 parent (i.e. a shorthand for '<rev>{caret}<n>..<rev>'), with '<n>' = 1 if
 not given. This is typically useful for merge commits where you
 can just pass '<commit>{caret}-' to get all the commits in the branch
@@ -337,7 +337,7 @@ Revision Range Summary
   as giving commit '<rev>' and then all its parents prefixed with
   '{caret}' to exclude them (and their ancestors).
 
-'<rev>{caret}-{<n>}', e.g. 'HEAD{caret}-, HEAD{caret}-2'::
+'<rev>{caret}-<n>', e.g. 'HEAD{caret}-, HEAD{caret}-2'::
 	Equivalent to '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
 	given.
 
-- 
2.12.2

