Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34AB91F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbdARVwO (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:52:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63012 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752886AbdARVwM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:52:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D1F26290D;
        Wed, 18 Jan 2017 15:58:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X0x16C6P7y8oeVNf3pZcUqreeBA=; b=Nedt1h
        D2LBsVoLROMg4iY2hN8Mi6BNd2OBuJOCFgQny6mwduB1oVSWa7OOmxb7glpzwPTM
        YORRIXMn0fTEaMk+Mbs6rasfnLPzdgBcNc7ha/6ZZQIlXuKYPPxtTSqWqAFA+LWw
        622jE5xkcaRYVlU92WfpRQ6Gw1ZVhMZqZ/2HI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XG3r1RwNXKA4EJL4EYsYQiHKya4G5vKI
        W+bSdvcea2X5ky2rsj8OBx6lJYpT8dt08h3uTDTsELG0UMmJIIOfwIx1jU/UJKvN
        SHD5SbtE5tGvEhS57kAybHWMDiX2ULkrXNItCKoom+DqxjZGjFhuQfSu/tMpXY9C
        TPXQYXwVxhg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 921AE6290C;
        Wed, 18 Jan 2017 15:58:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 006F46290A;
        Wed, 18 Jan 2017 15:58:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Jacob Keller" <jacob.e.keller@intel.com>, <git@vger.kernel.org>,
        "Johannes Sixt" <j6t@kdbg.org>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Jacob Keller" <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 1/5] doc: add documentation for OPT_STRING_LIST
References: <20170118000930.5431-1-jacob.e.keller@intel.com>
        <20170118000930.5431-2-jacob.e.keller@intel.com>
        <xmqq37gg9moc.fsf@gitster.mtv.corp.google.com>
        <254445096AD0412287CBB994E8BCA043@PhilipOakley>
Date:   Wed, 18 Jan 2017 12:58:24 -0800
In-Reply-To: <254445096AD0412287CBB994E8BCA043@PhilipOakley> (Philip Oakley's
        message of "Wed, 18 Jan 2017 20:08:09 -0000")
Message-ID: <xmqqr3403x1r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB113D18-DDC0-11E6-9B00-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>>> +`OPT_STRING_LIST(short, long, &list, arg_str, description)`::
>>> + Introduce an option with string argument.
>>> + The string argument is stored as an element in `&list` which must be a
>>> + struct string_list. Reset the list using `--no-option`.
>>> +
>>
>> I do not know if it is clear enough that 'option' in the last
>> sentence is a placeholder.  I then wondered if spelling it as
>> `--no-<long>` would make it a bit clearer, but that is ugly.
>
> Bikeshedding:: `--no-<option>` maybe, i.e. just surround the option
> word with the angle brackets to indicate it is to be replaced by the
> real option's name.

Yeah, I bikeshedded that myself, and rejected it because there is no
<option> mentioned anywhere in the enumeration header.
