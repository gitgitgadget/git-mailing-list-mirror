Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60AC920193
	for <e@80x24.org>; Thu,  1 Sep 2016 20:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753427AbcIAUzF (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 16:55:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64944 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754036AbcIAUyw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 16:54:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB40B3A3D2;
        Thu,  1 Sep 2016 13:58:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1zcoRNHXR1aBFc8rtXjQ4zAX25w=; b=ZZjQW3
        FE+bRkd/IrfXmtybLVKaq7+JRFRP1Xr1w4uMKETj6OZEwkqDLS++hXsbJzZ8i7do
        BOpqV1tGtd8dL2RGm102ZTsHDgA3ilyb+yWRYAm+YekuYWUIiCMX2cNcmlwr6gRT
        BqhvAFuT0byk88PPQ9ZBCbZZtaxKqJuI0TBlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IbdLf4fyMJm9du3zyqJZmNo7hELDLLVf
        dVso/3aWR6M8LNRmJex1DpuRfVZ7/XsyI6NvpivtA6ecpcZxpNKvVZ5nwHOTTdJj
        /QJh05AjIq5jZ2MWp0zqpdZF297/v/HKtcxahHHBrLGvDLn7LZneueas7uGTidlR
        V04JFlSplh4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C05153A3D1;
        Thu,  1 Sep 2016 13:58:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 442C33A3D0;
        Thu,  1 Sep 2016 13:58:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 21/22] sequencer: left-trim the lines read from the script
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <8c30113a920e075e5ecd68ba31b4007de3e2dbc2.1472457609.git.johannes.schindelin@gmx.de>
        <7996a963-52b5-5f3c-f686-f5cf22573573@gmail.com>
        <alpine.DEB.2.20.1609011608440.129229@virtualbox>
Date:   Thu, 01 Sep 2016 10:58:41 -0700
In-Reply-To: <alpine.DEB.2.20.1609011608440.129229@virtualbox> (Johannes
        Schindelin's message of "Thu, 1 Sep 2016 16:13:57 +0200 (CEST)")
Message-ID: <xmqqvayfwlgu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8A4E984-706D-11E6-90EF-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Interactive rebase's scripts may be indented; We need to handle this
>> > case, too, now that we prepare the sequencer to process interactive
>> > rebases.
>> 
>> s/; We need/; we need/
>
> Hrmpf. From http://grammar.ccc.commnet.edu/grammar/marks/colon.htm:
>
> 	There is some disagreement among writing reference manuals about
> 	when you should capitalize an independent clause following a
> 	colon. Most of the manuals advise that when you have more than one
> 	sentence in your explanation or when your sentence(s) is a formal
> 	quotation, a capital is a good idea. The NYPL Writer's Guide urges
> 	consistency within a document; the Chicago Manual of Style says
> 	you may begin an independent clause with a lowercase letter unless it's
> 	one of those two things (a quotation or more than one sentence).
> 	The APA Publication Manual is the most extreme: it advises us to
> 	always capitalize an independent clause following a colon. The advice
> 	given above is consistent with the Gregg Reference Manual.
>
> Based on that, I think that a capital is the correct case here.

Does that manual have anything to say about semicolons, which is a
different thing?
