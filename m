Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8F1CD4857
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 19:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjIYTBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjIYTBO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 15:01:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86EE93
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 12:01:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 668BF2203B;
        Mon, 25 Sep 2023 15:01:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=0FQCRdJuqJja4f5PaxAydPa+ZgDzCIPIjdBpLv
        32sOA=; b=Dgrpvx7GkX7SuNqZlABkUyXYKwG55ho3N3bUesJHQmvFX1ruOGJ7Q9
        HvolU3XZvovWw9FZgLrWbdwzS2NUK/ANbfj56z2iZYmAc2q28uvXTnSQqh74Tc8x
        l4JdSFydKhQwpZCcwBPnFDM3ZOX2Lsr0V+Z0t4vzj/lhSRPYJmM1Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DF5F2203A;
        Mon, 25 Sep 2023 15:01:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 62B6122039;
        Mon, 25 Sep 2023 15:01:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc:     "Oswald Buddenhagen" <oswald.buddenhagen@gmx.de>,
        "Jeff King" <peff@peff.net>, "Taylor Blau" <me@ttaylorr.com>,
        "Derrick Stolee" <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] format-patch: add --description-file option
In-Reply-To: <a1920050-bedc-49d4-840d-350b8fd3c003@app.fastmail.com>
        (Kristoffer Haugsbakk's message of "Sun, 24 Sep 2023 00:14:28 +0200")
References: <xmqq1qg9qmyq.fsf@gitster.g>
        <20230821170720.577820-1-oswald.buddenhagen@gmx.de>
        <a1920050-bedc-49d4-840d-350b8fd3c003@app.fastmail.com>
Date:   Mon, 25 Sep 2023 12:01:01 -0700
Message-ID: <xmqq7coet6vm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFB2228E-5BD5-11EE-B32A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Mon, Aug 21, 2023, at 19:07, Oswald Buddenhagen wrote:
>> This patch makes it possible to directly feed a branch description to
>> derive the cover letter from. The use case is formatting dynamically
>> created temporary commits which are not referenced anywhere.
>
> Thanks for implementing this. I've just written cover letter text in
> separate files and copied them into the generated files every time. (I
> don't use branch descriptions.) I've wanted some convenient way to feed
> these messages in, and if I end up writing a cover letter again I'll most
> probably be using this new option.

Thanks for a positive feedback.  The changes is already in 'master'
since the beginning of this month or so and its way to be part of
the next release, I believe.


