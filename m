Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B64E1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 18:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfGKShh (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 14:37:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35224 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729527AbfGKShg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 14:37:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so6898115otq.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9pvuGvRpNslkGgP35JYJXws3HGI7F+ZmzR838BHuEec=;
        b=pfgkNRiPhJ1iLPGVRbtdIcMlrYu9Mdqkw718vAWugznCYdN/TP1NipK43SkcvXQvTC
         zxpohQXmPQa+3aASn6TcO9caqFiG31V44/qa5242IoIfaimfmP5JFrCg+8DuKMhoeX5K
         0LXMQ7fGAtjLqTAMNhypvSMeC+hDTzfQvMeI9HnJz5K+d+8p4IY9OLGyGWBFiudOo08Q
         XX5hfBA/dX0HQY/TBj9O3fCUdcvqVF0kDWkZz+SsASYasS4y94jzMwQfnZYPv3qKiswS
         a1kVHmPLclJ+Y77NoPDtodByuHAGlRFuP1Bt5TxiK7IHxylBgAP1ZciF9tmEZikghwzN
         hjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9pvuGvRpNslkGgP35JYJXws3HGI7F+ZmzR838BHuEec=;
        b=UQpxxWBm4ev5l8xk11Q1vpun/u1+auVTMDjzIhegTZUSJ805Gvm6FMkIc1iLXJ5rE7
         /hhqHBryGPboRsWqu+jsNP+yjHdlIVurZA/pLxJCrjexZSN2QvSMUFCY7oJ5egurfQ70
         Fwg/S5jfqWQddxQQcC3ezFb6q3/I0CdaRDBJ2nKizuPdvlR8VWDwY70noBAkwaxqexBJ
         RO3DTepk/wbqNKKfKR8l9BARfw4FRCQgi40J8mm8QIYYhvAXN1IcIEQ6QbsAnJxfuHnt
         ++5aHXlz825jL997oH6X0fwh4HoeBjdoaQn93yykuBs4q9F3WwmVXH5QeTZG8lWAhmJ4
         ZkpA==
X-Gm-Message-State: APjAAAVj1e4bHscXAjdbqGxf3hqSssuUgDsysOm9/MeokHfJ+l9Y1al8
        vVaCTKEk8Pk9TOZD6NNveDNbN9zk
X-Google-Smtp-Source: APXvYqzs3cnKtF4gV5yeJk6d/MsDZCSQ6pf3reZKuFGi9e20VpInmq3OAOYbZe+2yoPxqKAl3kORbQ==
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr4448242oti.122.1562870256092;
        Thu, 11 Jul 2019 11:37:36 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5d50:4f59:ae8:3eb7])
        by smtp.gmail.com with ESMTPSA id h9sm2016646otl.51.2019.07.11.11.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 11:37:35 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v4 2/3] log: document --no-use-mailmap option
Date:   Thu, 11 Jul 2019 13:37:26 -0500
Message-Id: <20190711183727.8058-3-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711183727.8058-1-ariadne@dereferenced.org>
References: <20190711183727.8058-1-ariadne@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When mailmap is enabled by default or by configuration, it may be
useful to override the default behaviour.  Previously, it was
possible to enable the mailmap feature when it was disabled by
default or in the configuration, but it was not possible to disable
the mailmap feature when it was enabled by default or by the
configuration.

The previously undocumented --no-use-mailmap option equalizes this
by allowing the user to explicitly enable or disable the mailmap
feature according to their requirements.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 Documentation/config/log.txt | 4 ++--
 Documentation/git-log.txt    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 78d9e4453a..8a01eed46b 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -39,5 +39,5 @@ log.showSignature::
 	linkgit:git-whatchanged[1] assume `--show-signature`.
 
 log.mailmap::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--use-mailmap`.
+	If false, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--no-use-mailmap`.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b02e922dc3..b406bc4c48 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -49,7 +49,7 @@ OPTIONS
 	Print out the ref name given on the command line by which each
 	commit was reached.
 
---use-mailmap::
+--[no-]use-mailmap::
 	Use mailmap file to map author and committer names and email
 	addresses to canonical real names and email addresses. See
 	linkgit:git-shortlog[1].
-- 
2.17.1

