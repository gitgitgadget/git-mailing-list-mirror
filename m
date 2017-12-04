Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6ED20954
	for <e@80x24.org>; Mon,  4 Dec 2017 22:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbdLDWWr (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 17:22:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56404 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751934AbdLDWWr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 17:22:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F547AFECF;
        Mon,  4 Dec 2017 17:22:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/kg62ffz3I4/6nliHbCUfEw1IOk=; b=YZprVL
        3SBc6T53kPElhXNfNPjj4YfkyNsODGq0nPnA6GJ/wPq5SrHL6zgdih5T758I0VUA
        0mwoiy03m5+Ahxm7/CDx1pUMtVJZ/1MR9cxClDlyW/TDzbh+A1QND9buL+woElJl
        9z7CIjENdpbxNLz7zQT45TrljTllI1Ur0ocU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G1gUO9cHAw5l1bGeiLpcdy/aAnFqQWCY
        GszWpQBoOmpdFpqGTGNiw4C5c8yn4Y2cLOYQ1Nh9ON542wCugcreQUYqQMEKJ3WA
        cLWydy4Tz2pyjXLoSign9+Jpq8clcVhNVP82I4YeKuKLVMFDylK4cmeC6GYllAkW
        6Shv9ryQ4Xg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 649DCAFECE;
        Mon,  4 Dec 2017 17:22:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7166AFECD;
        Mon,  4 Dec 2017 17:22:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 0/2] fix v2.15 progress regression
References: <20171204203647.30546-1-lars.schneider@autodesk.com>
        <20171204213350.GA21552@sigill.intra.peff.net>
        <xmqqvahmkwbi.fsf@gitster.mtv.corp.google.com>
        <20171204220228.GA29422@sigill.intra.peff.net>
Date:   Mon, 04 Dec 2017 14:22:44 -0800
In-Reply-To: <20171204220228.GA29422@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Dec 2017 17:02:28 -0500")
Message-ID: <xmqqindmkua3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A72391B8-D941-11E7-B6E0-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's what I think we should do: fix the bug in the minimal way, and
> then drop the useless code. It's worth doing in two steps, because we
> may decide to resurrect the feature later, and it would then just be a
> straight revert of the second commit.

Yup.  Thanks; will queue.
