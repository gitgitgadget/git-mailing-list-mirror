Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567CD1FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 12:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbdDLMTB (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 08:19:01 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33035 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbdDLMTA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 08:19:00 -0400
Received: by mail-io0-f171.google.com with SMTP id k87so23527906ioi.0
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DgWsVbVxbJbt9t1YTqbd0TUIkeq8PhRlJBzwLZ8izuk=;
        b=hXN+4vDC824DS6MSxld8gGE0Qm7UohMudxQ3CR6ZfX8d6YhSu9o0d6MHY6Knsz5SHl
         35vqexCTv+Q9g8FN8h4HrdLVdyrogN5C5PcR+vuin8LMAz2Eat2h9sQzvS/cSCBouYt+
         qPn9Xzv7tXYIE/4gWPMWLpWhKLuBgz/AFIEaPvq0ivi34kuidc92TBUgAxHYHQX7FlNo
         vWeXGhzpYFY0Bwb3i5Xi1KWXnP3Cpp5XUVAphwdhqVK34ZX8BG2qSyUWsRuS3UVQwvu5
         xNirvRkWsqKixr9UFqKoNREIvO2ORMgIXjta5jPQEDeeZ9lJ7Wl2+/PBZGa/V4GfOMoa
         bTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DgWsVbVxbJbt9t1YTqbd0TUIkeq8PhRlJBzwLZ8izuk=;
        b=EzdmhVwvS4ZYBPQdLJWrZ3tLIcbCu5qu5UKrWiX+Py3WF4s1HoI5CFJLLv12AHE/13
         xOQK8ToPPNGqttRirfXpjPKwL8q5Y3uq4Wjv68Jo1fQD/R73mBLp45ia1BxJEbxbt7Ce
         9jpMN+wN47grwGMPyB14nRtGmnhS79le5JvKaCam1cUO3svRP1+Jh7t/9wuLVw7JO0Yl
         xfWt/POvbovj1J4maQ1Sa7NjMS84GeSH4x8lkHzguepFprrpwKSv0ZB35Nia5rBZ+mHq
         8sGtM5sRSVuiYMGQK/f5pnVrSpddsVp4x92oZxiRVBcST0/ECuDYTV2RSpKYzOY/ufr+
         ZKxA==
X-Gm-Message-State: AN3rC/7Mt0IaLITWihKQR+1yObm0NGDR5BOtMgcSAYB+mj+c39/Azb0w
        Kkf5tX9HuYPtTbIaPnWNYQEnFA0GEHh7
X-Received: by 10.36.173.91 with SMTP id a27mr23200748itj.60.1491999538984;
 Wed, 12 Apr 2017 05:18:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Wed, 12 Apr 2017 05:18:38 -0700 (PDT)
In-Reply-To: <5704E476-BD11-47D1-A15E-C1E29A1398AD@grubix.eu>
References: <CAMLReHYBVmuu5H015N1ShCD0iLNau9oLOabJhQ7xc=58rXQi+Q@mail.gmail.com>
 <88df8638-9b7b-42c4-bb34-4e1a49d4c22d@grubix.eu> <CAMLReHYbuHmGTtBSUQq3bO=6ghz=rfP-=Eg=PvP0tkwZbM2Q1Q@mail.gmail.com>
 <CACBZZX7xqoZ3LboOjwvQvX3JRJFhjFC54+mfLOddLXzconrobw@mail.gmail.com> <5704E476-BD11-47D1-A15E-C1E29A1398AD@grubix.eu>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 12 Apr 2017 14:18:38 +0200
Message-ID: <CACBZZX4W1kk2cnncWz1EVjA-WtFryYzNoiiDHR9+9VC4AKJhKg@mail.gmail.com>
Subject: Re: `git status` output is very misleading after a merge on a
 "detached HEAD"
To:     Michael J Gruber <git@grubix.eu>
Cc:     =?UTF-8?Q?Enis_Bayramo=C4=9Flu?= <enis@picussecurity.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 7:43 AM, Michael J Gruber <git@grubix.eu> wrote:
> Am 11. April 2017 22:40:14 MESZ schrieb "=C3=86var Arnfj=C3=B6r=C3=B0 Bja=
rmason" <avarab@gmail.com>:
>>On Tue, Apr 11, 2017 at 5:13 PM, Enis Bayramo=C4=9Flu
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

How does it reduce the information we give? Maybe I've missed
something about what "from" means here, as opposed to "at", but it
seems to me to mean the same thing as "diverged" by definition, i.e.
we detached from the branch but we diverged from it. Saying "diverged"
just makes it clearer, how does it reduce the information we give?

> Note that the difference between from and at is also: are there commits t=
hat we could lose when we switch away, that is: that git checkout would war=
n us about?

Right, but I don't see how that's in any way conflicting or mutually
exclusive with saying before hand that we've diverged from the branch.

> Maybe improve the doc instead?

Aside from whether my patch makes any sense, the solution to a UX
issue really can't be "oh this just needs to be documented". For every
user who's confused by some interface we provide a *tiny* minority of
them go and exhaustively read the docs for an explanation, will just
remain confused.

I think saying from v.s. at is way too subtle, I for one have been
missing it for years until this thread, that's bad UX, git's also used
by a lot of non-native English speakers who may not at all get the
subtle difference between at and from in this context, or if they do
think the UI is using that subtlety to tell them something.
