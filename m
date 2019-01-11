Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9051F803
	for <e@80x24.org>; Fri, 11 Jan 2019 00:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfAKAHc (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 19:07:32 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:34635 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfAKAHc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 19:07:32 -0500
Received: by mail-io1-f47.google.com with SMTP id b16so10723290ior.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 16:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1DI/htM6W/ago4gH5ls0Uq3Mdx/4LgQZPb+e3vKp3Q=;
        b=hzs7sZsh1X9Opj0JeJnsXGv+P/ApHbT6cE4CEurMjIGeCZPm4sOqJ58xwUcpgWf6Pn
         UL2lS1/9qwzqahPfzNubl7NXvDBHfw8Xufy3I5n0oEzJTb98+e6UOTOUtricZmM801r6
         L1O2Mo44yXSz/1wwkxzSmR8L2vulW9hghGPKIRvPrGO8OAe9tt5ThNhTyNPcOKfxjCS8
         VIGmtPJTAXK/edokBIKMmVooXoYjj4ZD519Q42R5E+IggBawdJDEh8btQdRs2243XpAS
         ADsaHcrbr9oLP3zYjpMLC473SWHbvdywLumPyCfcmWxW+YYCOfl3n1P337CGxq26htCy
         e34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1DI/htM6W/ago4gH5ls0Uq3Mdx/4LgQZPb+e3vKp3Q=;
        b=t+jIEkC+k1a8ui3MYbFz97aThcFQK6venEPbpkcUIAdi6pCVTMTsVZTfsh0uiFEZpe
         t3TdTS017I0iMR86zJRfm2rNDW4Qp6/FK35m+2qr36DwxFf8PNHw/2ecU/ocBVVu8ACy
         zB8F6+YSRCX4ttzfL4bivehBbl6IzTTb/+1lo4fJCA0wYfLGO+kM19Xz0TWw2oAIgnuw
         GXmEupi7sRUcMyfl2L+YEsYZ95XHd5SzANT0ZVmZbbLJ6YW6zdFUbywpEGqFNYa7rLLY
         a+mwgHN/Ds7IHkFUKpwMC70qK//LOP/cBzZmgh8H04eb4OWPBqnAxB2WXrUdgNuL74Oz
         e5gg==
X-Gm-Message-State: AJcUukddaH9eeuQtnbjDBkbPjMaFdFnQR3TJwKgW0HK1xhcpNLNwIWOr
        QthdaNcoPn4QsmX08Nv17Ea3DqTGeYuDiex84vvvJw==
X-Google-Smtp-Source: ALg8bN6wqRaja76ZV476udjOHKU0dq5S7ZuknbXv7YjxlBHq8Hr7fu5rXHKxh2Xe17fLNDUBD5I821XqLzseeBYSACQ=
X-Received: by 2002:a02:8943:: with SMTP id u3mr8513532jaj.92.1547165251180;
 Thu, 10 Jan 2019 16:07:31 -0800 (PST)
MIME-Version: 1.0
References: <CAG0vfyQeA3Hm7AsYgYtP4v-Yg0=rKXW0YYfg_emAwEscZha4VA@mail.gmail.com>
 <CAGZ79kZBwocC=UzjW+DxodwJkQZ2mNMYNjsk6sL4SCqdhGoQ7w@mail.gmail.com>
 <CAG0vfyR3KnDDBrpyG-n-RFbu-xgCLFUa6HUXQ+dk8E4HutR+ow@mail.gmail.com> <CAGZ79kZ9ibM4eDyK=M6YWEDsjt+JfqJH-Gm56+092VATGuZDaw@mail.gmail.com>
In-Reply-To: <CAGZ79kZ9ibM4eDyK=M6YWEDsjt+JfqJH-Gm56+092VATGuZDaw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 11 Jan 2019 07:07:05 +0700
Message-ID: <CACsJy8DQTFCO=nKZ9T02RDMZGGwiO1wGK1YERYaXSriiszf74w@mail.gmail.com>
Subject: Re: Regression: submodule worktrees can clobber core.worktree config
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?Q?Tomasz_=C5=9Aniatowski?= <tsniatowski@vewd.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 11, 2019 at 3:07 AM Stefan Beller <sbeller@google.com> wrote:
>
> > I had a look at https://gitlab.com/pclouds/git/commits/submodules-in-worktrees,
> > and it doesn't seem to be quite all okay.
> >
> > The submodule update step of the repro (that breaks the config on 2.20) emits
> > an error message instead, and leaves the config unchanged:
> >    git -C b2 submodule update
> >    fatal: could not set 'core.worktree' to '../../../../../../b2/a'
> > It looks a bit like it's still trying to do the wrong thing, but errors out
> > during the attempt (repo_config_set_worktree_gently returns false).
>
> There is more than just that. After adding the worktrees,
> (and after the first status call)
>
>     $ cat b2/.git
> gitdir: /u/git/t/trash directory.t7419-submodule-worktrees/b/.git/worktrees/b2
>     $ cat b2/a/.git
> gitdir: /u/git/t/trash
> directory.t7419-submodule-worktrees/b/.git/modules/a/worktrees/a
>
> Are worktrees using absolute path for their gitlinks?

Yes. Moving to relative paths is on my todo list and I probably should
get to it after I'm mostly done (*) with submodule support

(*) Sharing submodule repos between worktrees is still something not addressed.
-- 
Duy
