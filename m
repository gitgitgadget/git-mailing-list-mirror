Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830A4207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 17:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754910AbcILRCp (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 13:02:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57098 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751389AbcILRBk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 13:01:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A94983D133;
        Mon, 12 Sep 2016 13:01:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4me7GWY4Q0dw
        k0ij8CpAsssFvXg=; b=XhJOk+m6T1eYT8AqUjVdBtgqyUoW+UnfGqWktdSiIaem
        SK2bMbQuxDBlGsx8OOPZWOckiJARO5XkDOhcWU+6FESUtRD8XRYGPQWcGM5MCc9i
        MO7ruz9/7lPh1kIYRNZdZ/2Sc9OzzkIIjMpAOC/VxdchYYdutN5QKVBLKK1jMxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TPSB5B
        UoCVFmYbsTrLxWzbHFrPHYIYxVXYEatHwFmpI0uW9RIzP8ILOHj5ow/bKK6J04r+
        jKRgCmSjWFGMC6y0sBELsvBIUOCSXyweB+tsckCpxsPLceHTofS8rLXIX62z4xRR
        eJp2ni47HbmrltpS1xHO4009zFPyKOLykoWx8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1CD53D132;
        Mon, 12 Sep 2016 13:01:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 284423D130;
        Mon, 12 Sep 2016 13:01:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Subject: Re: [PATCH v2 07/14] i18n: merge-recursive: mark error messages for translation
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
        <1473679802-31381-7-git-send-email-vascomalmeida@sapo.pt>
        <882dcaf3-fd9b-0d83-2756-f3315dd6bb4e@gmail.com>
Date:   Mon, 12 Sep 2016 10:01:36 -0700
In-Reply-To: <882dcaf3-fd9b-0d83-2756-f3315dd6bb4e@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
        Avila"'s message of "Mon, 12 Sep 2016 13:47:43 +0200")
Message-ID: <xmqqeg4p3vdb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91A9A1B2-790A-11E6-8435-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:

> Le 12/09/2016 =C3=A0 13:29, Vasco Almeida a =C3=A9crit :
>> -			warning("Cannot handle more than %d bases. "
>> -				"Ignoring %s.",
>> +			warning(_("cannot handle more than %d bases. "
>> +				  "Ignoring %s."),
>>  				(int)ARRAY_SIZE(bases)-1, argv[i]);
>>  	}
>
> This one is also missing the plural form.

That is technically correct, but I do not think it matters, as we
won't be making bases[] array smaller than it currently is, so the
"more than %d bases" part of the message will always be in the
plural form and never be singular.

Thanks.

