Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBCE21F462
	for <e@80x24.org>; Tue, 21 May 2019 21:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfEUVGD (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 17:06:03 -0400
Received: from siwi.pair.com ([209.68.5.199]:47455 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfEUVGD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 17:06:03 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 985763F4094;
        Tue, 21 May 2019 17:06:02 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:101d:dfe8:f4b5:4e4b] (unknown [IPv6:2001:4898:a800:1012:c150:dfe8:f4b5:4e4b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 575493F408A;
        Tue, 21 May 2019 17:06:02 -0400 (EDT)
Subject: Re: Cygwin Git Performance
To:     Nathan and Ila Reynolds <nathanila@gmail.com>, git@vger.kernel.org
References: <01cf52cb-7e90-efde-a06c-f0413f9efc8a@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5d06cf4a-c29f-335f-52f9-c6c35369b673@jeffhostetler.com>
Date:   Tue, 21 May 2019 17:06:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <01cf52cb-7e90-efde-a06c-f0413f9efc8a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/21/2019 10:34 AM, Nathan and Ila Reynolds wrote:
> I am not sure if this is the right mailing list.  If not, please 
> redirect me to the right place.
> 
> I have Cygwin's git (2.21.0) and Git for Windows (2.21.0) installed on 
> my Windows 10 machine.  I run the following command with each binary 
> "git push --all" on a simple 2 line change to 1 file.  If I use Cygwin's 
> git, then the operation takes almost 5 minutes.  If I use Git for 
> Windows, then the operation takes almost 20 seconds.  I tried using 
> --verbose to figure out why Cygwin's git is so slow but it does not 
> reveal anything to me as to why.  What can I do to figure out why 
> Cygwin's git is so slow? I am hoping that we can get to the bottom of 
> this and it can be fixed to help all users.
> 


You might try turning on GIT_TRACE_PERFORMANCE [1] and see if that
shows any differences.

If you can install 2.22.0-rc* versions of both, you can turn on
GIT_TR2_PERF [2] and some additional details.

If your repo is very large, it may be due to some Windows file system
optimizations present in the Git for Windows version.

[1] https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables
[2] 
https://github.com/git/git/blob/master/Documentation/technical/api-trace2.txt#L80


Hope that helps,
Jeff
