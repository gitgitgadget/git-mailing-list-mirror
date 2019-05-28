Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6A31F462
	for <e@80x24.org>; Tue, 28 May 2019 12:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfE1MNY (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 08:13:24 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:59701 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1MNY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 08:13:24 -0400
Received: from localhost.localdomain ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id Vayph2doDWIpcVayph6wwa; Tue, 28 May 2019 13:13:23 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8
 a=VwQbUJbxAAAA:8 a=KaBGzcqrvFpBx-mTBmcA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=QEXdDO2ut3YA:10 a=j_Tf7YO6MbsA:10 a=xts0dhWdiJbonKbuqhAr:22
 a=PwKx63F5tFurRwaNxrlG:22 a=AjGcO6oz07-iQ99wixmX:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Subject: [PATCH] doc branch: provide examples for listing remote tracking branches
Date:   Tue, 28 May 2019 13:13:15 +0100
Message-Id: <20190528121315.2604-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.22.0.rc1.windows.1.33.gc7da05f206
In-Reply-To: <CACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S+hiXBoUGQ@mail.gmail.com>
References: <CACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S+hiXBoUGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNfOs452x/55bGia5TIZJKkn+VwaHPh/mLUYhc+ucZIeCLquwdgwK/JZTWIWNOitZzLgRJYFve3xZULyt6QLHL1NLbV9/pUvUBB4Vn4kNq3kiXuSuP/R
 0ozd9SKpCtuSvlMyRL36RFxs9UdT0nlUz2uAN6y1LN/WPCPOt+3XnngPCcPmSWXi5uUPvI++ysdtqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The availability of these pattern selections is not obvious from
the man pages, as per mail thread <87lfz3vcbt.fsf@evledraar.gmail.com>.

Provide examples.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

in response to 
<CACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S+hiXBoUGQ@mail.gmail.com>
https://public-inbox.org/git/?q=%3CCACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S%2BhiXBoUGQ%40mail.gmail.com%3E

to: "Git Mailing List <git@vger.kernel.org>"
cc: "Duy Nguyen <pclouds@gmail.com>"
cc: "Ævar Arnfjörð Bjarmason <avarab@gmail.com>"

 Documentation/git-branch.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 3bd83a7cbd..7ed91f1be3 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -314,6 +314,18 @@ $ git branch -D test                                    <2>
 <2> Delete the "test" branch even if the "master" branch (or whichever branch
     is currently checked out) does not have all commits from the test branch.
 
+Listing branches from a specific remote::
++
+------------
+$ git branch -a -l '<remote>/<pattern>'                 <1>
+$ git for-each-ref 'refs/remotes/<remote>/<pattern>'    <2>
+------------
++
+<1> This can conflate <remote> with any local branches you happen to
+    have been prefixed with the same <remote> pattern.
+<2> `for-each-ref` can take a wide range of options. See linkgit:git-for-each-ref[1]
+
+Patterns will normally need quoting.
 
 NOTES
 -----
-- 
2.22.0.rc1.windows.1

