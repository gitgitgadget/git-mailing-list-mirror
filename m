Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE443200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 22:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932947AbcL0WsZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 17:48:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51970 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932702AbcL0WsX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 17:48:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64F1D5A683;
        Tue, 27 Dec 2016 17:47:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eSZl9DWszSkG7xakjX0AnF+uINQ=; b=TlCOBr
        0Abo34n7tzaEJ4XG04LSba7TbxXWPxDO0+kjl9bdjhdpFXxaBn6APif50n5ksbfX
        NDdUy8EmZDO269w+DlxqfpUP0yz7RjThxzwAv/cVmeCziZb5J4m0+7zAJBKaU74W
        BZwDkZoErPa8Lm9OVR4ZuaStTjFaOvdZ3NVGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YmUiUN5SeXCg1ZtaZOR8eRIwuKcItaYi
        Kz5LW8n+KP7qeX5vhrgbhtTkqIJ/DEsyoqhJjOHO83HINEHDrC9eVah8Xhmdx7Fj
        ODmOS9NK4/sStQHZ80fRMVenI28Nsd3lDXNXYsf/jkXAqpY/WEN7wB3E/tIRniIb
        S6yb3xJssTw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C9FA5A681;
        Tue, 27 Dec 2016 17:47:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF2415A680;
        Tue, 27 Dec 2016 17:47:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] worktree: initialize return value for submodule_uses_worktrees
References: <7E1C7387-4F37-423F-803D-3B5690B49D40@gmail.com>
        <20161227175013.12747-1-sbeller@google.com>
        <xmqqa8bh6myb.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbbm=g9DTUWY=xVZPUi4ajCMgKT63bGXJSpP2t0RDH0Ew@mail.gmail.com>
Date:   Tue, 27 Dec 2016 14:47:23 -0800
In-Reply-To: <CAGZ79kbbm=g9DTUWY=xVZPUi4ajCMgKT63bGXJSpP2t0RDH0Ew@mail.gmail.com>
        (Stefan Beller's message of "Tue, 27 Dec 2016 14:18:10 -0800")
Message-ID: <xmqq37h96lc4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F700904-CC86-11E6-93A7-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Dec 27, 2016 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I'm planning to disappear until early next
>> year
>
> Safe travels!

Thanks.

> I assume there is no interim maintainer for such a short
> period of time (which also is not as busy).

I plan to take my Flip with me (the primary development box for me
these days is Google's datacentre, and I only need a chromebook to
use as a SSH terminal or two) and expect to have a usable network
connection, but given the number of topics labelled as "Waiting for
review to conclude", I expect that people have plenty to chew while
I am away and the public git.git tree does not replace the in-flight
topics for a week or so ;-)


