Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829432047F
	for <e@80x24.org>; Wed, 26 Jul 2017 18:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750982AbdGZSOF (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 14:14:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51411 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750893AbdGZSOE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 14:14:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D74A3935B5;
        Wed, 26 Jul 2017 14:14:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pS0EwTW2+y1szm35d9/RnDi0pxM=; b=Zi6dRA
        FKdQzt5CoKkjvs9HjU3CnjDjUf033+5F7ty9NysfaI/PGaJXIfCQjlgcsemw1+EJ
        XITbqB+csxi/Ic2iIM29RjTt6Gio5BsMhWnke64YVyFYvHB87NrTFXp8axIYgWMI
        a+QXNADLL+GG9ELufAbpE3ppdtE7/JYNVcYUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mO40vAoaKy0PWE7PQudaZKeL7Ba4g9AR
        4395RDm65F81+DYfVPSTErP1sXD/sdtrwA6jmz3JOLFsjHhm76k17/OHxIzAFexD
        QcAkgrshPtEzuai3TWVmQeuqDfxM11M2CUcIoEn7k/AyujjeV7D1Nhm2dbAhL7W0
        RVXS/yTGkUA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEB33935B4;
        Wed, 26 Jul 2017 14:14:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20743935B1;
        Wed, 26 Jul 2017 14:14:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        benpeart@microsoft.com
Subject: Re: [PATCH] sub-process: refactor handshake to common function
References: <20170724213810.29831-1-jonathantanmy@google.com>
        <EB54F0E5-E555-40BF-8AA7-7CB3174FE22C@gmail.com>
Date:   Wed, 26 Jul 2017 11:14:01 -0700
In-Reply-To: <EB54F0E5-E555-40BF-8AA7-7CB3174FE22C@gmail.com> (Lars
        Schneider's message of "Wed, 26 Jul 2017 18:52:29 +0200")
Message-ID: <xmqqeft3rrpy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3469B564-722E-11E7-8B79-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Please note that I've recently refactored the capabilities negotiation a bit:
> https://github.com/git/git/commit/1514c8edd62d96006cd1de31e906ed5798dd4681
>
> This change is still cooking in `next`. I am not sure how this should/could
> be handled but maybe you can use my refactoring as your base?

I think they can play well together as independent topics.  The
known_caps[] thing you introduced essentially is the same as the
struct subprocess_capability capablities[] Jonathan has.

Please check

    $ git show "pu^{/jt/subprocess-handshake' into pu}" convert.c

to see if it makes sense.

Thanks.




