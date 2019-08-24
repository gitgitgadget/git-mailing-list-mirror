Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EB681F461
	for <e@80x24.org>; Sat, 24 Aug 2019 08:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfHXI1P (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 04:27:15 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:33490 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfHXI1O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 04:27:14 -0400
Received: by mail-io1-f52.google.com with SMTP id z3so25699485iog.0
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 01:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XVN3uoweg9olm4lkkysRDVARDiy1wDmhHAGBz6iSCUo=;
        b=bXYUr6ScwYB0tOTp85ju1O87fwnX+xyDSPdxx5vF5YoQ+ry7ieZ4OPXmhvPwzVKnfH
         jcMTtsSyec2at2GL73BbvqMmBmUNPuQ+8Xfyfm0GHETDVZEuqBDu+7uJjbeqaUCElqzo
         54KvDHpibYhRtU7Ongt8ftWYi+CjqA6sQ9hM122p9/eleZe5lwOWC9ByrAY9CkFiDNPX
         VkS4OFeVdf1HAAWyKbUFSWPt88oRhPWB3mV2vN6AiVShHWj0NPAgNesJeqkWh1Ji2L5Y
         8jqDl1gRPQNVOxjdIG18oSSVG0MdrVmLwdsetsSfoCDvVXlq3/4fGJYj3U55T64WC3cY
         UawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XVN3uoweg9olm4lkkysRDVARDiy1wDmhHAGBz6iSCUo=;
        b=iRaq2P+0oEzH5kFgZF3Zbco6qLDGYEX/dFMTAXPAlzL8Tnrg36cIiqZXsV5hteRCRT
         Fb/Fl67hJny/AaAMjOe2uFiybRyJ+QlyptTDaSjo35SaaQ1BXCFAQzlf8OOgv/lxXMh6
         5LbLZJ/aRl7tC3yj9ieM1TPgKZT6kG9jpSZJQhWS2XL9St3zOYCl4H+YCB16iHc2JLOY
         4EyItlJckW/LyHUXKPy/63iE6BHRghJwt/NWLaRp7PqwWskWFOwMYJrP1cbC9RJH9Gm7
         3aGw7VlgxLsCs5gcEmiQqiQpzof8gzKHKvLOTv6WHJndtH9X3wF7jvVCxwedj9S09Xof
         6QVw==
X-Gm-Message-State: APjAAAWufSm5NxhUHZ9rfNDLSJ/XYBTLsZC18Mf/7gW+JIvzvlFgULFW
        IDBbzkIUMsth9XYb/cVVWZW2/Coe
X-Google-Smtp-Source: APXvYqzOnsUqGwDJCRN/d2C4IuMaxMefcI7u5j8fB16lCeE8lDYduyRu3yuzYXpb6Ctq7i5snOTUmQ==
X-Received: by 2002:a6b:c94c:: with SMTP id z73mr12770315iof.84.1566635233387;
        Sat, 24 Aug 2019 01:27:13 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id j1sm3572176iop.14.2019.08.24.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 01:27:13 -0700 (PDT)
Date:   Sat, 24 Aug 2019 04:27:11 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 10/13] t4014: remove confusing pipe in check_threading()
Message-ID: <6a9409cee036f3ded3b88540959dc4d05a3ced12.1566635008.git.liu.denton@gmail.com>
References: <cover.1566285151.git.liu.denton@gmail.com>
 <cover.1566635008.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566635008.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In check_threading(), there was a Git command in the upstream of a pipe.
In order to not lose its status code, it was saved into a file. However,
this may be confusing so rewrite to redirect IO to file. This allows us
to directly use the conventional &&-chain.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 18142ee5fa..67f4c62ed6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -319,7 +319,7 @@ test_expect_success 'reroll count (-v)' '
 check_threading () {
 	expect="$1" &&
 	shift &&
-	(git format-patch --stdout "$@"; echo $? >status.out) |
+	git format-patch --stdout "$@" >patch &&
 	# Prints everything between the Message-ID and In-Reply-To,
 	# and replaces all Message-ID-lookalikes by a sequence number
 	perl -ne '
@@ -334,8 +334,7 @@ check_threading () {
 			print;
 		}
 		print "---\n" if /^From /i;
-	' >actual &&
-	test 0 = "$(cat status.out)" &&
+	' <patch >actual &&
 	test_cmp "$expect" actual
 }
 
-- 
2.23.0.248.g3a9dd8fb08

