Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A7FA1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKOBB1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42848 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfKOBB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id s5so5458056pfh.9
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=inLt0QKoeIphXL/Ze1gMz2SKfhZ6e4mcP429R5zsWDI=;
        b=M3fpAb6b4JXMhRO1lZXbSBUbJkxHR7RaYPs0MmT91c0XhxMz4LNL9xn2fXawp8mLEs
         52AolrpNJoE7B8rIyYnXuJn2mT0Cks36IkZWuBkZRa43iJ98ZXXMQjmh4JexPQI0Pufd
         N+zSURoWnuL92RSsSX7QsOn0Ei/jhH4g+Aww3zioXGRuJ5ceK8cDFJGyjdI6/+N6Hhj1
         D2DpRtcvNy5/uWrxancb/4u4qyDUjuMX3VMNus/PwTsVy/4wPkiAo3bGZmMWc4KlRSNb
         eGdEdIH3aaTLMdASUu7QCvJqiqvbIEvBaI9tYxZMXqmN8GPJqBNRQrdBwxBur9tuWFQN
         qWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=inLt0QKoeIphXL/Ze1gMz2SKfhZ6e4mcP429R5zsWDI=;
        b=p+dXK3+vqib7mdKgNMFwmFP6oQ3bZyknkFwkbZ1Knwa+p2N0xaf5JeZICcGExytg51
         MtGvqDh45SqB6hEyixbiOzRuaMEdafFh2A54Bitdos3kgfvI0vgVcSX7uDCnm76RtkCb
         nL093YdWzcMd+kILZa14p7bJmE1q8Zvh06dci8oiMUS5LggdxBPmn8kC7C1IRFF4wxce
         M2AxP8LoZJrTLbgDAwYDZ4GridoOJQ+45Qp8pbaeHIei2+4YvrX0UchOeoSN3eMPps7o
         ku4W+95jaG5mmF3CxZpc4AqbI7YBByEPHxks4GXi/6TRVCiXOT+CUP3j1PnRy6JXuZ4B
         L0ng==
X-Gm-Message-State: APjAAAW8tCFfOWG0xtfxKVhYpbwXKWnizU/jX1P/0hpSluw9osRALB5E
        WCbOB8d51d9sJx8K0/6nhXFKZY/a
X-Google-Smtp-Source: APXvYqzz1k/u3/D668U7CC1QUyoDAgTTj6111JcNOyEPNrnIVrE4k8O+BkTgB+lIszQPRVBKS+VVVA==
X-Received: by 2002:a63:e84d:: with SMTP id a13mr13124967pgk.226.1573779686089;
        Thu, 14 Nov 2019 17:01:26 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id z4sm7756365pfn.80.2019.11.14.17.01.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:25 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:24 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 23/27] t3600: mark git command as failing
Message-ID: <bc4c208f7814c3362fa5949af3cb8d2d2904f386.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we plan on running tests with `set -o pipefail`.
Since we intentionally induce SIGPIPE, before the return code
was being masked away. However, now `git rm` will cause an error code to
be returned because of the SIGPIPE.

Mark the failing command with `test_must_fail ok=sigpipe` so that
failures induced by SIGPIPE don't propogate.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3600-rm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0ea858d652..d1b3703edb 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -252,7 +252,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 		i=$(( $i + 1 ))
 	done | git update-index --index-info &&
 	# git command is intentionally placed upstream of pipe to induce SIGPIPE
-	git rm -n "some-file-*" | : &&
+	test_must_fail ok=sigpipe git rm -n "some-file-*" | : &&
 	test_path_is_missing .git/index.lock
 '
 
-- 
2.24.0.399.gf8350c9437

