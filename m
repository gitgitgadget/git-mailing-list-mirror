Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1E6C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 14:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD3061A05
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 14:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCZOrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 10:47:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:38111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhCZOr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 10:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616770036;
        bh=PFr5QGVsOtR2kvYtBdrrIdB3iTimu+h64295um5Z77M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VToUSo2PiF5JX5pGQMx0o+uZgl49nx4KEDRsi+emUNVbs130tF34s0si4bhQdQNIz
         6YsaZI0h4mcnWm5BQfuDxJHHfaHpwWjsMwnQjGST0ANJER+VU3vH03/5+leunO5O8s
         k81OsFGsdOz7A8Ann35umo043OAfD2xOEq1BHQ+U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.162.157] ([89.1.213.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7Jza-1lI66S0BOW-007hda; Fri, 26
 Mar 2021 15:47:16 +0100
Date:   Fri, 26 Mar 2021 15:47:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe=2E?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: sanitize all directory separators
In-Reply-To: <xmqq5z1fuen6.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2103261543550.52@tvgsbejvaqbjf.bet>
References: <314451a4-ee8f-fb68-016f-66a4f3bea409@web.de> <xmqq5z1fuen6.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-969711651-1616769940=:52"
Content-ID: <nycvar.QRO.7.76.6.2103261545480.52@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:kveHUeaZlgCGvu3BIlFPQXSGJ24CMY5A8pCq+dwQFwwD/u4Z5gv
 aJtmjZjDRYQwNjIp4AjXM2BkGFpSJrV32vsxjIhzFujq50GSWuMGB91qE6dfoDvRePj14nE
 /erWbFEIZItngFysY0jycO4Tz5nC/rVYRcWmlNyaFDcFypwvYklEa0BhNL6i0zJw1+3S39p
 Nc/+ZkEH9rWqr7NdPI2yA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+W/vLZl4hMU=:YR+QOACzwZmh5VIU9R9iuh
 pFkPQFTOaWGc8T4U6jj1YAR5osZ8uYOCHuWoLYX6a94aPFHlRm9xg282q6Igg5TgFT9Nnx5dN
 VwzXGnQ/x0YVwHjZHpqMlBLTSESWTBXo5STk4cXRCLyvqX6W9keOiMIQBX/7r9Ilot5D5FA0d
 FhwfbcoL1JNk/QFXO6R1Y+WZOgT6I90+tNcWYVAWWrYRRWQLgGw+JxgjSdyRtIpvZiYHS1+ik
 zdTSaFXBDP27Ti7ALUHHHx6ooCXtOsJQUmHwew+6ysMeQqISa5ZUTacYzVBnTWY/d7ZcGoKh1
 jjev6UDyssNNz0CH/K3r2aSR+qn2BaLruuxrMN/oPmlGrU5zoGQc1IocszlRbVVgbnK/gYZk9
 Hr6aQzJXoi9CglEk4KJv/AdqI4Kx9EDpahuSQ7bOrsWDSRR0Vqxa9R2avSAn4Gd/Y1EwlWPeG
 d7RlJpcOuEO1sKcstmrZW/+Uh/SSIx3voz9nt88HDi+HrC+soiomot2vlPaGbVh/Wlvb7ztos
 9XgFRqiYxNzxQ3QtOBXG5IgnSsnEvUeJ3zBSkxYI6Hzdz8QozUFy4i8nDAo9F6Zz5eccUrJzq
 k5iuIuCPykqeT0Sl8KUgEcX8rXuB+fOXuSoJDRPJLAru4q3o8Zvk8Q69a0nOrkRctgGRMDuCm
 X2YgY/kObooOi0tnrasBjPUU1glHJnF0b3zU92hg1OKj1vTMyXyGuiccK7tBsHBM7RU/IZ9c0
 Q2tURPPFtT9qvkayaVudKmY3E6yDIVeQltAsUaiGPsZ2SS/VMr+7+zjYj36Dg/ZI1Gz4A7kgy
 PeuEGiBjRVjOZ5YxLzEpPg7z+miPw8Q0NmRENORgGZrL7eNP+3V0hNhNlBbwwjggcOvRmVF6S
 cCBv7H250FnUH+BjCYNoTw4TTXaBauU01su0mVxpZMGrB4raUQM82BAhzXRostgbY7a5FXM6w
 vCTlwysu6NqkXx5qAqT8gaaz5GgiwsLbeO72hFnCwov/j5BZI1ugk9CFpRTzSbBRcYnbElSdk
 mbN4PSYpA+YyaLPWbIUaI5/zR5x/DdQmUsX1FiYeRmE3lLnzbr770r8rG0JRAV0IQAiNjehHz
 JhJ0bGgjXlGUFDiVN1XjPksSbITRXKbkrqO9CyEpcFtciZaq5ZXW/KFXeqxb6S2LANHYKgc8P
 iBJFKOt8Gc5qPXBTllhrr51n9aEQHeUfKbpw/rvoYn1qgybZypRuNiK7rhkn1k6hb+1GIrhSB
 o3kV8JVJbcnzhwqwa
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-969711651-1616769940=:52
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2103261545481.52@tvgsbejvaqbjf.bet>

Hi Junio & Ren=C3=A9,

On Thu, 25 Mar 2021, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe. <l.s.r@web.de> writes:
>
> > When sanitizing client-supplied strings on Windows, also strip off
> > backslashes, not just slashes.
> >
> > Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> > ---
> >  daemon.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> I do not know how common is it to run "git daemon" on Windows, but
> it would be nice to have at least an ack from Windows person.

Here is my ACK.

I do not have any precise numbers, of course, as we do not have any
telemetry in Git for Windows (for better or worse).

There _are_ occasional reports about something in `git daemon` not
working; Most notably, you have to turn off the sideband to make `push`
work.

> > diff --git a/daemon.c b/daemon.c
> > index 2ab7ea82eb..0561c19ee8 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -566,14 +566,14 @@ static void parse_host_and_port(char *hostport, =
char **host,
> >
> >  /*
> >   * Sanitize a string from the client so that it's OK to be inserted i=
nto a
> > - * filesystem path. Specifically, we disallow slashes, runs of "..", =
and
> > - * trailing and leading dots, which means that the client cannot esca=
pe
> > - * our base path via ".." traversal.
> > + * filesystem path. Specifically, we disallow directory separators, r=
uns
> > + * of "..", and trailing and leading dots, which means that the clien=
t
> > + * cannot escape our base path via ".." traversal.
>
> Not a new problem, but "runs of '..'" confused me.  If I am reading
> the code right, we disallow directory separators (by ignoring) and
> two or more '.' in a row (by squashing them into a single '.').

Indeed, the code is a bit funny in that respect. But at least it keeps us
somewhat safe: there is currently no way to break out of the directory to
the parent directory, whether with this path or not. (Phew!)

Thanks,
Dscho

>
> >   */
> >  static void sanitize_client(struct strbuf *out, const char *in)
> >  {
> >  	for (; *in; in++) {
> > -		if (*in =3D=3D '/')
> > +		if (is_dir_sep(*in))
> >  			continue;
> >  		if (*in =3D=3D '.' && (!out->len || out->buf[out->len - 1] =3D=3D '=
.'))
> >  			continue;
> > --
> > 2.30.2
>
> Thanks.
>

--8323328-969711651-1616769940=:52--
