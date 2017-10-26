Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E661FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 07:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbdJZHWP (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 03:22:15 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:35469 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbdJZHWO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 03:22:14 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Thu, 26 Oct 2017 09:22:14 +0200
  id 0000000000000041.0000000059F18D26.00004E86
Date:   Thu, 26 Oct 2017 09:22:13 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] color-moved: ignore all space changes by default
Message-ID: <20171026072213.p6llaqrbdss7nbu4@ruderich.org>
References: <20171025224620.27657-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20171025224620.27657-1-sbeller@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 25, 2017 at 03:46:18PM -0700, Stefan Beller wrote:
> On Mon, Oct 23, 2017 at 7:52 PM, Stefan Beller wrote[1]:
>> On Mon, Oct 23, 2017 at 6:54 PM, Junio C Hamano wrote:
>>>
>>>  * As moved-lines display is mostly a presentation thing, I wonder
>>>    if it makes sense to always match loosely wrt whitespace
>>>    differences.
>>
>> Well, sometimes the user wants to know if it is byte-for-byte identical
>> (unlikely to be code, but maybe column oriented data for input;
>> think of all our FORTRAN users. ;)
>
> ... and this is the implementation and the flip of the default setting
> to ignore all white space for the move detection.

Hello,

I'm not sure if this is a good default. I think it's not obvious
that moved code gets treated differently than regular changes. I
wouldn't expect git diff to ignore whitespace changes (without me
telling it to) and so when I see moved code I expect they were
moved as is.

And there are languages where indentation is relevant (e.g.
Python, YAML) and as color-moved is also treated as review tool
to detect unwanted changes this new default can be dangerous.

The new options sound like a good addition but I don't think the
defaults should change. However unrelated to this decision,
please add config settings in addition to these new options so
users can globally configure the behavior they want.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
