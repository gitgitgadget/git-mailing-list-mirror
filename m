Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30F420365
	for <e@80x24.org>; Tue,  3 Oct 2017 08:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbdJCI44 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 04:56:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50299 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751059AbdJCI44 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 04:56:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36229B7C70;
        Tue,  3 Oct 2017 04:56:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tJUxk/4BQ1CsQvQWMWq4I+4BsWk=; b=pe7xRn
        8Jsfa+ksteTPFn5RM586EMC5anq4V9AHHuAU/nwT+0Uj8vnnGt4xU/9ZwVR5cRvH
        pnquJqyDeGBp4Cvm1PL/vzLEZy/HSugb/jKgmk84Cz5sUWaLGW7ebKWqPcDI9ksP
        wEtYFI1ywISxRFrzkGjtAMsXg1FFNXqBTypb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l2vOl1bu6sthBllQ7vR/gIesYhz3Y2yc
        Iu1kqmwzW4X/+3bdfy2LoQ6LBN7eouIW130275TKWwW2j9C/9vq6lXfoAzADfcoQ
        DuQjbSSw8YY+6X3yRyb2n1GYzEq6n7RJqX5AYn9XHMK5vMV/ogJw9YuvDFXd5tyx
        Va57svXFyGo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E31FB7C6F;
        Tue,  3 Oct 2017 04:56:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C12FB7C6D;
        Tue,  3 Oct 2017 04:56:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
        <20171002230017.GT19555@aiede.mtv.corp.google.com>
        <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
        <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
        <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
        <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com>
        <20171003071622.el6zqibfyrjc2mra@sigill.intra.peff.net>
        <xmqqefqkiq8v.fsf@gitster.mtv.corp.google.com>
        <20171003084506.lwmnrym4oyf66icz@sigill.intra.peff.net>
Date:   Tue, 03 Oct 2017 17:56:53 +0900
In-Reply-To: <20171003084506.lwmnrym4oyf66icz@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 3 Oct 2017 04:45:06 -0400")
Message-ID: <xmqq4lrgip7u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDFB0870-A818-11E7-A0D8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Note that I'm arguing that it's a foot-gun even without scripts in the
> picture at all. Forget about plumbing versus porcelain. If you set
> color.ui to "always", you're going to get unexpected and confusing
> results from time to time.

Really? 

I would think you would consistently get ANSI colored output in any
medium, even in files that you would later "cat" or "less -R" to
view.  Is that unexpected?  Those who set "always" (I am not among
them, of course) would expect that, I would think.
