Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7A12036C
	for <e@80x24.org>; Thu,  5 Oct 2017 01:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdJEByW (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 21:54:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58689 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751177AbdJEByV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 21:54:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 072CAA8F42;
        Wed,  4 Oct 2017 21:54:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YtMJMx4M4PP5MhrXObcd1apmKyc=; b=kH/6XR
        TlrerdSMbXT9tvrGnVr6fNHx/67vGPKvlnc2dkkMUpSg+9gAMHRn3IpMsfSBd17c
        v+Ie0i1JnFFmJTqAjTAbz0c4768jhshcjOIvQgQJQbzKx+eW9JgKoH8m3nmbzf/A
        OLV8U4fSQ3tH0BDIleJa5J0JX2OdBWTl4QMfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=re9tBkS9zBKcIFfqQU/o5dl/5MjMUABp
        TEIVPc2mVEOMD1w0evnkTK6zDlkjsmAmAZtPsmcZU7TbAnUUQRYOPs2vyNC4faVz
        8tKERoq/7cv9suY1W7zLkqP4ad0b0k3t7dJcWd6NG36cDLQq4iwYgcV2ElzXKgZ7
        BL1sAMIN1YM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1CB5A8F41;
        Wed,  4 Oct 2017 21:54:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64A77A8F40;
        Wed,  4 Oct 2017 21:54:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] for-each-ref: add :remote-ref and :remote-name specifiers
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
Date:   Thu, 05 Oct 2017 10:54:19 +0900
In-Reply-To: <cover.1506952571.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Mon, 2 Oct 2017 15:56:32 +0200 (CEST)")
Message-ID: <xmqqy3oq8ilw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A82B852-A970-11E7-93B5-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Note: the `%(push:remote-name)` placeholder is only interpolated by the value
> of `branch.<name>.pushRemote`; unlike `git push`, it does not fall back to
> `branch.<name>.remote`. Likewise, `%(push:remote-ref)` interpolates to the
> empty string unless `remote.<nick>.pushRefs` is configured.

I think the reason why I had to spend more time than necessary on
the above point during my review on this (otherwise mostly well
done) topic was because of this note.  It says what it does, but
does not say why this behaviour is better than the other obvious
alternative.

In a reroll to address the remaining points, please update the log
message (not the cover, which won't be in the committed history) to
explain why we think this is a better choice than an obvious
alternative.  Let's help future readers of "git log".

Thanks.

