Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCEB61F462
	for <e@80x24.org>; Wed, 29 May 2019 16:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfE2Qkz (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 12:40:55 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52938 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfE2Qkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 12:40:55 -0400
Received: by mail-it1-f194.google.com with SMTP id t184so4992506itf.2
        for <git@vger.kernel.org>; Wed, 29 May 2019 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corthon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dZb2r+q1pRpUGOX7Pprltu0Dnlkmahrv/tbJTpxt67U=;
        b=1ionzWqOkXUSZzKhoviXe5g3cmH7G2iw3pX1NlWQ1DStllBGWP3EdM84XD29SD7Hxl
         Cujlf1DN4sFzOa3wnjqcmTkHceiK6a+/5holudaJ4N5+fVCe3UGuRnQljCoVz/vXtGuQ
         9/Muez/FU4JEjvIKJCK11FcF1bb+EW6+mTaIjr3PDVtH9c/SABkX4HnJ8iiw1hA4tpoW
         JdNX6C9x5ImuT6x4FfItdok/YJGftO7ZbF/9RAj9XCUl056tBsbmt0833kMJUoJwSVOl
         DHpNmqH2fQ9hyCGLjkg9Iy0aBtcfsW7/PRDy22yxkiRHRKCClQsllkIv+A/mxNd69lwM
         3JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dZb2r+q1pRpUGOX7Pprltu0Dnlkmahrv/tbJTpxt67U=;
        b=aHw2MxJ+2irM623twcbjNgwe9JEcKz80tCpDg0WIZa7lJH4N/s/Z9AOJoOQWeY9I0Q
         qSvjalXfwAK7CkjzQrzwvRRCCKA8fRhNRqQUVZ26FMwH4zt1XbIj53zBm5/Tq7KUnoF+
         kIGbcd1KLQNU8BjdmZMMoT2Wy9lZ4CiO5x3NsR8IebVxW3JIGMIeZWOjekLM5lZWDQIV
         ghVH/vbPY0FQIWGfgkHjZDVTwtDMK7D0NubClHXKScLbTKb7M7zhJ8ua6HWDP9oRW8NZ
         n0PCBqJrr0jw/iExJkxNAf8rhrlGLB3cToTchjY49kVbh6/7c3aJVBgTwc54It+p4wHS
         d9MQ==
X-Gm-Message-State: APjAAAW3q5OKlNoKdHXyNxQH8JxSAqKoOdfiRHBipISam0E5Y3nO1yKg
        FUky3v7PgLpE8BQSEofqIPEKmZjJVEyn6llpz5Q=
X-Google-Smtp-Source: APXvYqwuIqBOm1vWxmffPBqIWUG+CDbnGm1cP/aBeO2D4LmVSx5IYUCYuapTWrVVtrjNubxY4wX//HpBKdKfBhv6Wq8=
X-Received: by 2002:a05:660c:f87:: with SMTP id x7mr8632413itl.163.1559148049572;
 Wed, 29 May 2019 09:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAGTkKag2sFy+Of=6uQeiGOQm0-NBrh9ixgzDoQXKR73+Ct3raQ@mail.gmail.com>
 <CAGyf7-HcncFOfmm5McEkOvCTkHNdePDSEQDZwEAK=z1bmC=QKw@mail.gmail.com>
 <CAGTkKag-fTy3iZAKJxEnWD6_b_3pfuYvQQKBkLaeSL8wKM2sfg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901091936420.41@tvgsbejvaqbjf.bet> <CAGTkKajkW-U9mhh_GmTXmZQbnceEKX_BcMtOF4hOhEDZe2u9Bw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901101616100.41@tvgsbejvaqbjf.bet> <CAGTkKagTCw-EcMo3M1P3XVtjbTcm4HPjCWGZ1sM_NnJwH7v_hg@mail.gmail.com>
 <CAGTkKajYiyT_OtX1mQECvxjvKXndjBYAqwgKMimJrroPAAvZJA@mail.gmail.com> <nycvar.QRO.7.76.6.1904271722290.45@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1904271722290.45@tvgsbejvaqbjf.bet>
From:   Bret Barkelew <bret@corthon.com>
Date:   Wed, 29 May 2019 09:40:40 -0700
Message-ID: <CAGTkKagwzceU51O6dK_6-MRZdEW52-xEFoGBVf9z9XLVEJoAGg@mail.gmail.com>
Subject: Re: git version 2.20.1.windows.1 throws file name too long in gitk
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I know it's an incredibly late reply, but I have not seen this issue
reappear since the patches. Thank you very much for helping!

- Bret

On Sat, Apr 27, 2019 at 4:20 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Bret,
>
> On Thu, 18 Apr 2019, Bret Barkelew wrote:
>
> > This issue is now being reported by more users inside MS. I'll also
> > reach out to the Git for Windows advocacy group to see if they have
> > any ideas.
> >
> > I have not had time to figure out the inner workings of Tcl/Tk. Is
> > there any way to turn on tracing/logging in Git for which commands are
> > being called by gitk?
>
> Thank you for reaching out with detailed information internally, I am
> happy to report that together with the help of Max Kirillov, this is now
> resolved and a snapshot is available from
> https://wingit.blob.core.windows.net/files/index.html that has the fix.
>
> Ciao,
> Johannes
>
> > On Thu, Jan 10, 2019 at 10:55 AM Bret Barkelew <bret@corthon.com> wrote=
:
> > >
> > > On Thu, Jan 10, 2019 at 7:20 AM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > Hi Bret,
> > > >
> > > > in that case, please try to find a way to trace the commands in a T=
cl/Tk
> > > > program (which gitk is) and see which command triggers the error.
> > >
> > > Er... that's a little out of my depth. I'll see if I can find time to=
 learn.
> > > Meanwhile, is there any way to request better instrumentation for the
> > > error dialog so this data could have been collected for me?
> > >
> > > >
> > > > Ciao,
> > > > Johannes
> > > >
> > > >
> > > > On Wed, 9 Jan 2019, Bret Barkelew wrote:
> > > >
> > > > > Will try to reply in-line, when appropriate.
> > > > > The latest snapshot (git version 2.20.1.windows.1.5.g6b286585b1) =
still
> > > > > has the issue.
> > > > >
> > > > > - Bret
> > > > >
> > > > >
> > > > > On Wed, Jan 9, 2019 at 10:39 AM Johannes Schindelin
> > > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > > >
> > > > > > Hi Bret,
> > > > > >
> > > > > >
> > > > > > On Thu, 3 Jan 2019, Bret Barkelew wrote:
> > > > > >
> > > > > > > They are the exact same path (with a different drive letter).
> > > > > >
> > > > > > [it's a bit hard to follow the thread if you top-post a reply t=
o an
> > > > > > inline-replied answer, maybe imitate the style of other mails i=
n the
> > > > > > future.]
> > > > > >
> > > > > > > Another thing I've been able to confirm is I uninstalled git =
2.20.1
> > > > > > > and installed 2.19.0 on the failing system, and the older ver=
sion of
> > > > > > > Git works.
> > > > > > > I've also tried a suggested fix I saw elsewhere to enable lon=
g path
> > > > > > > names in the Windows registry, which did not resolve the issu=
e with
> > > > > > > git 2.20.1.
> > > > > > >
> > > > > > > Happy to collect any additional data.
> > > > > >
> > > > > > Please try the latest snapshot at
> > > > > > https://wingit.blob.core.windows.net/files/index.html (I *think=
* the bug
> > > > > > might be fixed via
> > > > > > https://github.com/git-for-windows/MINGW-packages/pull/32).
> > > > > >
> > > > > > Ciao,
> > > > > > Johannes
> > > > > >
> > > > > > > - Bret
> > > > > > >
> > > > > > > On Thu, Jan 3, 2019 at 7:10 PM Bryan Turner <bturner@atlassia=
n.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jan 3, 2019 at 6:21 PM Bret Barkelew <bret@corthon.=
com> wrote:
> > > > > > > >>
> > > > > > > >> When I open gitk in a particular repository under this ver=
sion of Git
> > > > > > > >> for Windows, I now get a dialog box that says "Error: coul=
dn't execute
> > > > > > > >> "git": file name too long". I've noticed that the most pro=
nounced
> > > > > > > >> effect is that I cannot see the file diffs (or sometimes t=
he file name
> > > > > > > >> list) for any of the commits. I don't know the exact repro=
, but I've
> > > > > > > >> narrowed down the following things:
> > > > > > > >>
> > > > > > > >> - This does not happen with the same repo if I use a syste=
m that has
> > > > > > > >> git 2.19.0.windows.1 on another machine.
> > > > > > > >> - This does not happen on my current machine in a freshly =
cloned repo.
> > > > > > > >
> > > > > > > >
> > > > > > > > How =E2=80=9Cdeep=E2=80=9D are the paths to the different c=
lones on the different systems? Are all of the clones at exactly the same p=
ath on disk?
> > > > > > > >
> > > > > > > > Git on Windows is (by defaulted) limited by MAX_PATH, which=
 is 260 characters. That length is calculated including the path to the rep=
ository itself and then to the file inside the repository. That means, for =
example, a given repository cloned to C:\repo may not have issues, but the =
same repository cloned to C:\Users\Bryan\Documents\workspaces\repo may.
> > > > > > > >
> > > > > > > >>
> > > > > > > >> However, as soon as the remote updates with any changes on=
 a given
> > > > > > > >> fetch/pull, the repo is put in a bad state permanently.
> > > > > > > >>
> > > > > > > >> I've pasted the output from gitk below...
> > > > > > > >>
> > > > > > > >> couldn't execute "git": file name too long
> > > > > > > >> couldn't execute "git": file name too long
> > > > > > > >>     while executing
> > > > > > > >> "open $cmd r"
> > > > > > > >>     (procedure "getallcommits" line 48)
> > > > > > > >>     invoked from within
> > > > > > > >> "getallcommits"
> > > > > > > >>     (procedure "readcache" line 80)
> > > > > > > >>     invoked from within
> > > > > > > >> "readcache file827e200"
> > > > > > > >>     ("eval" body line 1)
> > > > > > > >>     invoked from within
> > > > > > > >> "eval $script"
> > > > > > > >>     (procedure "dorunq" line 11)
> > > > > > > >>     invoked from within
> > > > > > > >> "dorunq"
> > > > > > > >>     ("after" script)
> > > > > > > >>
> > > > > > > >> Happy to gather whatever data needed.
> > > > > > > >> Thanks!
> > > > > > > >> - Bret Barkelew
> > > > > > >
> > > > >
> >
