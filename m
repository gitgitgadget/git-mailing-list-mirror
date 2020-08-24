Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80907C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 14:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C75206B5
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 14:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="R+w3mjFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHXO7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:59:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:51805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgHXO7A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 10:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598281128;
        bh=Ikt/rbT9IwJB6jdd80v/r/axdsrAcGEICrbBaDaMX5w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R+w3mjFtugouAMULLpwXFM7Pio1GGTlfQZIK+Xhe0ry4jo/ALfzqoQ05hcTM8jQXO
         HTwK3FcRAN6r1dUDGWlNpZcGzMSROpB6lL+n31wWsc+QcE1ucE3b/Q0KmWXCIML/2j
         Rq4J5F+iNjpQbNSwOf86MiGr0lnSfQss63x/yQFM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.214.173]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5Q5-1kNiBk3jJ1-00FDHY; Mon, 24
 Aug 2020 16:58:47 +0200
Date:   Mon, 24 Aug 2020 16:58:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] Optionally skip linking/copying the built-ins
In-Reply-To: <xmqq7dtx2kzf.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008241657071.56@tvgsbejvaqbjf.bet>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>        <647f49d62e910fe8392219c3a5c6d86ac98a88e6.1597655273.git.gitgitgadget@gmail.com> <xmqq7dtx2kzf.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1577573104-1598281128=:56"
X-Provags-ID: V03:K1:f0345u4M0+gcnb4HvHJKEOOHCtTw0qhhe8km/qTIyQh5XK62OAj
 JIDAT6eG6ZiyI/2PBA3Nw6DORdE+p8l5plKbL5pOfWQ7pYO6homs/mqBCKmOuBASWS5nnNc
 fiSJHCAM0ej+mmn8E5mkNvON45pcdyyK/p9VIw018vTqiSAEnYTgSmrLuMb6AokhaQbjQMi
 GMcRrYgRfzIi3cHzUM2CQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UYcIWULselQ=:958IUmK0VKr8zwFc75Bzc4
 lkG0wBhpEh2kaa2fs5NJxhTbCkmjAcpyhKnMkSUpT6LiBY2kwWF4AIoLytQNiBVBozsPfzP70
 BifNwlW7PspmkcI/g7I6HTRyiXTjq6Ap4Hrp1JpcTgbeGbgDwb9z7PaN+QR+zjwTgItMnvxLM
 7EXnpvx2Jo6hSpXuJ01aAhbQ/rYGELWronuywTuyWrSgurpSF2i5q9nt8WRMQqhCA2uSrOuxt
 0SEFb7cNw+bmrAi/psvaAG0wHReWFWgA5je0vawUNi78U9d3WxVx49WMvEYiJJN576GOOLFD6
 ZGsE5hffK1lTZLO/ZUzSxGzN9w9X7TJeLt+nUGZE/aex4nS9qhsxeveObqz2ow0gBG4/ftpL+
 n4KZwXfrRUC/eQDlPeQ25JDnwNaVsudLka7ThK2jErMQJUV6K+4TYT9k6aptcgiS8n08owmrP
 USBl/NMtKh+c2k/nlwRFFCZZgT8VO0G3yOzjCsELb5B4kdA088iGGIakDbUXmAdjIFqjwbjsC
 LilwRBmRXWdz/mL7bjVi4+mfYlwgR/ZhPBiAWERwLCSeVujfyLbg2EyY0je0FMq6Z30pDjDKM
 bGpE2FA5YQrmS/NIVLaQwDGzN1VaAFQufcxe0duIz1DU2HsLMmTuWcMsee//Ef71dJJjc9Fc8
 JDYqOvuzLcRrRQURXq4SSq0XVxo8wCniKN7r/qF6NKWqUWqRGRtGf9xTztZQQ0eXCCZxrbIvO
 8sHYWCMDIKXgkojS8bGKMEO+UxQcpfy3JmJbMWnCQpMONizRHBb754FNp0bSp5I2hbVp90G+1
 xgcrTBpaeULuwDpMm2lUYadzRRysGl/SnvVUngCsffiLSfdZep91+uepQak6wVlDDk45MzSuC
 H+uTcQsUOKwrbj35pHlCxnDho52YOw7D3Xard0Ti4Px0G3KvAgQUQsDVFVU9OBoLHhBVtOV7o
 6oBmsfaQ1uLU5RCXAqu4PpB8go7LfahME1JUrR/PGA5RpQj57Oq4Ss07ojjZJTD/MIy69fKdb
 k9J/Ig9CXsmDOyasXYvVXEFfkc0eQoo6JYQD6dUdqgEds4R4Lid4BLXyE/fkAJp1f3Oi6cJL5
 0fZ/2OQfHz6OlkPWZ6ik9LuEEGlz05f61qkTWsJBYUhbGvqRrz4sqM4BTjESMwYPwFpGfMhqV
 8FkdPRh9S9/DRWebOwf0srIbPiu1FQql7HF4dhE/w2PubgLesIVwI18zsJdmUMkbWVSxuEA3+
 8C61YIlKnhG3TWNgJeH7NGw4WxlAzDcpnWGzUMBtdcIy3VAuVXWUyYucqFjo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1577573104-1598281128=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 17 Aug 2020, Junio C Hamano wrote:

> Johannes Schindelin <gitgitgadget@gmail.com> writes:
>
> > The dashed form of the built-ins is so pass=C3=A9. To save on developm=
ent
> > time, and to support the idea of eventually dropping the dashed form
> > altogether, let's introduce a Makefile knob to skip generating those
> > hard-links.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Makefile | 53 ++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 36 insertions(+), 17 deletions(-)
>
> I do not know pass=C3=A9 is a good adjective to use for the past effort
> of keeping the promise we made to our users, but I think in general
> this as an optional installation knob is an excellent idea.

You're right. My frustration with related Git for Windows tickets got the
better of me. I hope that you'll like v2's commit message much better.

> >  ### Check documentation
> >  #
> > -ALL_COMMANDS =3D $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS)
> > +ALL_COMMANDS =3D $(ALL_PROGRAMS_AND_BUILT_INS) $(SCRIPT_LIB)
> >  ALL_COMMANDS +=3D git
> >  ALL_COMMANDS +=3D git-citool
> >  ALL_COMMANDS +=3D git-gui
>
> This stops "make check-docs" from ensuring that the built-in
> commands are documented when skip-dashed is requested, no?
> The first action in check-docs target that runs lint-docs in the
> Documentation directory may notice a missing documentation when
> it is referenced by somebody else, but the check in the target
> itself are told that these built-ins no longer exist and triggers
> "removed but listed" errors.
>
> A mistake clike the above an become harder to make if
> ALL_PROGRAMS_AND_BUILT_INS is renamed to indicate what it really is
> (which would also help its primary target, the installation step).
> It obviously does NOT always include $(BUILT_INS), so it is not "all
> programs and built-ins" but something else (perhaps "all programs
> and built-ins that are installed on a filesystem as separate
> executable files"?)

Right, that's a very good point. I had assumed that `check-docs` would be
exercised by CI, but it wasn't... It's only exercised in the
`Documentation` job, which is run without Makefile knobs.

I fixed it in preparation for v2 of this patch series.

Ciao,
Dscho

--8323328-1577573104-1598281128=:56--
