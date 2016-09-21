Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60FC41F4F8
	for <e@80x24.org>; Wed, 21 Sep 2016 11:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933629AbcIULon (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 07:44:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33479 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbcIULom (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 07:44:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id w84so8116566wmg.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 04:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=j3FoL86m4GNX9r+GEzxHrjtNJ8XoKwqv/d8rhHerdUs=;
        b=XI2sUXDWBNqRm6qa6JfH2AN/2/0AGCo8Jp7RpbKnZ5j8nonWusuWaARXViq8erhXBk
         Mna38Yo2WNUO8XEExQd7T3MdGgwokTY4R3h1nac0omoc6smgAa1JTQ1xFuka6oqKEa4J
         Eqx9X9dLA9vfDQ5/iWzsacMDcDuXP6bcwwaJlrB0eb+G4F2jtRlhAp0TxP7PeGIrfi0Z
         v0a+lt6JOIgUzCDbhc2BVr0MXv3jcwX6ALKOA7OBYH1/9HrUwBVbwV7B2s1UYsz7WyOB
         8FMx6GLkB7rx4T+WVKfW/DrnISuq5pkSaJk4VT97XAomcfQsKgDqZRAdOAqjY14yYlUC
         SPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j3FoL86m4GNX9r+GEzxHrjtNJ8XoKwqv/d8rhHerdUs=;
        b=d9bH0QGZgnGW4jfa2m5eYwzigK7FJduYHdXt2yehShDRvRAWeeAkYtx++GdsKZzDn9
         EKw4JElRJgDyzTKBrWL6rN8DFlOJEQLB8l4vFfj/UkX6Di0OT70BuzIYyD3ntverOg3v
         +jPdnoGyCyLvlIpNNFuEtGTR31pq5vaLE0TV867xvj0Srv6w69YY4WG1L4cWkKkuZs98
         htFYe2KY147Ia7Fh7MtP25Bu0LvOe9r4D0PZPF3wLiJyOD5pBIMvOy4gND9Rsm4UV1hr
         irF2vALlAJ/+ZQlFkebX3JNOe79aToTabYUFsDSwqfVtSnfHEmUnuWWA4LDpxWMSei3O
         msaA==
X-Gm-Message-State: AE9vXwN+ayqKYtqeJBkco+BkXeNBkO/cAi8aZ4V5AThbDuHVUrkbvQarc/6hFgicygTsEw==
X-Received: by 10.28.51.21 with SMTP id z21mr2661956wmz.24.1474458280745;
        Wed, 21 Sep 2016 04:44:40 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id au10sm33165171wjc.12.2016.09.21.04.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Sep 2016 04:44:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Kay Sievers <kay.sievers@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] gitweb: Fix an ancient typo in v1.7.7-rc1-1-g0866786
Date:   Wed, 21 Sep 2016 11:44:26 +0000
Message-Id: <20160921114428.28664-1-avarab@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Content-Type is application/xhtml+xml, not application/xhtm+xml.
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 33d701d..9473daf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1616,7 +1616,7 @@ sub esc_path {
 	return $str;
 }
 
-# Sanitize for use in XHTML + application/xml+xhtm (valid XML 1.0)
+# Sanitize for use in XHTML + application/xml+xhtml (valid XML 1.0)
 sub sanitize {
 	my $str = shift;
 
-- 
2.1.3

