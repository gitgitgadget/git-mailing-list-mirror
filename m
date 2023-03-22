Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD1C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 10:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCVKGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 06:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVKGG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 06:06:06 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62614A1FE
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 03:06:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id t14so18296701ljd.5
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unit-image.fr; s=google; t=1679479563;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tuyv85KeUX+T4m4EjTnG0qN0V35hvNSXnnERgmmNmHs=;
        b=gFE0/Lcqh0VW36uIy1AUdw0ELemkVRduyRRZmtN3RYKlHD8NbPQR5bGMBHS795GMV7
         w9KVP8lMzCHjkz8crKvmE4hytq4cf0X+GJJJ+M6XvcxWYVIXTcmICmQLReZ1WQbbJgi2
         v8SYcq6mfakqagXMuZpWMQc4J2REvervWbOBBiR9YLyjDkKuSQwp3RqgBmBq3/8+Zgh7
         Y46MxsCqpP77mMGTOXaxwnCOwiAx9LU1vhvGeHu0m+8T7U4NOmUgv84Fketf/QDG67IZ
         +x3h5Yg2vrtCcxx3JvN9DIdr1GfJMVT5hXrKAa/eRjKa07e/3WsorX1k+M7vEaEejG/k
         zObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679479563;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tuyv85KeUX+T4m4EjTnG0qN0V35hvNSXnnERgmmNmHs=;
        b=tv9GDYEKZ41esKRYJBaFEVMnsKEtFtKslAGw3gjsC6omzGxEAk4OVy23yV3pOZB9vH
         f3nMeLuI7HkKZ/SJeRaVguGU8u/z3KD9TdRxzn75AoBofM4o0dsbFmUI++cMjmuE+vTc
         d4cRof6zGePA9M8i2MMmgDMmgbwzdLlSLyfzx48VBal96ZAI05dyIU67lnemJhGHv4ZQ
         0Hb9VV1jHDCnQDMl1rFwOPdwYjhDlyIP/eEK6X74cwELieEg7/vdkrA6NQ4+rbYGAaIg
         Uev70wrGHZ35mxIknr8Faolu/xTx940sk21YTwvLELM+POdn7WajTl7LwAWNjwA561gP
         2W+A==
X-Gm-Message-State: AO0yUKVExebvCYNtR4yGge5P4u9ga5ebKcv+qCoPv3jSrKDdo6RZuCqr
        yag7xqbm/UUyuV4LrJ3Pz9ZKih+8PUmcVkf1TP9R4omks8216QD0l1Y=
X-Google-Smtp-Source: AK7set+vvgowYisD/ZC1tluWvwa9C70eb9Gv6R/UvMJfE2T3lf4oSO4KDzlo+tqXg4JPM1lISFW+aup+JHAJgUHHLFo=
X-Received: by 2002:a2e:a0cd:0:b0:29b:d21c:e859 with SMTP id
 f13-20020a2ea0cd000000b0029bd21ce859mr1826951ljm.3.1679479562929; Wed, 22 Mar
 2023 03:06:02 -0700 (PDT)
MIME-Version: 1.0
From:   Robin Vagner <robin.vagner@unit-image.fr>
Date:   Wed, 22 Mar 2023 11:05:52 +0100
Message-ID: <CAHadCYLUTxzBYk+jw1Eg9FrP2Abn_qTyAvGBPeoi=Cwum2FfnA@mail.gmail.com>
Subject: git log -L:<funcname>:<file> bug report
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c1aab405f77a4e81"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000c1aab405f77a4e81
Content-Type: text/plain; charset="UTF-8"

Hello, this is my first time reporting an issue through mail, so I am
sorry if I missed something.
The file generated with `git bugreport` is attached to this mail, and
I also copy-pasted its contents below just in case.

Tell me if you need more precisions, I feel like this is a bug, but it
might just be an absence of feature.

Thanks in advance,

Robin Vagner.

---

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
> Use the command `git log -L:<funcname>:<file>` on a python file, with an existing function name in an existing file.

What did you expect to happen? (Expected behavior)
> The git log function to find the given function name and display its history.

What happened instead? (Actual behavior)
> I got this error : `fatal: -L parameter 'get_comment_from_args' starting at line 1: no match`

What's different between what you expected and what actually happened?
> Since git already knows by default to use python for diffs with *.py files, I expected it to find the function.

Anything else you want to add:
> It works properly if I add a .gitattributes file with the following line : `*.py diff=python`, which is weird because I thought this was already the default values for git (at least a `git diff` shows me the function name properly in the diff blobs.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.35.1.windows.2
cpu: x86_64
built from commit: 5437f0fd368c7faf1a0b5e1fef048232c1f2a3e6
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19043
compiler info: gnuc: 11.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]

