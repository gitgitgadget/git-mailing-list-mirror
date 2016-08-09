Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77EA1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 15:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbcHIPuT (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 11:50:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752363AbcHIPuS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 11:50:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F07AC349C5;
	Tue,  9 Aug 2016 11:50:16 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xYMe88Q/DIZECmljb6nZGrDlONU=; b=puZhCh
	Fk5C243NtD+LON7FZwXrPefosjTjFFNWi6EgHDw0WEiPrTI/KNXNw/z6HfMzzA3v
	a7JIMdeduEEvBoo+/ryKlXs0ea8bXCAD3RJqi9Fz/FiEcwITLkZRotjWUFv76kiq
	L8XCGoP/c4h3NITswznm3ItxoRt4o5ootUbAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KVYwBPIwkPgFREXdSuV5fKO8U1Ex9Kct
	HhjJeDKx26PAc1Kdl3RbsEmksOfsQZ6rax7FOcdUC2zX8n+NC6E27cklj1Dn7F0H
	KzwxJYhFp0SGnhCPIyQlz0NbfKVU2n+yYwiBmwnfHgJgGWdKsLfalvzTrC0VSVWV
	8AjUphU7qf8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E5FFC349C4;
	Tue,  9 Aug 2016 11:50:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 51163349C3;
	Tue,  9 Aug 2016 11:50:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3 1/9] t7408: modernize style
References: <20160809040811.21408-1-sbeller@google.com>
	<20160809040811.21408-2-sbeller@google.com>
	<CAPig+cRnDVMBZzKOOS-fW+hNaCHhYRVLM+d_akZcB4H5iyqfKA@mail.gmail.com>
Date:	Tue, 09 Aug 2016 08:50:14 -0700
In-Reply-To: <CAPig+cRnDVMBZzKOOS-fW+hNaCHhYRVLM+d_akZcB4H5iyqfKA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 9 Aug 2016 02:59:18 -0400")
Message-ID: <xmqqfuqec56x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7716A66-5E48-11E6-9652-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Aug 9, 2016 at 12:08 AM, Stefan Beller <sbeller@google.com> wrote:
>> t7408: modernize style
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
>> @@ -8,74 +8,76 @@ test_description='test clone --reference'
>> +test_expect_success 'that reference gets used with add' '
>> +       (
>> +               cd super/sub &&
>> +               echo "0 objects, 0 kilobytes" > expected &&
>
> Since you're modernizing the style, perhaps drop the space after '>'
> here and elsewhere.
>
>> +               git count-objects > current &&
>> +               diff expected current
>
> Modern practice is to call this 'actual' rather than 'current', but
> perhaps that's outside the scope of this patch(?).

Not just that, modern practice is to use "test_cmp" not "diff".
