Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACDC22021E
	for <e@80x24.org>; Wed, 16 Nov 2016 05:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932249AbcKPFXD (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 00:23:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62034 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751233AbcKPFXD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 00:23:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B805E4F4B6;
        Wed, 16 Nov 2016 00:23:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3/T0pnzQZgefWU6YJjAb2+rhOCI=; b=PcTNuL
        mYTKd701jSwYYbz4KNc/7gshxG+YppwGAk4jn1UkLcP98mav21FQGkrtLPs/c2Na
        N58U0lhikE0cyU2PuIfLkaauOHynm+873w/6mgDjmPdXic0P+ALZk3A7eyOaqsbE
        mTZnZRRiUElTcc5l/u3VP3Wtp2egalTi6Fg8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qUESd22R3lcETYEiFCl2AfC5gBAHrTKM
        QgsphGDsFRj0aPl0O84TA+KI6+7VYvGwNkvazBUBt+epcWXWUlLxNukfY8vL9/7T
        5HbHEb4Pkmt3uakx5G/Idq3q944N9xNa0psCYkhepQ81x3N6x9XYcGvTiMjt9fag
        Ab89SkorSPs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B00714F4B5;
        Wed, 16 Nov 2016 00:23:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29AE14F4B3;
        Wed, 16 Nov 2016 00:23:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Douglas Cox <ziflin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug with disabling compression and 'binary' files.
References: <CA+i4re65SsxcaLcpGyMDnJygQFmAq4X_x_uxrkqB0yqQkEYPUQ@mail.gmail.com>
        <xmqqk2c4ryj8.fsf@gitster.mtv.corp.google.com>
        <CA+i4re4FZhshheftQnsogaY7601wgf_GfsFUxy+doLcOYPWv7Q@mail.gmail.com>
Date:   Tue, 15 Nov 2016 21:23:00 -0800
In-Reply-To: <CA+i4re4FZhshheftQnsogaY7601wgf_GfsFUxy+doLcOYPWv7Q@mail.gmail.com>
        (Douglas Cox's message of "Tue, 15 Nov 2016 22:12:04 -0500")
Message-ID: <xmqq37isroaz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE09C932-ABBC-11E6-973A-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Douglas Cox <ziflin@gmail.com> writes:

>> This may or may not be related to the symptom
>> you are observing (if it is, then you would see a packfile created
>> in objects/pack/, not in loose objects in object/??/ directories).
>
> No, the file is loose (it's in .git/objects/eb in this case). This is
> seen immediately after the add, though I believe it's the same way
> when doing a commit on a changed file.

Then I do not have a guess as to where the symptom you are seeing is
coming from.
