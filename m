Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5881F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 02:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbeKNMcL (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 07:32:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59291 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeKNMcL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 07:32:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C32DF116C5F;
        Tue, 13 Nov 2018 21:31:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3cTZg1gARRv9Uq3UpT4kte7LjPM=; b=F1evw9
        wk8kPKDaRjzRhNQnG7r4VdNvAJQVtkCPXd/RnR0CfKsBVL160BH9RiT1Zsrocpsj
        xpdwK/dAHa970rKWkyU2XO+9G/tgiSBGJcMZj2Ybce7tTWuTi2UlBqpfSFu+5rGR
        VHbqeTynWFRXpVwDKhM4F0/5NiGdpkS3j+V5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R3K8HcxnZqpF+CdNmbzJUITJWJLH4inr
        +eNwkyiYznzvODdBIJvkND7eSD4YewATiO9SIUw3F8LCH1yQIVw6VFSRjyM+5yG7
        GfA0eFr/7wO5xHzVBTUzEGT3byomzgoFrI9d4bJvcAyi5DkIwCkp8RBI1BULIvB2
        WikKFt/unws=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC5F3116C5E;
        Tue, 13 Nov 2018 21:31:02 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A81F116C5D;
        Tue, 13 Nov 2018 21:31:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Re* [PATCH v3 1/1] protocol: advertise multiple supported versions
References: <cover.1539305180.git.steadmon@google.com>
        <cover.1542059029.git.steadmon@google.com>
        <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
        <CAGZ79kaPjw3UbYY=XL0gyKp2VxghwaUOJJoDhiO5sQpT8OWerQ@mail.gmail.com>
        <xmqqy39xwtfs.fsf_-_@gitster-ct.c.googlers.com>
        <CAGZ79kYv_a8-6dppo3XcNb8wc0RuTSJeOj71Q+3FmEZguBBUiA@mail.gmail.com>
Date:   Wed, 14 Nov 2018 11:31:00 +0900
In-Reply-To: <CAGZ79kYv_a8-6dppo3XcNb8wc0RuTSJeOj71Q+3FmEZguBBUiA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Nov 2018 11:21:55 -0800")
Message-ID: <xmqq5zx0s84b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5429181A-E7B5-11E8-96E1-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> "Nobody reads documentation any more, we have too much of it."

Maybe, but spelling it out and writing it down, you can point at it
(or hope that other people point at it without making a bad or incorrect
rephrase).

> I would have hoped to have a .cocci patch in the bad style category,
> i.e. disallowing the _() function inside the context of BUG().
>
> That said, I like the patch below. Thanks for writing it.

That was a mere weather-baloon, and too early to thank about.
Hopefully people can pick nits and come to a final version that can
be applied.

I have a few things in it that I think may be debatable.  I am not
sure if we should talk about being careful not to send localized
strings over the wire in that comment, for example.


