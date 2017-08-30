Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77DB120285
	for <e@80x24.org>; Wed, 30 Aug 2017 14:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbdH3OLJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 10:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751377AbdH3OLH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 10:11:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B45FB7AE97
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 14:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com B45FB7AE97
Authentication-Results: ext-mx01.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx01.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=fweimer@redhat.com
Received: from oldenburg.str.redhat.com (dhcp-192-212.str.redhat.com [10.33.192.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14CC08D567
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 14:11:06 +0000 (UTC)
To:     git@vger.kernel.org
From:   Florian Weimer <fweimer@redhat.com>
Subject: Produce contents of index with existing directory as cache
Message-ID: <5a9e4efd-8c48-487e-4a9f-9362a944c992@redhat.com>
Date:   Wed, 30 Aug 2017 16:11:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 30 Aug 2017 14:11:07 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a variant of “git checkout-index” which will produce the
existing index contents, like “git checkout-index” would do with an
empty directory, but can reuse an existing directory tree, to avoid
writing all files from scratch?

I'm writing some analysis scripts which need to change a checked-out
working tree.  Right now I'm throwing away the tree after making the
changes and create the next tree (which is expected to be quite similar
in contents) from scratch, starting with an empty directory.  This is
quite slow.

Thanks,
Florian
