Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C151F461
	for <e@80x24.org>; Wed,  3 Jul 2019 19:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfGCTlY (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 15:41:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:46187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGCTlX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 15:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562182878;
        bh=Cap5RdVhBGHUTCH7QSy9q0530nIYpc5srvs4x/6YuhA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Hve/hiOmKVhr21+uI7hNCTvsTFNaBl4SSt1dKDJjRUwfwyWUgRcjSFdv0Qocs7ZH1
         4kqOv0RqM+xZnfCezJWN2BZYY8AdWoS4ajWKPkPSYykSA3P2oV/O2xHljohg1t5Mj6
         7oM786K58ld6ErDhqlUlJMtzY3g7AUrZiuDEaFcI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KUd-1ibkOa45Sz-016hSE; Wed, 03
 Jul 2019 21:41:18 +0200
Date:   Wed, 3 Jul 2019 21:41:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: enforce atomic in
 push_refs_with_push
In-Reply-To: <20190703185535.GC121233@google.com>
Message-ID: <nycvar.QRO.7.76.6.1907032137210.44@tvgsbejvaqbjf.bet>
References: <20190702005340.66615-1-emilyshaffer@google.com> <nycvar.QRO.7.76.6.1907021540330.48@tvgsbejvaqbjf.bet> <20190703185535.GC121233@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TmOCxFQVhbyD/M/gBdJBo3tuoSXnSTC24V6T4GUlPQfNyYPybkI
 /51WXblG/TJPLMFjxidp74zGGH2HUiwBg0beFo5cOAMHguGwACAf3cAGy3KKAYRxOsvA8uV
 iJTQs11t8Y1nJ8dXZsGmSyXwvb5oUwgtfSn/pzUC2VzCImwWqpYMTURlpVI+3r0zKRVaJ4R
 aU5pHiIwf96ls32E92Epw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JQcG4lQqLq4=:rMW/TCnCcwG7CgpEIsbynE
 ofyWgbQpcHRiMZt1gCbIiKRE7K8UErUZEThhvHI4wAAPLQ75whJGOnsUrlyH0IBjhVdU70O0D
 lKLqPWS5lOvW4gXcbXfkJCwN4LSclvgzZmviWkf7+/d2ZGncBtSYi42CfIacYvavQnmB+WsS4
 qY7J1Zh7wXOHGMwmTZ4CjHZOT5ll1SX0gxGHVeyOy6DCr3WGzdFMWts1Vgq+m6x6fhY0K83pw
 na2mb9ERYACtVDN9U4t45xxOe1p5oS19bPk7a962L61oQnX0YVTE+OfdSo/39zOT4XZYoKcfj
 5tKjudXvKt5A5LHSCr1Gmxj1eGwqgdYI7NEw32fIiSFjSoG6NHKdYi8atFwhE7PKh0lR31YXN
 iq5kxQWX+LhrL6aBmQdocRhtWpXwX3BEbXvgaGAb4bcaQ+4ZODwX7SwbBbpLn8OGuXW4q89gr
 KGFnkhpCXv5Cx5rcJXxMlBg6fmBOOwAhiG5njxQy+EOpvx/ncrwsPUHZtzmh5+rFwY3tq3VPl
 3hgptCVMVhdF7JqW5J38y9j2zoNXQ+GIuynq7LkGZxicKV9liWYvQp3z6xO8xAhqULv+Rap4p
 SOuq77iWujWW2y0dD8pddzlpPYPlP3fvN7hPYvcJZkjUMtu3p9Ca1TWMumlyx9wYIyhmYhdlv
 96/iLT1AteQORriK5UQ3xbKZnHdtf9C+1LaSQWJ1335LPtu6kwOQmkjmI6JrAHkCp4GIhANo4
 wlCu/9N5HWKywInjlJwJJhwOu7WFEtJpZa6DLJTrfsL/IeZgDx0XpdiVygCrxoI+9vOona5td
 Pp28Z/PisKdSec5Mz+epB7MaMJT+9ju8AESAw6PS5VlGm/Sr09Fi5DavaTsjCSvFio9HBPcr/
 z0jQ5w0x/7aUummuA8v+t8/oJnsbFpV4DLDPuBcS6uT63FOs0hAguYR3dmuds1Opkn8Vg7NP6
 z4xAf7gVKanqdOyxU2mw0UYxR2GKQDuyyQGnX6HnlapaUpS4fqpIEBVe8M2/qHxAFYP7/L+Az
 fFvEXkFTP40F0ZvqaxJmkmFR6aMHX7J5XtbeizjaAQsAPyqcD0HkeiJJFn2qxdu8dH369Ql7i
 bqlWeKN/1FJshXOL5g/fiQRaPXa0pNRYYA+
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, 3 Jul 2019, Emily Shaffer wrote:

> > > +	up=3D"$HTTPD_URL"/smart/atomic-branches.git &&
> > > +	test_commit atomic1 &&
> > > +	test_commit atomic2 &&
> > > +	git push "$up" master &&
> >
> > It would be more succinct to do a `git clone --bare . "$d"` here, inst=
ead
> > of a `git init --bare` and a `git push` no?
>
> I'm not sure I would say "more succinct." This leaves the test with the
> same number of lines,

No, it does not, as `git clone --bare . "$d"` does _both_ the initializing
and the object transfer.

It only saves one line, of course, but do keep in mind that anybody
running into any kind of regression with your test case needs to
understand what it does. And from experience I can tell you that reading
any test case longer than 5 lines is quite annoying when you actually
only care about fixing the regression, and not so much about the wonderful
story the test case tells.

So in a sense, I guess I would even suggest to move as much of the setup
for your test cases outside, preferably into an initial `setup` test case
that initializes the minimal scenario required by the regression test
case.

Thanks,
Dscho
