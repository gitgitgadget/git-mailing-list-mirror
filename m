Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F337320C31
	for <e@80x24.org>; Thu,  7 Dec 2017 08:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbdLGIOd (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 03:14:33 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:39894 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdLGIOc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 03:14:32 -0500
Received: by mail-it0-f49.google.com with SMTP id 68so12517228ite.4
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 00:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IzEHWTXoU3dZrY8W/zNsP3Gsakf0KqwWaSCFigEpA1o=;
        b=lfW2Qn4rACT1xBdyPnAr3abx7m5tt0udbtHXJJh8X0bBJxfDN6XxWbCxy79aTXcY5P
         /xmOtJptcAwut1tm2VvCsYqv8PfEhkBvIAFaOBXSoKu0skEzoKNfnr9EEV2wa4HIrg5V
         wxoNjD9yW/tce7/niXGyyLv6nXztWxDRJna2ACmVwxFvt1zuRr6VsNU9sXOWUO7BAQCQ
         Hhw0QfNBSUlf+b78GOFbagoiWUYR40cIzG6Dz6k6xnbqAlDEOy4YHMyLBe/VYbdGry+t
         fGVpwiu0EfgE7z5gAYwuDjxycLGmHMJvbZJ7ikwd+J667Q+8NzdWaDtAW3jWzveDOROR
         2nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IzEHWTXoU3dZrY8W/zNsP3Gsakf0KqwWaSCFigEpA1o=;
        b=mDihoFkcum0k+fjPZgDMMybkKOPYLcFjv68pnIvnxYxb0ateAPtdFVASTWHRXfXwF7
         RtkIoXUFMT+lTiVKq/hVrCGEpI2/zlWWg3ChGYUeaxbSXhFkv/E7QSlTLcj7rQTE8i+R
         I4MOm8OAxEUKO5jL7RYff5o/OQMfPD5wHXxBOm7Rq9ZHDQsnkwaFkBTWBN7CcyuHgpjw
         moPYzP856zVEM21jpLJuSm4lPSYixujRmJoIVS57P6IVmRhC31Zryyx627BKzD2dRTxC
         6WRNMze7fpo9gmMMmyJxIZKOAhidb/L6uZUzQ9kA1lLJL/xddA1hreXkVHIh4cBZVwl4
         JTlw==
X-Gm-Message-State: AJaThX5p4Inpnxrv/xoEo+HM1Hy6Xl7HlZDFN38+o/eq1w1jID5TXy5c
        vd3O5vPXiKnIVHaFUnG5UEaLl+k57WXeT9wT1ZY=
X-Google-Smtp-Source: AGs4zMYDvls7NpfwhIQT8q2qgIsr1qg0fEIHQDozjKn6CAdyM60xOFPxli3vwZmzozkkphZ50Iv3xxFei/CBBlF/xuQ=
X-Received: by 10.107.39.207 with SMTP id n198mr34437233ion.180.1512634472034;
 Thu, 07 Dec 2017 00:14:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Thu, 7 Dec 2017 00:14:31 -0800 (PST)
In-Reply-To: <20171207005639.GB1975@sigill.intra.peff.net>
References: <CA+P7+xotDPa+=G5ypfyD7gySp6r2SKRAjMSw_0BmvuyyfcjxBw@mail.gmail.com>
 <CA+P7+xouqMi4xo7psM-PmpqcpKre2X1YyYZBLfMDYSSZ8tD_VQ@mail.gmail.com>
 <20171207002234.GA21003@sigill.intra.peff.net> <20171207002439.GB21003@sigill.intra.peff.net>
 <CA+P7+xpoaa5zaF13ageKKjpPKTECU6XjaRdSZy6WOP7Q0TX+yA@mail.gmail.com> <20171207005639.GB1975@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Dec 2017 09:14:31 +0100
Message-ID: <CAP8UFD3iL_sRgvhm7YO_jVG5RiNn1=JRW0qvhBEPcUtCorWdYA@mail.gmail.com>
Subject: Re: git commit file completion recently broke
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 1:56 AM, Jeff King <peff@peff.net> wrote:

> I think we'd do better to just assign NULL when there's "=", so we can
> tell the difference between "--relative", "--relative=", and
> "--relative=foo" (all of which are distinct).
>
> I think that's possible with the current scheme by doing:
>
>   else if (skip_to_optional_val_default(arg, "--relative", &arg, NULL)) {
>         options->flags.relative_name = 1;
>         if (arg)
>                 options->prefix = arg;
>   }

Yeah, that is a possible fix.

> IOW, the problem isn't in the design of the skip function, but just how
> it was used in this particular case.

I agree.

> I do think it may make sense for
> the "short" one to use NULL, like:
>
>   skip_to_optional_val(arg, "--relative, &arg)
>
> but maybe some other callers would be more inconvenienced (they may have
> to current NULL back into the empty string if they want to string
> "--foo" the same as "--foo=").

I discussed that with Junio and yeah there are many callers that want
"--foo" to be the same as "--foo=".

By the way I wonder if "--relative=" makes any sense, and if we should
emit a warning or just die in this case.
