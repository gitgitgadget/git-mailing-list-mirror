Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D321F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 10:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409714AbfJYK4s (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 06:56:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57776 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2407132AbfJYK4s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 06:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572001007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEDrNF41/Fk1cGwVJLrCKi66k3GqC/TR1AmJlHTHLmU=;
        b=eZNqipWujBis03oFtdqWFtx519IOmLgUhShg+c0P3BHAMm0rvSkKeL8P/ZUNhWIaVyizsN
        1c938ZqZGLT1OJkGcExAaTt3hTngio+2ugkBDfKSU8LjRtfl9DkVVvEU3cNt86PVA3dssU
        U2IR6w95v3ImS0MFS3+1JLGZb2czByA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-e0kuroOROUyuDpuHchAdaA-1; Fri, 25 Oct 2019 06:56:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 352F1800D41;
        Fri, 25 Oct 2019 10:56:42 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60A0A1001DC0;
        Fri, 25 Oct 2019 10:56:41 +0000 (UTC)
Subject: Re: [PATCH v2] pretty: add "%aL"|"%al|%cL|%cl" option to output
 local-part of email addresses
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
References: <20191024125332.29958-1-prarit@redhat.com>
 <20191024202947.GN4348@szeder.dev>
 <5d9b8cbe-489e-b3eb-873c-4aee2e2015d0@redhat.com>
 <xmqqwoctcszm.fsf@gitster-ct.c.googlers.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <8baf0152-e38a-eaad-b181-72e2d3d2f00d@redhat.com>
Date:   Fri, 25 Oct 2019 06:56:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqwoctcszm.fsf@gitster-ct.c.googlers.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: e0kuroOROUyuDpuHchAdaA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/19 1:08 AM, Junio C Hamano wrote:
> Prarit Bhargava <prarit@redhat.com> writes:
>=20
>> It can't harm anything to have braces but if the preferred git coding st=
yle is
>> to only use them when necessary I will remove them.
>=20
> It harms readability.  Don't try to be different just for the sake
> of being different, especially when you think "it can't harm
> anything" aka "there is no strong reason to do so (or not to)".
> Instead, help others by making sure that their eyes do not have to
> get distracted for such meaningless differences from existing parts
> of the system.

Ha :)  I did pull them for v3 after doing a search.  I didn't reply properl=
y and
should have said "I'll do a search".  Admittedly I'm concerned in a few spo=
ts in
the code where it *seems* like something could go wrong if the code is chan=
ged.
But nothing worth patching over.

P.

>=20
> Thanks.
>=20

