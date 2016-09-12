Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3D6207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 15:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbcILPmY (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 11:42:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53536 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752243AbcILPmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 11:42:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 379EC3D3C2;
        Mon, 12 Sep 2016 11:42:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xbQiyfV+g/6aDu3d8g5aFdv8QEc=; b=GbA+uA
        ho3tBG1x5jqPZSsZ941gmcrwVh/qEcx8d/6IdNz/7+Mjh+g+WfjuS5zJIwvGVwuc
        j+PvgoN1G9YnQ3GDsz3LELivp6zqaTpbRDa2N8RdhaV0CMqGAp5JO0sG6Ca/59C4
        Axl8qtMW/p+glY3l9c/jrT1kj/pXNGUbS5AYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gnX42ECzSsJniZHpH4xS7lLXl7D7syYz
        hwueTP4SBecqJ7SVKx2cUsv4DlRdSqdZFkQ/DfbyyZy2le5RYL4hSPj8xdt6N1FP
        FHSTh+QoDgpaE298bs9YiMDDxbey8ytxMrxflpOJVhTrCJGKnOUuGoopGkvhg60a
        7+UcbkeFQjo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F56F3D3C1;
        Mon, 12 Sep 2016 11:42:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5E723D3C0;
        Mon, 12 Sep 2016 11:42:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 20/25] sequencer: left-trim lines read from the script
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <09e05e7ac23164625f2076ff06d2b034101878da.1473590966.git.johannes.schindelin@gmx.de>
        <xmqqsht657ls.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609121019290.129229@virtualbox>
Date:   Mon, 12 Sep 2016 08:42:17 -0700
In-Reply-To: <alpine.DEB.2.20.1609121019290.129229@virtualbox> (Johannes
        Schindelin's message of "Mon, 12 Sep 2016 10:23:28 +0200 (CEST)")
Message-ID: <xmqqr38p3z1i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D6204CA-78FF-11E6-AB12-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I do not offhand see why we want to be lenient here,
>> especially only to the left.
>
> Postel's Law.

How would that compare/relate to yagni, though?
