Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2010B20248
	for <e@80x24.org>; Mon, 15 Apr 2019 12:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfDOMyv (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 08:54:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:37489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfDOMyu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 08:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555332885;
        bh=0/diU+HtL8WbrEvUJO//+qCt2YGLHe2KvnSJ1g0jtKs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Zliy46aNx6LSeJiICujcV15cSp57g3Rc60EP5YE39V5xqETAhZs4uNR5jw2sSWKwu
         EefwTxUOey4UUoU4YLGGKXbglZlQ1J4yHvNv3LfpvENiJ5Gcfjf5pEQ6bpnu59JVY9
         eWczSLP446iDIMFlAFL01QhHQXE3H2veLvyrPB/A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsCAp-1grYyI1ww3-013u69; Mon, 15
 Apr 2019 14:54:45 +0200
Date:   Mon, 15 Apr 2019 14:54:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/4] range-diff: don't remove funcname from inner
 diff
In-Reply-To: <CAPig+cSmh1rCTPj0Y=G4OA3TmoGqVBnj95S+KogOgiDtW_0DiQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904151454010.44@tvgsbejvaqbjf.bet>
References: <20190411220532.GG32487@hank.intra.tgummerer.com> <20190414210933.20875-1-t.gummerer@gmail.com> <20190414210933.20875-3-t.gummerer@gmail.com> <CAPig+cSmh1rCTPj0Y=G4OA3TmoGqVBnj95S+KogOgiDtW_0DiQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kLxUKYxWzEpAAoBGFLbkGFONrumCO56bXMbKJUGvBPkaBPAkzDx
 bGcp7uTkc7Cj9fQl8NcsIWkXvWxdHhA2FEgsKMLFcNfOn2DOIAEzNSl9vn6KM+UTBZvSIAG
 UOwkf5jhlMMPnB3eQ1b0LJveJrWqPUCbh5yalNbitYmtX+iheHy69xOgybUJQ/0Bjm/3wFG
 L8LDg4/TqPotX5jjzM0fQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/QnLqqgXvmk=:VgYVRF53G3BRgV869tBx8t
 IOMpbbLNdtcOLyrj1Atnw3ZdViqNMjfwrC9+V04ZygZULXjBWFwswK+7n2W4aoousutNmgO+T
 +4lYRJD3ZEGqRC4mJDPtPrRmOZOWURMM+03zVSowq0KeSXS0Mhqh0jGsTHPAYtadaNLbZy2D1
 W9QmP86ReZikKUsHXl92ZvL7QFANiIAEZ+Y+svfft+f2Uj5gXvKHNXOptLXTzYCBS+NNc+RiC
 4SM7Yp1Ua51MykRns8VjFh+xlplortXh+BTDTxqMDp+nGcAB9AZBlZPP0F3akDgFL6IIohQDw
 kFngt2073/w2O12x0JulbacVlJXl+MfAa+wOat67jfZmTS/gZgfPJPpysixbe4xJtaao6VuQO
 yPQhdS0ByMspEaHswVAkf57wMTtqo8qVIVF+sSmmKxewF9hE3L3cq+zcg8dCzdzHnisMqrHzJ
 DNErbvnv0sp8PunqFEVSfpoeqhqLeYtwgLjcYYhqewpo/S+Y7lXgxw/Xf8qebl4eG2vM/bDkT
 QvvWRUEMUonUdF7RpudRKNwNINWGfVBzIk1CrDs7qfGTbvSILbW7aCESROq1gunOe8ZmfXlz6
 Ri7iVfioe5zLr46KmnHr6QMB0xie9nhV6vztreDoeaufXZCRgtQUxtJLSVDA9sQBJi0s9159E
 YDSxy31Jk0nmHmyQnTUU8Y8Ict++EjjH+GQuHR+FwvCwvLOGdzmkyYQLQrrl42Z66zRqDEwEq
 xKZka0S3QRvs8TTYq1wJerGH7+SK0avvB4oGnm4SgG7K4igWBerqLkE04em3r1whBUWxK6JOo
 c9yxQ0+Z1ysnN6kO/qHlwGAvyMzO6Q54zo+moJkrwjwp6lxbjy6ynDbpDlkBXWf7QhKUYQjhw
 kiGhjfmqctUs/sPa7+BDDxI1IBtbqchMteiDDlV0WXpeN17RtBYbFf4A1wTEZis05fpS0OZaZ
 yw2vIRvp+pA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sun, 14 Apr 2019, Eric Sunshine wrote:

> On Sun, Apr 14, 2019 at 5:09 PM Thomas Gummerer <t.gummerer@gmail.com> w=
rote:
> > [...]
> > However it can still be useful to have the function name that 'git
> > diff' extracts as additional context for the change.
> > [...]
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > diff --git a/range-diff.c b/range-diff.c
> > @@ -102,9 +102,12 @@ static int read_patches(const char *range, struct=
 string_list *list)
> > +               } else if (starts_with(line.buf, "@@ ")) {
> > +                       char *skip_lineno =3D strstr(line.buf + 3, "@@=
");
> > +                       strbuf_remove(&line, 0, skip_lineno - line.buf=
);
>
> It makes me a bit uncomfortable that this is not checking for NULL
> return from strstr() before doing pointer arithmetic (even though the
> input is presumably machine-generated).
>
>     if (!skip_lineno)
>         BUG(...);

Good point, but maybe we should not go so far as to declare this a bug,
and fall back to removing everything bug the initial two `at` characters
instead?

Thanks,
Dscho

>
> might be appropriate.
>
> > +                       strbuf_addch(&buf, ' ');
> > +                       strbuf_addbuf(&buf, &line);
>
