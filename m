Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C6F20248
	for <e@80x24.org>; Mon,  4 Mar 2019 12:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfCDMmm (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 07:42:42 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:41019 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCDMml (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 07:42:41 -0500
Received: by mail-ed1-f52.google.com with SMTP id x7so4116484eds.8
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6dBAiJQl7tonO2M3Tz8tV5UAK/OMy2GiJ6KcEuwHwEg=;
        b=pu7TD5LLiSylALIt2IQ1Gj0XGPQPDwqEuszHyNKNGNAzxe4wommRQv4XF6oa7dmD97
         Zauq48xYosLE8u1pIzeOEaqKiDOjiQ4ZIMIY0oMXps0i/DnuVpZVj21XhJtZksWIODLA
         AAUNTmmypSCdyZWzJVi79IPGtQQ5iz5MOLcZi9JDE60vu5zNlmMBw8Np7MG7egfWAO/1
         IBurol9YHvU0PUbRuHXOhOPYqHZTqveJLE2L0AQOotLHmVJ398iThu3DMAGg354Dk0lj
         EJ5aDkx+WkQY92mDDhgi9ic2iSFy+56XvdzZ67ag2xFxiDyll+X8QLI+bSaK5aYfkSHO
         9zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6dBAiJQl7tonO2M3Tz8tV5UAK/OMy2GiJ6KcEuwHwEg=;
        b=IIzTXdYR3UyGN2a5Oo2kDEN6bioeLz3N/akyPhgKxO30ZQxG4OuDnP8PE0mJtKtVsy
         BKzjHXQLY+hC/4m5UA6M5pCMIxiSsv9G2ayNWvfncw4bxe3z6rkaxC9Ow2kmsQ5yo0bz
         jHOKN0eFelh17jdYgeb14Gylj62O5z7KXMgJhtDYMfcAvOqtGzQzRAlBiVN6ScZ3cjs7
         M5lS0aAj8zF0j5ldor8dBQy3pNBAwnBJf8sD6x+5oxSFIMPvM3YSLaRbtX+KhLaF5vew
         UNWQkGQQZcKFKejhoDPs7y2pSNWtcoVgtOp1W0n6Fe5aQeuo56oPh26jeAP8wtEGUTlo
         a2rA==
X-Gm-Message-State: APjAAAVBtkYz9vv/13MALOSG757tfyfUucQKcUTTNr5FIg/Sntczd/mX
        zeEWAaaV3DZLLlDUbf0pm6oCPrd0AHrTxuttksfjUWnX
X-Google-Smtp-Source: APXvYqxpvP9je2TVz8KSeiITeUOawQU6qYnbwQ1cE1o0VBVe6pio+c5pvtqjA0eENE9fVQH/7dP1KmnN6MOx9j18reU=
X-Received: by 2002:a50:a4ec:: with SMTP id x41mr15007948edb.27.1551703359570;
 Mon, 04 Mar 2019 04:42:39 -0800 (PST)
MIME-Version: 1.0
From:   Sandu Turcan <idlsoft@gmail.com>
Date:   Mon, 4 Mar 2019 07:42:19 -0500
Message-ID: <CAEnBgA0=F8rDkUJEy-nUYGuqPMvMW1XwkAg=B8uN9yDTQtzRMA@mail.gmail.com>
Subject: Git Monorepo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At my company we need to be able to manage access to different parts
of source code.

We've used separate git repos in the past, but then discovered
Mercurial=E2=80=99s narrow extension, which supports sever side filtering.

We all clone one repo, but get different subsets of the source, based
on permissions.
It=E2=80=99s pretty seamless, and works well. There are some limitations, l=
ike
not being able to merge files outside your filter, but on balance
things are easier to manage.

I'm trying to see if the same can be done with Git.
The latest version seems to have some ingredients, like sparse
checkout, and blob filtering. They're both meant to address
performance AFAIK, but perhaps can also be used as foundation for
implementing permissions.

I have some ideas on how this would work, and my company is willing to
support the effort, but we'd like to coordinate it with git
developers.

There have been a number of attempts to implement a git monorepo over
the years, I'm sure it would benefit a lot of people.
