Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URI_HEX
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63EA71F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 23:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750957AbcIAXEj (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 19:04:39 -0400
Received: from mwork.nabble.com ([162.253.133.43]:64740 "EHLO mwork.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbcIAXEi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 19:04:38 -0400
X-Greylist: delayed 4169 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Sep 2016 19:04:38 EDT
Received: from mjim.nabble.com (unknown [162.253.133.84])
        by mwork.nabble.com (Postfix) with ESMTP id B484B4591C61E
        for <git@vger.kernel.org>; Thu,  1 Sep 2016 11:16:49 -0700 (MST)
Date:   Thu, 1 Sep 2016 11:16:49 -0700 (MST)
From:   gjarms <gjarms@gmail.com>
To:     git@vger.kernel.org
Message-ID: <1472753809733-7657450.post@n2.nabble.com>
Subject: bitmap creation failed
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git Experts,

We have been exploring various ways to improve git cloning time, one among
them is using bitmap which is suppose to save time "counting objects".  but
i have problem creating bitmap since the repository contains 100's of pack
files. the bitmap file is not created when i use "git gc".

I have the following entries in my .gitconfig.

[pack]
        packSizeLimit = 10m
        writebitmaps = on
        writeBitmapHashCache = on

If i just dont use "packSizeLimit = 10m", then bitmap is created just by
running git gc

Can you please make me understand ?, What i understood is that the bitmap is
created when there is a single pack file, but if i split it into multiple
pack file, the bitmap generation fails with the warning
"warning: disabling bitmap writing, as some objects are not being packed".

Regards,
Arumuga



--
View this message in context: http://git.661346.n2.nabble.com/bitmap-creation-failed-tp7657450.html
Sent from the git mailing list archive at Nabble.com.
