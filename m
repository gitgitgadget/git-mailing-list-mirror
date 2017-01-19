Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D2120A17
	for <e@80x24.org>; Thu, 19 Jan 2017 18:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbdASSNY (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 13:13:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55586 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754093AbdASSNW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 13:13:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE2FE5E756;
        Thu, 19 Jan 2017 12:56:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xMTQVEKb1TeJ2ipeIf+cu6zPNDk=; b=w66iTd
        TcvKpZGCawVWERCUY56vCa7zEy4c4/xynke6lU5CBanoy29XssnQBxbBDt+TOMIK
        79DGuRD6uSZKHnpThkT4uGk6WrhoKkRXCDrq5G9/B/vcG5D+Im4M4njcZwZZXEIb
        uKHXjGHnXnWaFJTTImBz3zpmvmY3W+EuKHCO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fq4UqMVRU0bggFFIX7gnNOfmvhOiCFD/
        DafJNsNcUU+6JP3RfLDWDtSOjBP0+C7brZpTR4u76jjnYJsStT8cX+2AGb6sQmsy
        4+ZoCBbViQJjwQeHL3ORp2ryLul8/llPWqpsWcuqBp0+cl5OfZsqzIQmovpf93uE
        fD6YkjAD/k8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3D955E755;
        Thu, 19 Jan 2017 12:56:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 253245E752;
        Thu, 19 Jan 2017 12:56:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v5 3/3] Retire the scripted difftool
References: <cover.1483373635.git.johannes.schindelin@gmx.de>
        <cover.1484668473.git.johannes.schindelin@gmx.de>
        <8238bba389c031b091a37396fed43cac94d944e7.1484668473.git.johannes.schindelin@gmx.de>
        <xmqqk29tcqb8.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701181332230.3469@virtualbox>
        <xmqqbmv49o3s.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701191730040.3469@virtualbox>
Date:   Thu, 19 Jan 2017 09:56:36 -0800
In-Reply-To: <alpine.DEB.2.20.1701191730040.3469@virtualbox> (Johannes
        Schindelin's message of "Thu, 19 Jan 2017 17:30:48 +0100 (CET)")
Message-ID: <xmqqlgu72asr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FE5C6CC-DE70-11E6-A532-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Ok, I was mostly reacting to 2/3 while I am reading it:
>> 
>>     The reason: this new, experimental, builtin difftool will be shipped as
>>     part of Git for Windows v2.11.0, to allow for easier large-scale
>>     testing, but of course as an opt-in feature.
>> 
>> as there is no longer an opportunity to participate in this opt-in
>> testing, unless 3/3 is special cased and delayed.
>
> Yep, as Git for Windows v2.11.0 is yesteryear's news, it was probably
> obvious to you that I simply failed to spot and fix that oversight.

OK, if you want to tweak log message of either 2/3 or 3/3 to
correct, there is still time, as they are still outside 'next'.  

I am hoping we can merge it and others to 'next' by the end of the
week, though.


