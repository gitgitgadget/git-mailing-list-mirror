Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D623D1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbdJ0PCn (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:02:43 -0400
Received: from siwi.pair.com ([209.68.5.199]:34950 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751380AbdJ0PCm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 11:02:42 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1F016844EB;
        Fri, 27 Oct 2017 11:02:42 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AB298844E9;
        Fri, 27 Oct 2017 11:02:41 -0400 (EDT)
Subject: Re: [PATCH] dir: allow exclusions from blob in addition to file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171026180222.39421-1-git@jeffhostetler.com>
 <20171026180222.39421-2-git@jeffhostetler.com>
 <xmqq8tfxe693.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <937c3ec0-fb9b-0f11-b00d-f015d8e4bf4b@jeffhostetler.com>
Date:   Fri, 27 Oct 2017 11:02:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tfxe693.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/26/2017 9:20 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Refactor add_excludes() to separate the reading of the
>> exclude file into a buffer and the parsing of the buffer
>> into exclude_list items.
>>
>> Add add_excludes_from_blob_to_list() to allow an exclude
>> file be specified with an OID without assuming a local
>> worktree or index exists.
>>
>> Refactor read_skip_worktree_file_from_index() and add
>> do_read_blob() to eliminate duplication of preliminary
>> processing of blob contents.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
> 
> Yeah, with a separate do_read_blob() helper, this one looks a lot
> easier to follow, at least to me---as the author, you might find the
> earlier one just as easy, I suspect, though ;-)
> 
> Thanks.  Will queue.
> 

Yeah, I think the net result is better and easier to follow.
Thanks,
Jeff
