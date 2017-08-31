Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F1B1F4DD
	for <e@80x24.org>; Thu, 31 Aug 2017 09:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdHaJ6h (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 05:58:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbdHaJ6e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 05:58:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0476883CE
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 09:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com C0476883CE
Authentication-Results: ext-mx02.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx02.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=fweimer@redhat.com
Received: from oldenburg.str.redhat.com (dhcp-192-212.str.redhat.com [10.33.192.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64D9977DCE;
        Thu, 31 Aug 2017 09:58:32 +0000 (UTC)
Subject: Re: Produce contents of index with existing directory as cache
To:     David Lloyd <david.lloyd@redhat.com>
Cc:     git@vger.kernel.org
References: <5a9e4efd-8c48-487e-4a9f-9362a944c992@redhat.com>
 <CANghgrS9hZyA4vWU=4PZuYue3iLsLx7ObbT_VgRGSXpACwNkcg@mail.gmail.com>
 <df9cb4e8-13f7-54b9-b737-be4e56977867@redhat.com>
 <CANghgrTFjybxfmn=DzKwvoqRP3GA3sWiGFtYdEfPZtWmyznq9g@mail.gmail.com>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <8ca2e078-88d2-83db-bc28-5f8fbf3c0dd6@redhat.com>
Date:   Thu, 31 Aug 2017 11:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CANghgrTFjybxfmn=DzKwvoqRP3GA3sWiGFtYdEfPZtWmyznq9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 31 Aug 2017 09:58:34 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/30/2017 04:55 PM, David Lloyd wrote:
> On Wed, Aug 30, 2017 at 9:18 AM, Florian Weimer <fweimer@redhat.com> wrote:
>> On 08/30/2017 04:15 PM, David Lloyd wrote:
>>> git reset --hard ?
>>
>> That doesn't remove unstaged files.

> Ah, does it not?  Perhaps add a "git clean -d -f" as well.

It would have to be “git clean -d -f -f -x” (not the two “-f”) to be on
the safe side.  I wonder what else I'm missing, though, and if this is
completely reliable and has the same effect as removing the tree before
“git checkout-index”.

Thanks,
Florian
