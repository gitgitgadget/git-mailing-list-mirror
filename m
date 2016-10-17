Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2926D1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 20:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757962AbcJQUHs (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 16:07:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59843 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755761AbcJQUHr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 16:07:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D02E7467E8;
        Mon, 17 Oct 2016 16:07:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GrC+KzM8f+QiiU2aFSrCO9ApNP8=; b=ev2SUP
        4AptnriZgGSshEQZBIgvoqJ6Wg/ywsHPdjta0ef15+DKF+Heb3aT6dO/51AfmonK
        w961fazK5GecTOjW7RsCSBSITAoZ6Rtro067NJ81hIYHFEe55c+5EKny//CdQea+
        /f3sYcXFAY807OYwFJXnv+bIADPtxnTqJxapU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uHkHAwrkgiZQH7w4BHUtv9WSAbShr9hk
        qwLWXyN5cf1S+gXKX2z6o2xUdOKlCMi1r0jqmOUPh9u6YFE/2AvVBBuN7BR53Nm7
        Tyufn9AKnUa2wpBuHS0lJX8VliKlia+91EuFRx7vQYDcxgj33HtV0wNZhDQIurAC
        mJXqmwVnKEo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8DA0467E7;
        Mon, 17 Oct 2016 16:07:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43B96467E5;
        Mon, 17 Oct 2016 16:07:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] convert: mark a file-local symbol static
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
        <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com>
        <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com>
        <B7662EA0-3181-413E-A40B-69C88FC46F96@gmail.com>
        <5a9a1c44-8a3f-1894-c4c5-8f1fa96b63b9@ramsayjones.plus.com>
        <20161017021825.jgpsew7qqfjrirhw@sigill.intra.peff.net>
        <alpine.DEB.2.20.1610171058580.197091@virtualbox>
        <20161017093754.wah5d6cg4qgtw7ln@sigill.intra.peff.net>
        <16298e68-c0f9-b7ff-d4b5-0d4b79306377@ramsayjones.plus.com>
Date:   Mon, 17 Oct 2016 13:07:43 -0700
In-Reply-To: <16298e68-c0f9-b7ff-d4b5-0d4b79306377@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 17 Oct 2016 18:21:56 +0100")
Message-ID: <xmqqmvi2u4c0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E3D5858-94A5-11E6-9AA4-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Heh, I actually have the following in my config.mak already:
>
> extra-clean: clean
> 	find . -iname '*.o' -exec rm {} \;
>
> But for some reason I _always_ type 'make clean' and then, to top
> it off, I _always_ type the 'find' command by hand (I have no idea
> why) :-D

"git clean -x" anybody?
