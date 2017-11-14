Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 921181F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 12:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754944AbdKNMbc (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 07:31:32 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:43534 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbdKNMbb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 07:31:31 -0500
Received: by mail-qt0-f178.google.com with SMTP id r58so714001qtc.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 04:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eeBHYB1m042djjWqN06aAb/IfowpR0mWVicCWka45mQ=;
        b=Gik1Zqmuk97LEN7GYu6S/Wkc/YpWiNGBKhFP4LRJXGjvVXINORUlSsfxyqQLF9Ayc1
         qYOYgA7V/lXfv/bR1bDcFeina4AiTzHxf9gd2V7l+sfR5OAyeZUMKHbWr5Fv2tInNXNf
         6FH0cJbhEnrl4unY66sreXYLiOGrdIoWjhIufNz1AqNAGRTUYU259c9PhvtPHrXQZlsF
         OaL9xov7obD3x2AtjeMzKizc/L4Rr7XmrTdT/4PBUtCoLi/f6BGlbOplt7Le0svyNnPW
         0eXyODAUPLIiqEHEKqfrfI0pH7qnS6gmK6YI1TtuYPzfBGRXkV/p/sPmXNq3dIVwokAX
         L9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eeBHYB1m042djjWqN06aAb/IfowpR0mWVicCWka45mQ=;
        b=Zh5GwlNuzeeS+BgMnJqVKDMLrRQ6s/Z1R4+XfZIyPAolBKUhwJokrSgX3NOr4zeVoH
         1RZPWpntb9GdFtw0nerGYy2ea0yiMQPoamwb3FjXTicuY9IDnMSdwqPsdx8QfQMajbex
         hvnmVFK6McuHAELwH37aWGglWrBvqXvCZOOWiHEfePRxYUavKgkubYHRl+6tQq4FkQ0C
         DZrPxERnVTOJpwS5A0TIn3sEPzsI4aJE+ajU4l5Z4Cs5UzyK5mXzdWhxjdmzXIIsFgPm
         6jgzofJUqWuVUAAR2ohOApqydw5GJvInQ5ZhWj2cssACwrgsQB3JUTlaM4AJKcfD7OIl
         lpwg==
X-Gm-Message-State: AJaThX4FBsClLFELZGz4DRlLvAnJspZ65XsRkoFLJ5VDTgu1nRvk4k7N
        kNdBUPepsbXmmx/5juktTx36GtQRbSmNqmkP8GU=
X-Google-Smtp-Source: AGs4zMZl5wBk6Gl1f3s+Sr3ebncT4V0AIdeuQtOqYFm4/ypBXpWZH3Cw9dRoagTmtrrZ6PmOiqghFRPT/eI3EdwGInU=
X-Received: by 10.129.154.143 with SMTP id r137mr7645195ywg.251.1510662690942;
 Tue, 14 Nov 2017 04:31:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.203.85 with HTTP; Tue, 14 Nov 2017 04:31:30 -0800 (PST)
From:   Ashish Negi <ashishnegi33@gmail.com>
Date:   Tue, 14 Nov 2017 18:01:30 +0530
Message-ID: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
Subject: Changing encoding of a file : What should happen to CRLF in file ?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

I have a cross platform project. I have a utf-16 file in it.
I changed its encoding to urf-8 and committed. When i pulled the file
in Linux, it shows that file is modified. This means that the commit
which changed the encoding does not convert crlf to lf, when new
format is text based (utf-8).

Steps to reproduce:

   In windows :

    Change encoding of file from utf-16 to utf-8.
    Commit the change.

   In linux:

    Pull your branch.
    You will see the issue of file being shown as modified even though
you have not used it.


If i change the file encoding in linux and commit. Then if i do git
pull in windows, i don't see the issue.
In linux, during committing i get warning : warning: CRLF will be
replaced by LF in =E2=80=A6file_name..

Here are my configuration :


> git config --global --get core.autocrlf

false


> git config  --get core.autocrlf

false



> cat E:\work\WindowsFabric\.gitattributes


# Set the default behavior, in case people don't have core.autocrlf set.

* text=3Dauto
*.vcxproj eol=3Dcrlf
*.sh      eol=3Dlf

# Denote all files that are truly binary and should not be modified.
*.exe binary
*.dll binary
*.pdb binary
*.ico binary
*.png binary
*.jpg binary


> git --version
git version 2.14.2.windows.2


I played around with core.autocrlf values like true and native, but
that didn't help.

The behavior is inconsistent across platforms, and windows version is
giving me problem.

Can someone suggest right settings for this ? Or is this a bug in Git.

Thanks
