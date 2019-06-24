Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C50291F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbfFXSBy (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:01:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50097 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbfFXSBy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:01:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80C9415DBAB;
        Mon, 24 Jun 2019 14:01:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RWh5gjnymixhduAkcQImCIpZG0w=; b=hFXnVx
        xa6wrILSIvV5QHu/5pVWzVoWmd8lAQO9BctHylB3o/ZpQaINvl+FbQTD8VZY90IL
        0+y2u68xVjUvzkMJBO875l1pOq/pxv2iFee5gCXDN7YswbLH2CV0FSvFiH2RVB3i
        3H7mJuvqm9z5majMhSukVG0e6MVRDf9g5hjEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IuCbQsqy7133fGWhN4KRjECy3e9vG+y9
        ENy3Fc3arekv4dsRtHZnScIZ/y4fGI1jb/zlrhHxmC7VQLcHtSFawkYmmvt26+2Z
        d68NF5vFSz8sJCg7o08YHF3c2VxYSL4DmHeMbgJDHgsyY36bJsCEjCpTI84qUn8W
        5EhGtmapZL0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7670E15DBAA;
        Mon, 24 Jun 2019 14:01:52 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BECB115DBA9;
        Mon, 24 Jun 2019 14:01:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dimitriy <dimitriy.ryazantcev@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] l10n: localizable upload progress messages
References: <20190622093655.80092-2-dimitriy.ryazantcev@gmail.com>
        <CACsJy8CPChOGSZVfXd6ioaXHWg_aFxNMzr2J=Zdm2RZXkO++Ew@mail.gmail.com>
        <CAPUT4mQnsThA=ZxZD8K+J+u6tbN5PggPomuymEUO=u2GT88aUA@mail.gmail.com>
Date:   Mon, 24 Jun 2019 11:01:50 -0700
In-Reply-To: <CAPUT4mQnsThA=ZxZD8K+J+u6tbN5PggPomuymEUO=u2GT88aUA@mail.gmail.com>
        (Dimitriy's message of "Sat, 22 Jun 2019 19:39:57 +0300")
Message-ID: <xmqq1rzij20h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24D498D8-96AA-11E9-836F-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dimitriy <dimitriy.ryazantcev@gmail.com> writes:

> I just moved 'B' out of else block so it will be prepended with
> 'Gi'/'Mi'/'Ki' when needed.
> Note: I changed 'bytes' to just 'B' unit.

That makes this change more than "localizable messages", doesn't it?

As an old timer, I do not mind MiB (I'd prefer the old-fashioned MB
myself), but I think "20 bytes" (or "1 byte") spelled out is much
easier to grok and less prone to get misunderstood than "20B".  Like
it or not, with scale prefixes, e.g. "20 kiB", "20 MiB", etc., it is
hard to misunderstand what 'B' means in there, but without any scale
prefix, i.e. "20 B", it is rather easy to get confused what 'B'
means.
