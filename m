Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5891F404
	for <e@80x24.org>; Tue, 10 Apr 2018 20:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeDJUo4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 16:44:56 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:44384 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDJUow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 16:44:52 -0400
Received: by mail-pl0-f49.google.com with SMTP id b6-v6so8264715pla.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=djTzQcM9CWBrCHkEYta0jV1Y+qqKkBzQTsM60m5EHX4=;
        b=MgkNvAfbk4qemVb7ybr5K+Gvt2zACU4w896/Gaf31vEqZjy2LK0WeEC3hf8BoG+y4O
         i2IVNXHB8psItX87UfjwfI3e7Odluooo74/BYuegjHJOzxylg7WU+5LyWg/UURvRt+fl
         lCOKJfSkYhBnNt1tWqoanYTOxBHLrjnEKPQJY6F8G2C9ff0h3edzs4dqeMFGBgjAJylv
         XxSSbzdAo0Rq1yRx4b5j03WCrbtJj0rU+AE3fi+rtdYqH9jus6/ls1mEjx9gnkMBtAUY
         VPa6koX5emjajc4Qz81gNvx11bLI+Z+zDRzOrCapZtqIjeLUMNMlaxjEMlzFt01bxUly
         qegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=djTzQcM9CWBrCHkEYta0jV1Y+qqKkBzQTsM60m5EHX4=;
        b=uYRREzTpGtf7CTR5YTvQbGTj5XynNHk2/ALR8DpoRsjZL6t0hHeNtDB7Mzv0vIx7Ab
         4jopfnxZDxZBqe0I5eF3+shfV6NwtaGKoMYQjYl788e6cbNGzgFc6Wn1eVTVzA2faOm3
         1nDhGkHE4F98m9BoKUvmAcTUCnP62mpwI0cAB4yQYVhjZne+0JnZ+GlpyKJhgtUl/A7U
         bflAI0LxTW//ZupPEnFP7ROxymGPXMPoc+cbLMWcEHiDmrQ44B1sAaf51Oi1uJqUlpfJ
         6cc/zTDOJ3NwIMxjhOhT28dYRLtjBq/hgRk7jxh+RAHPtTiz0BD5a/VN+bSEJDA2TdjM
         j1Cg==
X-Gm-Message-State: ALQs6tDO0rLwogujRY4ZuAfXBByUJ9bmZ82GwG0l9m75NLT/hzi6Yjg8
        1TVTQZLs4OG07b3cAIISGeH2ECagXZdKCBvHCgk2pXCP
X-Google-Smtp-Source: AIpwx4/+P9ePUQeWd9Ghopr9FuWSoqR0B5oNfI1D6DlKrseeb3Jz6CXiyObRtitO1bmnXGvMgUjshAwFnxgTKJpjwtw=
X-Received: by 2002:a17:902:9893:: with SMTP id s19-v6mr1929661plp.304.1523393092086;
 Tue, 10 Apr 2018 13:44:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.178.66 with HTTP; Tue, 10 Apr 2018 13:44:51 -0700 (PDT)
In-Reply-To: <f45ef7cb-dc0c-8c63-1d2f-6ece0d0091cc@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com> <20180410183224.10780-2-asheiduk@gmail.com>
 <CAN0heSquxLpMfrLQs2em1amLv77-Uywr+885Viuq4-7DiWYmAQ@mail.gmail.com> <f45ef7cb-dc0c-8c63-1d2f-6ece0d0091cc@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Apr 2018 22:44:51 +0200
Message-ID: <CAN0heSojXxQZz50rwCJefkMpF4bPfpzt+=r9qcVoczU1+qN0Dg@mail.gmail.com>
Subject: Re: [PATCH 1/6] doc: fix formatting inconsistency in githooks.txt
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 April 2018 at 22:04, Andreas Heiduk <asheiduk@gmail.com> wrote:
> Am 10.04.2018 um 21:13 schrieb Martin =C3=85gren:
>> On 10 April 2018 at 20:32, Andreas Heiduk <asheiduk@gmail.com> wrote:
>> Hmm, I wonder if that is actually intentional. `git commit --amend`
>> could be run exactly like that and would do what this paragraph expects
>> of it. The 'git-rebase' is a Git subcommand name, i.e., not some
>> copy-paste command-line ready for use. If it were something like `git
>> rebase -i HEAD~5`, I would expect the backticks.
>
> That page mostly uses single quotes and no dash ('git send-email')for
> formatting. Reading 'CodingGuidelines' my understanding is, that git
> commands should be typeset with backticks, no dash (`git send-email`).
> So 'git-rebase' (an similar) *should* be typeset as `git rebase`. But
> doing so consistently would be a full-diff for this manual page.
>
> Should I do this?

Your reading seems correct, so I was wrong in my speculation. My guess
is such a patch would be welcome. I checked a couple of man-pages and
this one seems particularly heavy on 'git foo' as opposed to `git foo`.
I think that's a reason to fix it, not to leave it behind.

Martin
