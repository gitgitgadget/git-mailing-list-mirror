Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD76202F8
	for <e@80x24.org>; Mon, 13 Mar 2017 17:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbdCMRcu (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:32:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61599 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751229AbdCMRct (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:32:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D27D882500;
        Mon, 13 Mar 2017 13:32:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fhvADcI4J82M/S5pUe7V1oZYVDU=; b=kG4Uvn
        QKr7Mif3YDUccYsl+EYwLQHs4/CUDDlIgpcJuVEjOlA1NLeIjYZq01evl4ZecQEC
        UmIdMVGWXkFVoMhbtoJh6MAzR/tIrXxK6WWCztKQdTBCH0ZfIWRDusnDZbV0ncMQ
        u90O9j3Yzt3qNWbNxc9ztFzveqYBRl6F1ENw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fs9Ql3MPfYTO3i2iPPODbCYXV187TY5Q
        hNPcDgeidb4qSwE8Zj7C1fmym6nFqgQuWtfMrs4r23XG2PXxKhkFycJ7nG6hzeRL
        xRDbhpk2clm3WPrxPsCSrafRRukSPQ56H89XgfSkaZwMVG/clasez4j7rg49Lr+u
        UIvRpx9Kj/A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9FE4824FF;
        Mon, 13 Mar 2017 13:32:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E8DC824FD;
        Mon, 13 Mar 2017 13:32:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v5 09/11] Test read_early_config()
References: <cover.1488897111.git.johannes.schindelin@gmx.de>
        <cover.1489098170.git.johannes.schindelin@gmx.de>
        <72b36d27cefc0060f170b33f19cf504bb0338c1c.1489098170.git.johannes.schindelin@gmx.de>
        <xmqqa88tymys.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703131819160.3767@virtualbox>
Date:   Mon, 13 Mar 2017 10:32:46 -0700
In-Reply-To: <alpine.DEB.2.20.1703131819160.3767@virtualbox> (Johannes
        Schindelin's message of "Mon, 13 Mar 2017 18:19:57 +0100 (CET)")
Message-ID: <xmqq37eht741.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12E7D342-0813-11E7-9A1A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > Subject: Re: [PATCH v5 09/11] Test read_early_config()
>> 
>> Let's retitle it to
>> 
>> 	t1309: test read_early_config()
>
> I specifically avoided that, as it would sound as if I modified t1309. But
> I *added* that file.

Then please stop specifically avoiding that style.

For a reader of the shortlog, a title that identifies the area (and
in t/ scripts, it is common to give the test file name as the
identification) it touches gives useful information, i.e. "Thanks to
this commit, we have a test for read-early-config in t1309 now".
Doing s/in t1309 now/somewhere now/ makes the title less useful.

Thanks.
