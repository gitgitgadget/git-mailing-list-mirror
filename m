Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD841F454
	for <e@80x24.org>; Thu,  7 Nov 2019 12:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbfKGMtv (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 07:49:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:59369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388206AbfKGMtu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 07:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573130986;
        bh=RA9edPL4eELhPaTQyNk3bXbl/2Exh8wn/l6pY43hMEE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MOHWhplZAqICteuHyZaTugechYlEXjNRlTKS6TkxWTV12YLLApZ+Q7RrmrCKOhHHE
         WVXzHd46E6ZyRGygrEHRFB8nCbEDbmbtivTV1GXrQq6EZ193IqkbHaWTJ9IXM1IMrR
         6WPvdZx+vm40mLRBu1BzHy8teb/IxCu0nvtV18wI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacOQ-1hwOLg0tyc-00cDas; Thu, 07
 Nov 2019 13:49:46 +0100
Date:   Thu, 7 Nov 2019 13:49:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Danh Doan <congdanhqx@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 31/32] commit-graph.c: fix code that could convert the
 result of an integer multiplication to a larger type
In-Reply-To: <20191107040605.GA8096@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.1911071345440.46@tvgsbejvaqbjf.bet>
References: <20191104095923.116086-1-gitter.spiros@gmail.com> <20191104095923.116086-2-gitter.spiros@gmail.com> <xmqq7e4dwxob.fsf@gitster-ct.c.googlers.com> <20191107022347.GE6351@danh.dev> <xmqqtv7gs6g3.fsf@gitster-ct.c.googlers.com>
 <20191107040605.GA8096@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0xbfu00S06bOYxY6DzmcBeRKQa2UMaaGG7mMi4DujMqYK0T/UY6
 GYHGjZ1+ltaBkSUcbYkY1spaKdso07y3FejjFN6TdW3FdGOqgYU0ytj2L4NfwWIVBX6x/8E
 fmEsJvegRE3BDme9XvwhqxB4Wce3cnaHuzuvJT6tr9VcrsOI1xemJHV6QfwXt/sG/+J3Rtk
 sddaspdobsK5lWUD+YUPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fYhYf2bLFD0=:SheSfXd3AwIrhlEZilLISQ
 ruArmKaLhNm/gwdfR633z3UXc8QbAWO/3Zqw0LtLuZKLEi+my5eoEWUUsX5fwpRuXxlUkqdmZ
 Xx8Gys8j5tUHhch37ydqN/YqUZ2nsQDHd4ajty5mn1jzMNMz7/3MWiboiFr1cCXXa/Z16Wmtr
 dUqDg74BXvQvxdMlBLsxUVMlMBYAr1SbIsrH0hGA++0rNXryZcdOy8OOFz3HnZryu46WA2Oia
 WGqYp4orDjw64a0GdyLKj5iOLI/f95uLBzGXHsI1ApLY/uJ55wJr257bU2O/1dOYV6/7IilXX
 Geyf2SXUZjn8uz5X3Y66haM7JvaKab/9YJr6poNlQojLFi+wUqzpeZ3kEx1HLS2liiS0GJ3Ne
 bSMZjmXvlWMr6PdeV9dgHHhkg3ghBpAoE7S2LEVNt5/imxnIfyL/X8Junlal8POLIB4RV2rof
 f7NtGmoEuTivFaolRG6SSZ1nhnlVtMoLIik6j6jBmFGjRvccx9Rp+09i4s3a59e8LLnb3IGgw
 i0Srkb0BsvwYoQNhWcZOP8vh0tEtmZP428R5uYwf9T7rCO8IQUJYU/RbCBWEYO2RNl9eAoi5u
 4x17MNUickadx0oC66NNzCCjtB9ZxtT/fqgTlC7Nd53Lf1Q7csioY9achLF2gJcEVkWuT9Xlk
 wyJ2kpEu962ne8rdpKe/jKT3BTYB34JprQKhAYrXm/udFOcPw3Mc719W6su0xf2uOSX2lkedC
 L/TeYuRZCV41LAafP3l4d56wy1sxJxPLG0cPvr/xjsbvfk386sE+Qm7qLVBUsArQeyNuoycDU
 fnC11qUaofZdrv44xuw8SZBBEPEN4s3f3gzevQQPf1USIfN4xb5lFVvyXflcEYxhjqTBPAGlV
 g4Aabm/4gcgi+vV9cAggmPVxCBt1lM12h25Uo3QpGAtg+AG4zV9+yTRmMa4ouZOX4Onvl+/e0
 dCJcWeeS58mMhOmt8+eaqE1FHtMrt+6Vo2XRIYKfIsdkfuZZW08sS5G5MCWYCu/+c64L1rDwE
 8YmjEd1fizmc9PoiPQeT/CbQJ2dYkjtpF98OPPFayL5ArkteIeYRJisi8leyqDVfUUpnBM1S7
 KAzmor62YcJeW/0CyivPUeOVa7hYDYzg7gjv/BMjHyRehZuN3v15eDBbBS8auQQh/kw/BnSVo
 GpKv3mCeF1xtvsn0iNGvEmmzfDeJLGTBLWngZsfhvWI29P3mItjfzl8d7oq5iJEjlbc74TYlA
 UZyqU566HWE2z0ObFhk/m7runfiC/LqBzcf1+30yDKVfWsEKYsXm4ChaH2p0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

On Thu, 7 Nov 2019, Danh Doan wrote:

> On 2019-11-07 12:37:00 +0900, Junio C Hamano wrote:
> > Danh Doan <congdanhqx@gmail.com> writes:
> >
> > > On 2019-11-06 11:23:00 +0900, Junio C Hamano wrote:
> > >> > @@ -1454,7 +1454,7 @@ static int write_commit_graph_file(struct w=
rite_commit_graph_context *ctx)
> > >> >  			    num_chunks);
> > >> >  		ctx->progress =3D start_delayed_progress(
> > >> >  			progress_title.buf,
> > >> > -			num_chunks * ctx->commits.nr);
> > >> > +			(uint64_t)num_chunks * ctx->commits.nr);
> > >>
> > >> Hmph, do we need this?  I understand that the second parameter to
> > >> the callee is u64, so the caller needs to come up with u64 without
> > >> overflow, but doesn't that automatically get promoted?
> > >
> > > Neither num_chunks nor ctx->commits.nr is promoted because both of
> > > them are int. The result of `num_chunks * ctx->commits.nr' will be i=
nt
> > > and will be promoted to u64 to pass to caller.
> >
> > Ah, yes.  Thanks.
> >
> > The commit title is about "integer multiplication", but can the same
> > issue arise with addition and subtraction as well, by the way?
>
> Yes, the same issue will arise with all binary (and ternary) arithmetic =
operators
> (+, -, *, /, %, ^, &, |, <<, >> and ?:).
>
> IIRC, gcc doesn't have any warning for this kind of issue.
>
> Microsoft Visual Studio (2017+) has C26451 for this.
> https://docs.microsoft.com/en-us/visualstudio/code-quality/c26451?view=
=3Dvs-2017
> If our friends at Microsoft could help, we can check the remaining one
> in our codebase.

I am a bit busy right now, but it _was_ my hope that adding a Visual
Studio job to our Azure Pipeline would enable everybody to perform tests
like this one.

In other words, I _think_ that you can add something like

	#pragma warning(enable: 26451)

to `compat/msvc.h` and then open a PR at https://github.com/git/git, the
Azure Pipeline should produce precisely what you want.

(If I were you, I would also try to save some CO2 by ripping out all
jobs except the `vs_build` one from `azure-pipelines.yml`.)

Ciao,
Dscho
