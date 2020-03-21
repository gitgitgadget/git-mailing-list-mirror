Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12C3C4332E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 10:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6055206F9
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 10:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="W6iO/ayn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgCUKxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 06:53:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:34051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbgCUKxi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 06:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584788011;
        bh=cGbjOQ+UUJRqy+e9/5ft0q1iJHM0DkJ9x/Q9O0UnN/k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W6iO/aynpD8eB3gegigsmne3pcT0eUpITZO6z0afNaZ0yOJ+5IJbBpREYnNltbocx
         M7hJh82AcuCX3wr/S6U9Sup9bMJ22lgFrDZkVowONtpmL6Yl9oggoz7yGALQR9GLqs
         slXgweFZSKGvUYo6EheasRDLC83KqMa/zWuZ7/kA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.14]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mt75H-1jYw5a24iX-00tVm2; Sat, 21 Mar 2020 11:53:31 +0100
Date:   Sat, 21 Mar 2020 11:53:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
In-Reply-To: <xmqq7dzebq4j.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003211152080.46@tvgsbejvaqbjf.bet>
References: <20200302230400.107428-1-emilyshaffer@google.com> <20200302230400.107428-3-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet> <20200319213902.GB45325@google.com> <xmqq8sjudirm.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2003202336390.46@tvgsbejvaqbjf.bet> <xmqq7dzebq4j.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ejl4aj1q2kUcoUhEXGunMlQ1kBy0Eijev+zAmwAbJdJv44UGN3c
 yHE29JX5mC9L6BFHhR89/RxWLgb3fVvqUTr6hRJf9M+nyX75mad7BGt4w4MkdtwfXtmS3KS
 6cozSsRep4VSwznNCl5+Hyhe2daJ4gPPh5YSV0LOTDpBpbl99ctnwGV3ucZX1nW6Sk+a+G0
 kyTdtdH82My0IS1YmT0Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DSmT1wZyO+0=:MLi1BK8wDnrCKbwJAENK34
 o57zfNO8ELSYp/8+gXGLXoASmZCZPLg2Hb258TzqWdvNauBKDU1yi/Mzshmq8tc3Nb20ip2+k
 KkUnpp2QdvERfvnBLgV+VwOmJg2O3fXaGlW0uknypuvfgqjXbB83WjgYxPSBabN/hEy/qUCst
 cXWkV2idY3v0sbB1sK/BOqSv0unoUFXHr/eGIBBg6cu7C72u565eAXVjMW6tK99g+jvkgdprT
 6e9H4mY9TEQXR+2Kww2TGnG4zrrplY4H0sQOZG6fI9HstOgy2MMf0YIx2FbYgZZcrbLTSQegf
 YFOJrzHlh3gI/0RhkWwotCprkHDi9b1KBJEIGNFYXwW82/RkrngLYgB0gxGNlTJAzGpC1tlkP
 5tJom/MGOV6ytTymO1Dammh4ksxx8JDNm3SIMoKOEFBGi+raEyD77JVuSU9y8oj4Gt6T5Om0F
 tXU5/y465UJ+sVs2JyXZfYnT7FPLDLSo+5jyXw9LxU3OULNmr7evF6FmBSM0a5tmIpz/Y69hK
 fr2Lij61YircQv9O/InlJlzDRofNTXPPLQ/IyhtlsS0szpDtQIU6/YUYLEOdhfXFnY/dN1dSd
 JFwSpsJf6nQKjF/DAQ3vBkUAkiAxG74wT0m5t84cYWv9N9321GdUeQ5RF3lKNawXggfIDpvx/
 0uXNWSNUfOZkBLIlIQq/mQf1yLwbu/PBaOQu6h5u6zeYtKuWOqLC6B6Sm43TPfhcaWIwv+JZb
 PHnTqMBfCg8onjimNaLm1H+atj0QsTZA6ocCEXzw8ZVLJN9xhrV5MHi/MJsm7FHinWqrhV/3Y
 x/cqaTozhHkgNl5I8OHhpQEZ2c2OlMUKC9CnPU9u0uZcCMhXI0lNKINNVq+rG9KDAJFtCO5LW
 WB2mik+ma4DpVLQEgc+dSldAot2IopPuUAEJZyxy35mb7PvXs8KYLEX1PLIOh2k6HOm+/8Pc+
 LXgM/Ke9sYz3ElSQ0UlM+T9hKLckzWEHZjzynMYl2h4Qqxj+eoO+UNMpccHFbGwBBE53SANrA
 Q5PgtPTfShKh2lBqEbaWTZ7EWwrMZ0lZvbfaeSmjBDuiw+ltnpzNo27/hKOTQZL51i7ciCKJr
 KiqvG8XNOLwd24Uqfic7LcNJSbEi7Jdsdf/VGm7WhGsogmtSTaK5WDAiIfq70r+5dricDlQRz
 ttzt2mOVjoHNxT76nJgw507Bg8cYJ3aGtv0FE0mYn7IDWbu192P8CXT4QU35fAxPFNeuYaEco
 PW4dWT2r+JsSzrfV5
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 20 Mar 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> I actually have a suspicion that "git bugreport" that is spawned via
> >> "git" wrapper is a bad idea (in other words, /usr/bin/git-bug that
> >> is totally standalone may be better).
> >
> > The obvious downside of `/usr/bin/git-bug`, of course, is that it has =
no
> > way to provide accurate data regarding, say, the cURL version in use.
>
> Sorry, but I do not see what's new in your argument this time.
>
> I thought we've already established that the best solution for the
> "accurate data regarding, say, the cURL version in use" is to use
> your earlier idea, i.e. give an interface to git-remote-curl so that
> "git bugreport" can ask it such details, because "git bugreport"
> that is known by git.c::cmd_main(), whether it is builtin or
> standalone, is *NOT* linked to the transport anyway.
>
> And the same interface can be used by an independent "git-bug", or
> even by the end user who is sitting at a terminal when asked by git
> developers "what version of curl library does your build link
> with?".

You are _asking_ for version mismatch here. If `git-bug` is a totally
standalone program, then it cannot rely at all on `git` to give it the
information it wants. Forward compatibility becomes another concern.

In other words, all the avoidably incurred complexity will come back to
make the entire `git bugreport` not worth all the effort Emily put into
it.

Ciao,
Dscho
