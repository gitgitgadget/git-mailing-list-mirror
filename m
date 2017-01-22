Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71E320A17
	for <e@80x24.org>; Sun, 22 Jan 2017 14:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbdAVOPi (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 09:15:38 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38429 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdAVOPg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 09:15:36 -0500
Received: by mail-wm0-f47.google.com with SMTP id r144so115459968wme.1
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 06:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanburgh.me; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=3fqsjwfTsvjs5quEtdo6DYYzFNoJWgtXJXO9tmRijGA=;
        b=ccRq+Kx1KXhHqOzge80qjv2Fn+wUHAduwnRlgTKRh6k5ERLl/AVM5pYOCj+IVwGCHh
         jdBdgj3wHMES6D6tAzZMG/rsg/Wq1PwyG9wKRtDhBcNEzwLND5pMAHAzliHbWWj45YtM
         6kcFNEPAlnJNcywdXoD1GOfds6gVvyhr7G8RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=3fqsjwfTsvjs5quEtdo6DYYzFNoJWgtXJXO9tmRijGA=;
        b=G/Qbord1IYxHAFiAwL7h8J8Knlax956kIYQSYjYA6tnu+2dXltH3c4Iib6lDUjWmvS
         yO6LzejJFcxR9e8hrB+WvE+ufxp9PKN/ES455DD3PfmSaBbUWE/lsoi3fqEFnLQuZKxw
         UP67+I9zlh5LH35s/VIzrgVaqy20xnHN24YP29emK6jkLStPn7vOfJ5mr+KckT4ZFtJ3
         M922k5f8cC3tjwOHaZB+qOPAzcgQbVOEv/Jx49YbgtWj688psNc0uHUviuKAuDYoOqrz
         Um8FhQORQZXkx5l0Brf9EkvfuHA/4myos+mtqoKm5BKUbERANCkE/to4vunrM8eSnxuf
         yRdQ==
X-Gm-Message-State: AIkVDXKiXT0cReKIQIIf9XH7KdlR1FlFrm9h9uk0hBwPfQJeIglNzWLq4hDlrPWtyKchBg==
X-Received: by 10.28.206.136 with SMTP id e130mr10052867wmg.121.1485094500595;
        Sun, 22 Jan 2017 06:15:00 -0800 (PST)
Received: from TEMPEST ([149.18.92.226])
        by smtp.gmail.com with ESMTPSA id k195sm16134372wmd.7.2017.01.22.06.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jan 2017 06:14:59 -0800 (PST)
From:   "George Vanburgh" <george@vanburgh.me>
To:     "'Luke Diamand'" <luke@diamand.org>
Cc:     "'Lars Schneider'" <larsxschneider@gmail.com>,
        "'Git mailing list'" <git@vger.kernel.org>
References: <01020159c0e82598-e373cf0d-2bad-41bb-b455-6896ad183e22-000000@eu-west-1.amazonses.com> <A7425283-9C32-4AE8-A442-11B7CFEAB4E8@gmail.com> <000f01d273fa$05358ee0$0fa0aca0$@vanburgh.me> <CAE5ih7_+Vc9oqKdjo8h2vgZPup4pto9wd=sBb=W6hCs4tuW2Jg@mail.gmail.com>
In-Reply-To: <CAE5ih7_+Vc9oqKdjo8h2vgZPup4pto9wd=sBb=W6hCs4tuW2Jg@mail.gmail.com>
Subject: RE: [PATCH] git-p4: Fix git-p4.mapUser on Windows
Date:   Sun, 22 Jan 2017 14:14:59 -0000
Message-ID: <001901d274b9$eaad3f80$c007be80$@vanburgh.me>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIUK6tOJOf2iHp2Y3A2khLXGqjAtAILtpD4AtMcqZ8CKjEqhqCIz5Cg
Content-Language: en-gb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 22 Jan 2017, at 13:05, Luke Diamand <luke@diamand.org>
>=20
> I'm confused....see below.

That now makes two of us!=20
I think I've figured out where I messed up, see below.

>=20
> On 21 January 2017 at 15:21, George Vanburgh <george@vanburgh.me>
> wrote:
> >> On 21 Jan 2017, at 13:33, Lars Schneider <larsxschneider@gmail.com>
> >> > On 21 Jan 2017, at 13:02, George Vanburgh <george@vanburgh.me>
> >> wrote:
> >> >
> >> > From: George Vanburgh <gvanburgh@bloomberg.net>
> >> >
> >> > When running git-p4 on Windows, with multiple git-p4.mapUser
> >> > entries in git config - no user mappings are applied to the
> >> > generated
> > repository.
> >> >
> >> > Reproduction Steps:
> >> >
> >> > 1. Add multiple git-p4.mapUser entries to git config on a Windows
> >> >   machine
> >> > 2. Attempt to clone a p4 repository
> >> >
> >> > None of the user mappings will be applied.
> >> >
> >> > This issue is caused by the fact that gitConfigList, uses
> >> > split(os.linesep) to convert the output of git config --get-all
> >> > into a list.
> >> >
> >> > On Windows, os.linesep is equal to '\r\n' - however git.exe =
returns
> >> > configuration with a line seperator of '\n'. This leads to the =
list
> >> > returned by gitConfigList containing only one element - which
> >> > contains the full output of git config --get-all in string form.
> >> > This causes problems for the code introduced to
> >> > getUserMapFromPerforceServer in 10d08a1.
> >> >
> >> > This issue should be caught by the test introduced in 10d08a1, =
and
> >> > would require running on Windows to reproduce. When running =
inside
> >> > MinGW/Cygwin, however, os.linesep correctly returns '\n', and
> >> > everything works as expected.
> >>
> >> This surprises me. I would expect `\r\n` in a MinGW env...
> >> Nevertheless, I wouldn't have caught that as I don't run the git-p4
> >> tests
> > on
> >> Windows...
> >
> > It appears I was mistaken - the successful tests I ran were actually
> > under the Ubuntu subsystem for Windows, which (obviously) passed.
> >
> > Just did a quick experiment:
> >
> > Git Bash (MinGW):
> > georg@TEMPEST MINGW64 ~
> > $ python -c "import os
> > print(repr(os.linesep))"
> > '\r\n'
> >
> > Powershell:
> > PS C:\Users\georg> python -c "import os
> >>> print(repr(os.linesep))"
> > '\r\n'
> >
> > Ubuntu subsystem for Windows:
> > george@TEMPEST:~$ python -c "import os print(repr(os.linesep))"
> > '\n'
> >
> > So this issue applies to git-p4 running under both PowerShell and =
MinGW.
> >
> >>
> >>
> >> > The simplest fix for this issue would be to convert the line =
split
> >> > logic inside gitConfigList to use splitlines(), which splits on =
any
> >> > standard line delimiter. However, this function was only =
introduced
> >> > in Python 2.7, and would mean a bump in the minimum required
> >> > version of Python required to run git-p4. The alternative fix,
> >> > implemented here, is to use '\n' as a delimiter, which git.exe
> >> > appears to output consistently on Windows anyway.
>=20
> Have you tried a 2.6 Python with splitlines? I just tried this code =
and it seems
> fine.
>=20
> > val =3D s.strip().splitlines()
> > print("splitlines:", val)
>=20
> Tried with 2.7 and 2.6, and bot print out an array of strings returned =
from
> read_pipe().
>=20
> And 'grep -r splitlines' on the Python2.6 source has lots of hits.

Ah - it appears I was looking in the wrong part of the Python=20
documentation - which is what lead me to think this.=20
From the Python 2.4 documentation:

https://docs.python.org/release/2.4/lib/string-methods.html

Splitlines is a built-in method, not part of the string class.

> george@TEMPEST:~# /home/george/.pyenv/versions/2.4.1/bin/python -c =
'import string
> print("test1\ntest2\r\ntest3".splitlines())'
> ['test1', 'test2', 'test3']

>=20
> >>
> >> Well, that also means if we ever use splitlines() then your fix =
below
> > would
> >> brake the code, right?
> >>
> >> Python 2.7 was released 7 years ago in 2010.
> >
> > Now I feel old...
>=20
> :-)
>=20
> >
> >> Therefore, I would vote to
> >> bump the minimum version. But that's just my opinion :-)
> >
> > I feel like splitlines is the better/safer fix - but figured bumping
> > the minimum Python version was probably part of a wider discussion. =
If
> > it's something people are comfortable with - I'd be happy to rework
> > the fix to use splitlines.
> > Luke - do you have any thoughts on this?
>=20
> I agree that we have to stop supporting 2.6 at some point (and start
> supporting 3.x, but that's another world of hurt). But does 2.6 really =
not have
> splitlines?

The minimum supported version is currently Python 2.4, no?

>=20
> If you send a patch with splitlines I can try it out (although I guess =
it could be
> broken under Windows).

Given that there doesn't _actually_ seem to be an issue with using =
splitlines in
2.4 (sorry for the confusion!) - I'll test out a patch using splitlines =
on=20
Windows, and resubmit =3D]

>=20
> Luke

