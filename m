Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4381F404
	for <e@80x24.org>; Wed, 27 Dec 2017 18:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbdL0SRj (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:17:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64218 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751184AbdL0SRi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:17:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F364B6880;
        Wed, 27 Dec 2017 13:17:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jMqGKQRr7VUi4nZ6VnMg2SUfWUc=; b=Avl7SR
        U22G8PuQ/3F8zKnRrlFqfqw9W/JxaXgzXLtBnfc5OrZc48hB0Epj8ELEKFu9fpGu
        Vz1XombcIhnUd5EJSUHlx/NgYZinT8x4fxN8rvHuTaYWz+rxWxPWzH3y2AmWeI7Y
        mHxC7WNYA0Zj2T+/Q6qnkaEGOAnzFDPgji/E8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mmefVpE4CJaEUkF3WLwIZNnV5+ETXKRp
        R4EUJxeo8CDdxEDs1jnFP23KgnTPqjP//5X/MhgURDv32LUMWLC4jS/WV8ycPk43
        FLCY+e7zBUe044v7s/RZMA5omOZYifHYqSWSQHgWxteNLZnIE49JwvFlSFVDnXf5
        70kiS8ItUck=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DC65B687F;
        Wed, 27 Dec 2017 13:17:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CE3AB687E;
        Wed, 27 Dec 2017 13:17:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] status: handle worktree renames
References: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
        <20171225103718.24443-1-pclouds@gmail.com>
        <b3e90960-d743-3299-ba43-150849b591d2@gmail.com>
        <20171226021150.GA10059@duynguyen.vn.dektech.internal>
        <CACsJy8CN58ivOeAr83X86NZcBy+yrJd0SbFhej99Pjb8x8_gBA@mail.gmail.com>
Date:   Wed, 27 Dec 2017 10:17:36 -0800
In-Reply-To: <CACsJy8CN58ivOeAr83X86NZcBy+yrJd0SbFhej99Pjb8x8_gBA@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 26 Dec 2017 09:53:14 +0700")
Message-ID: <xmqqd130nigv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37D8870C-EB32-11E7-987D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> The problem is, you cannot know if it's a rename from HEAD or from
>> worktree with this updated v2 (or perhaps you could because HEAD name
>> should be all zero?).
>
> I'm wrong about this. the "<XY>" code for HEAD rename would be "R."
> while worktree rename is ".R" so I think we're good.

Ah, OK, then.  Thanks.

