Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55A7215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 21:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbcJLVpb (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 17:45:31 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36159 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbcJLVp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 17:45:29 -0400
Received: by mail-yw0-f177.google.com with SMTP id u124so41372535ywg.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8qNMG/RPbkzH1mFiJ1XFChg3FLtkKEEcGVsgdUhi38E=;
        b=loASklJo22zoaaLkzsZyS8zIqVq1PY8zlZKEa/sydsOZQzRPYtOChl+/7PlOrasvmr
         H6BYEwjwnGsm9BVXqWslSGwYO90//SmU1zKZdQoM4MGuEq2veezbtJsGGUg7z0ERm4DA
         TIE3COqu2mg3j9zvq8Ev0ympA/BqRb+IaoIyeGtwfY3ZyoVEVgTvfDVyP2nzy8y0f2/b
         ynNRR2bibLmVhsTLVlR+ZhAM756cvhtig9+7CGquqTxatIZ2XuKIM0H86LpUa5i5Ntod
         Vaj/e9sZLRP48DOK11SKlM+AeQRYNmNPK+gpCwqlYk32kOlBfCVETkvYcWb2sC3OLLLf
         QzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8qNMG/RPbkzH1mFiJ1XFChg3FLtkKEEcGVsgdUhi38E=;
        b=FFc2v37Whhecd2ROlokoC4ukeMwnREECuoaxLpuE8Z67iO6JiH3ZC41bKujw4CFZSa
         arjupp27PP84KnIZbONz33alTsVgZLuTrWL2nZ7/uEueSxywiqiKrmovudrj2h44WMwm
         Yz2vbFHZv+v1K6DOdGJCkiH5f9MevuOAjhBMl2oyCfiBPb5F2Nwl9rhCyC+0REXZB6Xc
         ZW3aOEXQlaal49yjtoVT2mCUiu64kwtqB1u7c7rign0q2nlpODTcI+jtglYPbwE6gpEE
         31h8fvIwRGMiMrO5NR1RZm07JAohM9/TMin+XuQZz1HpNarneKHK6FME7dUuGkSKoOyh
         nVtg==
X-Gm-Message-State: AA6/9RloIp63y0a/1+wpi4FDMeYM/rizE9McPQxlk1H7XhouKGLDPSU3k9Era0CE3B+Ki8Gct4YDCbosJLxYwQ==
X-Received: by 10.13.244.129 with SMTP id d123mr2825236ywf.276.1476308728933;
 Wed, 12 Oct 2016 14:45:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Wed, 12 Oct 2016 14:45:08 -0700 (PDT)
In-Reply-To: <44c554b8-7ac1-047d-59f0-b4d5331ed496@kdbg.org>
References: <20161011235951.8358-1-sbeller@google.com> <44c554b8-7ac1-047d-59f0-b4d5331ed496@kdbg.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 12 Oct 2016 14:45:08 -0700
Message-ID: <CA+P7+xqBUT3jUsxciVydO+nRoR+iJygWG=y_ARpiQSs+-kcH2A@mail.gmail.com>
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>, bmwill@google.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 1:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Sigh. DCLP, the Double Checked Locking Pattern. These days, it should be
> common knowledge among professionals that this na=C3=AFve version _does_n=
ot_work_
> [1]!
>
> I suggest you go without it, then measure, and only *then* optimize if it=
 is
> a bottleneck. Did I read "we do not expect much contention" somewhere?
>
> [1] http://www.aristeia.com/Papers/DDJ_Jul_Aug_2004_revised.pdf C++ centr=
ic,
> but applies to C just as well
>
> -- Hannes
>


You know, I always wondered why Linux Kernel code needed memory
barriers but userspace programs didn't seem to use them.. turns out
they actually *do* need them for the same exact types of problems...

Thanks,
Jake
