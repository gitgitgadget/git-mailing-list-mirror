Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D23501F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbcIIOkv (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:40:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:60777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbcIIOku (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:40:50 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LeiJ8-1bGEUd3OQg-00qUvE; Fri, 09 Sep 2016 16:40:45
 +0200
Date:   Fri, 9 Sep 2016 16:40:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 22/22] sequencer: refactor write_message()
In-Reply-To: <dbc1b08c-a151-29ab-a5a2-45343ca556d6@gmail.com>
Message-ID: <alpine.DEB.2.20.1609091639430.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cb4253698ae3eca066c031e0aec4e83ede1fa3e5.1472457609.git.johannes.schindelin@gmx.de> <4c0ee8f6-1302-1dcc-602d-7a84150ec39d@gmail.com> <alpine.DEB.2.20.1609011619220.129229@virtualbox>
 <dbc1b08c-a151-29ab-a5a2-45343ca556d6@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-116441008-1473432045=:129229"
X-Provags-ID: V03:K0:KIL3SFHNlXg+Wjw/EJBQBrzUKErPwSjFhJ7mxlAsNRSIv0GQfNX
 luQ3UkOlavlaFl9sHvQc4MUr0ujIsL5VzICMbXZ/Tat+OG6ll1T8/Dw+g+qHRLuD3G5g50Y
 y0uAM4xPy8ZZxOJk1i7RDcrBDZ4O/DH0iYy+xna4y4qBfvknmNwRTQFoS+W0xR56qv4RK1l
 AEjHNWKinTGTq85k7lTOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:15ilF8zsQOM=:gyWMwEWZ0mZvB9lyXVSoNU
 Runsg1ucTklS3s8WpLPRIWFS1Sg5GeDViMx+TzU1A+nYrrfzLRW9UTCdei8XVFAUs2xdYKZg8
 ZunqkdRTcAXRsQHSYeNPLkXh6sKf6WXJiKiwMtchPYvCp6uLcxtf0VRWokZZXnhn0VRHtjPK1
 araBuQN0wREf+mG4iSFoiJsuqqcQkONSX8KBo1IEa3UIM2jb+leGu7+OGunPP07Ih5m2w5IkF
 mC/1BZcCgvspau4inYY91bomnV93tX052cw6nT953NH/BSuirXHWCmv4goqEy+IQrrtJQSBpA
 QYMWMlskQq/Y7cfrROkNi6Iw4DBsVGcz4FFZMCirCed5SfIKr1ReanjH1H8GuzPEm95YhF6Qe
 gqbN71D/6O2ByLlMFs6Wm6qBm/eu1A8r1nh4NCafn0fN0MrwY+jQXCDDr7fYxFKgWxJMkM5ut
 c1h6+rez4wWcRPkk0QV2fh35mKXAfLWXfvdMhnAXV49cTR9lozeiQODAawU1xtuEfVKMXZpY2
 TQJPSAziUpfazE9reYS4JHvGn3UFfjdXxiYeyCllAbr29Xd40v8iy27o5nCqVdgDpBBKhvyNs
 GH5M69eC+aY359BE65QRPZ0eQd5nwCY9rAWlDk2uOEK/bQTfDs8HL/95C+qRL010g660FipjU
 0GgEgVRwAqsNHClzW3JWgbQoWD81FVpTleZtchHRQ2Oky8gEzTir3ucH3aXHjgHcPozQ1f/a+
 t1zyQ3tZ/6iRMj31K6k1RQs+b1sakORbXiSuli3RYyAgpIQn4zk42ZsjW+mZscZ2ERz54e/CM
 Pe7MVHy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-116441008-1473432045=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Fri, 2 Sep 2016, Jakub Nar=C4=99bski wrote:

> W dniu 01.09.2016 o 16:20, Johannes Schindelin pisze:
> > On Thu, 1 Sep 2016, Jakub Nar=C4=99bski wrote:=20
> >> W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:
>=20
> >>>  =09if (commit_lock_file(&msg_file) < 0)
> >>>  =09=09return error(_("Error wrapping up %s."), filename);
> >>
> >> Another "while at it"... though the one that can be safely postponed
> >> (well, the make message easier to understand part, not the quote
> >> filename part):
> >>
> >>   =09=09return error(_("Error wrapping up writing to '%s'."), filename=
);
> >=20
> > As I inherited this message, I'll keep it.
>=20
> Well, please then add quotes while at it, at least, for consistency
>=20
>   =09=09return error(_("Error wrapping up '%s'."), filename);

I may do that as a final patch, once all the other concerns are addressed.
I really do not want to change the error message during the conversion.

Ciao,
Dscho
--8323329-116441008-1473432045=:129229--
