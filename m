Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891801F51C
	for <e@80x24.org>; Mon, 21 May 2018 16:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeEUQIy (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 12:08:54 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:44205 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeEUQIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 12:08:53 -0400
Received: by mail-vk0-f46.google.com with SMTP id x66-v6so9066173vka.11
        for <git@vger.kernel.org>; Mon, 21 May 2018 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t/KrsqbZNz9pU3a4mYK38c9Ca7c+VOVPaEch2E4gzwY=;
        b=K3r+aDd5XQB2Wb/vWIMqcjsdzRfk7ip2f6VQ0r/pFgymoyV1PkllLrpOo5qWHIX229
         SQtnFzLU4e5dSzQanFOXrLbvMw6kBbxwWIF7eEfbLk9L5VsugPYSidAY4P+gJa+XcXsm
         rJJKz3PU51p8a37qu4/SL2aGaMFU98+FyhCOvR6Cpl2PnVQH4bL/4zFhUxL4zTBJHxB+
         Q4RSP893f6/cevlDW9/8N/gdQU+hUiPC3kUb7BNL/MTongZa/+1RoiW/ljLCNs8V+5Sn
         duk8IFhPnnOluzcpaBvBkglPuOSu3lpxher2mlMCwaq5T14pTdnZsoq/M39KPec/VJH2
         sPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=t/KrsqbZNz9pU3a4mYK38c9Ca7c+VOVPaEch2E4gzwY=;
        b=Bp0QjDx3JKPmrMl3leV2gRNDi/ixKNuqutNshKDUBYPOk2JBSc/ZTQGeKIKrkiivuz
         7vQVyxXI1eFPLvjDrqAljRjy/0AZJB1fESyTwMoA1LSIEEj5uxM7TUgiJu+VTaFNI7fF
         Psxk7ho6wVrNK1PnM40YmCBRJS1C4izhMT8JYRp3Ev9H9qjLkXriQHsh9SJEmGw44Ctd
         oAmaSRXDiNikDqhxgmnSEb7lrnvz8DwkgxvO4bcE7FwfQ+Qq1A8HnZ6sIbvGiPBdRfF/
         yy85CflSrWEhkF+g3WyCVdhLq1R80Yk0s15W7tVF+WUHM02HmbH1wqkCbx46sV0phJMx
         RxgQ==
X-Gm-Message-State: ALKqPwcjVeLIAFYXutDoD0UqzNzOelXqxSeC2FwU7KGhCQw6VTq2BIVe
        ziD+EWcyRT5qcpWl8UwgGpFyWKuwvIxJ9O7KYLs=
X-Google-Smtp-Source: AB8JxZonDm/VKCKQxeEl5RnVmwpFoevKckXvDaAM6rVBk6Vxey7HXQpYtvsvyfA6/Nf4wC2H2bwz/n8pQ7l+HwomuLI=
X-Received: by 2002:a1f:dcf:: with SMTP id 198-v6mr13690648vkn.103.1526918931833;
 Mon, 21 May 2018 09:08:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.77.145 with HTTP; Mon, 21 May 2018 09:08:31 -0700 (PDT)
In-Reply-To: <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain> <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Tue, 22 May 2018 01:08:31 +0900
X-Google-Sender-Auth: v3jxSuCbM85fGopIytpHS32ebPk
Message-ID: <CAPc5daUu3uG0P7OsEenVcwT=BQQKEc0uJZqxmRjqFPLxzEspAw@mail.gmail.com>
Subject: Re: which files are "known to git"?
To:     Elijah Newren <newren@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 22, 2018 at 12:09 AM, Elijah Newren <newren@gmail.com> wrote:
>
> I had always assumed prior to your email that 'known to Git' meant
> 'tracked' or 'recorded in the index'.

That's been my intention as well ;-)

> From Documentation/git-clean.txt:
>
>     Normally, only files unknown to Git are removed, but if the `-x`
>     option is specified, ignored files are also removed.

The above makes it sound as if "unknown to Git" is synonym
to "not marked as ignored via the exclude mechanism", which would
incorrectly imply "known to Git" is "marked as ignored via the exclude
mechanism".

Which is a sheer nonsense.

I think this is written while forgetting that "known to Git" was already a term
with a specific meaning, and used a confusing term unnecessarily loosely.

 "clean" removes files that are not in the index and are not marked as
ignored by default, but with "clean -x", the user can remove all files that
are not in the index, even the ones that are marked as ignored.

In the above version of description, "files that are not in the index" can
be replaced with "untracked files" and we can also say "files unknown to
Git" (if we want to), but the set of files "clean" operates by default is
narrower than "unknown to Git"--it is "unknown to Git and not marked as
ignored".
