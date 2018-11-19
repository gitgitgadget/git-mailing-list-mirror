Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45E7A1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 17:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406653AbeKTDjQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 22:39:16 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:32897 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406532AbeKTDjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 22:39:16 -0500
Received: by mail-io1-f65.google.com with SMTP id f12-v6so22801859iog.0
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 09:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jar1UkzdmkY+YoFrk+z38dtsNtKPYSkfT4xmdkOCWfM=;
        b=HpPZ9FPxPm34OGzpmCa3+12ehwXA/zEfNSWN4EipUGqcTxjKcl9gylBFk9r9DEE/IE
         JIUiDiwkeczANXb8ww8IMnZ7h92HImyAm7qQcCPHzkbBRygQBAElN7MbyFbqUKJa0eHP
         vvrr6lzKxjbzx5Jt/VEjhPn7g9mNuQFc0x5lvIB8MsmMju5bUwHJDwn6MA6CJdH8GM7n
         f16cS0OAcPiOb2VUrH3oi9IGJ0Ow5dNAI9i7XxpxyVYtPMaCDwn9WfFiQim62aamzsPG
         59d6z00Gbs1gUcpCZ1pFWT4zBzeORQGchIToGRe8uzPG29yw4tqSVacIFrgA71stWYql
         uoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jar1UkzdmkY+YoFrk+z38dtsNtKPYSkfT4xmdkOCWfM=;
        b=FVRPH3jj2uqUK+t+4nKkiED8ma7ZPfrmqpRt+MoyE9KpNW+2F4laxIJjCFU0iLMe71
         RtnqAmLrMPAm302XU9tEi6/Q72lShCs8LEWA098x2zUwI26Ha7jdJuw0UwXSzIKKyyzW
         8zciUFHhr5rUYXQqRETyWRTZP8ATtOrw/xsZYxfFV3EKZxBPP74nUtM0zBUOzF9IUXCP
         Ja4DTwVut3+eLGz6s9hDCdZ3z8tjVfNzai/AGlLbwZUdxmeoMA4ZtRVwKAJb6PxBZI0l
         pLnJ090/4DtVDFiP9FvPFycCvlfByJAuWE2BZrjaHQnyMTKUfHFsyiK+YHtHbzg4g89H
         OBWQ==
X-Gm-Message-State: AA+aEWaQUxfwBtCZWudYJ1uvOn9+ZIeM3fb1weq3E47nORgdQ4MpkJll
        2/t79aUqmTODYZTYCEt+xdXWRalt21TRdSfQ/wQ=
X-Google-Smtp-Source: AFSGD/XJgaqr/L6FIrwokHQW9OX8T+aeg8/SgDp8m/8mF3JJXq1OAc2y55b2ZhKkVM81S4MKQcSgPzAjkmXboRUDaAI=
X-Received: by 2002:a6b:3e45:: with SMTP id l66mr16766219ioa.269.1542647695407;
 Mon, 19 Nov 2018 09:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20180817161645.28249-1-pclouds@gmail.com> <20181119082015.77553-1-carenas@gmail.com>
 <37b7a395-3846-6664-9c4d-66d2e4277618@web.de>
In-Reply-To: <37b7a395-3846-6664-9c4d-66d2e4277618@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 19 Nov 2018 09:14:40 -0800
Message-ID: <CAPUEsphrYOV64m08JY_tsVuJ-uwTv=o=m5LdCFOWd+8tWJP54A@mail.gmail.com>
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive filesystems
To:     tboegi@web.de
Cc:     git@vger.kernel.org, pclouds@gmail.com, git@jeffhostetler.com,
        gitster@pobox.com, newren@gmail.com, pawelparuzel95@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 4:28 AM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> Did you test it on Mac ?

macOS 10.14.1 but only using APFS, did you test my patch with HFS+?

> So what exactly are you trying to fix ?

I get

not ok 99 - colliding file detection
#
# grep X icasefs/warning &&
# grep x icasefs/warning &&
# test_i18ngrep "the following paths have collided" icasefs/warning
#

and the output of "warning" only shows one of the conflicting files,
instead of both:

Cloning into 'bogus'...
done.
warning: the following paths have collided (e.g. case-sensitive paths
on a case-insensitive filesystem) and only one from the same
colliding group is in the working tree:

  'x'

Carlo
