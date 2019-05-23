Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AF8B1F462
	for <e@80x24.org>; Thu, 23 May 2019 21:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfEWVGg (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 17:06:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56646 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfEWVGg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 17:06:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15FA16D54C;
        Thu, 23 May 2019 17:06:34 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=j/3xfcR2oeqpsrt6ImjECW4hFnA=; b=VukcIpr
        sl+AHuSy7mywhlh9jFBxtyK71lEnvPbbyoODigMidKXixAQc0wOhK8ukt38QIU2T
        HxlztqCWkMsHkLOhIHt+PLf6A6YlNzVIQk5Iv1JF67ylcXHJwQA/QYchSZHZkaEL
        knnRQfQzuxd1Ff8Sae55yBwhDHYUelZQ+8cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=d6JZkbNvukhE9FObKhpMHgJPN2I5BTqr1
        RIouj/m6lFfxRz0cbUDfEFkdTux0ZEteH/tM73MKP9gz3GUAGm5aZ8IWW50dOjCq
        97Vh7w2cbKvT/nZAKUxwoQNKjH7cn84OjC69K9nMgMIvrdtHLlJbzxAklL4Fmgze
        ijPEYriF1U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CE556D54B;
        Thu, 23 May 2019 17:06:34 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD7CA6D54A;
        Thu, 23 May 2019 17:06:30 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 23 May 2019 17:06:28 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        git-packagers@googlegroups.com
Subject: Re: New diff test failures on s390x architecture (was: [ANNOUNCE]
 Git v2.22.0-rc1)
Message-ID: <20190523210627.GP3654@pobox.com>
References: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com>
 <20190523150416.GL3654@pobox.com>
 <20190523191429.GO3654@pobox.com>
 <CACsJy8CY8CVVv1+s9sLtVEAhrC5Ki8NSY2qje8+se7VVudFo_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CY8CVVv1+s9sLtVEAhrC5Ki8NSY2qje8+se7VVudFo_g@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: A3670732-7D9E-11E9-AEDB-8D86F504CC47-09356542!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Duy Nguyen wrote:
> On Fri, May 24, 2019 at 2:14 AM Todd Zullinger <tmz@pobox.com> wrote:
>> I am guessing it's no coincidence that this only fails on
>> s390x and it is the only big endian architecture in the
>> fedora build system.
> 
> I see a problem with -w and wrong type casting. sizeof(int) and
> sizeof(long) on s390x are not the same, are they?

I don't believe so.  I tested a small program which output
sizeof(int) and sizeof(long).  On s390x it's 4 bytes and 8
bytes, respectively (same as on x86_64).  I hope that's the
right way to test.

Thanks,

-- 
Todd
