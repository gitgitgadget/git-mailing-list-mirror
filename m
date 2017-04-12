Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428CF20970
	for <e@80x24.org>; Wed, 12 Apr 2017 06:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbdDLGPu (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 02:15:50 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35992 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdDLGPs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 02:15:48 -0400
Received: by mail-oi0-f53.google.com with SMTP id r203so20816361oib.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 23:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=picussecurity.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dMHkWp/fohwUVmG8preGQ1YFJDmL9HTJEm4QqAkWkys=;
        b=aDv01+PVv61aOr8Erbbp8Yau0cfk6RiG7izXDU2Uf6BdUku4n/ZBSg5ZiW6lYYvqFh
         JBNjAXMfj2JeFeF6KMAWNQJd5lmfzUvP264c2wwYHQ1o6yYhuXiIVpTxZFpN+ylNqa+B
         UsTiYELJSFd4KDUu0pfy4AecGQeOOygSGqAIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dMHkWp/fohwUVmG8preGQ1YFJDmL9HTJEm4QqAkWkys=;
        b=JC38wruEmyUMILc9jxBdigxxPytGTuuWy61HUnQzlOoAsJtoZnRvRJGXRDYG+Bhs7z
         F5ndqtn+CetSr9urrGcHNOHWU67qrCJYf3zvYvcLMP6UKRRfwtcd9w00y7fJ/JnbJqgv
         KsUrNj6CI9vua2vFQNw/1PWP3MlUx/Ldly+TeOZM1/LaBTIS6psmMXxp1/sXjyCUBwK/
         ft5HGIFBS3fUxiKxi/Hm8KAowYOkS83PHyj9tB+j14KGX7CxW5PRivKBQ4rgCnjghrjc
         9COcmvyPG53MXmhlU4EnaZFU2T32XK09YR7tBrAAXAkK0Cafadb/DNP49k6CNFUWGyaj
         u41Q==
X-Gm-Message-State: AN3rC/6lSON6XPoHGhhcqMi/ekLkaSEOZ+SKMicgxkx34cJdk3/c3K3FvgjE/C66ZwvAopPbCFOMp0QBVpRkPQ==
X-Received: by 10.157.25.23 with SMTP id j23mr1602769ota.9.1491977747898; Tue,
 11 Apr 2017 23:15:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.1 with HTTP; Tue, 11 Apr 2017 23:15:47 -0700 (PDT)
In-Reply-To: <5704E476-BD11-47D1-A15E-C1E29A1398AD@grubix.eu>
References: <CAMLReHYBVmuu5H015N1ShCD0iLNau9oLOabJhQ7xc=58rXQi+Q@mail.gmail.com>
 <88df8638-9b7b-42c4-bb34-4e1a49d4c22d@grubix.eu> <CAMLReHYbuHmGTtBSUQq3bO=6ghz=rfP-=Eg=PvP0tkwZbM2Q1Q@mail.gmail.com>
 <CACBZZX7xqoZ3LboOjwvQvX3JRJFhjFC54+mfLOddLXzconrobw@mail.gmail.com> <5704E476-BD11-47D1-A15E-C1E29A1398AD@grubix.eu>
From:   =?UTF-8?Q?Enis_Bayramo=C4=9Flu?= <enis@picussecurity.com>
Date:   Wed, 12 Apr 2017 09:15:47 +0300
Message-ID: <CAMLReHa2M=h+cWm_9qqiL0n+E1+AFzHXqiBG45fGiGUBTdkseg@mail.gmail.com>
Subject: Re: `git status` output is very misleading after a merge on a
 "detached HEAD"
To:     Michael J Gruber <git@grubix.eu>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 8:43 AM, Michael J Gruber <git@grubix.eu> wrote:
> Am 11. April 2017 22:40:14 MESZ schrieb "=C3=86var Arnfj=C3=B6r=C3=B0 Bja=
rmason" <avarab@gmail.com>:
>>On Tue, Apr 11, 2017 at 5:13 PM, Enis Bayramo=C4=9Flu
>><enis@picussecurity.com> wrote:
>>>> Well, what do you suggest as an alternative?
>>>>
>>>> Git tells you that you are in detached state and where you came from
>>>> (detached from).
>>>
>>> I think it'd be best if git status somehow indicated that you're no
>>> longer at the same commit. Maybe something like:
>>>
>>> $ git status
>>> HEAD detached from origin/master, no longer at the same commit
>>> nothing to commit, working directory clean
>>
>>I'm not saying this is clear, I didn't know this until I read the code
>>just now, but for what it's worth it says "detached at" if you're
>>detached from BRANCH but at the same commit, and "detached from" if
>>you're now on a different commit.
>>
>
> That's what I explained in my first reply which the OP quoted in a choppe=
d way.  I think he even misquoted the git output he got.
>
> It's the difference between from and at.

You're right, I hadn't noticed the difference, I really thought I
copied the git output verbatim from the console, but I must've been
confused while switching windows. Sorry about that.

I consider myself fairly fluent in English, but it's not my native
language. If you think head detached "from" vs. "at" is immediately
and unambiguously clear about what's going on, then I guess it's not
worth changing the behavior.

>
>
>>> or, to be more informative
>>>
>>> HEAD detached from origin/master 1 commit ago,
>>
>>In lieu of that, which would need some of the rev-list machinery to be
>>invoked on every git-status, I wonder if just saying "HEAD detached &
>>diverged from origin/master" wouldn't be clearer:
>>
>>diff --git a/wt-status.c b/wt-status.c
>>index 308cf3779e..79c8cfd1cf 100644
>>--- a/wt-status.c
>>+++ b/wt-status.c
>>@@ -1542,7 +1542,7 @@ static void wt_longstatus_print(struct wt_status
>>*s)
>>                                if (state.detached_at)
>>                                      on_what =3D _("HEAD detached at ");
>>                                else
>>-                                       on_what =3D _("HEAD detached from
>>");
>>+                                       on_what =3D _("HEAD detached &
>>diverged from ");
>>                        } else {
>>                                branch_name =3D "";
>>                           on_what =3D _("Not currently on any branch.");
>>
>>
>>
>
> No way. That would reduce the information that we give.
>
> Note that the difference between from and at is also: are there commits t=
hat we could lose when we switch away, that is: that git checkout would war=
n us about?
>
> Maybe improve the doc instead?
>
>>
>>> On Tue, Apr 11, 2017 at 5:55 PM, Michael J Gruber <git@grubix.eu>
>>wrote:
>>>> Enis Bayramo=C4=9Flu venit, vidit, dixit 11.04.2017 10:57:
>>>>> I've encountered a very misleading output from `git status`. Here's
>>a
>>>>> sequence of events that demonstrates the issue:
>>>>>
>>>>> $ git --version
>>>>> git version 2.12.0
>>>>>
>>>>> $ git checkout origin/master
>>>>>
>>>>> $ git status
>>>>> HEAD detached from origin/master
>>>>> nothing to commit, working directory clean
>>>>
>>>> Hmm. My Git would display "detached at" here as long as you are on
>>the
>>>> commit that you detached from.
>>>>
>>>>> $ git merge --ff f3515b749be861b57fc70c2341c1234eeb0d5b87
>>>>>
>>>>> $ git status
>>>>> HEAD detached from origin/master
>>>>> nothing to commit, working directory clean
>>>>>
>>>>> $ git rev-parse origin/master
>>>>> e1dc1baaadee0f1aef2d5c45d068306025d11f67
>>>>>
>>>>> $ git rev-parse HEAD
>>>>> 786cb6dd09897e0950a2bdc971f0665a059efd33
>>>>>
>>>>> I think it's extremely misleading that `git status` simply reports
>>>>> "HEAD detached from origin/master" while this simply happens to be
>>a
>>>>> mildly relevant fact about some past state.
>>>>>
>>>>> Thanks and regards
>>>>>
>>>>
>>>> Well, what do you suggest as an alternative?
>>>>
>>>> Git tells you that you are in detached state and where you came from
>>>> (detached from).
>>>>
>>>> Michael
>

Thanks,
Enis
