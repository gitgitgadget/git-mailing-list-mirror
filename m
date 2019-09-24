Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23571F463
	for <e@80x24.org>; Tue, 24 Sep 2019 10:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409471AbfIXKbo (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 06:31:44 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:32866 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfIXKbn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 06:31:43 -0400
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iCi6d-0007DM-Gs; Tue, 24 Sep 2019 12:31:39 +0200
Subject: Re: [PATCH v2 2/2] t0028: add more tests
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.347.git.gitgitgadget@gmail.com>
 <pull.347.v2.git.gitgitgadget@gmail.com>
 <40e54cf5ce74d1404187e31c94644df29134b4ff.1569233057.git.gitgitgadget@gmail.com>
 <163fcc3c-e827-ad15-5987-a2ae93a0bec2@kdbg.org>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <9f681989-b2cf-ff66-b2e8-2a2823d5609c@syntevo.com>
Date:   Tue, 24 Sep 2019 12:31:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <163fcc3c-e827-ad15-5987-a2ae93a0bec2@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24.09.2019 8:21, Johannes Sixt wrote:
> What are we testing here? Is there some back-and-forth conversion going
> on, and are we testing that the conversion happens at all, or that the
> correct conversion/encoding is picked, or that the conversion that is
> finally chosen is correct? Why does it help to test more interesting
> chars (and would you not also regard codepoints outside the BMP the most
> interesting because they require surrogate codepoints in UTF-16)?

According to my understanding (I'm not the author of test package),
it is designed to test that various encodings are properly supported
by git in the working tree.

The new tests are designed to avoid any back-and-forth, which actually
happened for the previous UTF-16-LE-BOM test, which in turn hidden
that the test was bugged.

Otherwise, the test verifies that if you requested some encoding, you
get exactly that, and it covers various potential problems at once.

 > Why does it help to test more interesting chars (and would you not
 > also regard codepoints outside the BMP the most interesting because
 > they require surrogate codepoints in UTF-16)?
					
It helps to cover more potential problems. One could agree that
converting latin characters is mostly about padding/dropping zero
chars, but this approach could never work for the chars I used. As for
"outside the BMP", I'm simply not experienced with that. If you are,
you're welcome to further improve the tests I added.

