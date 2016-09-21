Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D68420985
	for <e@80x24.org>; Wed, 21 Sep 2016 16:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938797AbcIUQwq (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 12:52:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65010 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933808AbcIUQwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 12:52:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1183E3E46A;
        Wed, 21 Sep 2016 12:52:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bNkLWy9WNVY0CA9gYcvWbw34f0c=; b=JhJcEU
        4v2eEZPaGmx2UHmtxX6WLL/vv2kf55LNCqPv5SrGa2rPDWeTFsWvu6tDIN1+6dYT
        LrZMqkjTvTsop/89Y5i9nRKzHv4EKLHPaYNS/enqn91SntMFA1c+4bt5yISSE6OC
        GpbzZJ+eLywaUOoirJ/wZQhYCR/gaoXXkLQ8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t1imbEyh6p9EFh6+VVW9GxZ6WRcfWhju
        Nlt5QTxkE5KFy4c3kTkKTOJkd5ZYmUdw4wOwIIC0cEZGaNW2JHFZ4ZqGimLMEfsi
        NI6legnFYeEkO1Tm6CYDnQ8bGDAYbFDuOi/lKbtXDcc0Qi/sE/TtQvaWhm+j9enA
        Vw+o4T88h+c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09A3A3E469;
        Wed, 21 Sep 2016 12:52:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82F023E468;
        Wed, 21 Sep 2016 12:52:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     git@vger.kernel.org
Subject: Re: v2.10.0: ls-tree exit status is always 0, this differs from ls(1)
References: <20160921132655.h49HMsHbp%steffen@sdaoden.eu>
Date:   Wed, 21 Sep 2016 09:52:41 -0700
In-Reply-To: <20160921132655.h49HMsHbp%steffen@sdaoden.eu> (Steffen Nurpmeso's
        message of "Wed, 21 Sep 2016 15:26:55 +0200")
Message-ID: <xmqqr38d9ova.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0B6C4B2-801B-11E6-BDCB-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steffen Nurpmeso <steffen@sdaoden.eu> writes:

> I think this behaviour contradicts the manual which strongly links
> ls-tree to ls(1):

Patches to the documentation is very much welcomed.

Somewhere the similarity must end, and actually it ends a lot
earlier, as "/bin/ls" takes exact paths while "ls-tree" (or any
other Git command for that matter) takes a pathspec pattern,
and not having a path that matches the pathspec pattern is not
an error condition.

Thanks.
