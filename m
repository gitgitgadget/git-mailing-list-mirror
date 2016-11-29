Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623291FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 18:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934260AbcK2Sb7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 13:31:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51038 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934246AbcK2Sbz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 13:31:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4FCB536F3;
        Tue, 29 Nov 2016 13:31:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QNE5qYx1XHMJswJ127vlgEfmXac=; b=nV/AsJ
        gBgHHbVSEnfwbp3g5gqOu9971jxqc2ZHD4LF5FrKjBs6ZW/rdVJH17zt8viyIANN
        RUSYWqm1fw0yOAb7fmoOcAC9OxUAedHRF18u7KdX9sjwwJrqw293vgY/k+9DH5me
        ah2RAYJe1EXSyFc6Z+q7jnJuwTTv28mO00rl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aHNkLp6+NgAPM1RfylGdbnGPVc03h7I1
        P3I3CFsqE32ozEP1Sze7KOv5fCQYGAojwxLriG/Qb//3/kpiywnVC1MuE0eW15Q8
        d19TZaTXMeIRUri305qAm8oJZwF4BAjrUrlVeS1LWSrrofbikJtS3EgTLbJmLnwh
        U8eDSNlkSnQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABB4E536F2;
        Tue, 29 Nov 2016 13:31:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CA6C536F1;
        Tue, 29 Nov 2016 13:31:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
        <20161129065912.xa7itc3os425mr3r@sigill.intra.peff.net>
Date:   Tue, 29 Nov 2016 10:31:51 -0800
In-Reply-To: <20161129065912.xa7itc3os425mr3r@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 29 Nov 2016 01:59:12 -0500")
Message-ID: <xmqqfumagmso.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 197C6C3E-B662-11E6-B7AE-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm actually considering scrapping the approach you've queued above, and
> just teaching verify_path() to reject any index entry starting with
> ".git" that is a symlink.

Hmph, that's a thought.
