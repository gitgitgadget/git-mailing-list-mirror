Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84FD4200B9
	for <e@80x24.org>; Mon,  7 May 2018 00:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEGAHs (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 20:07:48 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46140 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeEGAHr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 20:07:47 -0400
Received: by mail-qt0-f193.google.com with SMTP id m16-v6so34139702qtg.13
        for <git@vger.kernel.org>; Sun, 06 May 2018 17:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cr86WOalUw6DqjvBYxbuum5Xh0EUfOiH/mzdfRw61a8=;
        b=Rmven5u5R03ANNmtmbroguQmWIGrpAfmK45apB0ObZJg/wb7zVMq19X71+OD52/Kx+
         QnE4Txa4+wl+kEJrp8J8tuSzwVejlLDfAuybt3Lczu8uoEuzg/M5TPjXd89Lfuwp3mUu
         EVnm2iMTxk8BO/nLOIAthalaXzLpTRSOpUKsd4LO84Egb7Zb7YpsGl/ZyAR03ldxzOhc
         To9RFygL3YsBy3XtVyO3xm4kzSynbIZH21azoCoRIJU2RXaouAPjgVRfHN2Flj7KOcp8
         uz/SyTfn8ahX0QAU4CX0t7DO9SfpFeMahlgsswHQ3Quck0kkHpcsXanVc5rzWfVp6QMU
         5Lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cr86WOalUw6DqjvBYxbuum5Xh0EUfOiH/mzdfRw61a8=;
        b=F+7JlsZdXlYgLHUyrzfk0eus2AF/EtGDSfhJ6DRrLFSvuH11jhUX6Zxido8q/rpDfy
         SsO43uy0S16gvJtJxairUZhnPZHpk26x74MARVjeGiXZasIn7zPIn9H2WrOJ+ZqwiYnl
         MpUGgaF8M2HM/qy7IYFi3L8J5++X6owurmNi9d7WD17uoCA36rJpn9PEBMM8NXkd0H8l
         6g6kgJYfxjlsULv4Sl32Zy0D4TPc37+mDsGAWX7qqImvl0ub7IlVQKR57395HaVXnldy
         TskirFZ7v69kR7c4/iHGywnH2EM2GUO54MstgeZml41LXcl1kC3dMvKNrjTungJxYhEq
         XccA==
X-Gm-Message-State: ALQs6tB9rkAKwyszSc5XClKs/++ct669EuhfcgySveAZ5/hPVlTGz2Ad
        ZdyQtihznfU85QkxQ9RYXcBLe/eAIY3CAPoQi64=
X-Google-Smtp-Source: AB8JxZpoX8S+GKaC22KQM8oWsKo8m18W27KURd686Hqn6eONVBYLrHWhxrVv6eJ5+aTHT9EBMSfMStCmBzdlu+dyAkA=
X-Received: by 2002:ac8:42b:: with SMTP id v43-v6mr31118135qtg.69.1525651666955;
 Sun, 06 May 2018 17:07:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Sun, 6 May 2018 17:07:46 -0700 (PDT)
In-Reply-To: <20180506231752.975110-17-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net> <20180506231752.975110-17-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 May 2018 20:07:46 -0400
X-Google-Sender-Auth: fDXaVzhNlWvdgoGxYWjCvq7uU2g
Message-ID: <CAPig+cQ0tm76B4_uewtdMwUo9weRkz92id5cuuQcRdBByZBCDA@mail.gmail.com>
Subject: Re: [PATCH 16/28] t4008: abstract away SHA-1-specific constants
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 6, 2018 at 7:17 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Adjust the test so that it computes variables for blobs instead of using
> hard-coded hashes.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
> @@ -27,29 +27,32 @@ Further, with -B and -M together, these should turn into two renames.
> +       blob0_id=$(git hash-object file0) &&
> +       blob1_id=$(git hash-object file1) &&
> +       blob2_id=$(git hash-object file1) &&
> +       link_oid=$(printf frotz | git hash-object --stdin) &&

Inconsistency nit: For the blobs, you tacked on "_id" but for the link
you added "_oid".
