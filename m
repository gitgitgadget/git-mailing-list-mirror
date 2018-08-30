Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6A21F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeHaAkt (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:40:49 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:41397 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHaAkt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:40:49 -0400
Received: by mail-qt0-f179.google.com with SMTP id t39-v6so12173355qtc.8
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 13:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6Z0b7Fp5HCgCXJo8V8MnzjrgjY9bHxjiUOndGIKaL8=;
        b=L37Ciq8ADLoBh/06Cdhn7gpTFcTq1MCndJsl459N5X9ugI9CvsczvXmXTgYjqLd+RE
         ogBXD7SOiCiKE+ik/CQGPOulfHV1PNLGPIupzKuiKkVJgcWRRo2W1OGg0C1Uz0KVDyQr
         FE7azj+ZXsx4IveU28W/K012hw+immDK8fPqSf9PYlM7JHE0N5BQdSw6sQ9a3aUWbZmt
         vVsongsG3K8MhWtR+47cwLF3e07Vg9gCerOjg4lX38fB3IHWg5e52Z5LaL+WZywyXB12
         +0k4guxalbnnitmzj5otPp1pPgagzjygBzro+KgUV/euvuSjy3k682fILl5qA6lyVINJ
         dpvA==
X-Gm-Message-State: APzg51BPGg0MYtw5vUQuE6EG/uqxMeY+hIWFQOV1YxyPuA5M37Nt19uS
        PUP5R39qeNSR5JhUcpQoPUd22Klhzkw7SHf049g=
X-Google-Smtp-Source: ANB0VdYSixV2oL22oXOUFpYGE/Xep2NNOu+Ignh4LERZbrUeFdg73uPGEkvioTp28mtrsoGuu5asTd+NxlZWDU999Qk=
X-Received: by 2002:a0c:c503:: with SMTP id x3-v6mr12833211qvi.82.1535661411287;
 Thu, 30 Aug 2018 13:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180830081202.GA10224@sigill.intra.peff.net> <20180830195546.GA22407@sigill.intra.peff.net>
 <CAPig+cRXEegGwm3QiyEZqkVN1NYv5xAAYRuAKHUE8n-g9m6jqw@mail.gmail.com>
In-Reply-To: <CAPig+cRXEegGwm3QiyEZqkVN1NYv5xAAYRuAKHUE8n-g9m6jqw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Aug 2018 16:36:40 -0400
Message-ID: <CAPig+cSq=AikZU9X8hC9QM29vUA4bNKXLvf60dweJWyvFWY0EA@mail.gmail.com>
Subject: Re: [PATCH] doc/Makefile: remove tmp-doc-diff on "make clean"
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 4:34 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Taking into consideration that people might be surprised and alarmed
> to find "git worktree list" showing a worktree they didn't explicitly
> create, would it make sense to do something like this?
>
> clean:
>     ...
>     -git worktree remove -f tmp-doc-diff 2>/dev/null
>     $(RM) -r tmp-doc-diff

More accurately:

    -git worktree remove -f Documentation/tmp-doc-diff/worktree 2>/dev/null
    $(RM) -r tmp-doc-diff
