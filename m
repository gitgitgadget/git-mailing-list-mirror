Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18656C33CA2
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 08:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92E92077C
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 08:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgAJI02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:26:28 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:43013 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgAJI02 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 03:26:28 -0500
Received: from oxbsltgw65.schlund.de ([172.19.249.155]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mspu2-1jedzf1I2C-00tEUP for <git@vger.kernel.org>; Fri, 10 Jan 2020
 09:26:27 +0100
Date:   Fri, 10 Jan 2020 09:26:27 +0100 (CET)
From:   Erik Fastermann <erik@fastermann.de>
Reply-To: Erik Fastermann <erik@fastermann.de>
To:     git@vger.kernel.org
Message-ID: <1032627506.120165.1578644787174@email.ionos.de>
Subject: Question about the pack OBJ_OFS_DELTA format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev25
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:zB3eKXeMdT6CurTr/z8C6ckCJtUhtYX+mbHfmmeBbnRY2j3g+vZ
 wnEe10Rj/z59fS8VuJ3LiZF91AXZviPYvMetk2I8EwKjAEPvHCfBtoDFW5aX8CuwFh25ypG
 Vcv65C09ui/ijq7pzy+W8rsfTEXZqkhr9I7ez6r5V6wQ7IZNsUfaGuo5nkZhuOkp+Yfx5LU
 NLddeh4fHqqB5gtt35CWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XweT4kS3/kI=:xKJuRXFpjIn4FIm5eG0630
 mtAwMV/f0GpzKY4ojlUzXLBWm10Iv0Mg/ZGVHJ24lKayb4CUh0q4F0skr8xEqSV9nB2vOLm/n
 neQVqWse6UjTwow56/xHXUXmyKqQjsZCOHogdRK6Ja61KVQicuSdHabLzMVwkPj/bkn2wNIGF
 1BStP5hSlIYKvcKQ87X+xLAfUN6kNYwIFMmYhzajiIDQAoOCUNtOu0hADtj6rYUxIcJWmxsKw
 udjf0eBBjvhkIv2K0qJ/42oO4X0HL85Bybiv7Ow1pfVRpYjHRHMmZCAPfVA9/1gHIOdVi8USB
 Ga1J0FxHBL0BeBMziLBLyfVAUJLqLamCn/4eBzatdEYFun9fvA1vcL6x3iPLeyiCzt86OAcs2
 tJgqHpw1jGfModo4DEa2I+ZdvV0+MMy2LAmUk8id6pQ5s89THTPvDjz2Wd6/gx8TpAQKirWlu
 61n8m9CLyT7w5Ve8W6jGNPOZCeLLmdOXF2buzTG6xnJCQ8TdEY/6SdHMHYUujVy+6uoYYgBE1
 XL9QUICUeXBI9HG5WQ84vxDNpo7T75iUD5NR2/bGHFUdPn231j6JvaaFzNsFycCrinrC3Uetv
 t1G4Jrsj/vprVSfy7/Z0azSE3xKMqSBmK4ctnuUlh+8+FY7rQppgqRzSVBAHRGW8LMIalFi1Y
 eqqh8haMTD5z0a/bXijlu5V/GrvF5Y5uZpcpZUMcFDmHINzg+95kf5efKigRg+p3TUXejFHwN
 z6mrVkuk2WaK6pvau5GoTrMPGhpeyBmGj38WuUR3EtxVAkhL2jVBauV0ZwuJPswIEf078ufx6
 HbdAdu0Ckp5clAYPvtos/cZro+6bYgv6YcuAO9aqxOxafKtnuJwQyECW/AA4jTnS1bNKTZu+A
 VZCDhC9S13mpItSGcRF/NNj8blr2B2gRa5JyY7u9k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm trying to implement the Git pack format. Parsing the index file and
unpacking undeltified objects already works. However I'm unable to get
the offset, if the type is OBJ_OFS_DELTA.

The very much work-in-progress Go code and data can be found here:
https://github.com/erikfastermann/notes/tree/wip/git

From the docs (https://git-scm.com/docs/pack-format) I assume, that
the offset is a variable length integer, like the size.  However my
caclulation leads to a illogical result.

When trying the hash 8c40ff4767d973b672fe5aa431cb8ba0593dd26a with:

git verify-pack -v pack.pack

I get: offset: 138650 size: 30.

The base object 9b25d441c1bf358af01edc4eeba65870581a5ac1 (shown by
verify-pack) has the offset 136887, which I think means the delta should
be: 138650 - 136887 = 1763.

Using the command:

dd skip=138650 count=4 if=pack.pack bs=1 status=none | hexdump -C

I get: ee 01 8c 63

The first two bytes, the type and the size are correctly computed.

So the next varint should be the offset.

8c: 10001100 --- 63: 01100011

-> 1100011_0001100

-> 12684 ???

The result is the same when calculating it manually and with my program.

I probably have some crucial misunderstanding about the format, so a
clarification would be nice.

Thank you for your help.

Erik