--000000000000c1aab405f77a4e81
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2023-03-22-1040.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2023-03-22-1040.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lfjir8bs0>
X-Attachment-Id: f_lfjir8bs0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCj4gVXNlIHRoZSBjb21tYW5kIGBnaXQgbG9nIC1MOjxmdW5jbmFt
ZT46PGZpbGU+YCBvbiBhIHB5dGhvbiBmaWxlLCB3aXRoIGFuIGV4aXN0aW5nIGZ1bmN0aW9uIG5h
bWUgaW4gYW4gZXhpc3RpbmcgZmlsZS4KCldoYXQgZGlkIHlvdSBleHBlY3QgdG8gaGFwcGVuPyAo
RXhwZWN0ZWQgYmVoYXZpb3IpCj4gVGhlIGdpdCBsb2cgZnVuY3Rpb24gdG8gZmluZCB0aGUgZ2l2
ZW4gZnVuY3Rpb24gbmFtZSBhbmQgZGlzcGxheSBpdHMgaGlzdG9yeS4KCldoYXQgaGFwcGVuZWQg
aW5zdGVhZD8gKEFjdHVhbCBiZWhhdmlvcikKPiBJIGdvdCB0aGlzIGVycm9yIDogYGZhdGFsOiAt
TCBwYXJhbWV0ZXIgJ2dldF9jb21tZW50X2Zyb21fYXJncycgc3RhcnRpbmcgYXQgbGluZSAxOiBu
byBtYXRjaGAKCldoYXQncyBkaWZmZXJlbnQgYmV0d2VlbiB3aGF0IHlvdSBleHBlY3RlZCBhbmQg
d2hhdCBhY3R1YWxseSBoYXBwZW5lZD8KPiBTaW5jZSBnaXQgYWxyZWFkeSBrbm93cyBieSBkZWZh
dWx0IHRvIHVzZSBweXRob24gZm9yIGRpZmZzIHdpdGggKi5weSBmaWxlcywgSSBleHBlY3RlZCBp
dCB0byBmaW5kIHRoZSBmdW5jdGlvbi4KCkFueXRoaW5nIGVsc2UgeW91IHdhbnQgdG8gYWRkOgo+
IEl0IHdvcmtzIHByb3Blcmx5IGlmIEkgYWRkIGEgLmdpdGF0dHJpYnV0ZXMgZmlsZSB3aXRoIHRo
ZSBmb2xsb3dpbmcgbGluZSA6IGAqLnB5IGRpZmY9cHl0aG9uYCwgd2hpY2ggaXMgd2VpcmQgYmVj
YXVzZSBJIHRob3VnaHQgdGhpcyB3YXMgYWxyZWFkeSB0aGUgZGVmYXVsdCB2YWx1ZXMgZm9yIGdp
dCAoYXQgbGVhc3QgYSBgZ2l0IGRpZmZgIHNob3dzIG1lIHRoZSBmdW5jdGlvbiBuYW1lIHByb3Bl
cmx5IGluIHRoZSBkaWZmIGJsb2JzLgoKUGxlYXNlIHJldmlldyB0aGUgcmVzdCBvZiB0aGUgYnVn
IHJlcG9ydCBiZWxvdy4KWW91IGNhbiBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24ndCB3aXNoIHRv
IHNoYXJlLgoKCltTeXN0ZW0gSW5mb10KZ2l0IHZlcnNpb246CmdpdCB2ZXJzaW9uIDIuMzUuMS53
aW5kb3dzLjIKY3B1OiB4ODZfNjQKYnVpbHQgZnJvbSBjb21taXQ6IDU0MzdmMGZkMzY4YzdmYWYx
YTBiNWUxZmVmMDQ4MjMyYzFmMmEzZTYKc2l6ZW9mLWxvbmc6IDQKc2l6ZW9mLXNpemVfdDogOApz
aGVsbC1wYXRoOiAvYmluL3NoCmZlYXR1cmU6IGZzbW9uaXRvci0tZGFlbW9uCnVuYW1lOiBXaW5k
b3dzIDEwLjAgMTkwNDMgCmNvbXBpbGVyIGluZm86IGdudWM6IDExLjIKbGliYyBpbmZvOiBubyBs
aWJjIGluZm9ybWF0aW9uIGF2YWlsYWJsZQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJhY3RpdmUg
c2hlbGwpOiA8dW5zZXQ+CgoKW0VuYWJsZWQgSG9va3NdCg==
--000000000000c1aab405f77a4e81--
