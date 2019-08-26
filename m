Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D58D1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfHZOQy (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:16:54 -0400
Received: from sonic303-24.consmr.mail.ne1.yahoo.com ([66.163.188.150]:42901
        "EHLO sonic303-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729015AbfHZOQy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Aug 2019 10:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1566829012; bh=dFaDAeD/sdU98rkbouMb/AqmnyN2nxfoO6cHNAK7BHg=; h=From:To:Cc:References:In-Reply-To:Subject:Date:From:Subject; b=WlzvbYkujagtz5kF5aacaMrKb266ZH9UlKy1nyDdGsP2BNXpA+8syJeOl8j5ZGo58xwuDEL9gSnrSUixrvPmFNi2mphSAeqLsKwUUqO8mTidi4p1uIs14olRG3vnUtT97n9TFgp7JQxEbPMPYxGBVyltvVhLIqfvVk32mnF10e1RzEzAIjAn0FTKek9nn/7bSOSirrOZnadx3KvFfmAKnsgRaco49/hXSy9a6ZjiIve1qvh9qT00dQeBV9U1919j0vAjyn8BxIRGta+2OeaXkpUg2uUPLKI/BrV6XafVAAaYnsBfSh9vmbvDIapLj3o3Z09EbX+Mjp6BMGNCtuV4pw==
X-YMail-OSG: 01YEwTkVM1mGZxtsc0Ryxhq.s8zDPBrWAwwPGsdXEVNbHf.gr0gGYh9uEuHQp0M
 m4X2ijPpcIVh1QXWy9uv.efQQwIQ5T4su7vQq66OW9kb13RH9i83Z.TALun4LfrWWcESQAZwXwqh
 bN3GEhBnmGSWvTuosxQofzAZNG.V8eFq7BNZF7UzPGHaaIGc8Q5OsnS6EWB8I4bgnoumjU2bpD6K
 vnbKFp.6IOVrBsrGN.K1EKeEOj1wAYiaOREJVPrUp4U69KaftR4TqD1Xe5qYcmI3ERz6yGidLc.E
 mY7xEvrnJQK6pJ5avixHLEwPfAo2d6Z0NaQ9T3icBeBk8wZbjHWqe1JaCDF7Cid1RzCO2swtZeza
 FQBrVdCigHwgXwj_ZjG352mYYEAdU5NKQ.2l2X_ijLeZrg3V4d.GtdM._L_gr1wzLjoZ3yYCE30s
 1NovZIgLbNH98Qh.PeN5JyY1ffxEmYQ5iaNVhDJhN3ftJ6uQUCj_BZ_2K2kM6LOQxvgzxjYL9JDK
 h9vKZcFduALXjV1IVTor29s4wlD9drPC1YG76qMyq3tOuJPJCzObWE6fDrbNyZ7946bejPKihRwq
 HfHyjMtGMeGzdH0sycjC23uSEQNPCBFyopBc0SH1sEp87NooxXTOoJd2lybcOqwbIjvvEpX3MQNI
 amMr0.ZeddmEy7A4n534IlWIosf2PV3.puRRjG0rbqYKkF.WOaMdGS7tdkv5kP_ix_DvKM_10uts
 IczZNYL1YQtv3VZxU9fkcALzSZfeCg8gijz1B_EUJYqfndHNy9BYjXYo_1LviA536j0Hh5Crvu.e
 BEC5JxeQIGLNrWy.03cj5o2MXTy9qhVx55389ZWVq4AUYe59wuvIvhJv57qPYQXXNf6A33QxJHrY
 .5Xpp31UIKqkNiP9mAGaKhOCDZvxZY303d8INioD7JXamHbcXtO2MJuwKApENhVz72NyMA7VHA0o
 dHHKMTCwbY44HaXOLWrjvsOsNtzqqXhx0jfHh.8IpFInMuuHGv5ou4GBM0mvxI4s.ly45WrYBOSg
 _k0ORDkjzPPxriptnOxDYn0ttaxbLI4Al4qfz70RvA9gzv2yq0Su.360V58YNPyrKdsYxnAvnyfB
 2eewg.qf795FT0eD6MPbcQ8lqvqw75orUCC67OorIraCzIqgA7OkWsstrROUDsLZ467bIwrkCTWG
 BGMbswNIFe7sA6d4OtY2BjSxFeqVbC5okwf6y3RrM.pOhQl9qg6bnobsma7.AX.iIA_P00nGtQYj
 OjCsb_S9GL8hSRDsXXvX9XWFIdOWtumC5a2ESvg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Aug 2019 14:16:52 +0000
Received: by smtp431.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c184765ab7e0649881010d02a940cafd;
          Mon, 26 Aug 2019 14:16:51 +0000 (UTC)
From:   <randall.s.becker@rogers.com>
To:     "'Bryan Turner'" <bturner@atlassian.com>
Cc:     "'Git Users'" <git@vger.kernel.org>
References: <005f01d55a1f$88e2ab20$9aa80160$@rogers.com> <CAGyf7-HyJGVX51YMH0uqah4dkwkwfs6pLR5eSVBCeRQ1Ou=ZjQ@mail.gmail.com>
In-Reply-To: <CAGyf7-HyJGVX51YMH0uqah4dkwkwfs6pLR5eSVBCeRQ1Ou=ZjQ@mail.gmail.com>
Subject: RE: [Question] clone performance
Date:   Mon, 26 Aug 2019 10:16:48 -0400
Message-ID: <006001d55c18$e6def6c0$b49ce440$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLF/IjgNADX6oarydk8PpngD+yI5wGSPTFNpR+lUkA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 24, 2019 5:00 PM, Bryan Turner wrote:
> On Fri, Aug 23, 2019 at 6:59 PM <randall.s.becker@rogers.com> wrote:
> >
> > Hi All,
> >
> > I'm trying to answer a question for a customer on clone performance.
> > They are doing at least 2-3 clones a day, of repositories with about
> > 2500 files and 10Gb of content. This is stressing the file system.
>=20
> Can you go into a bit more detail about what "stress" means? Using too
> much disk space? Too many IOPS reading/packing? Since you specifically
> called out the filesystem, does that mean the CPU/memory usage is
> acceptable?

The upstream is BitBucket, which does a gc frequently. I'm not sure any =
of this is relating to the pack structure. Git is spending most of its =
time writing the large number of large files into the working directory =
- it is stress mostly the disk, with a bit on the CPU (neither is =
acceptable to the customer). I am really unsure there is any way to make =
things better. The core issue is that the customer insists on doing a =
clone for every feature branch instead of using pull/checkout. I have =
been unable to change their mind - to this point anyway.

We are going to be setting up a detailed performance analysis that may =
lead to some data the git team can use.

Regards,
Randall

