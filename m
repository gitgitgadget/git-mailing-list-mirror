Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD22C0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 00:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjG1AZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 20:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjG1AZY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 20:25:24 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEF013D
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 17:25:23 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 069D93252B;
        Thu, 27 Jul 2023 20:25:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Byf9ptg05NLJWX+vmcmZXy+YjrqA/zb3vVk9sl
        9Mrsc=; b=J6Ks5fi5FtybKRq4hrPOhFOYvU9hsZXiJhhgyvqieuMlUxIIIVoreL
        yAMhwUbA34dcPMF4pWPE1PLDW0XUeleeDPJ1SoHW80gkAf5qrbgTxsTxbfBHV6nV
        6v1/LtO0RX0ezr7iAy4h2U7+5HdNNsZmjohyEgnxePHvJ/unXoKug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0068D3252A;
        Thu, 27 Jul 2023 20:25:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 874BD32529;
        Thu, 27 Jul 2023 20:25:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3] MyFirstContribution: refrain from self-iterating too
 much
References: <xmqq3583uyk0.fsf@gitster.g>
        <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
        <xmqqcz76tv6d.fsf@gitster.g> <xmqqzga9opdu.fsf@gitster.g>
        <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4>
        <xmqq8rbbbzp2.fsf_-_@gitster.g> <owlycz0deykz.fsf@fine.c.googlers.com>
Date:   Thu, 27 Jul 2023 17:25:18 -0700
In-Reply-To: <owlycz0deykz.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Thu, 27 Jul 2023 16:14:52 -0700")
Message-ID: <xmqq7cqkanm9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BADB4B8-2CDD-11EE-B47D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> I was in the process of writing a review but my comments were getting a
> bit long. So to save you the trouble of applying the suggested changes,
> I have a scissors patch version at the bottom with the changes applied
> (you may simply want to read that first).

Thanks.  I very much like your version over the one you are
responding to, except for one minor point.

>> +Keep in mind that people in the development community do not have to
>> +see your patch immediately after you wrote it.
>
> How about just
>
>      Please be considerate of the time needed by reviewers to examine
>      each new version of your patch.
>
> ?

Both give a useful piece of advice, but they are slightly different.

> Please be considerate of the time needed by reviewers to examine each
> new version of your patch. Rather than seeing the initial version right
> now (followed by several "oops, I like this version better than the
> previous one" patches over 2 days), reviewers would strongly prefer if a
> single polished version came instead, and that version with fewer
> mistakes were the only one they would need to review.

What I wanted to convey with "we do not need your initial patch
immediately" was that it is perfectly fine if the cost of producing
the version "reviewers would strongly prefer" is that it takes 2
more days before they see such a more polished version.  IOW, adding
something like
 
   , even if it took 2 more days before they see the version.

at the end of the above paragraph was what I wanted to say with
"hey, this is not a race. don't focus on sending immediately after
you wrote it. nobody is dying to see your patch immediately off the
press".

Thanks.
