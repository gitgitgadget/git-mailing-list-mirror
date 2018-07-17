Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 313A61F597
	for <e@80x24.org>; Tue, 17 Jul 2018 09:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbeGQJqK (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 05:46:10 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52207 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729478AbeGQJqK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Jul 2018 05:46:10 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 43FC321CE2
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 05:14:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 17 Jul 2018 05:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=//wFtqd6P686L3SUsgGBaqwX2VxH4H6hnjFznlGCBAc=; b=TnuBU7eE
        ZLVF5bGRApO3QBRThbdHFvzx/mccfTFGcB9Ka58d3Bm8tXJAKFf+jomHDE38iJF7
        p/0EI2W0zfAQcslOCeAZLSvfM6EFY6PemDCiXjiTIR/wbsbYdORU4aRqIhma/U3K
        OJDHc0n2IBgeIzIOUxUKrspfnRmHbt4/n5q3Ud5DQYARiFEfM4x+F3UbjIXtYIwZ
        qYzwXdhKPYLejpVpM7grtWmjNdSV4keGYpsUhcJliCPeJ59bgG2BZ/PcxQBhU2MZ
        CBzmDXY5+8xkwZWdNNdZevldOuG2TH1QXBLkpEeyNIObW5g3HufrmMCMO2vgnYT5
        uqIhuJbO3ADAGQ==
X-ME-Proxy: <xmx:d7NNW35g_fim4ASATO6f9Uzd4O3mlSQ2vlEA5hvvKHz5LRekqndb_g>
    <xmx:d7NNW9FlEJ7AcUTOhDChh3HW4LxnoRqzxHMF7EpKnceKZEQRBYB9dA>
    <xmx:eLNNWxGFBHfWz_fN-xBkcm7YfTAp8HIWvMJjDTBjSlSvAGN53JQllA>
    <xmx:eLNNWzvlpXw8jqCHm_LUZw1NvkKM5YCGcE73fBzm3vpk4WyeVz120w>
    <xmx:eLNNW_KQ229ehKwESWG_bxRPr7yVHLMas4ejSmHrBkXBy5u02_1m5Q>
    <xmx:eLNNW5kfYrR2Byo0OOvqN0XkVWJsXYuIAWYBouSi7na-lLlDtqFQxg>
X-ME-Sender: <xms:d7NNW_nBnVot_2dVXQeTEEbDyA3KmgTGniVzXtffBK27XaveUnC9MA>
Received: from sigkill.com (c-76-103-91-89.hsd1.ca.comcast.net [76.103.91.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 85F22E435C
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 05:14:31 -0400 (EDT)
Date:   Tue, 17 Jul 2018 02:14:29 -0700
From:   "J. Paul Reed" <preed@sigkill.com>
To:     git@vger.kernel.org
Subject: Are clone/checkout operations deterministic?
Message-ID: <20180717091429.GA31043@sigkill.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hey Git Devs,

I have a bit of an odd question: do git clone/checkout operations have a
deterministic ordering?

That is: are files guaranteed to be laid down onto disk in any specific
(and deterministic) order as a clone and/or checkout operations occurs?
(And if so, is it alphabetical order? Depth-first? Something else?)

In case the answer is different (and I'd guess that it might be?), I'm
mostly interested in the initial clone case... but it would be great to
know if, indeed, the answer is different for just-checkouts too.

I did some cursory googling, but nothing hopped out at me as an answer to
this question.

Thanks!

-preed
-- 
J. Paul Reed                                              PGP: 0xDF8708F8
=========================================================================
I've never seen an airplane yet that can read the type ratings on your
pilot's license.                                       -- Chuck Boedecker

