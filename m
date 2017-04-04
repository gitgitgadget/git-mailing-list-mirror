Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9A920964
	for <e@80x24.org>; Tue,  4 Apr 2017 15:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754510AbdDDPUZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 11:20:25 -0400
Received: from avasout07.plus.net ([84.93.230.235]:35268 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754480AbdDDPUY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 11:20:24 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id 4FL21v0011keHif01FL3Lu; Tue, 04 Apr 2017 16:20:04 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Y8KIilWN c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=KFpA8Q4GAAAA:8 a=NzzK-pF66Q6r9Dt0gJIA:9 a=QEXdDO2ut3YA:10
 a=n8sMt3pHIuYvP_eQiBdH:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v5] http.postbuffer: allow full range of ssize_t values
To:     David Turner <dturner@twosigma.com>, git@vger.kernel.org
References: <20170403235308.30102-1-dturner@twosigma.com>
Cc:     tboegi@web.de
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <3d351f90-af4f-1ddb-c8a0-3e7926fd722d@ramsayjones.plus.com>
Date:   Tue, 4 Apr 2017 16:20:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170403235308.30102-1-dturner@twosigma.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/04/17 00:53, David Turner wrote:
> Unfortunately, in order to push some large repos, the http postbuffer
> must sometimes exceed two gigabytes.  On a 64-bit system, this is OK:
> we just malloc a larger buffer.
> 
> This means that we need to use CURLOPT_POSTFIELDSIZE_LARGE to set the
> buffer size.
> 
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
> 
> V5 addresses comments from Torsten Boegershausen and Ramsay Jones.  Since
> I don't have a 32-bit machine handy, it's difficult for me to check
> for compiler warnings on 32-bit machines.  Hopefully my guess as
> to the solution to Ramsay's issue will be correct.

Yep, this compiles without complaint.

Thanks!

ATB,
Ramsay Jones
