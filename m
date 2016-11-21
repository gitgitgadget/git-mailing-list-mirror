Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94A161FEEE
	for <e@80x24.org>; Mon, 21 Nov 2016 23:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754573AbcKUX1N (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 18:27:13 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35236 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753535AbcKUX1M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 18:27:12 -0500
Received: by mail-pf0-f179.google.com with SMTP id i88so185687pfk.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 15:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qPSh5qsfoCdO1yZo1t/FqkY4uU0/lrDRXTfASy1nq7k=;
        b=H/uMRsgVJFD8VTtT/spsyixQLeqErjshYEYbvAXa7jD2V3CRGiQ4K12YQo/4TIOnJY
         bO4ehOCuraGAwZeFshXcqIoBSBDyUpxYG4dOhAuTl12KjZibF9BxlGTOLrc412oluJq5
         K5x/V/arOYd/q2SLACkTC1wVuXkBkjViF7vkFnNd/xA0KPGgsZGwMmTkTAnWmK2rGmCH
         VLyFQFFi02veMluX/+ynUAOPMWXq2fv0UkKEnatmipg22gjOOvbH0LM5gJNhR/aeC6YN
         A50fXcSqUK5RNJJ9foD2DghG/pH3rU3hzRzJahqH6Ntcj/rIPsyjorfQAkeOkK6E7x/G
         sbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qPSh5qsfoCdO1yZo1t/FqkY4uU0/lrDRXTfASy1nq7k=;
        b=NmlHyJSP0YjtzWPEjn46dBTLHykhi8BB88CcI6BxZD4xIgnrSEYlymSTEDGw0AGkqZ
         YT5b5DELt1YbNMJWh1W1ilA6J/A3oYY1QJ/eFAY/RUj+zc3YKse8880P/sGiRiFDCeYV
         cuU1+wfP9taf3Yfi1KXx6fmdsmSYwUbo9vlTCC3KYeQKO0n1HKgCf9qkSC4VkD4hzY8q
         ze42Pdg7Jx54mpvyREpaqS1odIXuOyMiuxP1Z1lT9CP9JB+v5XWOvEnuRYzyeFYQSsaz
         z9iyBOVFpgRE37CPaJ2ZkM/wvRuwsxIaQZSNjKcb8TYqpBrbqFVitUuxEzelKAn9MS/S
         rYTA==
X-Gm-Message-State: AKaTC02kOM2hVgxM2Aw4KMBG0bBjJPo42npiLlCycprZraAE+x6qIBzUTBqpaN8Tnnr2QCdN
X-Received: by 10.99.244.17 with SMTP id g17mr37390499pgi.80.1479770831577;
        Mon, 21 Nov 2016 15:27:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1d4e:2913:1c16:dc05])
        by smtp.gmail.com with ESMTPSA id 186sm39887114pfv.61.2016.11.21.15.27.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 15:27:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     bmwill@google.com, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/3] submodule-config: clarify/cleanup docs and header
Date:   Mon, 21 Nov 2016 15:27:06 -0800
Message-Id: <20161121232709.8906-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.18.g0126045.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

replacing sb/submodule-config-cleanup

v2:
addressed Jacobs concerns in patch2, fixing all occurrences of commit_sha1.

Thanks,
Stefan

interdiff to v1:
diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 1df7a827ff..a91c1f085e 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -49,7 +49,7 @@ Functions
 
 `const struct submodule *submodule_from_path(const unsigned char *commit_or_tree, const char *path)`::
 
-       Lookup values for one submodule by its commit_sha1 and path.
+       Lookup values for one submodule by its commit_or_tree and path.
 
 `const struct submodule *submodule_from_name(const unsigned char *commit_or_tree, const char *name)`::


v1:
A small series that would have helped me understand the submodule config
once again.

Thanks,
Stefan

Stefan Beller (3):
  submodule config: inline config_from_{name, path}
  submodule-config: rename commit_sha1 to commit_or_tree
  submodule-config: clarify parsing of null_sha1 element

 Documentation/technical/api-submodule-config.txt | 13 ++++--
 submodule-config.c                               | 59 ++++++++++--------------
 submodule-config.h                               |  4 +-
 t/t7411-submodule-config.sh                      | 11 +++++
 4 files changed, 45 insertions(+), 42 deletions(-)

-- 
2.11.0.rc2.18.g0126045.dirty

