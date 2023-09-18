Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA2BCD13D2
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 16:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjIRQEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjIRQEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 12:04:09 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2A130FC
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:02:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B22E826848;
        Mon, 18 Sep 2023 11:58:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=EBdPu/WygXWQnFENg4ss1h6XRAC1ymDHH7ib99
        9iqx8=; b=fGdWLpNUdZi+u/uCUSLj3vVwcJyyBAN/xBkYVtobqTEnPTZGDY3zFe
        8g1V/jV6w8o64jiTBAJeqE/IZCRVI+Qqz/0uBnD9Qt2vVn5s6aqAdPdSpl1JRxMJ
        1URZ10onkuihkBw+QdPkCThYt0gJZngWTN8MurHnLBFViESgDcDoA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A955A26847;
        Mon, 18 Sep 2023 11:58:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 364E026846;
        Mon, 18 Sep 2023 11:58:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Mark Levedahl <mlevedahl@gmail.com>, me@yadavpratyush.com,
        git@vger.kernel.org
Subject: Re: [PATCH] git-gui - use git-hook, honor core.hooksPath
In-Reply-To: <a6998d64-32a7-80b6-f75c-d983ac6130dd@gmx.de> (Johannes
        Schindelin's message of "Mon, 18 Sep 2023 17:27:44 +0200 (CEST)")
References: <fa876f80-02dc-2c04-0db3-bf3f6269b427@gmail.com>
        <20230917192431.101775-1-mlevedahl@gmail.com>
        <a6998d64-32a7-80b6-f75c-d983ac6130dd@gmx.de>
Date:   Mon, 18 Sep 2023 08:58:02 -0700
Message-ID: <xmqqpm2fmq2d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26B31F98-563C-11EE-8237-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +	set cmd [concat git hook run --ignore-missing $hook_name -- $args 2>@1]
>> +	return [_open_stdout_stderr $cmd]
>
> This looks so much nicer than the original code.
>
> Thank you,
> Johannes

Yup, looking good.
