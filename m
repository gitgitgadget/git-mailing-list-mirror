Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B8ED1F453
	for <e@80x24.org>; Fri,  3 May 2019 14:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfECOKN (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 10:10:13 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39067 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfECOKN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 10:10:13 -0400
Received: by mail-wr1-f50.google.com with SMTP id a9so8074432wrp.6
        for <git@vger.kernel.org>; Fri, 03 May 2019 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neuxpower-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2HwZqtYBTqgzQTL45I4wZ5fUr+hbVrr1znqUT00USNY=;
        b=NpfGfGy4S+G5My3hpfv/crzz53yUTrLxYgzONU0HXHRasKmjgS6+Je67QaCYR0MJGu
         T7PN3Y3HeZtcL1RFgbWTz2jSXSrKcqbpkf+/OUgFrKE827LvWDsD8v1YWOD/eFPW9DFH
         jJvEdotydeJY0U0QVYQd6T+BUggUOAMxdDLfGRDZ+f8JNq+MfOWWZBkZT2jsmHFTBp6k
         aNZB1nWuEiiJPjut8FKIHGJ1pemUj17aDz78X225Eg5RlC2dSClqzlqbTOHHIMBBUcee
         h7S4XLa5tpn3PCZwF7qwjNi3hpnaLGwKhhXczIa8IuSd0jysV9yyMvhjdPl50Di4ZqhP
         BUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2HwZqtYBTqgzQTL45I4wZ5fUr+hbVrr1znqUT00USNY=;
        b=j1mpqd1XW25wQWkU9jQqNLBFnc4w6zlCYNbKDt7voa5314t+C0pUWBnk9ldRJQ2HLi
         zIGbyI4Cuv6L7Ovz2nVUB9LC6yIYMSvsiXvh/AajVJ6CRHXJQZJyoGoRL001pXXeHDzW
         5f/EyvnS6UyEmrfmErMEJvDQzZOCydedl04TdEZKkPOOC2Ln4qC4S4ic+416f6mwto7F
         E8uQ7j/uiZGYTzBxSagxEyGaybUy6A53yt++JIqtFN09H3yYCnNAxIxqx3gtYtQ/ziVD
         EC6NeRt7FL5RQ0DJwTzEc2DJNX9SUEsPyOg+WJkc1XKyGFjyPwtftHxnVmiN780QwbTQ
         6ywg==
X-Gm-Message-State: APjAAAWrXkbi7lPoz2ELcvhHL4nD/EJlT9JbIKsyrUa/B+z2J1AB3VnT
        eI9bnqrbEDVyHS2999cfgq/XVA==
X-Google-Smtp-Source: APXvYqwnu/HdrEJT0UYBwcNeKevDw5ePvwkXpnLrUpL2UQmZ8KsF3vw5nRFyjgp/N74xU82vEydMOg==
X-Received: by 2002:adf:c503:: with SMTP id q3mr7363501wrf.263.1556892611476;
        Fri, 03 May 2019 07:10:11 -0700 (PDT)
Received: from DESKTOP-KSPT8GU.localdomain (cpc109701-know17-2-0-cust59.17-2.cable.virginm.net. [77.96.178.60])
        by smtp.gmail.com with ESMTPSA id m22sm3287177wrb.15.2019.05.03.07.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 07:10:10 -0700 (PDT)
Received: by DESKTOP-KSPT8GU.localdomain (Postfix, from userid 1000)
        id E92DD2A000000072818; Fri,  3 May 2019 15:10:08 +0100 (DST)
From:   Andrew Molyneux <andrew.molyneux@neuxpower.com>
To:     git@vger.kernel.org
Cc:     Andrew Molyneux <andrew.molyneux@neuxpower.com>
Subject: [PATCH 2/2] tests: fix typo (UTF-16LE-BOM) in test name
Date:   Fri,  3 May 2019 15:09:52 +0100
Message-Id: <20190503140952.9029-2-andrew.molyneux@neuxpower.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503140952.9029-1-andrew.molyneux@neuxpower.com>
References: <20190503140952.9029-1-andrew.molyneux@neuxpower.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Encoding name was erroneously referred to as UTF-16-LE-BOM in name of
test; this should in fact be UTF-16LE-BOM (no hyphen between '16' and
'LE').
---
 t/t0028-working-tree-encoding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 1090e650ed..9a05993ce5 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -79,7 +79,7 @@ test_expect_success 're-encode to UTF-16 on checkout' '
 	test_cmp_bin test.utf16.raw test.utf16
 '
 
-test_expect_success 're-encode to UTF-16-LE-BOM on checkout' '
+test_expect_success 're-encode to UTF-16LE-BOM on checkout' '
 	rm test.utf16lebom &&
 	git checkout test.utf16lebom &&
 	test_cmp_bin test.utf16lebom.raw test.utf16lebom
-- 
2.21.0.windows.1

