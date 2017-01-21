Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D941F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 15:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbdAUPVX (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 10:21:23 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35956 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdAUPVX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 10:21:23 -0500
Received: by mail-wm0-f44.google.com with SMTP id c85so75308890wmi.1
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 07:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanburgh.me; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=Fj2FdxfO7KRRVA9npIQ08IHRsarGiWoyo1q5VqiAiq0=;
        b=A8D8IIFDgqovyDXgRQ7NtEf66fPo7Uw9e/Jfx1fS5MEs8AYtE8LPxlHDApMUm/uwos
         QVXEbl7ORNO1rqiBi+oQ+ySLjt8kAYoqPc5h42t8IV2Z6aM+QRJItmWZv6wSv/uoiXOw
         Ztq7MHnKo4muDOn956j/jg9fEktwwjy/FnA+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=Fj2FdxfO7KRRVA9npIQ08IHRsarGiWoyo1q5VqiAiq0=;
        b=abPk5EEENRCSU9OAlNm1q1Ya8uymXrYp4cVCvdR6AfTW/6bogICjJZrMf5GkNDlIi7
         zHBqtQB0Bl8fwkUO69uAmVpb2SZu40GirIzFYRIcnMPguXHHbgWPRCRm0X68+Kd9n8vP
         wozntGEhC/ztSxtsoOtZTqKkRqkV2FuD7/tc4nHlfofynFlPS1p9VQZN0GX1N/Jp4WUe
         3l+fJ82z2NFrrs/2sgdvThRchvXC2+EkR7dvlJoCm/skJFGGezMWrZFohxKpRPec8ihF
         JSD4cv5YhtdSqMS9Yy1ZyqCJf3M8+akgnqpxzEFdPmum5c4nUwt6AluHRHSMDBvNbBd4
         +hbw==
X-Gm-Message-State: AIkVDXLaC/ZK52XwqqQsCHC1Wr0nJZG60JhjXcEowM4se5BTu0vqoFiwa6y9Vk6NNysCFw==
X-Received: by 10.223.176.210 with SMTP id j18mr19261400wra.8.1485012081443;
        Sat, 21 Jan 2017 07:21:21 -0800 (PST)
Received: from TEMPEST ([149.18.92.226])
        by smtp.gmail.com with ESMTPSA id g5sm4900741wrd.0.2017.01.21.07.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jan 2017 07:21:20 -0800 (PST)
From:   "George Vanburgh" <george@vanburgh.me>
To:     "'Lars Schneider'" <larsxschneider@gmail.com>
Cc:     "'Git mailing list'" <git@vger.kernel.org>,
        "'Luke Diamand'" <luke@diamand.org>
References: <01020159c0e82598-e373cf0d-2bad-41bb-b455-6896ad183e22-000000@eu-west-1.amazonses.com> <A7425283-9C32-4AE8-A442-11B7CFEAB4E8@gmail.com>
In-Reply-To: <A7425283-9C32-4AE8-A442-11B7CFEAB4E8@gmail.com>
Subject: RE: [PATCH] git-p4: Fix git-p4.mapUser on Windows
Date:   Sat, 21 Jan 2017 15:21:20 -0000
Message-ID: <000f01d273fa$05358ee0$0fa0aca0$@vanburgh.me>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIUK6tOJOf2iHp2Y3A2khLXGqjAtAILtpD4oK8xL2A=
Content-Language: en-gb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 21 Jan 2017, at 13:33, Lars Schneider <larsxschneider@gmail.com>
> > On 21 Jan 2017, at 13:02, George Vanburgh <george@vanburgh.me>
> wrote:
> >
> > From: George Vanburgh <gvanburgh@bloomberg.net>
> >
> > When running git-p4 on Windows, with multiple git-p4.mapUser entries
> > in git config - no user mappings are applied to the generated
repository.
> >
> > Reproduction Steps:
> >
> > 1. Add multiple git-p4.mapUser entries to git config on a Windows
> >   machine
> > 2. Attempt to clone a p4 repository
> >
> > None of the user mappings will be applied.
> >
> > This issue is caused by the fact that gitConfigList, uses
> > split(os.linesep) to convert the output of git config --get-all into a
> > list.
> >
> > On Windows, os.linesep is equal to '\r\n' - however git.exe returns
> > configuration with a line seperator of '\n'. This leads to the list
> > returned by gitConfigList containing only one element - which contains
> > the full output of git config --get-all in string form. This causes
> > problems for the code introduced to getUserMapFromPerforceServer in
> > 10d08a1.
> >
> > This issue should be caught by the test introduced in 10d08a1, and
> > would require running on Windows to reproduce. When running inside
> > MinGW/Cygwin, however, os.linesep correctly returns '\n', and
> > everything works as expected.
> 
> This surprises me. I would expect `\r\n` in a MinGW env...
> Nevertheless, I wouldn't have caught that as I don't run the git-p4 tests
on
> Windows...

It appears I was mistaken - the successful tests I ran were actually under 
the Ubuntu subsystem for Windows, which (obviously) passed. 

Just did a quick experiment:

Git Bash (MinGW):
georg@TEMPEST MINGW64 ~
$ python -c "import os
print(repr(os.linesep))"
'\r\n'

Powershell:
PS C:\Users\georg> python -c "import os
>> print(repr(os.linesep))"
'\r\n'

Ubuntu subsystem for Windows:
george@TEMPEST:~$ python -c "import os
print(repr(os.linesep))"
'\n'

So this issue applies to git-p4 running under both PowerShell and MinGW.

> 
> 
> > The simplest fix for this issue would be to convert the line split
> > logic inside gitConfigList to use splitlines(), which splits on any
> > standard line delimiter. However, this function was only introduced in
> > Python 2.7, and would mean a bump in the minimum required version of
> > Python required to run git-p4. The alternative fix, implemented here,
> > is to use '\n' as a delimiter, which git.exe appears to output
> > consistently on Windows anyway.
> 
> Well, that also means if we ever use splitlines() then your fix below
would
> brake the code, right?
> 
> Python 2.7 was released 7 years ago in 2010. 

Now I feel old...

> Therefore, I would vote to
> bump the minimum version. But that's just my opinion :-)

I feel like splitlines is the better/safer fix - but figured bumping the
minimum 
Python version was probably part of a wider discussion. If it's something
people 
are comfortable with - I'd be happy to rework the fix to use splitlines.
Luke - do you have any thoughts on this?

> 
> 
> > Signed-off-by: George Vanburgh <gvanburgh@bloomberg.net>
> > ---
> > git-p4.py | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/git-p4.py b/git-p4.py
> > index f427bf6..c134a58 100755
> > --- a/git-p4.py
> > +++ b/git-p4.py
> > @@ -656,7 +656,7 @@ def gitConfigInt(key):
> > def gitConfigList(key):
> >     if not _gitConfig.has_key(key):
> >         s = read_pipe(["git", "config", "--get-all", key],
ignore_error=True)
> > -        _gitConfig[key] = s.strip().split(os.linesep)
> > +        _gitConfig[key] = s.strip().split("\n")
> 
> I can't easily reproduce this as I don't have a running git-p4 setup on
> Windows.
> However, your explanation and your fix make sense to me. If we don't want
> to bump the version then this looks good to me.
> 
> Cheers,
> Lars

