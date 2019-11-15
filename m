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
	by dcvr.yhbt.net (Postfix) with ESMTP id A36051F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfKOBBe (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38476 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfKOBBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id w8so3487720plq.5
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VjJogdhR5BS13cyYeMoZljc4gDWzfmfdKUgXYp6WRsk=;
        b=BE/epLgdlUlqvHmqRJl/sx91f4f43RlNXz+I3av/RPJanjtT4FjfKMwffjqu3qhsBX
         tcH3fpy8NUpfTjYvhTtRAXzJ2IXWaqx3Zy8VdLGJCIBuwXLTza224adrvv0roEMMkOtB
         VPeEysTE4a2LWYqtTdAE+mrHt9c5fpYbZdIeURiQI6+WV8HrdnReaCcAffD7q6vuOTcp
         rBHfNIIEaQxoFNTgiacr5ETrHiUXePFQCof9UHI/Oj4WCJLp4s8oQCYKwXRfXCKiwaSi
         63e2khnpXECTpgzZuLubQk5OJHJLFFibX0KeKs4H9nbsOhOJNobUddYnbnnmxWkjEU4u
         9tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VjJogdhR5BS13cyYeMoZljc4gDWzfmfdKUgXYp6WRsk=;
        b=KQypCHRbWxzT4TrcT8jD8tEn7FKsUPZSaAvjTHsZn6nKepDKGhe/pKuP+Nfcsg+Ka6
         ID7sAICY6wzUTr3UCUvRpVK2vDULQmC5cDhcPju0fCAxOrQKBvkYw49PEB8oBBG5uDzA
         04KBajZjdnkWXFi+LnT59t8GV4z/j4XAwDR+ZDVfvffrSgVd6cTOzeWf/br5gWen/WDW
         wguWhoxX8Baa1VmiSh+du953wg8jgRPomaPlu3zWOpUU4jKATXF84dK3d2hSyE/5nywA
         oV9zw+MsC0awOXJYzBP6N0XLAj9x5EKCqSV4fjdBlFAyZFcwVuoD8d2LCY+bwQYcNqXa
         sDeA==
X-Gm-Message-State: APjAAAUL0e6QmGnlU2EE+oa0a9bm5xUJJMEBwP58my3X0+QIHGk8iSbe
        +seG5BLrHWeovTbYx1TidxjD4s7u
X-Google-Smtp-Source: APXvYqyP4JoWC4I0ddGEhuKbcWXTQV+rcc9oAHz8fjGDjNb49FiieHv0MIQGB8CC+3zHJLvCucfojw==
X-Received: by 2002:a17:902:ac98:: with SMTP id h24mr12122560plr.227.1573779692385;
        Thu, 14 Nov 2019 17:01:32 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id 71sm8688760pfx.107.2019.11.14.17.01.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:31 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:30 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 26/27] t9902: disable pipefail
Message-ID: <95806f55e7e0ad1ac187ea162a74d5883fa86e67.1573779466.git.liu.denton@gmail.com>
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
However, these tests cannot run with pipefail. Since git-completion.bash
is not a testing script, it does not follow the same return code
conventions and it's expected that commands can fail within a pipeline.

Run `set +o pipefail` to disable pipefail in this script.

Note that this is being unconditionally run because this test will be
skipped if its not running on Bash.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t9902-completion.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index e90ac565e1..75a512669e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -7,6 +7,12 @@ test_description='test bash completion'
 
 . ./lib-bash.sh
 
+# These tests cannot run with pipefail. Since git-completion.bash is not
+# a testing script, it does not follow the same return code conventions
+# and it's expected that commands can fail within a pipeline. Ignore
+# these failures.
+set +o pipefail
+
 complete ()
 {
 	# do nothing
-- 
2.24.0.399.gf8350c9437

