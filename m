Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207CE1F42D
	for <e@80x24.org>; Tue, 27 Mar 2018 10:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeC0Kih (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 06:38:37 -0400
Received: from siwi.pair.com ([209.68.5.199]:39115 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbeC0Kig (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 06:38:36 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3503B3F4012;
        Tue, 27 Mar 2018 06:38:36 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1FADE3F4005;
        Tue, 27 Mar 2018 06:38:36 -0400 (EDT)
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
To:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
References: <CAGZ79kbAOcwaRzjuMtZ_HVsYvUr_7UAPbOcnrmPgsdE19q=PrQ@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <95add9fa-85f2-4c2b-4610-dc32edd78acf@jeffhostetler.com>
Date:   Tue, 27 Mar 2018 06:38:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbAOcwaRzjuMtZ_HVsYvUr_7UAPbOcnrmPgsdE19q=PrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/26/2018 7:39 PM, Stefan Beller wrote:
> coverity scan failed for the last couple month (since Nov 20th)
> without me noticing, I plan on running it again nightly for the
> Git project.
> 
> Anyway, here are issues that piled up (in origin/pu) since then.
> 
> Stefan
> 
> 
> ---------- Forwarded message ----------
[...]
________________________________________________________________________________________________________
> *** CID 1433539:  Null pointer dereferences  (FORWARD_NULL)
> /t/helper/test-json-writer.c: 278 in scripted()
> 272             struct json_writer jw = JSON_WRITER_INIT;
> 273             int k;
> 274
> 275             if (!strcmp(argv[0], "@object"))
> 276                     jw_object_begin(&jw);
> 277             else if (!strcmp(argv[0], "@array"))
>>>>      CID 1433539:  Null pointer dereferences  (FORWARD_NULL)
>>>>      Passing "&jw" to "jw_array_begin", which dereferences null "jw.levels".
> 278                     jw_array_begin(&jw);
> 279             else
> 280                     die("first script term must be '@object' or
> '@array': '%s'", argv[0]);
> 281
> 282             for (k = 1; k < argc; k++) {
> 283                     const char *a_k = argv[k];
> 
> ** CID 1433538:  Null pointer dereferences  (FORWARD_NULL)
> 

The "jw.levels" field has been removed in the json-writer V4 reroll,
so this isn't an issue going forward.

Thanks,
Jeff
