Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BC982018D
	for <e@80x24.org>; Thu, 11 May 2017 05:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754837AbdEKFEu (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 01:04:50 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:54889 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdEKFEu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 01:04:50 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wNgyS1TYMz5tlB;
        Thu, 11 May 2017 07:04:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id F119842ED;
        Thu, 11 May 2017 07:04:46 +0200 (CEST)
Subject: Re: [PATCH 8/8] pathspec: convert parse_pathspec to take an index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <20170509191805.176266-1-bmwill@google.com>
 <20170509191805.176266-9-bmwill@google.com>
 <xmqq1srxxn72.fsf@gitster.mtv.corp.google.com>
 <20170510170226.GB41649@google.com>
 <xmqqh90sw4dr.fsf@gitster.mtv.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <dab1beaf-ca8d-2f3f-9fcc-22e6938a868a@kdbg.org>
Date:   Thu, 11 May 2017 07:04:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqh90sw4dr.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.05.2017 um 03:48 schrieb Junio C Hamano:
> But perhaps you are right---it may be wrong for the contents of the
> current index (or any index) to affect how a pathspec element is
> parsed in the first place.  If the current code (before this series)
> uses the_index only for error checking, we may want to separate that
> out of the parse_pathspec() callchain, so that it does not even look
> at any index (not just the_index).  And that may be a better change
> overall.

Just a reminder: if core.ignoreCase is set, the variant of a path in the 
index takes precedence over the variant found in the working tree. 
Hence, pathspec must be matched against the index that corresponds to 
the working tree. I guess that's the_index.

-- Hannes
