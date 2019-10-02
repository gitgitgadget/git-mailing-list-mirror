Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C991F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 04:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfJBEwn (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 00:52:43 -0400
Received: from albireo.enyo.de ([37.24.231.21]:42414 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfJBEwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 00:52:43 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Oct 2019 00:52:43 EDT
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iFWWR-0008BS-KT
        for git@vger.kernel.org; Wed, 02 Oct 2019 04:45:55 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iFWUB-00021C-O9
        for git@vger.kernel.org; Wed, 02 Oct 2019 06:43:35 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     git@vger.kernel.org
Subject: git mailinfo with patch parser
Date:   Wed, 02 Oct 2019 06:43:35 +0200
Message-ID: <87imp77o5k.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git mailinfo splits a message into headers, commit message, and patch
text, but does not actually parse the patch text.  As a result, the
patch portion produced by git mailinfo can contain something that
looks like a patch, but actually isn't.

Is there a way to get the patch data, as parsed by git apply or git
am, and dump it back in patch format, without actually applying the
patch to a working tree?
