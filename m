Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250A4C55179
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 19:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0965207EA
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 19:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yH2aFLns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgJ2Ttj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 15:49:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51784 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgJ2Ttg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 15:49:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1386F7E4E6;
        Thu, 29 Oct 2020 15:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xu2vpR8kjysCHhsqhYJQ1l0T9ew=; b=yH2aFL
        nstanrZ5mbZL0qd+PIsfFOlJ5fVYMbrjYDBDwDDU/1+euLSrMtEw3pKGsGnTkqNf
        hBSi+2YhSfHLEGK32xkYPIGTO7aFO13FY7WGZ1RK6Zl5uyPBgzArOEv7YwvEKGlq
        I+raXXccg/0rOYkpsF3q8q4LPOaKm0QQ1H3Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PdudoQNyTiMN7H77wKuC0jAtYN0eeevl
        dHC9OwXTyaSdH7qiKWQsK2npq2b0VC2wu18TbrXGWqpV0aLrCfK1LpsYBXQIuS4W
        82/r60EBj9NSKTwFUs1YtiGp43pxUZQTRvVapM59YSEBw60GW2zSLfGt3a36A9eK
        3zyPbTDsaus=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AA147E4E3;
        Thu, 29 Oct 2020 15:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 881677E4E2;
        Thu, 29 Oct 2020 15:48:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        chriscool@tuxfamily.org, peff@peff.net, newren@gmail.com,
        jrnieder@gmail.com, martin.agren@gmail.com
Subject: Re: [PATCH v3 00/19] Parallel Checkout (part I)
References: <cover.1600814153.git.matheus.bernardino@usp.br>
        <cover.1603937110.git.matheus.bernardino@usp.br>
Date:   Thu, 29 Oct 2020 12:48:43 -0700
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Wed, 28 Oct 2020 23:14:37 -0300")
Message-ID: <xmqqlffo7qzo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0CAFCE2-1A1F-11EB-9DF9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> There was some semantic conflicts between this series and
> jk/checkout-index-errors, so I rebased my series on top of that.

That is sensible, as you'd want to be able to rely on the exit
status from the command while testing.

Will replace what has been queued.
