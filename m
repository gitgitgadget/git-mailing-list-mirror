Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637321F4F8
	for <e@80x24.org>; Fri, 21 Oct 2016 00:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754921AbcJUAuL (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 20:50:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59777 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751226AbcJUAuK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 20:50:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7280A48D31;
        Thu, 20 Oct 2016 20:50:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mArVkkem7B9zS2skdC1Vzdchm9U=; b=JcuAbP
        VHGGMpY8b3wqmeWfPCID7jz08dqNW3i7mL0k4LwC00KQrXp4su115els5SW4JDx+
        fb+q11wlWZXXX5TPKIi3CTw2mA70/W5+aielJzlTCqg+9hrD4dQ+zQl7NEXruc/T
        AryKGuQpeYyNj6IN//QX9CiofiBMGrlwVp678=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KPl3nd6I3I5Fohcqhu+VbEY5vDF4gd3i
        in8kPTDeNZ0Ykly+1qWuD1KDsnR3i2lEKJ+636NZGyws29NRLG3lJ+0UrljMiKU1
        X5/1wqUWEa8bOKqK3HIhPM8DR9kpr2/mxExjg2ILFpYcvCu2xEXRDibiSYwqrLk4
        JgDbPE/iSrQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 681DF48D30;
        Thu, 20 Oct 2016 20:50:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E40CC48D2F;
        Thu, 20 Oct 2016 20:50:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Matthieu Moy <Matthieu.Moy@imag.fr>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: t9000-addresses.sh: unexpected pases
References: <3e9bfa01-d69c-05c1-e24e-960a3add2551@ramsayjones.plus.com>
Date:   Thu, 20 Oct 2016 17:50:06 -0700
In-Reply-To: <3e9bfa01-d69c-05c1-e24e-960a3add2551@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 21 Oct 2016 01:24:48 +0100")
Message-ID: <xmqq1szaeda9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50AE81D2-9728-11E6-B082-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> I have started seeing unexpected passes in this test (am I the
> only one?) on the next and pu branch, which seems to be caused
> by commit e3fdbcc8 ("parse_mailboxes: accept extra text after
> <...> address", 13-10-2016). Thus:
>
>   $ tail -15 ntest-out
>   [15:17:44]
>   All tests successful.
>
>   Test Summary Report
>   -------------------
>   t9000-addresses.sh                               (Wstat: 0 Tests: 37 Failed: 0)
>     TODO passed:   28, 30-31

Yeah, I noticed this in some of my integration runs but didn't pay
attention and forgot about it; thanks for bringing it up.

