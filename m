Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84BE81F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 18:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJKBcJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 21:32:09 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:36473 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKBcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 21:32:09 -0400
Received: by mail-ed1-f42.google.com with SMTP id c26-v6so5814054edt.3
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3G8AZeMf0tc9FYHGZjZRXbPzVratuSStgoC8/8SGiU=;
        b=VOnh5nc3OihSPuK8H4DLGNtxxlgm6pgy+Row333JlIP85yE5axOG4IP4cQ4yMevuEY
         yvd22vel3WxknHE9YEU1zBwHTvnqinVZsygD2yhms0KqC2+wibICOfvGxVCmR4ZgT7Od
         ad4T8HaE8h9wRoqN358/WzIVZSx+npLCDrI2Hc9EQrDNF0OPD0QPjsXXTWzKupnqGSfp
         hAOGUkPB4o0BZABygLBg3mQ/rE5geR7q3QSMigJgN9M2MCnwowRP6DmL1/Rq0mb7jWQD
         NvR9M2L44cZiA5gbp99QTBKFq6F8zCYfD1ahx2h8s3p0vE+el2ADLtlFJvCZLZK3Mbri
         qkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3G8AZeMf0tc9FYHGZjZRXbPzVratuSStgoC8/8SGiU=;
        b=NBYt/qrVKKCQWfdLgCU7Px1oBGbYTQxELOyPFuJImd0akk0b2o2EVXBYzuMvDy55m6
         VhiZ68+QfDj69Zjn3xzWnAAEQ322YeBQd2I5QG7ARgt+74lYdhmUyoP1dMERpc0vcu2j
         BrDWV0k1FfsOpFP81M6ePtpqFuEac6SpUf4FWy1rWAu/eDK+gt77dXuee4H51oQ4BwCn
         Xjc9RGJgfdytQdhObNvgc3ysc5hlICH5YVfr3+tGz1c/kb31v86EEN4CqRNMt+isGxFG
         maJ7JTMRMkHmXPHdMXHytbxmAEqdc8DrocFOMOmeDmIDc5ZGXwm6SrsoeqiCuTIQM9cG
         Yvug==
X-Gm-Message-State: ABuFfoiZaiyM02IPxVFYxTc6m9z1rJDhyl92ev7rlSWwH67eR7Lr4AIG
        FHKKpfl8cDvWmYSDR0eFG8e4freYtO3TOm6TED/IEg==
X-Google-Smtp-Source: ACcGV61BeJ1m4rg1KLRa88qiXygd22xcvKrePh0HR92dQI+QkzkkPx/MYtqw7usrAf8J+GBMCUzSW4APd6RSjX5x0Ew=
X-Received: by 2002:a50:aca2:: with SMTP id x31-v6mr42401441edc.76.1539194931539;
 Wed, 10 Oct 2018 11:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181009182006.9446-1-daniels@umanovskis.se> <87woqpetd3.fsf@evledraar.gmail.com>
 <d6e8a7a4-2de1-7ffe-2848-d372cb550a2d@umanovskis.se>
In-Reply-To: <d6e8a7a4-2de1-7ffe-2848-d372cb550a2d@umanovskis.se>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 10 Oct 2018 11:08:40 -0700
Message-ID: <CAGZ79kamNFs8hugoEv9M_fk97Bm2jkUywbrCoD4CwsZ=UsFPmg@mail.gmail.com>
Subject: Re: [PATCH 0/2] branch: introduce --current display option
To:     daniels@umanovskis.se
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'd be happy to submit a documentation patch for discussion that
> formally moves rev-parse to plumbing.

I'd be happy to see such a patch.
