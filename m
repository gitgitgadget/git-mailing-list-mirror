Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F93C433E0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 04:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D0720724
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 04:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aEcFlhkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgGMEeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:34:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56403 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGMEeo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 00:34:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8D38E7374;
        Mon, 13 Jul 2020 00:34:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jmOw+fH2A6A73YuMY8p5ZibJ2DI=; b=aEcFlh
        kU/Q9mJilVEf4ONlF1UpWHLdqSyU4kbI7FF+9W7dXa/4Uf1gijy9ChpbhU/A58nI
        j7bsAlDZe4R1X/HkztQtHAHcXwT6ULVi2iJTXmxdm9nMW2p62wtWA0UTHdHFh1Mc
        n+PPnvCzecgOxWIlpphf/PzRy2ZjyfS22n1/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kzbHQDWLeEzbfKuaMBRUCaIoXVjNZspR
        jRP4VJvg4sAPQgM2JQz0nivN+5fin+oeaTfGzTAfJZVpl+ai5Krqg3VNR3lll+3u
        L1kF/Fkaa+nRUxmRNAOKmKH3uMyyty4cbdtYrankfl9FvlXmqlDINElBVzEruzB0
        SdFETqk5d6E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A195CE7372;
        Mon, 13 Jul 2020 00:34:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2C71E7371;
        Mon, 13 Jul 2020 00:34:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tobias Girstmair <tobi@isticktoit.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] gitweb: Replace <base> tag with full URLs (when using PATH_INFO)
References: <20200711203947.23520-1-tobi@isticktoit.net>
        <20200712183329.3358-1-tobi@isticktoit.net>
        <xmqqmu44phym.fsf@gitster.c.googlers.com>
        <20200712230508.GA1000433@isticktoit.net>
Date:   Sun, 12 Jul 2020 21:34:36 -0700
In-Reply-To: <20200712230508.GA1000433@isticktoit.net> (Tobias Girstmair's
        message of "Mon, 13 Jul 2020 01:05:08 +0200")
Message-ID: <xmqqa704owwz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 297A81F8-C4C2-11EA-B7F4-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tobias Girstmair <tobi@isticktoit.net> writes:

> On Sun, Jul 12, 2020 at 02:00:01PM -0700, Junio C Hamano wrote:
>>Sorry, but I am not sure the description is understandable to the
>>intended readers of this sentence.
>>
>>Where does this README.html come from?
>
> gitweb reads a README.html from each repository to display on the
> summary page. 'man 1 gitweb' has a paragraph on it under
> "Per-repository gitweb configuration".
>
>>Is it stored in the history of the repository as a blob, and sent to
>>the browser with a call to git_blob_plain() sub?  Wouldn't that
>
> No, it's a plain file in a bare repository, placed there either
> manually or by a post-update hook.

OK.

> ... If the user wanted to
> include an image, they'd write <img src="blob_plain/HEAD:/image.png">
> (assuming this patch landed).

And without this patch, the src URL needs to know where this
repository appears in the site's URL namespace?

If that is the case, the change makes quite a lot of sense.

Thanks.

