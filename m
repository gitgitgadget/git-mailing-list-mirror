Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 865A81F803
	for <e@80x24.org>; Wed,  9 Jan 2019 18:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfAIStI (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 13:49:08 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:33140 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfAIStI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 13:49:08 -0500
Received: by mail-it1-f196.google.com with SMTP id m8so13427033itk.0
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 10:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corthon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZIZG8EhdpYDtHTgpChPKDzesi9ejUFl4ohbhd3mAjLY=;
        b=jOl6yGUjPz7SfFkciFqNPfV5+r+M1MW92LwNZuXHjIvvSNuWiML3sAJlVodQ13Jplt
         thSSLbB3KGt/XAcV5SL2Vraoot43Ck8QiGEMKLuzhMKwAisvx8PC9rxzFcXt7s03xhn2
         8UYHOXS9DuUP+Br6Ehg1hmSALFQeV9DHuzbzis+xFEnYUqmPFgXSBmHkvnfFHe6MNZ2r
         qIHtkvVrdWhxY3a5TU9ZrlJkBKiydz/+6nLGOmdEX8P3KjCdl75OmN7aW6/7zAQc5UXT
         r9t0XaE6n4BrrYXnYYeKNTImp3jvyKcq6ARrixCmQpou9hL6YyXUMCFHxwV92hL6Ay/K
         wfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZIZG8EhdpYDtHTgpChPKDzesi9ejUFl4ohbhd3mAjLY=;
        b=dGPFvch1kao0mJsHHJpMA7RD5HvszfiUIowm+FmL8ehNwVpca/HkOH4Mk5dHtH7I/n
         fdBaCW/0A0cV6XPRTOnBWocrW9J+ATuiJ7Eks8J/ViN6T793CD+ADPkGmv7BAv7m/SQC
         VGJsynpzbyTgPcVmgFr+d1+mXaBqUA6xhJcoEHrZaz+eqyQw1V9PZbAATHu6aqmwwNMf
         xyHq0nn9IG4LjfVQNFKZ9oqdn8+MbLdY/YB7SAwqqJzZJYocvbtnxqyYqdpemGXRGpFS
         jcuAHeheT5i7BFgcrDA6ZnMkyVonxcdmNhQKY1Yn5UDOXxWClOB8j9162iW0CShYt4yu
         Vj+w==
X-Gm-Message-State: AJcUukeywFjLw0RzjERIe+8uoiYZyz0qnowEu7JV1yNbOdu3rdUXGAy9
        v3fDxe2HinVQFhlRSWPWVXvwDMdfF0XA02GpJTE=
X-Google-Smtp-Source: ALg8bN6n3pm7Or3s/lqW7aZSlf4lmUfnPqz9ZMD8dmJsUoVTWJFbUzJxOcySANkTPgytTyYuCHAMRTdCXL30yj/BU1E=
X-Received: by 2002:a24:d857:: with SMTP id b84mr4747141itg.149.1547059747022;
 Wed, 09 Jan 2019 10:49:07 -0800 (PST)
MIME-Version: 1.0
References: <CAGTkKag2sFy+Of=6uQeiGOQm0-NBrh9ixgzDoQXKR73+Ct3raQ@mail.gmail.com>
 <CAGyf7-HcncFOfmm5McEkOvCTkHNdePDSEQDZwEAK=z1bmC=QKw@mail.gmail.com>
 <CAGTkKag-fTy3iZAKJxEnWD6_b_3pfuYvQQKBkLaeSL8wKM2sfg@mail.gmail.com> <nycvar.QRO.7.76.6.1901091936420.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901091936420.41@tvgsbejvaqbjf.bet>
From:   Bret Barkelew <bret@corthon.com>
Date:   Wed, 9 Jan 2019 10:48:56 -0800
Message-ID: <CAGTkKajkW-U9mhh_GmTXmZQbnceEKX_BcMtOF4hOhEDZe2u9Bw@mail.gmail.com>
Subject: Re: git version 2.20.1.windows.1 throws file name too long in gitk
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Will try to reply in-line, when appropriate.
The latest snapshot (git version 2.20.1.windows.1.5.g6b286585b1) still
has the issue.

- Bret


On Wed, Jan 9, 2019 at 10:39 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Bret,
>
>
> On Thu, 3 Jan 2019, Bret Barkelew wrote:
>
> > They are the exact same path (with a different drive letter).
>
> [it's a bit hard to follow the thread if you top-post a reply to an
> inline-replied answer, maybe imitate the style of other mails in the
> future.]
>
> > Another thing I've been able to confirm is I uninstalled git 2.20.1
> > and installed 2.19.0 on the failing system, and the older version of
> > Git works.
> > I've also tried a suggested fix I saw elsewhere to enable long path
> > names in the Windows registry, which did not resolve the issue with
> > git 2.20.1.
> >
> > Happy to collect any additional data.
>
> Please try the latest snapshot at
> https://wingit.blob.core.windows.net/files/index.html (I *think* the bug
> might be fixed via
> https://github.com/git-for-windows/MINGW-packages/pull/32).
>
> Ciao,
> Johannes
>
> > - Bret
> >
> > On Thu, Jan 3, 2019 at 7:10 PM Bryan Turner <bturner@atlassian.com> wro=
te:
> > >
> > > On Thu, Jan 3, 2019 at 6:21 PM Bret Barkelew <bret@corthon.com> wrote=
:
> > >>
> > >> When I open gitk in a particular repository under this version of Gi=
t
> > >> for Windows, I now get a dialog box that says "Error: couldn't execu=
te
> > >> "git": file name too long". I've noticed that the most pronounced
> > >> effect is that I cannot see the file diffs (or sometimes the file na=
me
> > >> list) for any of the commits. I don't know the exact repro, but I've
> > >> narrowed down the following things:
> > >>
> > >> - This does not happen with the same repo if I use a system that has
> > >> git 2.19.0.windows.1 on another machine.
> > >> - This does not happen on my current machine in a freshly cloned rep=
o.
> > >
> > >
> > > How =E2=80=9Cdeep=E2=80=9D are the paths to the different clones on t=
he different systems? Are all of the clones at exactly the same path on dis=
k?
> > >
> > > Git on Windows is (by defaulted) limited by MAX_PATH, which is 260 ch=
aracters. That length is calculated including the path to the repository it=
self and then to the file inside the repository. That means, for example, a=
 given repository cloned to C:\repo may not have issues, but the same repos=
itory cloned to C:\Users\Bryan\Documents\workspaces\repo may.
> > >
> > >>
> > >> However, as soon as the remote updates with any changes on a given
> > >> fetch/pull, the repo is put in a bad state permanently.
> > >>
> > >> I've pasted the output from gitk below...
> > >>
> > >> couldn't execute "git": file name too long
> > >> couldn't execute "git": file name too long
> > >>     while executing
> > >> "open $cmd r"
> > >>     (procedure "getallcommits" line 48)
> > >>     invoked from within
> > >> "getallcommits"
> > >>     (procedure "readcache" line 80)
> > >>     invoked from within
> > >> "readcache file827e200"
> > >>     ("eval" body line 1)
> > >>     invoked from within
> > >> "eval $script"
> > >>     (procedure "dorunq" line 11)
> > >>     invoked from within
> > >> "dorunq"
> > >>     ("after" script)
> > >>
> > >> Happy to gather whatever data needed.
> > >> Thanks!
> > >> - Bret Barkelew
> >
