Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FD6C433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 17:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355536AbhLDRD1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 4 Dec 2021 12:03:27 -0500
Received: from mx7.b2b2c.ca ([66.158.128.85]:50930 "EHLO mx7.b2b2c.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355453AbhLDRD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 12:03:27 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Dec 2021 12:03:26 EST
Received: from dermoth.dyndns.org (dsl-10-148-225.b2b2c.ca [72.10.148.225])
        by mx7.b2b2c.ca (8.14.7/8.14.7) with ESMTP id 1B4Gpl0l025492
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 4 Dec 2021 11:51:47 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mx7.b2b2c.ca 1B4Gpl0l025492
Received: from localhost ([::1])
        by dermoth.dyndns.org with esmtp (Exim 4.94.2)
        (envelope-from <thomas@guyot-sionnest.net>)
        id 1mtYGF-00DjQI-9F; Sat, 04 Dec 2021 11:51:43 -0500
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
References: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
 <20211203195856.7lfcy4gfvheb7lau@meerkat.local>
From:   Thomas Guyot-Sionnest <thomas@guyot-sionnest.net>
Subject: Re: Large delays in mailing list delivery?
Message-ID: <2cd4a07b-6ffe-15f9-c8d4-fab322a79d2f@guyot-sionnest.net>
Date:   Sat, 4 Dec 2021 11:51:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211203195856.7lfcy4gfvheb7lau@meerkat.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-12-03 14:58, Konstantin Ryabitsev wrote:
> On Fri, Dec 03, 2021 at 11:52:58AM -0800, Elijah Newren wrote:
>> Are there some rather large delays in mailing list delivery these
>> days?  Anyone know who to contact to investigate?  [*]
> The right person to contact is postmaster@vger.kernel.org, however I can
> actually answer your question (despite not actually being in charge of
> vger.kernel.org). Periodically, Gmail decides that there's just too much
> incoming mail for some accounts and will arbitrarily delay delivery by
> returning a "this account is receiving too much mail, please try later."
>
> I am willing to bet that this is what happened to you.

I have already contacted postmaster and they are aware, however you add
very good point. Somehow I knew it but it's the way you put it that made
me realize: the emails are sent in bulk to gmail (to many or all
recipients for a single copy at once). The mail header even shows this,
listing the first recipient followed by "+ 99 others". If it's delayed
for all because of a single recipient that can only be because the 4xx
error is returned at the end of the DATA command (rather than on a
specific RCPT TO command), so no way for the sender to retry that single
faulty address alone later.

I'm not sure if their software allows it but I suggested sending to a
single recipient at a time for gmail, that would solve the issue.

In the meantime what I did is switch my subscription to another email
using a forwarder address on a domain I own - I still haven't received
all the backlog but at least I'm getting new posts timely now.

Regards,

--
Thomas

