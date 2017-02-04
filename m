Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D401FAFD
	for <e@80x24.org>; Sat,  4 Feb 2017 02:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbdBDC41 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 21:56:27 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35970 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbdBDC40 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 21:56:26 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so3459291pgf.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 18:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cO/qNPcfVi+F63hTHHTobNKUmV1GWHYq5Lh35FbVZpA=;
        b=RzjzUkjGCFYghSfnqyeQ6tQTijus7TYtriE0Gu7w5jG/w0WaS5AQ8dd9Z7MPIf7fxe
         yTepaEC3spzz1NjbJnpys2f/wTaMRigDtoNiKiEmhSrDs1escoAeYcbADKP7uzXmwyZe
         IgruqVjjt4W2k9dkrpQZ/nGMY5fzw1yxI6Wof3nmcgjDX1ULUvF1/yjtcReRH0Js6vY0
         FQpkqcx+1x1CaEFBZNRx5uuU4Z+UD5Hd0OjqeX4SamDem0xsfnZSQfeWL8Nq3DXrOY//
         BNoMiwoQbsWnPvFfhRhEb6L2chW2Xg6T0Ih2nRbUcNN7N/lo7sHkck7R4s7NQxKGp/Dr
         nNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cO/qNPcfVi+F63hTHHTobNKUmV1GWHYq5Lh35FbVZpA=;
        b=RpdpQLwiCinz4HcRWH9XeKKh95RC1OI7JBIOwDVjo+i4tz1iXJQxL4wz5rozOcneKF
         AJ1wK2n6i5SUIvWKykjE6bodcJO1TWDxfLnjwdwhVnpw1VbArpIj+cZuuGKmtXFdMu61
         CbxlmoMT9eoOwUaCu458n1CTPfqtGZPjWS7nIdz0sUvkLk5M4wmtdIJq6dfrDZIIteGH
         5SvnGQcajA6UW4YuY7+SxVFjJVQugdPOiGcX726RvSuD72zbYt84HouVguZUGszXrO97
         QvHZ0AnTL5gocDKBQOK2zMy001aaQqlOj62R7fbo7UCEnMOxsmOCRtN6zGGJR6nTcE3L
         TkMw==
X-Gm-Message-State: AIkVDXJbp0JMUJPdAI0ZMVSheNxtJjtKSTSfO/L5NQfAlfJdeat8NYlvaNliOIP2U8DoDQ==
X-Received: by 10.98.10.69 with SMTP id s66mr303935pfi.146.1486176985509;
        Fri, 03 Feb 2017 18:56:25 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id b67sm70195023pfj.81.2017.02.03.18.56.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2017 18:56:24 -0800 (PST)
Date:   Fri, 3 Feb 2017 18:56:17 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] Remove --no-gui option from difftool usage string
Message-ID: <20170204025617.GA9221@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --no-gui option not documented in the manpage, nor is it actually
used in the source code. This change removes it from the usage help
that's printed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 git-difftool.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index a5790d03a..657d5622d 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -29,8 +29,8 @@ sub usage
 	print << 'USAGE';
 usage: git difftool [-t|--tool=<tool>] [--tool-help]
                     [-x|--extcmd=<cmd>]
-                    [-g|--gui] [--no-gui]
-                    [--prompt] [-y|--no-prompt]
+                    [-g|--gui] [--prompt]
+                    [-y|--no-prompt]
                     [-d|--dir-diff]
                     ['git diff' options]
 USAGE
-- 
2.11.0

