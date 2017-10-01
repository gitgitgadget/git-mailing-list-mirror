Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,SORTED_RECIPS shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC37F20281
	for <e@80x24.org>; Sun,  1 Oct 2017 08:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbdJAIYo (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 04:24:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62692 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750953AbdJAIYn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 04:24:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48B88963E7;
        Sun,  1 Oct 2017 04:24:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E85x3BX/oWufc9zIg1ts2MtkwOU=; b=oXTNtE
        T3+Q3omlTF6fWP0qgeSMgV3/R1cH4ru8qlc7+ihfRfQTvHvyC6F/tgxDCxELGhwf
        fmLD76PBGuw01cqZLlwMi89d7takx4zcRZ99jBmi9+XUw8DEfOadWACy/wIsrLwi
        mjLBA42b+6/rIJsQO4m32A8LxOwJxWwg7wqU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QC5tjPO+JjNcH7KG/1JTWNyT1m+vak70
        3CZuS1vYqiIL9xLwSYZop7YFfkVxprjbl9YeBZoasqwpxQdQnwwzydjx3TXvnKBv
        S9hx84WfM8ZczKR4MZZupo0VIBm++4PXV870kdAZx7rD0WQFY1z0mbg39XH+eb+J
        HZDbXwjieYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E70B963E6;
        Sun,  1 Oct 2017 04:24:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87D9A963E5;
        Sun,  1 Oct 2017 04:24:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "David.Turner\@twosigma.com" <David.Turner@twosigma.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "christian.couder\@gmail.com" <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin\@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v8 00/12] Fast git status via a file system watcher
References: <20170919192744.19224-1-benpeart@microsoft.com>
        <20170922163548.11288-1-benpeart@microsoft.com>
        <xmqq7ewiz1mz.fsf@gitster.mtv.corp.google.com>
        <MWHPR21MB0478B8D1C5442B2FCE1ED465F47E0@MWHPR21MB0478.namprd21.prod.outlook.com>
Date:   Sun, 01 Oct 2017 17:24:40 +0900
In-Reply-To: <MWHPR21MB0478B8D1C5442B2FCE1ED465F47E0@MWHPR21MB0478.namprd21.prod.outlook.com>
        (Ben Peart's message of "Fri, 29 Sep 2017 12:07:46 +0000")
Message-ID: <xmqqk20fuvg7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8FD3C98-A681-11E7-99AE-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> I had accumulated the same set of changes with one addition of removing
> a duplicate "the" from a comment in the fsmonitor.h file:
>
> diff --git a/fsmonitor.h b/fsmonitor.h
> index 8eb6163455..0de644e01a 100644
> --- a/fsmonitor.h
> +++ b/fsmonitor.h
> @@ -4,7 +4,7 @@
>  extern struct trace_key trace_fsmonitor;
>  
>  /*
> - * Read the the fsmonitor index extension and (if configured) restore the
> + * Read the fsmonitor index extension and (if configured) restore the
>   * CE_FSMONITOR_VALID state.
>   */
>  extern int read_fsmonitor_extension(struct index_state *istate, const void *data, unsigned long sz); 
>
>> 
>> Thanks.

OK, now my copy has the same, so we are in sync.  Unless there is no
more comment that benefits from a reroll of the series, let's run
with this version for now and merge it to 'next'.  Further updates
can be done incrementally on top.

Thanks.
