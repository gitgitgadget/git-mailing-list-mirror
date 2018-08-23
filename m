Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5F6F1F404
	for <e@80x24.org>; Thu, 23 Aug 2018 21:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeHXA7d (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:59:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51329 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbeHXA7d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:59:33 -0400
Received: from pb-smtp21.pobox.com (unknown [10.110.30.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPS id A510FF59D1;
        Thu, 23 Aug 2018 17:27:56 -0400 (EDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 086A222325;
        Thu, 23 Aug 2018 17:27:56 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=tC6+kdFSynvxx1Ebe/On96U16TE=; b=KUm9AC
        g+8lF56Ea2hTkjNWGmbScSbwRcBNBshIAzAiMYDMHuwv8oir2Ts0Apm2OBCwlYd8
        +iPnqv4v9NGXOhVb6EXjck8X/oNJbMjKLJMvKanVyDLiEVVmIemmDuU02BMcAaUP
        glsopODlY+CCekDv+ipFfKPDjkATz0ApBN9HU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0198922324;
        Thu, 23 Aug 2018 17:27:56 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=t+3GL7r7VjEqtrHdAH0HpYWRtanPmONPeLyKxKXzgGk=; b=kzPTcc6VaRjC0kW1IqQRmbV30mFxCEgWmb7K1UPh5PS79Rod8Vc6MuHSG2oyFNw+Yb9GKr1dV71mf37o1L8ARLKXbFkqNIo0+pYEA88VQMr/DMAveu5l3Ybjhaod4THg0Hhjey1EgnyIIpYKt8WjPDGLQf39BILEc6PsW12oxPI=
Received: from localhost (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 645A622322;
        Thu, 23 Aug 2018 17:27:50 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] range-diff: update stale summary of --no-dual-color
In-Reply-To: <xmqq1saoixxs.fsf@gitster-ct.c.googlers.com>
References: <20180823023955.12980-1-kyle@kyleam.com> <nycvar.QRO.7.76.6.1808232254260.73@tvgsbejvaqbjf.bet> <xmqq1saoixxs.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 23 Aug 2018 17:27:48 -0400
Message-ID: <87pny8wz6z.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6327102C-A71B-11E8-8765-CC883AD79A78-24757444!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

[...]

>>> -			    N_("color both diff and diff-between-diffs")),
>>> +			    N_("restrict coloring to outer diff markers")),
>>
>> How about "use simple diff colors" instead?

That's certainly better than the one above, and I also prefer it to
"color only based on the diff-between-diffs" in v2.

> I am wondering if it makes sense to remove the option altogether.
> I've been trying to view the comparison of the same ranges in both
> styles for the past few days, and I never found a reason to choose
> "no dual color" option myself.

But I like this suggestion even better.
