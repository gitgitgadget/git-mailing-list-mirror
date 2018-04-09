Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380491F404
	for <e@80x24.org>; Mon,  9 Apr 2018 18:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbeDISvv (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 14:51:51 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:38152 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeDISvu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 14:51:50 -0400
Received: by mail-yw0-f175.google.com with SMTP id x20so3153744ywg.5
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lk0nECXHyUebHKLg73pRtWz3dsENl1daNlMB14wlLiI=;
        b=JQUK6JG6xY8qicbP7v/8REeSXN7+pNNgjsg2SJJWSR5Z3+j6RQxV2On+mMJ8d0QhFU
         zbW1JPZbi90rBVnIavI1NxaAnJhvUVOr/XOtTIuBZg/Hl3XZfi7Ql9vx81QdMDfrlpoq
         u9FXHNL4ebMuYcOKWEl1P35lEfDk7tyIdZQX2eP54QYU8rou8ILq3M6UP5MBxZzMWY25
         l1sbl9Fpb3P4x3W7Yb2ZL7N/RxiT11E3uU3NtNTF4RIjS5dcWSMkI3YP4DADRpdcKoVR
         NuWRqsVkYPUdYOZYz6QQF0jvTAnOoIXcevow6i3p+BJAp01nmpst5EBMwOQaJ6WF452x
         XkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lk0nECXHyUebHKLg73pRtWz3dsENl1daNlMB14wlLiI=;
        b=XQZeahy+QGAXTT896sAYaRIah0Bvr7iZP90iiRd2x1V32kSnHjWziq75oy5keHW76d
         PgpEJME6r5QF2dlhoqeKWm5aK98HNnvGzQ2UaK9P4985na/BpGBkWE/T7CHZNl7kEtRG
         WpPnDf+V4d82UFPeSihfMHKuleQslW1im1RMDAdkQJkC8EF76jXCJfQs0ASdETa2Y574
         DfRGeT7tl2vImleQ2zmT6Mj4QaWXsUP3T6TMtFoIzuy0l5dHbqmKd1bMLYOi2Tq24w1v
         4e/MqXy6K58Y2yPCUISP4KgDKlCRf8pQUzdCzyvYDG68o0BFdHfpKgTlK6a4AFyZSvVe
         fpgg==
X-Gm-Message-State: ALQs6tDBMwQNoS/0wbRcrygseXJiEdHwAFDYbo+bLxDvLQluTmTAhhh0
        ozB9F3wj0lkv6oBDJATvwMpn354Yhqxmib8XXRU0Rg==
X-Google-Smtp-Source: AIpwx4/dU3Qh1kUraf3IMBQfH4YDen/Uc0q1UJ2f/xrEqKjE5lW0FzQWHdf8M/8fsAq8KeZueMeRG1HsPz3jUWS2WLE=
X-Received: by 10.129.86.5 with SMTP id k5mr11926546ywb.345.1523299909419;
 Mon, 09 Apr 2018 11:51:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 9 Apr 2018 11:51:48 -0700 (PDT)
In-Reply-To: <CAPig+cQT0Cgd4gto0dv91XUPDbweG97=waoDCOP-r3S2LbXpUA@mail.gmail.com>
References: <20180406232136.253950-1-sbeller@google.com> <20180406232136.253950-7-sbeller@google.com>
 <CAPig+cQT0Cgd4gto0dv91XUPDbweG97=waoDCOP-r3S2LbXpUA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Apr 2018 11:51:48 -0700
Message-ID: <CAGZ79kb09U4s791C-dW1kCSvYSNGu=UWfH7hxT8Euo13M6-FBg@mail.gmail.com>
Subject: Re: [PATCH 06/19] refs: add repository argument to get_main_ref_store
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, Apr 6, 2018 at 11:53 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> # Conflicts:
>> #       t/helper/test-ref-store.c
>
> Meh.

Fixed in a reroll.
