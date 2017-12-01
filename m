Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7552220954
	for <e@80x24.org>; Fri,  1 Dec 2017 17:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbdLARZe (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 12:25:34 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:62896 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750988AbdLARZd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 12:25:33 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3ypLky5d2sz5tlH;
        Fri,  1 Dec 2017 18:25:30 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 48A2E211E;
        Fri,  1 Dec 2017 18:25:30 +0100 (CET)
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Dan Jacques <dnj@google.com>, git@vger.kernel.org,
        gitster@pobox.com, avarab@gmail.com
References: <20171129155637.89075-1-dnj@google.com>
 <20171129155637.89075-2-dnj@google.com>
 <3c897f4c-0cb5-ca44-f144-598a623c1dc3@kdbg.org>
 <alpine.DEB.2.21.1.1712011812250.98586@virtualbox>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <97acc3d3-5c6a-2e65-a372-24def5b21d54@kdbg.org>
Date:   Fri, 1 Dec 2017 18:25:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1712011812250.98586@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.12.2017 um 18:13 schrieb Johannes Schindelin:
> Hi Hannes,
> 
> On Fri, 1 Dec 2017, Johannes Sixt wrote:
> 
>> Am 29.11.2017 um 16:56 schrieb Dan Jacques:
>>> @@ -1989,6 +1986,15 @@ GIT-PERL-DEFINES: FORCE
>>>         	echo "$$FLAGS" >$@; \
>>>         fi
>>>    +GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak
>>> Makefile
>>> +	$(QUIET_GEN)$(RM) $@ && \
>>> +	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory
>>> instlibdir` && \
>>> +	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>>> +	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" &&
>>> \
>>> +	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
>>
>> This doesn't work, unfortunately. When $(pathsep) is ';', we get an incomplete
>> sed expression because ';' is also a command separator in the sed language.
> 
> Funny, I tried this also with ';' as pathsep, and it worked in the Git for
> Windows SDK...

My ancient sed vs. your modern sed, perhaps? I can check this on Monday.

-- Hannes
