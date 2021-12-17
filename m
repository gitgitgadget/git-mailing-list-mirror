Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9716C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 11:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbhLQLEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:04:50 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:63818 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbhLQLEu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 06:04:50 -0500
Received: from [91.113.179.170] (helo=[192.168.92.29])
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1myB2E-0003vQ-Du
        for git@vger.kernel.org; Fri, 17 Dec 2021 12:04:22 +0100
Message-ID: <505637a9-f6de-8f0d-b5cf-e765388f9301@syntevo.com>
Date:   Fri, 17 Dec 2021 12:04:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Should update-index --refresh force writing the index in case of
 racy timestamps?
Content-Language: en-US
From:   Marc Strapetz <marc.strapetz@syntevo.com>
To:     git@vger.kernel.org
References: <d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com>
In-Reply-To: <d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/12/2021 11:44, Marc Strapetz wrote:
> Subsequent calls to "git update-index --refresh" or "git status" will invoke the "lfs" 
> filter over and over again, ...

Please forget about the note regarding "git status". cmd_status() will 
actually fix racy timestamps by calling repo_update_index_if_able(). So 
the problem is only about update-index.

-Marc
