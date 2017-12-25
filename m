Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406B21F406
	for <e@80x24.org>; Mon, 25 Dec 2017 17:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbdLYRxI (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 12:53:08 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:44160 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbdLYRxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 12:53:06 -0500
Received: by mail-wr0-f171.google.com with SMTP id l41so21036183wre.11
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 09:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=as00q7ydlC0JIrGz+4SIO7Q+O2IDemGHSlCR3470jr0=;
        b=or9vZj316wP2rgJ+IvoWW3/lTSurW3/fva0FhF3nXKlGQPPrwohozOkDZBh+b838k8
         Ie6HlrTDW3quaGNZyiFtnIfCOJqyqBeEpaaI0XJEq3DpQ8sdfuxSmE3J9UTKpvokO9MT
         pByVj6V+YVrqnDcOH2zjvyK7rhlHIajsV5B6gMunNtDDF3aCBjBakbs5R0w9PJtQAdRX
         kkoOhC8KFt9Wcw4ovjjGeMsN3NDPfyvRJznoVdON7GxNeGqKV0lkGnNerqaJeFfjQuRk
         dmjPIGebAMCA3oVhntPMGvzfLzqtyLUH+fgqywop0tbQtwnF/SLoARA60briPsDrcRLL
         9GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=as00q7ydlC0JIrGz+4SIO7Q+O2IDemGHSlCR3470jr0=;
        b=GCpE/Q0gDD8H50L8ad07ifjC1jPOHfhxh0LPWtw/I50pYj4xlqbjECDo0eHXxfbSAK
         rZZswrqac47NLF8PMwjo2YL84yEEzPKVllBT850jQr6euhyOMpagXHIor5qjiZsZ54+H
         35Sk4PFATsBsM9jDEC2jEx/uCxLT3+omaOeobb8N0xnxEJidxncIEMpztmPhjQt7e1n1
         5ZwuD1UmTRKiivxSz9+MMiw2Q9Gy29NeJiwwhCVurHjZsFW5hFvzceE6OMzZ5qijmzB6
         xiPe+mZ3npZ4gEMwpmE16x/v10NzV7Q26Bsuha1vQWm+kZsYnsWkGYHGPLI5G2ymfFZi
         gUbQ==
X-Gm-Message-State: AKGB3mItcjmbOTPejSP5mhZNvWwgLTBvVbAzuCAOCGkOJNGYbicoyrZL
        OI/tWpPrDrg9KJBtrR+7EU0xdGxbqwPSawmfdRg=
X-Google-Smtp-Source: ACJfBotQjOv0IHPHwRyNGa7KKYS6rJdRvBTAwRgGH/MvJgKclGlCEH0NCZCLCoaEZ8QkgPRcLEYWu2ucy52rxlVz4n4=
X-Received: by 10.223.133.210 with SMTP id 18mr16701552wru.199.1514224384988;
 Mon, 25 Dec 2017 09:53:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.163.195 with HTTP; Mon, 25 Dec 2017 09:52:44 -0800 (PST)
In-Reply-To: <87zi67rkab.fsf@evledraar.gmail.com>
References: <3853941514059379@web42g.yandex.ru> <alpine.DEB.2.21.1.1712232332000.406@MININT-6BKU6QN.europe.corp.microsoft.com>
 <1483761514103335@web45o.yandex.ru> <20171224171118.GD27280@alpha.vpn.ikke.info>
 <87zi67rkab.fsf@evledraar.gmail.com>
From:   Martin Werner <martinerikwerner@gmail.com>
Date:   Mon, 25 Dec 2017 18:52:44 +0100
Message-ID: <CABW-mG0R8aFmHc+ka_8ZtQ=iz8wnp9D6G64V25=2SS6rVYc=7A@mail.gmail.com>
Subject: Re: [PATCH] setup.c: move statement under condition
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>, Vadim Petrov <tridronet@yandex.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 24, 2017 at 8:35 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sun, Dec 24 2017, Kevin Daudt jotted:
>
>> On Sun, Dec 24, 2017 at 12:15:35PM +0400, Vadim Petrov wrote:
>>> Thank you for your replay.
>>>
>>> > I have to be honest: this commit message (including the subject) left=
 me
>>> > quite puzzled as to the intent of this patch.
>>>
>>> I still only learn English and correctly express my thoughts while some=
what difficult.
>>>
>>> > If you also have a background story that motivated you to work on thi=
s
>>> > patch (for example, if you hit a huge performance bottleneck with som=
e
>>> > tool that fed thousands of absolute paths to Git that needed to be tu=
rned
>>> > into paths relative to the worktree's top-level directory), I would
>>> > definitely put that into the commit message, too, if I were you.
>>>
>>> I have no such reason. I just saw it and wanted to change it.
>>
>> A commit message contains the reason why this is a good change to make.
>> It lets others know what problems it's trying to solve or what usecase
>> it tries to satisfy.
>>
>> The commit message basically needs to convince others why the change is
>> necessary / desired, now, and in the future.
>>
>> This will help others to follow your thought process and it gives you
>> the possiblity to communicate trade-offs you made, all which cannot
>> inferred from the patch.
>>
>> For simple changes, the motivation can be simple too.
>
> ...and a good example would be 6127ff63cf which introduced this logic
> Vadim is trying to change, i.e. does this still retain the fix for
> whatever issue that was trying to address?
>
> It's also good to CC the people who've directly worked on the code
> you're changing in the past, I've CC'd Martin.
>
>> To make it concrete: You are talking about a condition. What condition?
>> And you say that the previously obtained value will not be necessary.
>> What do you do with that value then? Why does this change improve the
>> situation?
>>
>> These are things you can state in your commit message.
>>
>> Hope this helps, Kevin
>>
>>> > Up until recently, we encouraged dropping the curly brackets from
>>> > single-line statements, but apparently that changed. It is now no lon=
ger
>>> > clear, and often left to the taste of the contributor. But not always=
.
>>> > Sometimes we start a beautiful thread discussion the pros and cons of
>>> > curly brackets in the middle of patch review, and drop altogether
>>> > reviewing the actual patch.
>>>
>>> I was guided by the rule from the Documentation/CodingGuidelines:
>>>      When there are multiple arms to a conditional and some of them
>>>      require braces, enclose even a single line block in braces for
>>>      consistency.
>>> And other code from setup.c:
>>>      from function get_common_dir:
>>>              if (!has_common) {
>>>                      /* several commands */
>>>              } else {
>>>                      free(candidate->work_tree);
>>>              }
>>>      from function get_common_dir_noenv:
>>>              if (file_exists(path.buf)) {
>>>                      /* several commands */
>>>              } else {
>>>                      strbuf_addstr(sb, gitdir);
>>>              }
>>>
>>> > In short: I think your patch does the right thing, and I hope that yo=
u
>>> > find my suggestions to improve the patch useful.
>>>
>>> I fixed the patch according to your suggestions.
>>>
>>>
>>> Signed-off-by: Vadim Petrov <tridronet@yandex.ru>
>>> ---
>>>  setup.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/setup.c b/setup.c
>>> index 8cc34186c..1a414c256 100644
>>> --- a/setup.c
>>> +++ b/setup.c
>>> @@ -27,26 +27,26 @@ static int abspath_part_inside_repo(char *path)
>>>  {
>>>      size_t len;
>>>      size_t wtlen;
>>>      char *path0;
>>>      int off;
>>>      const char *work_tree =3D get_git_work_tree();
>>>
>>>      if (!work_tree)
>>>              return -1;
>>>      wtlen =3D strlen(work_tree);
>>>      len =3D strlen(path);
>>> -    off =3D offset_1st_component(path);
>>>
>>> -    /* check if work tree is already the prefix */
>>> -    if (wtlen <=3D len && !strncmp(path, work_tree, wtlen)) {
>>> +    if (wtlen > len || strncmp(path, work_tree, wtlen))
>>> +            off =3D offset_1st_component(path);
>>> +    else { /* check if work tree is already the prefix */
>>>              if (path[wtlen] =3D=3D '/') {
>>>                      memmove(path, path + wtlen + 1, len - wtlen);
>>>                      return 0;
>>>              } else if (path[wtlen - 1] =3D=3D '/' || path[wtlen] =3D=
=3D '\0') {
>>>                      /* work tree is the root, or the whole path */
>>>                      memmove(path, path + wtlen, len - wtlen + 1);
>>>                      return 0;
>>>              }
>>>              /* work tree might match beginning of a symlink to work tr=
ee */
>>>              off =3D wtlen;
>>>      }

As far as I can tell this retains existing functionality.

Is this intended as just a style change or a speculative performance
change?

So the general concept is:

x =3D fa();

if (...) {
  if (...) {
    return 0;
  }
  x =3D fb();
}

being rewritten as

if (...) {
  if (...) {
    return 0;
  }
  x =3D fb();
} else {
  x =3D fa();
}

or, in the last iteration

if (!...) {
  x =3D fa();
} else {
  if (...) {
    return 0;
  }
  x =3D fb();
}

which (at least conceptually) avoids setting x unnecessarily when we do
the early return.

I think the last iteration might suffer a bit from the condition
inversion, since the comment feels a bit odd placed there at the
"} else {" line, and if it were to be placed at the top, it would have
to be negated "check if work tree is NOT already the prefix". Therefore
I think the original or the first iteration might be a tad better from a
readability perspective.


(Going down this path, We could potentially also remove the 'off'
variable completely, increment the 'path' pointer directly, and set
the 'path0' pointer before, not sure if that's a good idea though...)

--
Martin Erik Werner <martinerikwerner@gmail.com>
