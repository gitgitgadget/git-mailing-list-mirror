Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358FF2090A
	for <e@80x24.org>; Mon, 20 Mar 2017 20:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756155AbdCTTsj (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 15:48:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61060 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756111AbdCTTrM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 15:47:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C2467F523;
        Mon, 20 Mar 2017 15:47:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NFwmIJr/lLcrawR4hbCFQLOL0bY=; b=lKnbp4
        JhIM3ysoJGwXA44/ujUQhs/I994MnR/yKtfahJulAsrfHo24oUm2fEi4o/0OqKQe
        gi9VNm0XG4GxvJrbpRx2ysilCq7jo54MEd9PibYrA9Ji1qGG2jj4Ajfn0BQTx3gH
        6eb8KHcNB+OBeUKJ41Jj4hlh3FLzwbskzdl5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=axe2EM2bc7/EiuiPYjfajMfynIF9cHqA
        3aXNwfV5OyT59p9sxkz8fnlzzetbA2THm/QpQ++1EIyBAizu+DoZObGaf6mvkJUj
        oxIHA6k1LUCThhAyPRa6IlcrT2ssY58lZKZzRt2JXfl1iAVi7OHJ/ilbbvvKwKPS
        ftcViGovNZw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02AEE7F522;
        Mon, 20 Mar 2017 15:47:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AD597F521;
        Mon, 20 Mar 2017 15:47:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 09/20] refs: split `ref_cache` code into separate files
References: <cover.1490026594.git.mhagger@alum.mit.edu>
        <f16c123354404088f9ffef0b0e31d4a9817cb804.1490026594.git.mhagger@alum.mit.edu>
        <20170320174937.xkozsdruyrj44qg2@sigill.intra.peff.net>
Date:   Mon, 20 Mar 2017 12:47:02 -0700
In-Reply-To: <20170320174937.xkozsdruyrj44qg2@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 20 Mar 2017 13:49:37 -0400")
Message-ID: <xmqqpohbvih5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD9DF992-0DA5-11E7-A9AB-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It might have been a bit easier to review as separate steps for that
> reason, but I doubt it's worth going back and re-doing. I'll take your
> word that nothing substantive changed.

In such a case when I do not want to "take your word", I often do
"blame -C" on the result, setting the bottom of the range close-by.
I should mostly see the ^bottom lines (or with "blame -b", lines
intended with blanks without any commit object name).

