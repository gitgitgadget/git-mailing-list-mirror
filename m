Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790AA2036B
	for <e@80x24.org>; Fri,  6 Oct 2017 11:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbdJFLK1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 07:10:27 -0400
Received: from sonic307-54.consmr.mail.ir2.yahoo.com ([87.248.110.31]:44631
        "EHLO sonic307-54.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750967AbdJFLK0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Oct 2017 07:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1507288223; bh=JniuPcS2+1/w/HYW2veKQ5PJzfb05hUTEHJ1QKSbvFk=; h=To:From:Subject:Date:From:Subject; b=Z2r8IaCAo3592ePFQeqWDh6GBS1xM4otJQcxYCu5/GSTtlbtcP3tdUywDb9nkvbd6qiTeF/puDNPi6ZjABP+mYSsRS1wsXsYzrqcpnprTrSTUSPegfzG6ghbFxP4x7HAnp5R1lXPBsliUdHYm5qPoFh+8i1bUY8p17e7XplVaY1Jg+1JJPmTi5q4xiU7cFXtjyMM7y9lc4pnk+hRS524iI99u7ZwAR+ahAPZmguitNzR2Zeqiyo+1fEoFgEz7TQ4PuGg30yBa4tCATgyrMjvWSiiKasqw5gP2on9ogagSwePssHCD3MSapOt1B/czXcj5EU0L+I4Hnemz5FPOV7FJA==
X-YMail-OSG: 3CAV4M0VM1nYMNkTKcxBb15wzuo796jHiPyA6YTpntNl.FYn5RfwmNELqMZT5CN
 1ozCzQPR7ZJ46TnwolBzQfm8gXtEWK373ftQsEbf9Y9TfG.EZUbSL9JVKLZOH.FcXaRSrLxGTPSK
 A2.x66H2ko29bMKX5LMuh4.NMGlRbcU1EfcHpTizmCinZr3mB57pJ5NdUfTfn7crzIPZYUUGbGtC
 F6ES6Ob_qhgZ61Z6UeEJluH_Yebu81E6X99CSvkEtSj6jNEyoIuUwRHLRmLal5bGTvu1KWbWV_ZK
 xvVN4fZM.3cBYM4JsxYM_C8YYaq.CiMRG.XVdP4sc9Vx7ngElZ3YYxNhix_lkq5wksXMyCFsfYCb
 NzNccGFgNk_oPEYNfXnoMnWEMuwf0u1_tGeOVAIjMAIXJUERz4BU_ZSWlGIFZeocSRV9TLYDOflc
 WToHtURN6sEy3rsBxcdWuPhC5.M_Zc1FoU2_8XEbUthx59juk04e642dxTMbTb4s7HGzn7vVrVsT
 kuQxC6Q6I4E8Zu.2hKLc9Rc22xWXXJR9VVd91
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Fri, 6 Oct 2017 11:10:23 +0000
Received: from [127.0.0.1] by smtp144.mail.ir2.yahoo.com with NNFMP; 06 Oct 2017 11:10:18 -0000
X-Yahoo-Newman-Id: 167624.42859.bm@smtp144.mail.ir2.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: 3CAV4M0VM1nYMNkTKcxBb15wzuo796jHiPyA6YTpntNl.FY
 n5RfwmNELqMZT5CN1ozCzQPR7ZJ46TnwolBzQfm8gXtEWK373ftQsEbf9Y9T
 fG.EZUbSL9JVKLZOH.FcXaRSrLxGTPSKA2.x66H2ko29bMKX5LMuh4.NMGlR
 bcU1EfcHpTizmCinZr3mB57pJ5NdUfTfn7crzIPZYUUGbGtCF6ES6Ob_qhgZ
 61Z6UeEJluH_Yebu81E6X99CSvkEtSj6jNEyoIuUwRHLRmLal5bGTvu1KWbW
 V_ZKxvVN4fZM.3cBYM4JsxYM_C8YYaq.CiMRG.XVdP4sc9Vx7ngElZ3YYxNh
 ix_lkq5wksXMyCFsfYCbNzNccGFgNk_oPEYNfXnoMnWEMuwf0u1_tGeOVAIj
 MAIXJUERz4BU_ZSWlGIFZeocSRV9TLYDOflcWToHtURN6sEy3rsBxcdWuPhC
 5.M_Zc1FoU2_8XEbUthx59juk04e642dxTMbTb4s7HGzn7vVrVsTkuQxC6Q6
 I4E8Zu.2hKLc9Rc22xWXXJR9VVd91
X-Yahoo-SMTP: .w5QqJ6swBA_3w7N9yIVdzdJdKQq_njOOGspvdTCCa.iTA--
To:     git@vger.kernel.org
From:   "aleksander.baranowski" <aleksander.baranowski@yahoo.pl>
Subject: Git config multiple values
Message-ID: <4b848032-e8b6-be67-58d9-e3fcc2c11853@yahoo.pl>
Date:   Fri, 6 Oct 2017 13:10:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm currently using git version 2.14.2. There is possible to put
multiple values into same variable with git config.

Case 1:
# git config --global user.name Foo - returns 0
# git config --global user.name Bar - returns 0 and replace Foo to Bar
# git config --global user.name Foo - returns 0 and replace Bar to Foo

Case 2:
# git config --global user.name Foo - returns 0
# git config --global user.name Foo2 Bar - returns 0 and put second name
# cat ~/.gitconfig
[user]
	email = aleksander.baranowski@yahoo.pl
	name = Foo
	name = Foo2
# git config --global user.name Foo - return 5 and message
"warning: user.name has multiple values
error: cannot overwrite multiple values with a single value
       Use a regexp, --add or --replace-all to change user.name."

It's just an opinion, but this behaviour is no consistent for me.

If it's not the bug it's a feature just let me know.

Bests,
Alex
