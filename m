Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323302036D
	for <e@80x24.org>; Sat, 25 Nov 2017 02:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbdKYCcF (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 21:32:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60378 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751748AbdKYCcF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 21:32:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1741C2F37;
        Fri, 24 Nov 2017 21:32:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GXVBl1ItklDXWDCscbUfauWDHTw=; b=aekSwn
        6ouJQcboS9DjZCY24Hx0In4Mk/bve7l7d1hVvkSUWawRX2rcgPJ4WM2qR01Cgjqd
        eKkPlTPqF+CWYAyHlIkBBskgyx2itCSut1Ph4DC3oKuZLsed+KhluU4ZOiE7MHJC
        gjeSICCSpeiOw2fKQG+mtv7UbqUQP5XvZy6AE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k411SAGtxLISv46CtAoMeVvA9DXYfS6f
        K7f2lgZk/1S//oJ93BtW5vgbP1YPj2DNXAIY3oy3Ti5bdAeziNfFgGjYWiVnG6G4
        lxiISu+IOiF8Hp0Ezyfek4RxfjRsV4Bi26zGlqMVZuOL0Sht+i/DxBqZmlq08QXn
        lXNeEPyKLqY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A941AC2F36;
        Fri, 24 Nov 2017 21:32:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DEEF8C2F34;
        Fri, 24 Nov 2017 21:32:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Shawn Pearce <spearce@spearce.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFC: Native clean/smudge filter for UTF-16 files
References: <BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com>
        <20171124180401.GB29190@sigill>
Date:   Sat, 25 Nov 2017 11:32:00 +0900
In-Reply-To: <20171124180401.GB29190@sigill> (Jeff King's message of "Fri, 24
        Nov 2017 13:04:01 -0500")
Message-ID: <xmqqy3mvks0v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D18B346C-D188-11E7-B791-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So anyway, that is an alternate strategy, but I think I like "canonical
> in-repo text is utf-8" approach a lot more, since then git operations
> work consistently. There are still a few rough edges (e.g., I'm not sure

Sounds like a good way forward.

> if you could apply a utf-8 patch directly to a utf-16 working tree file.
> Certainly not using "patch", but I'm not sure how well "git apply" would
> handle that case either). But I think it would mostly Just Work as long
> as people were willing to set their encoding attributes.

It should work (or fail) just like applying LF patch to CRLF working
tree, so I wouldn't worry too much about it.

Thanks.

