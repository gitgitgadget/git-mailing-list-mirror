Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AACD120986
	for <e@80x24.org>; Thu,  6 Oct 2016 09:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966312AbcJFJWY (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 05:22:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49024 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966105AbcJFJWW (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Oct 2016 05:22:22 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F25F2078E
        for <git@vger.kernel.org>; Thu,  6 Oct 2016 05:22:21 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 06 Oct 2016 05:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=QmD+vTgfV8kpgo5Bf6Wy+a2ECgk=; b=UmRwx
        MG/1m6qxS1wpIqlMGy13Fda/B4txbmVMHT3LKT9GZLmllIFlYv3nVu59vkGMWuVz
        l8AFiSXgY0/HDPTxmNziOzRWJUxCyPSwOigwlmVkn8TlCFBffsw8kLW3FKz/gsYe
        Bs20yaopAKLdfPeFwKeiA6PhEvWTV57pCEgl4o=
X-Sasl-enc: +jrMJqnw8q024jyNmOHNHaiPD4T8fuBIx4Qipdx2D/Cv 1475745740
Received: from [192.168.1.6] (unknown [183.89.37.67])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6C1BEF29D4
        for <git@vger.kernel.org>; Thu,  6 Oct 2016 05:22:19 -0400 (EDT)
To:     git <git@vger.kernel.org>
From:   "Ravi (Tom) Hale" <ravi@hale.ee>
Subject: Format for %d includes unwanted preceding space
Message-ID: <a3eed8fb-505c-e9c1-6fb6-944d9df2f15d@hale.ee>
Date:   Thu, 6 Oct 2016 16:22:08 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The log --format="%d" includes preceding space:

$ git log -n1 --format="XX%dXX" HEAD
XX (HEAD -> master)XX

I know of no other %<token> that is output in this way.

Is there a way of removing this preceding space through the format 
string, or will it need to be a code change?

-- 
Tom Hale
