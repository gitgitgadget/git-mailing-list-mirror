Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35623207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 21:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbcJCVXU (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 17:23:20 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38348 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbcJCVXS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 17:23:18 -0400
Received: by mail-it0-f44.google.com with SMTP id o19so110062084ito.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W0UtMuQ1UOYj29SrN2SEJDOL42GTQbjHdLB4zjiSh8Y=;
        b=A/PkZf6kSSFfp36eR2zNikSthDa59j+VscmuZH3KPNfUBOgUD/eIklZSYfEOMdK0fm
         sL6T0lTPhHFG+4maDEetQFDnNeHcr99QlWELXx7Ajdw6mkOOI/fHXEkT0fyiO9+KxI16
         TClimwhzEzVIFJ9ovkvNvw4M6ndl8tkdyL+ABaigPIoyYVAHy5RL0C6H478+XGSEbdoN
         6DcqK8zN875QYxF+b+FAyio4S7F+Sy3FLC+kaBkK+kh6qt1LpJ2HzfniSz0znmhUED8S
         y3T+fig/GwLc3r/KWxMxGtk6PWrk+zKJopOLEAJIxRVZEgzg4/PA7BbwnfKv9CVB7DDt
         k4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W0UtMuQ1UOYj29SrN2SEJDOL42GTQbjHdLB4zjiSh8Y=;
        b=DKi0eO/3NjO2ETe/ObkwoHfdEENPwFYgRc/XtddadjGKQqA6cwvVVtVmR5DDrvdMDT
         WGz0s/BTdkF+Kuw1vkV50QtEdDAHMHUl6vFs6+i15RiEPYHRZWNzlqrSqqWqGsVH/oMf
         bfrZ40/FkzmtaebynewNZbQOdNWJgFjTgs5hXavl0n/jBHx97kgvoTrFh6wOdalvFkzY
         m+qzYEO4YocC0lAR++2TO8aX25vJXW8AF1nqnI1uCZcPlHAD2+tlvyN9cF1CwK0codCv
         79UrBoMMbM5zeQrN8sKYq3crM6EtTwTaJteBLyvkstd9WF5E2/+gGf/PpCW0tCp9C/n2
         pbLA==
X-Gm-Message-State: AA6/9Rk9qD55e6sUYRK6fcJW1YjgA1YuNqH910PZxJSOoQT7834be8ma4wGjMRg3UARdQkgF72W0YJcUShQ/FJ/i
X-Received: by 10.36.192.193 with SMTP id u184mr18103575itf.91.1475529797542;
 Mon, 03 Oct 2016 14:23:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Mon, 3 Oct 2016 14:23:16 -0700 (PDT)
In-Reply-To: <CAGZ79kYXx+a+U3o6FPBy2mHOy4BxxuF97t6iyedPLk0Qw1Jx1A@mail.gmail.com>
References: <CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com>
 <CAGZ79kYXx+a+U3o6FPBy2mHOy4BxxuF97t6iyedPLk0Qw1Jx1A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Oct 2016 14:23:16 -0700
Message-ID: <CAGZ79kY6FpTD1VJQ=+wJ0FrXe9LjJ=NBwLsOku0R4FerAmQGJQ@mail.gmail.com>
Subject: Re: Slow pushes on 'pu' - even when up-to-date..
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Heiko

On Mon, Oct 3, 2016 at 2:17 PM, Stefan Beller <sbeller@google.com> wrote:
>
> * sb/push-make-submodule-check-the-default (2016-08-24) 1 commit
>  - push: change submodule default to check
>
>  Turn the default of "push.recurseSubmodules" to "check".
>
>     Will hold to wait for hv/submodule-not-yet-pushed-fix
>
>     This reveals that the "check" mode is too inefficient to use in
>     real projects, even in ones as small as git itself.
>     cf. <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>

So maybe we should eject this series from pu as long as
hv/submodule-not-yet-pushed-fix is ejected to enable you
running pu happily.

Thanks,
Stefan
