Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1117BC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 22:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbiFBWJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 18:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbiFBWJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 18:09:43 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D634643
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 15:09:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54FEA1281BF;
        Thu,  2 Jun 2022 18:09:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=otgaiyp9vJrdaLFQ1RfCyZC9hUGdJQCqc+kRsN
        3fqZs=; b=tKyV83eYzmwdqTctVk9eGHWo7bqihNNduXT6x9185ryq8bcn9sVfSJ
        qLWTXGIrMK03lpKhz5Cul7YYWRhXGzn2djjlnllEP0eeSSQ6z924yAwG6GO5LM2h
        7upPYQ/3Hc34iW0HiZetqRM3wkrGUnqWpgJC8hk4ZsbaoixtJy710=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B9EA1281BE;
        Thu,  2 Jun 2022 18:09:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CE0C1281BD;
        Thu,  2 Jun 2022 18:09:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jason Yundt <jason@jasonyundt.email>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] gitweb: switch to an XHTML5 DOCTYPE
References: <20220601012647.1439480-1-jason@jasonyundt.email>
        <20220602114305.5915-1-jason@jasonyundt.email>
        <xmqqv8tinblc.fsf@gitster.g>
        <YpkwD1op18MY/qBa@camp.crustytoothpaste.net>
Date:   Thu, 02 Jun 2022 15:09:39 -0700
In-Reply-To: <YpkwD1op18MY/qBa@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Thu, 2 Jun 2022 21:47:59 +0000")
Message-ID: <xmqqmteuiuos.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B304BC90-E2C0-11EC-A888-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> > Subject: Re: [PATCH v2] gitweb: switch to an XHTML5 DOCTYPE
>> ...
>> > 2. mentions HTML5 like Bagas suggested.
>> 
>> So, is it XHTML5, or HTML5, we want to see on the title?
>
> It's XHTML 5.  Technically, it's the XML syntax of HTML 5, so I don't
> think we care much about the nit here.

I too don't care either way very much.

I just noticed the discrepancy between the title and the body, but
the mention of HTML5 is after the three-dash lines so nobody gets
hurt anyway ;-)

> We _could_ make this check for beginning of file, the XML declaration,
> and then the specified lines (e.g., with head(1)), but I don't really
> think that's necessary. We should be fine here for now, and if we decide
> we need that in the future, we can add it.  I'd be happy with this as it
> stands.

Yup, thanks for sanity checking.

Will queue.
