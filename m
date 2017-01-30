Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6F41FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 17:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdA3RH3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 12:07:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50210 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750765AbdA3RH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 12:07:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16DAC64224;
        Mon, 30 Jan 2017 12:07:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K8Jr/7N9GksDNtp2ASrHO2Gl8yw=; b=Yyw9Qm
        ATCqhfrv4ZXtSILr4lsEbxYkq5XXmQ1Y9sF8vnE5zTjaOArK6J6ibA+le9rJjU5N
        WhkHyZ4A5sKVSJ3D2CC0THEJbyI6Jntwu52VsgrVX/Lgw+pJPGaZDdz7ZCsy28Qi
        +w4Apl39yRm8hQ3eSX2QUosDufw+mlHDWZO1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l9eHyB+EAmqAw+PPavqBw+uKgviA3vZf
        TeO7TmUGL71UrQGuqDPu527tLTiiHMteLk/DoWKomnpGG7MuOLLMryEPhzqC6LA3
        gOdIx0FwUaZPEApGCkpltS+TDnZHp9qBlI3TDPkXRm3GILZIHhXEiYmrMapnmfAt
        iqVpE8Pa2kQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CF0664221;
        Mon, 30 Jan 2017 12:07:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A90464218;
        Mon, 30 Jan 2017 12:07:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>,
        George Vanburgh <george@vanburgh.me>
Subject: Re: [PATCH v2] git-p4: Fix git-p4.mapUser on Windows
References: <01020159c0e82598-e373cf0d-2bad-41bb-b455-6896ad183e22-000000@eu-west-1.amazonses.com>
        <01020159d4ea6861-fce45d61-8be5-49b0-ab4e-d161b9429795-000000@eu-west-1.amazonses.com>
        <xmqqa8ac1k7o.fsf@gitster.mtv.corp.google.com>
        <CAE5ih7-qug9n-Df2gA27iTjSQo67tAnPhTJWQhyvR_PP9h3rcg@mail.gmail.com>
Date:   Mon, 30 Jan 2017 09:07:25 -0800
In-Reply-To: <CAE5ih7-qug9n-Df2gA27iTjSQo67tAnPhTJWQhyvR_PP9h3rcg@mail.gmail.com>
        (Luke Diamand's message of "Sun, 29 Jan 2017 17:10:04 +0000")
Message-ID: <xmqqinowwk6q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 930098C8-E70E-11E6-ADAB-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> On 27 January 2017 at 17:33, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Luke, Lars, this version seems to be in line with the conclusion of
>> your earlier reviews, e.g.
>>
>> <CAE5ih7_+Vc9oqKdjo8h2vgZPup4pto9wd=sBb=W6hCs4tuW2Jg@mail.gmail.com>
>>
>> Even though it looks OK to my eyes, I'll wait for Acks or further
>> refinement suggestions from either of you two before acting on this
>> patch.
>
> It looks good to me. The tests all pass, and the change looks correct.

Thanks, queued.
