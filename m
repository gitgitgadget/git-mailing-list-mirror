Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8AE203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934367AbcLMSms (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 13:42:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50373 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932250AbcLMSmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:42:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FE0656E8C;
        Tue, 13 Dec 2016 13:42:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nzHKy+QKEW+6N1P9PHC/pvkUqw0=; b=lKFo+x
        ZGF3FNeQRoR0Qw59deKnLhD3RGCRgyyunaKPWNjs3c+Wb0UX23JfnNtmjsJRrIC7
        X5ZjBR85ExFgxu9toiYWKldxTXdLPdrhD5Rnj8uux7WW1LppxOYN6GWcKA4AwfSU
        7fOQQ8VhmO7XN5dzPf3W+HM+sBhjBUVzVQbA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GO1A0t9GSnaj7V7JRskXSWdzLCINj+mQ
        9uJgkYZ174XrLqBz6H6yG+/Cesy3V3FkrOE9lVM/iyLRdUg/e47p30HvmZL6tqQk
        KarCcd4uWclhuBu/LgJbuvJTEoKYJWM1XPrw80jmRBX/hGDOqB6O/PFnZ0nOqTwN
        HLoHnYKoPuY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47B6756E8B;
        Tue, 13 Dec 2016 13:42:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8EC156E83;
        Tue, 13 Dec 2016 13:42:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] handling alternates paths with colons
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
        <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
        <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
        <20161210085133.2pnkz6eqlxoxdckg@sigill.intra.peff.net>
        <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
        <xmqqvauo7p0r.fsf@gitster.mtv.corp.google.com>
        <20161213115018.quulwlheycjtlsub@sigill.intra.peff.net>
        <xmqqshpr4s41.fsf@gitster.mtv.corp.google.com>
        <20161213181755.wrgu6drm45v7xhnl@sigill.intra.peff.net>
Date:   Tue, 13 Dec 2016 10:42:39 -0800
In-Reply-To: <20161213181755.wrgu6drm45v7xhnl@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 13 Dec 2016 13:17:55 -0500")
Message-ID: <xmqqbmwf4qn4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED36632A-C163-11E6-ABC9-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Right, but we also support relative paths via environment variables. I
> don't think that changes the conclusion though. I'm not convinced
> relative paths via the environment aren't slightly insane in the first
> place,

Sorry, a triple negation is above my head.  "relative paths in env
aren't insane" == "using relative paths is OK" and you are not
convinced that it is the case, so you are saying that you think
relative paths in env is not something that is sensible?

> given the discussion in 37a95862c (alternates: re-allow relative
> paths from environment, 2016-11-07). And they'd probably start with
> "../" as well.

Yeah.  In any case, there is a potential regression but the chance
is miniscule---the user has to have been using a relative path that
begins with a double-quote in the environment or in alternates file.
