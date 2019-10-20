Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20CA81F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 18:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfJTS1K (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 14:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfJTS1K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 14:27:10 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC74A218BA;
        Sun, 20 Oct 2019 18:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571596029;
        bh=7uPdkhMCeJbTYfsMFo9NsHhaa959Mg+36iP5wUWxRjQ=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=18Vz+9ZNoM6G+2XpMf63vIF0Dx6rKp/G3DtmTD8TzU5l8puFfTi8rKWmFo16MIYxe
         EeKF8w8QuGvI4iVCWcfw9io9Xro/+vVb42H0ur7wHMdEsQMSk4sETlBmRJuPufTHDP
         Ue7YEFGFnJ3f78bcub0vUkcgR6/yqdmy+0rDv8fA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4f8e8a13-c41f-558f-18c3-b2bda178a06b@kdbg.org>
References: <20191016203239.212174-1-sboyd@kernel.org> <4f8e8a13-c41f-558f-18c3-b2bda178a06b@kdbg.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Adrian Johnson <ajohnson@redneon.com>,
        Junio C Hamano <gitster@pobox.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2] userdiff: Fix some corner cases in dts regex
User-Agent: alot/0.8.1
Date:   Sun, 20 Oct 2019 11:27:08 -0700
Message-Id: <20191020182709.CC74A218BA@mail.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoting Johannes Sixt (2019-10-16 14:10:09)
> [Removed bouncing addresses of Matthieu Moy and William Duclot from Cc]
>=20
> Am 16.10.19 um 22:32 schrieb Stephen Boyd:
> > diff --git a/t/t4018/dts-nodes-multiline-prop b/t/t4018/dts-nodes-multi=
line-prop
> > new file mode 100644
> > index 000000000000..db4b4bdda686
> > --- /dev/null
> > +++ b/t/t4018/dts-nodes-multiline-prop
> > @@ -0,0 +1,14 @@
> > +/ {
> > +     label_1: node1@ff00 {
> > +             RIGHT@deadf00,4000 {
> > +                     multilineprop =3D <3>,
> > +
> > +
> > +                                     <4>;
>=20
> I was actually thinking about something like
>=20
>                         multilineprop =3D <3>,
>                                         <0xabcd>,
>                                         "text",
>                                         name,
>                                         <4>;
>=20
> or something like that -- whatever occurs in the real world.
>=20

Ok sure. I can have a list of numbers that spans four or five lines.

> > +
> > +
> > +
> > +                     ChangeMe =3D <0xffeedd00>;
> > +             };
> > +     };
> > +};
>=20
> Apart from that, the patch looks good.
>=20

Cool. I'll resend.

