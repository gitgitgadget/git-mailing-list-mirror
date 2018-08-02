Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713651F597
	for <e@80x24.org>; Thu,  2 Aug 2018 17:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbeHBTgf (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 15:36:35 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:36722 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387422AbeHBTgf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 15:36:35 -0400
Received: by mail-yb0-f182.google.com with SMTP id s1-v6so1525818ybk.3
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VH1RLma1NBkHOUtFtslEWCfZkYiqk8ZTmsQ70jbtnMI=;
        b=oI+1+ELv9eMYSoXZMKJ6yhIIjW81kf2zkWh9WQAeujSY9AyVxlS8Ub4LnadVQI4qRl
         OidWfxB0Q+Fojh4B1t9zgdIKt75/kLic8XLarUY9vOPyOwxtdrwfoUPuVBPrsvSBYPEG
         AQwNTcaozaNygdjtZ0KAaHM9x9IhyzM9yAqznZBNiobxdhPUr2WrU1qjT8RxiON0m153
         udnupC5AZyEdFhCbAN4OESFh2Wv8jsgDrVdU5o57f2XL+v8CmNOGrAkpX5mBT2xbdsmK
         2rGjaycao9nFR7eD3l5OKiC1JJGhgxKQDTryIP+OqYY2dpK6Sc0jp8ZkZDYrMvFgf5RU
         1sOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VH1RLma1NBkHOUtFtslEWCfZkYiqk8ZTmsQ70jbtnMI=;
        b=OnVNJU4dhAbD0TVpeI2Qqg2EUqt0Edcv/VPV2rWlTJNfZON9yXKg3bZm0MU4ximZTN
         dBO35xFKed4wABOhHXg2aFBHkixCI+qFctmG+8l2CkEaD9EWFcFUTDZlKqCHir33cu7Q
         6jpZK7ebHgBGrArACS631hcI+LUZA70aMH+oBTupse44xwsDSjMzYo8oTkKlk0yCdRGn
         Z+jKyfYyVCF3nH5gztSO6f41miyDd0IhjaHu6BB4TP7k5u3PhOC87NW9mSdp3WxW5YqB
         11l/zrQ1faaDtJHL7iO8VwuejBSxphi6z1Ztb2JiprS7916wXZfDHFH1CeEMJ5GQ82qz
         n2IA==
X-Gm-Message-State: AOUpUlF2NYhkrbb5NCpd4JtdoKZVMVC7XN9YWLbF+jBO6K2B1RDQaYAJ
        mZfFp2YYuTzUAsaCPUow4JE0+W3ltEB+1YS0JVBrbg==
X-Google-Smtp-Source: AAOMgpeJxIfOiWjN46Wyhr1+w5+cSnQJSqLoLA0PrFM/mK4pMeyXCVOnL494PuXs971aLDcGcTaTUglIJ7G52V2TaDU=
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr297969ybi.247.1533231865765;
 Thu, 02 Aug 2018 10:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180731173651.184716-1-hanwen@google.com> <20180731173651.184716-3-hanwen@google.com>
 <CAPig+cSbibJ7i8LwJqPe06xJObnq6dJdMUnJoC1uAg4zUQq3KA@mail.gmail.com>
 <xmqqeffi856n.fsf@gitster-ct.c.googlers.com> <CAFQ2z_PXfp60C-aiizUURjcqr-A+VJQDjMJ+fU_5DOo10x+rcQ@mail.gmail.com>
 <xmqqsh3y6jfp.fsf@gitster-ct.c.googlers.com> <CAPig+cR3WdYpZftK72MKMs4BBF2ZiuO-Bm_-edJ4tr1bRQvoGQ@mail.gmail.com>
 <CAFQ2z_NOxB4E13hoUPwoP+kZ0rVofCf3mb+bdopyTLnzWu1kPA@mail.gmail.com> <CAPig+cS5Nwnau36t_G-PBgY_8aoQQT6b_TfQPeyLt0tFXSppeQ@mail.gmail.com>
In-Reply-To: <CAPig+cS5Nwnau36t_G-PBgY_8aoQQT6b_TfQPeyLt0tFXSppeQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 10:44:14 -0700
Message-ID: <CAGZ79kYGS4DvoetyGX01ciNrxxLCqgXoVSpLhmgYZ8B51LzhSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Highlight keywords in remote sideband output.
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 10:37 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Aug 2, 2018 at 7:46 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
> > Sure. My doubt is that it's hard to tell what the state of my patch is
> > at any given time.
>
> Understandable. Junio sends out a periodic "What's cooking" email
> summarizing the state of patches sent to the list. The most recent one
> is here [1].

Please contrast that with [2], specifically:

  The discussion thread in the list archive is
  the authoritative record of the discussion; treat "What's cooking"
  as my personal note, nothing more.

[2] https://public-inbox.org/git/xmqqsh3x69ap.fsf@gitster-ct.c.googlers.com/
