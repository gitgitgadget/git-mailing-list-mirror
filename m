Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D6220985
	for <e@80x24.org>; Wed, 21 Sep 2016 15:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbcIUPp7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 11:45:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60760 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753670AbcIUPp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 11:45:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AB643E798;
        Wed, 21 Sep 2016 11:44:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eh2AptvrvJM5Sd6pkUcaS9Tk2mA=; b=lUjAWY
        Orrh++5reqYtsh+/mL+2FQnnC4ziv6daAcNcBrozq5UVYbmjdiUsQCp987nU2oN2
        UiiWBFzw+HkRdl4P66B01BEkZ+8szGHKb4oPWM2fDwK7rftjnmqEkwdUkx59lbFL
        QK9E4P9CrejiLj4FByqNljlCHfytK518vUvpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IfYeYjEF27YjXIKiKloWJTrwYk8uxZkZ
        f/+TeGW/66dp0MxgTUuuhxXs3DIbRrKIrhhapr7Vvby3fSpgvaq0YfJtFM7yOwoA
        1q/qx2nRBBj52XxGJC4EoJnGiBgCctt2HaWpOA93JE9LjwGMy2Q/pAk3BMTfIDzk
        n2h0jGiCajc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02F9C3E797;
        Wed, 21 Sep 2016 11:44:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DD233E796;
        Wed, 21 Sep 2016 11:44:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2016, #05; Mon, 19)
References: <xmqqd1jzcvs5.fsf@gitster.mtv.corp.google.com>
        <CACsJy8Dwe1n-YQfNMOyduLksNhAkAEPpBE3S0n==T-D1E0BneA@mail.gmail.com>
Date:   Wed, 21 Sep 2016 08:44:45 -0700
In-Reply-To: <CACsJy8Dwe1n-YQfNMOyduLksNhAkAEPpBE3S0n==T-D1E0BneA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 21 Sep 2016 16:11:00 +0700")
Message-ID: <xmqq4m59cl5e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53378868-8012-11E6-AF49-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Sep 20, 2016 at 6:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/checkout-disambiguation (2016-09-09) 4 commits
>>  - fixup! checkout.txt: document a common case that ignores ambiguation rules
>>  - checkout: fix ambiguity check in subdir
>>  - checkout.txt: document a common case that ignores ambiguation rules
>>  - checkout: add some spaces between code and comment
>>
>>  "git checkout <word>" does not follow the usual disambiguation
>>  rules when the <word> can be both a rev and a path, to allow
>>  checking out a branch 'foo' in a project that happens to have a
>>  file 'foo' in the working tree without having to disambiguate.
>>  This was poorly documented and the check was incorrect when the
>>  command was run from a subdirectory.
>>
>>  Waiting for an Ack for fixup!
>
> Oops, I didn't know (I have about 300 unread git mails in my inbox), Ack.

Thanks.
