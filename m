Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9E720188
	for <e@80x24.org>; Mon,  8 May 2017 05:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbdEHFoJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 01:44:09 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33951 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752023AbdEHFoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 01:44:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so2695504pfk.1
        for <git@vger.kernel.org>; Sun, 07 May 2017 22:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w4dBIrVNfxSbZp42cY7/NwOEBrMoJRUxrG16lr0nFTg=;
        b=VQiMB3aJxlujyKEp3HLTTvRpkBHDBTuGGuGHv31E9v3Vv0IuZGp7xrsqTcYAstJZ4S
         0oU86icrLIs/hZc57w7+qJ8ZG3rvCum03B4oBolCPPgn10+nX3kdtRxSkkMrbJSSYKZ2
         eiu935d+xUtagMi0GzhIjdGem+kRyapxQwt7juOdSQ6RYjq1ndC6gC6IIUQLuTieT/bY
         cLDdNF7FhLTnyvN4SZWeJieaysu9ec32P94z8FgkiODMGQAwX24VuiT9Q6RWesCw6HvI
         moFqzfsmTYVd08WxrgKR8xhzMMzqYIL5QvKoemuOfpIEr4051iSFFNjyeW4dOgLc5E/3
         2yCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w4dBIrVNfxSbZp42cY7/NwOEBrMoJRUxrG16lr0nFTg=;
        b=gIjQjsXnyOfZUENCgCbxo0uL20+fqyXh2SrAPop5ipKSyXg2KEtBdQnGybvUEfOCAc
         AJyDLG7/4YetKqQko5hvKDfdN1rdu+wGH1b4YZKRxjXjhqgMhhWv8tHvgS2JAXL0hDwn
         CMBJS6ojwCy46NPSszm9Kf9pfsUWWfL0o4wusiQ79AHZQnWU116zm042PgdQsxcJeuYW
         DnSkiko7KhZQQnRNd35r+QS9GjgoKRB8t5SQ7jZnJbeuXkY5B6nyzZlPjNsf0x3b89gM
         ROM0E0led4Tl93NaOss66DiAOJCENOdg4rSpPUHhzr1ooStqXlk7ElNSSSBwfXtz46sS
         Fn6A==
X-Gm-Message-State: AN3rC/4EHRsI2gcFIyVoz3oiA8w3YAscqGw57l41yVMrA5c1llVj7FKc
        q71+NRDAoVTUjwNjUsQ=
X-Received: by 10.98.52.4 with SMTP id b4mr30906349pfa.124.1494222247736;
        Sun, 07 May 2017 22:44:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id q68sm14779084pga.57.2017.05.07.22.44.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 22:44:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 0/3] Clarify interaction between signed pushes and push options
References: <cover.1494027001.git.jonathantanmy@google.com>
Date:   Mon, 08 May 2017 14:44:06 +0900
In-Reply-To: <cover.1494027001.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 5 May 2017 16:46:41 -0700")
Message-ID: <xmqqa86n9a3d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> We noticed this when trying to use Git to make a signed push with push
> options to a server using JGit (which rejects such pushes because the
> Git client makes requests that are, strictly speaking, incompatible with
> the documented protocol).
>
> There have been several commits (see the commits linked in the commit
> messages of the patches sent in reply to this e-mail) to support push
> options (that are read by receive hooks) when using "git push", but the
> interaction between push options and signed pushes are not very clear.
> Here are some patches (containing both code and documentation) that
> clarify this interaction.
>
> I would appreciate a review of this - if we could make the protocol
> clear, we could then update JGit to use the updated protocol and be no
> longer incompatible with existing Git clients.

I've seen the exchanges on list on these three patches, and I agree
with what Jonathan said.

These are going in the right direction in general but a few nits
need to be picked before becoming ready for 'next'.

Thanks.

>
> Jonathan Tan (3):
>   docs: correct receive.advertisePushOptions default
>   receive-pack: verify push options in cert
>   protocol docs: explain receive-pack push options
>
>  Documentation/config.txt                  |  5 ++--
>  Documentation/git-receive-pack.txt        | 10 +++++++
>  Documentation/technical/pack-protocol.txt | 32 ++++++++++++++++----
>  builtin/receive-pack.c                    | 49 ++++++++++++++++++++++++++++---
>  t/t5534-push-signed.sh                    | 15 ++++++++++
>  5 files changed, 98 insertions(+), 13 deletions(-)
