Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21FC02021E
	for <e@80x24.org>; Thu,  3 Nov 2016 16:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756147AbcKCQG1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 12:06:27 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:36272 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbcKCQG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 12:06:26 -0400
Received: by mail-ua0-f172.google.com with SMTP id b35so43203728uaa.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=1YDMhWeOVoM1AijKXqw4ngumHQ1OYkHlsW6BEZwtK3s=;
        b=OZBdN8HSEd0ySFfXsvBY9vP1RnH3noKGYw5E0rl4z+kL2L1pSGqp+6FY0x3yanOpI0
         ZvAewBF56qgjulSJo5edTkucM+dyLB3GMMlMvt6mt6kbKHBizvJygjXQnwynCTLmymiQ
         m9DJrvmAR0PhzJuu/5gOLNAme7fsmT/KO0uqfbG5NuJ9WM1aC+p7kJ0P0BiYqQzR92t/
         90lDmeJhaWmYRJYNqpFZqn2dc/uye4Wqr+Fli/WL/D9OZWOUblLJwsLw+zfc7N0ShfZJ
         7r+wjSPM9NzbsQbtndflB2QeTgKruTFzocI+tuYliioepWtlWbFAaJay4qf4XUtp3a76
         ERdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1YDMhWeOVoM1AijKXqw4ngumHQ1OYkHlsW6BEZwtK3s=;
        b=XNnSoJKg1NtF3baeR8XD3iN9naw4a2kBXcmNL7N8GbUfzN/Q0HSGHE/kwM4NAJMVz6
         ZSnKoypO+9i5TwjmOOR9+ald7+TtK/7NiWvhx5ajYIOix+ma37PH8aTlgNMaw3hlc8dx
         iKb0gHF4vTWu/wk+PRayJzqIA+EVRn5d9AmBsV0W4Kr3U7MsPJisregk4izRDepQG3Td
         +RuB03ZV5apJ6Gs9ReV9Y/0kvRSDcCGOVO34EC3AKG9/enwy8mJuG0mxMkSH8ZgoJzSU
         7F53xxH9+sEylv4IY1+KF72X5sLbAgan6j7Wz3igcY9CTLnlq9C2x+45FbeO6beg+WYb
         8ooQ==
X-Gm-Message-State: ABUngvfvttTDASGKJ0JLfTRsWbdy/VrfVE+twzOwZFfZv6W5/n8xXGfS/Ery5O2h4NazQXoy2ciprxtKt1PcKA==
X-Received: by 10.159.41.163 with SMTP id s32mr7882188uas.137.1478189184851;
 Thu, 03 Nov 2016 09:06:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.47.133 with HTTP; Thu, 3 Nov 2016 09:06:04 -0700 (PDT)
From:   Stefan Monov <logixoul@gmail.com>
Date:   Thu, 3 Nov 2016 18:06:04 +0200
Message-ID: <CAJtFkWsUL=9K=VGTDejE+4RR3HJevk+2aRAhUyf8-mDrqi5MRg@mail.gmail.com>
Subject: `git stash apply` deleted a random dir from my working copy
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a114bd63e463d9a054067bd6c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a114bd63e463d9a054067bd6c
Content-Type: text/plain; charset=UTF-8

Hi.

I just tried `git stash save` for the first time. It worked fine. Then
I tried `git stash apply` and while my uncommitted changes were
restored, another effect was that a random dir from the root of my
working copy was deleted. I don't know why it chose that exact dir,
there's lots of other dirs like it in the root.

`git stash save` output and shortened `git stash apply` output are attached.

Note: The dir that got deleted was a committed and pushed dir. It had
no uncommitted local changes.

It's not a huge problem, because there was no data loss - I can pull
the deleted data back from the repo. But I'd still like to know why
this problem happened.

TIA, Stefan Monov

--001a114bd63e463d9a054067bd6c
Content-Type: text/plain; charset=US-ASCII; name="git_stash_save_output.txt"
Content-Disposition: attachment; filename="git_stash_save_output.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iv2jmvz00

