Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F8120373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbdCMUiM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:38:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55813 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751477AbdCMUiK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:38:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED5B384CE0;
        Mon, 13 Mar 2017 16:38:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z4mCfls2g3eEuv0KNbdD3tiRzBU=; b=uthY2H
        HFKoBM9Hm9gobGu8BjWwX+jornO8+UdrgRXk3XbbMTJVmHTWV5xGmEadxhkS2rV7
        jIgxoS9+/LJXm2Tgxn87fnZbK08YEPcz3OvZgwEx5qq9yJJfZOLmv2Yt8X31OTcZ
        x17ojQ6O1+r09rOSeEmJgStiSxQdcASj6Y2Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TPfdeqFOkWk64gSZrlE9bv6jGIspf0qg
        pG50Gfmr47VNiWtBG0D3Dl3mEF7y4r3GligqwkNxkPh2ozoxvwNq1TcEw3HjbVx/
        XJ2zH8LZtNx+WB4+Uo+VLvHByWgSsMTbmlL14Cf77o9IwwXkzAcIOHxEz9PVRwsK
        iV921rb6NYE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E677784CDF;
        Mon, 13 Mar 2017 16:38:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5988784CDE;
        Mon, 13 Mar 2017 16:38:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Domagoj Stolfa <domagoj.stolfa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible git blame bug?
References: <20170313201104.GA32821@workstation>
Date:   Mon, 13 Mar 2017 13:38:07 -0700
In-Reply-To: <20170313201104.GA32821@workstation> (Domagoj Stolfa's message of
        "Mon, 13 Mar 2017 21:11:04 +0100")
Message-ID: <xmqqmvcorjyo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F79AD8AE-082C-11E7-978A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Domagoj Stolfa <domagoj.stolfa@gmail.com> writes:

> The question is whether this is a bug or not, as --since=<year> might not be a
> valid filter.

I do not think blame ever was designed to work with --since, so that
is indeed the case.  

Making it work with --since=<date> might be a worthy addition.
Patches welcome.

