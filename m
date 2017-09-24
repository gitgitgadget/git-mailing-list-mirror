Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PI_IMPORTANCE_HIGH,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E676720281
	for <e@80x24.org>; Sun, 24 Sep 2017 00:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdIXA2I (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 20:28:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61406 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750839AbdIXA2H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 20:28:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E994B1DC0;
        Sat, 23 Sep 2017 20:28:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iHBeyMjqnwbcQ5ffE0n85G9jPQo=; b=xiVrKy
        5BQ+af1gxFRt+jyHrRmltkTBYzYXObpITdKr1u3GFHCPIYOOOgF3ecOXFI2Mx1bw
        lXNdchy4vjw5K3Tl4rT65PEDAqSNge2oBcEBhiHm4b/D8lHesEE6B9fcUlW0pyUP
        X1boo4Z5uLBcPWBKuUnLKxUPNzye0ICXFFb5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PX3ftplRWLKY9jnaTwVZQBBeXKEVYgT+
        gLi558eS8HWXFX9hHwarlfC1M6vkL/uiedxOeU6yqha2OsCKeo0/b8g69/VliLp4
        7+NgNkYb5BDXMQ8mrQWZSjjth3vhY0/IIipO/snBGF2bPdU8UwD3cKJ0JN836j6S
        7dAJHFUlW54=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 475EDB1DBE;
        Sat, 23 Sep 2017 20:28:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4B3EB1DBD;
        Sat, 23 Sep 2017 20:28:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] doc: camelCase the config variables to improve readability
References: <20170919202201.GD75068@aiede.mtv.corp.google.com>
        <20170923045617.3782-1-kaarticsivaraam91196@gmail.com>
Importance: high
Date:   Sun, 24 Sep 2017 09:28:05 +0900
In-Reply-To: <20170923045617.3782-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Sat, 23 Sep 2017 10:26:17 +0530")
Message-ID: <xmqqmv5lhre2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C2D0304-A0BF-11E7-A633-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> A few configuration variable names of Git are composite words. References
> to such variables in manpages are hard to read because they use all-lowercase
> names, without indicating where each word ends and begins.
>
> Improve its readability by using camelCase instead.  Git treats these
> names case-insensitively so this does not affect functionality. This
> also ensures consistency with other parts of the docs that use camelCase
> fo refer to configuration variable names.

s/fo/to/ (or s/fo/in order to/)?  

I think the one I have on 'pu' uses Jonathan's suggested rewrite of
the log message verbatim, and I suspect that it is already clear
enough, even though I admit that I stuttered a bit while reading its
first sentence.

I'd avoid "A few" above, as it is my impression that we use
multi-word names quite a bit, not just a few.

Perhaps

	References to multi-word configuration variable names in our
	documentation must consistently use camelCase to highlight
	where the word boundaries are, even though these are treated
	case insensitively.

	Fix a few places that spell them in all lowercase, which
	makes them harder to read.

may be a more succinct way to say the same thing.  We state the rule
upfront, explain what the rule is for, and tell the codebase to
apply the rule.  That should cover everything your version and
Jonathan's version wanted to convey, I'd think.

