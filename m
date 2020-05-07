Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05761C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 18:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50D9216FD
	for <git@archiver.kernel.org>; Thu,  7 May 2020 18:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ro6fM2OP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgEGS4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 14:56:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61760 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgEGS4R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 14:56:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4857BD90D1;
        Thu,  7 May 2020 14:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XiGkUh/enSmesRoWEYfLm1QPPFQ=; b=ro6fM2
        OPRyNEuddEcoLbDGSH2cw7OMWN76JcsZGDWTHcl7otU2xZdIppfCBOv+mmCLdfdQ
        V+730SJ+Xl7HBIQ4c3iekYzyDMotC3aASChQPi1fIdS4e/bhiCE9OHixG5gtINcS
        Q4oEzvAVQC4Fd6DFkAVzTBq6M376vLkEVpNOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fyTi65XiZMnfy1ziDVJc9INuohj6Yl8D
        sGjxXXPQBJKT+tF1zRK9H6MaVUfSVVUh7DSnXMTPpAgkFLv6hiGTUHZKujP7SQr/
        l/BPIwKeFZpN43S5ASSpNbY31s3DS3/4lDVySTsmlJ4EndUvd2ATFF0pnf7vfZvI
        Ha4DujWgUlk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FEC3D90D0;
        Thu,  7 May 2020 14:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86CDED90CF;
        Thu,  7 May 2020 14:56:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (April 30, 2020)
References: <fda6d0db-f79e-f44e-7c2b-b60ed1794cd0@gmail.com>
        <CAFQ2z_PP9Ld+GDctV-v2CDKFamF6zKdJZ_-jhahj_fcm3wy4Hw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2005012316350.18039@tvgsbejvaqbjf.bet>
        <20200503095500.GF170902@coredump.intra.peff.net>
        <xmqq1ro1j6qk.fsf@gitster.c.googlers.com>
        <CAFQ2z_Pf7u0k-PvMG8J-kWMdRXhamm5JgHZiUM6Ffu-2zGGubQ@mail.gmail.com>
Date:   Thu, 07 May 2020 11:56:10 -0700
In-Reply-To: <CAFQ2z_Pf7u0k-PvMG8J-kWMdRXhamm5JgHZiUM6Ffu-2zGGubQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 7 May 2020 12:11:02 +0200")
Message-ID: <xmqqa72j4lrp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BC21E70-9094-11EA-9C75-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> I'm discussing options on how to move forward with Jonathan Nieder.
> Once we have sorted those out, we'll send out an email, hopefully
> early next week.

Thanks.
