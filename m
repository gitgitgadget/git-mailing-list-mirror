Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7A51F859
	for <e@80x24.org>; Wed, 31 Aug 2016 21:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759548AbcHaV6d (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 17:58:33 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36678 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbcHaV6c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 17:58:32 -0400
Received: by mail-it0-f44.google.com with SMTP id i184so34839242itf.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PKILifEgI5U+nwlOmL56JehuJo29ndLmpoH2UitkEFE=;
        b=fSQ3RiDuLc3JQxbxrZ5cmc42oCd0sGCTMEhmt+2kFZyUQM3rpFxQa1r3eavZrn4VHM
         23UwTtNw8b9rJkz/zhFJz6F9sOP3POnLsruMRuEow2Xjn+qfsFsMCLTcgG/eznDOY6o/
         Ef2w8kU/NyWzwDpmDXkR8sxTnSKb6kRsbmtEUDXI0MUNjYSsqDziJZkeVT+R5E2tDR6S
         857tMmT/xiIDeIV7vKDJ7a5mxLbhou24cV9F42UGWk10WE5sOlcBOITa4mqh+vguEMJd
         Z7eTlw+yGgSAGie2oCikb5P4rJ3MTahZzF5i8VuZiwoBvZVwKMOr3GJd8LJcydfE1Hhk
         YNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PKILifEgI5U+nwlOmL56JehuJo29ndLmpoH2UitkEFE=;
        b=bBB2nywuIPsdMfa3D1BfEt/NS9uDSokxGCy5RAqtp2mv5vR0rV+7Phtk/6ioa1HNzZ
         6POxJYpHJXL+qvpfaptp03Dvzyk5+lGP6VQrPlXWhCbXSgXiTc1n3gCxLgvdw94aLdqx
         /PhEG3lgXf3Kdkr5an0smiSRIf9oMNrb3hHi3CX9xNVrQPHGqQ0a4AAjtvVkHhp0uttZ
         rbY5nWeE7S2aakqKJtCAiS0wF2QHKBNZapm2c0aEGzx2Mq+hjiihdYKpPyVPFw3AgoB6
         WK9s4WppkeuGZPoXd1jyPGkJ2DPaY6GxSdfQFiC19rCfXgYhXEO1rf5thPOuvFrKEeBS
         uWLA==
X-Gm-Message-State: AE9vXwMBpAXtQnPPQflTgP3B+LlCsON252aqqvIOCwABewornpIdYHDbYof3d9N4W6AZ8ij3NCRAUMxg7Iq76Dsc
X-Received: by 10.36.227.7 with SMTP id d7mr1012726ith.97.1472680711165; Wed,
 31 Aug 2016 14:58:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 31 Aug 2016 14:58:30 -0700 (PDT)
In-Reply-To: <20160827184547.4365-5-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org> <20160827184547.4365-5-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Aug 2016 14:58:30 -0700
Message-ID: <CAGZ79kYz2kRgDOFvOOAQL5HyjvcZ1+o9fFJMWVtkazVfy3Ev6w@mail.gmail.com>
Subject: Re: [PATCH v13 04/14] apply: make some parsing functions static again
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2016 at 11:45 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Some parsing functions that were used in both "apply.c" and
> "builtin/apply.c" are now only used in the former, so they
> can be made static to "apply.c".
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  apply.c | 6 +++---
>  apply.h | 5 -----
>  2 files changed, 3 insertions(+), 8 deletions(-)

Looks good.
