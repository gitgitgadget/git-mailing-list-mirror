Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6134D1F406
	for <e@80x24.org>; Mon, 14 May 2018 23:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeENXIb (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 19:08:31 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:42573 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752382AbeENXIa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 19:08:30 -0400
Received: by mail-yb0-f175.google.com with SMTP id 140-v6so4714759ybc.9
        for <git@vger.kernel.org>; Mon, 14 May 2018 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KrA+67lMZnHaYkXEHs0bQtSd75CFA7g0g4ZBSQPF6pQ=;
        b=hco39ESUU/qpKQ0Gxyhe6fI9k30NXRs92eFfKIrFMWfZHTOQdt5CDdZythEZuyEm1T
         oD83E1oG1y/4F8PSVhSa35Nn37MFJyLJ6mwoUIlqOAuo5JDGW3tv2uuMG6xIWcsrq0iw
         ccl4tVjvERiE1FPfEVeeYfQzvFeaWZYzQT5mFx9JNoCvaqeGAr4kBpMufxsKNWiTlKtj
         5IGjUS7IlcqgWjfEG/4BdoRtUkUjUJeWQjWUValnqhfmSnhw1rW5zX2UNwtZ6Spp6DZo
         Z6FwHN0zs87bu2PTtWGGCinGCTJUXnoa3od/ahYAUGI+SuAWJ8DPWDRofRfmibYOvpdC
         XN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KrA+67lMZnHaYkXEHs0bQtSd75CFA7g0g4ZBSQPF6pQ=;
        b=aPAVTMQ9DhfhsB1xEiWhqmZZ0pMtGmOAX3BY3yzUg4XRSRZIPlB37rk8DvP6l3nqd9
         /UZkP35RGDAlcA7erS53Xhmw8Qf7Lpd5kRQMfx89wqAPz18GFEfyC+R+6NfxwR0vz1eY
         G5LC3OuK6cPpBxkvbSKCMDpbBd1AoTAlhHVeeeVsyAAhljMsc12RfM67tPZ/76/wolpo
         2GnX9LIctZ+3ZMmTMnrI6L9RDZjVEwf7BlD4FEeEca92En8p98BxpM2pYLZYujuJP2X/
         dYvqSOs/km8G2HqAK6srfKwkj/V9F6J6xHu/Zx0zafI4DqFrQT+Y7Irv7S/vsaEEDBO7
         g1yA==
X-Gm-Message-State: ALKqPweIHF6ZnRD9euaOuFbmXjCGUIGnwkjEnLVHvK+0ByvF/IMuzLIJ
        dEjDwnFt4PLphSrv5eHyo0SmtvQWXh0m/WAE9XSJ7g==
X-Google-Smtp-Source: AB8JxZoCljP5ZqO6AcG4SJwhPLRzP4hHziNZkgDznL8tANn8CRKQ6dzOCrKeJJrN0vFo1xS8rBDmJPIywLkTQpWqeEg=
X-Received: by 2002:a25:5f12:: with SMTP id t18-v6mr607550ybb.167.1526339309629;
 Mon, 14 May 2018 16:08:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Mon, 14 May 2018 16:08:28
 -0700 (PDT)
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 May 2018 16:08:28 -0700
Message-ID: <CAGZ79kZMVLWfgWd53uV+8uaWu6_4iHVE6OJjUdtSA02mqUHCwA@mail.gmail.com>
Subject: Re: [PATCH 00/35] refactoring refspecs
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  22 files changed, 514 insertions(+), 571 deletions(-)
>  create mode 100644 refspec.c
>  create mode 100644 refspec.h

This looks promising. I'll hope to find time to review it.

Stefan
