Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B60CC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 21:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5729D20731
	for <git@archiver.kernel.org>; Thu,  7 May 2020 21:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QYNaCPdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGVC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 17:02:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60906 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 17:02:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0559D9D4C;
        Thu,  7 May 2020 17:02:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mpm0MbUCKAi/
        MlKLgTEsyNAnAdU=; b=QYNaCPduilUjacmw2TujHeFlkVf3EgYXs5XRGAmSC+9Z
        51zL+nxjk1O/Au2TqyNyCrP4JOqvDsSVhQjL0D6oOO2l+nqEY2XfEm/I08g5P0Qi
        wQUynAtBI2vFyImoq5wzqW+YRemOxkENbI2gfZjBYp+o0PbsM28QaPNs1Sk0WLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JRbpBH
        B5ovV2tv0nsAXXw/s8YJQRzrCfnZiA16kLCdUWV7V7X17+TypwdI//C7Tv2Ed5SM
        gUWBre1KVvYAnxiSSQ3UzziYOJgbbLuJ4Tjw7ytLCYSSlExFLjOa2D5bwcH7J6WC
        p/GZ8E2B+aNTTX0ke/YU8jgx1DvMDe/ItI8ZA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7BACD9D4B;
        Thu,  7 May 2020 17:02:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A732DD9D48;
        Thu,  7 May 2020 17:02:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 3/4] credential: update gitcredentials documentation
References: <20200505013908.4596-1-carenas@gmail.com>
        <20200506214726.81854-1-carenas@gmail.com>
        <20200506214726.81854-4-carenas@gmail.com>
        <20200507205435.GA39802@coredump.intra.peff.net>
Date:   Thu, 07 May 2020 14:02:18 -0700
In-Reply-To: <20200507205435.GA39802@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 7 May 2020 16:54:35 -0400")
Message-ID: <xmqqsggb31d1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0B505E78-90A6-11EA-8F51-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, May 06, 2020 at 02:47:25PM -0700, Carlo Marcelo Arenas Bel=C3=B3=
n wrote:
>
>> +While it is possible to override all attributes, well behaving helper=
s
>> +should refrain from doing so for anyone other than username and passw=
ord.
>
> The earlier versions said "any attributes other than..." which I think
> is a bit more precise than "anyone".
>
> Other than that, this looks good to me.

Will locally tweak; thanks.
