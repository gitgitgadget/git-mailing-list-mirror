Return-Path: <SRS0=Mgdg=4W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56307C3F2D1
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 23:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2988820801
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 23:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEXpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:45:11 -0500
Received: from siwi.pair.com ([209.68.5.199]:39815 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgCEXpL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 18:45:11 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 18:45:10 EST
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EDA813F486C;
        Thu,  5 Mar 2020 18:40:06 -0500 (EST)
Received: from [192.168.1.6] (251.sub-174-195-210.myvzw.com [174.195.210.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6F7763F486B;
        Thu,  5 Mar 2020 18:40:06 -0500 (EST)
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
References: <20200302230400.107428-1-emilyshaffer@google.com>
 <20200302230400.107428-3-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com>
Date:   Thu, 5 Mar 2020 18:34:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/4/2020 4:35 PM, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 2 Mar 2020, Emily Shaffer wrote:
> 
>>   .gitignore                      |   1 +
>>   Documentation/git-bugreport.txt |  46 ++++++++++++++
>>   Makefile                        |   5 ++
>>   bugreport.c                     | 105 ++++++++++++++++++++++++++++++++
>>   command-list.txt                |   1 +
>>   strbuf.c                        |   4 ++
>>   strbuf.h                        |   1 +
>>   t/t0091-bugreport.sh            |  61 +++++++++++++++++++
>>   8 files changed, 224 insertions(+)
>>   create mode 100644 Documentation/git-bugreport.txt
>>   create mode 100644 bugreport.c
>>   create mode 100755 t/t0091-bugreport.sh
> 
> Hmm. I am still _quite_ convinced that this would be much better as a
> built-in. Remember, non-built-ins come with a footprint, and I do not
> necessarily think that you will want to spend 3MB on a `git-bugreport`
> executable when you could have it for a couple dozen kilobytes inside
> `git` instead.
> 
> Ciao,
> Dscho

Having this command be a stand-alone exe rather than a builtin allows
it to have a different linkage.  For example, you could include the
libcurl and other libraries that are only linked into the transports.
And then report version numbers for them if you wanted.

Jeff
