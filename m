Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842DBC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 20:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiK1UGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 15:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiK1UGj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 15:06:39 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40E1E0FA
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 12:06:37 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q7so14422555ljp.9
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 12:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:content-language:to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jXX9HiALF1bMgC0BUb4HFyv9oh6jM895yQrDitAiW1E=;
        b=narsrknFURBhAg/luHQSCbX1vbwQ/X7pV6dKHzRD2uVtnGeuEJ4paHYvS8rON2217F
         bMaC1Q0z/11u1qq1ijiPJnrY5t/9nTONZKjOaajDaATT8sj5Hf5HFHB+5FTn2Pv0Ah4t
         9CR9ytNik+p3Jg8AFebRhUxEE3CZVMA+vBVDF++oA9BpcD5c4uXM1ZFOgUX55wVllygP
         nodIFYYud1gINWp1vLHmNSiV6sKnSYToZewlq13tR//TOoxkBBXqwbIEpPRgc2c5OjES
         JkNCqPVdsJEZDueYaB2QqiEsKBkOqIbnjfk47WvSe+pmI/WSgk8Ak5RaVyCMeDR4XPE9
         A/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:content-language:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXX9HiALF1bMgC0BUb4HFyv9oh6jM895yQrDitAiW1E=;
        b=VoKvjb8DYf9Lft9fFjUZhVG4w88FQsLBQsoXKwpsMHH/4EZhKR6XlMoKmpSy06yi5n
         fkYD97Giv8h1Htxe9Un10fW07q2Wy1oYERda8Gv2GwHJXzDPFYTpbLy+jz1lcPDmsxKZ
         RCW7AT/m4uGpWja+CZ3Q4ZAEZnAoKvWmfz+UFAZyfScUtPNg/1soE75iMuYbwhtMiT9V
         9pGTISfFWj25k1wvg074ENdsJphlu2C0ldNhAcgSKfz5qstQaGerubQ+o7pjgAKkVCcW
         jMfRaWZDe2kDPVG0GwfnQhSOzmS1CJ1TXz/1CqNjM5uR8FiJNY4soHYIe+XlCEWzRTFU
         7tKA==
X-Gm-Message-State: ANoB5pkD+cABjCAiNJcdgK2v9znE5ZChb7+M5D9V86/Xsrt/swBBNsd1
        /pnIPpH6g2cad55gm1g0T1Q3aYDEXp6zaw==
X-Google-Smtp-Source: AA0mqf6KGGZvhXKJ6yvuiLBhcmuFgX2h7lLV8wM429x97oCKLnEU5qQV4OUoTOUyqj+vQpEL82+Tlw==
X-Received: by 2002:a05:651c:201c:b0:279:a4b0:c34a with SMTP id s28-20020a05651c201c00b00279a4b0c34amr2595874ljo.435.1669665995807;
        Mon, 28 Nov 2022 12:06:35 -0800 (PST)
Received: from [192.168.0.104] (host-80-238-118-13.jmdi.pl. [80.238.118.13])
        by smtp.gmail.com with ESMTPSA id j3-20020a056512028300b0048b26d4bb64sm1864728lfp.40.2022.11.28.12.06.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 12:06:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------hoqSZzZG3ECJFcfXDhqw8rDU"
Message-ID: <01e70557-6f54-142c-a98b-f109f69648a3@gmail.com>
Date:   Mon, 28 Nov 2022 21:06:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To:     git@vger.kernel.org
Content-Language: en-US
From:   Tomasz Osak <tomasz.osak.80@gmail.com>
Subject: possible bug for Git - Git incorrectly recognizes which file has been
 renamed.
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------hoqSZzZG3ECJFcfXDhqw8rDU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

What were you doing before the error occurred? (Steps to reproduce the 
problem)
I was doing the exercise "EXERCISE: A VERSIONED TODO APP" from the end 
of chapter 3 of M. Tsitoar's book "Beginning Git and GitHub":

