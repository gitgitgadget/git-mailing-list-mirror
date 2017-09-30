Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 226882047F
	for <e@80x24.org>; Sat, 30 Sep 2017 18:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdI3Sqq (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 14:46:46 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:55022 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdI3Sqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 14:46:43 -0400
Received: by mail-pf0-f172.google.com with SMTP id d187so1208767pfg.11
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jpny290P78BG3DfdCNXocbfwX/3ftxXLIrFQsdzQjE4=;
        b=YBsdj2Q8Z+BeRKfmYfEkqvaxu2PYXGSQNxSGMNs6FKhLAbOm+BQxKPD5YTm6Fv3Iow
         IL5Cjy3VFxY7rzzTOoe7mvdinXLPWq0Pj7ouMwZGmStEt1alzdDnvDtsXDLQstCq8ULv
         7/5m8nWuxNdXEo2GsQ1n7Qv/A8/zI5zRQh3pABvV+RWsOP3K6Ip4XagE8pX3VVmTQPKK
         79GJwKPsm7KuYSsYvDRSTce5KQihPNjKsDyuvzQs6jBt0I7Zl4h7F6D03/sePFSlTIWc
         fwKzxvirU4A8Ki6Ww3Gus3I7ZRjyVVyh/oWm7D4YMqN6GOK4d7ul10jDI2azh2/rzufJ
         HQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jpny290P78BG3DfdCNXocbfwX/3ftxXLIrFQsdzQjE4=;
        b=O0JdxaQrKFULaBxDDeV5iUkAt2/4v3Hvd7JGQgjTsfaLU5/G4eOGRhGyQc/t/qw8Qk
         G3xEB7WfLZnfuk+4O7SAfVYLczCNLaHhdDdvepJBSu8eSus2p4f86oFV+77++ENw5dBo
         2fhHH0izPI/6t2TYhpQe92dZSpwm11+4Te0o2Ay3EtIGhRv/p/IcHjcOqZdkESAE18sK
         p1bWnbkXy5m9qvNRd/yaum99Ct/FNZdjJRzMlK4x98+UtlBRu8aAYHx8W0BjCUM9QUwv
         hv96bEKIqEr+e0tve13yl9eCZo9K0zqR7BdSzIa2mlovBaiVT5U6pLrIAfdE1B37tzc7
         HBmw==
X-Gm-Message-State: AHPjjUghg7VNG1RTiMz2mtEM8TaFvfjWV8Wj0ov9jEW5NCNOZXd8vqND
        a7Ejr/aKEgpN/VhmEsQIjxgMOmEP3GI=
X-Google-Smtp-Source: AOwi7QBHeTT94BVOEId7x9YZnjvu9RzX7amM+1xj/et1qmaE3gbk+pRIh7QWRAajYftZb6A3JuFOkg==
X-Received: by 10.101.85.204 with SMTP id k12mr8610150pgs.439.1506797202689;
        Sat, 30 Sep 2017 11:46:42 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id d190sm12080082pgc.11.2017.09.30.11.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 11:46:41 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 3/6] doc: 'trailers' is the preferred way to format trailers
Date:   Sat, 30 Sep 2017 11:46:26 -0700
Message-Id: <20170930184629.75900-3-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20170930184629.75900-1-me@ttaylorr.com>
References: <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
 <20170930184629.75900-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation makes reference to 'contents:trailers' as an example
to dig the trailers out of a commit. 'trailers' is an unmentioned
alternative, which is treated as an alias of 'contents:trailers'.

Since 'trailers' is easier to type, prefer that as the designated way to
dig out trailers information.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 03e187a10..6b38d9a22 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -213,7 +213,8 @@ line is 'contents:body', where body is all of the lines after the first
 blank line.  The optional GPG signature is `contents:signature`.  The
 first `N` lines of the message is obtained using `contents:lines=N`.
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
-are obtained as 'contents:trailers'.
+are obtained as 'trailers' (or by using the historical alias
+'contents:trailers').
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
-- 
2.14.1.145.gb3622a4ee

