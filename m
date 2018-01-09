Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 882FD1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 22:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755093AbeAIWEY (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 17:04:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59941 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754821AbeAIWEX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 17:04:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5B6FC12B6;
        Tue,  9 Jan 2018 17:04:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EFEpCYukSwUYK/JRUmjdkPDd5xM=; b=E54qFe
        nIp1wKmCOhiaWHfNUZGFoo7ZRScvC4LoucbfPikQHFCrYFMXA4iitdDR/sOuCclj
        hgznnx6ey7ZKnAMuVdBIwmi6qbGcYuaTlGc7Nuj97riEbZN3sDGYxnrsVjwd0p81
        6DpSt3vgi8c1o3YOu91ge1w/cIi2kF+TU6Ixc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S6GDSWpvboPBCPN69wfznRRxmicsX1EQ
        nMZrVuqSQR8V70/2hb8XZCI49OFVXHVjogceaqf1hA0ZBb3S+i+ubMyd3qDw/IWU
        yAS+0+SKWGBTlaktG7/bWToFqC9qY47PsSB6RdaYiEGHuTV1Kcn9wMveczHknnze
        jLqupfTI6No=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD587C12B5;
        Tue,  9 Jan 2018 17:04:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A75FC12B4;
        Tue,  9 Jan 2018 17:04:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/20] cat-file: rename variables in ref-filter
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
        <01020160db067bde-7f500636-b80e-4099-a84e-2613126c9aa1-000000@eu-west-1.amazonses.com>
Date:   Tue, 09 Jan 2018 14:04:21 -0800
In-Reply-To: <01020160db067bde-7f500636-b80e-4099-a84e-2613126c9aa1-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Tue, 9 Jan 2018 13:05:23 +0000")
Message-ID: <xmqqtvvu3d0a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C303828-F589-11E7-919B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Rename some variables for easier reading.
> They point not to values, but to arrays.

Once the code is written and people start to build on top, a change
like this is not worth the code churn, especially because there are
two equally valid schools of naming convention.

 - When you have an array, each of whose 20 slots holds a single
   dosh, I would prefer to call the array dosh[20], not doshes[20],
   so that I can refer to the seventh dosh as "dosh[7]".

 - If you more often refer to the array as a whole (than you refer
   to individual elements) and want to stress the fact that the
   array holds multiple elements in it, I can understand that you
   may be tempted to call the whole array "doshes[]".

So please drop this and other "rename variables" patches from the
series.


