Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F125D20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 19:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbdFATqO (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 15:46:14 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37258 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdFATqM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 15:46:12 -0400
Received: by mail-it0-f44.google.com with SMTP id m47so725256iti.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nli/kYdKbBRgjsvMjc5jDdP2rQ2umPESLo9LWZOIwE0=;
        b=gvftZxMHyUcBMX33HuA2ZGMrnr5WftzZ1iZKv7ooif2X7S4ybehLPsFkXEKeLoFg4X
         dC6FQIJDvjQrpKSd/sfwJDkrAW4HsHJNkhzhQOToYgT0GJRQAIxiT8HvxQPgRMgxmjLj
         7O5+cYfKPbsrZGgNe8aYHLr+XEWZeyQLwYYscEP6MEHoW5ytqWAzoZ95yq0MP+Tue5Cc
         ARHpSpjsLtg6SzAMOxqGt950MNiLha+gquBEdpsQj/m0fhof+yKiTPOoFMOCIM7EXvcw
         e4gQEtMf0k59ika273QPMJ0rFyfxUhw3ZR8Om3aqsKqsoMuIvXy/tzMRExn4lwSZcP5a
         zD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nli/kYdKbBRgjsvMjc5jDdP2rQ2umPESLo9LWZOIwE0=;
        b=EGwDoNDBIIOR7WyfyBSB7aaprTW8zKx+BbsgWbr94JjX0LSKOZYhvu9AtCIFNTK2+N
         VuFgxcKSj7dmQGFjI9g5yYj7yQNC4CiLvVR7LCPaASkaqIKTnGWzFh/GblJr/rWQABMu
         vlRx82aG96HCO9LQ/zy4FLYNqBWzSc8ygA6S+rk+mNphqO1aCheafNkjQcowgF3IZohZ
         ot21h6w6cnSUyHV/EpINxIDzaH1AJEKKPo/KY1OST6rhVLedde0ir9lR7JtxaPrSQrld
         X/puQE40aaa19USQ0zYxpwn7vf44i8q43JcYkvRbxfnLXPAaNzGEJGo24yUYBkP1Y6ZB
         T10g==
X-Gm-Message-State: AODbwcADM5vRRuYRBuD+Pm+iFynUEOdIUwzYCC1QEnLAGl6XVLBuR6IU
        HluJnkyhiJa6VWO175IbnTD/VTe2WQ==
X-Received: by 10.36.29.150 with SMTP id 144mr975456itj.71.1496346372003; Thu,
 01 Jun 2017 12:46:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 1 Jun 2017 12:45:51 -0700 (PDT)
In-Reply-To: <20170531214019.bbhjdaejvgje3v6g@sigill.intra.peff.net>
References: <CA+dzEBn4EKzDqS0pCHHsPtGGJc1orf5weKKh0GN-GkE+fVYGcg@mail.gmail.com>
 <CACBZZX7OhdRM+Mhx4FVX-Upvq169ZLvArL5ZxcTgz8u=WRh3aw@mail.gmail.com> <20170531214019.bbhjdaejvgje3v6g@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 1 Jun 2017 21:45:51 +0200
Message-ID: <CACBZZX5j=g=Lnv-X9F5Uaf0wW922R3N=LgrzRKPw853ECmoqYQ@mail.gmail.com>
Subject: Re: bug: `git log --grep ... --invert-grep --author=...` negates /
 ignores --author
To:     Jeff King <peff@peff.net>
Cc:     Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 11:40 PM, Jeff King <peff@peff.net> wrote:
> On Wed, May 31, 2017 at 08:08:54PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> $ git log --grep=3Dbar --author=3D=C3=86var --pretty=3Dformat:%an -100 o=
rigin/pu
>> |sort|uniq -c|sort -nr
>> 5 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>
>> $ git log --author=3D=C3=86var --pretty=3Dformat:%an -100 origin/pu |sor=
t|uniq
>> -c|sort -nr
>> 100 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>
>> $ git log --grep=3Dbar --invert-grep --author=3D=C3=86var --pretty=3Dfor=
mat:%an
>> -100 origin/pu |sort|uniq -c|sort -nr
>>      78 Junio C Hamano
>>      14 Jeff King
>>       2 Andreas Heiduk
>>       1 Sahil Dua
>>       1 Rikard Falkeborn
>>       1 Johannes Sixt
>>       1 Johannes Schindelin
>>       1 Ben Peart
>>       1 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>
>> That last command should only find my commits, but instead --author is
>> discarded.
>
> I would have thought that the last command wouldn't find _any_ of your
> commits. Don't we consider --author a greppable pattern and invert it?

There's two unrelated things going on here AFAICT:

* Anthony expected --author to be inverted by --invert-grep, but this
is not how it's documented, it's *only* for inverting the --grep
pattern: "Limit the commits output to ones with log message that do
not match the pattern specified with --grep=3D<pattern>."

* The --author filter should be applied un-inverted, but isn't, it's
seemingly just ignored in the presence of --grep, actually mostly
ignored, this is bizarre:

$ diff -ru <(git log --grep=3Dbar --invert-grep --pretty=3Dformat:%an -100
origin/pu |sort|uniq -c|sort -nr) <(git log --grep=3Dbar --invert-grep
--pretty=3Dformat:%an -100 --author=3DWeMostlyIgnoreThisButNotReally
origin/pu |sort|uniq -c|sort -nr)
--- /dev/fd/63  2017-06-01 21:44:08.952583804 +0200
+++ /dev/fd/62  2017-06-01 21:44:08.952583804 +0200
@@ -1,6 +1,6 @@
-     66 Junio C Hamano
+     65 Junio C Hamano
      10 Jeff King
-      8 Stefan Beller
+      9 Stefan Beller
       5 Lars Schneider
       2 SZEDER G=C3=A1bor
       1 Tyler Brazier


> By itself:
>
>   $ git log --author=3D=C3=86var --invert-grep --format=3D%an -100 origin=
/pu |
>     sort | uniq -c | sort -rn
>        79 Junio C Hamano
>         8 Stefan Beller
>         8 Jeff King
>         1 Sahil Dua
>         1 Rikard Falkeborn
>         1 Johannes Sixt
>         1 Johannes Schindelin
>         1 Andreas Heiduk
>
> So that makes sense from the "--author is invertable" world-view.
>
> But I'm puzzled that you show up at all when --grep=3Dbar is added (and
> moreover, that we get _one_ commit from you, not the 5 found in your
> initial command). That seems like a bug.

I think that's the only thing that's not a bug, i.e. we just find 1
match in the first 100 (note -100), sorry for the confusing example.

Anyway, much of the above may be incorrect, I haven't dug deeply
beyond just finding that something's funny going on and we definitely
have *some* bugs here.
