Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515DBCD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 17:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjIRRx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 13:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRRxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 13:53:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBAAFA
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 10:53:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84ED127084;
        Mon, 18 Sep 2023 13:53:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hV3ik9cZlRpy
        dscpfpg2cqb4OgAGsGNWqJyjmXvHWvM=; b=HgeYdE0iNypuuilZKP2M14W8SdEb
        32Z3M89YjF/ObiiZ923yFA3yFt3yBLXfSOK44YBbNtfeCrO/wI/sFaRpVt6xSaS4
        OKeI9/2wSbrg246JBI/5d1xynNI9xGz805OGQy4WgKzdfFjzY0tBROY1zgFohk7C
        /pX55c1XZjYFV4w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D56F27083;
        Mon, 18 Sep 2023 13:53:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F223027082;
        Mon, 18 Sep 2023 13:53:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        me@yadavpratyush.com, git@vger.kernel.org
Subject: Re: [PATCH] git-gui - use git-hook, honor core.hooksPath
In-Reply-To: <a4765b59-1953-695b-4f5e-686bef0a3a50@gmail.com> (Mark Levedahl's
        message of "Mon, 18 Sep 2023 12:25:02 -0400")
References: <fa876f80-02dc-2c04-0db3-bf3f6269b427@gmail.com>
        <20230917192431.101775-1-mlevedahl@gmail.com>
        <a6998d64-32a7-80b6-f75c-d983ac6130dd@gmx.de>
        <xmqqpm2fmq2d.fsf@gitster.g>
        <a4765b59-1953-695b-4f5e-686bef0a3a50@gmail.com>
Date:   Mon, 18 Sep 2023 10:53:14 -0700
Message-ID: <xmqqa5tjl65x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3E6FCBEE-564C-11EE-A905-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> On 9/18/23 11:58, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>>> +	set cmd [concat git hook run --ignore-missing $hook_name -- $args =
2>@1]
>>>> +	return [_open_stdout_stderr $cmd]
>>> This looks so much nicer than the original code.
>>>
>>> Thank you,
>>> Johannes
>> Yup, looking good.
>
> Thanks. BTW, my commit message at "Furthermore, since v2.36 git
> exposes its hook exection machinery via" needs
>
> =C2=A0=C2=A0=C2=A0 s/exection/execution/
>
> Should I resend?

Nah, I'll just fix it up locally before merging.
