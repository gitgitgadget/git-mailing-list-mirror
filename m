Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B41F1FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 00:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756745AbdJRADh (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 20:03:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62142 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755059AbdJRADg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 20:03:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD9289D970;
        Tue, 17 Oct 2017 20:03:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7UBN60PUAtUCKYzrZH3pXzkQLlk=; b=DBQHjy
        cen69ucd+K2HGqJqcYNCHoyoIAULWmb5LHmM/3+HCPer8W5X2+MoKWqiceHkQWEI
        vRHJKNnWpfllz/q7oNSQB1ZJrGEKHqiMyoSxMA51ormV0A0bZSFtdBqODrlfNCPU
        Gc3q7egBtFoYDM4cBDDu0VNblp7hX76t+Bz2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KOOC5ilfODlaYpO6ue6okVbu1OUMIuRa
        QD/+7uHTZt4Es78Lr0ZNlbn7gxfpZkWz/dh0/ARkQySUilevi1OJCCv9HSb63pP/
        yMlmQjVTi+Jy1ijqx8grVgLj8PE+q8/0Z1vAiJP0uB5tLF7ZD4Xsb11PPDBMmwrZ
        wJcVDfAIuDo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C54A29D96F;
        Tue, 17 Oct 2017 20:03:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A7E69D96E;
        Tue, 17 Oct 2017 20:03:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] submodule: simplify decision tree whether to or not to fetch
References: <20171016135623.GA12756@book.hvoigt.net>
        <20171016135905.GD12756@book.hvoigt.net>
        <CAGZ79kaOqynvWsWxReKT=c33+EA2FSAbBicY7vsHuvAxOnAwZA@mail.gmail.com>
Date:   Wed, 18 Oct 2017 09:03:34 +0900
In-Reply-To: <CAGZ79kaOqynvWsWxReKT=c33+EA2FSAbBicY7vsHuvAxOnAwZA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 17 Oct 2017 11:22:20 -0700")
Message-ID: <xmqqbml5mieh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C91600C8-B397-11E7-9E14-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Oct 16, 2017 at 6:59 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> To make extending this logic later easier.
>>
>> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
>
> Thanks for this readability fix!
>
> Stefan

Thanks, both.
