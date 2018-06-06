Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0FB1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933638AbeFFRK6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:10:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52331 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933589AbeFFRK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:10:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 56FEFE6194;
        Wed,  6 Jun 2018 13:10:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=qwgI0J1Rah0a+P6+3mjzavV1ocI=; b=ZRpWWa2
        Mi5WOW+b3Pen4o0EiCdQqE4Ohuc1M2ibA2GP2ywz8BFdSBJarFDkuu7sd6vZhf8h
        ZhhZoETiX3Sxv4pzj442E8iJBlzHb/DuOgHEDH6BNZSJrbV2keGeE5pT20CKKCpP
        n82UwjRI/oW0C+wU2x51cFgTI6Tx3NNQKnXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=UUX0airH1jCqFJtnjU1ffwXTrnHWQvqPo
        EtmPOIWsezUCe/sNJj09+kqefuc0vd9pXgr01DxGrpJfWHHkjTjamwO4uqwrDigQ
        V7heCsPW1yzjWRYiiWGm2xkTK1KnGyLl7RiH8pAXsUIVc7hLC36nBgw/nQI/q7vF
        0B5kLY6+3Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DA8BE6192;
        Wed,  6 Jun 2018 13:10:54 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCEA7E618F;
        Wed,  6 Jun 2018 13:10:53 -0400 (EDT)
Date:   Wed, 6 Jun 2018 13:10:52 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 2/2] json-writer: t0019: add Python unit test
Message-ID: <20180606171052.GI3094@zaya.teonanacatl.net>
References: <20180605163358.119080-1-git@jeffhostetler.com>
 <20180605163358.119080-3-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605163358.119080-3-git@jeffhostetler.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 91F64640-69AC-11E8-B925-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com wrote:
> +# As a sanity check, ask Python to parse our generated JSON.  Let Python
> +# recursively dump the resulting dictionary in sorted order.  Confirm that
> +# that matches our expectations.
> +test_expect_success PYTHON 'parse JSON using Python' '
[...]
> +	python "$TEST_DIRECTORY"/t0019/parse_json_1.py <output.json >actual &&

Would this be better using $PYTHON_PATH rather than
hard-coding python as the command?

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Sometimes I think I understand everything, then I regain
consciousness.

