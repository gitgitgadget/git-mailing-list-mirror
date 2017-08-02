Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A5920899
	for <e@80x24.org>; Wed,  2 Aug 2017 18:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbdHBS7F (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 14:59:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35231 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdHBS7E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 14:59:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id r77so34756wmd.2
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=instituut-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pMR1rKF/5WC+LBuYFiMr4Wfb80Xf8V/uTA5wGjIgZyE=;
        b=fTFOzpLwpQeeKoSQHUKxDp+RMoivRUSVCLHNUoMXErHoWZHmTtbS13PuN1Nr4jbQ/x
         fVyXgyqoW+LPbQh9DZfxII3Ru8HJGMq11rMAyUxwEbAb3Wp6/CKSsZchAkSE691h9Ofp
         qAvKiCn6qxKZys8BcL2G85d/K7BiubgjJLaWDHDOKET53LuhmgSvkwNaiIRJUwmAvfyH
         UJYm8ftsk15EagPIIAipD5oFRi6cKkZIApdyBfPHw/fo3psaatAshBjgs2GvefCHTzoP
         emCfFKpf3Bbf40ImHDVtqE5bBJkKs9uHTKZhBfn3bN1jBybtE9dXse1H+mJQRlxxBBMu
         xfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pMR1rKF/5WC+LBuYFiMr4Wfb80Xf8V/uTA5wGjIgZyE=;
        b=kaFOGYY0IDdV29GxNAp2HxwrjcmqGKaJYRjCGwBzV9Kn91k+d5KIbXjCbmAu4OPQgs
         CW8tyV6qMGtElUhhpiou61NOYag3tSWVPzku7lQu949ccQF42um3k5HFD+BjB484SJQs
         gEczqNL9Pr7zHCPqPwLWqmrPZvNbXs8rQz8FTnTwEzYDJ3yQrRvr7OXnj1aePcgYHj9a
         Y0O6EZXHQBoOL9IbwHSA+ATbLeXlk6/r5Dier7ghi+bAzgLOTrYveni13F2bO4CWkTNL
         lFkmGmKTOK4hOcu0yZ9rfMYzwrG59zF0l9N7py3JViW0XZeJrEhDezAISAkxipM1mMxZ
         tlmQ==
X-Gm-Message-State: AIVw112Ccxk7W1wlmI4F+3oi/UKYC68WllNZKn25/uLYcA6k9CIkPcs3
        JYqPEgaju8cLfYqgkY8Kag==
X-Received: by 10.80.148.107 with SMTP id q40mr21356705eda.28.1501700342951;
        Wed, 02 Aug 2017 11:59:02 -0700 (PDT)
Received: from localhost ([2001:67c:208c:10:3dc6:a9a2:10ff:6f76])
        by smtp.gmail.com with ESMTPSA id f29sm18870edd.23.2017.08.02.11.59.01
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2017 11:59:02 -0700 (PDT)
Date:   Wed, 2 Aug 2017 20:59:01 +0200
From:   Job Snijders <job@instituut.net>
To:     git@vger.kernel.org
Subject: [PATCH] Add 'raw' blob_plain link in history overview
Message-ID: <20170802185901.GA27243@Vurt.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We often work with very large plain text files in our repositories and
found it friendlier to the users if we can click directly to the raw
version of such files.

This patch adds a 'raw' blob_plain link in history overview.

Signed-off-by: Job Snijders <job@instituut.net>
---
 gitweb/gitweb.perl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3d4a8ee27..ad79c518e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5961,8 +5961,11 @@ sub git_history_body {
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype) . " | " .
-		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
+		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype) . " | ";
+		if ($ftype eq 'blob') {
+			print $cgi->a({-href => href(action=>"blob_plain", hash_base=>$commit, file_name=>$file_name)}, "raw") . " | ";
+		}
+		print $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
 
 		if ($ftype eq 'blob') {
 			my $blob_current = $file_hash;
