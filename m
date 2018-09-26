Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3331F453
	for <e@80x24.org>; Wed, 26 Sep 2018 09:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIZPM4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 11:12:56 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37820 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeIZPM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 11:12:56 -0400
Received: by mail-yb1-f196.google.com with SMTP id b3-v6so9947238yba.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gDLzJu6cpqLQ1TVpD5cqoAAWGIs/fgYk/fzsUvpMhJc=;
        b=MtkYkpyWmNUoa1gZ6lLU0OJU7bN/2v8JaqPpp59laB0nkL9xvWe/15nUrgOWGIHRqR
         8pXyodYMlhqMMRALTw+iCkzvnDEd46skdo2lREeZRYf5VbNm2zMGrzkxg0z8P/VLqQG1
         MCyTj04TQDIrhnmcCigx4SVw67NvTVuNT5xhS8vPkl1StL0A/D4ylXHLrpk3suDM5sux
         8GVXXHYggckymx117014TjiBcosQk1ZrNGq+iDvGK5colRfjZvO3H0dN0YPFZK9LaDIV
         ErwgssEKiUOxcNgn2197g5bTVKZKL5pkCf8B7WCMmQPk9YY+34CIjwYl9KyXAMoco+cE
         w+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gDLzJu6cpqLQ1TVpD5cqoAAWGIs/fgYk/fzsUvpMhJc=;
        b=Eu0UZ8EKVsCo9+efB5vKofIAm7MhV9NuvYkv46fVPbUbGGjWV4M2eJX1ickdWVWAPo
         DNpjUG5bI59v1DkuFm+SQodXB+tAvGshwKplArK/gVNyjvrp/A+oY8IGBWZcvVrV2QYb
         SA3D5n1XkrZQ0wzUX+I9LPC1o2YnGRZlXJUrprmX3cFDmRomuTbx7htawL2+Syu/BOJL
         LejsSQp7uI1oGykp8r10n0YqTLW28o7z9lkqQKrJcKTcta2n1Of4XCapyprKLHeyYiek
         4pxOolsoY2TEwz1+3ZxHeBDj20sEBGr+IvJOPbSUY1nzI36mEBd2jf9nIwEhe1Y/0r0k
         ZB7A==
X-Gm-Message-State: ABuFfojLUpbz5FtvrTOvVbHZvnsqF977yFY8m7eMP2Lc8bkKAgEuP0DU
        FMlAqXOvvjJx29DEMfju0ZBGucaf8OcPzUIyvss=
X-Google-Smtp-Source: ACcGV613Qic5/Dv+UVsWSoCFQHsDNQSvtiR+gZMoNBVfMYOYWEcFZztmQOrJYgX17YpexkXNa6sOLzLr8G6r9A276x8=
X-Received: by 2002:a25:1656:: with SMTP id 83-v6mr2505185ybw.217.1537952457729;
 Wed, 26 Sep 2018 02:00:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:248c:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 02:00:57
 -0700 (PDT)
In-Reply-To: <CAN0heSrhaaP0ds8K92g9w5DAnbwuq8mM6WLKrTQ7e_a8Fku9KA@mail.gmail.com>
References: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
 <CAN0heSrhaaP0ds8K92g9w5DAnbwuq8mM6WLKrTQ7e_a8Fku9KA@mail.gmail.com>
From:   Alexander Pyhalov <apyhalov@gmail.com>
Date:   Wed, 26 Sep 2018 12:00:57 +0300
Message-ID: <CALOYryEMB5HoCXbVKnc49KLkk2ySZjn4DG9RbJjQAvPn1H5K6Q@mail.gmail.com>
Subject: Re: t7005-editor.sh failure
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ecca9e0576c27535"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000ecca9e0576c27535
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.
As for sign-off, do I understand correctly that you just want to know
that I'm the original author of the code? Yes, it's so.

I see this on OpenIndiana in
https://github.com/OpenIndiana/oi-userland/pull/4456 , when running
test suite.
Not sure why it wasn't noticed earlier, as 'trash directory' is used in pat=
h.

When I use truss to look at failure, I see

2653:   execve("/export/home/alp/srcs/oi-userland/components/developer/git/=
build/amd64/git",
0x00564EC8, 0x00566008)  argc =3D 3
2653:    argv:
2653:     /export/home/alp/srcs/oi-userland/components/developer/git/build/=
amd64/git
2653:     commit --amend
hint: Waiting for your editor to close the file... 2655:
execve("/bin/bash", 0x007EA898, 0x007EA960)  argc =3D 5
2655:    argv: /bin/bash -c ./e\ space.sh "$@" ./e\ space.sh
2655:     /export/home/alp/srcs/oi-userland/components/developer/git/build/=
amd64/t/trash
directory.t7005-editor/.git/COMMIT_EDITMSG
2655:   execve("./e space.sh", 0x005655C8, 0x00564008)  Err#8 ENOEXEC
./e space.sh: line 1: $1: ambiguous redirect
2653:       Received signal #18, SIGCLD, in waitid() [default]
2653:         siginfo: SIGCLD CLD_EXITED pid=3D2655 status=3D0x0001
error: There was a problem with the editor './e\ space.sh'.
Please supply the message using either -m or -F option.

