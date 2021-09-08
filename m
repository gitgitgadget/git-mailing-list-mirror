Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C0FC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AFE60F6C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245429AbhIHTMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:12:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:38211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235927AbhIHTMW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631128267;
        bh=m7gDqs4YeA8TitY6PKZ+kjqOE16oob7j6EC7dHNLkw4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c8wGUNmFOunZhV6DA10Ix31S7Lfzxh2EujIF8kSMmlqkodNmgpwlmVYi1A9W78wlD
         MtYFcsnmc9Zgui6DvqFC7Nmk2m+0BNqq0dNTlxxi1TvMEFCSnoSx5C9Hlg+sRRnt03
         HwhClf/zCJOwNI2J/+VbPZkoCLRtoGYTCSLjZLD0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKFk-1mFpVp2nh4-009T8S; Wed, 08
 Sep 2021 21:11:07 +0200
Date:   Wed, 8 Sep 2021 21:11:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 10/15] scalar: implement the `run` command
In-Reply-To: <xmqqk0jxft1p.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109082100180.55@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <c3f16bccd023601bb1d041c36cf5f49011abcb76.1630359290.git.gitgitgadget@gmail.com> <877dg2xbjp.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2109031747290.55@tvgsbejvaqbjf.bet>
 <xmqqk0jxft1p.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1395184817-1631128285=:55"
X-Provags-ID: V03:K1:zJpnmFLgtSC8aFDBGtA2uay4xGWXl5jVoGZ0nGJTJyMsunzJKGX
 qFB56FUGzr6o17WylxRlc9GQCt5LmtKE79fXsaY+eYzp/ZKY2ZJ2iD5phHANApVq1SDjD8H
 My5TYCZF8/+e6Lu+7wjoqkYwUhQGuoIDeGRXgmjVOqTtnSLkGFq3GHkSImSJTOtFmeWHqRN
 1P83gk+WIyX9Nvi8e3jIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:knHZpjwgTW0=:ZJpa+bTulBrTn+oAmSt7Vp
 SmvyIxfIYHE2+T4kTivOQb1mdqY3ytBl4zdAZxYlUBvXzZh+ohS6sYlgIPRAIRoCFSOo/lO0G
 JXA/MUNVD16AoGUm7Kr2rAl+CykKEKJZ2Z+UUHw8PuXCTIJTKXrkNxDQTmhP8QD6Y7B0/hXgA
 Sj0ptV05CMzyBPr6RmfywSM0YauZAyK7259viuDtFBr7HZWeVTO9QaHHr2GdNyOhnVHvneUmC
 OC1dccfmm9VBcdU1u/Hkhm71alM5GELa3WwV1BL4112IPHDLcy4uLwUaMvWVwOWqzywvzefnB
 qFhn0xvpA3i0T/6DDlauXasMjZNTsTXUSe+8yLIyjN9sKWr0JPeNl3XaFVXseCx9uwbG4MQFG
 eXvVUQ+jPRc06RgLvMXYNlRQ1yun80jZYGFaBQBpCfG3pje76NeLBjTX8gj5wfrTs2maiBZCl
 uDJ14zn7YiDbak9M7UrureyIbsYjJ2qlzc/PBcxAAshYJ0PFnOkuS0pEfVwRKLgKdEdRwX1FE
 zChVrlERS9CnI0Ds/PvvHJ+6Z3ATFc49G328LnWLD9LhKk4tJBX/3agMq9BoARwghmOmM3i4V
 q3oW4AVKvO6D66sz/f1iOC75JNnqwBLQfz1DPgTC/jRrHas1wiRYzZ42TzjBXdg5vmxsXD0PM
 9/fj59leT2ZpioL5QbgLRB1tahxWLvaDCq0rO/K87ahjQoi79NYLaF222RkdlYf1EJqDn/zcO
 CkJNxr9bHmd5oFQ7yU6wZ41DgG7jjjm/sRxrMWGEBPxAFMNJmhh1tWUwo6RGahqVg0uz6yfD8
 jvOWoP45n/OdOhSZjhEXle9ToGStwkfpZb5arj3nms482ZAhLMeMngl5rOhMS2XSdHqigfL8D
 Jeqx7bHwkBZ/GN5kPBtcC/HLjQ6is/Tou2zLnaBibeFVWcKQv8p0+EKjF9PyHGVUbOW+xnrMq
 CJkEmBByTJDjeBqxyXSVxzlqerNcmDIazQJTHOYdjTCdSHFTt8hEjiwzYv2apubH8f9odK8O7
 KFqmneteejl23HRVmp6EhQiiq0yD2xEpFBetBtYddeIdT5gytwnyo+5g0eoH2x3y7DJO5bRVx
 fosY0sb+EQwNO4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1395184817-1631128285=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 3 Sep 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi =C3=86var,
> >
> > On Tue, 31 Aug 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> On Mon, Aug 30 2021, Derrick Stolee via GitGitGadget wrote:
> >>
> >> > +	const char *usagestr[] =3D { NULL, NULL };
> >>
> >> Missing usage strings?
> >
> > This command will show a generated usage, i.e. a non-static string. It
> > therefore cannot be specified here already. See the `strbuf_*()` calls
> > populating `buf` and the `usagestr[0] =3D buf.buf;` assignment.
> >
> >> > +	if (argc =3D=3D 0)
> >>
> >> Style nit (per style guide): s/argc =3D=3D 0/!argc/g.
> >
> > It is true that we often do this, but in this instance it would be
> > misleading: `argc` is a counter, not a Boolean.
>
> That argument could be a plausible excuse to deviate from the style
> if it were
>
> 	if (argc =3D=3D 0)
> 		do no args case;
> 	else if (argc =3D=3D 1)
> 		do one arg case;
> 	else if (argc =3D=3D 2)
> 		do two args case;
> 	...
>
> Replacing the first one with "if (!argc)" may make it less readable.
>
> But I do not think the reasoning applies here
>
> 	if (argc =3D=3D 0)
> 		do a thing that applies only to no args case;
>
> without "else".  This is talking about "do we have any argument? Yes
> or no?" Boolean here.

Well, I offer a differing opinion. But you're right, we are at least
consistent in Git's source code in using `!i` where other projects would
use `i =3D=3D 0`, and consistency is definitely something I'd like to see =
more
in Git, not less.

So I changed it as you suggested.

>
> >> > +	if (!strcmp("all", argv[0]))
> >> > +		i =3D -1;
> >>
> >> Style nit (per style guide): missing braces here.
> >
> > The style guide specifically allows my preference to leave single-line
> > blocks without curlies.
>
> Actually, the exception goes the other way, no?
>
> We generally want to avoid such an unnecessary braces around a
> single statement block.  But when we have an else clause that has a
> block with multiple statements (hence braces are required), as an
> exception, the guide asks you to write braces around the body of the
> if side for consistency.

You're right. I am somehow still using the previous style where we
_required_ single-line blocks _not_ to have curly brackets (see e.g.
aa1c48df817 ([PATCH] ls-tree enhancements, 2005-04-15), the `else` part of
the added `if (! eltbuf)` block).

>
> When you only have just a couple of lines on the "else {}" side, I
> do not think it matters too much either way for readability, though.
> I cannot see the "else" side in the above clause, but IIRC it wasn't
> just a few lines, was it?

It depends what you count as "just a few lines". There are seven lines
enclosed within the curly brackets of the `else` block.

But as much as I enjoy thorough reviews of the Scalar code, I am failing
at getting excited about code style discussions, therefore I simply went
with your suggestion to enclose even the single-line block in curly
brackets.

Thanks,
Dscho

--8323328-1395184817-1631128285=:55--
