Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D277320372
	for <e@80x24.org>; Tue, 10 Oct 2017 02:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755457AbdJJCSa (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 22:18:30 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37581 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754172AbdJJCS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 22:18:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id z80so13291990pff.4
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 19:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sd/djdVx6zBVHgsznvzWUFfVFrqhm8HXREqzriqqvqI=;
        b=NBpFlXW2jYm20Jo77CW+l8gX78GUDo1PgcoZgMx/QN0w05Mu/wZMZr7xmyazDIZn07
         p8baLpaTEpucMdtv0ZWoZIVc170/pYoh4wXiP7yc/0CFHe2KmS0Ri9NFbSlttcVIl02P
         hXFfX/tAhVO56igQzqTERhGpfsgt5GaGqBTKpMVBrHtdxjWD0o3PioZJsQ+Uu8dCnNwg
         Yq1KN3TA6odPPHBiG3hVnVuMIAck55w+iAW3Fmuybqe77G6T08GOP3hycjFYQaowXgOJ
         mWOoMkwZ/zLFQ74+CNKvvd5HqP+uM+Zby1u4u1Y1l7O+NOOp6WvsXbZaC4VcTrg4LJJV
         ZClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sd/djdVx6zBVHgsznvzWUFfVFrqhm8HXREqzriqqvqI=;
        b=BmaQV5/7YNMarm6cva1qgKcBYmjHfbIt5ap9KPMYXmEcNU/8VROKtsu0yFz1Sgk51F
         RmtGQ1RggLWdmDlCgj2ZcJ1tK2cLDxnsDrMV3NhFYtdFmvfbeMr3SDBTk4FAZZbbWNtd
         ZDnGY3JlluC2ol1zQ5yIK6E6m1BFDdKBDFbtLwgAcs0d+gRrBDKjA6Vx9c49CCx2hlSA
         vctNo70ycLGKMEuxgOKUdDViQmpKwInk5YsqfVAs6Bim7JaUZjhFfJ/vBZX9a0QsC1Hx
         MWP1enWy7tkQbBX2xFVYlAgDJY7KibL2zgewuAHG/aLfKuHlSQuouLuGelxHXXfC9bID
         yipg==
X-Gm-Message-State: AMCzsaUYAujl36Xd1jNqY2ceMj1tLc1Zn5jtRXkMT8rNH3OMd0vPdpw3
        9LMSxQ1j14DSobgJQibmaVaUgeA2
X-Google-Smtp-Source: AOwi7QBgTW/mdqoIR/PJJ2+aj0Ipa+Uv7IgOafiKN1ELX6DOhi9T/mCbW+n7tqem/z1kVe4AgN/Rog==
X-Received: by 10.98.139.76 with SMTP id j73mr12086360pfe.265.1507601909369;
        Mon, 09 Oct 2017 19:18:29 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id u6sm14500252pfg.175.2017.10.09.19.18.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 19:18:28 -0700 (PDT)
Date:   Mon, 9 Oct 2017 19:18:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 11/24] refs: convert dwim_log to struct object_id
Message-ID: <20171010021827.GS19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-12-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-12-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/reflog.c | 4 ++--
>  reflog-walk.c    | 2 +-
>  refs.c           | 8 ++++----
>  refs.h           | 2 +-
>  sha1_name.c      | 2 +-
>  5 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Jonathan Nieer <jrnieder@gmail.com>
