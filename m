Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C8820401
	for <e@80x24.org>; Tue, 27 Jun 2017 16:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbdF0QUW (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 12:20:22 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:35221 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbdF0QUU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 12:20:20 -0400
Received: by mail-it0-f53.google.com with SMTP id v202so16339369itb.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zbifbeAHiICuSVknoD5IC1pdEd0ZVDGvrCnTKhNB1oM=;
        b=cqQT/c+eBAdOpGKnXC9trwW9qVC46SWh0CcoWFnxSDv1wT3GDU66QTYB4pNd7gdvey
         ymS7q42MFf021H1qBlOH1JqV55bRRSPcI0dFiWb/EYm2df9y9Ix7Dz+suhEbOBai2dtO
         KvMTioTLjgUJdtb9GA+9r3H64b+j23KQ7I7fiFTrNBBeRylbxo7HuIwrFX3C4s3ccoys
         OTTo4pWSM3xabiktzJE4993z8Ls6nlJiRGRq+K3puAyOyXboraObtzlOqvVsTAySklhj
         //TPAnd+ZiPS8Tq1AUnGXrNxe/rVVY8Xz/44ZgLK+tB5WZVRxUL4uEHGDdcD7g93qtxx
         8sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zbifbeAHiICuSVknoD5IC1pdEd0ZVDGvrCnTKhNB1oM=;
        b=axgak9RSe1nF0Rk7ARB04WAirQCeMqUPe1tjo6DM25ZNDPJQSRDg9alGbuqJHAKLqx
         3SMMCOLmN87XaKCwZpjcJkDSjRgxKYj2LAMfWD5of5J1GZvVtSewjnhHwM5Wye2umLBj
         XPgMmSV3gJepuodOuW0GebEiWeLSCLYD+L5+P1fLPoF/1tHNa1YSpQBM+w1kJbirg7t3
         HsNmHrRbX87oeVtjjlvV35TwGDiJ7XR2y0tZ9mJjmYk+RUyvmUHOx2Zyl3fgTFUEUjlq
         tRRmU32gdln+h6QLtQv2c4Co+gYJW3lAD3L0q230VSP92qwuvTpKmn0LaObG3R/PsKZl
         wcVw==
X-Gm-Message-State: AKS2vOwx/LKn0LOOrbHlOvJvLkHxlgA3KctiI/8AfDvWAgK7/k6e1ha+
        TXahJnmgr1RbGVjcRZlug3dR8pomOQ==
X-Received: by 10.36.8.195 with SMTP id 186mr3255569itc.76.1498580419820; Tue,
 27 Jun 2017 09:20:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Tue, 27 Jun 2017 09:20:19 -0700 (PDT)
In-Reply-To: <20170610134026.104552-5-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com> <20170610134026.104552-5-benpeart@microsoft.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 27 Jun 2017 18:20:19 +0200
Message-ID: <CAP8UFD3FtddFuaVY9qEyxbm6hiYhFR2TrZ32Cubp4GAEf9+vaQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] fsmonitor: add test cases for fsmonitor extension
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 3:40 PM, Ben Peart <peartben@gmail.com> wrote:

> +# fsmonitor works correctly with or without the untracked cache
> +# but if it is available, we'll turn it on to ensure we test that
> +# codepath as well.
> +
> +test_lazy_prereq UNTRACKED_CACHE '
> +       { git update-index --test-untracked-cache; ret=$?; } &&
> +       test $ret -ne 1
> +'
> +
> +if test_have_prereq UNTRACKED_CACHE; then
> +       git config core.untrackedcache true
> +else
> +       git config core.untrackedcache false
> +fi

I wonder if it would be better to just do something like:

=====================

test_expect_success 'setup' '
        ....
'

uc_values="false"
test_have_prereq UNTRACKED_CACHE && uc_values="false true"

for uc_val in $uc_values
do

    test_expect_success "setup untracked cache to $uc_val" '
         git config core.untrackedcache $uc_val
    '

    test_expect_success 'refresh_index() invalidates fsmonitor cache' '
          ...
    '

    test_expect_success "status doesn't detect unreported modifications" '
          ...
    '

...

done

=====================
