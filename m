Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BA0C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 15:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5DA6100B
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 15:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhFCPfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 11:35:43 -0400
Received: from mail.efficios.com ([167.114.26.124]:58866 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCPfn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 11:35:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E594131C75D;
        Thu,  3 Jun 2021 11:33:57 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eJCp_a_nWEsK; Thu,  3 Jun 2021 11:33:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8672F31CA04;
        Thu,  3 Jun 2021 11:33:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8672F31CA04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1622734437;
        bh=DKp9Kn9IOFj0rAa1smoreoI1xPw87j9ngxQ24mYrJBs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=W0NLN8o2HF9zHyJNFN8BDFot3aaEfAH2+zoVLTmd57z+jKtE6U5EZcAprQHQ+vOCh
         qpg93Ht8CIYSYPxeg0yDDT/rI1nuCyNBYRqYANHbfPRPUTiaWD8rracpx2KhvwfJSu
         UT8hNkzFCWbsvoDGL7a+FM2r1YhKRCMw2YNogE+SH4P/H+/q7krRXge0Qr7YWMQ+LX
         C+47md2mINyIRJtq1LIBfefRlwm4GwfzRGbq2jiYozeE3I0kfR+qfcjaOTOxkW3bi3
         E0rAhytfp7wydLmIjOhz85W7ZYu7IY03t6lx3NLVFfRkJhC49qxM6PUKkkRwpl0EuD
         0ZzqS91BP7xnA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7cKoZnbOfF31; Thu,  3 Jun 2021 11:33:57 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 765FB31C813;
        Thu,  3 Jun 2021 11:33:57 -0400 (EDT)
Date:   Thu, 3 Jun 2021 11:33:57 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        git <git@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <654904857.6915.1622734437354.JavaMail.zimbra@efficios.com>
In-Reply-To: <YLfe+HXl4hkzs44b@nand.local>
References: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com> <YLej6F24Emm7SX35@zeniv-ca.linux.org.uk> <YLfe+HXl4hkzs44b@nand.local>
Subject: Re: git feature request: git blame
 --ignore-cleanup/--ignore-trivial
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4026)
Thread-Topic: git feature request: git blame --ignore-cleanup/--ignore-trivial
Thread-Index: XLr69/WnC7jKcuBW+k7l9LYtwadObQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

----- On Jun 2, 2021, at 3:41 PM, Taylor Blau me@ttaylorr.com wrote:

> On Wed, Jun 02, 2021 at 03:29:44PM +0000, Al Viro wrote:
>> > Any maybe the patterns associated to "cleanup" and "trivial" commits
>> > should be something that can be configured through a git config
>> > file.
>>
>> Just an observation: quite a few subtle bugs arise from mistakes in
>> what should've been a trivial cleanup.  Hell, I've seen bugs coming
>> from rebase of provably no-op patches - with commit message unchanged.
>> So IME this is counterproductive...
> 
> Yes, I find excluding revisions from 'git blame' to be rarely useful,
> exactly for this reason.
> 
> You could probably use the '--ignore-revs-file' option of 'git blame' to
> exclude commits you consider trivial ahead of time. If you had an
> 'Is-trivial' trailer, I would probably do something like:
> 
>  $ git log --format='%H %(trailers:key=Is-trivial)' |
>      grep "Is-trivial: true" | cut -d" " -f1 >exclude
>  $ git blame --ignore-revs-file exclude ...

Nice trick! So within a project which standardize on a "Cleanup: " prefix
at the beginning of the patch subject, this would look like:

git log --format='%H Subject=("%s")' file.c | grep 'Subject=(\"Cleanup: ' | cut -d" " -f1 > exclude.txt
git blame --ignore-revs-file exclude.txt file.c

I fully understand that in many cases having the entire set of revisions is
needed, because even a cleanup patch could be buggy, but IMHO it's nice to
have a way to achieve this in situations where the cleanup patches get in the
way of figuring out the most recent behavior changes in a given area of the
code.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
