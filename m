Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFCC1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 05:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeIKKTn (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 06:19:43 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:33927 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeIKKTm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 06:19:42 -0400
Received: by mail-it0-f46.google.com with SMTP id x79-v6so7933809ita.1
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 22:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WLzi8VTfScXAmIGP3mSBhdkSbD7iVoSxCcwgjdCciTo=;
        b=mlnBUBXalLT+0XTTdFgB3DJ1Qz0ujWX/9ElAf0Uq2WIN8fzvjiY0e6QCG+xurn9j9O
         1KS4xxmtAjOVj3HVqghpLGMF5lCLCBrgj9ia4NS3GTlhDOO/cfnNfNZCuDq//79SDTUH
         IzycgW745BHDp6xlYPdb8VJwmmyn048TMJdHqfX8Zt7dyRxLGG3vbEA25TyrH6j5ZbvO
         7LJAbLiA4fmyj6mcPg8CX5XJ2+pAIdGC0W8BJCp43EjugvyELktaYQuT1BDpO5KHJQ8r
         psnjHmL+Sbu1L4ojM0nLpd4JKf0VieMqWsXFLB73NreDmCUoDi26jIPIeRMGsI0krLUU
         Zldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WLzi8VTfScXAmIGP3mSBhdkSbD7iVoSxCcwgjdCciTo=;
        b=sfeOz8sAAxHGVw6087f6N1J68kEeih3rMlEBKfD3DBjW9lBKRzOe4uNrxhptyvn1Rj
         rAObw/7AUDfD1It5l5MDDRcDbtOouPoPXc5hd5B+D+Vb0k1Cd4rsopHPhs5PMmfw6p8i
         f744WVDj2vk5J7t3q5JQ6VQWjAEBNE9/1lS76TzoyJZVye1OPKSRQr8kgncVZmc+t9m2
         34doyENZj7ZWrd1VAREcIBMs27bSGdcf2UXPwvdroYIqwexZVllKdDPOqVSc3YcgCiAf
         Hiy+8t/uQ8XoLiVsg2WrvkJIqRBGoqlMiHEfunn8idkflTaffIPWIeJ7fsnb46zegLlC
         Ac9g==
X-Gm-Message-State: APzg51CMr6UQ/P4hUu0Ks5Xql9pEbysgRsoGDjaTN92oRKAOMj53a0vK
        8iiiO9kF85cmi1kpbuiFYQIzFgaJDCDTTsTcuJY=
X-Google-Smtp-Source: ANB0VdZF2nVr+1EUe2DbBS1Z+G9YhcOY3BAfN3F0IFWZPlMthvs+LnTzAbn84AqcmZgo/9vbJ5opzIcHl1boypxKlgk=
X-Received: by 2002:a02:a70a:: with SMTP id k10-v6mr21380909jam.47.1536643331058;
 Mon, 10 Sep 2018 22:22:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 22:22:10
 -0700 (PDT)
In-Reply-To: <20180627132447.142473-21-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com> <20180627132447.142473-21-dstolee@microsoft.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 11 Sep 2018 07:22:10 +0200
Message-ID: <CAP8UFD3kzZo8qQqj=8T-TXbvb9b-KD=Ok7TgdV--Cb8MT4NCiA@mail.gmail.com>
Subject: Re: [PATCH v7 20/22] commit-graph: add '--reachable' option
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jakub Narebski <jnareb@gmail.com>, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 3:24 PM, Derrick Stolee <stolee@gmail.com> wrote:
> When writing commit-graph files, it can be convenient to ask for all
> reachable commits (starting at the ref set) in the resulting file. This
> is particularly helpful when writing to stdin is complicated, such as a
> future integration with 'git gc'.

It would be nice if the "Future Work" section of
Documentation/technical/commit-graph.txt had something about
integration with 'git gc'.

>  With the `--stdin-commits` option, generate the new commit graph by
>  walking commits starting at the commits specified in stdin as a list
>  of OIDs in hex, one OID per line. (Cannot be combined with
> ---stdin-packs.)
> +`--stdin-packs` or `--reachable`.)
> ++
> +With the `--reachable` option, generate the new commit graph by walking
> +commits starting at all refs. (Cannot be combined with `--stdin-commits`
> +or `--stdin-packs`.)
>  +
>  With the `--append` option, include all commits that are present in the
>  existing commit-graph file.

The "EXAMPLES" section still contains:

* Write a graph file containing all reachable commits.
+
------------------------------------------------
$ git show-ref -s | git commit-graph write --stdin-commits
------------------------------------------------

I wonder if this should have been changed to use `--reachable`.

Thanks!
