Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A041FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 17:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbdDCRHQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 13:07:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54906 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751732AbdDCRHP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 13:07:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A48C386CBD;
        Mon,  3 Apr 2017 13:07:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dUp5yvIkaWThemjscqiA+b09peY=; b=P4Nhmb
        Smlzkhoy6758nS8Tw6zbInjCaXSuatPbV0UAhQ+UhvDmClNi4whEm45bnwOzuXJb
        EdT0uaQuawbMhR3+yuvb38gmhLF2/Ncz/R1qLariF+JoK2X5kcIER01nTNoOsbty
        ff1L0m03O/2nhkGQROhCCdvz5raljpnFsxztg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hmxl+3f1tZBMTLMCjqqFbEfN9SS8VhVf
        c3G2U4NjuhK7m4VJ1JqLbLYv+mb058p8AXXbKm54uKyOPvPEzY+wW3beKwcxm4u+
        eu4cJakSpLkYfrPsPk914GMVPE5Gtty2AgbtZc97YTa9+4hbRBdreeBVZSqc06ML
        fG0gYnuHeLE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B9D486CBC;
        Mon,  3 Apr 2017 13:07:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A24F86CBA;
        Mon,  3 Apr 2017 13:07:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] name-rev: provide debug output
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
        <cover.1490967948.git.git@grubix.eu>
        <21cf9d6f55d17463ab6eccdd78d57cf4a1b8e9e1.1490967948.git.git@grubix.eu>
        <xmqqtw69z8vz.fsf@gitster.mtv.corp.google.com>
        <14D0E7F4-0DC7-42ED-8DEE-B0338ECBA80D@grubix.eu>
        <xmqqd1cxz5gb.fsf@gitster.mtv.corp.google.com>
        <xmqqzig1xpm6.fsf@gitster.mtv.corp.google.com>
        <c85bc2a1-56d8-8a02-6089-2b8cb3d39e99@grubix.eu>
Date:   Mon, 03 Apr 2017 10:07:12 -0700
In-Reply-To: <c85bc2a1-56d8-8a02-6089-2b8cb3d39e99@grubix.eu> (Michael
        J. Gruber's message of "Mon, 3 Apr 2017 16:46:01 +0200")
Message-ID: <xmqqa87xs9mn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBB6F332-188F-11E7-B4FE-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> No, I checked not to change the existing behaviour.
>
> If you look at the comment above that then you see that one of the sides
> of the comparison is a non-tag, so we compare 0 to 1 or 2, the boolean
> outcome being the same.

That one I understand, but if you compare 1 and 2 (one side being a
lightweight, the other being an annotated tag), they no longer
compare equal, no?
