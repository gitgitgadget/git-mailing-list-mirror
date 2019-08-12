Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD461F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfHLSAe (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 14:00:34 -0400
Received: from rchemail.bankofamerica.com ([171.159.227.167]:44638 "EHLO
        bankofamerica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726909AbfHLSAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 14:00:32 -0400
Received: from vadmzmailmx05.bankofamerica.com ([171.182.203.230])
        by lrcha0n0xepmx04.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7CI0U9K025402;
        Mon, 12 Aug 2019 18:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bofa.com;
        s=corp1903; t=1565632831;
        bh=Qi0Qo4htIf7Z8Suh4zjkjY0BaWUvaq1BJh01bWXZYaM=;
        h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
         Content-type:Content-transfer-encoding:References;
        b=0jSXlsKpimXid3Rzy7StnAEe4QbVu6aYaA2dfje0wd9mr0zJChQ9vrVcIx3bNZmxy
         RwEk7UfTCtPXORzc+IZy5ExsYILyqgDJXkEOjf2o3Z6L902fBCuZK5p3hniMGM58Sb
         uYMoDVt0GEhf8Y3H3P2P0uwhCRzO5txoBj+EPf7c=
Received: from lrcha0n5xepmx12.bankofamerica.com (lrcha0n5xepmx12.bankofamerica.com [171.205.12.15])
        by vadmzmailmx05.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7CI0IHg006445;
        Mon, 12 Aug 2019 18:00:30 GMT
Date:   Mon, 12 Aug 2019 18:00:08 +0000
From:   "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Subject: RE: suggestion for improved docs on autocrlf
In-reply-to: <20190812171049.ydec3nsmkt2xplhd@tb-raspi4>
X-Originating-IP: [30.245.13.45]
To:     =?iso-8859-1?Q?=27Torsten_B=F6gershausen=27?= <tboegi@web.de>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Message-id: <aae529ce1b084b7bbcca3977e6909417@bofa.com>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Content-language: en-US
Content-transfer-encoding: 7BIT
X-MS-Has-Attach: 
Accept-Language: en-US
Thread-topic: suggestion for improved docs on autocrlf
Thread-index:  AdVNISlxEEknYFEsRQ6Yj1wK7ruvjABLB7eAAAekNtAADVdLsP//xzkA//9/qwCABDUnAP/+mJWQgANNx4CAADsrQA==
X-MS-TNEF-Correlator: 
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com> <20190808205631.e2647kxq74thotjb@tb-raspi4>
 <3269668c03a8482d8d854ec19dd43907@bofa.com> <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
 <20190809033406.5t5ag3qmh36ideec@tb-raspi4> <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
 <20190811121004.guygurnopwwggvsp@tb-raspi4> <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com>
 <20190812171049.ydec3nsmkt2xplhd@tb-raspi4>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_06:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay, I feel like I'm on the verge of understanding, but it keeps eluding me,
because you keep answering the question I actually asked, rather than the
one I should have asked... let me try again, and bear with me if it seems like I'm
repeating the same question over and over, because I don't understand which
"irrelevant" differences matter and which don't.
(You've been amazingly patient so far actually.  Thank you for that.)

(Incidentally, you've successfully convinced me that attributes are a far better
way to deal with this.  I still feel that the behavior should be documented though.)

Setup: Suppose there exists a repo where sample.txt has CRLF line endings.
Meanwhile, my git config has autocrlf as "input".  Now, I clone the repo.
I edit sample.txt, and then commit.  Assuming the repo has no .gitattributes,
is it possible to predict what line endings sample.txt will end up with in my repo?
Or does it depend on more information than what I've just written?

----------------------------------------------------------------------
This message, and any attachments, is for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at http://www.bankofamerica.com/emaildisclaimer.   If you are not the intended recipient, please delete this message.