Create two new files named DONE.txt and WORKING.txt
Stage and commit those files
Rename WORKING.txt to 'IN PROGRES.txt'
Add some text to DONE.txt
Stage 'IN PROGRESS.txt' and DONE.txt
Unstage DONE.txt
Git status
You can see the information: renamed DONE.txt -> 'IN PROGRESS.txt'
Git commit
In the message file the comment is similar: renamed DONE.txt -> 'IN 
PROGRESS.txt'

What should happen? (Expected behavior)
Git status
You should see the message: renamed WORKING.txt -> 'IN PROGRESS.txt'
Git commit
Similarly, in the message file you should see a comment: renamed 
WORKING.txt -> 'IN PROGRESS.txt'

What happened instead? (Actual behavior)
Git status
Shows information: renamed DONE.txt -> 'IN PROGRESS.txt'
Git commit
In the message file also you can see the comment: renamed DONE.txt -> 
'IN PROGRESS.txt'

What is the difference between what should happen and what happened?
Git incorrectly recognizes which file has been renamed (DONE.txt instead 
of WORKING.txt).

Other valuable comments:
Both files (DONE.txt and WORKING.txt) were empty during the first commit.

Regards

Tomasz Osak

--------------hoqSZzZG3ECJFcfXDhqw8rDU
Content-Type: text/plain; charset=UTF-8;
 name="git-bugreport-2022-11-28-2041.txt"
Content-Disposition: attachment; filename="git-bugreport-2022-11-28-2041.txt"
Content-Transfer-Encoding: base64

