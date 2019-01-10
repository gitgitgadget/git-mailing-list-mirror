Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C98891F803
	for <e@80x24.org>; Thu, 10 Jan 2019 18:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfAJSzt (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 13:55:49 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:42307 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbfAJSzs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 13:55:48 -0500
Received: by mail-io1-f51.google.com with SMTP id x6so9793435ioa.9
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 10:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corthon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pbd88j4CA49lmbPt0PGASdtk/+D7JxA/+w+2QhGP6jM=;
        b=dDxOe/hs7gaK2p8+CZfrrh9/gHe+iCxqj5dvbNXdJRuwmmi/ghlaPVfhxALZ43Cahp
         UF7Wg6oftrQ9mr8ZOdALnFEbBlsHJVqtT7oKmYCbJrP7dDmjPE798lT8/z0oKjFarAjo
         fP0j/6d/dD1JSRhH8aMVwV2h+Xhg8RZchgN/PgqYKBTlSxaCOU2zf9AG8c+ehgxPf9NZ
         pWSpYP7bviQobQzUpMLbP9TQXK08sKhjOBB6HBVRaNGOz1Hb9jD2oT2tN/RofrKQE8xD
         qfVJ+cNVnyBt2lHNynbe/tbwUTaL/hGFF72JuU/ufDRx1ZxIrw1lEk5fNIme1pqzqAVg
         X21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pbd88j4CA49lmbPt0PGASdtk/+D7JxA/+w+2QhGP6jM=;
        b=eBHeKW7USLWJ3BYIG2jvyj4do8BpZ0RwGal9v+FszWwRP3K1m+nt2MfrVwI1WTG8y7
         5iuPTQDmXT4eaON56qRX9yimkLjT7Qv58whlGw283UQPN7SueHIIPXh/lyss3TbOHc+C
         X5W9GZhm73vexkXbt7dDzjv1YUt/yyKY9vBLdkDq0fWAU4MU+Ye22FDKcD+bsDV8FW7C
         H4XDy/fLS8hCFJXe5LjupYk+cKZi2/TGso4oUPxZo30tkpSUDyjATrXae8Mq3ApLx5HC
         JZjaQWPKE31p/lVJld3iXI/oAyWFyN2rmnJbVA+AshJPAoarXbiU1M+lh6mc5hBrPJ/+
         L4Hw==
X-Gm-Message-State: AJcUukcxScS9MDZZTqSTiOdsw4Vqvu8hRL78XsqDT4kpOSxaE5WfxnwO
        fJBpcHwtahUpWav5iSxh17/Og0zIywfxQRGB4nqs+w==
X-Google-Smtp-Source: ALg8bN5A4Wd+oHeyNo41vTPtg4ZWcgo8lAn0DXjWnjcC4HhMRvh9HwzXmkyNdJZZ7zGG6LjP7MGXThzpKPfDIfccKxY=
X-Received: by 2002:a5d:9257:: with SMTP id e23mr8451109iol.112.1547146547399;
 Thu, 10 Jan 2019 10:55:47 -0800 (PST)
MIME-Version: 1.0
References: <CAGTkKag2sFy+Of=6uQeiGOQm0-NBrh9ixgzDoQXKR73+Ct3raQ@mail.gmail.com>
 <CAGyf7-HcncFOfmm5McEkOvCTkHNdePDSEQDZwEAK=z1bmC=QKw@mail.gmail.com>
 <CAGTkKag-fTy3iZAKJxEnWD6_b_3pfuYvQQKBkLaeSL8wKM2sfg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901091936420.41@tvgsbejvaqbjf.bet> <CAGTkKajkW-U9mhh_GmTXmZQbnceEKX_BcMtOF4hOhEDZe2u9Bw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901101616100.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901101616100.41@tvgsbejvaqbjf.bet>
From:   Bret Barkelew <bret@corthon.com>
Date:   Thu, 10 Jan 2019 10:55:35 -0800
Message-ID: <CAGTkKagTCw-EcMo3M1P3XVtjbTcm4HPjCWGZ1sM_NnJwH7v_hg@mail.gmail.com>
Subject: Re: git version 2.20.1.windows.1 throws file name too long in gitk
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 7:20 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Bret,
>
> in that case, please try to find a way to trace the commands in a Tcl/Tk
> program (which gitk is) and see which command triggers the error.

Er... that's a little out of my depth. I'll see if I can find time to learn=
.
Meanwhile, is there any way to request better instrumentation for the
error dialog so this data could have been collected for me?

>
> Ciao,
> Johannes
>
>
> On Wed, 9 Jan 2019, Bret Barkelew wrote:
>
> > Will try to reply in-line, when appropriate.
> > The latest snapshot (git version 2.20.1.windows.1.5.g6b286585b1) still
> > has the issue.
> >
> > - Bret
> >
> >
> > On Wed, Jan 9, 2019 at 10:39 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > Hi Bret,
> > >
> > >
> > > On Thu, 3 Jan 2019, Bret Barkelew wrote:
> > >
> > > > They are the exact same path (with a different drive letter).
> > >
> > > [it's a bit hard to follow the thread if you top-post a reply to an
> > > inline-replied answer, maybe imitate the style of other mails in the
> > > future.]
> > >
> > > > Another thing I've been able to confirm is I uninstalled git 2.20.1
> > > > and installed 2.19.0 on the failing system, and the older version o=
f
> > > > Git works.
> > > > I've also tried a suggested fix I saw elsewhere to enable long path
> > > > names in the Windows registry, which did not resolve the issue with
> > > > git 2.20.1.
> > > >
> > > > Happy to collect any additional data.
> > >
> > > Please try the latest snapshot at
> > > https://wingit.blob.core.windows.net/files/index.html (I *think* the =
bug
> > > might be fixed via
> > > https://github.com/git-for-windows/MINGW-packages/pull/32).
> > >
> > > Ciao,
> > > Johannes
> > >
> > > > - Bret
> > > >
> > > > On Thu, Jan 3, 2019 at 7:10 PM Bryan Turner <bturner@atlassian.com>=
 wrote:
> > > > >
> > > > > On Thu, Jan 3, 2019 at 6:21 PM Bret Barkelew <bret@corthon.com> w=
rote:
> > > > >>
> > > > >> When I open gitk in a particular repository under this version o=
f Git
> > > > >> for Windows, I now get a dialog box that says "Error: couldn't e=
xecute
> > > > >> "git": file name too long". I've noticed that the most pronounce=
d
> > > > >> effect is that I cannot see the file diffs (or sometimes the fil=
e name
> > > > >> list) for any of the commits. I don't know the exact repro, but =
I've
> > > > >> narrowed down the following things:
> > > > >>
> > > > >> - This does not happen with the same repo if I use a system that=
 has
> > > > >> git 2.19.0.windows.1 on another machine.
> > > > >> - This does not happen on my current machine in a freshly cloned=
 repo.
> > > > >
> > > > >
> > > > > How =E2=80=9Cdeep=E2=80=9D are the paths to the different clones =
on the different systems? Are all of the clones at exactly the same path on=
 disk?
> > > > >
> > > > > Git on Windows is (by defaulted) limited by MAX_PATH, which is 26=
0 characters. That length is calculated including the path to the repositor=
y itself and then to the file inside the repository. That means, for exampl=
e, a given repository cloned to C:\repo may not have issues, but the same r=
epository cloned to C:\Users\Bryan\Documents\workspaces\repo may.
> > > > >
> > > > >>
> > > > >> However, as soon as the remote updates with any changes on a giv=
en
> > > > >> fetch/pull, the repo is put in a bad state permanently.
> > > > >>
> > > > >> I've pasted the output from gitk below...
> > > > >>
> > > > >> couldn't execute "git": file name too long
> > > > >> couldn't execute "git": file name too long
> > > > >>     while executing
> > > > >> "open $cmd r"
> > > > >>     (procedure "getallcommits" line 48)
> > > > >>     invoked from within
> > > > >> "getallcommits"
> > > > >>     (procedure "readcache" line 80)
> > > > >>     invoked from within
> > > > >> "readcache file827e200"
> > > > >>     ("eval" body line 1)
> > > > >>     invoked from within
> > > > >> "eval $script"
> > > > >>     (procedure "dorunq" line 11)
> > > > >>     invoked from within
> > > > >> "dorunq"
> > > > >>     ("after" script)
> > > > >>
> > > > >> Happy to gather whatever data needed.
> > > > >> Thanks!
> > > > >> - Bret Barkelew
> > > >
> >
