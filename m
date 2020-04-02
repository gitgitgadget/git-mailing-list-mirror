Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDE1C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827E42078B
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gY3g6Rsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbgDBQtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:49:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65295 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBQtC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 12:49:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 751B0C8772;
        Thu,  2 Apr 2020 12:49:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EptOp7wGHQpLyNoMKkbAMq/ln/A=; b=gY3g6R
        sl174VngOVr3KVdBHEOFzomdpGI//A21KcSQZxDQ0QFJNMonQ/kfEoIS0QuVJBS4
        wTIFbSIjgU4eLZ1F9rue/EF0REBwQrPxt46mT+ZDWgAJNqMtVhOH+fwTSv1DgisS
        mwLXUPLVJ9sxkfSExbxZpriz9FmqQ7Y17gutI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PXQwnF9v+ThHl0EmUw1yUqwlKPp0P44R
        93mp73RzAf1d+T22JwruM82mvl0yTlbQbzMEuMpnNAVtZmqHg3oCYITYxt3BgiPi
        ZObUmVKnhdb/dszeBzLh8+IgICKjk7MT2CfbeYW7iQoAaFi+fGdbbYyr957YA/dh
        fou8trrZaew=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E5BDC8771;
        Thu,  2 Apr 2020 12:49:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B370CC876C;
        Thu,  2 Apr 2020 12:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Doc: drop support for docbook-xsl before 1.74
References: <20200330094513.GB1735224@coredump.intra.peff.net>
        <20200331192600.588-1-martin.agren@gmail.com>
        <20200401101716.GC60227@coredump.intra.peff.net>
        <20200402004533.GA6369@camp.crustytoothpaste.net>
Date:   Thu, 02 Apr 2020 09:48:56 -0700
In-Reply-To: <20200402004533.GA6369@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 2 Apr 2020 00:45:33 +0000")
Message-ID: <xmqqk12x4yvb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8986198-7501-11EA-9674-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I believe Emacs does have good integration with the info format.  I
> personally prefer documentation in almost any other format and would
> also be happy to see it go away, but Emacs users may find it convenient.
>
> Junio, I believe you use Emacs.  Do you have an opinion on whether, on
> the whole, Emacs users are likely to make good use of the info
> documentation?

I probably am very atypical; I used to read even system manuals via
info in Emacs, but for the last 10 years or more, I don't.  Another
reason that makes me a bad judge is because I do not use our doc in
any formatted form---"git grep -e ... Documentation/" is easier and
faster.  So, no, I have no opinion.

> If nobody seems to care very much for the info documentation, we could
> drop it.  I've put a query out on Twitter to see if anyone I know is
> using it.

Thanks.
