Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698531F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 19:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbdIFTv1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 15:51:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53518 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752306AbdIFTv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 15:51:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D643C9890F;
        Wed,  6 Sep 2017 15:51:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=01pcp1r1irLof9hMc9JpXhtOju0=; b=vzOudiH46mR1gDQHTYo4
        kb7nuJ6kQy/R+CbumoZhSBibSWPfuC6zldb9k9DdkpEDEjKu80nMZkgkW7vPHuSH
        m5JF8vYoGwBJcZ+tROy0RSBtPux2pGbaVfMxf1dYHrEj7S9O/GrPtLLmc9QCsr9K
        eKH9ceUc1k1VSs+Cnlq2Ga0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=kR32sYmWWyFEopwdjVOz+GQJh38eYLeBuS1Y1LBBkbDdEv
        9X70Zdb9IGbORxEiPBCVTaWfOGgXBuyXZXAw26M/NEW7WxfZ098Yn7hnx+eiCw9j
        FZddbzohOyRhnb+SmSISJb4OM7XiD12zztCyuSeSRekk9bDKPe7lskVw5mK08=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF08F9890E;
        Wed,  6 Sep 2017 15:51:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3266A9890D;
        Wed,  6 Sep 2017 15:51:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rene Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 34/34] wt-status: release strbuf after use in wt_longstatus_print_tracking()
References: <20170830175005.20756-1-l.s.r@web.de>
        <20170830182018.21390-1-l.s.r@web.de>
Date:   Thu, 07 Sep 2017 04:51:19 +0900
Message-ID: <xmqqmv6761xk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0ED9C9C-933C-11E7-A022-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rene Scharfe <l.s.r@web.de> writes:

> If format_tracking_info() returns 0 only if it didn't touch its strbuf
> parameter, so it's OK to exit early in that case.  Clean up sb in the
> other case.

These two "if"s confuse me; perhaps the first one is not needed?

