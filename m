Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9ED21FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 11:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754614AbdCILY1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 06:24:27 -0500
Received: from mout.gmx.net ([212.227.15.18]:53802 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753754AbdCILY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 06:24:26 -0500
Received: from virtualbox ([95.208.58.21]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LZzKf-1cOf7Q3BIz-00lpHv; Thu, 09
 Mar 2017 12:24:14 +0100
Date:   Thu, 9 Mar 2017 12:24:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Fix callsites of real_pathdup() that wanted it to
 die on error
In-Reply-To: <xmqq4lz331wb.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703091221440.3767@virtualbox>
References: <cover.1488987786.git.johannes.schindelin@gmx.de> <0c0abc667d9b8dff299aa61aeb29a7e9e7316b66.1488987786.git.johannes.schindelin@gmx.de> <81f1e30b-e0e1-d587-4a4b-4848beffd38c@web.de> <20170308183840.GA130604@google.com>
 <xmqq4lz331wb.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-263381736-1489058654=:3767"
X-Provags-ID: V03:K0:N5fDYHPjPMMEc86Xr9eCp1rDxGLU9SrBATAUJ2SywI1hIi+DlbC
 r/BsZcxWlrq69b00budDSE8BdWqTaM0OUFdg+/+0LOHw0bMsVHuj6NXcNWxhoAUo5zfCyKj
 sm8eVcWino+8GrzkqC3ZeRjmcYzW/zK4unt1x1Qm+fgdCH/mLxjQWqEpeD3eIYtFI2mUYtt
 Bc6G33d9sBfOVIf4KJcbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:in4bkjqgBW4=:yiexkU1d1acm9Dgn200LfK
 LDjvYK54peApLnjlRdtiXQdDsPdWORH1HnetlUfLUbWZR5oRTptgSrjHGru/b92FRcyXuWmaw
 lkdkC0sbe04UAWtVUwIzlM/Vz5yN9yui8PdtpThdeJf667T5Ij/nVAP7h/0Urf6MTMMXZezqH
 Z4ehCObh9ARJe6aV2SFomD421ichwqFS54m8Tr9n9wVjQZ5rVl8DwYdRhtXq4P5bSw9wdC5Pe
 8k2NBhePxJQ6OxeyLGTHbC9my0v6IDfVxav71ZTCtzDgiJS3Pqu8NbKbOQrG0JBmUoV4y1A2m
 BWFDhG274eF1DVmKbee7NDlZKaQ0emrJXGwPMxTnyggKuALfQ26nbsh2NPlZdJcLWNaMtCdLh
 RChJ/omgZc+KQsx+pT+8QmM9+aMjIgpndnW9qYOqMH6g6IQ+If98XfTJO8/pYflX9g4VQ8pv2
 hk9SuwhB8AimLUQFC4i7TDyWmFujRCVNbTpR33aGRLYDBMn6cumIf8VgljJ/J6gSXxxYVbmVO
 7dvzgjqGT2Nq8LVXow40S+B5ybDZhWKWlRZFBOVZehWU5cF+cx+PtJlnXrhFGOJemi9DyS7up
 pvuWKURPC/ipUS2sI1EXO+OKG9wy7fusTTtRCBosuG53l0vKbIK/qZhkZtC3XN8GSPfjUp7U/
 FP/z7vTvdVxQoxEIYNtJHpkVBFBt5I66BJ6HOoU3ZmIzZucHt0XvRfXWARVZS9SGgGfmrokoD
 yz7LEfllw9Jp8C8h9tebNdUH2yCZz2cis+cdhes53+/w7KRhBJU580Ls4L/OOAGOv+f3InDWl
 wswXN2L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-263381736-1489058654=:3767
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 8 Mar 2017, Junio C Hamano wrote:

> Brandon Williams <bmwill@google.com> writes:
>=20
> >> > diff --git a/abspath.c b/abspath.c
> >> > index 2f0c26e0e2c..b02e068aa34 100644
> >> > --- a/abspath.c
> >> > +++ b/abspath.c
> >> > @@ -214,12 +214,12 @@ const char *real_path_if_valid(const char *pat=
h)
> >> >  =09return strbuf_realpath(&realpath, path, 0);
> >> >  }
> >> > =20
> >> > -char *real_pathdup(const char *path)
> >> > +char *real_pathdup(const char *path, int die_on_error)
> >>=20
> >> Adding a gentle variant (with the current implementation) and making
> >> real_pathdup() die on error would be nicer, as it doesn't require
> >> callers to pass magic flag values.  Most cases use the dying variant,
> >> so such a patch would have to touch less places:
> >
> > I agree with Junio and Rene that a gentle version would make the api
> > slightly nicer (and more consistant with some of the other api's we
> > have in git).
> >
> > This is exactly what I should have done back when I originally made
> > the change.  Sorry for missing this!
>=20
> While I agree that the shape of the code Rene gave us here is what we
> would have liked to have in the original, it is a bit too late for that.
>=20
> As I already mentioned, as a regression fix patch, I find what Dscho
> posted more sensible, because it makes it obvious that all existing
> callsites were looked at while constructing the patch and more
> importantly, it forces somebody to look at all the new callers of the
> function that were added by the topics in flight, by changing the
> func-signature and forcing compilation failure.

While I would have agreed earlier that Ren=C3=A9's patch looks less intrusi=
ve,
I have to point out that there would not have been any possible regression
if the original patch had introduced the die_on_error parameter. It would
have made the contract *obvious*.

The nicer API made the contract unobvious, and that was the reason that
the bug could hide.

Ciao,
Johannes
--8323329-263381736-1489058654=:3767--