U2F2ZWQgd29ya2luZyBkaXJlY3RvcnkgYW5kIGluZGV4IHN0YXRlIFdJUCBvbiBjbGlwcGluZzog
Y2ZlYWM0YiAtIGFwcGx5aW5nIHRoZSBzb2x1dGlvbiBmcm9tIGh0dHA6Ly9zdGFja292ZXJmbG93
LmNvbS9xdWVzdGlvbnMvNDAzODU0ODIvd2h5LWNhbnQtaS11c2Utb3BlbmdsLWVzLTMtMC1pbi1x
dA0KSEVBRCBpcyBub3cgYXQgY2ZlYWM0YiAtIGFwcGx5aW5nIHRoZSBzb2x1dGlvbiBmcm9tIGh0
dHA6Ly9zdGFja292ZXJmbG93LmNvbS9xdWVzdGlvbnMvNDAzODU0ODIvd2h5LWNhbnQtaS11c2Ut
b3BlbmdsLWVzLTMtMC1pbi1xdA==
--001a114bd63e463d9a054067bd6c
Content-Type: text/plain; charset=US-ASCII; name="shortened_git_stash_apply_output.txt"
Content-Disposition: attachment; 
	filename="shortened_git_stash_apply_output.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iv2jmw3a1

UmVtb3ZpbmcgZGVidWdfc3RlbmNpbF9ub3Rfd29ya2luZy90ZXh0dXJlYW5kbGlnaHQuanMNClJl
bW92aW5nIGRlYnVnX3N0ZW5jaWxfbm90X3dvcmtpbmcvcXRsb2dvLnBuZw0KWy4uLiBtb3JlIHJl
bW92ZXMgaGVyZSAuLi5dDQpPbiBicmFuY2ggY2xpcHBpbmcNCkNoYW5nZXMgdG8gYmUgY29tbWl0
dGVkOg0KICAodXNlICJnaXQgcmVzZXQgSEVBRCA8ZmlsZT4uLi4iIHRvIHVuc3RhZ2UpDQoNCgkJ
bmV3IGZpbGU6ICAgZG9jdW1lbnRhdGlvbi90ZXh0dXJlU2l6ZV9taXNzaW5nLnR4dA0KDQpDaGFu
Z2VzIG5vdCBzdGFnZWQgZm9yIGNvbW1pdDoNCiAgKHVzZSAiZ2l0IGFkZC9ybSA8ZmlsZT4uLi4i
IHRvIHVwZGF0ZSB3aGF0IHdpbGwgYmUgY29tbWl0dGVkKQ0KICAodXNlICJnaXQgY2hlY2tvdXQg
LS0gPGZpbGU+Li4uIiB0byBkaXNjYXJkIGNoYW5nZXMgaW4gd29ya2luZyBkaXJlY3RvcnkpDQoN
CgkJZGVsZXRlZDogICAgLi4vZGVidWdfc3RlbmNpbF9ub3Rfd29ya2luZy9xdGxvZ28ucG5nDQoJ
CWRlbGV0ZWQ6ICAgIC4uL2RlYnVnX3N0ZW5jaWxfbm90X3dvcmtpbmcvdGV4dHVyZWFuZGxpZ2h0
LmpzDQoJCVsuLi4gbW9yZSBkZWxldGVkIGZpbGVzIGhlcmUgLi4uXQ0KCQltb2RpZmllZDogICBt
YWluLmNwcA0KCQltb2RpZmllZDogICBtYWluLnFtbA0KCQlbLi4uIG1vcmUgbW9kaWZpZWQgZmls
ZXMgaGVyZSAuLi5dDQoNClVudHJhY2tlZCBmaWxlczoNCiAgKHVzZSAiZ2l0IGFkZCA8ZmlsZT4u
Li4iIHRvIGluY2x1ZGUgaW4gd2hhdCB3aWxsIGJlIGNvbW1pdHRlZCkNCg0KCQkuLi9kYmdfcmVw
ZWF0ZXIvZGJnX3JlcGVhdGVyLnByby51c2VyDQoJCWRlYnVnX3N0ZW5jaWxfbm90X3dvcmtpbmcv
DQoJCVsuLi4gbW9yZSBmaWxlcyBhbmQgZGlycyBoZXJlIC4uLl0=
--001a114bd63e463d9a054067bd6c--
