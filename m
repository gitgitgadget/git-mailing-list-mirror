Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A907CC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A47121741
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ySpb8Uv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIRRvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:51:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61278 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRRvp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:51:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57DF2F99E0;
        Fri, 18 Sep 2020 13:51:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e1b6uCXn0kJyL+RelAuBu8au+AA=; b=ySpb8U
        v3GKgAHoZWB+Z+3by10Mdj201m3eQPS26zSRjrwmGBuVEa9eML2/Msh1B3Tk/CKH
        pQMVPJWaOZDag1EBNrkPFMRtON3riJB/qm3LRfyReCLuAQVuF9oGRjZIBBWYMbcw
        QPwQlhx/UE8bp8n8QQ6D3sdGO4HIydmEPrq1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vIJXujdNVeWOk6LJ2yreTVNaPmRBCYQ+
        H98reYP2N0qMne78nuyXrZzllsi00GFYSG5+UphfO9SlUqKlVf+/9VdPXXiPdN/V
        I2mGxr8VFtLRH4H4CmlWxO4ifqnub/Kzb8OgLKGlR0X5ufw2ODLWP6G6kk6+aijB
        TvWErMcstFM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50E43F99DF;
        Fri, 18 Sep 2020 13:51:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8C584F99DB;
        Fri, 18 Sep 2020 13:51:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Guyot-Sionnest <tguyot@gmail.com>
Cc:     git@vger.kernel.org, dermoth@aei.ca
Subject: Re: Allow passing pipes to diff --no-index + bugfix
References: <20200918113256.8699-1-tguyot@gmail.com>
Date:   Fri, 18 Sep 2020 10:51:39 -0700
In-Reply-To: <20200918113256.8699-1-tguyot@gmail.com> (Thomas Guyot-Sionnest's
        message of "Fri, 18 Sep 2020 07:32:54 -0400")
Message-ID: <xmqq7dsrm0r8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B3C1618-F9D7-11EA-883C-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Guyot-Sionnest <tguyot@gmail.com> writes:

> Along with it a small fix in --stat and --numstat that affected one one
> git range-diff test, where added/removed lines stts were missing (needed
> for difffing the pipes too)

Next time, please send each of such unrelated patches independently,
not as a two-patch series that gives a (false) impression that the
second one needs the first one to work correctly.

Thanks.
