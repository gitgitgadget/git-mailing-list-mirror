Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF5720954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbdLGVLX (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:11:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54458 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752730AbdLGVK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:10:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17030C4E97;
        Thu,  7 Dec 2017 16:10:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ECNiI0Qi+pO8aDcOAjNF75bAIok=; b=vDeEXi
        8i64BjwK/lbV4+LCTOSKKI6W4kfcWLSG56uvL16E9yeWHgzAVkf1mjcrL6yNpEuw
        K5lOvyUPdDGZa4iNishjZekB+GGnoArO/DXnB5+ELk6NiAhQWh5TcaIojhNVG4YB
        s8LsJkFfVxvMv7zBlsXTcfCSu2pPmZuoNm3hE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D345hyqE+XdI8w9pYmORjPugdv5wgeqt
        PgLgJM7cX4vvikax2qrSO+c4agkp6ddCUdXyZicTBXbBsWVP/aaPbuiXKH5OgcXF
        fRPm+YoL2OpXr/wuMU1d3QDxvKMy5ACjSEIIeVIaekABm6bNkWg64R65K+qDhQz+
        m3XFD8OVNfE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E523C4E96;
        Thu,  7 Dec 2017 16:10:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54B7AC4E95;
        Thu,  7 Dec 2017 16:10:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
        <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
        <alpine.DEB.2.21.1.1712071643410.4318@virtualbox>
        <175f87bc-0270-fb18-fc14-24e8f59321d6@jeffhostetler.com>
Date:   Thu, 07 Dec 2017 13:10:55 -0800
In-Reply-To: <175f87bc-0270-fb18-fc14-24e8f59321d6@jeffhostetler.com> (Jeff
        Hostetler's message of "Thu, 7 Dec 2017 16:08:02 -0500")
Message-ID: <xmqqh8t2ckgw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DBC5276-DB93-11E7-A689-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I'm looking at t5616 now on my mac.
> Looks like the MAC doesn't like my line counting in the tests.

Ah, of course, test "$(wc -l)" = number would not work over there
we have "test_line_count" helper exactly for that purose.

