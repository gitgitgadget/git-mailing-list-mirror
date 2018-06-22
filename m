Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2FFE1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 09:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeFVJQK (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 05:16:10 -0400
Received: from mail.javad.com ([54.86.164.124]:53150 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbeFVJQF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 05:16:05 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id C05053EA4B;
        Fri, 22 Jun 2018 09:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1529658965;
        bh=UTTB6Wk/bwJS1n15QgW44WXQGlww7c3wA8rt0Q1hVmg=; l=976;
        h=Received:From:To:Subject;
        b=eBVk6BvSuujOnpCjJkkXEH1ebG2EZRpQwNwSXFIdD3vMjA8J3mbiR24snhzOCec+u
         b9S80ZMTLrv0KzeW9wmxy9hA2hEcARAm4UwP9w3EmrJrKRh6jbRsdwocz5vpid03Bj
         VgHYfhQZzgbqM5h1StTE+RjRrHUytaXghoYzdlI8=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1fWIAl-0006Tw-3Z; Fri, 22 Jun 2018 12:16:03 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is specified
References: <87efh0pdln.fsf@javad.com>
        <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 22 Jun 2018 12:16:03 +0300
In-Reply-To: <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 21 Jun 2018 08:54:17 -0700")
Message-ID: <874lhvmbak.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> When cherry-picking multiple commits, it's impossible to have both
>> merge- and non-merge commits on the same command-line. Not specifying
>> '-m 1' results in cherry-pick refusing to handle merge commits, while
>> specifying '-m 1' fails on non-merge commits.
>
> Allowing "-m1" even when picking a single parent commit, because
> the 1-st parent is defined for such a commit, makes sense, espeially
> when running a cherry-pick on a range, exactly for the above reason.
> It is slightly less so when cherry-picking a single commit, but not
> by a large margin.

[...]

>> +	} else if (1 < opts->mainline)
>> +		/* Non-first parent explicitly specified as mainline for
>> +		 * non-merge commit */
>
> Style.
>
> 	/*
> 	 * Our multi-line comments are to be
> 	 * formatted like this.
> 	 */

Ah, sorry for that. Will you fix it for me?

Thanks!

-- Sergey
