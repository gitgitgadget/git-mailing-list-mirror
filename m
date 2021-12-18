Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D07CC433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 01:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhLRBJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 20:09:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59431 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhLRBJF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 20:09:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A3F8150A8C;
        Fri, 17 Dec 2021 20:09:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+CCz5PSnqunYoexYWidD0zrJjAAnBC6Ek0Se6h
        BLge0=; b=PpXgZoeKh9IoCq4rdH5MVTQq6RQtmML9uMeifFLLC5sZpYijWej5Of
        xo2qKqLoGEG2jgFcmcYjM2bza6iNo25EdG2XiVUyanChUSZgK7IbsQDU2OdyYPBO
        u9xWW5gkHkwXEhJjweIojVWJ+X3GeC99y2VUsGLlI2H0pZ3zLVRLo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 73207150A8B;
        Fri, 17 Dec 2021 20:09:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CDE42150A89;
        Fri, 17 Dec 2021 20:09:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Florian Mickler <florian@mickler.org>
Cc:     git@vger.kernel.org, jqassar@gmail.com
Subject: Re: passing CURLOPT_CERTTYPE to libcurl
References: <20211218010621.2fdc2b3c@monster.mickler.org>
Date:   Fri, 17 Dec 2021 17:08:59 -0800
In-Reply-To: <20211218010621.2fdc2b3c@monster.mickler.org> (Florian Mickler's
        message of "Sat, 18 Dec 2021 01:06:21 +0100")
Message-ID: <xmqq7dc2zplg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1633E6F6-5F9F-11EC-B0E9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Mickler <florian@mickler.org> writes:

> Is there a specific reason, that patch wasn't merged? It would allow
> for non-pem ssl certificates to be loaded also (without pkcs11 at all). 
>
> I realize, that the underlying systems could and should set up
> everything automagically as soon as i point them to the certificate that
> i want to use. But not opening up these CURL Settings from git seems
> kind of silly given that today's systems still seem kinda borked and do
> not do that.  What harm comes from these two tuning knobs being exposed?
>
> Best regards,
> Flo
>
>
> [1] https://marc.info/?l=git&m=136675822032549&w=2

Almost always, when some patch aims to achieve a worthy goal, and in
the initial discussion on the thread more experienced project
members agree it is a worthwhile thing to do, the only reason why
the feature proposed does not materialize in later versions of Git
is because the developer with the original itch did not follow it
through after getting review comments and saying something that
makes reviewers to expect an updated version of the patch.

I didn't follow your marc.info URL, but I am reasonably sure, if I
were involved in the discussion, that would be the likely reason.

