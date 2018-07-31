Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CAF01F597
	for <e@80x24.org>; Tue, 31 Jul 2018 16:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeGaRwD (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:52:03 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:33475 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeGaRwD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:52:03 -0400
Received: by mail-ua0-f195.google.com with SMTP id i4-v6so10646348uak.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 09:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YEJXYG1zQNuCWbacgxYDBtJCN28xyXYy76jBjEwwEzU=;
        b=Nir3xe6q1g1wGrUG/xUnCgXVvN8ztUXvnku4rJ5vaUCF7aN+DSxiUNODD0y45skLOF
         x5fjS7jBNCtzszE9nHO++Kuq76+VsAK8J5u5Hbw5JW4oQmxhYdXE6XWogcQI8PO1wtAa
         YPY5NpxhaR3srmZh35q9EBl0kL1iQoghqyKCr0Ovvb+m5DNPNiFAWpBMR/9b4fAgsKz2
         UK5cyMJ0ef5RNrooUwV7KoJD3dykp7SawnzIKz/2DwomD8Ao3Mk86WYs2I3oa0lDSiGP
         fSlvnELp1BGAuPKJ73wpge03zNY5mKNfNzmfjSzDRB42qQVRgHoVdgz04b3SOnQS3FEv
         ZSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YEJXYG1zQNuCWbacgxYDBtJCN28xyXYy76jBjEwwEzU=;
        b=tgr5NZRgtNj6siOMI+p4cH9WzbQGUiRQkof5F3N56nSDi1rI5n/FXYfVc3ojI2jj4/
         FvMfHo5/APU911M7A+BWUZr8BfeAd4IxUze242PNs1gav/dMrUqWDibqiBZzXJKCwRXI
         a7WpxBJlihiw0iyvb7eOBEKJwIBJyoYPrkoNuLmRiVIQaN9SwH9AjlA4mSZkg8rAQ22t
         6kogmWHKyfjLDgreUIdc8EqPiRKjL2ibyRTia1vntghb74S98clMUlPJWtKYrHjar0So
         hhO4b95nmvYbI8fF5YQrRGsVCwxrl6EfJzmzGVch5/Sy0tr8WzOWNnFSjNmWyt4VSUq+
         Nk9w==
X-Gm-Message-State: AOUpUlGJGmNUV/ba7bNMpgsnq1CcFd/QopLY5nZOpPZlx15x3osdfTzd
        UnBi7jA7eU/S8s1SlY5GGDAqq94UfllbI2RbOK4=
X-Google-Smtp-Source: AAOMgpdegV4T0m2gBXL+GEByFB7WXODIN8tzpc3u3O1caGr+QaEM0LZ1/LcS/HCNkHyOvySWTiD2YlMIxKBDLw7BBkw=
X-Received: by 2002:ab0:4eef:: with SMTP id x47-v6mr15733801uah.23.1533053461805;
 Tue, 31 Jul 2018 09:11:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 09:11:01
 -0700 (PDT)
In-Reply-To: <20180727125923.11744-1-benpeart@microsoft.com>
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com> <20180727125923.11744-1-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Jul 2018 09:11:01 -0700
Message-ID: <CABPp-BEKboEvz7Yoq+OJnCJJ3JH=XZB=NepVHowCZMa9DogDiA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Preserve skip_worktree bit in merges when necessary
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "peartben@gmail.com" <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 5:59 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> Sending this update as Elijah is on vacation.  This only updates the test
> case based on feedback from the list.

Thanks!  One less thing for me to catch up on.  :-)
