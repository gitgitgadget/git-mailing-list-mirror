Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78D3F1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbeHOTa2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:30:28 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36844 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbeHOTa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:30:28 -0400
Received: by mail-oi0-f41.google.com with SMTP id n21-v6so2988681oig.3
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRVPl6PEcAsMIc7hjKIrSyGIMPOh7GaZ5m8A0ZxjcFs=;
        b=eGZXMChM8OukKuXE4O2l6WEZ3nYENC+01lNhq4j1jVHpduZy4NjO3nsVYuxDmPt5Oc
         SKLeC8GmjXRSOIHERoyk+fEdgVXvwIIDNlHUut3FVVd4PsiUGnYSDAokXVpUYjtHCvms
         SnuMIhMnVWP5Cik1XDLScWJ2xVF/mtR9/paQPZC8QmxtWJ4E5LPDIg8mio/2BS44fsGe
         Tr0AVTG8pcB+xnm3s0RIC7m8NZbJjEIN4eEMBv7U83sLLJvBCWzQZVVMuWF1fFphjR3g
         vOJgoGyWaS0Ora/tDPL11+tLov1p7LkTWpCzD6TbriFZGgWSrIyr3VE/W6nyDqRcbizl
         cTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRVPl6PEcAsMIc7hjKIrSyGIMPOh7GaZ5m8A0ZxjcFs=;
        b=AkSCr93uR1/q0aaD1/7OF4KUkAviI0YzDK1hUs8RAlofFN3IB30dVYoRdrug002+6O
         PHZDjuO2+b6ZmRHtjP/rapn2KbgcXcL8+C5XUqLiWbr7IOfs0FD9xFgYHu0NVRCB4fgJ
         R6v3IuX8zGjT+VbQyiGcJNXz29n7Y1oxLhls8HDodlwO0iwZ3lgwbJvjEuC9pqvb0gUF
         mXdTTXD9EU7sp26hOtAnB8DJ9VvnORbDbRbnVkUuv+K1AVVPyJjgULxqtIV0C11WdFM8
         M+7WxdLN0Ak5ia244TZCGTsL2y6tpt1kwn+X6ILZETzYCaTjr/uZUJEV9no0BEwtDQ0A
         Ojbw==
X-Gm-Message-State: AOUpUlEXnxj4npz7+nxmtsMVWSNqvcC1h0CriJ1qr6pkYWqXx2XNvloH
        Yldd7fBs0tcWF0sYT976J6Nu1GQ13lHq6o/NsTdU
X-Google-Smtp-Source: AA+uWPwnUih8575NwUXl2srr1M3OoAb594sc4wO1Q2T+YOJrVsXKv/nkcwoPCHH06a7eLHi04Tw04/km6Biz7N0oVSo=
X-Received: by 2002:a54:4e8c:: with SMTP id c12-v6mr10951105oiy.238.1534351055876;
 Wed, 15 Aug 2018 09:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAMfpvhKr4jmjZ3NUmxMyTM7KJxQX30UYXKf_rJ30A4C=P3tB=g@mail.gmail.com>
 <20180814201920.56534-1-jonathantanmy@google.com> <xmqqa7pozmzv.fsf@gitster-ct.c.googlers.com>
 <CAMfpvh+H5UeHmCqeVNZNoOe_-vgH3_3aTuO+c=imgzaVkC6N2g@mail.gmail.com> <xmqqva8bk3o4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva8bk3o4.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Wed, 15 Aug 2018 09:37:24 -0700
Message-ID: <CAMfpvh+F0asn94+M0369MoCaBKVoVFMzKarVm2kk0jaD-AdaGw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] list-objects-filter: implement filter tree:0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 9:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matthew DeVore <matvore@google.com> writes:
>
> > Thank you. I changed it to this:
> >   awk -e "/tree|blob/{print \$1}" objs >trees_and_blobs
>
> The "-e" option does not appear in
>
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/awk.html
>
> and I think you can safely drop it from your command line.
Fixed it, thank you. It will be in the next patchset version.

>
>     If no -f option is specified, the first operand to awk shall be the
>     text of the awk program. The application shall supply the program
>     operand as a single argument to awk. If the text does not end in a
>     <newline>, awk shall interpret the text as if it did.
>