RHppxJlrdWplbXkgemEgd3lwZcWCbmllbmllIHpnxYJvc3plbmlhIG8gYsWCxJlkemllIEdp
dGEhCk9kcG93aWVkeiBuYSBuYXN0xJlwdWrEhWNlIHB5dGFuaWEsIGFieSBwb23Ds2MgbmFt
IHpyb3p1bWllxIcgcHJvYmxlbS4KCkNvIHJvYmnFgmXFmy8tYcWbIHphbmltIHBvamF3acWC
IHNpxJkgYsWCxIVkPyAoS3Jva2ksIGFieSBvZHR3b3J6ecSHIHByb2JsZW0pCld5a29ueXdh
xYJlbSDEh3dpY3plbmllICJFWEVSQ0lTRTogQSBWRVJTSU9ORUQgVE9ETyBBUFAiIHoga2/F
hGNhIDMuIHJvemR6aWHFgnUga3NpxIXFvGtpIE0uIFRzaXRvYXJhICJCZWdpbm5pbmcgR2l0
IGFuZCBHaXRIdWIiOgpDcmVhdGUgdHdvIG5ldyBmaWxlcyBuYW1lZCBET05FLnR4dCBhbmQg
V09SS0lORy50eHQKU3RhZ2UgYW5kIGNvbW1pdCB0aG9zZSBmaWxlcwpSZW5hbWUgV09SS0lO
Ry50eHQgdG8gJ0lOIFBST0dSRVMudHh0JwpBZGQgc29tZSB0ZXh0IHRvIERPTkUudHh0ClN0
YWdlICdJTiBQUk9HUkVTUy50eHQnIGFuZCBET05FLnR4dApVbnN0YWdlIERPTkUudHh0Ckdp
dCBzdGF0dXMKV2lkYcSHIGluZm9ybWFjasSZOiB6bWllbmlvbm8gbmF6d8SZIERPTkUudHh0
IC0+ICdJTiBQUk9HUkVTUy50eHQnCkdpdCBjb21taXQKVyBwbGlrdSBtZXNzYWdlIHBvZG9i
bmllIGplc3Qga29tZW50YXJ6OiB6bWllbmlvbm8gbmF6d8SZIERPTkUudHh0IC0+ICdJTiBQ
Uk9HUkVTUy50eHQnCgpDbyBwb3dpbm5vIHNpxJkgc3RhxIc/IChPY3pla2l3YW5lIHphY2hv
d2FuaWUpCkdpdCBzdGF0dXMKUG93aW5ubyBiecSHIHdpZGHEhyBpbmZvcm1hY2rEmTogem1p
ZW5pb25vIG5henfEmSBXT1JLSU5HLnR4dCAtPiAnSU4gUFJPR1JFU1MudHh0JwpHaXQgY29t
bWl0ClBvZG9ibmllIHcgcGxpa3UgbWVzc2FnZSBwb3dpbm5vIGJ5xIcgd2lkYcSHIGtvbWVu
dGFyejogem1pZW5pb25vIG5henfEmSBXT1JLSU5HLnR4dCAtPiAnSU4gUFJPR1JFU1MudHh0
JyAKCkNvIHN0YcWCbyBzacSZIHphbWlhc3QgdGVnbz8gKFJ6ZWN6eXdpc3RlIHphY2hvd2Fu
aWUpCkdpdCBzdGF0dXMKUG9rYXp1amUgaW5mb3JtYWNqxJk6IHptaWVuaW9ubyBuYXp3xJkg
RE9ORS50eHQgLT4gJ0lOIFBST0dSRVNTLnR4dCcKR2l0IGNvbW1pdApXIHBsaWt1IG1lc3Nh
Z2Ugd2lkYcSHIGtvbWVudGFyejogem1pZW5pb25vIG5henfEmSBET05FLnR4dCAtPiAnSU4g
UFJPR1JFU1MudHh0JwoKSmFrYSBqZXN0IHLDs8W8bmljYSBtacSZZHp5IHR5bSwgY28gcG93
aW5ubyBzacSZIHN0YcSHLCBhIHR5bSwgY28gc2nEmSBzdGHFgm8/CkdpdCBixYLEmWRuaWUg
cm96cG96bmFqZSBrdMOzcmVnbyBwbGlrdSBuYXp3xJkgem1pZW5pb25vIChET05FLnR4dCB6
YW1pYXN0IFdPUktJTkcudHh0KS4KCklubmUgY2VubmUgdXdhZ2k6Ck9iYSBwbGlraSAoRE9O
RS50eHQgaSBXT1JLSU5HLnR4dCkgYnnFgnkgcHVzdGUgcG9kY3phcyBwaWVyd3N6ZWdvIGNv
bW1pdC4KClByemVqcnp5aiByZXN6dMSZIHpnxYJvc3plbmlhIGLFgsSZZHUgcG9uacW8ZWou
Ck1vxbxlc3ogdXN1bsSFxIcgd2llcnN6ZSwga3TDs3J5bWkgbmllIGNoY2VzeiBzacSZIGR6
aWVsacSHLgoKCltJbmZvcm1hY2plIG8gc3lzdGVtaWVdCndlcnNqYSBnaXRhOgpnaXQgdmVy
c2lvbiAyLjM4LjEKY3B1OiB4ODZfNjQKbm8gY29tbWl0IGFzc29jaWF0ZWQgd2l0aCB0aGlz
IGJ1aWxkCnNpemVvZi1sb25nOiA4CnNpemVvZi1zaXplX3Q6IDgKc2hlbGwtcGF0aDogL2Jp
bi9zaAp1bmFtZTogTGludXggNi4wLjktMjAwLmZjMzYueDg2XzY0ICMxIFNNUCBQUkVFTVBU
X0RZTkFNSUMgV2VkIE5vdiAxNiAxNzo1MDo0NSBVVEMgMjAyMiB4ODZfNjQKaW5mb3JtYWNq
ZSBvIGtvbXBpbGFjamk6IGdudWM6IDEyLjIKaW5mb3JtYWNqZSBvIGJpYmxpb3RlY2UgbGli
YzogZ2xpYmM6IDIuMzUKJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTog
L2Jpbi9iYXNoCgoKW1fFgsSFY3pvbmUgc2tyeXB0eSBHaXRhXQo=

--------------hoqSZzZG3ECJFcfXDhqw8rDU--
