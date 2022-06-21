Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5649C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 16:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352240AbiFUQ4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352234AbiFUQz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 12:55:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE3C1C92E
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 09:55:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E042C199093;
        Tue, 21 Jun 2022 12:55:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ph0SA/W/OJqf
        LBposLB4P2iCkh12lpWaXcZEqKiY8ss=; b=WrqX9Xg7U9C+ydjZ6c1t90EjvXfZ
        OzSECB2eDotvp38KukMOZW9hr0Kmi1v4Cyn3ieE3EC7JV1r/w3Pjb3GgzHYNVdRx
        MHMP7cKoDJu3Es9534GmPDPE9iHwpj5p6SQUr1BSnrG1DSW8b6ZQCM8zol/+K8mO
        bcDhx+7zfWtZAcA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8DD0199092;
        Tue, 21 Jun 2022 12:55:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E57719908B;
        Tue, 21 Jun 2022 12:55:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Subject: Re: [PATCH 1/2] combine-diff: abort if --ignore-matching-lines is
 given
References: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
        <patch-1.1-f7fd645468c-20220523T182954Z-avarab@gmail.com>
        <xmqqleusqaff.fsf@gitster.g>
        <220524.86leurw3my.gmgdl@evledraar.gmail.com>
        <xmqqmtf6hgae.fsf@gitster.g>
        <220524.86v8tuvfl1.gmgdl@evledraar.gmail.com>
        <49bcadd1-7dc2-d5ee-36a5-59456450aeca@web.de>
        <xmqqedzijago.fsf@gitster.g>
        <95d7609e-4cb5-c87e-0120-144f1f094241@web.de>
Date:   Tue, 21 Jun 2022 09:55:52 -0700
In-Reply-To: <95d7609e-4cb5-c87e-0120-144f1f094241@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 21 Jun 2022 17:58:50 +0200")
Message-ID: <xmqqsfnygdlz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 03052A42-F183-11EC-9823-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> +	if (opt->ignore_regex_nr)
>>> +		die("combined diff and '%s' cannot be used together",
>>> +		    "--ignore-matching-lines");
>>
>> "X cannot be used together _with_ Y" perhaps?
>
> Not sure, but that type of message was recently unified (most common
> case: "options '%s' and '%s' cannot be used together") and "with" is
> only used in an untranslated BUG:

Ah, sorry, I completely misread the original as "combined diff
cannot be used together with ignore-matching-lines".

Sorry for the noise.
