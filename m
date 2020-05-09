Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A07C28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 19:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7F5206B8
	for <git@archiver.kernel.org>; Sat,  9 May 2020 19:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mQ1vkJ4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgEITYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 15:24:53 -0400
Received: from mout.web.de ([217.72.192.78]:51955 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgEITYw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 15:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589052284;
        bh=3LHuKCBXf6mr5nCBezTS7xLNhrkgBkmWsSBn7FleDlQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mQ1vkJ4luI8rx5PmU8JthrsEyKWessjNOX+mb9Dw/2Uavdnpy1I219sd1pUZZqOSo
         JT5+Eu0lHV3bITw9lXC6cYR2HZ2KWL4yO4eXj8KyUTskhUaMkvnAGQ2OiPQbnfbNMV
         tTFLDL1KzLJIqrkRsq/+MuiMjqG1CAB0Nu2JqP+o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lu4q2-1j5h9u2fos-011PGx; Sat, 09
 May 2020 21:24:44 +0200
Subject: Re: invalid tree and commit object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
Date:   Sat, 9 May 2020 21:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqpnbduiec.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lvjM3FIHDX20YaoCSQxfoEwjgtc/Q8VhuWi7nok/L/k5kM9XhJn
 WWz4YkT4NGbCGMjGDVePB/aju8JtY3Jr7cOS32MLUXku+wkEzqDQE8NciwXUt9Z6QIGOYve
 2USfx+QgIAOsy9DdY46cPS3fO+ptxJksc9MjgxBi6v+902KSrR2/nJwTd5ETl61n710zl/v
 lOLO755IrqstIlPxtwFQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rww9VkuMwS4=:6FBuOrYp3UsS3Q8u1SP/EJ
 cV9OJ7ll1jvjkS3TkqmKTCOjv+wHD4lkU2xJKVcnoXn+ijFl5H34G1MC44dkMLqgXDySeW/52
 kZbSAOQOsHFbTcL1NKXHk9FjCufyIyMKCOuoTIxNB56OnMI64RQbTASNrwACj7C6yMeNZ79bp
 fp9drS+C+U4VUeL7bgQwvl1ugDhcUnIsgkpMryNX6VmV4xClOlKNtWS7K0BMGn1W8PmA+cBqO
 1JOOPlxgs6rHn5HPbWoDZ3OT3dp6b/b914Lqd8FJR//WEEu0nrUPedZiN0aG/6uR26S8VSr35
 nMh/w861FnZCDiK8Jcb6oPqlmYCuIWAogFXVUl8MjhQNceJzLKKcV+x505wYTMO1Zd8pwIWIy
 UpPunk60L+vCwi0HB0g3+ETAv6OlMg8MOXjSaOAU4YLaKbcyOWdwJ2THL4XeWwPiYGTcAx+AM
 qK2en7VZxo/WpLmc4MzeUzWRx01HCp9tX0JbT96ma/ONWx9EnE2/wfb8x6Bznfk8TNpTSNyPs
 joVa8PuRwCRlWs/qG6kIh7dUXySkf7zt6jLwhIyLvipvEi6havMVnnh9d6lfCO07VlGHcQwsh
 603JGMjgKg9NbeyiwOgvV2R1cskCkdYP+8cYw+BPhA8GlvIv434SzduT1lGkcHwZSzhiOMks4
 lUzNsT+9EHWqWqkur6BJWuOwJeX9GxJNM3aOVyY5hSoqCrNnEhzyG5xAdN4fO08eXNqQ7kyc+
 TsehMKAQ+bYeI5QrK11IKKHtH+BLFShhbnSnkopPJWYwC+uW40Sbd3/Uax878TRpLrnEMelgL
 8VNCF8WdbB8njMMwPXKLTOXiCjmNLSkBbRKjZI45BYPZIMnzdsk93Sauwl/iAcZelO2FLaKH+
 vAm+GVgdtPNKkDA4CckxgS3KOxDzX1LW64b6pbUAeidCz07xE7moF0P9puEiAUbHfsmFSXikc
 h2qXJvtkjOCTzELzigL/YRVwJcbUuoyvJ/DTf1QTYH3yQv3tgpkZ2v3GkdlO64joCW1EiteJu
 JOdc8V0+sJuV9uzb7/7YyeB4BNnvRH+ub3sfEVJ3hqaygU97SIjSkD5CBhfxykXm+CW3tfD1X
 0J8QeC3oxpgGSTybEx7+dSa///PgdESl8LjPbShW/yjklIOc2DV/sUnxYH3L3sbb4TBZVLCUv
 XPj5tzpHfcQdpWW0ARM36ini6jSbRf2pj4VQVSvxTUACBW8UDuXKXYlnhOyPWRdvzZcnl+c4h
 uzUsfQHFbgUBMfrld
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.05.20 um 19:28 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> So I got curious if such trees might be in popular repos, wrote the pat=
ch
>> below and checked around a bit, but couldn't find any.
>>
>> Is there a smarter way to check for duplicates?  One that doesn't need
>> allocations?  Perhaps by having a version of tree_entry_extract() that
>> seeks backwards somehow?
>
> I've never looked into seeking backwards in a tree object, but in
> unpack-trees, I had to deal with this exact problem that a blob
> 'hello' sorts before 'hello.c' which in turn sorts after a tree
> 'hello' because of the "implicit slash after the name for an entry
> for a tree object" rule by introducing the "cache_bottom" hack in
> the traversal logic to limit how far we must scan back.
>
> We may be able to limit the list of "seen recently" names in a
> similar way.
>
> If the tree we are scanning has 'hello' (blob), 'hello.c' and
> 'hellp', the bottom pointer initially would be at 'hello' (blob),
> then stay there when we see 'hello.c' (because the next entry might
> be 'hello' (tree) that would crash with 'hello'), and when we see
> the entry 'hellp', we know that the entry at the bottom pointer
> 'hello' (blob) cannot crash with any entry that comes later in the
> tree object we are scanning, so we can advance the bottom pointer
> forward.  To decide if we can advance the bottom pointer beyond
> 'hello.c' (blob), we see if 'hello.c' (tree) can appear after the
> current entry we are looking at (i.e. 'hellp'), and we know it
> cannot without violating the sort order.  So the bottom would move
> to point at 'hellp' we just saw.
>
> If we had 'hello' (tree) instead of 'hellp', when we look at it
> after looking at 'hello' (blob) and 'hello.c', we scan from the
> bottom pointer up to the previous entry, which is still pointing at
> 'hello' (blob), and notice the crash.
>

Hmm, this could lead to quadratic behavior in the worst case, can't it?
Imagine you have:

  a
  a.b
  a.b.c
  ...
  a.b.c/
  a.b/
  a/

If you have a single bottom pointer, it needs to stay at "a" the whole
time, so that you can detect the d/f conflict with "a/" at the end.
And for all entries in between you need to scan from "a" on and compare
each entry -- quadratic.  The blobs "a.b" and "a.b.c" don't need to
actually be present, but we need to scan all entries to determine
"a.b/" and "a.b.c/" are not conflicting anyway.  Right?

We could, however, reduce the names we add to the string_list to
those that are possible candidates for conflict -- blobs followed by an
entry whose name starts with the blob name followed by a dot and trees
that follow an entry whose name matches in the same way.

Ren=C3=A9
