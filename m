Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD6120954
	for <e@80x24.org>; Wed, 22 Nov 2017 18:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdKVS3Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 13:29:24 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:45817 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdKVS3W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 13:29:22 -0500
Received: by mail-qt0-f182.google.com with SMTP id r37so16923790qtj.12
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 10:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a+zEHBuCwLtVZeBYsRmD/WU1IfQreVXirj+rq61NcKM=;
        b=QxWw8r3eVGn+LAniSRVeXTaCZtfl5Ebuaz0rocdRys/xY8O7oSfot+lQtxr5uxAOOu
         y8xnpqTvJH9E3sogmHaWofXXU0/SSzoteUpqqWd6iaXrHkI7sI0EhUWM0KiM+SnVH1Zn
         eHEeZNlL0Tlh/hBrX3VnLif6oaT0rWjGW38gVqsgQQ55EGzWsoNzmJ+xEcPLOJhMQq3F
         MHjo0MhRBS/J4TUPgyLtjC9qp7QEYtD/yyvvLTbKwIObeHEkhZewsLRl5JlndkXyuk7z
         2vNJBtPTLvUp8XpDJIpPhN11WHC0lGT60FtBa2AvbTL0emZIqgPVvc/KBGEKch8CxzTJ
         buwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a+zEHBuCwLtVZeBYsRmD/WU1IfQreVXirj+rq61NcKM=;
        b=dA6BqVAlDHzmd/wfOvdKR+TUT3rF9H4PveW7OlpfQ1pEMWUBe6soKnVW0sD3rM5d2N
         grclPOBQ6YLi7X7z/njrWovj1IjFZj4gd/gJTxIlzZvTKizjGY+FraHiCeROGpsq+olS
         IueIka0zasV3yhdcFMoxtXXSZkpDWcdUvaE8eBFOKF36HziUO3faqq8QGyYcYVDoQ+F4
         9kHIlk6SHgoSS4NbZTtZn8RfMOB/Q4kMYyDzEKNL9j74+pxPDQknraxhOX4MMqVO1I8d
         k0bpwTmQdUgRd0yp5zFYXpuE1tClxRabMtUXSdtWzLb1YNADBFJPjoXcDfIk3wRcgIzH
         /DcA==
X-Gm-Message-State: AJaThX58SVGJdHMqg5Q3zWWtu1nPX8/CZOR9mTQMkVEAyRwIcyjCvcCF
        4psVod1jpQmPS2LGwk/EIxSso/zbOWCfggI5Q+WmWA==
X-Google-Smtp-Source: AGs4zMbGL3LPw88S2pTKuwg/fNX754JDp4jO0DI+ut5ufMw3RFzQPsuFNrVjqnG6D4kvjuw6I4lu9LBM9Z4OXXOjZXM=
X-Received: by 10.200.36.86 with SMTP id d22mr34908487qtd.140.1511375361455;
 Wed, 22 Nov 2017 10:29:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 22 Nov 2017 10:29:20 -0800 (PST)
In-Reply-To: <20171121080059.32304-12-newren@gmail.com>
References: <20171121080059.32304-1-newren@gmail.com> <20171121080059.32304-12-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Nov 2017 10:29:20 -0800
Message-ID: <CAGZ79kbMuxnToLazoVh6sx5ujB2Hh+eUqVy9j3dN6MnnJiZ-qQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/33] directory rename detection: testcases exploring
 possibly suboptimal merges
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +# Note: Both x and y got renamed and it'd be nice to detect both, and we do
> +# better with directory rename detection than git did previously, but the
> +# simple rule from section 5 prevents me from handling this as optimally as
> +# we potentially could.

...previously...

> +# Testcase 8e, Both sides rename, one side adds to original directory
> +#   Commit O: z/{b,c}
> +#   Commit A: y/{b,c}
> +#   Commit B: w/{b,c}, z/d
> +#
> +# Possible Resolutions:
> +#   Previous git: z/d, CONFLICT(z/b -> y/b vs. w/b), CONFLICT(z/c -> y/c vs. w/c)

"Previous git" may be hard to understand when reviewing this code in 2 years.
The future proof term is "git without dir rename detection" or such.
(This is only a small nit, which on its own doesn't require a reroll;
I'll keep reading.)
