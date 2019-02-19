Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D5B1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 07:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbfBSHWe convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 19 Feb 2019 02:22:34 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:35755 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfBSHWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 02:22:34 -0500
Received: by mail-qk1-f169.google.com with SMTP id w204so11494700qka.2
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 23:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SK2vCc+6o1SMAhr7aM1cY3Y1hEJO5YNEbR3MMT9Nffw=;
        b=lm4/1IuJxJOEuET/oaAJdHzLd1CX5z4lDC7SnEmpXIwWc6MWTTbOuukhdEClm/C1BI
         gBLfhX4EvcFC8LWJYjnh3492CsnykmbtQtSFEsG457z6btbigtR/dxDCWj0SkYS3bRxu
         5pyAnnQ7VgpZxq0yYnofoR8Cj3hV0WgMhfJJ19tjHyFrKi5HkjM/oFZzTRpYpYXIkDWv
         5IYlpmpOvk45OP2uFZkjqNS0XrgkyO1FHCO6ALtha3lajGLN1hJa6C+4CDMPJz+iM8yQ
         KeyOYvwsxlIgDtl/JHo3sb9kk/jbh29lT5EeALtqmVfckLfhXWBniIiwTDSHbWzn4yv3
         phQA==
X-Gm-Message-State: AHQUAuaYQPjhUalVSSx2NId37vCpY4JgfY/6cG9rYvjTe3Rlz/HbT3jf
        6T4Ffo7P2ZNYKPMU7c9xwvoW2EZTk2gM3UNWL84=
X-Google-Smtp-Source: AHgI3IYV5TacgrGaScMc2y9JJy6QheFxv9+0EF/di2VKG6AAsgRgI3Ibb5UDgMqaS/mQdaQgXO36qWli0+rtfRbvPKQ=
X-Received: by 2002:a37:404f:: with SMTP id n76mr19961017qka.26.1550560953377;
 Mon, 18 Feb 2019 23:22:33 -0800 (PST)
MIME-Version: 1.0
References: <CAJPSwc1GuifK9BdssWQsf+oVY0Aw+PLM1pgAiis7UdV1tZrpew@mail.gmail.com>
 <CAP8UFD22QMJyiJmQO1YVFmBkZuzex58+QBbTbdCCVHa8OGCQJA@mail.gmail.com>
In-Reply-To: <CAP8UFD22QMJyiJmQO1YVFmBkZuzex58+QBbTbdCCVHa8OGCQJA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Feb 2019 02:22:22 -0500
Message-ID: <CAPig+cQHx_BuxwZS7+juBdgKyAWhStU=9kFhs2hf=wjOMGAd7Q@mail.gmail.com>
Subject: Re: git rebase --continue after solving conflicts doesn't work anymore
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?UTF-8?Q?Sebasti=C3=A1n_Mancilla?= <smancill.m@gmail.com>,
        git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[cc:+phillip.wood@talktalk.net]

On Tue, Feb 19, 2019 at 1:45 AM Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Feb 19, 2019 at 5:20 AM Sebastián Mancilla <smancill.m@gmail.com> wrote:
> > But since Git 2.20.x it doesn't work anymore. Now after solving the conflicts
> > and running "git rebase --continue" I get this error most of the time:
> >
> >     error: unable to dequote value of 'GIT_AUTHOR_DATE'
>
> It looks like this can happen only when an "author-script" file (most
> likely .git/rebase-merge/author-script) is read by the sequencer
> mechanism. Could you show us the content of this file on your machine?

A very good suggestion considering that there have been changes
recently specifically related to the parsing of GIT_AUTHOR_DATE in C
code.
