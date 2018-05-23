Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924681F42D
	for <e@80x24.org>; Wed, 23 May 2018 20:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934428AbeEWUpH (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 16:45:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64668 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933518AbeEWUpG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 16:45:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5413DDC8FC;
        Wed, 23 May 2018 16:45:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=HkSgM/ii2tOGiUqfAhe9jXSYEoU=; b=jkpQWu3
        uXcD/qmgJ3Xe0H6CgCJhyf7jTAPhNltoYsIYcpFMrMvN77tOkGddIAZrMSQkuFQD
        fl0YHfEnsS5fkMx1zfLTFWcucHhalQplyqqJc7IGN51YMdhS8NdY4LJm+vx+biWB
        x3wEFOnF0w/4DWr6rRqmCfepD6hJA/CGAYR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=JJh84akHdGDzeo0cDgbEiIbN0gtZ3E+mt
        CNzF38gezWVuM+OMWuJuYrGwWq/Kyz7fgPFDa+8jFtI1A5OFkjX1az94Uds5cZeY
        0/xku8A5AdRgkRaVhl7P3v8vgBHBNxngvGzRJS671+UIO3TCais/fnV3yrGN4Ny0
        sXUOFgq9KU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C10DDC8FB;
        Wed, 23 May 2018 16:45:06 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6502DC8F8;
        Wed, 23 May 2018 16:45:04 -0400 (EDT)
Date:   Wed, 23 May 2018 16:45:03 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: rev-parse segfault with invalid input
Message-ID: <20180523204502.GU26695@zaya.teonanacatl.net>
References: <20180523195227.GT26695@zaya.teonanacatl.net>
 <CABPp-BFOwWvDpfLFa2yrUDU_3BU6F68oLTtO5FvQo8nr62_WtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFOwWvDpfLFa2yrUDU_3BU6F68oLTtO5FvQo8nr62_WtQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 2BF575B0-5ECA-11E8-A770-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren wrote:
> Thanks for the detailed report.  This apparently goes back to
> git-1.6.0 with commit 2122f8b963d4 ("rev-parse: Add support for the ^!
> and ^@ syntax", 2008-07-26).  We aren't checking that the commit from
> lookup_commit_reference() is non-NULL before proceeding.  Looks like
> it's simple to fix.  I'll send a patch shortly...

Thanks Elijah!  I thought it was likely to be a simple fix.
But I also don't know the area well and that kept me from
being too ambitious about suggesting a fix or the difficulty
of one. :)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I believe in the noble, aristocratic art of doing absolutely nothing.
And someday, I hope to be in a position where I can do even less.

