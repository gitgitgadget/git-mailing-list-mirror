Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5982036C
	for <e@80x24.org>; Fri,  6 Oct 2017 12:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbdJFMjz (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 08:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbdJFMjz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 08:39:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16EAD2027C;
        Fri,  6 Oct 2017 12:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 16EAD2027C
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=pbonzini@redhat.com
Received: from [10.36.117.208] (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7BF360F8B;
        Fri,  6 Oct 2017 12:39:52 +0000 (UTC)
Subject: Re: [RFC PATCH 0/4] interpret-trailers: introduce "move" action
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <20171005132243.27058-1-pbonzini@redhat.com>
 <CAP8UFD1X-aRN5sAB5PQt04jL_92APK279bjNf=Zt_x8KOxyL+A@mail.gmail.com>
 <748131b7-bddd-08c2-ff72-9fd1a63ef6a0@redhat.com>
 <CAP8UFD28vVx51xhDgQVesm356XAjfwb286baER-U6VOC+4NL4w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe023f38-01cc-2257-bbfe-3f4310193b41@redhat.com>
Date:   Fri, 6 Oct 2017 14:39:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD28vVx51xhDgQVesm356XAjfwb286baER-U6VOC+4NL4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 06 Oct 2017 12:39:55 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10/2017 14:33, Christian Couder wrote:
> Ok. I think you might want something called for example
> "replaceIfIdenticalClose" where "IdenticalClose" means: "there is a
> trailer with the same (<token>, <value>) pair above or below the line
> where the replaced trailer will be put when ignoring trailers with a
> different <token>".

So basically "moveIfClosest" (move if last for where=end, move if first
for where=begin; for where=after and where=before it would just end up
doing nothing)?  It's not hard to implement, but I'm wondering if it's
too ad hoc.

Paolo
