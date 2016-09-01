Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C81141F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 14:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753985AbcIAOVE (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 10:21:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:59015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbcIAOVD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 10:21:03 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M2t0Q-1aqWxw32Bi-00sd5b; Thu, 01 Sep 2016 16:20:50
 +0200
Date:   Thu, 1 Sep 2016 16:20:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 22/22] sequencer: refactor write_message()
In-Reply-To: <4c0ee8f6-1302-1dcc-602d-7a84150ec39d@gmail.com>
Message-ID: <alpine.DEB.2.20.1609011619220.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cb4253698ae3eca066c031e0aec4e83ede1fa3e5.1472457609.git.johannes.schindelin@gmx.de> <4c0ee8f6-1302-1dcc-602d-7a84150ec39d@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1172302886-1472739650=:129229"
X-Provags-ID: V03:K0:wZviFDZwmNvyvKJlgvz57oZ515YA/mMyMUQn6WNkxtMCPZ2Vsul
 ztr+aj/CtjPa4KOJciV9I158DJqC+KnbouX3q6DMf1YCRLu1gNk/qYcEPdSOP9rggPcrdjU
 5OuCLneB3EfAvBh0bLkm6X2q+GVx4CM7uKBidLlJAWZ7Q3K7YPFgJ0qMsm2i0T8PQxsvCYV
 D8uUX8aQcIHw+n3DUMoSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2q70oeaVtxQ=:FgiOIC0T4L811DkNT0FyoU
 HkCNOUUrTUML4bsp61BgezBvhdvYYy86T/2osHq14ZVKULfmRF9O1p4ckdLt7cpr/xKBgoX7L
 RrB8uszF2OBkqcJA8d5y8vDUKnl/rh7tOe1METjt6s7HBQ5niDSMXDzsbQoqei+7k473IlXaI
 HzsMi8xhJ6mGyMXE2gRIUhH+ssE6elZG9IjRoBk4HBD/waxeDr8HLScc+B64oIJCLUIwGm0g+
 IvGR4HVkDJV4R3UX4nH3G3hg+dfkA1znzKy9wZTC1R52HtCinHPKkH3Nf6nNG04Wy7eXKRTjS
 PG3hfikfHgbthf8n7+J4t9Rt8Pydi2B8nc65CjLdDWTo6rlvR7Sku9Ax+2P0HMa60xIt95qRF
 c1X+bJbPVdwNZMVtcP7Fv14kCFfH9l1tmlEFibfo7gffkz1LSOepEMWb7791tMdWeR8QsYp22
 mKY34srAdGhc+dfTENML6fDog09IbemOP/oXrmZMJhfV3AxHz+rW9++MnP3nYXIysu4acCZU3
 3eQtnmtnirw1kApBm4eTHu8NzoRgcSgbeCJ6nA3foNYY6/TRlTNacRexICj8/QCTjWkzRPurJ
 mg7PL534Nn2DQ4s36jHwX+ZV9NF5XYUwSiStlODqPQBIcVpMgLyzVWeWcbc/nE6bhyYYVwH+s
 FlwdbHi0pRxg/t8QP47aP2tg12E5+HWe1uqsfrtjgW0lU0rdYFkrtFxab5TxqEDP0bfB5xzA1
 uRpl7NQCF+YBweW99nxB9x33AWPsTCgDoqVnzOrfDB0w0hRN4qSTnXd9nFe5bO1bKMADOuaWY
 WBC8z+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1172302886-1472739650=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Thu, 1 Sep 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:
>=20
> > The write_message() function safely writes an strbuf to a file.
> > Sometimes this is inconvenient, though: the text to be written may not
> > be stored in a strbuf, or the strbuf should not be released after
> > writing.
>=20
> By "this" you mean "using strbuf", isn't it?  It is not very obvious,
> and I think it would be better to say it explicitly.

Rephrased.

> > Let's allow for such use cases by refactoring write_message() to allow
> > for a convenience function write_file_gently(). As some of the
> > upcoming callers of that new function will want to append a newline
> > character, let's just add a flag for that, too.
>=20
> This paragraph feels a bit convoluted.
>=20
> As I understand it, you refactor "safely writing string to a file"
> into write_with_lock_file(), and make write_message() use it.  The
> new function makes it easy to create new convenience function=20
> write_file_gently(); as some of the upcoming callers of this new
> function would want to append a newline character, add a flag for
> it in write_file_gently(), and thus in write_with_lock_file().
>=20
> Isn't it better / easier to understand?

I don't know, but I took it.

> > diff --git a/sequencer.c b/sequencer.c
> > index 5efed2e..f5b5e5e 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -239,22 +239,37 @@ static void print_advice(int show_hint, struct re=
play_opts *opts)
> >  =09}
> >  }
> > =20
> > -static int write_message(struct strbuf *msgbuf, const char *filename)
> > +static int write_with_lock_file(const char *filename,
> > +=09=09=09=09const void *buf, size_t len, int append_eol)
> >  {
> >  =09static struct lock_file msg_file;
> > =20
> >  =09int msg_fd =3D hold_lock_file_for_update(&msg_file, filename, 0);
> >  =09if (msg_fd < 0)
> >  =09=09return error_errno(_("Could not lock '%s'"), filename);
> > -=09if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
> > +=09if (write_in_full(msg_fd, buf, len) < 0)
> >  =09=09return error_errno(_("Could not write to %s"), filename);
>=20
> You could have, for consistency, add quotes around filename (see previous
> error_errno callsite), *while at it*:
>=20
>   =09=09return error_errno(_("Could not write to '%s'"), filename);

Done.

> > -=09strbuf_release(msgbuf);
> > +=09if (append_eol && write(msg_fd, "\n", 1) < 0)
> > +=09=09return error_errno(_("Could not write eol to %s"), filename);
>=20
> Same here, and it wouldn't even be 'while at it'

Done.

>   +=09=09return error_errno(_("Could not write eol to '%s'"), filename);
>=20
>=20
> >  =09if (commit_lock_file(&msg_file) < 0)
> >  =09=09return error(_("Error wrapping up %s."), filename);
>=20
> Another "while at it"... though the one that can be safely postponed
> (well, the make message easier to understand part, not the quote
> filename part):
>=20
>   =09=09return error(_("Error wrapping up writing to '%s'."), filename);

As I inherited this message, I'll keep it.

> And thus we got to the last patch in this series.  I have skipped
> patches that already got reviewed; are there some that you would
> like to have second review of?  Is there patch series that needs
> to be applied earlier that needs a review?

Thank you for your review!
Dscho
--8323329-1172302886-1472739650=:129229--
