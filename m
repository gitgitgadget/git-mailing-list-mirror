Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5324B211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 21:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeLEVNC (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 16:13:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36575 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeLEVNC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 16:13:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so18286231edb.3
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 13:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=I+jHCsxgxfNFE9fmeDSuhjHhvRXHTkUnOkI8R95ql4U=;
        b=XPZHisaP3LJZrvKZDtKaXjIhoKtpMJ0LzM0VrnVj57/a0j5lRUkH3n/ZBPg98/PnjU
         vfyMoaNh71ala6104DIXeEb1tnzN8pxwjml5ZHJ93QahVvwTq/A4CYsMm1UBu4h90Ejf
         8r8mhDar5KjG+YuRLyaK7C/KBYHgHgCZGEKx5R/UaRuhZXzNzSZ3vHFRVN4+/nTPzqBJ
         Q+gYcTWrK4XaDDJhOE6FWrPkiVqgYm8vgoojeBz8oAkcdoRAHk/GDqHuGmItYiBcJOfe
         69TpHbTFZpuoXb1oVCGIKoD/Hi5GGNLt/GBrr2C8UOMDaGB99s1bDEIji563p4/GL92q
         eeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=I+jHCsxgxfNFE9fmeDSuhjHhvRXHTkUnOkI8R95ql4U=;
        b=qP577POS+FCeStGngk6BG4/hjdNSHIh5X1FonkdGMMC2kvF+Ke6j+txK82Kq8t5FnY
         wiPfbWEU+H1nZEqVTHetQiafA10cV2yRUB9j9yo8grKqk5LxhtufZins5IZlbpgWtUnu
         lbYVP6Ffq7J0XHGiBEwKnzBimGQ5mdmVdhcv7e1VM8QgEyo/JwIa0LJ3sONVd7gThers
         nFlNct73OweNVB3IE8FCgsPwOJMxUziPVRIMdTNWqx6A3pccT1k7X1Y2A7viD7IKu6d8
         vh5uexhF/zAAmyrkZ31N2a7sb6jVyckfIvWibWxGYTmGraVtxHl9kTcP2KQhvsS379oO
         JSBQ==
X-Gm-Message-State: AA+aEWZcR7IDfJEWvdDVpEg4/VeIyA4Np8POMqP1qfJd8SIjdwY4F8lR
        eeNkUvKaY5+qASbWtMmPOfQ=
X-Google-Smtp-Source: AFSGD/WccmVJ1Pu8/PQNFXplHk2LH8jUfMCa4A4BxrrJeFFUWv5MqS9H5FlV6PEbEkxzipc/PWZJuQ==
X-Received: by 2002:a17:906:5c45:: with SMTP id c5-v6mr19576745ejr.83.1544044380751;
        Wed, 05 Dec 2018 13:13:00 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id gk8-v6sm3376994ejb.42.2018.12.05.13.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 13:12:59 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, John.Coiner@amd.com,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git, monorepos, and access control
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com> <878t13zp8y.fsf@evledraar.gmail.com> <a5a3009e-346e-2b63-5b7c-3e9daf0c7de2@gmail.com> <CACsJy8AzMvG3U5GnVkn0Ax3XP3NnPCwwc1AzdVV9JkePfMjwWg@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8AzMvG3U5GnVkn0Ax3XP3NnPCwwc1AzdVV9JkePfMjwWg@mail.gmail.com>
Date:   Wed, 05 Dec 2018 22:12:58 +0100
Message-ID: <877egnznhh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 05 2018, Duy Nguyen wrote:

> On Wed, Dec 5, 2018 at 9:46 PM Derrick Stolee <stolee@gmail.com> wrote:
>> This directory-level security is not a goal for VFS for Git, and I don't
>> see itbecoming a priority as it breaks a number of design decisions we
>> made in our object storage and communication models.
>>
>> The best I can think about when considering Git as an approach would be
>> to use submodules for your security-related content, and then have server-
>> side security for access to those repos. Of course, submodules are not
>> supported in VFS for Git, either.
>
> Another option is builtin per-blob encryption (maybe with just
> clean/smudge filter), then access control will be about obtaining the
> decryption key (*) and we don't break object storage and
> communication. Of course pack delta compression becomes absolutely
> useless. But that is perhaps an acceptable trade off.

Right, this is another option, but from what John described wouldn't
work in this case. "Any hypothetical AMD monorepo should be able to
securely deny read access in certain subtrees to users without required
permissions".

I.e. in this case there will be a
secret-stuff-here/ryzen-microcode.code.encrypted or whatever,
unauthorized users can't see the content, but they can see from the
filename that it exists, and from "git log" who works on it.

It'll also baloon in size on the server-side since we can't delta any of
these objects, they'll all be X sized encrypted binaries.

> (*) Git will not cache the key in any shape or form. Whenever it needs
> to deflate an encrypted blob, it asks for the key from a separate
> daemon. This guy handles all the access control.
>
>> The Gerrit service has _branch_ level security, which is related to the
>> reachability questions that a directory security would need. However,
>> the problem is quite different. Gerrit does have a lot of experience in
>> dealing with submodules, though, so that's probably a good place to
>> start.
>>
>> Thanks,
>> -Stolee
