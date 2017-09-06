Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAD39208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 03:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbdIFDf2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 23:35:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54568 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752353AbdIFDf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 23:35:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC701B0ABC;
        Tue,  5 Sep 2017 23:35:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=+HHwy9MoMwKR7KqBefW+WbhojD8=; b=RSBxWUvUT3dnysHekxLw
        34vkS+UCgs02lBAvP3tQfzmJL+6JUYL+5qL5nzv/ncfLdFHwFkz3fRLjW5lqd6H2
        oGXASYO3c7wqwBeUOig/o7qvYmJQ6Vj3ucSxft1GJW8QFEVGDY3ZfmyCY7GyiV+r
        slFH2eA6JCpdizGAZDnXguU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=XWxxMHTPgu7Y4E1cz7dljq2iN30VkPzMTDq2jBQvmCuERy
        KfdQh+GJCirrVhhSeFl044Uz3xBOQMrbJHyNuuoqiLIQtGOcdSefRmU9661yibYb
        lENNGRpd0jAF4mQWeVgZuH16IL8ceWzpC2me3s3buNBq+pM4zv5HmGtCE3+eQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D534BB0ABB;
        Tue,  5 Sep 2017 23:35:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 420A0B0ABA;
        Tue,  5 Sep 2017 23:35:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/3] merge-recursive: change current file dir string_lists to hashmap
References: <20170828202829.3056-1-kewillf@microsoft.com>
        <20170828202829.3056-4-kewillf@microsoft.com>
Date:   Wed, 06 Sep 2017 12:35:24 +0900
Message-ID: <xmqq4lsg8poj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C0FBE90-92B4-11E7-8364-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I needed this squashed into before I could even compile the
resulting code.  Perhaps my compiler is stale?



merge-recursive.c:28:22: error: declaration does not declare anything [-Werror]
  struct hashmap_entry;
                      ^
merge-recursive.c:29:7: error: flexible array member in otherwise empty struct
  char path[FLEX_ARRAY];
       ^
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ef4fe5f09f..1cd35db3f0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -25,7 +25,7 @@
 #include "submodule.h"
 
 struct path_hashmap_entry {
-	struct hashmap_entry;
+	struct hashmap_entry e;
 	char path[FLEX_ARRAY];
 };
 
-- 
2.14.1-546-g97ae4c876d

