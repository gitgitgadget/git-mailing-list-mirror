Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69BBC433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB23561058
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbhICPvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 11:51:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:50149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235662AbhICPvK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 11:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630684206;
        bh=Etm6pJAN9N+5FJnWzRHPn9yqLZrFqAtduUurfgS0aB8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gwKbug24uK8fj/qAWeYX+aBWz8HpE6zmtESr78c1mxaD6E8C4w5Wa1LNLlVQUFr0H
         0Sg7T9e2zw7QQkWCtbaOO98lmkdJqJF9SpVtTLZ9hV6leugqqn7CLogXJ4BSSMnA4/
         HwHKeS21mDKfAvDLpO1hqvzP6478ugICAE1uycmU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1n4YpT1fsn-0101GN; Fri, 03
 Sep 2021 17:50:06 +0200
Date:   Fri, 3 Sep 2021 17:50:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 10/15] scalar: implement the `run` command
In-Reply-To: <877dg2xbjp.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109031747290.55@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <c3f16bccd023601bb1d041c36cf5f49011abcb76.1630359290.git.gitgitgadget@gmail.com> <877dg2xbjp.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1090042449-1630684217=:55"
X-Provags-ID: V03:K1:Yp6l4wqqfh8I9ic0XNTZ0RvSAvuHkyE0CvaohMlrGI2BO3vEE+I
 GSBAoHZ1sTMhNCBwfKCe9pVB4FleUjqNU0KyVfObthU+oM9dU0LwyenLe4lxJlNaruVGVlm
 xWWWGWz7aHzRQnKr8E27GK9ty7ybg6TtFAnK1krh8wqgN8E1X8teiyXFUsrP+uuvFGLfcjl
 Z7+iXdGxulhdXT6CYVU3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LYek29vBi5c=:h6SuVFEfaJz2QGQO+iGtsW
 m+jUYT5JOBxhjzz1iX/fMHjfOjqNiQ/1ROtY9SwxUXaWTjZjgOkkZNZiQ2WvQZbhBAAhTIzCO
 FOSMYaI9ufjxcA130xhnDqO2yUVfqOkS21+6ulFyqIplv7e5UbjvscGL9sVzzPr4uAC3AFmee
 dVQsxGpvHaNtFTT29OSNmodUqX5pEQ4Cn7ne3fwJr2WUzGhBLlxV8B0WC/petvLdIblU7jrrI
 y5W/V8JIIoL0zSLOCrBAf/RJa42tCf1ttrVrrmqUTyamHRjgQgnJG2BlwGvOhL9RetCzT1tB8
 lp3H9IeCwYj2zftG7mdBKImgv0Jc4SbxvykBvAEP3uvpWMdzYNu0Ww8SauS9inZTuMcPl7xaL
 HKv5QyFUMTgZiXE3n03iWLxvclobKD7NDM2zp3LRLqkw2Bc84O8/5TmEcKrrNTa2sazNc3BLA
 BdJq5g+0VOoK7UqSFefKMmdIsBBQnSfm7NfpIpLhfoACy3G6rNZJw3CTfGEJQ1jnq7pBUFk81
 e3V3UrctFUwvZOfvHPAVXvdAu48mhREkuCwvMFzxuMrEphb/y8wWvWlDdYzZD+TwbGfk3UShw
 GZys5mdkDX+gsWsxz6HxXjQFzUHbjobPK5UYqTo7XcLOjN08ra+BrJJpfKG/5jDcdZTm5vYU8
 keKpO7RsapHEY2Csf3I8mZsA3dp6me82chxp4qwQiqOL/FdDcqhShOJAEFSBe3vfoTRH2m3VN
 yASXmBuxGtOsF1IBPK2ww/3Al/dPGfN+x+cLBxXhWoNXFRqPRXCJaFreYbHvtYgaK2frgexWa
 nTKOQeOO6LfKF0de7EyxTK4OYU5f9OIAHqL4rr/Wyc5OB5Fdn5iF5o0SDlJV3z3xGgX/ROi6o
 ne5NAlWnzGoTY8KxLCgntdaXi+lG50ovP5wxLQPwRGkpl60Q+sb+DFozqaubW7C1//MUYKEmf
 vXul8fjtQwwDZ2PUOY9A9mTFGe8Fc6+bGmR3ktMqOIoeL+F/+gRfEp8WtunN/ga9fLOMzvAWN
 l7Wasrw/F+Y4wLSaNDXxFK5K6jwi7149CivuuvcI9IJ/A28tlCMbdT+IlGe5iTOa9iafmu6gp
 spfnhXzKN6z4C4p+L66TgI+BvbeDzefU0UA9sUSrJ6SoqCk2ys/oBBKcg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1090042449-1630684217=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 31 Aug 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Aug 30 2021, Derrick Stolee via GitGitGadget wrote:
>
> > +	const char *usagestr[] =3D { NULL, NULL };
>
> Missing usage strings?

This command will show a generated usage, i.e. a non-static string. It
therefore cannot be specified here already. See the `strbuf_*()` calls
populating `buf` and the `usagestr[0] =3D buf.buf;` assignment.

> > +	if (argc =3D=3D 0)
>
> Style nit (per style guide): s/argc =3D=3D 0/!argc/g.

It is true that we often do this, but in this instance it would be
misleading: `argc` is a counter, not a Boolean.

> > +	if (!strcmp("all", argv[0]))
> > +		i =3D -1;
>
> Style nit (per style guide): missing braces here.

The style guide specifically allows my preference to leave single-line
blocks without curlies.

Ciao,
Johannes

--8323328-1090042449-1630684217=:55--
