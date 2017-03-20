Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BEA720958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756748AbdCTSCS (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:02:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65261 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756207AbdCTSCP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:02:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 707047ADAD;
        Mon, 20 Mar 2017 14:01:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Shwshpkhz+yh
        bj9QEHykcEM2WdA=; b=Ig37toe2k4+9SG4PBRim6F1xoj9rYkO5xONzk/P+5ciW
        ryHkEeqOBW1UZhiSHeag4yDrGxdFohuAM3kn2SOP4lrBTpxrBblbz9jAtdInJDU8
        rMbwT8Y85F+J44cwAe4V4aDCe7BRVXQT9m6cE0Eny4QpRQqH6aUv0G/4HPIflWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SQWvoe
        ZtaFFnXaOTw2TaRdnZYU3dqX0NvsbUqbnCOBsqxppEsw1ZDw4kLASDwVTjhQmAXe
        FA6WFoVJFowRSmJW+r2Zq1r6vrHd3M5k1UrDQMgzs8drbn2jErc+/ClbLYn/5hfT
        Yp1EUDppqNlvzjNCAaZodn0/19QLnbPzIP5tA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67ACE7ADAC;
        Mon, 20 Mar 2017 14:01:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA7887ADAB;
        Mon, 20 Mar 2017 14:01:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johan Herland <johan@herland.net>,
        Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] push: Re-include "push.default=tracking" in the documentation
References: <xmqqint5l4i9.fsf@gitster.mtv.corp.google.com>
        <20170319143636.23810-1-avarab@gmail.com>
Date:   Mon, 20 Mar 2017 11:01:26 -0700
In-Reply-To: <20170319143636.23810-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 19 Mar 2017 14:36:36 +0000")
Message-ID: <xmqqfui7x1xl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D56C1D6-0D97-11E7-8CB3-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index eccc012672..988659e16c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2459,6 +2459,8 @@ push.default::
>    pushing to the same repository you would normally pull from
>    (i.e. central workflow).
> =20
> +* `tracking` - This is a deprecated synonym for `upstream`.
> +
>  * `simple` - in centralized workflow, work like `upstream` with an
>    added safety to refuse to push if the upstream branch's name is
>    different from the local one.

Thanks for following through ;-)  Will queue.

