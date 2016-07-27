Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C6B203E2
	for <e@80x24.org>; Wed, 27 Jul 2016 08:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbcG0IeT (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 04:34:19 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36195 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbcG0IeR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 04:34:17 -0400
Received: by mail-pa0-f66.google.com with SMTP id ez1so1372218pab.3
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 01:34:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Dxf4Kjmp6rZ68KSzqcccYuH3Ml56UiHJrpEI6SZhLSo=;
        b=qXVyXka844iLbIuZSZe0TWERyVC9HJiBngi5U0yPsTJmguwc3Vv1b3HIdDoZOgIkdl
         XvQG5GXuYdNHkfKkVLANoVFxMh74NPTdrpgupUeNVD9t3Qk5U3ONbsKyw0sThnx0QXno
         Pe9YpOFZtfheExZHfdKcGz+tCNaeyrKdk1ZTODopeB01MAEOBfqbk1ZmlH0TPkvfeNmR
         rvlA3Y7Lqbmg1NJvWruHOPajwJJB6GaxNB6LsNN6MeXHfVGRvRAzplsEihSe6D0+i+5v
         4qsGfu9SxQ4cby1g1Yb/CyahkmsiIxzmtR+LTPeO5hzxDBiyvgvH9zrY5iDBDbUbgREJ
         u5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dxf4Kjmp6rZ68KSzqcccYuH3Ml56UiHJrpEI6SZhLSo=;
        b=KaManJ/FrfoV0weQgYlB2LNiSTuVZlLdyB+9fGiDnBfUNGmiXEUKHrbTFfPHUSyHXZ
         SZtUXhmiRQ2cPqe1DQ0ymj8VmD2o3KOwP8vb30mFwtkWBhL5drtGfdQiOVSmXmliUMKE
         wd7fA/UHGh8v3d1lrSGyoA8jBZnGVhDia2vKBHUeKMgByNP0NGQNKRKczbaW9KmHX/St
         tBZRC1lUA5wuUpT2IzmsAcqgBntbew0jKIwIzvGAYexdXATHCgaAhFQf5lDJLwMt5g37
         mCLzqxd6KlvSGgjtCBL3rELQSWQUjd/cHDie/Uhs5vlhvblkZofyl2hW+OgidNRPZpv7
         eKxQ==
X-Gm-Message-State: AEkoouvCovsXPr1yDlxQaG2kvjcJTrTO3TDY10Dj21/Gv02j81+lIYURKlA3CbT/+wJI+A==
X-Received: by 10.66.242.166 with SMTP id wr6mr47370157pac.147.1469608456681;
        Wed, 27 Jul 2016 01:34:16 -0700 (PDT)
Received: from chrisp-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by smtp.gmail.com with ESMTPSA id n69sm6951298pfa.77.2016.07.27.01.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jul 2016 01:34:16 -0700 (PDT)
From:	Chris Packham <judge.packham@gmail.com>
To:	git@vger.kernel.org
Cc:	Chris Packham <judge.packham@gmail.com>
Subject: [PATCHv1] completion: add option '--recurse-submodules' to 'git clone'
Date:	Wed, 27 Jul 2016 20:34:06 +1200
Message-Id: <20160727083406.10241-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.9.2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
Hi,

I noticed --recurse-submodules was missing from the bash completion. This adds
it. I went for '--recurse-submodules' instead of '--recursive' as I seem to
recall the former being agreed upon as the better (or least ambiguous) of the
two terms.

 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 37888f4..7c06455 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1136,6 +1136,7 @@ _git_clone ()
 			--depth
 			--single-branch
 			--branch
+			--recurse-submodules
 			"
 		return
 		;;
-- 
2.9.2

