Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37BC620954
	for <e@80x24.org>; Mon,  4 Dec 2017 22:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbdLDW5i (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 17:57:38 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:42190 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdLDW5i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 17:57:38 -0500
Received: from [192.168.178.21] (x4d077b3a.dyn.telefonica.de [77.7.123.58])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id B303C14080D;
        Mon,  4 Dec 2017 23:57:36 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.123.58) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Received-SPF: pass (mxf98a: connection is authenticated)
Subject: Re: [PATCH v2 1/2] git-prompt: make __git_eread intended use explicit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <alpine.DEB.2.21.1.1712011143320.98586@virtualbox>
 <20171201233133.30011-1-rabel@robertabel.eu>
 <xmqqindmml25.fsf@gitster.mtv.corp.google.com>
From:   Robert Abel <rabel@robertabel.eu>
Message-ID: <e8d35c35-ffd5-ef10-bc6a-0834c1703995@robertabel.eu>
Date:   Mon, 4 Dec 2017 23:57:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqindmml25.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <20171204225736.14882.50409@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 04 Dec 2017 18:58, Junio C Hamano wrote:
> Robert Abel <rabel@robertabel.eu> writes:
>> __git_eread is used to read a single line of a given file (if it exists)
>> into a variable without the EOL. All six current users of __git_eread
>> use it that way and don't expect multi-line content.
> 
> Changing $@ to $2 does not change whether this is about "multi-line"
> or not. 

I'm aware of that. I was documenting current usage. The function is used
to read file contents (which are expected to be a single line) into
_a_ (i.e. single) variable.

None of the current users of the function expect tokens to be split,
which is why I removed it in preparation of patch 2/2, which would
break tokenizing file contents.

Regards,

Robert
