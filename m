Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23CF9211B9
	for <e@80x24.org>; Thu, 27 Dec 2018 02:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeL0Cw6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 21:52:58 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43375 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeL0Cw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 21:52:57 -0500
Received: by mail-ot1-f46.google.com with SMTP id a11so15317811otr.10
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 18:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=+f0UlMRkBhObnC65hWlyRduWc+nP9ONhqFmBnT+jwUE=;
        b=qbQe8FeCuenmpN7eWsA1fAmNvH7Ct6dzboHi6Brg9LTWKPU9cqDUM6LU6AbRjza+q8
         5/vKRJjpjOW/NY8YYWlc0CAy2TJAWhECkS/GWq+oWwMByAJLock/FGW+KgHNCj6cIOsL
         pc4VSfzUvtVfsrbtcBOoKEkan0Z6IxmWOn/AmvtV/GUaYqRtOrge+3P8vUoAgjvSFp+R
         2kjlT0ujXWAFr5pEPrdq0cZp5P21V1o4X3dBOlQHSfk5OGROaa2GB911iNBN1btBaNko
         Ezc/PW1NSUqAhvG7gjJ9vdq/cXW+rUS5wa/eEjZetG88pIYZAMgA6M/ktsM38ZzmaOfM
         Tn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=+f0UlMRkBhObnC65hWlyRduWc+nP9ONhqFmBnT+jwUE=;
        b=TEKGCZPRaU2EAhcOqFZwcaCLdQT+ORrXHf5EH2dfaPJaAXPvhd89u5wtspAZwGGQnC
         s6+gyONT1kyx1d1Lh3RnT6xK4md4VrIE7vDy1P2lQkrncZOkrJUoVlPKBwrW3e0VLUtQ
         IBYt42DTngJw3OqEh72uTYob1PKYHKix+pJYvx93ro1oksDta92S+uVM8ubJAyou+tjJ
         QufpRwOFUtJzHSDGgyFMy+PTQbr09mkPbTr+1unhCOBN5dKrct1zkSImTcIwvLMh9Efx
         MT2CZLbVqRzTL3J8v8LxEfMbeXxbn/y+4ej+hKfIu34WDt03vPJDZk/3mcCkg3ruz3Mj
         KFVg==
X-Gm-Message-State: AJcUukdl0AN6bas5JKNdcT69LustLbwZXCu2uWVw9mT5YZ+fQcaS//RS
        dDagt0+dfC6SWETebRDXuIg=
X-Google-Smtp-Source: ALg8bN4emwv6xYC7myDiCdRhqifI/7RvOQHiNEzlNmDFsodC06AXdc6yuuyWLGRHy0VmXhaWucEENQ==
X-Received: by 2002:a9d:23e5:: with SMTP id t92mr15438308otb.159.1545879176750;
        Wed, 26 Dec 2018 18:52:56 -0800 (PST)
Received: from Daddy1 (ip68-5-136-133.oc.oc.cox.net. [68.5.136.133])
        by smtp.gmail.com with ESMTPSA id s186sm18788484oif.0.2018.12.26.18.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 18:52:55 -0800 (PST)
From:   "Alexandre Grigoriev" <alegrigoriev@gmail.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     =?UTF-8?Q?'Torsten_B=C3=B6gershausen'?= <tboegi@web.de>,
        =?UTF-8?Q?'Adri=C3=A1n_Gimeno_Balaguer'?= <adrigibal@gmail.com>,
        <git@vger.kernel.org>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com> <20181104170729.GA21372@tor.lan> <CADN+U_MgrGHLQ5QNa-HgzxLN4zJLJPu4PaT2MTRoc18=gET+5Q@mail.gmail.com> <20181105181014.GA30777@tor.lan> <20181106201618.GA30158@tor.lan> <CADN+U_N345aMaiN4CT-_qsecw2gv=8-r+Hqq+CNz-xOx2KGYzg@mail.gmail.com> <20181108170230.GA6652@tor.lan> <002201d49cb5$cc554160$64ffc420$@gmail.com> <20181226192525.GB423984@genre.crustytoothpaste.net>
In-Reply-To: <20181226192525.GB423984@genre.crustytoothpaste.net>
Subject: RE: git-rebase is ignoring working-tree-encoding
Date:   Wed, 26 Dec 2018 18:52:56 -0800
Message-ID: <005601d49d8f$45c109b0$d1431d10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGzHBPypQu4TMaDIA8Y5jdFC6/IqAKw5WaKAccDkOcBIFMB5AIB+CVKAwbFfncBcP5zVgNFWJF+AgYx4KmlSfVTYA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> -----Original Message-----
> From: brian m. carlson [mailto:sandals@crustytoothpaste.net]
> Sent: Wednesday, December 26, 2018 11:25 AM
> To: Alexandre Grigoriev
> Cc: 'Torsten B=C3=B6gershausen'; 'Adri=C3=A1n Gimeno Balaguer'; =
git@vger.kernel.org
> Subject: Re: git-rebase is ignoring working-tree-encoding
>=20
> On Tue, Dec 25, 2018 at 04:56:11PM -0800, Alexandre Grigoriev wrote:
> > Many tools in Windows still do not understand UTF-8, although it's
> > getting better. I think Windows is about the only OS where tools =
still
> > require
> > UTF-16 for full internationalization.
> > Many tools written in C use MSVC RTL, where fopen(), unfortunately,
> > doesn't understand UTF-16BE (though such a rudimentary program as
> Notepad does).
> >
> > For this reason, it's very reasonable to ask that the programming
> > tools produce UTF-16 files with particular endianness, natural for =
the
> > platform they're running on.
> >
> > The iconv programmers' boneheaded decision to always produce =
UTF-16BE
> > with BOM for UTF-16 output doesn't make sense.
> > Again, git and iconv/libiconv in Centos on x86 do the right thing =
and
> > produce UTF-16LE with BOM in this case.
>=20
> A program which claims to support "UTF-16" must support both
> endiannesses, according to RFC 2781. A program writing UTF-16-LE must =
not
> write a BOM at the beginning. I realize this is inconvenient, but the =
bad
> behavior of some Windows programs doesn't mean that Git should ignore
> interoperability with non-Windows systems using UTF-16 correctly in =
favor of
> Windows.

OK, we have a choice either:
a) to live in that corner of the real world where you have to use =
available tools, some of which have historical reasons
to only support UTF-16LE with BOM, because nobody ever throws a =
different flavor of UTF-16 at them;
Or b) to live in an ivory tower where you don't really need to use =
UTF-16 LE or BE or any other flavor,
because everything is just UTF-8, and tell all those other people using =
that lame OS to shut up and wait until their tools start to support
the formats you don't really have to care about;

> behavior of some Windows programs doesn't mean that Git should ignore
> interoperability with non-Windows systems using UTF-16 correctly in =
favor of
> Windows.

Yes, Git (actually libiconv) should not ignore interoperability.
This means it should check out files on a *Windows* system in a format =
which *Windows* tools
can understand.
And, by the way, Centos (or RedHat?) developers understood that.
There, on an x86 installation, when you ask for UTF-16, it produces =
UTF-16LE with BOM.
Just as every user there would want.


