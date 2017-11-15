Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D920202A0
	for <e@80x24.org>; Wed, 15 Nov 2017 08:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756783AbdKOILp (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 03:11:45 -0500
Received: from mail-yw0-f172.google.com ([209.85.161.172]:46391 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756582AbdKOILn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 03:11:43 -0500
Received: by mail-yw0-f172.google.com with SMTP id a4so721704ywh.3
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 00:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yHsgC8AVMBCwslZ+iKsGDTSVtbcPS6kNUwZis9XFOR8=;
        b=aGK2z0SKpjmJrTP1qcICUR0bua4/VAJAi4rahb+K1eOgadKZ59yOccEOCXXtkR7/Ni
         P1FMrQ4/RynPhvEtIpfwI0p0IJTdL4wFy4EpPZ0PJ0XZf9uePt9WBGNc51dzQ/GdwWf2
         0Rhk6KF0J5hwIYUtlFIzUe/bzl6J76UVVVpahCYevyYqPNnvl2FC+AoF8qQ4sfCAiYkO
         k3gnbDSlMnn/b3/vU3Ndh/51SrHsziEny+o0KQj6duOlcmrQbtF5s9T1emyoDYW4lK6Q
         TvOkMXHrHDZbJvQBs4q9i4nROK04IC8bJA2T9Pv0/zcCzYxpyECzWjXlZj9maKl/nt9W
         lvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yHsgC8AVMBCwslZ+iKsGDTSVtbcPS6kNUwZis9XFOR8=;
        b=dzuM3yrJd48ypi1ImkJ9gP/xxsMAqScj1sgvyCbS966q4vf0wCRF9u1FbUlKYoJKTl
         YRMbA2pdTqLg9Y7iIXg+IQSPNM6U2JB5hkTAj9NExiGqVuekGHvkPO/yZVQxhck8pm1y
         e94lVqQEYWwXQM1cpRMRMgkM59w7mhaQTH6/RXhXXV9iUvJQsXkhqNoKB5PnVukdUOgr
         K5BI2tHlIQuuWHG1Qsi0uTtNFEbqjxsjrth40lTnHmWXGvCapj719fBcPrnRCqGh5JNt
         tbVa66lCm3Ih3CH3ju3lltHL3snqqUQo5DUGQtdyHaJ5JhxP1bP9JuyZxy6PdIiw3d6J
         WhnQ==
X-Gm-Message-State: AJaThX4PuLrCa/qO6I7yZh+2OLRXD2gLzO+VEuYcbLnQmIHqnmtMcB8L
        4e7GARaDYeHpRzWcKOK1fn73TeJBft6iLJ4KMvc=
X-Google-Smtp-Source: AGs4zMbamjICB0t5+K0FY4z6tMKiG3DwZhZsQjStxImr+vuBBm14ZeKgXSOidMo9p0PQEGgTTmC3j8FT+Dch86faQLg=
X-Received: by 10.13.198.133 with SMTP id i127mr9995189ywd.123.1510733502957;
 Wed, 15 Nov 2017 00:11:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.203.85 with HTTP; Wed, 15 Nov 2017 00:11:42 -0800 (PST)
In-Reply-To: <f9dc6482-587d-50a9-d649-aed63be18fad@web.de>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de> <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
 <CAJ_+vJ7Yfcpz5252M4XJnDmEDCANp+eJ7RLJJF8TCcTxexZEUA@mail.gmail.com> <f9dc6482-587d-50a9-d649-aed63be18fad@web.de>
From:   Ashish Negi <ashishnegi33@gmail.com>
Date:   Wed, 15 Nov 2017 13:41:42 +0530
Message-ID: <CAJ_+vJ6SxLOmZfG79Sa-vskBR-XG=C97--PB-vpijjUKym=jYw@mail.gmail.com>
Subject: Re: Changing encoding of a file : What should happen to CRLF in file ?
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="001a114e52f6cb6eeb055e010d76"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a114e52f6cb6eeb055e010d76
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> If you commit the file, it will be stored with LF in the index,
This is what i believe is not happening.

Lets do this with a public repository and steps which are reproducible.
I have created a repo : https://github.com/ashishnegi/git_encoding

If you clone this repo in linux and run `git status`, you will find
that file is modified.

About repo :
Repo have 2 commits, done on windows machine.
First one check in a utf-16le encoded file which has crlf. crlf will
not be converted to lf in index as git treats it as binary file.
2nd commit changes encoding to utf-8 and commits.
This commit does not change crlf to lf in index, even though new
format is utf-8 which is text based for git. This is the crux of
problem.

I have attached all commands i ran on windows while creating the repo.
I tried to capture all information that i could give.
Please have a look. It might be useful.

Finally, thank you Torsten for giving your time to the problem. Really
appreciate it.

On Tue, Nov 14, 2017 at 10:39 PM, Torsten B=C3=B6gershausen <tboegi@web.de>=
 wrote:
> (Back to the beginning)
>
> You have a file ApplicationManifest.xml
> It is encoded in UTF-16 (and has CRLF)
>
> You convert it into UTF-8
> The file has still CRLF (in the worktree)
>
> Now you add it and make a commit.
> Under both Linux and Windows you have "text=3Dauto".
>
> I assume that you have efficiently core.eol=3Dlf under Linux
> and core.eol=3Dcrlf on Windows.
>
> (That is the default, when you don't change anything)
>
> Now, what happens to the CRLF?
> If you commit the file, it will be stored with LF in the index,
> on both systems.
> On checkout, Windows will convert them into CRLF, but Linux will not.
>
> That why you see
>>On linux, during committing i get warning : warning: CRLF will be
>>replaced by LF in =E2=80=A6file_name..
>
> All in all there is nothing wrong, at least as I see it.
>
> The question remains:
> Do you need CRLF in Linux ?
> Probably not, but if yes, plase add a line
>
> *.xml text eol=3Dcrlf
>
> to your
> .gitattributes
>
> Otherwise your .gitconfig looks good to  me.
>
>
>
>
>
>

--001a114e52f6cb6eeb055e010d76
Content-Type: text/plain; charset="US-ASCII"; name="all_git_commands_output.txt"
Content-Disposition: attachment; filename="all_git_commands_output.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ja0rmjpk0

Z2l0X2VuY29kaW5nX3JlcG8+Z2l0IGNvbmZpZyAtLWdsb2JhbCBjb3JlLnNhZmVjcmxmCnRydWUK
CmdpdF9lbmNvZGluZ19yZXBvPmdpdCBjb25maWcgIGNvcmUuYXV0b2NybGYKZmFsc2UKCmdpdF9l
bmNvZGluZ19yZXBvPmdpdCBjb25maWcgLS1nZXQgY29yZS5hdXRvY3JsZgpmYWxzZQoKZ2l0X2Vu
Y29kaW5nX3JlcG8+Y2F0IC5naXRhdHRyaWJ1dGVzCiMgU2V0IHRoZSBkZWZhdWx0IGJlaGF2aW9y
LCBpbiBjYXNlIHBlb3BsZSBkb24ndCBoYXZlIGNvcmUuYXV0b2NybGYgc2V0LgoqIHRleHQ9YXV0
bwoKKi52Y3hwcm9qIGVvbD1jcmxmCiouc2ggICAgICBlb2w9bGYKCiMgRGVub3RlIGFsbCBmaWxl
cyB0aGF0IGFyZSB0cnVseSBiaW5hcnkgYW5kIHNob3VsZCBub3QgYmUgbW9kaWZpZWQuCiouZXhl
IGJpbmFyeQoqLmRsbCBiaW5hcnkKKi5wZGIgYmluYXJ5CiouaWNvIGJpbmFyeQoqLnBuZyBiaW5h
cnkKKi5qcGcgYmluYXJ5CgpnaXRfZW5jb2RpbmdfcmVwbz5naXQgc3RhdHVzCk9uIGJyYW5jaCBt
YXN0ZXIKCk5vIGNvbW1pdHMgeWV0CgpVbnRyYWNrZWQgZmlsZXM6CiAgKHVzZSAiZ2l0IGFkZCA8
ZmlsZT4uLi4iIHRvIGluY2x1ZGUgaW4gd2hhdCB3aWxsIGJlIGNvbW1pdHRlZCkKCiAgICAgICAg
LmdpdGF0dHJpYnV0ZXMKICAgICAgICBmaWxlX25hbWUudHh0Cgpub3RoaW5nIGFkZGVkIHRvIGNv
bW1pdCBidXQgdW50cmFja2VkIGZpbGVzIHByZXNlbnQgKHVzZSAiZ2l0IGFkZCIgdG8gdHJhY2sp
CgpnaXRfZW5jb2RpbmdfcmVwbz5naXQgbHMtZmlsZXMgLS1lb2wgZmlsZV9uYW1lLnR4dAoKZ2l0
X2VuY29kaW5nX3JlcG8+Z2l0IGFkZCAuCgpnaXRfZW5jb2RpbmdfcmVwbz5naXQgc3RhdHVzCk9u
IGJyYW5jaCBtYXN0ZXIKCk5vIGNvbW1pdHMgeWV0CgpDaGFuZ2VzIHRvIGJlIGNvbW1pdHRlZDoK
ICAodXNlICJnaXQgcm0gLS1jYWNoZWQgPGZpbGU+Li4uIiB0byB1bnN0YWdlKQoKICAgICAgICBu
ZXcgZmlsZTogICAuZ2l0YXR0cmlidXRlcwogICAgICAgIG5ldyBmaWxlOiAgIGZpbGVfbmFtZS50
eHQKCgpnaXRfZW5jb2RpbmdfcmVwbz5naXQgbHMtZmlsZXMgLS1lb2wgZmlsZV9uYW1lLnR4dApp
Ly10ZXh0IHcvLXRleHQgYXR0ci90ZXh0PWF1dG8gICAgICAgICAgZmlsZV9uYW1lLnR4dAoKZ2l0
X2VuY29kaW5nX3JlcG8+Z2l0IGNvbW1pdCAtbSAiQ29tbWl0IHV0Zi0xNmxlIGVuY29kZWQgZmls
ZSB3aGljaCBoYXMgY3JsZi4iClttYXN0ZXIgKHJvb3QtY29tbWl0KSA5MWZlM2JkXSBDb21taXQg
dXRmLTE2bGUgZW5jb2RlZCBmaWxlIHdoaWNoIGhhcyBjcmxmLgogMiBmaWxlcyBjaGFuZ2VkLCAx
MyBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgLmdpdGF0dHJpYnV0ZXMKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBmaWxlX25hbWUudHh0CgojIyBBdCB0aGlzIHRpbWUsIGkgY2hhbmdlZCBm
aWxlIGVuY29kaW5nIHRvIHV0Zi04LgoKZ2l0X2VuY29kaW5nX3JlcG8+Z2l0IHN0YXR1cwpPbiBi
cmFuY2ggbWFzdGVyCm5vdGhpbmcgdG8gY29tbWl0LCB3b3JraW5nIHRyZWUgY2xlYW4KCmdpdF9l
bmNvZGluZ19yZXBvPmdpdCBhZGQgLXAKT25seSBiaW5hcnkgZmlsZXMgY2hhbmdlZC4KCmdpdF9l
bmNvZGluZ19yZXBvPmdpdCBzdGF0dXMKT24gYnJhbmNoIG1hc3RlcgpDaGFuZ2VzIG5vdCBzdGFn
ZWQgZm9yIGNvbW1pdDoKICAodXNlICJnaXQgYWRkIDxmaWxlPi4uLiIgdG8gdXBkYXRlIHdoYXQg
d2lsbCBiZSBjb21taXR0ZWQpCiAgKHVzZSAiZ2l0IGNoZWNrb3V0IC0tIDxmaWxlPi4uLiIgdG8g
ZGlzY2FyZCBjaGFuZ2VzIGluIHdvcmtpbmcgZGlyZWN0b3J5KQoKICAgICAgICBtb2RpZmllZDog
ICBmaWxlX25hbWUudHh0CgpubyBjaGFuZ2VzIGFkZGVkIHRvIGNvbW1pdCAodXNlICJnaXQgYWRk
IiBhbmQvb3IgImdpdCBjb21taXQgLWEiKQoKZ2l0X2VuY29kaW5nX3JlcG8+Z2l0IGFkZCBmaWxl
X25hbWUudHh0CgpnaXRfZW5jb2RpbmdfcmVwbz5naXQgc3RhdHVzCk9uIGJyYW5jaCBtYXN0ZXIK
Q2hhbmdlcyB0byBiZSBjb21taXR0ZWQ6CiAgKHVzZSAiZ2l0IHJlc2V0IEhFQUQgPGZpbGU+Li4u
IiB0byB1bnN0YWdlKQoKICAgICAgICBtb2RpZmllZDogICBmaWxlX25hbWUudHh0CgoKZ2l0X2Vu
Y29kaW5nX3JlcG8+Z2l0IGNvbW1pdCAtbSAiQ2hhbmdlIGVuY29kaW5nIG9mIGZpbGUgdG8gdXRm
LTgiClttYXN0ZXIgMTc5YzI3Yl0gQ2hhbmdlIGVuY29kaW5nIG9mIGZpbGUgdG8gdXRmLTgKIDEg
ZmlsZSBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiByZXdyaXRlIGZp
bGVfbmFtZS50eHQgKDEwMCUpCgpnaXRfZW5jb2RpbmdfcmVwbz5naXQgcmVtb3RlIGFkZCBvcmln
aW4gaHR0cHM6Ly9naXRodWIuY29tL2FzaGlzaG5lZ2kvZ2l0X2VuY29kaW5nLmdpdAoKZ2l0X2Vu
Y29kaW5nX3JlcG8+Z2l0IHB1c2ggLXUgb3JpZ2luIG1hc3RlcgpDb3VudGluZyBvYmplY3RzOiA3
LCBkb25lLgpEZWx0YSBjb21wcmVzc2lvbiB1c2luZyB1cCB0byAxMiB0aHJlYWRzLgpDb21wcmVz
c2luZyBvYmplY3RzOiAxMDAlICg3LzcpLCBkb25lLgpXcml0aW5nIG9iamVjdHM6IDEwMCUgKDcv
NyksIDgzNyBieXRlcyB8IDgzNy4wMCBLaUIvcywgZG9uZS4KVG90YWwgNyAoZGVsdGEgMCksIHJl
dXNlZCAwIChkZWx0YSAwKQpUbyBodHRwczovL2dpdGh1Yi5jb20vYXNoaXNobmVnaS9naXRfZW5j
b2RpbmcuZ2l0CiAqIFtuZXcgYnJhbmNoXSAgICAgIG1hc3RlciAtPiBtYXN0ZXIKQnJhbmNoIG1h
c3RlciBzZXQgdXAgdG8gdHJhY2sgcmVtb3RlIGJyYW5jaCBtYXN0ZXIgZnJvbSBvcmlnaW4uCgpn
aXRfZW5jb2RpbmdfcmVwbz5naXQgbHMtZmlsZXMgLS1lb2wgZmlsZV9uYW1lLnR4dAppL2NybGYg
IHcvY3JsZiAgYXR0ci90ZXh0PWF1dG8gICAgICAgICAgZmlsZV9uYW1lLnR4dAoKZ2l0X2VuY29k
aW5nX3JlcG8+
--001a114e52f6cb6eeb055e010d76--
