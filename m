Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99671F424
	for <e@80x24.org>; Tue, 24 Apr 2018 18:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeDXSLo (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 14:11:44 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:36979 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeDXSLn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 14:11:43 -0400
Received: by mail-ua0-f175.google.com with SMTP id i3so1943514uad.4
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 11:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RZjjs5xkLSj1OlaXVoE0YZDEERDL46CMlaBJySNK9mk=;
        b=q2DMJrUPnWlBTSrvuAUIsDK8/CN0f/D6OvIFArInjksqEjpwmokrgoRZgxFuNwfvXR
         11eoQxAUY1rWNdVHRpsmEXt/VTxW/DgSLO1s2Mp6Dc/zgoaVATp/LKhAfWq31pT7zzMi
         JmMV7+8caSVA+zprkLZ5asIgeS64jzbrBLpKl9MOACx2CnGYHXrhv7qGBc9nRsWt0zyY
         37UMjLC28P5AfkrdTMgOufxhvWIQpBwHmVlPJ40pGHkkSe1o3I+gzBaghG57lLKCkBV8
         u7JksZ7LglSpoblkuF7gjDHNIRjAIIZVSWRo0pu5BNQkKpODOog/WGoqFD1chtbpLy+X
         qNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RZjjs5xkLSj1OlaXVoE0YZDEERDL46CMlaBJySNK9mk=;
        b=kwjtl6JIX1a90+y/tb44U8dvgv1C0IXs0GCNzVTcot8Y45jbLyg5jigyD4OvfCdcGC
         xUTW5QbnCpeeY67nZhp0BuU0nSEyHabjhNkeJqgPd/exxEFdFu8VpxXALJfi78y5Gkim
         v0r7tJi/QiBd7UOueb3P59rMXtBFvtu5TtgATVx6fPTt75wTM3hZlUWHxgTT6TdZI/SW
         YHGrKZqzmy7/fmp5HBGgGHJkOQShid4QKp1xyQBzUEE1eS3TkaS+2xEgZI8oWgyOSTLj
         Pm6O0lfNtY/qLumw3AN4HovjAsvcSB+X8w+/kETSc5wsdEOKEeqj9jMJZNurXiyyMnMw
         Vc+g==
X-Gm-Message-State: ALQs6tDiseUeWMCXWg1NubcDxiYwi8huWdlmD2KXOr32Xd2qzj+KA3L8
        3bWcjAKm7CpGzJ2ZPENHTCdSba+M3jeS/lmdseY=
X-Google-Smtp-Source: AB8JxZo6r8/PaM8O0Bvmo+oXsZ6xtQ5h3qUxyGP1CSq0qIgvmy9bZOnCMeJyn7t4vNhmUiUjTvP+Ifynz3H4MNr+mF8=
X-Received: by 10.176.10.26 with SMTP id q26mr4150829uah.23.1524593502366;
 Tue, 24 Apr 2018 11:11:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Tue, 24 Apr 2018 11:11:41 -0700 (PDT)
In-Reply-To: <20180424171124.12064-2-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180424171124.12064-1-benpeart@microsoft.com> <20180424171124.12064-2-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Apr 2018 11:11:41 -0700
Message-ID: <CABPp-BGDS4ocBbjqW4FqosPvOe11crzK2G2pZa+9Q3hgGXsPfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] merge: Add merge.renames config setting
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 10:11 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> Add the ability to control rename detection for merge via a config setting.

Sweet, thanks for including the documentation updates.

I lean towards the side of the argument that says that since
merge.renameLimit inherits from diff.renameLimit, merge.renames should
inherit default value from diff.renames (allow people to not have to
repeat themselves as much if they want to use the same rename settings
for all cases).  Sounds like you and Johannes disagree.  I don't feel
super strongly about this item, but it'd probably be good to get some
other git folks' opinions on this particular point.

Other than that unresolved question, and the separate one about
whether to go with a different option instead (e.g.
merge.defaultStrategy), as being discussed elsewhere in this thread,
the patch looks good to me.
