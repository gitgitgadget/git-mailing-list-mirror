Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71344C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 13:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1116C2065D
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 13:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iOOaMSD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbgKINdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 08:33:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:48241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730192AbgKINdk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 08:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604928808;
        bh=RgqMDz7I+XI9/IiQ9nFvQlZ0vdJhzNOw+R+lDnwlLIM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iOOaMSD7Q9Yr/T9at4dNCLArv4BPLYbnH0QMwKhdRA5YKCRyFGgmo2Fc/Ac/qR6dW
         P88FtlSQlzFrkwJU/oPf2KJIlrNJTQhPhGfgqqigpzKL+IJoAxI5nnqc2pw8IR2hpM
         3Lk6c06BRqy/dLw7UHgeFn1B8+27+OOmuUkjqLRE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49lJ-1kBXvF0T5t-0107N4; Mon, 09
 Nov 2020 14:33:28 +0100
Date:   Mon, 9 Nov 2020 14:33:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/2] rev-parse options for absolute or relative
 paths
In-Reply-To: <20201009191511.267461-1-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2011091432380.18437@tvgsbejvaqbjf.bet>
References: <20201009191511.267461-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DuDi9jLWIxSKdVX3Y8TJarSgewr8ce6wb9RCwOSmH40aA9xx9H+
 ZY9trLfU70RrD6Mp0hCINn7NkgK19WMBd4MMXgoLB1saQ9KPSr03iGSs8Ygo7A0oo7v2kI8
 1yYO2l7SgUjsLj/gwK2xNQJKdS+71qe6FrPdp5jl2+XZnyfOP9n1A6/3Yv2FKzyUWqRXxvI
 FlrM2kqXOLNHS43WVL5kQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hfkhMv8HISk=:1Tth65BdzzLZfD2JfTILnx
 YTDuc6gnBFu444a9vaFMdvAoM0MZqduv1XEpEp2BNXi2Hr/dTBzYkVTqGaAHCV4p7RsGCNrgT
 INS8eoQ2tWXc1lNA9EY+zFId4nXwtwbHB1mShTx1J2HQzHQ3+GX7FTpekDC8JC+73ficKzdDe
 VzXwim4YW4oUcAaFckvrvmx+VFZQTZvC1HZo4eP0FKvWVoJE+YTR1GIOUCS5PhSd5Ugq4+0lH
 +DT0HhtvbrTLVEOuzwBExQDjVw048QWmFa/obIaGEsN7QTZUB6SWir5duq1goGSe5GC9Rs5wT
 nED8dvfPx7KBv8G8wJfelFIoJiAbFdrr3hBbyV6k81j+wZjwBDZMBM+lugVbYZHM91COUlts3
 QwNK86UlkUEYap5GuLPw/i7ATj4Qiy1n6lC6R9KkbaP7jt4BucjVoAKESkJDEw22zlI5f2WXL
 NQbUd/K6QbCV/fcrr+jQ2b6EY8mijXMNB0/nYfCLrrrJoiZ89MDbhUS4tsaykEF5Qpw3sIrLl
 IdL7XGdOIxZV0dKrjs1vXLjNJ7cCY3B/sWrEJru4iyyA7NzqbSxmL8YxIGKMWypFnWx/GwHxx
 pl67rdEvdEJURuVPQfnmPQQdeQTH1SGh28OZPF3oLHZBU1EKFo6/vITen5vmtr+3lO5ZT3g/A
 xpXM4V81iBXV552747HnWCmlUqA8+x91IT5IpNo7b9PSu6cQRPUQzhQgJZVipulnp58b6QfG4
 S7+ENs8rpTC4+v2OSvSbJ41SjFQ8vpNzaET7J3Dwm1SSu3B7NVAlKsjJmaXbb18NOpcB24MJA
 qJ8Imq9e046jlzYqP+xHXw5MqkbYxHvydwnFdlhUXdHLt4H4+ABy3rv5CeGH/aGULczlcE+te
 D4Oqu20T8XHcBfRwtG+ZWVW/h9LIziQoJpPhLlLiU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Fri, 9 Oct 2020, brian m. carlson wrote:

> There are a bunch of different situations in which one would like to
> have an absolute and canonical or a relative path from Git.  In many of
> these cases, these values are already available from git rev-parse, but
> some values only come in one form or another.
>
> Many operating systems, such as macOS, lack a built-in realpath command
> that can canonicalize paths properly, and additionally some programming
> languages, like Go, currently do as well.  It's therefore helpful for us
> to provide a generic way to request that a path is fully canonicalized
> before using it.  Since users may wish for a relative path, we can
> provide one of those as well.

I am very much in favor of this patch series' goal. Windows also does not
_really_ have anything in the way of `realpath`. Besides, it would be good
to have a way to ask _Git_ what it's idea of the real path is (no
guessing!).

Thanks,
Dscho
