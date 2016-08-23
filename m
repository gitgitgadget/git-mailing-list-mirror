Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D49EA1F859
	for <e@80x24.org>; Tue, 23 Aug 2016 01:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933088AbcHWBIG (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 21:08:06 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35515 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933073AbcHWBIG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 21:08:06 -0400
Received: by mail-it0-f50.google.com with SMTP id x131so120237893ite.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 18:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J2eaP/9fodEkwx+R8PolLecmDskYPQaYWGtP/BgNLzU=;
        b=M9EwytfB2q+2/tybXMZCf7dsTHEM9t/n2BjkoH6UTZ5MgHONCGl5DtSOnnm2qN5uye
         rUNQSbObKj+wh8mAOD44O7WqNa8sGiTOjZy4K3LkkQ6GUxliJSPJoEwuY3Dv5knwH2wf
         k1oHj72MQ8uDEzMNfI6M7YWsRh5TGDqdv603M2lW2wp163rvJlVpowI6vJgAVrcZtN14
         oj7IL1AuKxPd++o1KffsIi0V29gsf8EymTKh89YBKifLE+LojGw28flYUARvNJBhKtVw
         ec/zgvhKqGJXbIOaolK4Y5bWfZMmSEFX68VN+zcoHzhAjKHNoW4lwdTfYtxsMti+Scub
         XDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J2eaP/9fodEkwx+R8PolLecmDskYPQaYWGtP/BgNLzU=;
        b=GXTCK7BQBUUpsrhmU3/H1l9+1A/h5Uw0YvNzpgg+U6ObXaHfyZHNLEStedhgQz0YaG
         54jzDpjVLcwX2RxPZ39tBKlmBgKAM7BfWGvEbIBJPPTCmeRQhCgxzZCNif9gEoWm5tHB
         Op3FpcMB6/Uam5vHdxTdEVvSOdbTr3rHqGW4xP3KdsBml2q4g9kDKe0T4BlgjG2NfPN1
         b1yUZEFYTr7M3NbhjKbt1jASrULKxSPWY/xMYM3EypOJsDDW9l/w/PKwFGyZ59+Kbihz
         rC/nRQGc8LmmY4d9tbWWFkRixw7vFNN2ZOneyCjrk+SdUfCBv2YqrAMrvOyefLTz/hgs
         L7OQ==
X-Gm-Message-State: AEkoous+HFvk1FxkhrAKgXIDcmHM2994Cq2sgNJv0IXe2xe8U8SBllh8wD+Syzd2YorazsUaYOG7pyziByRPI0MR
X-Received: by 10.107.144.10 with SMTP id s10mr25556258iod.165.1471914057450;
 Mon, 22 Aug 2016 18:00:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 22 Aug 2016 18:00:56 -0700 (PDT)
In-Reply-To: <20160822234344.22797-1-jacob.e.keller@intel.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 Aug 2016 18:00:56 -0700
Message-ID: <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] submodule inline diff format
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 4:43 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> A few suggestions from Stefan in regards to falling back to
> .git/modules/<path> being a bad idea. I've chosen I think to avoid using
> die() as we just stick with the current path if we can't find its name.

Which makes the existing bug more subtle :(

> I think this should be safe since we already do this today.

It's a bug today already. Thanks for spotting!

> The new flow
> only changes if we are able to lookup the submodule, so I don't think
> it's worth adding a die() call.

Well this series improves the buggy-ness as it is only buggy when the name
is not found, and we fall back on the path.
