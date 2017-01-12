Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C70BF20756
	for <e@80x24.org>; Thu, 12 Jan 2017 07:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750762AbdALHSd (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 02:18:33 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33768 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdALHSc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 02:18:32 -0500
Received: by mail-io0-f196.google.com with SMTP id 101so1572982iom.0
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 23:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FTvZkj+GIigERPNXjvBDFbdn46tKD6jVyIrmckfIMXk=;
        b=a4vvCNrXV3wrahbN5YYtKznyiNmCLQV2Loj9tYX1iz36r3TyPuxtF57N22mAzuJtbI
         LNCALnxSJ8e0lxh9xty8w25YOVHQG2By+2Is4Qrf/QLYP19L8QDXcpi2M3TbECnP3Xby
         ms9v2DvtrLhUbWxic5ZT2a1SI/jMcSDmU4hYzjXAVvAauBvXceFDRWHJ3Wl6UEPBmEU+
         tpfzNhzK6mpj0AO1ZYDMI6904Dk8dLrQNK/ywKCqQAm1V/D2dHMU/tRY/VpjF2uHHZdq
         A3xQYhKeWOn7RN4ykkMFCA15nErrt7eBUaJQQQ8l2RjaMGA62P8+3sUyioVfX3iTGCiI
         QW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FTvZkj+GIigERPNXjvBDFbdn46tKD6jVyIrmckfIMXk=;
        b=ncIICDbK2s4i8LUTBrRXK4ADmCeq4i3PNZ5/JsBWCPrp5izUVywKaJlDj5KtGrPhzC
         fzhAzX5m22PmaTTHMOi34N5NLSeZVYqQbKNen7crEJ+k5HhNIEP3qseILj5eIIh4/d0X
         f14QA7EZC5xcF387sA+REoQSXDxdHoak987XH7u8TB5FFQVjQpfm8JRVsZZD01GaURqK
         IP2XZ5PaukrpMeiWh1oaJjfRgnfAeivBYbEbsg+Yf5XuV0FifR530zwZD7dTYtYY3toB
         1YTq165fxjIE57jfFHheRkaYaq9EbkP9LJ5MK4ncDyRFscFx+J4pl2QmD04YUKHHL1zN
         4LaQ==
X-Gm-Message-State: AIkVDXLSvsmUfnYRaJL6C3XkvPCRd1fsfL/jUFR4cvNi6gYYQTOolsjTSPCvdZXsOK47O8SulrqqGV6bTRxMDQ==
X-Received: by 10.107.31.71 with SMTP id f68mr4406640iof.236.1484205495545;
 Wed, 11 Jan 2017 23:18:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.50.131.84 with HTTP; Wed, 11 Jan 2017 23:17:55 -0800 (PST)
In-Reply-To: <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
References: <20170112055140.29877-1-pat.pannuto@gmail.com> <20170112055140.29877-3-pat.pannuto@gmail.com>
 <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
From:   Pat Pannuto <pat.pannuto@gmail.com>
Date:   Thu, 12 Jan 2017 02:17:55 -0500
Message-ID: <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not at all attached to changing all of them, just figured it made
sense while I was here.

Would a patch that changes only:

 git-add--interactive.perl                     | 2 +-
 git-archimport.perl                           | 2 +-
 git-cvsexportcommit.perl                      | 2 +-
 git-cvsimport.perl                            | 2 +-
 git-cvsserver.perl                            | 2 +-
 git-difftool.perl                             | 2 +-
 git-relink.perl                               | 2 +-
 git-send-email.perl                           | 2 +-
 git-svn.perl                                  | 2 +-

be more acceptable?

On Thu, Jan 12, 2017 at 1:27 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 12.01.2017 um 06:51 schrieb Pat Pannuto:
>>
>> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
>> index cf6fc926a..6d7b6c35d 100755
>> --- a/git-add--interactive.perl
>> +++ b/git-add--interactive.perl
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/perl
>> +#!/usr/bin/env perl
>
>
> This change, and all others that affect installed external git programs, is
> a no-go. On Windows, our execve emulation is not complete. It would invoke
> only `env` (looked up in PATH), but not pass 'perl' as argument.
>
> Sorry for the bad news.
>
> I would have suggested to set PERL_PATH in your config.mak, but that does
> not change the generated perl scripts, I think. Perhaps you should implement
> that?
>
> I'm not thrilled about your changes to the test scripts, but I do not expect
> that they break on Windows.
>
> -- Hannes
>
