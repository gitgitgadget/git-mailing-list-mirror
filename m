Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088A5211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 00:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeLZA4L (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Dec 2018 19:56:11 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:43715 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbeLZA4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Dec 2018 19:56:10 -0500
Received: by mail-oi1-f176.google.com with SMTP id u18so12019579oie.10
        for <git@vger.kernel.org>; Tue, 25 Dec 2018 16:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=AIGzEuki3dYVrM5G9mH6y/6DDr24D3SqEZ/qxvxKcGY=;
        b=IbCatLvdCsqc+JR5XCvrLL6bDvzYaSaPwNoz8RTenN1BNanHJ20qW53BSxfvGXO3xx
         AOagsbbu926j8iG8HqV9CMqGle+veHmSZghuTDC1rkUAdpnLVQNPUpWL83YZvivi6yDK
         hw3eDsL2ZGPLVTw2uxmcaXgTHeFAhxoZxW77HGX4FJ5iTe/sP5uBHaaNEFzvuwXYv3Lm
         zjwc9rUrxtnlIWRSQvlhkJxIrfD1dBqZewLHXpIaRmCzo/5dj2RvtkWzSa2CKNTfLpMS
         VdqPDCbS7aPzsL9lHe/QuMGglKT7UBv1LkitjA6V+xzFrsrYFv+sDIIfvcyXnwc2QcKo
         nYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=AIGzEuki3dYVrM5G9mH6y/6DDr24D3SqEZ/qxvxKcGY=;
        b=ZNXJyzniEtWD78BzwYRiO4OBkbQGD7lL8rCL2hSeo8W/53eqmNxO/3bN8xwiFh/om1
         esh2CvifG0ztjddBUNWF/IkHt+vOWhC4eWViit9Y5HJtHBG+lsbQKIPXz+Flv3814mh+
         JBwC8NEkbH1oPzhYYZWRl3STne7ZryVqCSot8cJA/jSe2q57OlF9PPJJPZIr7h0kS1yc
         sicMEuqApjVELinnjENBJERYKEeb2iunoNYggMlvW70/nGtrC76+rMaQHFTa4PX0uAmi
         m23/pcbOcgEXc+IQET0y33wnOZVKDO8Q4zX4zUD20TeiOXjgcxYWT7s/TfL5XYdxn6fO
         tZmA==
X-Gm-Message-State: AA+aEWbPLC//2aA4H4I0QY7cNTp/iSmexdA/wGzHfjL2do/bwkNxQHM0
        YwHEUqlh0/KFrjXOizBdgtE=
X-Google-Smtp-Source: ALg8bN56dJvGsiKQYW4hfa8BatMSR/e52UVZdjLkEE+JmMiRsQvinXtizMXTQryFq+dy3C2w3ZJLFw==
X-Received: by 2002:aca:4d47:: with SMTP id a68mr10885029oib.43.1545785769630;
        Tue, 25 Dec 2018 16:56:09 -0800 (PST)
Received: from Daddy1 (ip68-5-136-133.oc.oc.cox.net. [68.5.136.133])
        by smtp.gmail.com with ESMTPSA id 99sm17366720oth.20.2018.12.25.16.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 16:56:08 -0800 (PST)
From:   "Alexandre Grigoriev" <alegrigoriev@gmail.com>
To:     =?iso-8859-1?Q?'Torsten_B=F6gershausen'?= <tboegi@web.de>,
        =?iso-8859-1?Q?'Adri=E1n_Gimeno_Balaguer'?= <adrigibal@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com> <20181104170729.GA21372@tor.lan> <CADN+U_MgrGHLQ5QNa-HgzxLN4zJLJPu4PaT2MTRoc18=gET+5Q@mail.gmail.com> <20181105181014.GA30777@tor.lan> <20181106201618.GA30158@tor.lan> <CADN+U_N345aMaiN4CT-_qsecw2gv=8-r+Hqq+CNz-xOx2KGYzg@mail.gmail.com> <20181108170230.GA6652@tor.lan>
In-Reply-To: <20181108170230.GA6652@tor.lan>
Subject: RE: git-rebase is ignoring working-tree-encoding
Date:   Tue, 25 Dec 2018 16:56:11 -0800
Message-ID: <002201d49cb5$cc554160$64ffc420$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGzHBPypQu4TMaDIA8Y5jdFC6/IqAKw5WaKAccDkOcBIFMB5AIB+CVKAwbFfncBcP5zVqVynmag
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Torsten Bogershausen
> Sent: Thursday, November 8, 2018 9:03 AM
> To: Adri=E1n Gimeno Balaguer
> Cc: git@vger.kernel.org
> Subject: Re: git-rebase is ignoring working-tree-encoding
>=20
> On Wed, Nov 07, 2018 at 05:38:18AM +0100, Adri=E1n Gimeno Balaguer =
wrote:
> > Hello Torsten,
> >
> > Thanks for answering.
> >
> > Answering to your question, I removed the comments with "rebase" =
since
> > my reported encoding issue happens on more simpler operations
> > (described in the PR), and the problem is not directly related to
> > rebasing, so I considered it better in order to avoid unrelated
> > confusions.
> >

> OK, I think I understand your problem now.
> The file format which you ask for could be named "UTF-16-BOM-LE",
> but that does not exist in reality.
> If you use UTF-16, then there must be a BOM, and if there is a BOM,
> then a Unicode-aware application -should- be able to handle it.
>=20
> Why does your project require such a format ?
>=20

Many tools in Windows still do not understand UTF-8, although it's =
getting
better. I think Windows is about the only OS where tools still require
UTF-16 for full internationalization.
Many tools written in C use MSVC RTL, where fopen(), unfortunately, =
doesn't
understand UTF-16BE (though such a rudimentary program as Notepad does).

For this reason, it's very reasonable to ask that the programming tools
produce UTF-16 files with particular endianness, natural for the =
platform
they're running on.

The iconv programmers' boneheaded decision to always produce UTF-16BE =
with
BOM for UTF-16 output doesn't make sense.
Again, git and iconv/libiconv in Centos on x86 do the right thing and
produce UTF-16LE with BOM in this case.

Also, iconv/libiconv should not be rejecting files with BOM for input
encoding UTF-16BE or UTF-16LE.
The BOM is not some magic tag. It's just a zero-width space, with unique
property that its 8 and 16 bit encoding variants can be recognized one =
from
another. It can appear anywhere in a file.
If it's a first character in the file, then the file encoding can be
reliably detected. But it's just a character, and iconv should be =
accepting
such files as valid.

