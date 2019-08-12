Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A9FF1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 17:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfHLRRz (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 13:17:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34947 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLRRy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 13:17:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so8083906pgv.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 10:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYVpc2q69XG5nuwkx3RXGrX049kaOSGubqIrFj23yQc=;
        b=h0tJT5gF5JjQXhEUQlUvFBkFMOVq+tXW3qIl+ZNbDpwmQgHDagVnZUEvY0hVORydDv
         qPtj88vzOPfWo7LU3fmAcOWBCkIFMulze18L8Xa3Qpk0jhJYYhENjdBGMFs4fiqSMeET
         z+iU6S3OuKmPh7Jn5bSkHkZ3Wkqvr6DuIPeeHK+A/np2/Bf3FrrajNeFxY9CgWP/uQa8
         E1qbkq8LvhPLqppbcBF4RJMfhrLSiV11+UpQyoMrA2hFc33oXjRjGmlrwheaALmuph6Z
         Da7umasPBxW5EIL2uBIyAuJsEZwg2laCtdad3odn1JjN+9XtiYACudm53JS6w+Aau3fD
         Buzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYVpc2q69XG5nuwkx3RXGrX049kaOSGubqIrFj23yQc=;
        b=GRMBWUZoQvExvQ6VX8VyzWk9/U7Zwp5kjtV0H+UD32l4GqyhVy1UDDVOci2VUbzbrQ
         BEs9iX03FWQ7eDeSGVfhz7E/UKBLazQsA5YAPH/UAMPeHhzegR7fArw1vUvT9avhtuRu
         q7bWSGk/ptzVlINB8YhB2zRvEnCMIZE/ov76wi7HC900hzgX5ZZgHj2x5slYNGT4THF4
         CsDyoEILbcgGSZ4yZZDBHlf9lTvpr73+B1YD7/dakRw+xrqiIzlVpYFz4OFWk9Ei6jB7
         TiDYyn0/9R+jha7ALWDKUdVNOOvZ2/JFx0sKN4ILhCcPHibg7HzgdXD/KBljOX56srhy
         jE9A==
X-Gm-Message-State: APjAAAV70o2Shl0xFaPsLp+KvOjuj7Loi4teMCNjz0lWTRarSlEY463g
        LUYXT1xdP4ilUgrUynkaeHqODKNy
X-Google-Smtp-Source: APXvYqxMrVDEbReR4jvrBaoUr4skAiCShoNNWLR/kvmFARpGuElCxaZj0KA9o3Pe3nskhqv5QOTmkg==
X-Received: by 2002:a62:f245:: with SMTP id y5mr3035606pfl.156.1565630273706;
        Mon, 12 Aug 2019 10:17:53 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id r12sm89134361pgb.73.2019.08.12.10.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Aug 2019 10:17:52 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Joachim Klein <joachim.klein@automata.tools>
Subject: [PATCH] git-fast-import.txt: clarify that multiple merge commits are allowed
Date:   Mon, 12 Aug 2019 10:17:47 -0700
Message-Id: <20190812171747.30838-1-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.661.gd1c9dd82fc.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The grammar for commits used a '?' rather than a '*' on the `merge`
directive line, despite the fact that the code allows multiple `merge`
directives in order to support n-way merges.  In fact, elsewhere in
git-fast-import.txt there is an explicit declaration that "an unlimited
number of `merge` commands per commit are permitted by fast-import".
Fix the grammar to match the intent and implementation.

Reported-by: Joachim Klein <joachim.klein@automata.tools>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-import.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index d65cdb3d08..28b447a3e6 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -390,7 +390,7 @@ change to the project.
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
 	('from' SP <commit-ish> LF)?
-	('merge' SP <commit-ish> LF)?
+	('merge' SP <commit-ish> LF)*
 	(filemodify | filedelete | filecopy | filerename | filedeleteall | notemodify)*
 	LF?
 ....
-- 
2.22.0.661.gd1c9dd82fc.dirty

