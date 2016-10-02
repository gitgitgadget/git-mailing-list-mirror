Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3F4207EC
	for <e@80x24.org>; Sun,  2 Oct 2016 10:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbcJBKuy (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Oct 2016 06:50:54 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39769 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751420AbcJBKuy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 2 Oct 2016 06:50:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A07BA20384
        for <git@vger.kernel.org>; Sun,  2 Oct 2016 06:50:52 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Sun, 02 Oct 2016 06:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=+evSS9dvZt/2yYQnW38IJxQszlM=; b=h43UH
        V0eMtRyzyusU4lHbDFnx5YXGAUVEtSipJSnK5doESHJhhgv2imrlcBKoip/O1JOl
        XEulwzDHTZoRGJXJuDYRPgVOGHIwI88sd9XLfzJGVa2gtIW01HAd06/gdkg14IFZ
        T6z1KvmKtEMuOz7uCTo+M1ENERfS3RtW7/GEFg=
X-Sasl-enc: v02icwvOP0cnwsJYJAWF2K1QxzYDvwNhYeYpiunQnNwM 1475405452
Received: from [192.168.1.4] (unknown [183.89.28.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id C74E9F29CD
        for <git@vger.kernel.org>; Sun,  2 Oct 2016 06:50:51 -0400 (EDT)
To:     Git mailing list <git@vger.kernel.org>
From:   "Ravi (Tom) Hale" <ravi@hale.ee>
Subject: Setting pager.add=true breaks add --patch
Message-ID: <e8bdb434-432b-57c6-5cb4-283aca08ab0b@hale.ee>
Date:   Sun, 2 Oct 2016 17:50:49 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Given:

1) git version 2.10.0.GIT

2) The following configuration:
=======================
[core]
   pager = less -FRX --tabs=4

[pager]
   add = true
=======================

3) A patch hunk longer than a screen

THEN:

less will be invoked as expected.

However, upon exiting less, I am dropped back to the shell, whereas I 
would expect to see:
Stage this hunk [y,n,q,a,d,/,j,J,g,e,?]?

-- 
Tom Hale
