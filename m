Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238C21F51C
	for <e@80x24.org>; Sun, 20 May 2018 13:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeETNUN (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 09:20:13 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:46791 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeETNUM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 09:20:12 -0400
Received: by mail-ua0-f194.google.com with SMTP id e8-v6so8249182uam.13
        for <git@vger.kernel.org>; Sun, 20 May 2018 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6t4SSY0clexBG5SyWJl6lJ5jby9DeIqgyCksFElsQUI=;
        b=EeeFpNsEl4qLMtBcc5Pm1ki5GAmZvTZOZCA1i6gfAjbjNRKLqYBCvrTmRBpNuBPsSs
         uvEX/JveAfGaJrW7p5D9lu5c5IbqkzEyGpUXHq46qdMYQHlOShQVdyETw0kKTLpOENre
         JI6QzcU8bTAyYw/zBms6m2ErY6gxu7okuRjjocECMBqaVQJ6aKlia1rz5iFCIA91iyTl
         42YMXUDqtAjjvUfauIF+PLg1PTgJH3NIbksRxG9P6pX6k+gjwBP6/X7MKWWSDzJZgH29
         8Vi1EyZIPd33IApMv+XkfsmSwA25S0QFH2vxqB7vPebfrnWhStQwPzv18wwC/57TrNSN
         PR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6t4SSY0clexBG5SyWJl6lJ5jby9DeIqgyCksFElsQUI=;
        b=j9G0UTUk215hZ6z+tQiMF9fYpbkuRQ9icmv3qhorvC9szdliEUc3m5sPn5MzLIVpdY
         DX2WvJD1Dhhkb8iLure/N3+K6Sg69nZqWD2Y1x2NYMxBA9S/gkjtumxbaantY7EQZ4j/
         ZxnNcbl+Fv87uPpZRWC/3JOyfGwf/q9lgF8sy1FMEWLe6JhH5opo09fhVC1DULvZf0Yy
         uxLFQqeto+bzZiLsDR6xF6AEbRRmcz5VZZToxpttLezuA+OcMlSR6kDU38kBxLPFIFwr
         Cr4vRaz1x0UsOz6gLaEi85ZVnBLrpOvE8aA1TxIht8lWlN9S4AkKtJFjn9fx0fpi+Mrn
         smSQ==
X-Gm-Message-State: ALKqPwep9u/j49ctKIjYu7DgwiFepVUqMYkh+r4vljiuID5E9MpPr6hU
        H+C17xokVsHj9QPWiQUUu4QwT5j57B5XWy7Lv98=
X-Google-Smtp-Source: AB8JxZrn1uiQc0FOR4NcPnL0fNtDu7myrHT6V+eiUpPlMmYN8Tbbug5j2woa5Qa28SvlP3R1n6G8VYjGIURGuObdx7c=
X-Received: by 2002:ab0:1c16:: with SMTP id a22-v6mr12311316uaj.27.1526822412130;
 Sun, 20 May 2018 06:20:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.22.212 with HTTP; Sun, 20 May 2018 06:20:11 -0700 (PDT)
In-Reply-To: <20180519042752.8666-13-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com> <20180519042752.8666-13-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sun, 20 May 2018 15:20:11 +0200
Message-ID: <CAM0VKjk4F-RfDjPLfC8_YzzJxPEM0O79uBx3kiCAMSCV4xVAMw@mail.gmail.com>
Subject: Re: [PATCH 12/14] completion: let git provide the completable command list
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 19, 2018 at 6:27 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Instead of maintaining a separate list of command classification,
> which often could go out of date, let's centralize the information
> back in git.
>
> While the function in git-completion.bash implies "list porcelain
> commands", that's not exactly what it does. It gets all commands (aka
> --list-cmds=3Dmain,others) then exclude certain non-porcelain ones. We
> could almost recreate this list two lists list-mainporcelain and
> others. The non-porcelain-but-included-anyway is added by the third
> category list-complete.
>
> list-complete does not recreate exactly the command list before this
> patch though. The following commands will disappear from the complete
> list because they are not in command-list.txt and it's not worth
> adding them back: lost-found, peek-remote and tar-tree.

These commands have been removed long ago, see the topic leading to
577aed296a (Merge branch 'jk/remove-deprecated', 2013-12-12).  Perhaps
you saw them only because they are still somewhere on your $PATH or
$GIT_EXEC_PATH?

> Note that the current completion script incorrectly classifies
> filter-branch as porcelain and t9902 tests this behavior. We keep it
> this way in t9902 because this test does not really care which
> particular command is porcelain or plubmbing, they're just names.

s/plubmbing/plumbing/
