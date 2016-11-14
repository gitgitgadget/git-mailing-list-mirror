Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF1BE1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 18:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935992AbcKNS2O (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 13:28:14 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:36383 "EHLO
        homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932458AbcKNS2N (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Nov 2016 13:28:13 -0500
Received: from homiemail-a61.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTP id A359057807D;
        Mon, 14 Nov 2016 10:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=dmKLHWi87X5WVgTct/qD2FglHiI=; b=vV1gFaetL6
        wPIFgQ22WxbRqnIvJaT/ChJHJMXDOfbQbmFSIiJxYDdjS1nWilQYVBIWhRIm1hQH
        j2ckT0LewyakxNUzg8Lrok61Vbbuj8R5g5fQlc3Tl5IfDoctzf4c1DZ5Lzh8r3hi
        vxxcwIqto27gy9YQnuJZ10nrLdgVleLQI=
Received: from main (30-10-119.wireless.csail.mit.edu [128.30.10.119])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTPSA id F199057807B;
        Mon, 14 Nov 2016 10:28:11 -0800 (PST)
Message-ID: <1479148088.2406.27.camel@mattmccutchen.net>
Subject: Re: [PATCH] fetch/push: document that private data can be leaked
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Date:   Mon, 14 Nov 2016 13:28:08 -0500
In-Reply-To: <xmqq1syezs3g.fsf@gitster.mtv.corp.google.com>
References: <xmqqy416uvan.fsf@gitster.mtv.corp.google.com>
         <1479001205.3471.1.camel@mattmccutchen.net>
         <xmqq1syezs3g.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2016-11-13 at 18:57 -0800, Junio C Hamano wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
>=20
> >=20
> > =C2=A0Documentation/fetch-push-security.txt | 9 +++++++++
>=20
> A new (consolidated) piece like this that can be included in
> multiple places is a good idea.=C2=A0=C2=A0I wonder if the original
> description in "namespaces" thing can be moved here and then
> "namespaces" page can be made to also borrow from this?

I gave this a try. =C2=A0New patch coming.

> > --- /dev/null
> > +++ b/Documentation/fetch-push-security.txt
> > @@ -0,0 +1,9 @@
> > +SECURITY
> > +--------
> > +The fetch and push protocols are not designed to prevent a
> > malicious
> > +server from stealing data from your repository that you did not
> > intend to
> > +share. The possible attacks are similar to the ones described in
> > the
> > +"SECURITY" section of linkgit:gitnamespaces[7]. If you have
> > private data
> > +that you need to protect from the server, keep it in a separate
> > +repository.
>=20
> Yup, and then "do not push to untrustworthy place without checking
> what you are pushing", too?

If there is no private data in the repository, then there is no need
for the user to check what they are pushing. =C2=A0As I've indicated befo=
re,
IMO manually checking each push would not be a workable security
measure in the long term anyway.

Matt
