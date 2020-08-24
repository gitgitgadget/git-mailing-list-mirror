Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573A2C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310EA2075B
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wbH1gGwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgHXSmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:42:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56966 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgHXSmO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 14:42:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 201C06B143;
        Mon, 24 Aug 2020 14:42:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iW08wbQh0RDW0R+11byf9rcTpak=; b=wbH1gG
        wpk1AeGyD9Syw9UFP9WUzOjYbcy8YyT0rEtBOzq14ByMYOlrZBy7Cowp9CshU7II
        SRd1/+JoO260HpAoS1wFY2XEc2WY02WSH8v90ji3xQfqERjkTapxnHg/o2dsCv4i
        AlkF6fZhkaLWM8NQDED/RLRr82xkvHh+h4hyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hu8oQWJa8yrfC9+kNzWCxtzbPCMwVhVy
        vO+XPoV0J4xLfJgV3IOceSLtdsevsJttQlm+vJLKVf6wcA252cahUeADA8ZLxseo
        3GJnxCTBVcTIbkrr6/80RCO1RUAN+pypOkKTMNhhJDKI/lestKTBZjATWLO7UEbk
        jUWqu5PxL8I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1687C6B142;
        Mon, 24 Aug 2020 14:42:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9651D6B140;
        Mon, 24 Aug 2020 14:42:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Optionally skip linking/copying the built-ins
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2008170653440.56@tvgsbejvaqbjf.bet>
        <xmqqblj92lro.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2008241445200.56@tvgsbejvaqbjf.bet>
Date:   Mon, 24 Aug 2020 11:42:11 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008241445200.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 24 Aug 2020 14:47:13 +0200 (CEST)")
Message-ID: <xmqqzh6j51j0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 858C1572-E639-11EA-9897-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> It is close ;-)
>>
>> The author name is correctly on "From:" but not the address.
>
> Yes, but the problem seems to be insurmountable, as I _think_ it is to
> prevent spammers from successfully sending "from abitrary email
> addresses".

At least, even with only the name correction, the threads were
easier to locate.  Perhaps you can leave the in-body From: in to
help "git am" but keep the half-successful attempt to give the human
readable name to humans who are reading in their MUA?

Thanks.
