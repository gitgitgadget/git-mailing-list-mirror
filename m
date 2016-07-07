Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE2B20705
	for <e@80x24.org>; Thu,  7 Jul 2016 21:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbcGGVvt (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 17:51:49 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35035 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbcGGVvs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 17:51:48 -0400
Received: by mail-it0-f48.google.com with SMTP id j185so110431021ith.0
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 14:51:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IjDET7n5L25mVvK+Rxem2BFkWW6Eotzour/tlbGZLAM=;
        b=AHur2E/x43oRGeeRN3BT8+oqzMYAKi/gZScmSOimfj45+WLoi9hLJd8iuGyN4Yv0ol
         tj4wkQxYgfu+oFXvLDLp1GbKHUpCABAZfKlLBpZL3Cj5T1CTTrM+a6EP181dxqFy98GA
         W1X983em3wmPabcr+9y+FFKs5NxCJP9SR6nEv+fsNQg7VGkWmsz5m9BBUNbiGpDoFUWT
         fgXdjenYJ2q+nd7uT1CUpGSYsLPT94/J3gAYcRE2lejMYJrpY+l7oAfua7VN8KzSpV0x
         Cc6HOcccYGPdqeNR7RRa/3vk0LCRKUsus4n1Fwsh9gyOAIesJFcx9iuUpXrvkBsQxMBD
         GxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IjDET7n5L25mVvK+Rxem2BFkWW6Eotzour/tlbGZLAM=;
        b=ixwom2tUstkdMrWePqPohwpibzubZn18mmEwPltCGdOXuDQX6l4mYQMPDIb/2NMTqQ
         UEjEgKjdfUCH0hWLMMsRc1cIu+qecPoeFW2H6HYJd+dJH7fbWDuTQy+FsuAuKlArU/97
         CoRcIYRc3WM0DkLSgWhACyViVmHxxu6NKfoHWo45/6ogtTMD7flm2yEqvSLokLjIlaAH
         TNCywo2oTZBBWwLAgkjvwIvrW0JEn0DUU+1RRKS8tBbDPMcD1qOp8DMo7ahSmgQWU3nd
         MfiwBy+hitGDjlFsIeN8s6fuoEaUHVPFJTBAPfEYqs96SXGopFROQT6t8ERzxcvsoOWT
         OOoQ==
X-Gm-Message-State: ALyK8tKzmg3GwyNg2hEb5UCa5jHF4BTEDXGqKiDsm9sAV2emOsss3Mf22AOeOfRUk57gIIn8WxE2sGOb0T4ohia6
X-Received: by 10.36.95.146 with SMTP id r140mr45844itb.49.1467928307407; Thu,
 07 Jul 2016 14:51:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Thu, 7 Jul 2016 14:51:46 -0700 (PDT)
In-Reply-To: <CAPc5daUnUtUK_9caymCkhkdH7DQSEY_UhuyraJmeo9y4Mo86yQ@mail.gmail.com>
References: <20160707011218.3690-1-sbeller@google.com> <20160707011218.3690-5-sbeller@google.com>
 <xmqqinwhp6pv.fsf@gitster.mtv.corp.google.com> <CAPc5daUnUtUK_9caymCkhkdH7DQSEY_UhuyraJmeo9y4Mo86yQ@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 7 Jul 2016 14:51:46 -0700
Message-ID: <CAGZ79ka6mf3Q+cPqseffXvGkxbSYehkTe6qzzd4z-D51FwQXSQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] add a test for push options
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
	Jeff King <peff@peff.net>, Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 7, 2016 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Thu, Jul 7, 2016 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> The functions `mk_repo_pair` as well as `test_refs` are borrowed from
>>> t5543-atomic-push, with additional hooks installed.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>  t/t5544-push-options.sh | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 101 insertions(+)
>>>  create mode 100755 t/t5544-push-options.sh
>>
>> FYI:
>>
>>     Applying: add a test for push options
>>     Test number t5544 already taken
>>
>
> I'll just move it over to t5545; no need to resend.

I'd resend because of the the first three patches anyway,
so I can include a renamed version of tests, too.
