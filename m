Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A8C1F406
	for <e@80x24.org>; Wed, 10 Jan 2018 02:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964814AbeAJCYJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 21:24:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57990 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933578AbeAJCYI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 21:24:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17777C4B0C;
        Tue,  9 Jan 2018 21:24:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EEsWIdYdNVTdCj/OIMx+uulSceM=; b=oUvnjL
        sWvk5mI2z3bAx5w0Og4zc0SUq0ifvAQcAGuWP9XkWEFWQ+R6WKux9BbuNN085pet
        hjYeKOwJJBEF7sgcCcC4YaRObbWBtyzW4Styz8z7qHOEsIbVui6XwPd1vrL3TyC+
        f4bNJf7f0iqQASNwcCu30y+2jb5ZNTOb8HOgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mvMm/X8faMDmtGRVv1KzUdb+oeWEpyQu
        W3qERqHRokDNX+u2jend2v1rD4yEXXHq0sIwDhtuIA1MbFCYnCrmTjvuO09dIh0a
        7awCln5X1qr8nTMWSB48ow0wF9nLka1WnC0zp2yRrxkNfVmkh+e62ODS1qZfLQyo
        iljHcJkBme8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 103D0C4B0B;
        Tue,  9 Jan 2018 21:24:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 843DEC4B09;
        Tue,  9 Jan 2018 21:24:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: prepare-commit-msg hook no longer run for cherry-pick?
References: <CAKdAkRQuj1hfKeckjuR2oP+8C1i+ZR36O-+aRYif4ufaS_zs+w@mail.gmail.com>
        <CAKdAkRTK=0Kafc-nhvJTu+9m-pp=BV3Oc-gu6ssjZZQm95pC_Q@mail.gmail.com>
Date:   Tue, 09 Jan 2018 18:24:06 -0800
In-Reply-To: <CAKdAkRTK=0Kafc-nhvJTu+9m-pp=BV3Oc-gu6ssjZZQm95pC_Q@mail.gmail.com>
        (Dmitry Torokhov's message of "Tue, 9 Jan 2018 16:39:20 -0800")
Message-ID: <xmqq1siy30zd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55CAA99A-F5AD-11E7-B8F4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

>> I had prepare-commit-msg hook that would scrub "Patchwork-ID: NNNN" tags
>> form commit messages and would update input mailing list patchwork to
>> mark corresponding patches as "accepted" when I cherry pick form
>> WIP/review queue into branches that I publish, but that recently stopped
>> working if I do a simple cherry-pick.
>
> This seems like a regression, at least for my use case. Unfortunately
> my mail seems to get lost in the mailing list noise...

Possibly.  Can you bisect to see which commit broke things for you?
That would allow people who know what they themselves broke better
than I do to take a look ;-)

Thanks.
