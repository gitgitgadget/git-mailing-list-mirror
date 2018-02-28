Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 237201F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932240AbeB1TJa (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:09:30 -0500
Received: from mail-yw0-f173.google.com ([209.85.161.173]:44777 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeB1TJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:09:29 -0500
Received: by mail-yw0-f173.google.com with SMTP id x197so1185724ywg.11
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MPknSOzQkt7oip02gjtKR2i8pkirXePom/jimTI7DOk=;
        b=HdPbdEZ/sXD1DBfnxbmXzXj5SgvfoYumXUy+Ua+1zbPXDADZFBluzx23RJ45Ifuxag
         weUQXXcX9iJ76rij7vZ0h+Rvsmg+ixsrNiDZWMJcrlU4SBwJRCnd+j+p9Gd/h2MHKkoQ
         ZFs38b1pKKtAg/EdE7fLraV31q45ncDUCHB7o053YQY63KmfG2KqNiEvnNdD1faFTXQ7
         wt0SDVD3DBdSMKc6Igt59tQZpQPM99uqJ3hw3H4hYaT98ix0efqrf70OnbX5Jt+0TG7l
         0NnFwKcqqpa++DxsY2R6GKPnDzLbUXHiamCrw8qIcvoy8tePfIyXLT8jCjcjnALpcDSM
         UxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MPknSOzQkt7oip02gjtKR2i8pkirXePom/jimTI7DOk=;
        b=COcTvojUQzSe1K83JNwjURGNmnSFprk76G5USZt9I2L21hvapt+LKtw9YgTtH+RNYY
         XuOYCOSb3qdIkNGl9E+ZGzlaOO4AuK5b0Vn2kC6wiL/D8DHmPX1VI95c0+T/G667OfXD
         5N42bStw0DMDmQBytmtCu6BsJyngG+DhWcEQDG1Kf+sGf4MJVBWC0f4b0JvjFsqN+t+X
         Fp1n13MGbnqhOg2mlF+wY9TyTvRkBWmbcds2ZRiKFQoEKt5dEpfysxjvL98mWSuggZpF
         6LPkdLWEfG5siphO+FTbnAauCvKQTGG5p/G5ITlnseVaZ2PQIJmMTjyLYQOGNtbgZkKh
         ZVoA==
X-Gm-Message-State: APf1xPDLVknFC67cEbh726SkFwN/gN5FiiBPNAeXrSzdKded3odNt9VU
        un/zchYgAeU76+U5Gy7NRr6cdL7ubjXk0eU3gEdAPA==
X-Google-Smtp-Source: AG47ELt3kkpVdqqSGpz4LYpmHEsXXESE/QiIQp9XhSXqI+fSEHhdt9URSOoL/Rf+XwZfQ6tLDqb4GZMrAqW3JnsQRto=
X-Received: by 10.129.241.13 with SMTP id h13mr8520566ywm.500.1519844968214;
 Wed, 28 Feb 2018 11:09:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 28 Feb 2018 11:09:27
 -0800 (PST)
In-Reply-To: <xmqq7eqxkkds.fsf@gitster-ct.c.googlers.com>
References: <20180228010608.215505-1-sbeller@google.com> <xmqq371lm1zd.fsf@gitster-ct.c.googlers.com>
 <xmqq7eqxkkds.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Feb 2018 11:09:27 -0800
Message-ID: <CAGZ79kZJC+puprsqHuGqsgHNse4=10unnGBwHgKu9dW8a_fiJg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Moving global state into the repository object
 (part 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 11:02 AM, Junio C Hamano <gitster@pobox.com> wrote:

> OK, so I finally picked up the last round, which wasn't even in my
> private build.  I had the previous round but hadn't convinced myself
> that my conflict resolution with other topics in flight that were
> still mushy was correct, so it was out of 'pu', but at least it was
> in my tree, so that is where my impression came from.
>
> I saw that the way a list-head in a repository is initialized has
> been revamped in v4, which looked sensible.  Will merge it to 'pu'
> so that I can pick up the ignore-env removal from Duy.

Thanks,
Stefan
