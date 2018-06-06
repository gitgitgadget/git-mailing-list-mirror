Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2911F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933646AbeFFRS4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:18:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46163 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932977AbeFFRSz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:18:55 -0400
Received: by mail-wr0-f193.google.com with SMTP id v13-v6so7113747wrp.13
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M46RVVVMZ+efeDlHt+uP6HwHDWJ6/O+E4RZfy2g3iuE=;
        b=lvpLSqGI+57u6x3t24mA7KXZTwSGQ1CkAelQZVEL8h/wSbv0DW/+fcYl1VSezDp+sJ
         1coJx9pzl5+zE+OdI59C6gJjcTDpJJePuzHOBzIrjfepr/Ql5WFWzzVMWJKk1MlhciQF
         nSTlj7Aukm4wDNklE6Q0+Qh/SXWpWsuErl6fRYjUIm+OhdfwkqVeLgBKUFGJlx9xANfx
         IA3gVET4pC/kn6EKIPNmjhyrB/dg90BR/R4/yIMa8z/BIfv/n1O29uYO1YhYGgcjNirJ
         EAvDdi+l3o7aDHT9XWsZGSusYMwbY4yrJykvC3zWrcNNpVUXRMgcVtXtBgb/qqe2u9JW
         sP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M46RVVVMZ+efeDlHt+uP6HwHDWJ6/O+E4RZfy2g3iuE=;
        b=ZqW/ie7kVFU/T4jdqNNS+u0lejHIqXDpH4fzxEyj0speWGa6QTCERrGoHpBWpwKF34
         U1kus/iv9n8BWVH2Sz5BxX0qz8sqJbI85M6ATNdvCxfzmylK7pjuL2GcOHmxMs+rTdTv
         mj65jkPNyxwG6irGaQjl+Nv84mVJ2/zhch5N+AuOMd4nvKPSchv3YW+s/WTryyvVYqIH
         12GXWv0x++qZ0n+Xjm8C/fEKCPkeL2rdF0rsrr7R5uo9BtK7exQdWMByRAVoEPRofPiW
         n6jy2zl+k0N96DuUD5/wiaEcI0Lq7i2br4U8YQjwRdSje15eKk/6B5hU73xn0B0Uw8bJ
         pi7Q==
X-Gm-Message-State: APt69E1FH5iHxGl1/x3/ykdImsSafH+RSx46mUhN8RHQypFBWqS0AkUE
        J8fBZ1nrjfwj1R61IiCP0GcynEJgUSbIXurqYgYJ0Q==
X-Google-Smtp-Source: ADUXVKJM40vzZ3jxnNVHretZLUGZQiPZ3spfzTV8qnj5o4+tiD/WsleNEWTmIJnLBeX+ADpNcN3bpvZ7Td6m6EzuhnE=
X-Received: by 2002:adf:dd03:: with SMTP id a3-v6mr3275514wrm.2.1528305534567;
 Wed, 06 Jun 2018 10:18:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:ef04:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 10:18:54 -0700 (PDT)
In-Reply-To: <CAPig+cRyv=JuGo+OfULuvbLrqRxoYZyBZDrSJrt5F8YRwzNn6w@mail.gmail.com>
References: <20180604201742.18992-1-asottile@umich.edu> <CAPig+cSzJ=2Zz7jRNB7sK7FyZ+YwdAFseCTSDbM_m4E8K9WxHA@mail.gmail.com>
 <CAPig+cRyv=JuGo+OfULuvbLrqRxoYZyBZDrSJrt5F8YRwzNn6w@mail.gmail.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Wed, 6 Jun 2018 10:18:54 -0700
Message-ID: <CA+dzEB=7tGeXduxdKrJpDpXrmNbb_ZnYg=CmByJ7J-w-iiyxsQ@mail.gmail.com>
Subject: Re: [PATCH] config.c: fix regression for core.safecrlf false
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 10:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 6, 2018 at 1:15 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Jun 4, 2018 at 4:17 PM, Anthony Sottile <asottile@umich.edu> wrote:
>>> +       for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
>>
>> Simpler: printf "%s\n" I am all CRLF | append_cr >allcrlf &&
>
> Or even simpler:
>
> printf "%s\r\n" I am all CRLF >allcrlf &&

Yeah, I just copied the line in my test from another test in this file
which was doing a ~similar thing.  My original bug report actually
uses `echo -en ...` to accomplish the same thing.
