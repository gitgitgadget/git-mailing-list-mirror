Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1579720248
	for <e@80x24.org>; Thu, 18 Apr 2019 18:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391516AbfDRSQX (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 14:16:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40676 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390694AbfDRSQW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 14:16:22 -0400
Received: by mail-io1-f65.google.com with SMTP id i21so2081429iol.7
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corthon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ByffnyAjI599etYtnE3n7PkaL+q2gGTgnUnSx5J4IPI=;
        b=Q/mzwok0K9DWEuqbtRBAMAJY+x1HDStD0OYLlyrOdFvR8rFJQQqwE08aAfnu+TpcKW
         k5xEuw9mSkzqnl0WR9lBSkDlFODjE//yS66SFStc41zcDmJWK/TVumnfa59ZQBdksV/6
         +YN0IEoKsYpwhQow2ZwoCdSi5xmz61J0YaayyzfnQOtL/vF4VqZLMJ61RciWNKTOdDYg
         dx3fgOZSdiJOmm+oFm79N5UL+1UrctMBwhPIAQg3QM+HDvYU3WlU42FhxWhKgYcN3DSQ
         zbQliqnh1Jqyc+ZD8fGW7//lu5heZXxkYCXmM7pMd2PsSImHYnYipSycga9gRk/OqFyd
         2nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ByffnyAjI599etYtnE3n7PkaL+q2gGTgnUnSx5J4IPI=;
        b=Lu4OFKAOHUHkl7CvU5qgVJxsiw1c5uXIqlV0VN71zYCUzg9hsjREjwe4JzB1ddg23b
         c4aHdZx+6WPHxVHFsKuPqVL67JtwZuJeKOtBRGBw0bORLglV6kAzPZ813mc2vbAx0PTG
         ea1s9f8sUfcvpprJ0wjbwiC74tuTPx9SHsm7phuKhMlCPlRrwc03xzsMcG43ZIaBwqpZ
         UzYhvYWSQwhNvJak6RiLQRGJbGE+uId2yMicnyKvazvAosw3U2C/vy5DaHSgLjZ0H51Y
         JBQi4AAB2FVMW7bQ90ed+Vdkw30iYivkEb5oFP/3NTOEi4olD5GF1YiEyvo0HUz5wMhb
         ReFQ==
X-Gm-Message-State: APjAAAVPQFi9dxAUbBb1UsyiWVGj8fonUSLipXDnGRQUiKwBAn6Zbp9J
        Yyutj8ybpxcGFs7d+34hWbc7l7vn+8KL9mGg1YY=
X-Google-Smtp-Source: APXvYqzOqMJdPFH5UsYsTwG/O89O809s/OWFOS3n2hTsvV5UnSkIOojCB1Cik6ZpCRzkh/bUA8IFCFRZ6iYZVuHney0=
X-Received: by 2002:a6b:7218:: with SMTP id n24mr2526324ioc.112.1555611381272;
 Thu, 18 Apr 2019 11:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAGTkKag2sFy+Of=6uQeiGOQm0-NBrh9ixgzDoQXKR73+Ct3raQ@mail.gmail.com>
 <CAGyf7-HcncFOfmm5McEkOvCTkHNdePDSEQDZwEAK=z1bmC=QKw@mail.gmail.com>
 <CAGTkKag-fTy3iZAKJxEnWD6_b_3pfuYvQQKBkLaeSL8wKM2sfg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901091936420.41@tvgsbejvaqbjf.bet> <CAGTkKajkW-U9mhh_GmTXmZQbnceEKX_BcMtOF4hOhEDZe2u9Bw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901101616100.41@tvgsbejvaqbjf.bet> <CAGTkKagTCw-EcMo3M1P3XVtjbTcm4HPjCWGZ1sM_NnJwH7v_hg@mail.gmail.com>
In-Reply-To: <CAGTkKagTCw-EcMo3M1P3XVtjbTcm4HPjCWGZ1sM_NnJwH7v_hg@mail.gmail.com>
From:   Bret Barkelew <bret@corthon.com>
Date:   Thu, 18 Apr 2019 11:16:07 -0700
Message-ID: <CAGTkKajYiyT_OtX1mQECvxjvKXndjBYAqwgKMimJrroPAAvZJA@mail.gmail.com>
Subject: Re: git version 2.20.1.windows.1 throws file name too long in gitk
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This issue is now being reported by more users inside MS. I'll also
reach out to the Git for Windows advocacy group to see if they have
any ideas.

I have not had time to figure out the inner workings of Tcl/Tk. Is
there any way to turn on tracing/logging in Git for which commands are
being called by gitk?

On Thu, Jan 10, 2019 at 10:55 AM Bret Barkelew <bret@corthon.com> wrote:
>
> On Thu, Jan 10, 2019 at 7:20 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Bret,
> >
> > in that case, please try to find a way to trace the commands in a Tcl/T=
k
> > program (which gitk is) and see which command triggers the error.
>
> Er... that's a little out of my depth. I'll see if I can find time to lea=
rn.
> Meanwhile, is there any way to request better instrumentation for the
> error dialog so this data could have been collected for me?
>
> >
> > Ciao,
> > Johannes
> >
> >
> > On Wed, 9 Jan 2019, Bret Barkelew wrote:
> >
> > > Will try to reply in-line, when appropriate.
> > > The latest snapshot (git version 2.20.1.windows.1.5.g6b286585b1) stil=
l
> > > has the issue.
> > >
> > > - Bret
> > >
> > >
> > > On Wed, Jan 9, 2019 at 10:39 AM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > Hi Bret,
> > > >
> > > >
> > > > On Thu, 3 Jan 2019, Bret Barkelew wrote:
> > > >
> > > > > They are the exact same path (with a different drive letter).
> > > >
> > > > [it's a bit hard to follow the thread if you top-post a reply to an
> > > > inline-replied answer, maybe imitate the style of other mails in th=
e
> > > > future.]
> > > >
> > > > > Another thing I've been able to confirm is I uninstalled git 2.20=
.1
> > > > > and installed 2.19.0 on the failing system, and the older version=
 of
> > > > > Git works.
> > > > > I've also tried a suggested fix I saw elsewhere to enable long pa=
th
> > > > > names in the Windows registry, which did not resolve the issue wi=
th
> > > > > git 2.20.1.
> > > > >
> > > > > Happy to collect any additional data.
> > > >
> > > > Please try the latest snapshot at
> > > > https://wingit.blob.core.windows.net/files/index.html (I *think* th=
e bug
> > > > might be fixed via
> > > > https://github.com/git-for-windows/MINGW-packages/pull/32).
> > > >
> > > > Ciao,
> > > > Johannes
> > > >
> > > > > - Bret
> > > > >
> > > > > On Thu, Jan 3, 2019 at 7:10 PM Bryan Turner <bturner@atlassian.co=
m> wrote:
> > > > > >
> > > > > > On Thu, Jan 3, 2019 at 6:21 PM Bret Barkelew <bret@corthon.com>=
 wrote:
> > > > > >>
> > > > > >> When I open gitk in a particular repository under this version=
 of Git
> > > > > >> for Windows, I now get a dialog box that says "Error: couldn't=
 execute
> > > > > >> "git": file name too long". I've noticed that the most pronoun=
ced
> > > > > >> effect is that I cannot see the file diffs (or sometimes the f=
ile name
> > > > > >> list) for any of the commits. I don't know the exact repro, bu=
t I've
> > > > > >> narrowed down the following things:
> > > > > >>
> > > > > >> - This does not happen with the same repo if I use a system th=
at has
> > > > > >> git 2.19.0.windows.1 on another machine.
> > > > > >> - This does not happen on my current machine in a freshly clon=
ed repo.
> > > > > >
> > > > > >
> > > > > > How =E2=80=9Cdeep=E2=80=9D are the paths to the different clone=
s on the different systems? Are all of the clones at exactly the same path =
on disk?
> > > > > >
> > > > > > Git on Windows is (by defaulted) limited by MAX_PATH, which is =
260 characters. That length is calculated including the path to the reposit=
ory itself and then to the file inside the repository. That means, for exam=
ple, a given repository cloned to C:\repo may not have issues, but the same=
 repository cloned to C:\Users\Bryan\Documents\workspaces\repo may.
> > > > > >
> > > > > >>
> > > > > >> However, as soon as the remote updates with any changes on a g=
iven
> > > > > >> fetch/pull, the repo is put in a bad state permanently.
> > > > > >>
> > > > > >> I've pasted the output from gitk below...
> > > > > >>
> > > > > >> couldn't execute "git": file name too long
> > > > > >> couldn't execute "git": file name too long
> > > > > >>     while executing
> > > > > >> "open $cmd r"
> > > > > >>     (procedure "getallcommits" line 48)
> > > > > >>     invoked from within
> > > > > >> "getallcommits"
> > > > > >>     (procedure "readcache" line 80)
> > > > > >>     invoked from within
> > > > > >> "readcache file827e200"
> > > > > >>     ("eval" body line 1)
> > > > > >>     invoked from within
> > > > > >> "eval $script"
> > > > > >>     (procedure "dorunq" line 11)
> > > > > >>     invoked from within
> > > > > >> "dorunq"
> > > > > >>     ("after" script)
> > > > > >>
> > > > > >> Happy to gather whatever data needed.
> > > > > >> Thanks!
> > > > > >> - Bret Barkelew
> > > > >
> > >
