Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9B401F51C
	for <e@80x24.org>; Mon, 21 May 2018 18:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbeEUSK5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:10:57 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:39472 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753337AbeEUSK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:10:56 -0400
Received: by mail-qt0-f178.google.com with SMTP id f1-v6so20067959qtj.6
        for <git@vger.kernel.org>; Mon, 21 May 2018 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=1kkvW5RGGaxPfJk7E3BNDPT1BIpO2B77kMNweZqOXPQ=;
        b=gNBq1NxqGPnh2C1BK07lI4lzO0G80UFV8olcCnUOClU+xh5XN8Kj9TzeoEhGw6/stm
         btbyGw1MEoF5XpKkRf61U8nqMn9+lwm+UjfAiUaGPNlDg/6lJSrlXT1Xe22MTEpLbVZT
         2a8YfktA0XlklVhUsfz3/agR5iI017hF5SVbglP4QMFiUKfUz+naVUZDcdqAqoRd2rRB
         QaiTIxfQ1wR87WGUCduq5ZGGg0/MIuU0DI9Nq7JDacDzFnia81Vi00IkCXmFaUZ15g0E
         RaKudhpKp26DkBIYfCq+hpRH96DAAt73oFZ7bJwjTx0mUtuoMO8krbCuf/PMA2npH1Cl
         sl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=1kkvW5RGGaxPfJk7E3BNDPT1BIpO2B77kMNweZqOXPQ=;
        b=l1pwLtVY/9dPYuvwgabQwCqW24ehJagMvTvnAOnI0/2At/9B5q39cngKI3i3z51Iwf
         DdSpHn+Wdv7IkMKZRCwPu/HFQVTIu43R/NXwkr1ymHLEP0vNsyDWbsJ32ZNRbnTB0BQb
         rA8uDvF1WkkSfxQIZgq6ewOduBTe18bOpD1HmMoNWNta/dOX97ehQIoo7lStmfURuPlR
         lcgwlE61iS84X/S12EB4F7hTGPPz/zrwqsDbPmQrvR0LCdEevF/wg0BWW0cq/HNjnnaT
         tZR1x0F3blywCl6Z8T+7zlTOJlx9a77OHTBObuVfJRJnIR7sfjquVOWAlE7npQN4WDLW
         5O4Q==
X-Gm-Message-State: ALKqPwfyINjunwuF7fqZtR5Tm/W6URGM9hSzgsQpgiU5cwIHgNWVgqcx
        CKHRabqoH5EqDjBG1rV3Qbk=
X-Google-Smtp-Source: AB8JxZrUHA8sOCXgK7MZLC6qt/X4MulbqmtQHCSmcOPRAq7K15xIh8yZT4SGO/1GyaGVvry23wrf+g==
X-Received: by 2002:a0c:b305:: with SMTP id s5-v6mr18614992qve.96.1526926255989;
        Mon, 21 May 2018 11:10:55 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id s127-v6sm10305195qkf.21.2018.05.21.11.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 May 2018 11:10:55 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
From:   Derrick Stolee <stolee@gmail.com>
Subject: commit-graph: change in "best" merge-base when ambiguous
Message-ID: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com>
Date:   Mon, 21 May 2018 14:10:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

While working on the commit-graph feature, I made a test commit that 
sets core.commitGraph and gc.commitGraph to true by default AND runs 
'git commit-graph write --reachable' after each 'git commit' command. 
This helped me find instances in the test suite where the commit-graph 
feature changes existing functionality. Most of these were in regards to 
grafts, replace-objects, and shallow-clones (as expected) or when trying 
to find a corrupt or hidden commit (the commit-graph hides this 
corrupt/missing data). However, there was one interesting case that I'd 
like to mention on-list.

In t6024-recursive-merge.sh, we have the following commit structure:

     # 1 - A - D - F
     #   \   X   /
     #     B   X
     #       X   \
     # 2 - C - E - G

When merging F to G, there are two "best" merge-bases, A and C. With 
core.commitGraph=false, 'git merge-base F G' returns A, while it returns 
C when core.commitGraph=true. This is due to the new walk order when 
using generation numbers, although I have not dug deep into the code to 
point out exactly where the choice between A and C is made. Likely it's 
just whatever order they are inserted into a list.

In the Discussion section of the `git merge-base` docs [1], we have the 
following:

     When the history involves criss-cross merges, there can be more 
than one best common ancestor for two commits. For example, with this 
topology:

     ---1---o---A
         \ /
          X
         / \
     ---2---o---o---B

     both 1 and 2 are merge-bases of A and B. Neither one is better than 
the other (both are best merge bases). When the --all option is not 
given,     it is unspecified which best one is output.

This means our official documentation mentions that we do not have a 
concrete way to differentiate between these choices. This makes me think 
that this change in behavior is not a bug, but it _is_ a change in 
behavior. It's worth mentioning, but I don't think there is any value in 
making sure `git merge-base` returns the same output.

Does anyone disagree? Is this something we should solidify so we always 
have a "definitive" merge-base?

The biggest reason I think we should avoid sticking to the existing 
behavior is that the current behavior depends on the walk order. That 
means we would not be able to concretely define a tie-breaker without 
changing the existing behavior anyway.

Thanks,
-Stolee

[1] https://git-scm.com/docs/git-merge-base#_discussion

