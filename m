Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549FD1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 19:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfFST4u (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 15:56:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:49457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfFST4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 15:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560974188;
        bh=dedsjUkTS3Rl6hrMUugLJOI5MNvPxRW192F25xDggwA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MJPEpGRTM8gtJcCif7Bj7E2SXasnif1W/DJKkrjMOSg5KUcMDFvuMOSZGColi7nwG
         DlFyzcSjOayk2kwRWfv/z5raDTQS5uSdLEeU1pnQvCmZ6UsllRup/ztU2IkpWs2e+D
         UD/LWyrAuA73hi5fns6L80YQFqulrOD+O5U6a7go=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M86jp-1iZ4Xd2g53-00vhic; Wed, 19
 Jun 2019 21:56:28 +0200
Date:   Wed, 19 Jun 2019 21:56:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] t: add helper to convert object IDs to paths
In-Reply-To: <20190618165525.GN31952@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1906192155560.44@tvgsbejvaqbjf.bet>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net> <20190616185330.549436-2-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.1906172102180.44@tvgsbejvaqbjf.bet> <20190618012943.GB8877@genre.crustytoothpaste.net> <c9be7464-21f3-6651-500d-14137f0f1c0f@kdbg.org>
 <nycvar.QRO.7.76.6.1906181647480.44@tvgsbejvaqbjf.bet> <20190618165525.GN31952@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1979474959-1560974203=:44"
X-Provags-ID: V03:K1:Rs+7YKvH6myi6PEVVtgOE5p/AXA9Q10LrD/cg1wvTuBHKx8JmbZ
 LG1y95EJW9EHl5pZb4xR0FzayPQsnv/6UAjzSN3kJBaFZhYzzSwfhszIwJf4Lp1hCJ+cCuR
 DBIdL/MFNzZROyhRk/lKeMlppba5eCmJJt7hUklhKnaZJWgJvudVJF7j2E7N17YAKlaH4GH
 iDMucE18QfnfClMmYQvpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wITKD1ox5X8=:j1i+56cQcyW57RJhVw23v/
 IVAlGD2AY6o+KtkX/IOJEVnyqjZM62GTyeEt0YMOGEE/4Y1g+otdNoC1E0X2bxMjsnekJrvoa
 3DXOxsL6KGmui1MEqCZFleojaDRTN8XaPPduEXH6l7OzIyNCTgtR+jL1AeXua765ghycOugDH
 Url0YZy8qRqJUJoB+/kFXLYxF/ixRsqA9mxDfq4VUrf0LfnrDz250W5ezmO4c2kPlpTfJsAnx
 E7+Pe+ntDWgvS8fT/QkT355m0WGa1e/BMwV0CSsZFm7clcgZX7SUlE6GygVCtt7Z1DDNR4LtN
 u0xglbP6krLksgpVLnvqxEyHiuOcUzMUeL0RvGZ/SfIj+/fDjcvpTbnbcn7zpKJ7ScMbNJNIJ
 NF6ZoD1/dpM6SFn+dPKpm5pl5qjG52qRq7NuBlumGZalQ9i5jxIjwg9BVJhsMaC0twfbwu17v
 YS977GcbgjcRokIjI880zUePq8v+fNKPtJVYFX1giPeG7AEuWaka0oeTMTSfpZE4fnRBF9xL/
 DVri1SXnfs9jf0kHquZt3N+YEvV7BOoFJE+d7J2HFcVTQBhm34XT0v0T79B5uPvQZIUFr5pcR
 aomqlJOjHXyuNkXwg7UN/ldrvNlT2LDOGoSpHsxtNKcG5DvFJzSXMy6nHlFo7HrahLiKpBmKF
 7AxRmE5RRLlUMAwvzTpRWfz/uKCEGN2TQmWgXva+RGlyShaOMVEjmCeK9GqMP9aIpL9TkQcK8
 JJefJQ/JXo0nYvk7BsktZ1V864KhC9v1ACj22chN5KrTSXdZCLbJfT9WvEAyr6dM2PILhyiQX
 llAqYlY1oJsH23dXCcahOdQ0xvNhJ1J0J6tFHY24VWZlNjiqtYPggtpolxjeae5PDxjR34b2u
 NnNNzFnE1ay0mGPxXqwpN6GvSPlj1ouNfB6VVEznrAUk+H+vjWG667b9x6QGDtHanMlqtlBJX
 0Y56TIQS19O3LFpdI4Z/yYqj0/x5uxW7qoJLY9C0Fp/AEsSbGEZaB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1979474959-1560974203=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 18 Jun 2019, SZEDER G=C3=A1bor wrote:

> On Tue, Jun 18, 2019 at 06:15:46PM +0200, Johannes Schindelin wrote:
> > > Regardless of how it is implemented, I have another gripe with this
> > > helper: the way it must be used requires a process: $(test_out_to_pa=
th
> > > $foo)
> >
> > Indeed.
> >
> > > And looking through this patch series, I see a gazillion of *new*
> > > process substitutions $(test_something...) and $(basename $whatever)=
.
> > > Can't we do something about it?
> >
> > I wish there was. Unix shell scripting has not evolved much in the pas=
t,
> > what, 3 decades? So I don't really see a way to "pass variables by
> > reference" to shell functions, short of calling `eval` (which buys
> > preciously little as it _also_ has to spawn a new process [*1*]).
>
> > Footnote *1*: Theoretically, it could be a *ton* faster by using threa=
ds
> > on Windows. But threads are pretty much an afterthought on Unix/Linux,=
 so
> > no mainstream POSIX shell supports this. They all `fork()` to interpre=
t an
> > `eval` as far as I can tell.
>
> 'eval' doesn't fork().  It can't possibly fork(), because if it did,
> then any variables set in the eval-ed code snippet couldn't be visible
> outside the 'eval'.

Good point. My brain must have made a couple of incorrect associations
there.

Sorry,
Dscho

--8323328-1979474959-1560974203=:44--
