Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50A2820437
	for <e@80x24.org>; Mon, 16 Oct 2017 12:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbdJPMqn (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 08:46:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53911 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751776AbdJPMqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 08:46:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DE04AA1AE;
        Mon, 16 Oct 2017 08:46:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fm6lRF4nc5/RnIzigK4Fe7bCkkc=; b=Q9XAyB
        SoPf+pPEsSuXCfUzgyEYsKLaRG143NIaSpaVDhZZcdQH8pw7DwZo7MI/4Cm45ckE
        ZhgAB2Fj9XjtUnGzISopYPZ0+cH+KABvBS+QF3w46OzsD0NImgo3MfjPCNiwgyit
        nRNp//neb5X7E6YRBBy1sJ0d4c7Uuy22B5hWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NTTbeZRZ+6dkudBUULh8fRh45nBvCHEu
        dp1MeO6bxLmNFzvUH4nN6vuXV4rVSZHIYQXHGnbxcHCIue7pkFmaMtLmPH+eVfJv
        fnEV9u+ff/e+nMzBBQFl9frsH7Uj6goj6BbbqwmlaWjep4RJzBs0sSFcr0Ql0kCf
        dlgDgoGbiik=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 246A6AA1AD;
        Mon, 16 Oct 2017 08:46:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97E77AA1AC;
        Mon, 16 Oct 2017 08:46:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Ralf Thielow" <ralf.thielow@gmail.com>, <git@vger.kernel.org>
Subject: Re: [PATCH v2] sequencer.c: fix and unify error messages in rearrange_squash()
References: <20171013175157.13634-1-ralf.thielow@gmail.com>
        <20171015170742.8395-1-ralf.thielow@gmail.com>
        <xmqqfuajuae8.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710161331290.40514@virtualbox>
        <17346CCF8DEF41E790C96248408E07D2@PhilipOakley>
Date:   Mon, 16 Oct 2017 21:46:39 +0900
In-Reply-To: <17346CCF8DEF41E790C96248408E07D2@PhilipOakley> (Philip Oakley's
        message of "Mon, 16 Oct 2017 13:36:35 +0100")
Message-ID: <xmqqwp3vqmz4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F08846C-B270-11E7-9E5D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> Hi, 'Truncate' is real English, but it is not that common in normal usage.
>
> My dictionary suggests that it means 'cut off at the tip' such as a
> truncated cone. However the thesaurus is far more relaxed about the
> common idioms that truncate at the tail such as: clip, crop, cut
> short, trim, abbreviate, curtail, etc.
>
> So perhaps "could not trim '%s'".

Truncate is fine, as there is already another instance that barfs
with "cannot truncate" upon an error from ftruncate(), and the patch
merely matches the two error messages.
