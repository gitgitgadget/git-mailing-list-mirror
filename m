Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21681F45F
	for <e@80x24.org>; Sun,  5 May 2019 16:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfEEQHP (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 12:07:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42318 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEQHP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:07:15 -0400
Received: by mail-io1-f67.google.com with SMTP id c24so9086138iom.9
        for <git@vger.kernel.org>; Sun, 05 May 2019 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SUCPUcvvbwIBA9rsZlrPzdV2UdlpMC2ciT7FyxtpIug=;
        b=NTjIo2QS5WCnrKjm/C9ZuBXGaZe2e37a4jHRkqg9ezDqTeHF7CbY7H4i3vKRthQiAr
         uTSMjAa1OIaqMFidwMWRQYw8iRwem9vysGWuRCRJ2ZhFDQqCxHKqvxfro0tyOgR/9Bs+
         n1pdjhQA6yiHwNv0nzWYfx3ZEkI128DBC/EiGtnYncbj2rw+ujf4AsjsH3Qa2x5Erijk
         Z3iW2BOsr4nM2K75Omyax5hNtZSwadC1AxQBcJyeZqYNnNN/zWmhggjR0yTjwXvP8UXG
         GaEwno0C8ySDDaaX+KPpQ/XoaU3ctfIaoX+MxagbcTR5IfpMLG4Jqko/KjvyEe1WacqY
         nfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SUCPUcvvbwIBA9rsZlrPzdV2UdlpMC2ciT7FyxtpIug=;
        b=SDe8nc+ujSUg1IQqzk9LuFyeXVvlGwFfsL0zuzpjS3PQ1DVJugs/MfqrscU+1Wt6PA
         ddRdW+LCqlb8FfOP4RGdMJy8R/dN2PDLXUdclczI7apBG3Vgeo6XI4w02rouY/2GpI9I
         ZdjowU5VYSaxpDGBXUCS2qlGR/WZqjJ6QDVLxH1ZjAWhhor2gj/7tnQ8G/Ci7JUmjb/i
         /aVfUX3B9wrCe4W+R9jR7ND6pM14C+rXXWb/wqtvGOcF33CTCCTnEuHt9qfJn42tpSXM
         xkL6fglDPQlf1G58Xjdzh3MyNuChxUt4Z3jKD/qOQ7XnXDbuXXp5mIq/cFLKbcjlqMgq
         asmA==
X-Gm-Message-State: APjAAAUJOLq0FP0B4D2b3eGR12vrwLR8Hw8yNPOX1iGGpfjOvVHX+TFQ
        S5cZOIKZO2lavDwPEUT9Mvloyp5v
X-Google-Smtp-Source: APXvYqwwp4tsDOl9x/NgQ/yFe61gB0+pxHugbRnIOmzgdj5mqIBL6FnH4Uqu4ekFtJMBPauE5iaeOw==
X-Received: by 2002:a5e:8b06:: with SMTP id g6mr12778648iok.27.1557072434384;
        Sun, 05 May 2019 09:07:14 -0700 (PDT)
Received: from archbookpro.localdomain ([199.119.233.193])
        by smtp.gmail.com with ESMTPSA id v1sm1575683iob.56.2019.05.05.09.07.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:07:13 -0700 (PDT)
Date:   Sun, 5 May 2019 12:07:10 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/4] revisions.txt: remove ambibuity between <rev>:<path>
 and :<path>
Message-ID: <e765c0c7b89fc9c6eb00ca4afef094c9c1e46a38.1557072286.git.liu.denton@gmail.com>
References: <cover.1557071877.git.liu.denton@gmail.com>
 <cover.1557072286.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557072286.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andreas Heiduk <asheiduk@gmail.com>

The revision ':README' is mentioned as an example for '<rev>:<path>'
but the explanation forwards to the ':<n>:<path>' syntax. At the same
time ':<n>:<path>' did not mark the '<n>:' as optional.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Just for clarification, the correct procedure is to include my sign-off
on top of Andreas' when I'm forwarding patches, correct? If it's not,
Junio, please take my sign-off for me.

 Documentation/revisions.txt | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index a38ec7fb52..82c1e5754e 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -196,19 +196,16 @@ existing tag object.
   Depending on the given text, the shell's word splitting rules might
   require additional quoting.
 
-'<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
+'<rev>:<path>', e.g. 'HEAD:README', 'master:./README'::
   A suffix ':' followed by a path names the blob or tree
   at the given path in the tree-ish object named by the part
   before the colon.
-  ':path' (with an empty part before the colon)
-  is a special case of the syntax described next: content
-  recorded in the index at the given path.
   A path starting with './' or '../' is relative to the current working directory.
   The given path will be converted to be relative to the working tree's root directory.
   This is most useful to address a blob or tree from a commit or tree that has
   the same tree structure as the working tree.
 
-':<n>:<path>', e.g. ':0:README', ':README'::
+':[<n>:]<path>', e.g. ':0:README', ':README'::
   A colon, optionally followed by a stage number (0 to 3) and a
   colon, followed by a path, names a blob object in the
   index at the given path. A missing stage number (and the colon
-- 
2.21.0.1049.geb646f7864

