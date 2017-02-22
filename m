Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61EFC201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 16:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbdBVQTz (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 11:19:55 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:34784 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932197AbdBVQTx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 11:19:53 -0500
Received: from homiemail-a1.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 451EEC1D66
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 08:19:17 -0800 (PST)
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id AAD9D348078;
        Wed, 22 Feb 2017 08:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=T14P+iIHvK+R6oXPCGC4H1xb6us=; b=XskxDwjGYg
        v44x8V7RHi1gIPn/fI70LhIEQIyauQ2h2zP4iuOlmmRmXBh4yLPT7BMR0qFpGVkV
        yFgqWNoUtpSSRXtAP4o1FhiAYgpcwLS6LMWI6E19VCIlqdu1h53hPDS8bpmAZJGj
        dWFAM+dlSy0jlrH1LorsfwQEXc8oQ2r+k=
Received: from main (30-86-202.dynamic.csail.mit.edu [128.30.86.202])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id 4C4FF348074;
        Wed, 22 Feb 2017 08:17:37 -0800 (PST)
Message-ID: <1487780254.3016.1.camel@mattmccutchen.net>
Subject: Re: [PATCH] fetch: print an error when declining to request an
 unadvertised object
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 22 Feb 2017 11:17:34 -0500
In-Reply-To: <xmqqvas4gie9.fsf@gitster.mtv.corp.google.com>
References: <xmqq60kfezr9.fsf@gitster.mtv.corp.google.com>
         <1487470080.3570.8.camel@mattmccutchen.net>
         <xmqqvas4gie9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.4 (3.22.4-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-02-20 at 22:36 -0800, Junio C Hamano wrote:
> Hmph, I would have expected this to be done as a three-patch series,
>=20
> =C2=A0* move the loop at the end of cmd_fetch_pack() to a separate help=
er
> =C2=A0=C2=A0=C2=A0function report_unmatched_refs() and call it;
>=20
> =C2=A0* add a call to report_unmatched_refs() to the transport layer;
>=20
> =C2=A0* enhance report_unmatched_refs() by introducing match_status
> =C2=A0=C2=A0=C2=A0field and adding new code to filter_refs() to diagnos=
e other
> =C2=A0=C2=A0=C2=A0kinds of errors.

Sure.

> The result looks reasonable from a cursory read, though.
>=20
> Thanks for following it up to the completion.

This remark led me to believe you were satisfied with the single patch,
but the last "What's cooking in git.git" mail says "Expecting a split
series?".

Anyway, I made a split series and will send it in a moment.  I don't
know if all the commit messages include exactly the information you
want; hopefully you're happy to edit them as desired.  Compared to the
previous patch, there is one fix in the net result: fixing t5500-fetch-
pack.sh to deal with the internationalized "no such remote ref"
message.

Matt
