Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6261F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 00:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfAQAPO (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 19:15:14 -0500
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:45486 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727397AbfAQAPO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Jan 2019 19:15:14 -0500
Received: from resomta-po-15v.sys.comcast.net ([96.114.154.239])
        by resqmta-po-07v.sys.comcast.net with ESMTP
        id jv9Fgb9DRfdPwjvL0gJ8FX; Thu, 17 Jan 2019 00:15:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1547684114;
        bh=nA0WspaTycyyXfZq/l7QEWNrYoIgHrqNRem8R4hd5b8=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=AEf3Rz3LCl12AFovtStZpAlsYclHH37VdiFA1Hahd/5iDlUt7gJSbnjK+CQDFIWwH
         hPQriAhYSL0tMbEE5lckie+YNj88+/5mNl1P9JBcQokBRF5iBkdkVWRZCvbhu0/2EW
         tdvnm5o6qRyOehdpLw2dOjhDLWFWbNWhZnmgZgqI0H9PPIkKwuj8iIGnRTi+ODb+mR
         yWDK54YOgtjG35+wj3u1Gtti+RQwHHEPnolXU8PQcSnrvft0q1XkDwgoCULQOn6yfN
         1uq5wQkjBMGTTwpDMxq26lvcEgszWcQd0wNHrJcrSRxE1jpZYO+OpX2XvWUebMYPSx
         i+XRZPLMC1pOw==
Received: from maqku.svl.corp.google.com ([IPv6:2620:0:100e:913:d03c:28a5:6852:5bde])
        by resomta-po-15v.sys.comcast.net with ESMTPSA
        id jvKigxxAI3iLtjvKngLj7M; Thu, 17 Jan 2019 00:15:11 +0000
X-Xfinity-VMeta: sc=??;st=legit
Subject: Re: [PATCH v3 0/2] support for filtering trees and blobs based on
 depth
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org
References: <20190109025914.247473-1-matvore@google.com>
 <20190109180633.10273-1-jonathantanmy@google.com>
 <xmqqftttpk8w.fsf@gitster-ct.c.googlers.com>
 <xmqqbm4hpjyg.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@comcast.net>
Message-ID: <04d6b46f-da87-bde2-1511-a9f2071bf034@comcast.net>
Date:   Wed, 16 Jan 2019 16:14:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqbm4hpjyg.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2019/01/15 15:41, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> This is turning out to be messier than I like.
>>
>> The topic is tangled with too many things in flight and I think I
>> reduced its dependencies down to nd/the-index and
>> sb/more-repo-in-api plus then-current tip of master (and that is why
>> it is based on a1411cecc7), but it seems that it wants a bit more
>> than that; builtin/rebase.c at its tip does not even compile, so
>> I'll need to wiggle the topic before it can go to 'next'.
> Half false alarm.  I do need to wiggle the topic, but that was not
> because the choice of base was bad.  It was that nd/the-index plus
> sb/more-repo-in-api had semantic merge conflicts with the then-current
> master.

If I understand right, this is a product of the fact that you had to 
merge these branches together and base my change on top of them, and 
that is a result of that fact that I didn't work on top of master for 
the first iterations of the patch.


Sorry about that. My last re-roll was based on master (commit 77556354) 
but I guess before I sent that version of the patch set I had already 
done some damage by working off of next for the earlier patches.


I think my last version of the patch was fine since it was based off 
master. Let me know if I've misunderstood.


>> And worse yet, it seems that filter-options-should-use-plain-int
>> topic depends on this topic in turn as it wants to use
>> LOFC_TREEE_DEPTH.
> This part is still true.  The scaling-factor-over-the-wire topic
> does need to be rebuilt on top of this one.

This seems like a easier problem to understand, but I'm not sure how to 
avoid this issue in the future.


Thanks,
Matt

