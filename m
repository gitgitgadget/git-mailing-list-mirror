Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3709AC2BB55
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 12:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE8920771
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 12:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Wh1SVSpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDIMCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:02:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:46027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDIMCn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 08:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586433761;
        bh=Zo70W504pHOCVI4OLkNM4bJ+GRXOu+s86JWS1/n44S8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Wh1SVSpIH4QLkt4T2WHKFycYtvwwvFOO8oCxfOcUJANv2t5baqodhlwCbXONycHeL
         aKUanr7uJahWHrFofVMpz7PiBiMf0sluHRWT/5SaZlFat+JdQ0AHzyXOyyeFb2Y7OK
         rB5So/91uR71dvVvVcB4i8WPw/vYqfWUmKu8NJrw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.254]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MEm27-1jWjIQ1BP9-00GGCp; Thu, 09 Apr 2020 14:02:41 +0200
Date:   Thu, 9 Apr 2020 14:02:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Nathan Sanders <spekbukkem@gmail.com>
Subject: Re: [PATCH] mingw: cope with the Isilon network file system
In-Reply-To: <CAN0heSrvZb3z3JdYSXs4Dy4nBwPYBAQZ5Zf2f9RSeUnyQSLeeg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004091356110.46@tvgsbejvaqbjf.bet>
References: <pull.756.git.git.1586427853403.gitgitgadget@gmail.com> <CAN0heSrvZb3z3JdYSXs4Dy4nBwPYBAQZ5Zf2f9RSeUnyQSLeeg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1348633090-1586433763=:46"
X-Provags-ID: V03:K1:M8xu+6DO80RgtdDEL6Jv9b+FgYx9wscawcv8WUbB0sPx9JL5dte
 sY/WvGLQGImmBcSYSDsm1yEcfWKrM5XraXHZvC/vLLIjPFiwMDAEZtlcpdrtrEkodbglKS6
 mnJjPWbfn6PhsemV7754s8RZAOYQuvwRE2NlJr9oCQn6wdue3rAoyIzw3m/qr7LVvGRvls+
 6T19roEFmbaARr8tHC3dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EK/TiQJAlgw=:z39XYPDIYXnKou2Z9goLho
 o+eOgmZvbUARbP9AR0Vw8jn48fpgK5RErdsRvn/JaEK2hDPy85HARxBWhFsda6zOUiX4WkpCl
 Qt/S2JdRRwSaTaNGSPRwIue3PHpOvZ/zyR8JdNfFyVeJbtA4rtEtS9BaxELm4SWBEyh5AobNg
 NByC72rsIjd9sgycK6Fyed9c3WcScoXGu2k5R/pT1j7oWe1dPEMSlF79NlOFmikvBKoysIg/p
 EaXfloKaOro4L0XC5skJnp4GDyDsIJV3gJ06K8ZJI2InQLU/apEqdaR67jrI1cIlo5YmeHFez
 eB1+mGOzTE4JP9/jiuySDdyFg4RaUSCddLEUEoADsjnB13eNKgBbCVYdBPSyuLSRoJ9YX0r2S
 LDJzWrPoDG6lKrfDMC75XtZtASlneePlbkkjjTUCZihsxfjRxt1SQYaGGqR2qrNdDaR0gX9HS
 ZHf40xrugyIOLCn50CK6nVuw1hj7t/hrwTULNil+HrPLjnZ2dDue5oEBdxJP0gQnzQ7yhK1kk
 IuyVpKxPjxoeXoeEzZVkKnkzO/lRtJGnx5e0DpadjOP6JJ4O1uaJP2nuKkJugc+j+I2kf5PYd
 bnVWe4gsqbxHJHMaelk7KlQx3J4JgL2GuoqLRGXqh1xchejMhXhcSntcq1Eq7CDf6/PBZDYPJ
 WC45lneJLFqTq5FqeK6NdSxEIkCidhX6WnMkbHlb/Kv5rF9be3ANbVZoQ+lzyJFwv7hIu8WIV
 WHIw6w3525LX+sO8OTLhTU9iMpYywqJKnBPIMG6h4EFT+z2e0iiYdvtrBSqyL833Tj8f0Rw4c
 vNyLhz1KS0Wj6AyjRNnfl0XX7kcCptH8MiaGR+Mbr3Xb6vW8MBJhGnrkhoF+UXyD7RN+xZhFn
 l2qWTz3TV+kf3qmaGlWIcRZSH51g7scqUof4lD5+sU4/aAV1EERP7TnaX9xcg4twEvy5VQw5k
 HxMroUD2pQMtGE4TdhMHmSZr8PePaycHaptrj1RD3X5DBchJi6yRWqU0Q0WVzJWrC1MGwiE2Y
 wL7uB3ISoHig6ZMggxYhq4s1qSCU7J8KELGUMg6JI0e3QAofA/NgcdIDlJm2U6vKXT4HzxU/S
 LaQsr3toiVKcZy+/vz2KhsEPxUCt4y5BsnUjc8GoiNE1cN6zfy1Ayka9x0qgNhZYWo9Glewdp
 E/72osbU6jKNxYCeNbXAaOnPm/vL3t7yRuocebQeSM8wuloigt8L+q8k2/ld4HI+Vjen4H7Gk
 5SuBxlc+fg3IC9h5k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1348633090-1586433763=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Thu, 9 Apr 2020, Martin =C3=85gren wrote:

> On Thu, 9 Apr 2020 at 12:26, Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> >         handle =3D CreateFileW(wfilename, FILE_APPEND_DATA,
> >                         FILE_SHARE_WRITE | FILE_SHARE_READ,
> >                         NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
> > -       if (handle =3D=3D INVALID_HANDLE_VALUE)
> > -               return errno =3D err_win_to_posix(GetLastError()), -1;
>
> (This code, which is being removed, used "," to avoid having to introduc=
e
> braces. There's another instance of this pattern a bit above.)

Oh yes, that's an important point I had missed.

> > +       if (handle =3D=3D INVALID_HANDLE_VALUE) {
>
> (Adding a brace here.)
>
> > +               DWORD err =3D GetLastError();
> > +               /*
> > +                * Some network storage solutions (e.g. Isilon) might =
return
> > +                * ERROR_INVALID_PARAMETER instead of expected error
> > +                * ERROR_PATH_NOT_FOUND, which results in a unknow err=
or. If
>
> s/ a / an /
> s/unknow/&n/

Oh shucks. Usually I try to do a final review of the patches before I
"upstream" them. Seems like the quality of my submission here is not what
I want it to be.

>
> > +                * so, the error is now forced to be an ERROR_PATH_NOT=
_FOUND
> > +                * error instead.
> > +                */
>
> "is now forced" sounds more like it describes this change/commit, rather
> than this piece of code. Maybe this final sentence can be scrapped
> entirely, since the forcing/translating/mapping is obvious from the code
> anyway? The remainder of the comment goes into *why* and looks more
> useful. Just my 2 cents.
>
> > +               if (err =3D=3D ERROR_INVALID_PARAMETER)
> > +                       err =3D ERROR_PATH_NOT_FOUND;
> > +               return errno =3D err_win_to_posix(err), -1;
> > +       }
>
> Now there's no need to avoid introducing braces, so maybe split this
> into two lines for a lower huh-factor?
>
>   errno =3D err_win_to_posix(err);
>   return -1;

Absolutely.

I updated the PR at https://github.com/git/git/pull/756 (also addressing
issues with the commit message) and will wait for while before sending v2.

Thank you for your excellent review,
Dscho

--8323328-1348633090-1586433763=:46--
