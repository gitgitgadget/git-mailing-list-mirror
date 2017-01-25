Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3CD21F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 20:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbdAYUfU (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 15:35:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60753 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752091AbdAYUfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 15:35:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAC9263987;
        Wed, 25 Jan 2017 15:35:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PmNXxP2N6kKEbkEOj3fiNP63p38=; b=ouqKMW
        TcG3zxfPpamAc8MizoXjIbxUCHEkPKAS6z2gDRYB0VLbBxJjlb9fOejyfEwMF/pv
        vjI97eTKrrWEExexkba9clR6q6mDl3z9q88ioSmAVukOqGsFxGCMOBnMfCo8xW1L
        OkMQeG3Hd+f9uLi8+eFf0woNAQfDKDYHwmkgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=afB4e5+sRw5gSpS6RDIjxtN6S4VO7kqH
        wjtDuwKpEDvvqTKpL75pJvgq0IL7cl9323bWVx6TE9qEsvUrmWYLAJGsmddVdI2I
        byp5sjMWkZg0MhKlMcb0yJwmyd+LXO4UHzAICUFr0WUYr6pL/rQpCtv2TH9fQErZ
        ewzNgZfbA/E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A11BE63986;
        Wed, 25 Jan 2017 15:35:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD6B363985;
        Wed, 25 Jan 2017 15:35:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZKDyfP1SPsxAf8oMSU3763QiogLpUzFZHy+OTQQdJP6A@mail.gmail.com>
Date:   Wed, 25 Jan 2017 12:35:16 -0800
In-Reply-To: <CAGZ79kZKDyfP1SPsxAf8oMSU3763QiogLpUzFZHy+OTQQdJP6A@mail.gmail.com>
        (Stefan Beller's message of "Wed, 25 Jan 2017 10:38:32 -0800")
Message-ID: <xmqqwpdianej.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8978CF0-E33D-11E6-B537-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Jan 23, 2017 at 4:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * sb/unpack-trees-super-prefix (2017-01-12) 5 commits
>>  - SQUASH
>>  - unpack-trees: support super-prefix option
>>  - t1001: modernize style
>>  - t1000: modernize style
>>  - read-tree: use OPT_BOOL instead of OPT_SET_INT
>>
>>  "git read-tree" and its underlying unpack_trees() machinery learned
>>  to report problematic paths prefixed with the --super-prefix option.
>>
>>  Expecting a reroll.
>>  The first three are in good shape.  The last one needs a better
>>  explanation and possibly an update to its test.
>>  cf. <CAGZ79kaHDnVLQr8WLoaD5KKs7EqeW=KbkptF=iHpU5t054Xcdw@mail.gmail.com>
>>
>
> Please see
> https://public-inbox.org/git/20170118010520.8804-1-sbeller@google.com/

Thanks, applied.  Let's move this forward.



