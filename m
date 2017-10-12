Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7221FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 03:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbdJLD3T (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 23:29:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65331 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751953AbdJLD0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 23:26:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7EB599C4B;
        Wed, 11 Oct 2017 23:26:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pZDV6jHPuU2Y/6Izxk/FmzUs32Y=; b=sWQkRM
        Bs/Lk6A4pLLJz9ibMDDro56EgAv/hJUM5pb8hFC5kNhSUSdTOa+h1buFrvoRVJ+0
        tRQL83nNPcXgOMHtlEvSCTCrO1zU+bkcBXUjw1bb+Hr2Bf0hrtOgCHHffbtIVoCH
        IF9bwFGTQdrfiCZWyCSQi2TcdC9Y5YLa9RehQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EWiX9YUgkKd8PK4hNB4+t56NBkG8OHNk
        po2KpvjbEGE6bhbPcFWYOR9uJz45wZU99rN1RsEK+XLyh/9ZfRNSY4+RTs8ilpeM
        dEGCLXwysCqM8/to6nddaVlg9kXC7mV4w2v/HMYNJ+8jR++IgzvAoxjriQ7zQeeI
        UtQXpcscM24=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFA9199C4A;
        Wed, 11 Oct 2017 23:26:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2850599C49;
        Wed, 11 Oct 2017 23:26:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "Thais D. Braz" <thais.dinizbraz@gmail.com>,
        marius.paliga@gmail.com, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH][Outreachy] New git config variable to specify string that will be automatically passed as --push-option
References: <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
        <20171011202505.10113-1-thais.dinizbraz@gmail.com>
        <20171011202505.10113-2-thais.dinizbraz@gmail.com>
        <xmqqa80x2mb4.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD3VnVod7SPTM11XG=vHBYD4EwA+xZB563iwpL1Ue4pPnA@mail.gmail.com>
Date:   Thu, 12 Oct 2017 12:26:22 +0900
In-Reply-To: <CAP8UFD3VnVod7SPTM11XG=vHBYD4EwA+xZB563iwpL1Ue4pPnA@mail.gmail.com>
        (Christian Couder's message of "Thu, 12 Oct 2017 04:41:49 +0200")
Message-ID: <xmqqmv4x11y9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FD0ECE2-AEFD-11E7-BD8C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> Can somebody explain what is going on?
>>
>> I am guessing that Thais and marius are different people (judging by
>> the fact that one CC's a message to the other).  Are you two
>> collaborating on this change, or something?
>
> I guess that Thais decided to work on this, because we ask Outreachy
> applicants to search for #leftoverbits mentions in the mailing list
> archive to find small tasks they could work on.
>
> In this case it looks like Marius sent a patch a few hours before
> Thais also sent one.

... after seeing Marius's already working on it, I think.

> Thais, I am sorry, but as Marius sent a patch first, I think it is
> better if you search for another different small task to work on.

In general, I do not mind seeing people working together well, and
it is one of the more important skills necessary in the open source
community.  I however tend to agree with you that this is a bit too
small a topic for multiple people to be working on.

> Also please keep Peff and me in cc.

Yup, that is always a good idea.

