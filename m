Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B1520281
	for <e@80x24.org>; Wed,  4 Oct 2017 11:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbdJDLzr (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 07:55:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55007 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751877AbdJDLzq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 07:55:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEF999ABD2;
        Wed,  4 Oct 2017 07:55:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LFBu71+qbzRvOvfhZAWmbYztqlo=; b=Kf2iP5
        3W10aUQotcURSz6TvHAls35remTXlSx/1YzJcO+ScYPB53Zr7nG/Utnxb+Krvm3U
        npKxH5wz/qfF7778Y2hvUUC/n0h+Lx4FHOTzt6lOPJEiftZc85zHXguWVxOuFJ5r
        US58EdwtzCw6uq3Zbz++c7eeaSyzNtkd6pKzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BEOMa1+f3GijxOoVc7cEFVwOTjLjlg6r
        fMULEt9qodSf02tKVzKDEub0fn5dsflvCoTKbSzVIl2SxsNOMxfdpZuqwynRk1fE
        od66ezo0FG0h0mlFqnpYiy68ba9374VUFOl4P4Na7jtUjyABOr2BJDhzzxKjGmuv
        1uW4HLawRYI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B59CF9ABD1;
        Wed,  4 Oct 2017 07:55:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 365989ABCF;
        Wed,  4 Oct 2017 07:55:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v1] convert: display progress for filtered objects that have been delayed
References: <20170820154720.32259-1-larsxschneider@gmail.com>
        <xmqqwp5svjne.fsf@gitster.mtv.corp.google.com>
        <1AD84BB7-5BCA-4982-B157-944890F796EE@gmail.com>
Date:   Wed, 04 Oct 2017 20:55:43 +0900
In-Reply-To: <1AD84BB7-5BCA-4982-B157-944890F796EE@gmail.com> (Lars
        Schneider's message of "Wed, 4 Oct 2017 12:52:25 +0200")
Message-ID: <xmqqr2uj9lfk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F45149C0-A8FA-11E7-8265-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> The delayed progress API is being simplified so I'll probably do a
>> bit of evil merge while merging this to 'pu'.
>
> I just realized that this patch got lost :-(

Really?  Isn't it 52f1d62e ("convert: display progress for filtered
objects that have been delayed", 2017-08-20)?  It already is in
'master' since about 3 weeks ago.

As this is merely a new "feature", I do not think it is reasonable
to expect it to be merged down to 'maint'.  In fact, I think your
original patch <20170820154720.32259-1-larsxschneider@gmail.com>
declared that its Base Ref was "master", and I queued the topic on
top of the then-current 'master', so it is not mergeable to 'maint'.

It may be cherry-pickable, but I do not think it deserves to be.  It
is not a fix for a grave bug or anything like that, right?

