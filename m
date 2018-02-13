Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30BB51F576
	for <e@80x24.org>; Tue, 13 Feb 2018 07:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbeBMHef (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 02:34:35 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:44089 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933468AbeBMHee (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 02:34:34 -0500
Received: by mail-qt0-f179.google.com with SMTP id f18so2606806qth.11
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 23:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+xh6zmwQlpEBKmsNIipt0y1WgEgp7BUJZCkPSNuif1M=;
        b=BDRqve+j1QvprzYQOH1yXeT2NVpBjuZpbOGOnZaW2jfOwFWKEUd0hgB2ExV2GzJTyf
         afyFkI2wDACkkTcEjcG6GV4cm+pniB+WppDEzTPdmZUJGlwY5f10zm5evGduNIawdr4O
         0/8ro8BOQeMvkhifmSSf89LvfMs5W2qBfZV5lQbNX4dF0Or3zD37wXMz1Ckx3dvATxUu
         SZWvzb7/plkRuVE8sEF2VK2tOMOCiMBm4UxPhIBSdhN2kWrdDce8TUaYVPrgTIx3RaBk
         OOLPyCCNMkOD8eIPbyKtBteQOI/159MwuBaYtOwv8FQsOv2WnVKUhLPLOnXtDb8KSfPH
         4kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+xh6zmwQlpEBKmsNIipt0y1WgEgp7BUJZCkPSNuif1M=;
        b=tTd8vRAWPaBv1ypHPz3QAjnAFGLQkzqCFf7PP+JYVvFD1tt3RwWgHJiJ7HQHc/Mb1m
         tcx77HyJ2LM4fz0YJOOMMZrx5kspk/ePszdk+5jeAiST7es1eH5JgJ97vwD0qXWFBfln
         A5sDr0sMXUU4ogxeMlKPvkG2og9AcajnEZR1kKsmkNQWssREIOp7NbboTHCtEGfEXGFl
         djeEuAqD/09uwWnuIB6f5HNu3olPrfrrp+ck3Gt3QHATEM6drtlNr36zfFHeVyG2+/aS
         lJ/pXTfQViQN+br7QPdf0PE9GfQQJnx9g6dHHPVLpepaCxAwnTPl/yWOnJIB7yDeJiim
         fIMw==
X-Gm-Message-State: APf1xPCGv2MfdA+q0c9NI/B5AlQDIs3uznxzTqBWjLFMbnvs3FYxgdJo
        2AXY06nUucfON0qOaOdp+t/aF4TIVEHaSHuv7AY=
X-Google-Smtp-Source: AH8x227+RJxxjt3mveRK6Zcl3NKxtObM3NfiEBPIVny85xnmD7LORdZLfVSLUk10gf7+LH7EEdyfKs/du1Q/YLkQDsM=
X-Received: by 10.200.55.87 with SMTP id p23mr508765qtb.282.1518507273591;
 Mon, 12 Feb 2018 23:34:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Mon, 12 Feb 2018 23:34:33 -0800 (PST)
In-Reply-To: <b24e2f26-d5e4-d17d-04d1-1bd12eaf9faa@kdbg.org>
References: <20180210010132.33629-1-lars.schneider@autodesk.com>
 <20180212031526.40039-1-sunshine@sunshineco.com> <20180212031526.40039-3-sunshine@sunshineco.com>
 <b24e2f26-d5e4-d17d-04d1-1bd12eaf9faa@kdbg.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 13 Feb 2018 02:34:33 -0500
X-Google-Sender-Auth: Rs7OhUpYImPRObTErLbMnsd-XSo
Message-ID: <CAPig+cQH+a0UwN9Kqen0gmWbTwZZWTVtsPjDKqzw+U7t2Uk-LA@mail.gmail.com>
Subject: Re: [PATCH 2/2] worktree: add: change to new worktree directory
 before running hook
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 2:27 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 12.02.2018 um 04:15 schrieb Eric Sunshine:
>> +               echo $_z40 $(git rev-parse HEAD) 1 &&
>> +               echo $(pwd)/gumby
>
> $(pwd) is here and in the other tests correct. $PWD would be wrong on
> Windows. Thanks for being considerate.

Thanks for the confirmation. I'm always a bit leery of using "pwd" in
tests due to Windows concerns; doubly so since I don't have a Windows
installation on which to test it.
