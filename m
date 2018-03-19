Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6995D1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966250AbeCSRaz (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:30:55 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:45325 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965949AbeCSRaw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:30:52 -0400
Received: by mail-oi0-f43.google.com with SMTP id 71so3586573oie.12
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hD5c3YYnAkJ1mP8pjSkvjQq7mMVsVdNHkRA97xaBTx8=;
        b=YHkssWwKe8V7VgtyRkoobCFKbk0tUaYhCEx25/KZGyNkdaHXNLh3AdAsmZrXZ37LUU
         fflKeoVMIoPT9PiVL9mw+j743jl6iRCbVj0D70VDSIhEQvWkhei8v6L5GPvWMfyi6166
         aaChu87nut6OnyefljcLb9BZeGJxk6EMYQXwGfkRBNgTsuK2hWOwANS3TetgnWb/grkR
         Xg2VEYN6R7E29VKFxnYeghLISB+/qG3DDWFj90c264ytcxAOA3tev8mkdl8edDvU99Eo
         k2eodr0stNpMk6seaQlGx3jf2ElI8UcKggiPPMDzftCtvrxgv8Mz6JhUA9dSN0kBcmLG
         2Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hD5c3YYnAkJ1mP8pjSkvjQq7mMVsVdNHkRA97xaBTx8=;
        b=l/zhHZ7xsvZQIgiTkyFFqeyaXeV2/bweTEc5Fb3c1pDlIIqg8+DnNuKHaVZRL2Ff7k
         xM4Hna8ZQM8Qv2np4N3AlLG57NaMIgqFbFodXTmy4lrYhx7VQHuunz+K4O3kmkqVXJZe
         glv0oOanbClZi3Cw2qRXN8s7C9+SXgpp8F1gLPLPhP1/74luPl4RSTPTeptX5tpk3kJW
         3B9n5mDCprdgk/U5bkZAPsIOTM/0GSgHfYvy50lXEKlmQC5NzELlC327nWRdjGfhd/WR
         5KURT0tFd+H5UJwdxDVbddGtRTom+pAqC/VRdBZxowN26wZhz9hEFp9gxVT1L2TVME6H
         A2CQ==
X-Gm-Message-State: AElRT7E+aPR7EKCHgrJeHLb3Mo40VlCXeDBkACvhZPNR42Z5CVkr9JYi
        zATyj+1tinqI1BNKWDA7xjG2fBnroQYRqgC6xpD1H5pn
X-Google-Smtp-Source: AG47ELv3rJ8B4UFtmhceVGKHip23HuFtEHXarXyMi7J9DUW8Xhb7FgEqayNQGrjsdUoLvYqu7aJ0pLJBIASWDc3Z41E=
X-Received: by 10.202.28.14 with SMTP id c14mr7888416oic.60.1521480650763;
 Mon, 19 Mar 2018 10:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180319025046.58052-1-dnj@google.com> <20180319025046.58052-4-dnj@google.com>
 <xmqq7eq8vv09.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7eq8vv09.fsf@gitster-ct.c.googlers.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Mon, 19 Mar 2018 17:30:40 +0000
Message-ID: <CAD1RUU_1cNPF=HPvqgrgHisscxt4N39MnvPYGuaHES48axAPBw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] exec_cmd: RUNTIME_PREFIX on some POSIX systems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 1:24 PM Junio C Hamano <gitster@pobox.com> wrote:

> Look for these misspelled words:

Oh boy ... thanks, and done.

> OK.  An essentially no-op change but with the name better suited in
> the extended context---we used to only care about argv0 but that was
> an implementation detail of "where did our binary come from".  Nice.

Yes, exactly. Plus I think some other patches that I've seen circulating
around here recently use it in this new capacity, so the name update is
appropriate.