Shell is bash, as you can see (GNU bash, version 4.4.23(1)-release
(i386-pc-solaris2.11))


2018-09-26 10:59 GMT+03:00 Martin =C3=85gren <martin.agren@gmail.com>:
> Hi Alexander,
>
> Welcome to the list!
>
> On Wed, 26 Sep 2018 at 08:54, Alexander Pyhalov <apyhalov@gmail.com> wrot=
e:
>> On updating git to 2.19 we've suddenly got t7005-editor.sh test failures=
.
>> The issue seems to be that generated "e space.sh" file can't handle
>> files with spaces.
>> Instead of 'echo space >$1' it should be 'echo space > "$1"' or git
>> editor fails when gets file with spaces in name.
>
> Thanks for finding, analysing and reporting. I haven't bisected, but I'm
> guessing this comes from 4362da078e (t7005-editor: get rid of the
> SPACES_IN_FILENAMES prereq, 2018-05-14), which only happens to have to
> do with spaces in filenames. But in rewriting the test, it introduced
> /another/ instance of spaces-matter-here and didn't quote $1 properly.
> Cute. :-)
>
> We try to snuggle the filename to the >redirector, so it would be 'echo
> space >"$1"' and similar.
>
> Could we have your sign-off for this? Please see [1] for what that
> means. If you want to re-submit as a "proper" patch with commit message
> and all, great. If not, I could do it for you, with you as "Author:", if
> you just let me know.
>
> By the way, could you say something about which shell or which
> environment this bug triggered in? Just so we can better understand how
> this snuck past us.
>
> [1] https://github.com/git/git/blob/master/Documentation/SubmittingPatche=
s
>
> Thanks
> Martin



--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=9F=D1=8B=D1=85=
=D0=B0=D0=BB=D0=BE=D0=B2

--000000000000ecca9e0576c27535
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-t7005-editor.sh-e-space.sh-should-properly-escape-fi.patch"
Content-Disposition: attachment; 
	filename="0001-t7005-editor.sh-e-space.sh-should-properly-escape-fi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jmix453e0

RnJvbSAxNzFlMjQwNGE1ZTE5YjFiOWI1MTEyYWQ0MDhhNWNjMWNmOTYzMjg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4YW5kZXIgUHloYWxvdiA8YXB5aGFsb3ZAZ21haWwuY29t
PgpEYXRlOiBXZWQsIDI2IFNlcCAyMDE4IDExOjU0OjU4ICswMzAwClN1YmplY3Q6IFtQQVRDSF0g
dDcwMDUtZWRpdG9yLnNoOiAiZSBzcGFjZS5zaCIgc2hvdWxkIHByb3Blcmx5IGVzY2FwZSBmaWxl
CiBwYXRoCgpTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgUHloYWxvdiA8YXB5aGFsb3ZAZ21haWwu
Y29tPgotLS0KIHQvdDcwMDUtZWRpdG9yLnNoIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdC90NzAwNS1lZGl0b3Iuc2gg
Yi90L3Q3MDA1LWVkaXRvci5zaAppbmRleCBiMmNhNzdiMzMuLjY2MjQzYzQzYyAxMDA3NTUKLS0t
IGEvdC90NzAwNS1lZGl0b3Iuc2gKKysrIGIvdC90NzAwNS1lZGl0b3Iuc2gKQEAgLTExMiw3ICsx
MTIsNyBAQCBkbwogZG9uZQogCiB0ZXN0X2V4cGVjdF9zdWNjZXNzICdlZGl0b3Igd2l0aCBhIHNw
YWNlJyAnCi0JZWNobyAiZWNobyBzcGFjZSA+XCQxIiA+ImUgc3BhY2Uuc2giICYmCisJZWNobyAi
ZWNobyBzcGFjZSA+IFwiXCQxXCIiID4gImUgc3BhY2Uuc2giICYmCiAJY2htb2QgYSt4ICJlIHNw
YWNlLnNoIiAmJgogCUdJVF9FRElUT1I9Ii4vZVwgc3BhY2Uuc2giIGdpdCBjb21taXQgLS1hbWVu
ZCAmJgogCXRlc3Qgc3BhY2UgPSAiJChnaXQgc2hvdyAtcyAtLXByZXR0eT1mb3JtYXQ6JXMpIgot
LSAKMi4xOS4wCgo=
--000000000000ecca9e0576c27535--
