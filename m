Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D8D1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 02:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeAYCQr (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 21:16:47 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40975 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbeAYCQq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 21:16:46 -0500
Received: by mail-wr0-f195.google.com with SMTP id v15so6010777wrb.8
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 18:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xRVL1nGi2byMeLM9RdD0iiHRAcluq/qXt/lRn6CH0Ko=;
        b=Q5iXtfMH+ZwbikaJA6oYIYj+bE2QFksoMd3tti62ucN6r8ucAnJcjAdVTZk7u6AGuf
         SScfXBWRJoOxdOxVTpmoafu4dH5BZVvyu4vwbNdekRsVmIkgTNwNzk0bHqgn6St2Ed10
         symZScwuU1/L1rhYIgEuk2bTWT3Hf/LyQwfUjOH/jZWu5L2hjhcXRpMituBlRFvTWRYu
         1Mn1MdHTkQY1R+xEbZ4UvAL1AhaZe4N9APTDixa1dnFjOQiY8Uoh2P4OPwU9qSnbhnzZ
         x/mRuFnlwfbN9Bdfel/t8DBe0/IGIOEwcVLgGY4sQISegkPAt5TYX6wN/Ba5WNYOM+h4
         mpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xRVL1nGi2byMeLM9RdD0iiHRAcluq/qXt/lRn6CH0Ko=;
        b=CMzQJ3yZzH7cKVyDcbfcaC0qc8o5qtCWtlRe85092MrNtlrCdyWqVppnGUo1uHI42r
         4yEGDof1jQZCRU+vU8eOewCN+xJ1Ewur/bp+i/JvE0KY10kveOKXPAoW80Z75zFks2j5
         p9W+1i9duRz/aKnlmyG3U7t0i1N5nWr3hhlTqa+vuTT7Qzj5pvu1LYPWt+YvvbY477ov
         H0T2he1z3ua1/Bg8UDRlFsv/Z+mha36T6WkDRhN/9+BreuNF58RiSPz3A7q/81O9vnH+
         x5cVxtZLcryGppJNyqnYpHW3PSFo3DsmNIYM/+53S2WhxhsXyXFD4vFk+pvUP6+I5IHJ
         TkaQ==
X-Gm-Message-State: AKwxytfgZUuCZhdswUmnw+Z0pZqlXLb575EsrSQ/Cxfv8K3b6/HHgqkf
        TOSy45lQfmsp903wMMkesuiK4v/76rEhnUr9i/I=
X-Google-Smtp-Source: AH8x224TG8XfTt4psFPHGzRFE/opNT8h0B6vojjwCr6S/sn4q3YquQTgdwczkzJzKoN62Qv8PyqEE7XspyG7zcNcFQE=
X-Received: by 10.223.152.83 with SMTP id v77mr1009349wrb.233.1516846604975;
 Wed, 24 Jan 2018 18:16:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.166.115 with HTTP; Wed, 24 Jan 2018 18:16:44 -0800 (PST)
In-Reply-To: <e3d1e1f4-9927-47eb-7662-2c6918555058@gmx.net>
References: <20180123001648.24260-1-isaachier@gmail.com> <CAG6xkCZn6m2n0rDvpN6MmZcOr2hJBRCfhrppC37f-DUj3_JZsw@mail.gmail.com>
 <c5d21b22-e4cd-e338-c953-90a81981e23c@gmx.net> <CAG6xkCbtVYa_eqZj4m74jXo7yC8kS8kjWm-fALePmHaH5yY0qg@mail.gmail.com>
 <e3d1e1f4-9927-47eb-7662-2c6918555058@gmx.net>
From:   Isaac Hier <isaachier@gmail.com>
Date:   Wed, 24 Jan 2018 21:16:44 -0500
Message-ID: <CAG6xkCZK+Vda=Mtpy665tiGZ_FpXzUaz__w+FFpfE+zZioRX2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan, I totally agree about the advanced options. At first, I left
them as visible options seeing as the Makefile does not comment which
are advanced and which are basic.

In terms of the up-to-dateness, I find it easier to "fast-forward" all
the changes at once without tangling myself in a load of periodic
updates.

On Wed, Jan 24, 2018 at 5:02 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> On 01/24/2018 10:19 PM, Isaac Hier wrote:
>> Thanks for your interest! This patch is based on the cmake-build
>> branch of https://github.com/isaachier/git, but the full history is on
>> the cmake branch (squashed it for easier readability). Hope that
>> helps.
>
> Thanks. I use the cmake branch because I prefer "real" history over one
> huge commit.
>
> And I already love it. Thanks for all the work!
>
> From a first short glance, I wonder if you should mark a lot more
> options as advanced options, like the paths (e.g., SHELL_PATH,
> LESS_PATH, GETTEXT_MSGFMT_EXECUTABLE, etc.) and probably also things
> like GIT_USER_AGENT. If you use a configuration tool like ccmake, you
> see a lot of options and many of them are not relevant to the average user.
>
> I also think some variables have weird names, for example, POLL, PREAD,
> MMAP should be USE_POLL, USE_PREAD, USE_MMAP, respectively... or even
> USE_*_SYSCALL, I don't know.
>
> By the way, regarding up-to-dateness, you are missing these recent
> changes that have been merged to master:
>
>   edb6a17c36 Makefile: NO_OPENSSL=1 should no longer imply BLK_SHA1=1
>   3f824e91c8 t/Makefile: introduce TEST_SHELL_PATH
>
> (which is not surprising)
>
> ~Stephan
