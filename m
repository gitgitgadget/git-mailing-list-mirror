Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2904C1F453
	for <e@80x24.org>; Mon, 18 Feb 2019 21:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfBRVAk (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 16:00:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37609 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfBRVAj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 16:00:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id a48so20781852qtb.4
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 13:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDFrjBXuZg/dUUjjB+yUQj4TiR6zI7VGHRdDZlGQzBc=;
        b=TfcTciLlzDZhJ0m6/PLpUISrV6R1H+y+EcJa7lMs0Q+ETPuwFiwPSbK6pOdJUr2HRR
         uRgdbICNVfECX2Q/0YiRzcvISA4ZrpQjGDloBth0wfTBo2VwgsS4Iok45AxIges+e2EV
         YHcLx9Cjkkp21aduY5IXczN3BKPQaplPMTxekEaIU9bCgBKrEYNMPMKnvRSupwJ2/+ft
         k8C6Lk+mgwZKE/STYMl7dwm+ydaYT7ZDa1RjsWHAiNkTPCE+TU+BKZvQg+zrIy4W3zN/
         /AU0V4erVUIsQM57a3Au59bzhHmTj6VMAk7a791OoeHqL5csWoFcyiQxcaUyDx2M+7I7
         Hf2w==
X-Gm-Message-State: AHQUAuY9YVEo+9stc/zcMpc9M8LcM2Qs+8naxcY3kxPfWeviDzM9nO47
        W7lTRTx3fYfGkz4/t7+9wQ7pw4+NTSxds3DX/iY=
X-Google-Smtp-Source: AHgI3IafZbEh6txZvj30p2X9qSlWRXDLzHH6BaoUERmPaQnaGosTTIXmHpeDfO4KdMeufqcWgeDlq96PhU7oGoU28Eg=
X-Received: by 2002:ac8:2a81:: with SMTP id b1mr20174967qta.110.1550523638251;
 Mon, 18 Feb 2019 13:00:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550508544.git.msuchanek@suse.de> <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
In-Reply-To: <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 Feb 2019 16:00:27 -0500
Message-ID: <CAPig+cTA1hNXMiKb5Jwk3k+xfgCv-+B2HzdoJFLN9Fa5cN4NKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] setup: don't fail if commondir reference is deleted.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Git List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 18, 2019 at 12:05 PM Michal Suchanek <msuchanek@suse.de> wrote:
> When adding wotktrees git can die in get_common_dir_noenv while
> examining existing worktrees because the commondir file does not exist.
> Rather than testing if the file exists before reading it handle ENOENT.

This commit message leaves the reader wondering under what conditions
"commondir file" might not exist. For instance, the reader might
wonder "iIs it simply a condition of normal operation or does it arise
under odd circumstances?". Without this information, it is difficult
for someone reading the explanation to understand if or how this code
might validly be changed in the future. Your cover letter contained
explanation which likely ought to be duplicated here as an aid to
future readers.

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
