Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7918C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 23:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C39C20719
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 23:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aRasqtRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgDGXMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:12:09 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:63997 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGXMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 19:12:09 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200407231207epoutp012eb159329816e182da1ce5e19c845a25~DrHhtzOQb2568325683epoutp01L
        for <git@vger.kernel.org>; Tue,  7 Apr 2020 23:12:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200407231207epoutp012eb159329816e182da1ce5e19c845a25~DrHhtzOQb2568325683epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586301127;
        bh=AziTFLkcyBYtzzYuVmrNK1Bsi3stkL69h2hgjAaCb/A=;
        h=From:To:Subject:Date:References:From;
        b=aRasqtRoy2Wdaz70L568u/5oiZK3iuD/ueiPksQYpYQq8eNRmhOwC1zJU1Ea+p6on
         QuMX3TZBuG8UH7cJWhvZs+pWs8dQhWfb1Lahz6b+TZVwu4OZmym+1VOJhySZWOMNxu
         EaWY9pY6+4upE3a5yFYvnopeKaQdC1UVQtZktLnA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200407231206epcas2p302bef8ce45a03530aa637c1330cd4be5~DrHhjE4-32113021130epcas2p3y
        for <git@vger.kernel.org>; Tue,  7 Apr 2020 23:12:06 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.184]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48xjps4kHdzMqYkf for
        <git@vger.kernel.org>; Tue,  7 Apr 2020 23:12:05 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.90.04704.2C80D8E5; Wed,  8 Apr 2020 08:12:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20200407231201epcas2p1a72ef517da1e0bff4d481a57dc593ab1~DrHcq0T-M0234502345epcas2p14
        for <git@vger.kernel.org>; Tue,  7 Apr 2020 23:12:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200407231201epsmtrp19a6e9871550b89ffdf0b4b0f3fd02eac~DrHcqOubN2464224642epsmtrp1D
        for <git@vger.kernel.org>; Tue,  7 Apr 2020 23:12:01 +0000 (GMT)
X-AuditID: b6c32a46-829ff70000001260-15-5e8d08c212cb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.F3.04158.1C80D8E5; Wed,  8 Apr 2020 08:12:01 +0900 (KST)
Received: from KORDO039863 (unknown [10.229.42.93]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200407231201epsmtip1ec284274af5112de99f59d03442d19a8~DrHccpjwO2246922469epsmtip1s
        for <git@vger.kernel.org>; Tue,  7 Apr 2020 23:12:01 +0000 (GMT)
From:   "Jordan" <jordan.az@samsung.com>
To:     <git@vger.kernel.org>
Subject: Installing git questions I can't find an answer to.
Date:   Wed, 8 Apr 2020 08:12:01 +0900
Message-ID: <000001d60d31$f1b41d80$d51c5880$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdYNMWxU/nMwgzx2THOIp4+P0sirkw==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmqe5hjt44g3+fGC26rnQzOTB6fN4k
        F8AYlWOTkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZAzRU
        SaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgaFigV5yYW1yal66XnJ9rZWhgYGQK
        VJmQk3H8z37GggXMFdP3FDUwHmPqYuTkkBAwkbgxr5G5i5GLQ0hgB6PEvSMfWSCcHiaJzmdP
        2CGcCUwSL5dtZIdp+bDkDhtEYi+jxMuHTUwQThOTxMmeCWwgVWwCahL3710E6xARkJTY9vgV
        I4gtLGAj8WzGR1YQm0VAReLKv8VgcV4BS4nVW6dD2YISJ2c+YQGxmQXkJba/ncMMsVlB4ufT
        ZUC9HEAz9SSa18VDlIhLvDx6BOxSCYGvrBJXf5xihah3kVgwfSXU1cISr45vgbKlJF72t0E1
        TGaUOP7tMzOE08Mo8WbSfDaIKmOJUy1PWUC2MQtoSqzfpQ9iSggoSxy5BXUbn0TH4b/sEGFe
        iY42IYhGZYkDX1cwQtiSEj8+PYSyPSReHYEEiZBArMSqVT9ZJjAqzELy8SwkH89C8toshBsW
        MLKsYhRLLSjOTU8tNiowQo7sTYzgBKfltoNxyTmfQ4wCHIxKPLwPEnvihFgTy4orcw8xSnAw
        K4nwSvV2xgnxpiRWVqUW5ccXleakFh9iNAVGyERmKdHkfGDyzSuJNzQ1MjMzsDS1MDUzslAS
        593EfTNGSCA9sSQ1OzW1ILUIpo+Jg1OqgXFGmcjd+Yp7o6KS1yqo/ZwRKKr91mNW8M5f38/M
        0H5y7eOhXF1zg0VN0SZ/PsREduj9DD918lKlRWlPJcO9KXcnskr2bdw/Wysw63NZzyplzwKz
        OYGtMbEKs5vf36yJKnm6fHLdtdVv94lOjWc2WVEXOdNXxNNzUsfX6ClHWB5t7bD4lfM0xE+J
        pTgj0VCLuag4EQCqGewXhgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnO5Bjt44gx1TZSy6rnQzOTB6fN4k
        F8AYxWWTkpqTWZZapG+XwJVx/M9+xoIFzBXT9xQ1MB5j6mLk5JAQMJH4sOQOWxcjF4eQwG5G
        ibsdHSwQCUmJlnk7oGxhifstR1hBbCGBBiaJ6YsrQGw2ATWJ+/cusoPYIkD12x6/YgSxhQVs
        JJ7N+AhWzyKgInHl32KwOK+ApcTqrdOhbEGJkzOfAM3n4GAW0JNo2wgWZhaQl9j+dg4zxFoF
        iZ9Pl7GClIgAlTSvi4coEZd4efQI+wRGgVlIBs1CGDQLyaBZSDoWMLKsYpRMLSjOTc8tNiww
        ykst1ytOzC0uzUvXS87P3cQIDkwtrR2MJ07EH2IU4GBU4uF9kNgTJ8SaWFZcmXuIUYKDWUmE
        V6q3M06INyWxsiq1KD++qDQntfgQozQHi5I4r3z+sUghgfTEktTs1NSC1CKYLBMHp1QDY4f1
        sgU/hY6rrjGsPDN10vOXKgubAt1lGg1e3hNtPn4mULhRjG9X5UPepfl6e3esvPvylHhw5ckM
        /661PL9FhKTVQy5y/urIrbu7yGhqwiS+yx0RrVY1F5Y2n+fw3zX1WAnTPKct/pJnjadOLWTy
        CN4aVrF+1r40PUUWg6mF81Y1627i79oTp8RSnJFoqMVcVJwIADlHET9IAgAA
X-CMS-MailID: 20200407231201epcas2p1a72ef517da1e0bff4d481a57dc593ab1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200407231201epcas2p1a72ef517da1e0bff4d481a57dc593ab1
References: <CGME20200407231201epcas2p1a72ef517da1e0bff4d481a57dc593ab1@epcas2p1.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I have searched the internet and can find no answer to my dilemma. I am
trying to install a local copy of git on a Linux machine that is not
connected to the internet and I don't have root privileges on. I can
download and transfer things to this machine, but that is it. I think this
should be possible, but have had no luck with the things I have tried.
Thanks you for any advice.
Regards
Jordan

