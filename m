Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD7C33CB1
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 15:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5579C2072B
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 15:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAj9SK1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgANPV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:21:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36522 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgANPV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 10:21:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id m2so8093050otq.3
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 07:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=j6iR43TQnAGKyeV6kAwVnqcu5FtJPvjwDdylNWuWarg=;
        b=HAj9SK1mLN/WwpCSGWKfik+/aeGpxDa+cK5j8xSLmHaV79jKrJtqg9AUQLN1fgLD7M
         ddsOHXJZTLK/V1ihDJTLUCJXSLUW6jRi7IYvIpkYRZj2+PFEsbP8PuIvVQTz11/+SG12
         qlyeX4Erpe5fFop/6FqKzpePlIn5wcBT+GPWgGd+0TA+W+FzeOsC4oginQ4y84TApTZz
         w2vNrPulARCdI936a8zMZOfmCB7yMtOb8ZfC/pOX0yHzdvKri7rcrD3xKMf5SZJ3rCns
         ocyXne281vaCO/qZwjCKfLUlDOOhNaVbjHTJCpN7drgJWzaL4C2S91ItwdX4Cm+QdF/c
         EGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=j6iR43TQnAGKyeV6kAwVnqcu5FtJPvjwDdylNWuWarg=;
        b=BL2ucxUP+fxGzI+Wh2ocw0u3XgLrWqg5H4RuSMfs3/uyd5dJ2OCr2PQZzgdCqXPB0P
         XTpsFOhEZZj8SbJx3DYPWGWhzbPrxen1v8XrYVSOLocvevKM7X0xAkSjXAjzZ5k0+OLf
         HuNJ09E2gWC69N4v8UHvgP04kKczYXPCh1TkpO1s5AfaPZHd8eR2fuHeLx8eIr9EDc8D
         qlqi3cLQv6jLLmxcmIUsvlbC8En7u9HngOmbu/+ZbbbtwrCgf4UpCZhsNywY1wrWPb3T
         l2kTuTfoGsmyEKDclSj/zTFL0y16PBUkAvTNXM4ZUMrLZWk0FJJmCNv7TPUSiTCpwD97
         F5/g==
X-Gm-Message-State: APjAAAU07dS27FH8HOJhrcYrsriK+c5fZ0CoqCbSPBExV09n1jeHb8vm
        4/dol4wEAV6vJFbVAcHndlJTCLAobnEhETn/R6bj5WBFes0=
X-Google-Smtp-Source: APXvYqzbbDtHsatZ0pZ+4qwQAT2OOCWsU9i3sia1llJpNd6ANbp5hShF6WTB5/PdnSQqXJK9eedM2PA/+s5yWg5K3os=
X-Received: by 2002:a9d:7357:: with SMTP id l23mr16397168otk.10.1579015316176;
 Tue, 14 Jan 2020 07:21:56 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Tue, 14 Jan 2020 17:21:20 +0200
Message-ID: <CAHMHMxWpLAnj3w8DGLMFbfy-A-pBjDxNdMeiM-fyuu-gnZyg+Q@mail.gmail.com>
Subject: Git alias syntax help
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I am having an issue with git-aliases - specifically, the intricacies
involved in their syntax.

In general, the syntax is confusing to me, especially when it is
_wise_ to use quotes inside a `!sh` alias.
e.g. which one would be the correct one
new =3D "!f() { : git log ; git log \"${1}@{1}..${1}@{0}\" \"$@\" ; } ; f"
new =3D !f() { : git log ; git log "${1}@{1}..${1}@{0}" "$@" ; } ; f

(from converting this:
https://git.wiki.kernel.org/index.php/Aliases#What.27s_new.3F)
        new =3D !sh -c 'git log $1@{1}..$1@{0} "$@"'

The alias confusing me is more specifically this:
https://git.wiki.kernel.org/index.php/Aliases#simple_diff_ignoring_line_num=
ber_changes

diffsort =3D !sh -c 'git diff "$@" | grep "^[+-]" | sort --key=3D1.2 | uniq=
 -u -s1'

The output of:
$  colordiff -su <(git diffsort HEAD^..HEAD) <(git diffsort HEAD^^..HEAD^)
Files /dev/fd/63 and /dev/fd/62 are identical
is a little unexpected, since I know for a fact that one of the
referced commits is not a code block moved.

(and indeed, if I do it myself:
$ colordiff -su <(git diff HEAD^..HEAD | grep "^[+-]" | sort --key=3D1.2
| uniq -u -s1) <(git diff HEAD^^..HEAD^ | grep "^[+-]" | sort
--key=3D1.2 | uniq -u -s1)
--- /dev/fd/63 2020-01-14 17:17:45.103771745 +0200
+++ /dev/fd/62 2020-01-14 17:17:45.103771745 +0200
@@ -1,2 +1,13 @@
[....]

it works.

The issue I have found is: $@ is not expanded

Tested with:

diffsort =3D !sh -c 'echo "+git diff $@" | grep "^[+-]" | sort --key=3D1.2
| uniq -u -s1'
$ git diffsort HEAD^..HEAD
+git diff

I would appreciate if someone would clear out the air for me.
I think I have done my homework enough, and it is not trivially
obvious what is the correct thing to do.

I'll gladly take pointers though

=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=
=CE=BF=CF=82
