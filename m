Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638BD20285
	for <e@80x24.org>; Wed, 30 Aug 2017 21:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbdH3Vbg (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 17:31:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54546 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750862AbdH3Vbf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 17:31:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 777AA974AE;
        Wed, 30 Aug 2017 17:31:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DvtsOOvn97Tp
        rKfeFEzdxDm8nhE=; b=UNOnKLgutBCAy4Jszhp3qITyqDdnjM5LwOPirKv2i/cV
        FUjpcSNPKmNI60rFIrQFfxmyeBgmjciEolE4mlyJwo02zzWAwWJ+l0yUP9JsDc8F
        MFNUL3rWc7xtHByurBqboqbm1UDvTQgxKxVyrQdKT4ug3IPuWVVYE4K3NL0rR6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=x3ujVQ
        zgtJRUNc7cSQl99WVdimDoCtXsAEPAnP4Ty/ZBvilPZW3QSFk3F4qk/HW5E1iGz3
        5uaGrwomMs4aTZeGjMRe2sFl+GNqe9Z00Xwt7G2E6VCRwS+yv4B0jbN7mM0ODjiE
        5MMD7OlJ02KyyW4gV+gVApqIgnlw8wgQR8zVk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F338974AD;
        Wed, 30 Aug 2017 17:31:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFF32974AC;
        Wed, 30 Aug 2017 17:31:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Ben Boeckel <mathstuf@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Documentation: mention that `eol` can change the dirty status of paths
References: <20170822174918.GA1005@megas.kitware.com>
        <20170823211741.9633-1-mathstuf@gmail.com>
        <20170824055054.GA32617@tor.lan>
Date:   Wed, 30 Aug 2017 14:31:30 -0700
In-Reply-To: <20170824055054.GA32617@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Thu, 24 Aug 2017 07:50:54 +0200")
Message-ID: <xmqqpobcpwst.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9737FAA4-8DCA-11E7-B8DC-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> How about something like this :
>
>   This attribute sets a specific line-ending style to be used in the
>   working directory.  It enables end-of-line conversion without any
>  -content checks, effectively setting the `text` attribute.
>  +content checks, effectively setting the `text` attribute.  Note that
>  +setting this attribute on paths which are in the index with CRLF
>  +line endings makes the paths to be considered dirty.

Is this "always makes them dirty" or "may make them dirty depending
on the situation"? =20

If the latter, I'd prefer to see s/makes/may make/ here.


