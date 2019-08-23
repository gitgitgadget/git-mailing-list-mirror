Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EB121F461
	for <e@80x24.org>; Fri, 23 Aug 2019 16:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfHWQ6M (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 12:58:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56157 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfHWQ6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 12:58:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A32D16EBA4;
        Fri, 23 Aug 2019 12:58:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/IdgxoUgQRi/jo0/hOk0WSk/Kgk=; b=oTEUUG
        /hlRztSLSTkJu+OAX3zWeQ70LUWml4HISB+Z2ZvwnPI7oXcSwB+nph+s/Ld+yD7a
        d3cASH2siiCiC2x2pVytO6d5W9oUpYFEpOYFLa3v+xwTUwcQ1o6DKcg4dynncasE
        TD0IrlCtbFazd4erENX8vcOuBWkAWCtu3kyEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O3F2wypm95JgCjtNf6IEq/neNJC7SAtJ
        CabiM/ASz0X3VM4T8ssqvXRBiGOTClilx+fPETI8l6sBE+9z0k4h+XhqPfI1m8QL
        6UvqHFGJtwGtbMImeilRZS+5fuu9O+UXyvg5xE3nvm7fxpRg77ddizFuSAehrrqj
        m2KRCBA4q18=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 608A316EBA3;
        Fri, 23 Aug 2019 12:58:10 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C611D16EBA2;
        Fri, 23 Aug 2019 12:58:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christopher Sean Morrison <brlcad@mac.com>, git@vger.kernel.org,
        Cliff Yapp <cliffyapp@gmail.com>
Subject: Re: Bug Report: notes disassociated after history edits
References: <01F35983-BC98-4518-8ED3-C0E1AFC7507A@mac.com>
        <20190823055932.GA10806@sigill.intra.peff.net>
Date:   Fri, 23 Aug 2019 09:58:08 -0700
In-Reply-To: <20190823055932.GA10806@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 23 Aug 2019 01:59:33 -0400")
Message-ID: <xmqq5zmnn7j3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F8AC35A-C5C7-11E9-A0BA-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...
> 	  --commit-filter '
> 		commit=$(git commit-tree "$@")
> 		git notes copy $GIT_COMMIT $commit
> 		echo $commit
> 	  '

Thanks.  I was writing the same "git notes copy $this $that" based
response, but TIL we had --stdin to feed the input in bulk ;-)
