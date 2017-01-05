Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94FD1FEB3
	for <e@80x24.org>; Thu,  5 Jan 2017 10:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938344AbdAEKOO (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 05:14:14 -0500
Received: from mx02.novomind.com ([217.89.146.18]:59438 "EHLO
        mx02.novomind.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936741AbdAEKOL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 05:14:11 -0500
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jan 2017 05:14:11 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novomind.com; h=
        mime-version:content-transfer-encoding:content-type:content-type
        :content-language:accept-language:message-id:date:date:subject
        :subject:from:from; s=mail; t=1483610769; x=1485425170; bh=5qPeg
        PgNJD+Tgs8mh6aKzY7R+B+x4y4HILhopIZiVYI=; b=NaEn9QMlGfqCUgYH7qRTm
        YxYm0ZmSe4vwmHwkRmVFgWLh5ynBsfv777pPMx/VJO4vIkPcESJOv8kdsBi6AB0t
        Kv3z7idYjfY1zMnjuWPfihzViKh/jNu6upo98jrPiIfBWBU4G9bxxoFsnA+KGieX
        +J8MPld3Tp31i8NFwfw6Ak=
Received: from email.novomind.com (email.novomind.com [10.21.96.12])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx02.novomind.com (Postfix) with ESMTPS id 1E4533224797
        for <git@vger.kernel.org>; Thu,  5 Jan 2017 11:06:09 +0100 (CET)
Received: from EMAIL.novomind.com ([::1]) by email.novomind.com ([::1]) with
 mapi id 14.02.0387.000; Thu, 5 Jan 2017 11:06:08 +0100
From:   Roland Illig <rillig@novomind.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git branch -D doesn't work with deleted worktree
Thread-Topic: git branch -D doesn't work with deleted worktree
Thread-Index: AdJnOQ+BK+3iTnb/Ry637oOVSmR4VQ==
Date:   Thu, 5 Jan 2017 10:06:08 +0000
Message-ID: <4D106F0FF3D29E4FA1D91C1A31CE4C3501B8DEF2E6@email.novomind.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.21.105.114]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

R2l0IDIuMTEuMCBnaXZlcyBhIHdyb25nIGVycm9yIG1lc3NhZ2UgYWZ0ZXIgdGhlIGZvbGxvd2lu
ZyBjb21tYW5kczoNCiANCiQgZ2l0IGluaXQNCiQgZWNobyBoZWxsbyA+ZmlsZQ0KJCBnaXQgYWRk
IGZpbGUNCiQgZ2l0IGNvbW1pdCAtbSAibWVzc2FnZSINCiQgZ2l0IHdvcmt0cmVlIGFkZCAuLi93
b3JrdHJlZQ0KJCBybSAtcmYgLi4vd29ya3RyZWUNCiQgZ2l0IGJyIC1EIHdvcmt0cmVlDQplcnJv
cjogQ2Fubm90IGRlbGV0ZSBicmFuY2ggJ3dvcmt0cmVlJyBjaGVja2VkIG91dCBhdCAnLi4vd29y
a3RyZWUnDQoNClNpbmNlIC4uL3dvcmt0cmVlIGhhcyBiZWVuIGRlbGV0ZWQsIHRoZXJlIGNhbm5v
dCBiZSBhbnl0aGluZyBjaGVja2VkIG91dCBhdCB0aGF0IGxvY2F0aW9uLg0KDQpJbiBteSBvcGlu
aW9uLCBkZWxldGluZyB0aGUgYnJhbmNoIHNob3VsZCBqdXN0IHdvcmsuIEVzcGVjaWFsbHkgc2lu
Y2UgSSB1c2VkIHRoZSAtRCBvcHRpb24gYW5kIHRoZSAiZ2l0IHdvcmt0cmVlIiBkb2N1bWVudGF0
aW9uIHNheXMgIldoZW4geW91IGFyZSBkb25lIHdpdGggYSBsaW5rZWQgd29ya2luZyB0cmVlIHlv
dSBjYW4gc2ltcGx5IGRlbGV0ZSBpdC4iDQoNClJlZ2FyZHMsDQpSb2xhbmQNCg0K
