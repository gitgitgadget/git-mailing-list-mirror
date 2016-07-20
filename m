Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A701202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 15:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbcGTPuQ (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 11:50:16 -0400
Received: from siwi.pair.com ([209.68.5.199]:44248 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754924AbcGTPuM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 11:50:12 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 1506984626;
	Wed, 20 Jul 2016 11:50:11 -0400 (EDT)
Subject: Re: [PATCH v1 6/6] Unit tests for V2 porcelain status
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-7-git-send-email-jeffhost@microsoft.com>
 <578F9923.3000403@gmail.com>
Cc:	peff@peff.net, gitster@pobox.com
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <578F9D2A.2030204@jeffhostetler.com>
Date:	Wed, 20 Jul 2016 11:47:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <578F9923.3000403@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/20/2016 11:30 AM, Jakub Narêbski wrote:
> W dniu 2016-07-20 o 00:10, Jeff Hostetler pisze:
>> +test_expect_success pre_initial_commit_0 '
>> +	printf "## branch: (initial) master\n" >expected &&
>> +	printf "?? actual\n" >>expected &&
>> +	printf "?? dir1/\n" >>expected &&
>> +	printf "?? expected\n" >>expected &&
>> +	printf "?? file_x\n" >>expected &&
>> +	printf "?? file_y\n" >>expected &&
>> +	printf "?? file_z\n" >>expected &&
>
> Why not use heredoc syntax (cat <<\EOF), or prepare a file
> with expected output in the testsuite?
>

The tests involving renames needed to embed a tab character
in the output and hiding a tab character in a heredoc seemed
error prone.  So to be consistent I made them all printf-style.

Also, some of the tests include SHAs for the commit and for
file content, so having pre-computed expected output is awkward.
Granted we could hard code the file SHAs, but not the commits.

Jeff
