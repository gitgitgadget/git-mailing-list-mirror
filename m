Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51F4720966
	for <e@80x24.org>; Thu, 30 Mar 2017 17:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933424AbdC3R0U (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 13:26:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60782 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933150AbdC3R0T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 13:26:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A58CD6BAC8;
        Thu, 30 Mar 2017 13:26:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OrcyWuz3v1RdRE6OLpz/P+96Bno=; b=N3Pesi
        IitUOvlzXkP12ia2jARf/acDbsuU1Ywpv7MncozYoSXyrgWUCVen9xuElgUR4aiA
        VKuke+O3rMrB7Ez6tyD1I9i0eOvnBEKNbWFJ+n4VcoEa7GWxL70lmi66MnjF+AQ3
        u3b7YndXmYhS684qcGwPpE9g10WD09ei5EtUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AbRiRNvK8sU7dTRlZS9HzXWj6/nkhnaY
        VODaLltBQXVddfJU5YzUSuuyvOIFs0tyb45opbGZCmmDrUI8BPqydxgJMd3aezQ7
        s1gL+UrjmIFvybXIRk/ayRJLCvowNrKKhKhaRCL9S0lUKrL9ce3U/YeOqXneY65/
        xwspksZfxT4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C3A46BAC6;
        Thu, 30 Mar 2017 13:26:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1050D6BAC4;
        Thu, 30 Mar 2017 13:26:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org,
        sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v4 2/5] dir_iterator: iterate over dir after its contents
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
        <1490747533-89143-3-git-send-email-bnmvco@gmail.com>
        <7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu>
        <xmqqk278av4x.fsf@gitster.mtv.corp.google.com>
        <e412ef09-276b-92df-d2c0-0bf2f80238d2@alum.mit.edu>
        <xmqqinmr70uc.fsf@gitster.mtv.corp.google.com>
        <1751d788-d1f1-1c97-b33b-f53dab78ef86@alum.mit.edu>
Date:   Thu, 30 Mar 2017 10:26:15 -0700
In-Reply-To: <1751d788-d1f1-1c97-b33b-f53dab78ef86@alum.mit.edu> (Michael
        Haggerty's message of "Thu, 30 Mar 2017 08:39:28 +0200")
Message-ID: <xmqqmvc265hk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB5B6CB2-156D-11E7-9D7F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I don't think any of this needs to be implemented now, but maybe keep it
> in mind if/when `dir_iterator` gets more users.

OK.  One thing that was missing in your list was the opposite of "do
not show directories", i.e. "show only directories".  That should
also be easy to do (but we need to figure out a way to encode it in
the flag somehow) if it turns out to be useful later.


