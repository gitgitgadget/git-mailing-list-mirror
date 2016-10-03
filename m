Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671A7207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 17:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbcJCRIH (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 13:08:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54140 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753259AbcJCRIG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 13:08:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DA2F4122D;
        Mon,  3 Oct 2016 13:08:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pt7CiA5Woou1TMqMMIfgrEjGbUo=; b=Ceu3nb
        a8uVoeQM85UV3cH84p7+p6zms+RQTqCiyw+hBPySmU/Yygk/RwGenzWhwSX1JDi8
        MmRUEuIcyZ3aVyHgtYb3CQ6o8KoIIVVDio0VLd75Ara9+WzrsIumNnPlK2eNeo/r
        COtCVxu441+qXymiV6vOb7KiQdZDq/6W0mcuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TsN217V2xNmP1xO1wKgFu1rgp0/Cy4xK
        bwrQAJNrhc+DzWn1/tLIXzIS2Rdo7V7YjgGCj6OHoYO2vOCGcKv1431bJ6Jf4jSd
        zl8IlwP0ZxxL6AjykmGRP9PiirzSWVikNJXF/Zz98OvK4jFBVxKB2jb+j23KIeg5
        YHnC+sr5C/E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95FAC4122C;
        Mon,  3 Oct 2016 13:08:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1682A41227;
        Mon,  3 Oct 2016 13:08:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] diff_unique_abbrev(): document its assumtion and limitation
References: <xmqqvaxd9ssy.fsf@gitster.mtv.corp.google.com>
        <20160930180957.xj4jqoslbtevhqpb@sigill.intra.peff.net>
        <xmqqd1jl9ovc.fsf@gitster.mtv.corp.google.com>
        <20161001091558.guduirzlkog5fkzd@sigill.intra.peff.net>
Date:   Mon, 03 Oct 2016 10:08:02 -0700
In-Reply-To: <20161001091558.guduirzlkog5fkzd@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 1 Oct 2016 05:15:58 -0400")
Message-ID: <xmqqr37x743x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F25E124A-898B-11E6-8DA5-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I guess my point was that the poor name may have contributed to the need
> to explain it.

The comment was not about "it may not be obvious but this tries to
pad and align", but to say "the way this tries to pad and align is
based on an unsaid assumption that leads to this limitation".  I do
agree it is a good idea to rename it to a name that has 'pad' or
'align' in addition to 'unique', but I doubt renaming alone would
reduce the need for the new comment.
