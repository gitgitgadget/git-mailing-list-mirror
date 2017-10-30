Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D311FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 16:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbdJ3Q1a (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 12:27:30 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:51852 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752681AbdJ3Q13 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 12:27:29 -0400
Received: by mail-qt0-f175.google.com with SMTP id h4so17111720qtk.8
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qrtopgPcFS5BKeTdtmuV3Kw2zHkggqtPrWsS+GEUgR8=;
        b=QFkl6d7D9Vo0hbdrib5q8ezMp8QX/R79waIYRoR0D5aqL27Q3oDchguh53++xgi5NE
         hUqAfsBd0QMkMl8RhFoE4dFAHXNuxcj5f/HH3afEMOVdE9fcHsAH5JSsCJ/Na51up9YR
         T2uNjAyZ9Dglohutf+LQIaUEr/0GcOGz03a/Ud6Got0zG4iLes+9EpbRMY+Om8u43wW1
         kO+PYWnyub7RBb/h941zFxOdCz5sQsDfQuY/hu/ADPTcD9Yo8FVrN6lGAzCnLCSQFvAB
         G0UqgbNimp7+yWHrACjTHdqjS0+EWJ/d0GXEs1pT8426tOhWv9NtPz4HYpmVy+KfUTRJ
         UUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qrtopgPcFS5BKeTdtmuV3Kw2zHkggqtPrWsS+GEUgR8=;
        b=XP5ut9dDxxVQltxmTUlGhTZVtnPf9utaNv23+1OX8CxhrA0+Vxnxvh06LDlcgo+YME
         wT6W4FPj4CnHSrRlAM+twvX2neGxd3r3EXFMO2OAxe2EoG9h3ZBDeIPGaNGhLxkXG40i
         37qd1zpPwneYU4bAfemPDWNLv9tafzUxz71S8/D5Pt9iNesJoE4x8erzrmmHjfMixk3D
         dDX9YixeV40juR5GoOFJurMAqSQSGROEB8uSeVbS0lBPDgCb2hKerI55GuEa/OIEVDTs
         vJ+cXrKV9YF7Zw6+vf3wJlokjheKTmueOtVPEi2wSwLDa/ombvcCk68Cmm7jymX3kaoT
         qI2g==
X-Gm-Message-State: AMCzsaWV3kzpigihmPAG6Y0L++U0uTelirLkPpBtiK6sB302Gcm+urUX
        H8rxgjCvQpELfnSyjLnlGwz/BATObAKXrBO9VLrOUqmA
X-Google-Smtp-Source: ABhQp+Q4CaSPF+eDhvyi9C0Eje5V1soxYNfrTOfmrcleynrK8ydj60LDNEV6eXGTlLlwv7GnDH4M0MYNpxeO0Rda3Bs=
X-Received: by 10.237.53.137 with SMTP id c9mr15922050qte.125.1509380848691;
 Mon, 30 Oct 2017 09:27:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 30 Oct 2017 09:27:27 -0700 (PDT)
In-Reply-To: <20171028181239.59458-4-sandals@crustytoothpaste.net>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net> <20171028181239.59458-4-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Oct 2017 09:27:27 -0700
Message-ID: <CAGZ79kZZpO6SzGrN=2WKbKijwVCv4Kpj=yHBKN0vkP1UibhE9Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Integrate hash algorithm support with repo setup
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 11:12 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Include repository.h in cache.h since we now need to have access to
> these struct and variable definitions.

Let's see how that works out. I remember having include issues
in the repository struct series.

>  };
>  extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
>
> +#define current_hash the_repository->hash_algo
> +
>  #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
>  #define DTYPE(de)      ((de)->d_type)
>  #else
> @@ -920,6 +923,7 @@ struct repository_format {
>         int version;
>         int precious_objects;
>         int is_bare;
> +       int hash_algo;

I wonder if this (as well as the #defines in patch 2),
ought to be an enum { unknown-hash=0, sha1=1}.
