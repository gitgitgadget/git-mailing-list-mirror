Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917FD2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 03:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbdKVDXK (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 22:23:10 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40621 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdKVDXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 22:23:09 -0500
Received: by mail-qt0-f195.google.com with SMTP id u42so22021330qte.7
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 19:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=D5xuThCeT/zfLYvrZzoMhwaG4Q5aA+hqo/lL4BIcgWE=;
        b=uov2yR6/BHOmpsZ5THuIfK7SxUC/fFu0fU6nFVNSLtLSrgbT58ARhTYxAJH1wFOQ4K
         +Uo51iMNGKKKNW9JdM226ESRsF7tXqZm1HDdIWqsxfF+YqCD81ApD3qF7IGPv16YH0hX
         CdUD2smMsDGvhos7Z+lvkyjZ3pFW1FpoA/A5DvIdV1qrVnT0TBSKuYDNhif2dOtDBUhy
         8lmoVdqEP7Dmwn3J8TAlrzqJN3zKUSOBCjaH4J/+MokEZnR2AD839pXTsOZfcD2XlHbw
         Uhf4VSU1IkJj4dGK3aW11eJQz1RiQc+IxLjBFTdKDNf8UP3yyJK4e3bPME8iaX0/egxS
         KR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=D5xuThCeT/zfLYvrZzoMhwaG4Q5aA+hqo/lL4BIcgWE=;
        b=D8tBsuap88j36bPDyvYkzcDAmtf6jtJnYy7ikyMYfokidwK/pq5wae5qx48hBDOJ1M
         wpA0Zdg8eVagG5AUo3uFPiERdkHpLmJ2S/f7XqPXYSKhUqsifFyP+lKtPht7wXa42nEZ
         7byRLOV45YY0QVOsJbrnxFFPm9v+4/E4NsOonQvqgm/oo9FnPt3B++SD49FpG6HmRh6F
         qpcCKT9DcCiqunNDKajYrP9hD7yV8LOiWtGQbVufaxoVyRi94wlBJEWK/7pxgqqvCfjy
         2mtjKAGVOASYw7+20EF0HaCIp32M7f6br2wjxJ616nkT3u7DA4NjpGuzl6lQYhJL0sl7
         8A5g==
X-Gm-Message-State: AJaThX4sLHW/iOdKqDLXqEQA76AmKie0sjKICthEYQQJErKMdRHFPASB
        fCYR90jLyE/B4rzdbzxQbxbFJ4mKUh8Hg6nmCHQ=
X-Google-Smtp-Source: AGs4zMYtdmgQYscYdRs4HhLJsjJcknX9l14DF7Acfe3BvDMfe/iSnSjvxxKq2aC99HNB5aEqdj322rJPf75NsyroTHk=
X-Received: by 10.200.5.2 with SMTP id u2mr30012589qtg.217.1511320989084; Tue,
 21 Nov 2017 19:23:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Tue, 21 Nov 2017 19:23:08 -0800 (PST)
In-Reply-To: <CAPig+cTux4dfBsX3DD=5TbM-p4-t66WX3+sufi39-W5Dw+ZvOw@mail.gmail.com>
References: <20171121150954.3227-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQrC1MiPrwwPqtdX2tzj1ntFHxO28uqnMBcmVpPPrc_Rg@mail.gmail.com>
 <xmqqa7zfxdru.fsf@gitster.mtv.corp.google.com> <CAPig+cTux4dfBsX3DD=5TbM-p4-t66WX3+sufi39-W5Dw+ZvOw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Nov 2017 22:23:08 -0500
X-Google-Sender-Auth: 1pcZlDsGM5KCyhPJBs50R_Qq4vM
Message-ID: <CAPig+cStgFaeWoNVcwaJVtNnYeLQ2LfS9xXF7uM3Py17HUaFFw@mail.gmail.com>
Subject: Re: [RFC PATCH] builtin/worktree: enhance worktree removal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 10:14 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> The erroring out in this case looks like simple oversight. Most
> likely, this particular case did not occur to Duy. The code does
> intentionally check the directory to see if it is dirty so that it can
> warn the user (in which case the user can re-run with --force or take
> other corrective action), but erroring out if the directory is merely

"...erroring out if the directory _is missing_ is merely..."

> an indirect (and unintended) result of trying to check for dirtiness.
>
> So, Kaatic's patch is intended to address that oversight (though I
> haven't examined the implementation closely; I was just trying to
> understand the reason for the patch).
