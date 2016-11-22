Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267371FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 20:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756486AbcKVUOx (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 15:14:53 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34432 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756151AbcKVUOs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 15:14:48 -0500
Received: by mail-pg0-f43.google.com with SMTP id x23so10904584pgx.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 12:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yFSksqXxCfLlbblrZSFqIkXnUJYKI2GxP5O70xbR3kA=;
        b=insYuyCnh+enZHAm2eD/h3PO7atSxarSOjSGO9pnKtAuYPTHYXrWqnqB1SyLX/a66t
         kCMNjO272SnElW/K3qkDd8RaEtKsDDxP5EexbDdt+ijsaQwnh4PI6CXmHkvENqX6LFwh
         Mu3qmOSy+iNTZHjb0i7ZwsNtVuX48JmBOlF+y1Njsh6wdRrhTffIy8G8KX0+Ph7DFgoX
         xPbLMhR2mWw8NwpwNcVqI1nZigSE95Xy7xt7TvEx2uy0PxivrRHtP0uIC+QSJOpuVeY9
         vp/imJpqdFWwVV/h1ZRhnZ6hnbqiAxQkipIvNkATqDqdfD3YA49qZ9gaGzQrZhUmo69h
         iRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yFSksqXxCfLlbblrZSFqIkXnUJYKI2GxP5O70xbR3kA=;
        b=UihquMenbrhC0laZG4/q/736OarBXjAkZUc5ryTPcntoObIP36yn8hk9lDIe+cl8AF
         HvZhKVpDZUp5+ta1Elh75zJX1TilsQBAtg4GHeQW6BD/IcBO89ETBmR1b4FW0Xuzpcsh
         ABaDgFiP0t3iiKnFMtvQ1Naxr1HFpsjaIZPRVTIhyrVw+YBXAkmi0/Jw79thhp28KOes
         ZZ8Frpaett+TrLFN7UFmrltfcExmJrt4WikeTXcBegNjIGKotrstyisLg+wP2B7CjfeP
         hCDyrmF25C0OghUcOwkMkc5886H6YNQigMvqws8sEx2DTcewzfEreweyu/JuqLJlIEqY
         Uf8Q==
X-Gm-Message-State: AKaTC01FVFnP2DRYfVnv7CQUb/7L7F0YlNoDuEJV613aCPd6y5OEB1K+51e6tnqbq+3v/Eya
X-Received: by 10.99.161.2 with SMTP id b2mr48049535pgf.2.1479845687763;
        Tue, 22 Nov 2016 12:14:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3d4e:3f15:a371:dcb8])
        by smtp.gmail.com with ESMTPSA id v77sm47060206pfa.85.2016.11.22.12.14.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 12:14:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 3/3] submodule-config: clarify parsing of null_sha1 element
Date:   Tue, 22 Nov 2016 12:14:38 -0800
Message-Id: <20161122201438.16069-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.4.g3396b6f.dirty
In-Reply-To: <20161122201438.16069-1-sbeller@google.com>
References: <20161122201438.16069-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-submodule-config.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 8285bcc605..2f2eda377f 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -56,8 +56,11 @@ Functions
 
 	The same as above but lookup by name.
 
-If given the null_sha1 as treeish_name the local configuration of a
-submodule will be returned (e.g. consolidated values from local git
+Whenever a submodule configuration is parsed in `parse_submodule_config_option`
+via e.g. `gitmodules_config()`, it will overwrite the null_sha1 entry.
+So in the normal case, when HEAD:.gitmodules is parsed first and then overlayed
+with the repository configuration, the null_sha1 entry contains the local
+configuration of a submodule (e.g. consolidated values from local git
 configuration and the .gitmodules file in the worktree).
 
 For an example usage see test-submodule-config.c.
-- 
2.11.0.rc2.4.g3396b6f.dirty

