Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E2B20133
	for <e@80x24.org>; Fri,  3 Mar 2017 19:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbdCCTTw (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 14:19:52 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36749 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdCCTTv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 14:19:51 -0500
Received: by mail-pg0-f66.google.com with SMTP id 25so13495293pgy.3
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 11:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SngOUycBXJscwmFYz4grqDhJbYvxvXYJ2Mi4tSJTHhw=;
        b=O9Pf5KWxSdMEnozTjEJC1uKInE2O97dyrnBQ5+uy3fb5hpoBIxOZNe3ibjOImETd4g
         /z4i+TZOLnX8Cx+8vAHj79cqXs5GuosWJKXdxk9Y0Ut+s/dnCCESk23wrNVB+qSPzWZh
         76e1MMFj8hKxBGvpQPZC3ovGc083qeVcE92arBjr043PwDG+sNuOu3K7FVigte0xeZ80
         dJGmN5rJk0ByMZCX0gMZ/nZaxnPHooRB4c+lDpy7/pzHlr3/5vUOjH7HS+/SIpsbeo2z
         j/eAeRKWZsHMkJ8G65CW32MBdPxoH9ZjaskxSz7/ncmOuGwhjOqNU9YhcYgBkeI/eHUl
         QpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SngOUycBXJscwmFYz4grqDhJbYvxvXYJ2Mi4tSJTHhw=;
        b=J0pTLE+rNdepNWJ2EhcqrANQ6bbORuc7tU4RO0EcIMQPhKTqjOuvQci0tN6Gl+gEQ5
         eH/4YMRhcxdq7X3Bt5zcfqK9NmnYXTZp/VLmnv5C2bT4Iplo7t0X6td6H8NxgdzrLKV1
         FoKo1UKsT6VQgdZV1Gz/XS8PSrrhYbK21d2WPwrMMuixyl725q8TyDtKEqOjT3Gl2FHn
         EEv7bRpHCXSslgi8kjEjgXQE657wLOuaPARg/Occh2Nh25xFICMUiZj7beNspXUxBJ5J
         zu9VdEid6vUtg4lAFwfV1u/neK+jbeDnQsnyP7yA83irjeojFv012gHe7Ozi49M8eVJb
         4RDw==
X-Gm-Message-State: AMke39lB3F2BOpwmiyFUHya8mzLskBOKejitB05wleKi6QORJ+lZrGnUc1G/FcVpJKeHJQ==
X-Received: by 10.98.79.150 with SMTP id f22mr3546091pfj.55.1488548445757;
        Fri, 03 Mar 2017 05:40:45 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id r7sm23667037pfl.25.2017.03.03.05.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 05:40:45 -0800 (PST)
Date:   Fri, 3 Mar 2017 05:40:43 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 5/5] Remove outdated info in difftool manpage
Message-ID: <20170303134043.GA6281@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When difftool was rewritten in C, it removed the capability to read
fallback configs from mergetool. This changes the documentation to
reflect this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-difftool.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 96c26e6aa..a00cb033e 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -105,9 +105,6 @@ See linkgit:git-diff[1] for the full list of supported options.
 
 CONFIG VARIABLES
 ----------------
-'git difftool' falls back to 'git mergetool' config variables when the
-difftool equivalents have not been defined.
-
 diff.tool::
 	The default diff tool to use.
 
-- 
2.12.0.5.gfbc750a84

