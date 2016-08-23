Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02D31FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbcHWR4k (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:56:40 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:36643 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbcHWR4j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:56:39 -0400
Received: by mail-it0-f53.google.com with SMTP id e63so162830705ith.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Opbd1wtVifPremjzPENcQwj8nYmrNR6AsZZMQZjQEyg=;
        b=QYqUqtLRgd1BcldjsoqTXAnD8ZTZ+3mB3jZHR0xVM5E1KsQnSv1lxYqSxkvBGPM6T3
         eXQMa9QhKniVsYfacsd+HOCc5OJm+AdZWezetIenKw419zHS+W56C3Ym23B9+dXr1gsu
         5Cxe8g/+ceaip/sSmRGZVz5ZpyaKYGCz31ia455sPmBq2RtqgW9wyjoGMjfozcYs3Dgs
         n8/bOEBnTAiP2X79OoPrXEL2UpC6G4ERPfI5O/lJWD3vC5FxEU6JrI3+PakKWsDoAGjc
         kW/6ws+bY804aqZihT1GjDjs8O4accSNw/ezTDq4yqY4cVIDX+BOt/gGwh2t/uO9Ih/9
         ++gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Opbd1wtVifPremjzPENcQwj8nYmrNR6AsZZMQZjQEyg=;
        b=P/skCqcB/dxCp1qwS5UZ1oVcj1CAR5M5soH0AqcOE7DdpK0B0q84QxzL6+0Bh6xRaz
         7LPcEeAmwHUkn30Gi78UjJyXq8Fy4mMnFClVGh7KGQ6SmkIaLtwgY9w7eyGx9Qz23KKu
         uLfv7uWwo2eoaMugQV6ADCxJQzdNtiOnPDP52gpbgDEFMPYGyRGrsorGNC+JwnAO/waB
         ZAxqEwu2/YE1VPXYN1lfMWN+MDn485ygEslEwmJE0/J3zQkgAHcozxHBktgOJG3flp9A
         tsODdRsxqo99gIcgw92emI85/5sljDYR0VsLu3SPOqIKZQYHLehS4cbq/IlVPnSKviKi
         zQZQ==
X-Gm-Message-State: AEkoousXYc8IdoeTKH3nfSfoIOGXVuJIgedBJaqTbMAMKdJl4oMZoXxYGJ6yaxbe6eM/8NSLGuXgNzn/rvIRxPfo
X-Received: by 10.36.127.7 with SMTP id r7mr27974208itc.49.1471974465861; Tue,
 23 Aug 2016 10:47:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 23 Aug 2016 10:47:45 -0700 (PDT)
In-Reply-To: <xmqqlgznwg6o.fsf@gitster.mtv.corp.google.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
 <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com> <xmqqlgznwg6o.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 Aug 2016 10:47:45 -0700
Message-ID: <CAGZ79kbsq52Qh0Jtn5hpPPfHu_9r2CUHvAHOTh6Cgz8ODkzreg@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] submodule inline diff format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I am not so sure about that.  If there is an existing place that is
> buggy, shouldn't we fix that, instead of spreading the same bug
> (assuming that it is a bug in the first place, which I do not have a
> strong opinion on, at least not yet)?
>
> Can there be .git/modules/<foo>/ repository that is pointed at an
> in-tree .git file when there is no "name" defined?

If you're holding it wrong we can come into that state.
* Checkout the submodule,
* then remove .gitmodules as well as relevant config in .git/config.
Result: Then we have a only a gitlink recorded as well as connected
working tree to a gitdir inside a superprojects .git/modules/.

> I thought we
> errored out in module_name helper function in git-submodule.sh when
> we need a name and only have path (I just checked in the maint-2.6
> track); did we break it recently? submodule--helper.c::module_name()
> seems to error out when submodule_from_path() fails to find one and
> will segfault if it does not have name, so it is not likely.

The name is literally the only thing that is not optional in a struct submodule
(see submodule-config.c:182 In lookup_or_create_by_name, these structs are
added to the internal cache.

Stepping back a bit, I think we'd want to document this expectation more
in the man pages
    The name unlike the path of a submodule must not be changed (as the
    name is used internally to point at the submodules git dir)
