Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909C2C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 17:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiG1Ruy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiG1Ruy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 13:50:54 -0400
Received: from impout007.msg.chrl.nc.charter.net (impout007aa.msg.chrl.nc.charter.net [47.43.20.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1AC18E1B
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 10:50:52 -0700 (PDT)
Received: from localhost.localdomain ([97.71.114.58])
        by cmsmtp with ESMTPA
        id H7epo19N2oB69H7etouzat; Thu, 28 Jul 2022 17:50:52 +0000
Authentication-Results: sunshineco.com; none
X-Authority-Analysis: v=2.4 cv=Kf3BDCUD c=1 sm=1 tr=0 ts=62e2cc7c
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=rP6RehhB1vzViJ0LBHQA:9 a=jYKBPJSq9nmHKCndOPe9:22
 a=AjGcO6oz07-iQ99wixmX:22
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eugen Konkov <kes-kes@yandex.ru>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] format-patch: clarify --creation-factor=<factor>
Date:   Thu, 28 Jul 2022 13:49:53 -0400
Message-Id: <20220728174953.66964-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.37.1.550.gb06344481a
In-Reply-To: <xmqqo7x9ch7n.fsf_-_@gitster.g>
References: <xmqqo7x9ch7n.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCntSXajsPrlA+NVMVWO8cpXwJETs4ZsIX7cFHVfHYUusibmVUZh29NZc1BgkCzsagw+1j+RFp6rhTVNA4n8s0jRQQEh4JZeonJKGudedGBLIiyNpGjC
 e69qYwXdDG6b1wh2K41ZAQDpgd135utUP8oCTIj5tEbbwUDPt5jhlQIpTVdZDrjN0hJdeDmCO9ysUki/Av9coKofM1fcIHkw7CHnpg76ZM2dO3x5XyGya57L
 6zv0SLg18ej4AVY5h1RJOqUFA6tN5v67F3+7dWkU/OVts5euiHbvCr/q6HqmwxjeOtjcPHBMxd2s+IZg4oWUFI2mL0gyIQ75RFFEEcf70PGMwQWTrDtD6gXa
 HVSnyL2h
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The value is not a percentage that ranges from 0 to 100, so stop
referring to it as `percent`; instead follow the lead of the `git
range-diff` documentation and call it `factor`.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is a sibling to Junio's patch[1].

[1]: https://lore.kernel.org/git/xmqqo7x9ch7n.fsf_-_@gitster.g/

 Documentation/git-format-patch.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index be797d7a28..e06475abcd 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -27,7 +27,7 @@ SYNOPSIS
 		   [--[no-]encode-email-headers]
 		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
-		   [--range-diff=<previous> [--creation-factor=<percent>]]
+		   [--range-diff=<previous> [--creation-factor=<factor>]]
 		   [--filename-max-length=<n>]
 		   [--progress]
 		   [<common diff options>]
@@ -321,7 +321,7 @@ product of `format-patch` is generated, and they are not passed to
 the underlying `range-diff` machinery used to generate the cover-letter
 material (this may change in the future).
 
---creation-factor=<percent>::
+--creation-factor=<factor>::
 	Used with `--range-diff`, tweak the heuristic which matches up commits
 	between the previous and current series of patches by adjusting the
 	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
-- 
2.37.1.550.gb06344481a

