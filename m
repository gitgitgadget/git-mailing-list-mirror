Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416DC1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 13:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbdJFNtq (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 09:49:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751717AbdJFNtq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 09:49:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6629883C2;
        Fri,  6 Oct 2017 13:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com D6629883C2
Authentication-Results: ext-mx02.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx02.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=pbonzini@redhat.com
Received: from [10.36.117.208] (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DD1C63773;
        Fri,  6 Oct 2017 13:49:44 +0000 (UTC)
Subject: Re: [RFC PATCH 0/4] interpret-trailers: introduce "move" action
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <20171005132243.27058-1-pbonzini@redhat.com>
 <CAP8UFD1X-aRN5sAB5PQt04jL_92APK279bjNf=Zt_x8KOxyL+A@mail.gmail.com>
 <748131b7-bddd-08c2-ff72-9fd1a63ef6a0@redhat.com>
 <CAP8UFD28vVx51xhDgQVesm356XAjfwb286baER-U6VOC+4NL4w@mail.gmail.com>
 <fe023f38-01cc-2257-bbfe-3f4310193b41@redhat.com>
 <CAP8UFD2_ZC4J4eRxq04TJ6-xyK5oTqHM2qd+5HfPV7jcoShvqw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5dc97064-7d6a-b32d-c25b-202f85041373@redhat.com>
Date:   Fri, 6 Oct 2017 15:49:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2_ZC4J4eRxq04TJ6-xyK5oTqHM2qd+5HfPV7jcoShvqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 06 Oct 2017 13:49:46 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10/2017 15:19, Christian Couder wrote:
> Now it would be strange to have "moveIfClosest" without having "move"
> first and I don't see how "move" would be different from the existing
> "replace".
> Or maybe "move" means "replaceIfIdentical", in this case I think it
> would help users to just call it "replaceIfIdentical".

Well, the effect of "replacing if identical" *is* to move the existing
identical trailer to the new position. :)

Paolo
