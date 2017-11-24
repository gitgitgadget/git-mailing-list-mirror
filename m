Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E28420954
	for <e@80x24.org>; Fri, 24 Nov 2017 08:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbdKXIhG (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 03:37:06 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:33620 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbdKXIhG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 03:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1511512624;
        s=domk; d=cs-software-gmbh.de;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:
        Content-Language:In-Reply-To:References:Date:Subject:CC:To:From;
        bh=czCAxrY2oDpPZ4JBH05cPNglyUbMoK2UtomvaFvphic=;
        b=YzJLYTx0Nzp5fkr5NUaySYze49TJzFH4+97TJDuSDIjkdQdCcPWXZV7SoCmGYLj3bs
        /hStZVRJBo2uhUt4ln8zT1kbD14/mSXq2q+zZYSbSiXuaD+JGrBiiLnC+j2wuYgOjtLw
        Aap95RaGxEeJDa4jp9xVQuRj/s+wZMIk05sCc=
X-RZG-AUTH: :LWABbUmIevNaG8tCOliF7QMk1+ctV4c3xgfkpNE0NajOhmQxl91LCNFTJgA=
X-RZG-CLASS-ID: mo00
Received: from remote.CS-SOFTWARE.local (b2b-78-94-62-122.unitymedia.biz [78.94.62.122])
        by post.strato.de (RZmta 42.9 DYNA|AUTH)
        with ESMTPA id Y0993dtAO8UsYG3;
        Fri, 24 Nov 2017 09:30:54 +0100 (CET)
Received: from SERVER2011.CS-SOFTWARE.local ([fe80::5168:c363:4af8:7565]) by
 SERVER2011.CS-SOFTWARE.local ([fe80::5168:c363:4af8:7565%11]) with mapi id
 14.01.0438.000; Fri, 24 Nov 2017 09:30:49 +0100
From:   Florian Manschwetus <manschwetus@cs-software-gmbh.de>
To:     Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>
CC:     Jeff King <peff@peff.net>, Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: [PATCH] http-backend: respect CONTENT_LENGTH as specified by
 rfc3875
Thread-Topic: [PATCH] http-backend: respect CONTENT_LENGTH as specified by
 rfc3875
Thread-Index: AQHTZLVoeXHlnWdD/UiXJiamEw7lp6MjCM29gAAp8CA=
Date:   Fri, 24 Nov 2017 08:30:49 +0000
Message-ID: <F0F5A56A22F20D4CB4A03BB8D66587970253F84634@SERVER2011.CS-SOFTWARE.local>
References: <20171123234511.574-1-max@max630.net>
 <xmqqvai0nrv9.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqvai0nrv9.fsf@gitster.mtv.corp.google.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.1.154]
x-pmwin-version: 3.1.2.0, Antivirus-Engine: 3.69.2, Antivirus-Data: 5.45
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,
thx Max for jumping in, I wasn't able to complete this due to serious lack =
of time.
Later I forgot it. Great to see that this finally made it.

Mit freundlichen Gr=FC=DFen / With kind regards
Florian Manschwetus

E-Mail: manschwetus@cs-software-gmbh.de
Tel.: +49-(0)611-8908534
=A0
CS Software Concepts and Solutions GmbH
Gesch=E4ftsf=FChrer / Managing director: Dr. Werner Alexi=20
Amtsgericht Wiesbaden HRB 10004 (Commercial registry)
Schiersteiner Stra=DFe 31
D-65187 Wiesbaden
Germany
Tel.: 0611/8908555

> -----Urspr=FCngliche Nachricht-----
> Von: Junio C Hamano [mailto:gitster@pobox.com]
> Gesendet: Freitag, 24. November 2017 06:55
> An: Max Kirillov
> Cc: Jeff King; Florian Manschwetus; Chris Packham; Konstantin Khomoutov;
> git@vger.kernel.org
> Betreff: Re: [PATCH] http-backend: respect CONTENT_LENGTH as specified
> by rfc3875
>=20
> Max Kirillov <max@max630.net> writes:
>=20
> > http-backend reads whole input until EOF. However, the RFC 3875
> > specifies that a script must read only as many bytes as specified by
> > CONTENT_LENGTH environment variable. This causes hang under
> IIS/Windows, for example.
> >
> > Make http-backend read only CONTENT_LENGTH bytes, if it's defined,
> > rather than the whole input until EOF. If the varibale is not defined,
> > keep older behavior of reading until EOF because it is used to support
> chunked transfer-encoding.
> >
> > Signed-off-by: Florian Manschwetus <manschwetus@cs-software-
> gmbh.de>
> > Authored-by: Florian Manschwetus <manschwetus@cs-software-
> gmbh.de>
> > Fixed-by: Max Kirillov <max@max630.net>
> > Signed-off-by: Max Kirillov <max@max630.net>
> > ---
> > ...
> > I hope I marked it correctly in the trailers.
>=20
> It is probably more conventional to do it like so:
>=20
>     From: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
>     Date: <original date of Florian's patch series>
>=20
>     http-backend reads whole input until EOF. However, the RFC 3875...
>     ... chunked transfer-encoding.
>=20
>     Signed-off-by: Florian Manschwetus <manschwetus@cs-software-
> gmbh.de>
>     [mk: fixed trivial build failures and stuff]
>     Signed-off-by: Max Kirillov <max@max630.net>
>     ---
>=20
> >
> > +/*
> > + * replacement for original read_request, now renamed to
> > +read_request_eof,
> > + * honoring given content_length (req_len),
> > + * provided by new wrapper function read_request  */
>=20
> I agree with Eric's suggestion.  In-code comment is read by those who hav=
e
> the current code, without knowing/caring what it used to be.  "It used to=
 do
> this, but replace it with this new thing because..." is a valuable thing =
to record
> in the log message, but not here.
