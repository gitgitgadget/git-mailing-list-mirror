Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E95C433E6
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B7523B45
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbhAVVDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 16:03:22 -0500
Received: from mout.web.de ([212.227.15.14]:32869 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729275AbhAVVCe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 16:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1611349205;
        bh=udaR0YT3zorGdy5gjOrqVM89NIQNX/xgpGwDAdo/ZFg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=qnXR91wGpHvWJ6hGJ9p+FYa/yls+1sFOy7UcaEX0na+8RIMujymfXbN8GCpA1p9ZF
         3vfhc8cJVECVFJkNjPxXYttj9IKMc5zokaXY3aGBIvrZSXrJid7Z2nKgVXuateiYt/
         l+R0ujCNxiLsL3ANDfTHohGfpzok40VIy7otepeE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0Lp7Lg-1lhrvd0z2a-00exv6; Fri, 22 Jan 2021 22:00:05 +0100
Subject: Re: git archive setting user and group
To:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
References: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de>
Date:   Fri, 22 Jan 2021 22:00:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EGKqObd9eJIkB6M+6vNPVz5Lv6isth+RKDwBB2bUo/KEGwH3bEw
 P+h2aY6H00+5tf7AQ+Sx+RXYInuWIWXF7R+VlnXjRYXYbvcYjTtTFBQccO3c2rtQLs6BZaj
 Ch/Uq5gZAGP+fgN8Q1hEnsvdSTcCL54HXdelt425uOMRoJ+IwgpZ0/Qgi+G+CSA0GJnwl7Q
 wyTZVyhAphNwg8OQDmwIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rlCJRuGyvyM=:L9EBpO0A3vK8WV1bd9fsmZ
 dKu3KWp2sKF6u4VAHafJ5bQ469cKiiK/e4p7JlXl5pW67f6o6fL2YM1C0FkhdhqvItlSMQzF0
 aoit1VbZZRqaBezXiG1nXY4YaYbO6ieE2vTaXNbouble3R4uqXBGrMoNuGug86+Xl0GwLHHj+
 ukscMDwDdiSfI0bq5toaXhNlijrCEuXer4hY0+26/M6CdTF3IO/afGmM0qdQdA33mTHdOwx7c
 Egs6nR/fAAlzKHUkY706MHShqDNERnc/gT+RSW1eVsMg1YTciIM4EUyHNlpHyXqbpULkK6VqP
 2B0LYePb2Zrexw9T1pOKwCsJ5riDT90Bpyccin9AuwaBL6hnbr4JwLNf4YbNkxhlZgnW68T+U
 NsGZGqTqELW69jHxM1sjSu0VnAekWZjZEeA8L2UYmV2WWaENoUxv5H/uSPkAOuY0tAkACFnIa
 d3beQvAdGZTAUkZrFY/4lhzxrh+GwMjkjKDjcwoWUmOpQd6d1oFPQ+stR0JkdHk7soEsofYx0
 VEtSbHAzjJwpZZ68xQUgv/44cr95B6RwArgjxQnzds+9OP+Dz/ZKjD0ik/xzZm+DzJC7bH23x
 uABNm/2vpY5KXXCSKrI2+lLV/ZZpzWFmCwIQ1VG/XsEwMB4rpZ8dTUfwNO18FhfxYnsmBd1/4
 sITCIqLqkLqKSQ/SvztsU/eybjAQXECUutJsqcnm3pGYbGaSMtnzxq7sJKckLixbuNYTxVDtG
 ctPVJeXH3ssRjITarBbZONep9TKg84VIJDDlAOuBvcBJMYtfkA1M37pzG18mn+Ojc4ojAJ0Yu
 JImiuEz850alpWNjBxslHBBBNV3iQX0XAbsQKJN+q7CSG6wJzgBS7ttuYFDRvaRSmdBxmIKSN
 YoV2VHWSvpYh6iP+SHZg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.01.21 um 21:40 schrieb Jason Pyeron:
>> From: Jason Pyeron <jpyeron@pdinc.us>
>> Sent: Friday, January 22, 2021 3:09 PM
>>
>> I am about to make a release for logwatch tonight. Historically the fil=
es are owned by logwatch in the
>> tgz file. When I use git archive it is owned by uid 0, is there an opti=
on to set the uid/uname,
>> gid/gname owner of the files?
>
> Answer: not at this time, as it is hard coded in the source.
>
> archive-tar.c:
> static void prepare_header(struct archiver_args *args,
>                            struct ustar_header *header,
>                            unsigned int mode, unsigned long size)
> {
>         xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 077=
77);
>         xsnprintf(header->size, sizeof(header->size), "%011"PRIoMAX , S_=
ISREG(mode) ? (uintmax_t)size : (uintmax_t)0);
>         xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsig=
ned long) args->time);
>
>         xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
>         xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
>         strlcpy(header->uname, "root", sizeof(header->uname));
>         strlcpy(header->gname, "root", sizeof(header->gname));
>
>
> meh.
>

Adding support for using a custom user and group should be easy.  Is
this just a cosmetic thing?  Regular users would ignore the user info in
the archive, and root should not be used for extracting, and on systems
that don't have a logwatch user this wouldn't make a difference anyway,
right?

Ren=C3=A9
