Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E42C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8604B611F0
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbhEJMwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 08:52:05 -0400
Received: from st43p00im-ztfb10063301.me.com ([17.58.63.179]:53824 "EHLO
        st43p00im-ztfb10063301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243476AbhEJL4D (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 May 2021 07:56:03 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 07:56:03 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1620647281;
        bh=F54aLMfBI3BtSLkg9iqiSa0TMdrvj/iuispL5+bgyYw=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=y1WT2HeKbL1Uy31BgNuWr4SABJQWoqrKtDnOdXMuirAMr8aTBk0JB95aDGPmERqsV
         HVsKNevm/hLHDH1j+D/k/VRNlB5eYPRIDQl2xhPmVzoMMSnZDTrrahpUJELen2L4fm
         1ywgG6syFfgpWcU4XesBWNif5a2c6hCxsDf/Zvrj27rhLkis3tQiDtvi29nkzlZmCQ
         pPNRJ8n4lF0ELTC6lkonEqs59LwUuWing3Tm9O5ZrJAAxlTfpul+MGZrNZRbdsKn0l
         iuJ12Hhz8yyZYZH/SZIzFli272TDYwpKCK6q1yMUFyhXqsU6ZiYbq/SLwc4QPXimlU
         4L+cwj+Pue1VA==
Received: from [198.51.100.111] (unknown [85.174.197.166])
        by st43p00im-ztfb10063301.me.com (Postfix) with ESMTPSA id 516D8A4027B;
        Mon, 10 May 2021 11:48:00 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From:   =?utf-8?B?0J7QutGB0LDQvdCwINCQ0LvQtdC60YHQtdC10LLQsA==?= 
        <oxyoma1980@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Mon, 10 May 2021 14:47:57 +0300
Subject: Re: Re: [PATCH] maintenance: fix two memory leaks
Message-Id: <FADD543B-1D1E-492A-8F66-F79F2D4290DD@icloud.com>
Cc:     dstolee@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        lenaic@lhuard.fr, sunshine@sunshineco.com
To:     lilinchao@oschina.cn
X-Mailer: iPhone Mail (18D70)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.391,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-05-10=5F06:2021-05-10=5F05,2021-05-10=5F06,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=390 phishscore=0
 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2105100086
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCtCe0YLQv9GA0LDQstC70LXQvdC+INGBIGlQaG9uZQ==
