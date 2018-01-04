Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4171F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeADTJZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:09:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55142 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeADTJY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:09:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5620BC4EE6;
        Thu,  4 Jan 2018 14:09:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pR/LFClEJ6w8rHI3mdPToPdpIrY=; b=VGFJOn
        Nr1lx1tSsio28VmIuwsO0CMFo08War7jSyS0yhDWf8qGSeJurlp2px23Pe+GWeYP
        rMGnzICXqNgO4RuOF8Ui/he0IryhJtPaN0wIi9mL7LSKh9zeWBYE/jEFce//e/GI
        RKDtBL/RHubWjXrosn9IwnCzuHQoefmmR9aOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EF4pF8eWaSLlgMyVAAtnGoANx3AzhkXz
        /Vyuk8EzRrT/2Is6rTbWcTsj3w3YTMb7Qwo8/ztGYxuevGDn5OZhg03l35wLl1ji
        EU2OTDCP4Eaqi7WWoEERbF3eK2ns+ocOmlsWEJOOGWH5/8dWve39N0OwO81OCyfM
        fL9IW6qfjh0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B28CC4EE5;
        Thu,  4 Jan 2018 14:09:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B34E5C4EE4;
        Thu,  4 Jan 2018 14:09:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     John Cheng <johnlicheng@gmail.com>, git@vger.kernel.org
Subject: Re: Misleading documentation for git-diff-files (diff-filter)
References: <CAJzZBAT--X8GXg_knege_pZ8A=_Qk9nyMCLaoRMvjhUFGQYsZA@mail.gmail.com>
        <xmqqvagifqj8.fsf@gitster.mtv.corp.google.com>
        <CAJzZBAQ_T3JDqsxy=s7gbrRQjDsdZODB8XsBb4TUCs1K1Bmnjw@mail.gmail.com>
        <20180104164941.GB18376@sigill.intra.peff.net>
Date:   Thu, 04 Jan 2018 11:09:22 -0800
In-Reply-To: <20180104164941.GB18376@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 4 Jan 2018 11:49:42 -0500")
Message-ID: <xmqq1sj5fnkt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C69078BE-F182-11E7-9C22-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 9d1586b956..743af97b06 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -469,6 +469,12 @@ ifndef::git-format-patch[]
>  +
>  Also, these upper-case letters can be downcased to exclude.  E.g.
>  `--diff-filter=ad` excludes added and deleted paths.
> ++
> +Note that not all diffs can feature all types. For instance, diffs
> +from the index to the working tree can never have Added entries
> +(because the set of paths included in the diff is limited by what is in
> +the index).  Similarly, copied and renamed entries cannot appear if
> +detection for those types is disabled.

Makes sense; thanks.
