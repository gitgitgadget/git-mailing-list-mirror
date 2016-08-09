Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A77A1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 15:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbcHIPvP (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 11:51:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932245AbcHIPvN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 11:51:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E522030ED4;
	Tue,  9 Aug 2016 11:51:11 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r7R0t/Aw1eL/C1OFHtV0K2O7Moc=; b=bBcIPv
	L9l1MC0RwwZkY/2nT/yzW815IASKg+3Vl8l5te/40PnhHfqj8Rlqi9lDcPO4GzKO
	oPA0704x9/TedBg4wYaVo4wscd+ZhdgzPbzi5H8tsfh72CwCqRcx6Nz+GMUuTOCb
	dFxFecnRGgERK0oyhmN0N2JvTp/kw7CeK52ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ABV2or9J/ZPn86O9Ynn5LlyXSxGrEFB4
	xlDNBdVwNfT+ch055o7mgzuxARRwUU+ISaL+h5XsSJH/7plrhY+qsuRcbnumhO4Z
	EzJooTGjUfvYFpcWcXh7Ajv1xofTQGECmj8y3t/uuQkHusodsDx1HG+FEOoictWk
	Gda/1EDniYg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DDF9330ED3;
	Tue,  9 Aug 2016 11:51:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51E3230ED2;
	Tue,  9 Aug 2016 11:51:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3 1/9] t7408: modernize style
References: <20160809040811.21408-1-sbeller@google.com>
	<20160809040811.21408-2-sbeller@google.com>
	<CAPig+cRnDVMBZzKOOS-fW+hNaCHhYRVLM+d_akZcB4H5iyqfKA@mail.gmail.com>
	<xmqqfuqec56x.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 09 Aug 2016 08:51:09 -0700
In-Reply-To: <xmqqfuqec56x.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 09 Aug 2016 08:50:14 -0700")
Message-ID: <xmqqbn12c55e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 184456AE-5E49-11E6-925E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, Aug 9, 2016 at 12:08 AM, Stefan Beller <sbeller@google.com> wrote:
>>> t7408: modernize style
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
>>> @@ -8,74 +8,76 @@ test_description='test clone --reference'
>>> +test_expect_success 'that reference gets used with add' '
>>> +       (
>>> +               cd super/sub &&
>>> +               echo "0 objects, 0 kilobytes" > expected &&
>>
>> Since you're modernizing the style, perhaps drop the space after '>'
>> here and elsewhere.
>>
>>> +               git count-objects > current &&
>>> +               diff expected current
>>
>> Modern practice is to call this 'actual' rather than 'current', but
>> perhaps that's outside the scope of this patch(?).
>
> Not just that, modern practice is to use "test_cmp" not "diff".

Sorry, hit the "send" too soon, before writing "But all of that
comes in the next step."

