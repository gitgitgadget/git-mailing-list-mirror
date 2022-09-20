Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDEAC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 01:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiITBzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 21:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiITBzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 21:55:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AEF474E7
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g2so750557qkk.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UM4WWsbgPF1Dce1DxIp6hWtKm5kbA3RHmOFTesXRxH4=;
        b=JdunaTmhQ9e/uhqio8A7HWBaHRDF329LwFOwlE+0YeMRMIJz1Jm+11cXjs0TgmwpCB
         SZ3xXbg8/81qv1JOfXcwGK6OolpghU+Q1wEMkqfBOBByFpan8y+cN6wGaVuBEolsMIsY
         XKQ7oHW1XEn4AouctZ+Z0CjPQi/4yn7zfDPfft8rGrQdB2vnsx2Z1PDdSCQbBjYr0xAU
         SlTu8u0Gohgz8WB+m0GKTKtlWgKXSUBzp/Bz1Bg59nITam/TA432cukviFpOKJIx5Y6e
         qy3ksvPmfsf/7O78hT478v5ydjyPS1g/XscM62O46069vFc+1rgJdShFF2JnVOEoFbha
         xE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UM4WWsbgPF1Dce1DxIp6hWtKm5kbA3RHmOFTesXRxH4=;
        b=MjUkLiLIHrXNgTMEWG0+8Jale9ZfdmLgdtP7W62Wm4XhNJ9wn7L2fu0zRgwsh8NGwk
         huF0sh1OTycgbjK2x2b7M/8y07ERX2oRmv1fPIy1hgjHeyoBLLFGeOZ1ryrOHkNbJLvi
         Ee9R+K748xixOqLec/5J+1hgeuEi2J9/VYclwzcDZiYNqNqBkU5eDQ0/2IE+Rpp8aB7W
         SJ6o12tWWXanrHBS2FPHl3rEdC3o5NLUzvf8QcOXDpOtD9Ti0DFCofHpvWetR/0stP2g
         He8d0wToNkGInL6jcLiNtc5aLtge8UIxVigefuYJzJihvu3Okb84npdaLwibSE2/UYkx
         EXeQ==
X-Gm-Message-State: ACrzQf3ZD9cjYXlMMSW0nWY3Boo2jV9LT4rO53hEMue2vaCLPNSr6iap
        cNJSeE/OP47tGG2CWvEdQ9ih5MM9KEj2Sw==
X-Google-Smtp-Source: AMsMyM6+YUkiEtHN5lMO6Z63qku0Jf00GmZmBkRXLKiZ8N5LqjlMksUYJBwAvY3H3xwOIKpYDAXq4w==
X-Received: by 2002:a05:620a:404f:b0:6ce:8c88:406d with SMTP id i15-20020a05620a404f00b006ce8c88406dmr15200073qko.358.1663638941348;
        Mon, 19 Sep 2022 18:55:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x8-20020a376308000000b006bba46e5eeasm91179qkb.37.2022.09.19.18.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 18:55:41 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:55:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com,
        gregory.szorc@gmail.com
Subject: [PATCH 1/7] Documentation/git-multi-pack-index.txt: fix typo
Message-ID: <3a3c7db81ed16b73a5474f6795afd5d3a36d381b.1663638929.git.me@ttaylorr.com>
References: <cover.1663638929.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1663638929.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the extra space character between "tracked" and "by", which dates
back to when this paragraph was originally written in cff9711616
(multi-pack-index: prepare for 'expire' subcommand, 2019-06-10).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index a48c3d5ea6..b4a2378cd8 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -70,7 +70,7 @@ verify::
 	Verify the contents of the MIDX file.
 
 expire::
-	Delete the pack-files that are tracked 	by the MIDX file, but
+	Delete the pack-files that are tracked by the MIDX file, but
 	have no objects referenced by the MIDX. Rewrite the MIDX file
 	afterward to remove all references to these pack-files.
 
-- 
2.37.0.1.g1379af2e9d

