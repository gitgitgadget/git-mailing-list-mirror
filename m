Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 108671F461
	for <e@80x24.org>; Mon,  2 Sep 2019 15:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfIBPwU (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 11:52:20 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:45488 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfIBPwT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 11:52:19 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i4ocr-0001Za-9T; Mon, 02 Sep 2019 16:52:18 +0100
Subject: Re: Retrieve version-string on shallow clone
To:     Reino Wijnsma <rwijnsma@xs4all.nl>, git@vger.kernel.org
References: <26d7f32e-2df5-ce39-cd20-8cd82dc8587c@xs4all.nl>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <26794b96-8627-0d73-c548-91b0ea7fde83@iee.email>
Date:   Mon, 2 Sep 2019 16:52:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <26d7f32e-2df5-ce39-cd20-8cd82dc8587c@xs4all.nl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Reino

On 01/09/2019 12:07, Reino Wijnsma wrote:
> Hello git@vger.kernel.org,
>
> Two days ago I started https://github.com/mstorsjo/fdk-aac/issues/107, asking how to retrieve the fdk-aac version-string on a shallow clone.
> My question was of course not fdk-aac related, so Martin Storsjö suggested I'd try here. It basicly comes down to this:
>
> git clone https://github.com/mstorsjo/fdk-aac.git
> [...]
>
> git describe --tags
> v2.0.0-185-gcc5c85d
>
> git clone --depth 1 https://github.com/mstorsjo/fdk-aac.git
>
> git describe --tags
> fatal: No names found, cannot describe anything.
>
> The tags get lost while doing a shallow clone.
> I'm not an expert git user, so I was wondering if anyone could tell what my options are here.
> I'd figure one of these options would be to clone everything from tag v2.0.0 onward, but if so how would I do that?
> As another option I was thinking; maybe it's possible to do git describe --tags on the remote repo?
>
This is most likely a mental model problem.

If you only have a depth = 1 level clone, then there is no history 
available locally to use from which to describe almost anything.
Even if you had all the tags (without the actual commits they tagged) 
you still don't have that history upon which to describe them.

Start by getting a bit more history depth, then see if you need to fetch 
some of the tags (or at least any specific tags of interest).

Philip

