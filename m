Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 788021FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933896AbcLSS6g (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:58:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65333 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932852AbcLSS6e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:58:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EC775806B;
        Mon, 19 Dec 2016 13:58:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dlICv+EXtAeytVw040Qdd7LUOnQ=; b=l4Lb6g
        e/DIn57XgXSpKlXACUFx4YuSPX/4psKjELwdIlMuvsKUOLVlVEdUOIY7uoTU2Uny
        krekNck13vt2s5hZ43x8cKrFCWIq7/utCllcDkDutzXXoCTy6GbiN7vGEeRL7Bgo
        yJOVqm53/dB0y21cs33xSCpDy/BICUSNVSKrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ITpxYm+PnTXvJwrA8pBwVuO0DUaxrI55
        mAF8lmXsNxVSfkDZNOo+WLgblcmLa3lFB+qIECORljzdnRFcH2lRidsxIg9W17Cb
        RpQlDHGET6fclU7AX39ce1mIF9eqD2tEOlbUWDaCRtmEVGr9UF73BFITHhBTtuIi
        +rwxQug68uk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9424C5806A;
        Mon, 19 Dec 2016 13:58:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E77C58069;
        Mon, 19 Dec 2016 13:58:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 24/34] sequencer (rebase -i): respect strategy/strategy_opts settings
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <a21233f368f066408051e6bdc9a2b6ec513e9e11.1481642927.git.johannes.schindelin@gmx.de>
Date:   Mon, 19 Dec 2016 10:58:31 -0800
In-Reply-To: <a21233f368f066408051e6bdc9a2b6ec513e9e11.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:31:47 +0100
        (CET)")
Message-ID: <xmqqzijroieg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2358B706-C61D-11E6-AE1C-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The sequencer already has an idea about using different merge
> strategies. We just piggy-back on top of that, using rebase -i's
> own settings, when running the sequencer in interactive rebase mode.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)

A handful of steps before and including this one look quite faithful
port to C from the scripted one.  

Looking good.
