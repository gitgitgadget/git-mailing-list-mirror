Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965EE1FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 23:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932192AbdCJXdf (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 18:33:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58111 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755555AbdCJXdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 18:33:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56B376C2CA;
        Fri, 10 Mar 2017 18:33:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ujlsiad/8k1a
        hJxhQxqEUOAOZfI=; b=O7vPR3igKdh8EgkD8U+Kul9Benqaz0TABnhsmUbfk0kP
        HXpqzaAWWbPoCuXXY463oPPtY1REUj7bFdEZqs+iJveVzkhGZbLDaGWECFV4iFEU
        3TEur9SpkzCVMYCicYvMZ4uvodKgpyZVbCYSF+aD88u7DWs6iO9o0tSYtox3xg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IksyKD
        WAeB/vskWbkazMxqhsD6vgEz6Ic+kzp9c12TlKKD8w6FbSOnivwSN+3SGNPe0CbQ
        YVadq/ch/2TC2Gb9Nr69bjzIXTOVcbX23uNJtJw0OL1zZw+goUvuw94xQKf9EFAh
        EEjX9SnKxtBTvHZ8p4INlrm92lCO8HBhow714=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 507C36C2C9;
        Fri, 10 Mar 2017 18:33:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE2F16C2C8;
        Fri, 10 Mar 2017 18:33:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
References: <alpine.DEB.2.20.1703030315580.3767@virtualbox>
        <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
        <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
        <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
        <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
        <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
        <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
        <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
        <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
        <c553da50-e5ca-d064-e75c-46e5a5042935@web.de>
        <20170310081759.yka476hnw4w3mghs@sigill.intra.peff.net>
        <04f4849c-e1e0-f0ac-5b1e-10a343391db4@web.de>
        <xmqqfuikyjoo.fsf@gitster.mtv.corp.google.com>
        <c93a61a4-05d9-8e49-9734-12c81289517b@web.de>
Date:   Fri, 10 Mar 2017 15:33:21 -0800
In-Reply-To: <c93a61a4-05d9-8e49-9734-12c81289517b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 10 Mar 2017 23:04:32 +0100")
Message-ID: <xmqqr324wvum.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F37161B6-05E9-11E7-8EDD-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> 	@ depends on r @
> 	expression E;
> 	@@
> 	- *&
> 	  E

I guess my source of the confusion is that the tool that understands
the semantics of the C language still needs to be told about that.

I was hoping that something that understands C only needs to be told
only a single rule:

	type T
	T src, dst

	-memcpy(&dst, &src, sizeof(dst));
	+dst =3D src;

and then can apply that rule to this code in four ways:

	struct foo A, *Bp;

	memcpy(Bp, &A, sizeof(*Bp));
	memcpy(Bp, &A, sizeof(A));
	memcpy(&src, dstp, sizeof(A));
	memcpy(&src, dstp, sizeof(*Bp));

to obtain its rewrite:

	struct foo A, *Bp;

	*Bp =3D A;
	*Bp =3D A;
	A =3D *Bp;
	A =3D *Bp;

by knowing that (*Bp) is of type "struct foo" (even though Bp is of
type "struct foo *") and sizeof(dst) and sizeof(src) are the same
thing in the rule because src and dst are both of type T.
