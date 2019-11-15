Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4261F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 05:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfKOFHR (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 00:07:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58640 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfKOFHR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 00:07:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 284F039603;
        Fri, 15 Nov 2019 00:07:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=52hKts+6J/uh9/0r2W0tF8Rk+Bg=; b=HrcPXE
        5hbxLjB5quEO90+JZHE1D2S6zkYyhuanF4qhyJyxJGqZ6BMOc/STRbHqndb2avOB
        WhMVvaatOOSaL4H2BX5L3SZgtIX6JjgYr2GK/uvs1Fhc1O4huv3mOWxOw6/6Noc4
        SCsXW6kWxbW3a0B1dP9Mc62AUBUga2h7pWY30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nV4zYEPGe1dy2AffQ0xHD7Bxhwq5C5AQ
        8wbWC1KDl2q68+x81SCjapv0hJZswP6esJfQ6xqP7paEXo4ao0IVOzglzwhkLBqj
        elwxMhECDKj6vuare/ou6MoQQ5SGkVOpa6wCLiMYWvWFB4++jzfwNlq78g4qLfdA
        z3F5MicK7G0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DE6839601;
        Fri, 15 Nov 2019 00:07:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6415539600;
        Fri, 15 Nov 2019 00:07:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: rev-list and "ambiguous" IDs
References: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
        <20191114055906.GA10643@sigill.intra.peff.net>
        <ab4dcc9c-4416-aef8-c8c4-38bb5ec97990@virtuell-zuhause.de>
Date:   Fri, 15 Nov 2019 14:07:13 +0900
In-Reply-To: <ab4dcc9c-4416-aef8-c8c4-38bb5ec97990@virtuell-zuhause.de>
        (Thomas Braun's message of "Fri, 15 Nov 2019 01:12:47 +0100")
Message-ID: <xmqqa78x918e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9A37812-0765-11EA-ABA4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> Just out of curiosity: Is there a use case for inspecting non-commit
> objects with git log?

I do not think there is (rev-list is a different story, given that
you can pass --objects), and it probably is not too difficult to
teach "git log" and friends that they only want commit-ish.

Thanks.
