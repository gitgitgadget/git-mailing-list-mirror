Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E73F1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 17:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeI1Xcd (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 19:32:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42228 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeI1Xcd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 19:32:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id b11-v6so7124861wru.9
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2dM8/1maF/zq2SS0q7UhCliOZMzzCKgrgMd6hQYcR7g=;
        b=MBNueXUHk2EcM6DWIxT9S/WywhwUaS5crMDfmPeVbmysWlHelx/8t9HXV8OYPv06re
         pHsZiQ/hXjlXFYxQOueyaVjPoKCXj1i0jhBCSEIpA78Mt9VHItVMTBi+kV4UCQ9FrhVm
         84ROd8rp2paNEHB7OYD6AlqpTs0yWIp1UDJZdQNTHaRUe9Wee5UNQa70Ok3vpixjo8wR
         dlgx5nW7k72SVKe0ZeN/FNAg1fLfsIO7Ck+3cBmi2nzRdS60Os1YNpU4AtlZBquUwqdT
         F9FPK1CxktnjmHNxndHEHABuPsLEqQ1mzErZAFW7O32YjWTiNs9Qn/vsJbM/4THKLZxH
         7oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2dM8/1maF/zq2SS0q7UhCliOZMzzCKgrgMd6hQYcR7g=;
        b=ebZnLjBPdXB/ZumDDjkCcePU3bTQ1lJH6aORg9TkkQGrypiYHcswU60B0iaAd+hQll
         1DVwGYLQc21rmJQX1PVXDJjDbVZl1vHLi/1BjDYPr5jHfBGlSQgNNQAiIFoXXw9hHvAB
         zIzjYXVQIYwhAtMQC/4Uw8/3eMwJyS4f9W9a6kgXAGJgWlBjLTb3xct7QPhBWA63tkvx
         5SqZkRHRCmjedtK1ILJkCNND4yPhdxa/NHuwRu9Z5yMGYwraHGaV/YrOPuFUevmeelkq
         yQINVDEzxdsrU9WO/kwzTFbX0g2IgmYJkW2vD69zFk9nhDbYAGRMYocIt8ru6pqm+Y5b
         XAMg==
X-Gm-Message-State: ABuFfojECIQJ30aFkZ1FSdMDwXUQRyB3ikjCYAyozhoCjWnQm0FjrUBu
        O8ds90l3z3Mpsn8w8X4/SECqjhFY
X-Google-Smtp-Source: ACcGV614ajXMymBD/LebBrs8VkQXREJ0codVBcaPy4IVvkiNzX5DtEB1aEYh1MsTEXkekf+GUlkHXg==
X-Received: by 2002:adf:ef47:: with SMTP id c7-v6mr13057697wrp.182.1538154469714;
        Fri, 28 Sep 2018 10:07:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u185-v6sm2435114wmf.9.2018.09.28.10.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 10:07:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v6 4/7] config: add new index.threads config setting
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180926195442.1380-1-benpeart@microsoft.com>
        <20180926195442.1380-5-benpeart@microsoft.com>
        <20180928002627.GO27036@localhost>
        <cbc48a95-62f5-a098-fb70-97b6cf241920@gmail.com>
Date:   Fri, 28 Sep 2018 10:07:48 -0700
In-Reply-To: <cbc48a95-62f5-a098-fb70-97b6cf241920@gmail.com> (Ben Peart's
        message of "Fri, 28 Sep 2018 09:39:12 -0400")
Message-ID: <xmqqsh1tczyz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>> Why does multithreading have to be disabled in this test?
>
> If multi-threading is enabled, it will write out the IEOT extension
> which changes the SHA and causes the test to fail.

I think it is a design mistake to let the writing processes's
capability decide what is written in the file to be read later by a
different process, which possibly may have different capability.  If
you are not writing with multiple threads, it should not matter if
that writer process is capable of and configured to spawn 8 threads
if the process were reading the file---as it is not reading the file
it is writing right now.

I can understand if the design is to write IEOT only if the
resulting index is expected to become large enough (above an
arbitrary threshold like 100k entries) to matter.  I also can
understand if IEOT is omitted when the repository configuration says
that no process is allowed to read the index with multi-threaded
codepath in that repository.
