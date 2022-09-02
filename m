Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668E4C54EE9
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 09:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiIBJrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 05:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiIBJrF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 05:47:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9250C696A
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662112021;
        bh=e/yM35KyDHRYSkvW4VbLuktJ+8B3kPCZXTRZjNZJLbs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=epf4QiL2GUuzjIxvMPxzIc97xcgX6d28lAcYsPHlXk91bB9PdAf6GcWwFDFDYA9SH
         3AsJkO1yLNDqorH08YWjJy+gR2wU6Gjc0TCjZjOc+2+Vw2cm7xBKqx3ccKeluL8+1N
         XIg4eTxwiDCB9BEX8myi5NupM0gcjw4SzOMIqqkE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oFz-1pH3PU29a9-00wjhz; Fri, 02
 Sep 2022 11:47:01 +0200
Date:   Fri, 2 Sep 2022 11:47:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, alexander.s.m@gmail.com
Subject: Re: [PATCH v2 1/1] diff.c: When appropriate, use utf8_strwidth()
In-Reply-To: <20220829175425.cmbwtqpxrq4ppnnk@tb-raspi4>
Message-ID: <8p9rs98o-o802-569o-n59r-07orq1690182@tzk.qr>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com> <20220827085007.20030-1-tboegi@web.de> <0q921n79-sr17-2794-83r0-r59rnqq03pp2@tzk.qr> <20220829175425.cmbwtqpxrq4ppnnk@tb-raspi4>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-371541868-1662111815=:189"
Content-ID: <8s0qs318-27oq-8816-4926-0sq4qr122o79@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:xjyHieaS7aKPauy9qyaSX4DKLgBR/UWYAXIvgOQE0KhRI81Rb0K
 kY/oO5qoqqMFcUrJnDi3G7qLYfBzg2dBNUvKNLKF6lGxxJa+W9xa+Z2BEIazNY0WB4hVR3l
 0i60QHqajKwnSwY4P60Uwt5SM5lm5hmyrojuaoSjoHzcDP/zYMIa3siDG7WkuuOJ5r8W3W9
 JG79twn+6jjvWICKJ1YqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MT3DXgvnLJw=:xxWlYWgl48KdZe6P47No2+
 OcdgLjJ41nTMNe04iTUivz1Ep3PZHddsiIwx/BgJk/3Rg7qAqviXgv+KyedfX4TSxrv1BBlRp
 uGwrMDZd5nql14PpYjDr7QPdYUGMMpfr6IzWVr7+GfSDBSA5s+5OHpU0cHiif5eKMW/utoRIv
 wztvgu7RxHodUo6F2gnuJre4d0HtUQ6GOuhDkraYyEI9OebUNCYZ6/1V1BV+FfRdhuvhBwEMO
 gNqFgOm8cRJZ4Tov6XDMknppwHTCDP/5+esEWJe4tqGpekUD7h52UkD6cJygDsE5M1VeETfJM
 nspqUm0MFg5p2kSIGjw4j8J1oXp+A52EeBmoB+h/Ga64BZT5ZOdg2pDKwh9Mq43MKjyUfmqqh
 NCteSEZhw1953O8L0jmtzaN92YbbHxWDcksXGCgbXiy5U2v9KXjEJx2l7LC/TBu54+6obOiQ0
 dJ5XlI5c/8ptQK2iX6ZBB754UmIornvvwWzORyKWfx75IyerWKgc7R3XvG6AbO5IfltD8us+G
 rPIxEdGib68B7O3/4WZjS2JG1JoVa/ea3H55U4/K2Yc5v1I8AAdJK8WLIpF4eF3MaCygFWTxo
 0vngDSsaM4oA32JuEFO0kOcc0bMOsADBb7LRdM60CDcDC/GKxpRkt9wI03PEWZH8PhKnCYtyV
 xw08DsgFOHMwGEogWz3a9BLD+hVJyJbznUN18w2mPMvQ/8Du+tKVfZiA/vvfN+4InxSLD9UAG
 O/CsLTBvfLqqcwypOGWRX5Hi4FiFg+m9vuHFpmMnMnq5J51pU3Z3GdshRdY+uV9mrmQydfqEf
 5Bep+AFSlZ6JGJXy2ocs/vm5qpGwAGCZZdpMoU8fbbBw/lUNlhr5a9ffon1Sa/q9AsOr1gg/2
 JWFQrW1t3vlgcZMOU1vj9cdkaxFpQpKPnURpKP+xcx64XQQ+W6AqmWE6HdAf1dYpuzPpfzKyV
 eBoo5aKfVpWlyyRIp7RN1PGOxRnN4X4KfJdLn5opoDGqfSYInVjDi/uMjgUsRI8EtZ7jop5hK
 FomIrhStx1rWcLbK/k6BXpXoHD7cUwck1NAEOT3o0ERhcrvvutlei7VI64oFfgR4P2fTOF1HW
 MtBVd/JfwjOFolvPc6JSp7SFH9p9aQiFD7RQ2bz5Loaqgtr0s8gPD4voTNNeDeK0ImaUFJXmf
 lRGIajjdO/ejqAWbsRl6+dZCMX
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-371541868-1662111815=:189
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <o7p98175-9nrn-761q-2o75-89r5q7nnrr67@tvgsbejvaqbjf.bet>

