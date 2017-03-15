Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665DD202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbdCOVdH (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:33:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51209 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752585AbdCOVdG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:33:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AD857F5FB;
        Wed, 15 Mar 2017 17:29:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=d9hErx2C/fb/
        w9l3JNq8bvAcl04=; b=xavRD5B8T5aC5GWubXr+Y4CC/AKbDvibV4ofUFlaWjIa
        jHjHPnlSsjGqJm3/E3od/y42n5zyevYfXjppMNYCiA/2tS1pXiaqqJ8z+eDZ/OBp
        EIX3gWF9rn61/6pUeVZojpBrbVwkdTedtGIs6Ip5ACtPsLfDnxKP+lu8V87iGxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=G2C1hM
        xvgivt+iNQ5JQvZLaMXVlt8zfHdFsZ5wg7KK3Sn+tm8doKKQgfm4msd7mqQcG6bp
        zePziqebFELf3arhbhLf/UqXPehKI68n1WZOgb2YwsMD1STeXSvhYFDnpDVtE2dL
        C0VzT5KBeWYkV+BCB7OjaMdQXsosOQYtsujBw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33ED77F5FA;
        Wed, 15 Mar 2017 17:29:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 917FE7F5F8;
        Wed, 15 Mar 2017 17:29:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jeff King <peff@peff.net>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Florian Adamus <florian-adamus@gmx.de>, git@vger.kernel.org
Subject: Re: Commiting files larger than 4 GB on Windows
References: <trinity-9f703269-6f73-4f6d-b90b-45e09e1c094c-1489582854278@3capp-gmx-bs66>
        <179b5d92-ee96-c2df-dbd8-eb96f7bbdb24@virtuell-zuhause.de>
        <20170315155952.x2tpiudi6rbqidvi@sigill.intra.peff.net>
        <20170315161308.sbyoxzst7ffcu6qs@sigill.intra.peff.net>
        <93ccf86d-0090-a311-9825-7e23fd6a4141@web.de>
Date:   Wed, 15 Mar 2017 14:29:01 -0700
In-Reply-To: <93ccf86d-0090-a311-9825-7e23fd6a4141@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 15 Mar 2017 22:15:46
 +0100")
Message-ID: <xmqq4lyudyaq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 68EEEBCC-09C6-11E7-BFBF-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The real "show stopper" is at the end.
> ...
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> And it seams as if zlib is the limitation here.
> Unless we include the zlib source code into Git and redefine uLong,
> is there a nice way around this:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
>
> /usr/include/zconf.h:#  define uLong                 z_uLong
> /usr/include/zconf.h:#  define uLongf                z_uLongf
> /usr/include/zconf.h:typedef unsigned long  uLong; /* 32 bits or more *=
/
> /usr/include/zconf.h:typedef uLong FAR uLongf;

Hmph.  Would ef49a7a0 ("zlib: zlib can only process 4GB at a time",
2011-06-10) and e01503b5 ("zlib: allow feeding more than 4GB in one
go", 2011-06-10) help us here, though?

