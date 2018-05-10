Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA171F424
	for <e@80x24.org>; Thu, 10 May 2018 06:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753633AbeEJGTQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 02:19:16 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:36378 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeEJGTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 02:19:15 -0400
Received: by mail-ot0-f176.google.com with SMTP id m11-v6so1095874otf.3
        for <git@vger.kernel.org>; Wed, 09 May 2018 23:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C3YHr669mq7KcJYYteXxFtYwVVTW8ReLpNxJikiu7S4=;
        b=ESWBoS/ZQrAa1VKhQql0mbLsWmIgTPllfdtyleydsm1+tuWGoAqE4gQMN0YBxpGk6P
         ayd6XkXTePHNHh37YSsqZ4icdQdBSv6bMi0AVBLwVMZhJswWDp4Xx5cDV8cQcxkj+8oc
         XZyyUHSMkqW4QZtBbuOgvThlg1rXOa3BsXMfGkoctiOOU5HoSrnaNNhTQJXJ4VI5aozs
         euZ4hnti9sRPg9Gm2KWfVOYUr79ueOZLk64GxPASybZJGZh+8m3DKLgL/bBcSYVxp8Nj
         7wlDu5YJ9Bk7O+d23EzrcEu6458KdvXiCj+oBxUXm/oxYlgxphT+z6ZEgNO76ikieOWU
         n/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C3YHr669mq7KcJYYteXxFtYwVVTW8ReLpNxJikiu7S4=;
        b=EHfoOzZJTImFZigRXTGVwQyaE3ULkFEwvtRN9U41F3JtZcQWSzyrRl4vI0UTRxOzOm
         03t4v18qI1E3g/AWsq8mnxzxNoFEL53J6zLZbntJd8n/uXmFGffBd2ufEvcnlkGzKc0O
         44hunrmfziYkdH/EWL5k3n0jJ789ChX7+xq2ciIB3w+h+iST7pKEzgrjJjVqEVn/rCpe
         bjasq3X4UBVNE9sbrOER0DR7kL0zsvycIrUGnpJ4bVYQiL7F0qs1oks7uyONAQV9ock7
         Gr+V5uCc6f5mDl17vOUdzruY0/swmpDVdGGa3p3ejpyeVocIi2Jp5zeqrKG4lBboFXV2
         /Tfg==
X-Gm-Message-State: ALKqPwfHBFSohMMC8nOG5voMSpVV351qtRxM0HTNHsAWZxXs+Ls4yY9u
        jQFkWbm2NMZb9mMg50vpYuqBIK/V2PdQ6uzSGBI=
X-Google-Smtp-Source: AB8JxZpDDGjLQceVfab5WS2GFgYab4hLN01+YMS8Tc6/2+dfrSWb1PyJZZP5ILqN0M6SlvSfmD8OrLrrHhO/S8utAwI=
X-Received: by 2002:a9d:e8f:: with SMTP id 15-v6mr106035otj.14.1525933154562;
 Wed, 09 May 2018 23:19:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 9 May 2018 23:18:44 -0700 (PDT)
In-Reply-To: <CACsJy8AdJcQpiGrR3p6xfuqU0=qoP3=StgbWRNCkdfka6di+5w@mail.gmail.com>
References: <20180509170409.13666-1-pclouds@gmail.com> <CAGZ79kbFiULj1NJARm6ObYrqv_Fu+U2sb8h_sNJwdWur+JqrvQ@mail.gmail.com>
 <CACsJy8AdJcQpiGrR3p6xfuqU0=qoP3=StgbWRNCkdfka6di+5w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 10 May 2018 08:18:44 +0200
Message-ID: <CACsJy8CosHdk3DA46aNM3v5d4wnmLumv+6MdJMY=WfVtKqZ8LA@mail.gmail.com>
Subject: Re: [PATCH] repository: fix free problem with repo_clear(the_repository)
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 8:00 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> discard_index(repo->index);
> if (repo->index != &the_index)
>         FREE_AND_NULL(repo->index);
>
>> What is your use case of repo_clear(the_repository)?
>
> No actual use case right now. See [1] for the code that triggered
> this. I do want to free some memory in pack-objects and repo_clear()
> _might_ be the one. I'm not sure yet.

Another use case for repo_clear(the_repository) is "git worktree
move". Part of the reason I did not support moving the main repository
with that command is because I wanted to shut down every access  to
$MAIN_WORK_TREE/.git before moving $MAIN_WORK_TREE. It's probably not
a problem for linux/mac platforms to move files (on the same file
system [1]) with file descriptors still open, but I'm pretty sure it
won't work on Windows. If repo_clear() does its job well, I should be
able to safely move $GIT_WORK_TREE after that.

[1] if we move across file systems then another set of problems arise:
if file descriptors remain open, writing to those will not affect the
new copies in the target. We do not support moving across filesystems
yet, but we should not shut that door now.
-- 
Duy
