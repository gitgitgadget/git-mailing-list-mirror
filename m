Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A47261F404
	for <e@80x24.org>; Sat, 16 Dec 2017 08:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750987AbdLPIOa (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 03:14:30 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:41806 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdLPIO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 03:14:29 -0500
Received: by mail-pf0-f181.google.com with SMTP id j28so7631157pfk.8
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 00:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0POLs3MtPfqt5xHA7sQ/+U49GNpxgxCbsAprMlxeGAU=;
        b=r0j+PVUkRd56PFG9NrI6FT8pet2dPi1a5NswS53VHAlSq82REsI5TWIFt/+sDnlBwo
         +jFsCZnL2xHqqgrK5fZbdwC5cOwl5HgMyKpchGLZLwvGEjljk1PTmy+5Hjpc6JVqiZ5T
         UhNL2A0Htq2WiL5g6fud3vEc7DW2QnFH+k/ilSubLZ6OKSXPzdAT7N8lGTkDYmQQOW4B
         xJhGGmlzadQ/r+S90LnYHyZHj21+j+aqV9GATZe+MgtysiimdZDKL7dSR2LzZBGXoAal
         wmU+7H00xD7wRVtruTCr/ZJ4NDujX9iZXMXi2h+Q76TEMSMs4+8MomDKLyQMtcAqIZa7
         Ea+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0POLs3MtPfqt5xHA7sQ/+U49GNpxgxCbsAprMlxeGAU=;
        b=HU24a9YvL8s5HZEF/BNJz0f2BbXg5DwQv/HTGd2/tEcFf9i/fAbfHXlszB2we/bCQ3
         icBkXl++XEuElaG03t/qglQz2P+FZggqV3NNX04y6pUkWtnMnAKBIFS1PADgNgywcSOM
         5I13ldS1THST5M3rKW1c4vKEeAa4Vgy9/b5BQHv9m4o894j3yWkdwRySXgIGjPRV9B/H
         Q1Xa42w9pAIfT2pxR1N6hH96RaGTYqG24bFQW7Ot06nibptrrafCWABsYetDPPeUFJC4
         9H0kbdpkgxjTdxtOlc47w7oFzlQHcdrd/3T/M2r3BGUqjeDGI8EAtgDa2trHuwwMVbQy
         c7Yw==
X-Gm-Message-State: AKGB3mKDLETFe23gd/lIMSepd3ujNBhLbcmaXW3vcdHCoo34a4JRLEYg
        81jqAeJpnhx7cBBFYEyrq0ft/Gm1
X-Google-Smtp-Source: ACJfBos09csBp58Mlc2ciMOZ+ahI0fxfznIYq+lqRDLHanfrwnXztv7Y7TEbaC5//UuCmFNZvX3Img==
X-Received: by 10.98.28.5 with SMTP id c5mr15803119pfc.154.1513412069230;
        Sat, 16 Dec 2017 00:14:29 -0800 (PST)
Received: from localhost.localdomain ([117.209.230.129])
        by smtp.gmail.com with ESMTPSA id b127sm13410307pgc.70.2017.12.16.00.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Dec 2017 00:14:28 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v5 0/1] clarify about @{-N} syntax in check-ref-format documentation
Date:   Sat, 16 Dec 2017 13:43:48 +0530
Message-Id: <20171216081349.10431-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c
In-Reply-To: <xmqqa7ylur1i.fsf@gitster.mtv.corp.google.com>
References: <xmqqa7ylur1i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was previously [PATCH v4 2/2] of this thread. It has now been
detached from 1/2 as it got merged to 'master'.

This patch applies on top of 'master'.

As this is almost a v2 of the v4 2/2 I'm comparing the changes with
v3 2/2 of the series. Apart from the changes shown by the below interdiff
the commit message got changed,

--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -78,20 +78,22 @@ reference name expressions (see linkgit:gitrevisions[7]):
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
 With the `--branch` option, the command takes a name and checks if
-it can be used as a valid branch name e.g. when creating a new branch
-(except for one exception related to the previous checkout syntax
-noted below). The rule `git check-ref-format --branch $name` implements
+it can be used as a valid branch name (e.g. when creating a new
+branch). But be cautious when using the
+previous checkout syntax that may refer to a detached HEAD state.
+The rule `git check-ref-format --branch $name` implements
 may be stricter than what `git check-ref-format refs/heads/$name`
 says (e.g. a dash may appear at the beginning of a ref component,
 but it is explicitly forbidden at the beginning of a branch name).
 When run with `--branch` option in a repository, the input is first
 expanded for the ``previous checkout syntax''
 `@{-n}`.  For example, `@{-1}` is a way to refer the last thing that
-was checkout using "git checkout" operation. This option should be
+was checked out using "git checkout" operation. This option should be
 used by porcelains to accept this syntax anywhere a branch name is
 expected, so they can act as if you typed the branch name. As an
 exception note that, the ``previous checkout operation'' might result
-in a commit hash when the N-th last thing checked out was not a branch.
+in a commit object name when the N-th last thing checked out was not
+a branch.
 
 OPTIONS
 -------



Kaartic Sivaraam (1):
  Doc/check-ref-format: clarify information about @{-N} syntax

 Documentation/git-check-ref-format.txt | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

-- 
2.15.0.531.g2ccb3012c