Hi Torsten,

On Mon, 29 Aug 2022, Torsten B=C3=B6gershausen wrote:

> On Mon, Aug 29, 2022 at 02:04:42PM +0200, Johannes Schindelin wrote:
> > >
> > > The choosen solution is to split code in diff.c like this
> > >
> > > strbuf_addf(&out, "%-*s", len, name);
> > >
> > > into something like this:
> > >
> > > size_t num_padding_spaces =3D 0;
> > > // [snip]
> > > if (len > utf8_strwidth(name))
> > >     num_padding_spaces =3D len - utf8_strwidth(name);
> > > strbuf_addf(&out, "%s", name);
> > > if (num_padding_spaces)
> > >     strbuf_addchars(&out, ' ', num_padding_spaces);
> >
> > ... this sounds like it would benefit from beinv refactored into a
> > separate function, e.g. `strbuf_add_padded(buf, utf8string)`, both for
> > readability as well as for self-documentation.
>
> Yes, but:
> All (tm) strbuf() functions use an unsigned size_t, and are not
> tolerant against passing 0 as "do nothing".

I am missing something, as this seems not to contradict the idea of
`strbuf_add_padded()`. Simply provide the desired width as a `size_t`,
compare the width of the actual added string, and if it is shorter, pad
with spaces. At no stage does this require a signed type, all involved
values are strictly non-negative.

> >
> > Also, it is unclear to me why we have to evaluate `utf8_strwidth()`
> > _twice_ and why we do not assign the result to a variable called `widt=
h`
> > and then have a conditional like
> >
> > 	if (width < len) /* pad to `len` columns */
> > 		strbuf_addchars(&out, ' ' , len - width);
> >
> > instead. That would sound more logical to me.
>
> This is caused by the logic in diff.c:
>   /*
>    * Find the longest filename and max number of changes
>    */
>    for (i =3D 0; (i < count) && (i < data->nr); i++) {
>        struct diffstat_file *file =3D data->files[i];
>        [snip]
>        len =3D utf8_strwidth(file->print_name);
>        if (max_width < len)
>           max_width =3D len;
> // and later
>     /*
>      * From here name_width is the width of the name area,
>      * and graph_width is the width of the graph area.
>      * max_change is used to scale graph properly.
>      */
>     for (i =3D 0; i < count; i++) {
>     /*
>      * "scale" the filename
>      */
>      // TB: Which means either shortening it with ...
>      // Or padding it, if needed, and here we need
>      // another
>      name_len =3D utf8_strwidth(name);

I was referring to this part of the commit message:

	if (len > utf8_strwidth(name))
		num_padding_spaces =3D len - utf8_strwidth(name);

Here, we evaluate `utf8_strwidth(name)`, compare it to `len`, and if the
former was smaller, we evaluate the same function call _again_.

What my feedback intended to suggest was to store the result and reuse it:

	name_width =3D utf8_strwidth(name);
	if (name_width < len)
		num_padding_spaces =3D len - name_width;

Ciao,
Dscho

--8323328-371541868-1662111815=:189--
