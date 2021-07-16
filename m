Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F502C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18EDC61164
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbhGPP6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 11:58:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:40469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236246AbhGPP6a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 11:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626450930;
        bh=CMkBTZ9JH1Q0IcK31/z6HAx36nQKxqbIsciycI5LlKk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k6J61BQk/muLPuQaUI7yGl9y+bU8YB73vhO0eMBnwtPKFS0ljOTe+kSUhpe0fbblQ
         u20C+q0fT2lBJtPpYyELlmn4vWZJHtW3A2FJ/LmDoNWOhIwHFD08WNUSAuZFtkFemz
         aCRSuOpc8d/CUCeCi3G12YnH1fgpF3I/laU8EhCQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.111.2] ([89.1.214.95]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6qv-1lKKeQ3tSl-00paTk; Fri, 16
 Jul 2021 17:55:30 +0200
Date:   Fri, 16 Jul 2021 17:55:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 19/34] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
In-Reply-To: <87mtqq2i3r.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107161754180.59@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <pull.923.v3.git.1625150864.gitgitgadget@gmail.com> <5bba5eb3d1bd172f09fdf6eb2e9b8ac4dd7f940f.1625150864.git.gitgitgadget@gmail.com> <87k0m9bpmv.fsf@evledraar.gmail.com>
 <b19f3f2a-049f-acf2-f59e-de705dc54307@jeffhostetler.com> <87mtqq2i3r.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1411310482-1626450929=:59"
X-Provags-ID: V03:K1:zqxE9p8QSvJbHNI6plGURVxIhq9x9g7apkewACWOVhZXOscefMA
 wBlvj/vJSbYAD88rngnnlW3nWQTuYr1mkNalWl5FaZUEqEgZeUYtKNeE5OF3X8GUHzA3StG
 FGl0XVrXFbujNWKYdGXgRhqW/o7WmOAAad2JYGfxXMGxMfzfPJx+VaavDliU4RuKeTbqkh0
 3TgHb7Vh/wx1X92Fk0ecQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q7EONUT7xcM=:CnWlNY2HcJ5gmJ3nSYItLm
 2ptBHR1bwJJKXbJe1CIiIYb6xy1y97KYwQlb61s3EYS38hhlJWI/Y0Lro3j+24MIwQdOOVj2z
 hpcUGyqQeJcurL/OfNNDKStojQ1vocG6Wf/F4GklkF5oHno+qPUdS170UfAD5AGryYoxolTBY
 fI10NbF3/6ooL8dsaV+KnADPtaOrtAEXskHijhurPQR7SiaT1PklJSafyww+Ad+x42HGy0h23
 q6D3LClTM79vTOaFn5+22F6/97h+a6JH6ECJ0aFS1RXGxfj3W+kfqG71NyzmGWCQ+GLUtbO/K
 v10vVk+3d89U4t04FyqOarAR72KSWmSFSHIQ3+E64T1R2hYfA/fjtZozIYM4ycQL4ykn63XC1
 QBkmmQb/Li9vXaiWJi49KJr9VXseXy6POlqJXa/YimNcCORhW+RedVxWtyhhCBze7wAmW1+ZS
 Z2UMhU3vWCI+A1GUIX0v3b2JHS4DVzJ3l2ySHpeNCJIcpxSnIRdKBoAd4XuxOwfqUgT29u2cs
 4nAlDYvsrKkQ3HgYVubgAji/uKl0qs4PbLj5OkhinOJkYOxp4Kr4DrFylozL8y3YFqqpYjOHR
 nwKJ1HOsW6X/CmpRgElp5k6gf+A2JwumsVbXtQvN0xK09amxw1PTiJNreKEGMiWbee3JpRRNm
 6jcp+cQ6oy6Q27Msrl24hNOeoCye5OfR4VNB3KirWjioeO+3bDPNWjTLFD56/7CFBtt51zUoE
 X0kbaP8y9x7aGjlMHhbAzzU7Aia5u4/h83rLWZ04g7/T7amaa6uobH5mSiOgjTjYbR6gjjiMl
 Qp9Z1gx6Efcy7A5+g0YWOLYb3ZynIBq21yDT5/YHBl1XelIy/QLThoU/1M/Nhscih2Dzz4LT/
 Jid6NJsHZt9WF0QHnK1RDafJS8KvIsWXnmldRjavEjsDz+TtGAs5qHdZn2mU9/MX4GpwfheJ/
 2pu4g6djSTAkT3U8q1fMyYXZY7Bdo2iCzN2JhD9cZqylDAdO7W5et9k6Pf8VHtt5BAqD6kq1K
 CBdGV38XdXZ+8WU3WS2sHyCYzdObVT+429mC2+JfJbyg3zfeBbLDkfCobeGkYH38JKze65n/l
 sME3Zd5xeZdm6PozLGQe3yMf+hQXxdLwy4KDJCwRw/I2SH+uVC49JjZzA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1411310482-1626450929=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 13 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Tue, Jul 13 2021, Jeff Hostetler wrote:
>
> > On 7/1/21 7:02 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
> >>
> >>> From: Jeff Hostetler <jeffhost@microsoft.com>
> >>>
> >>> Teach the win32 backend to register a watch on the working tree
> >>> root directory (recursively).  Also watch the <gitdir> if it is
> >>> not inside the working tree.  And to collect path change notificatio=
ns
> >>> into batches and publish.
> >>>
> >>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> >>> ---
> >>>   compat/fsmonitor/fsmonitor-fs-listen-win32.c | 530 +++++++++++++++=
++++
> >> <bikeshed mode> Spying on the early history of this (looking for the
> >> Linux backend) I saw that at some point we had just
> >> compat/fsmonitor/linux.c, and presumably some of
> >> compat/fsmonitor/{windows,win32,macos,darwin}.c.
> >> At some point those filenames became much much longer.
> >>
> >
> > Once upon a time having "foo/bar/win32.c" and "abc/def/win32.c"
> > would cause confusion in the debugger (I've long since forgotten
> > which).  Breaking at win32.c:30 was no longer unique.
> >
> > Also, if the Makefile sends all .o's to the root directory or a
> > unified OBJS directory rather than to the subdir containing the .c,
> > then we have another issue during linking...
> >
> > So, having been burned too many times, I prefer to make source
> > filenames unique when possible.
>
> A much shorter name like compat/fsmonitor/fsmon-win32.c would achieve
> that goal.
>
> >> I've noticed you tend to prefer really long file and function names,
> >> e.g. your borrowed daemonize() became
> >> spawn_background_fsmonitor_daemon(), I think aiming for shorter
> >> filenames & function names helps, e.g. these long names widen diffsta=
ts,
> >> and many people who hack on the code stick religiously to 80 characte=
r
> >> width terminals.
> >>
> >
> > I prefer self-documenting code.
>
> Sure, I'm not saying daemonize() is an ideal name, just suggesting that
> you can both get uniqueness & self-documentation and not need to split
> to multiple lines in some common cases to stay within the "We try to
> keep to at most 80 characters per line" in CodingGuidelines in this
> series.

While you are entitled to have your taste, I have to point out that Jeff
is just as entitled to their taste, and I don't think that you can claim
that yours is better.

So I wonder what the intended outcome of this review is? To make the patch
better? Or to pit taste against taste?

Ciao,
Johannes

--8323328-1411310482-1626450929=:59--
