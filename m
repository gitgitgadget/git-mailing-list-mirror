Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F184620A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 21:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeLMVOl (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 16:14:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39253 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbeLMVOk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 16:14:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so1620736pgl.6
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 13:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxNyTiIvivxj1m4+9NJdC29AiR6yyKG1TKgEVIfumXQ=;
        b=G4f5vQKmX1/1UvPUEJ3NpFEKamrlbEn7rDODOyl/6GaB+w+1amAxnWDlW8Ppcrkqp+
         9WN/A/wjsBrQ+zFVsMDpYDM0cbp3K1jz+2n3fFca4SHTeEsAihSnXou/armwJyDuvnTs
         W7t8KiZrjBdwYy+fYqj9e1EMhzzN+X3mXPEOCgUoiu8OF61W+LJKFuclqB2kqhGchWtn
         SlF8/IWO6DtFhK3ATTmVMTPAVnryrUoxZdte6Cuhmyt+OXIMsW8XiCoe9DfondkoDYuZ
         o0ppVtu+ZVDbhCRuTN1IM4TCURbfTI2nu0LMJwCt55pNTUltY+Q3k8qWiNg7C+MTW4AF
         rVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxNyTiIvivxj1m4+9NJdC29AiR6yyKG1TKgEVIfumXQ=;
        b=OKCFinW0RfwtLQnypRLH/y13Oqg7n3UF50zblxjrk6d51JbyqMOVEhisEQH88XY2MR
         fLxNXvhJZwV3EGnkh8V004BPJ5Mc0fNHR0VPmWHBsctg+VDf/O73rwdx/HDGaOJWo8Lr
         yXW/bi1l1GIuR1MDqUjaCBTqhbWhJvEJIAfH5BPGbA/lnfgqd4+m/1eYpqiGs8qZjBE/
         Y+97UOHSKlrocI7Q4HefgcSn9zI/dS9sGLhvTh1bwKu2Asi1fn3aDCjSLz4S8IxbI6JO
         euBDrbmdvHmfrwPbb2/ziyWPCkwDZTYj6zXdNh0UICKWGLOd64+9HiBJIAT7kLi9F62d
         9MzA==
X-Gm-Message-State: AA+aEWYcsW3NYebeZR3CsvDrQDZyOkXULxrrbW/MjcRrdp8RM/xfJ35i
        hKt0OqsDBt+pTghBNCNrP70rFKmfFF05ycGUfPc=
X-Google-Smtp-Source: AFSGD/XPeGYZ3zpSRNUU7oQilpcqc7lKJo81J8ZDIZt0tlfCv2z5mTDfoxbNiHsbi3Zas212RQlIijKK74synvJhgpg=
X-Received: by 2002:a63:89c2:: with SMTP id v185mr307807pgd.97.1544735679496;
 Thu, 13 Dec 2018 13:14:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
 <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
 <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com> <CAGZ79kYnQPhGMStmKSFb5_4Ku-nv54nHwta==jE82ZR4NOPETA@mail.gmail.com>
In-Reply-To: <CAGZ79kYnQPhGMStmKSFb5_4Ku-nv54nHwta==jE82ZR4NOPETA@mail.gmail.com>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Thu, 13 Dec 2018 16:14:28 -0500
Message-ID: <CANoM8SWQTAEYGiUC9PnWi8u9oAJYPcyiE5+5usoRvR7Vw2z0JA@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 3:48 PM Stefan Beller <sbeller@google.com> wrote:
>
> > > The current situation is definitely a problem.  If I am in a worktree,
> > > using "head" should be the same as "HEAD".
>
> By any chance, is your file system case insensitive?
> That is usually the source of confusion for these discussions.

This behavior is the same for MacOS (High Sierra) and Windows 7.  I
assume other derivatives of those act the same.

On CentOS "head" is an ambiguous ref.  If Windows and Mac resulted in
an ambiguous ref, that would also be OK, but as it is now, they return
the result of "HEAD" on the primary worktree.

>
> Maybe in worktree code we have a spillover between path
> resolution and ref namespace?
