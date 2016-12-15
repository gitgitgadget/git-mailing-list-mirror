Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD33F1FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 17:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933358AbcLOR3W (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 12:29:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58077 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932343AbcLOR3T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 12:29:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0446257591;
        Thu, 15 Dec 2016 12:29:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0i0o/5J75keEKSSel3jgga9Sjec=; b=sw3G+M
        uy3dt3HXbdhiq8DW/NcCIFhoxp5SNY9ypdSquqHrrVZnezyYoUVaWLHYR4uf8zBJ
        FuskSNs5XIKQrEz8ytCKbVEU1yRRHPhjohJSkCNqyieWOS8Sd/b8h5tyxvD/6wQo
        zCi27rjW8lN112OgXNbmc/TBl8gbQrx4h0RoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wKZTlfODTd5RTItABv0Idbl257P6GANx
        iJ7msESkrltlmkaJl7abjlSCMslWDemo35C9TxzYhBAEQ9fXQld3HW6ErIVt5jEv
        bK89J2qpbLwS3dxcRM10y6sMUHCSUPFu67QRF0Em5GhwtcXfB2wGe5ED9TBNO86x
        hFSR61hMLv4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDB6D57590;
        Thu, 15 Dec 2016 12:29:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7246D5758E;
        Thu, 15 Dec 2016 12:29:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v10 2/6] http: always warn if libcurl version is too old
References: <1481679637-133137-1-git-send-email-bmwill@google.com>
        <1481755195-174539-1-git-send-email-bmwill@google.com>
        <1481755195-174539-3-git-send-email-bmwill@google.com>
        <20161215002120.xlnlquuqqw25wngc@sigill.intra.peff.net>
Date:   Thu, 15 Dec 2016 09:29:11 -0800
In-Reply-To: <20161215002120.xlnlquuqqw25wngc@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 14 Dec 2016 19:21:20 -0500")
Message-ID: <xmqqh965w17c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE88B3C4-C2EB-11E6-8C48-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Dec 14, 2016 at 02:39:51PM -0800, Brandon Williams wrote:
>
>> Always warn if libcurl version is too old because:
>> 
>> 1. Even without a protocol whitelist, newer versions of curl have all
>>    non-http protocols disabled by default.
>
> Technically, non-http and non-ftp. Maybe just "non-standard" would be
> more accurate.
>
> Not worth a re-roll, but if Junio hasn't applied yet, maybe worth fixing
> up while applying.

I just did a "rebase -i"; thanks always for your careful reading.
