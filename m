Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83FCF1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 18:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeFASvb (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 14:51:31 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:39206 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbeFASva (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 14:51:30 -0400
Received: by mail-yw0-f180.google.com with SMTP id 81-v6so4976132ywb.6
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MCLEu0kxP17B1y39/XKvczyzF0jUxjOulHBqZUc2sTc=;
        b=YoZjaZS6Ep4r42+b0wM5Z7UFievVGtdD1peiX5T2Sxnvv1ez4OzyUZ2sKQoR+keHRE
         NLIGMO5A3UAHY/JPkrOVRDNl3KJhW+AI/GQPIjlYIvIbx5ZmaUuWYtCOOEm27oESbYON
         sE3pbaK8e3FP4aAfiC9GquIZMEv0SNzXsC+KIOfLrcvISB39tS/3c0W1Qr9L67QL5Qxo
         Q0toJHyuVz/xvtW3SBssCz5K7/VuqBE8jDYRv16TaB1EicE89QtFHBfD9C4H739EOn99
         VWLLsdBNZf9f1T8Uun9AgqPs+5FpMWe/UmCdCHlbfm0w13lb4ym86emie20XUiAEQqVE
         inYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MCLEu0kxP17B1y39/XKvczyzF0jUxjOulHBqZUc2sTc=;
        b=sPgAzIzuzjTN9MCbkZdt9Y+7wEf8vLXIaVoJSZ4tLWeJEwqVbuT93yb4N9pXIxyi7+
         lh8/cHorbUO6UZJ+NxGO6WQBfoigQm733VK2vuWt/pdwDnoKq27OX64auczMO2PoEgOj
         5ePBw+rDJ5PDj9pt5OCKCjBKZnt5ocQ4KjdPKwQiYithEOSHGC2rgv6BtbfwaVEfkVwS
         hN0kB897gab13qjhOm3QIEpyA9blEE+i10gdYcGgBEXxbAJFGuk9zmoNI9iuHZ1Nde1d
         Cax8LM+Ct8Y1nzNudgvmHHcWdfBz7nEKE8Fg7+JfARoZ9VhDWLMd/JNQhqTvXbjgtoBU
         nHyA==
X-Gm-Message-State: ALKqPwceT+KZDYWUeAeodJ+WSloj9GRBEYHLaBt7rDxHGEYtAjsBPATv
        wyW/2JGn8BbpQIK5bEkTFWhRFasLHEAw+3p+df/fWg==
X-Google-Smtp-Source: ADUXVKLr8s+Aw/9cuVHbHJ31uFti1aVbebBHomhXw7EWx+qfWn6eeR0/BYOx4AyxR5IAfhOTyPpr2snu/WGc0PvwAwc=
X-Received: by 2002:a81:50d4:: with SMTP id e203-v6mr6723860ywb.421.1527879089766;
 Fri, 01 Jun 2018 11:51:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 11:51:29 -0700 (PDT)
In-Reply-To: <CABPp-BFaFR-ZTg2Wj4gcBPLyb4sejw+guNhWRFXfRRR0UZq4nw@mail.gmail.com>
References: <20180601161153.15192-1-pclouds@gmail.com> <CABPp-BFaFR-ZTg2Wj4gcBPLyb4sejw+guNhWRFXfRRR0UZq4nw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 1 Jun 2018 11:51:29 -0700
Message-ID: <CAGZ79kbOKPgBPJpoez7S5k7Y6L-+ncjcAvs3MaADLT1z_dv3+A@mail.gmail.com>
Subject: Re: [PATCH/RFC/BUG] unpack-trees.c: do not use "the_index"
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 1, 2018 at 11:34 AM, Elijah Newren <newren@gmail.com> wrote:

>> +/* Do not use the_index here, you probably want o->src_index */
>> +#define the_index the_index_should_not_be_used here
>
> Good call.

Is the space instead of the underscore between the last two words intentional?
