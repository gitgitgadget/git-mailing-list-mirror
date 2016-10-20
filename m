Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC961F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 16:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755937AbcJTQaa (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 12:30:30 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35751 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755009AbcJTQa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 12:30:29 -0400
Received: by mail-qk0-f171.google.com with SMTP id z190so103743599qkc.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sk4vYEXd9DJCQAq3cEwWv6QgEQMobWHf8+06Qtp+HWc=;
        b=NLTNIOzbOMy+meQ+xqHAwhGxUdEGaidNBZ/gRl9KIJApgg8O+UVJ5RwZmBpzpINu2p
         MR6n6tRxBMbZuq1mtxljco8zg0Z+76lOGQyL2bkRPqGlfx68GV/g4iKsHsyOW4/tAm+o
         kJF4/jJcqnxxWF1PeaVVTYw9PZalP2fTSNbd+yeTEEZ9114eqw8eFy72+mA9T/plc5DB
         Dk9SD/e6/xcqsQEYb9ufvrDv6QmHIXpZv4Gpgg7cbIFxtmH9SfE6/aWjvOSp+O9Co80B
         EY/Xcx2Fb8offKWphv28Q/tiOhPb1OundB0f3PVbZ5LCDoDwiLtxUvUavPKB550sxG1N
         0Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sk4vYEXd9DJCQAq3cEwWv6QgEQMobWHf8+06Qtp+HWc=;
        b=LeQ1jC2YvSxUG1oaiZ32TCOyDT0RFJ2MiW7/IbjirY0LCdQqazDTIlEuEMrBNZbXo1
         MUulDHGOSt3/gRDeRcQhRhTCl1Hjd77JWL8mtXEm0VNT8Yh7XumZEt+ANps5RRff5p0v
         CcJvuKQqKgszdeTWJ6vk3CIbANv3Tu5ffTVKc+u/ctDVTSVSrbtmaALw0YyMYdJO2wjF
         3X4bLQEREoFzt/dsIyoWLC7FkquzwYQPGr1NE/QtqYNdh1rUE044Fc0SdvVArl4vPyaq
         88gXtzudaChFFwZgNhP9KFs1Koxj4SUapt9ehuYeiVEDeuvBRgM8rwEb/Vz4HKN7Xo1/
         o+3A==
X-Gm-Message-State: ABUngvdcZMoEegOx8UleGKD1f2T4xU3YKrXCDIS26OcRNYqECjmRt5ICCgMnrLYAoBbbYqFHmSpgJqQ0da7WzFHe
X-Received: by 10.55.142.130 with SMTP id q124mr1278814qkd.220.1476981027634;
 Thu, 20 Oct 2016 09:30:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 20 Oct 2016 09:30:27 -0700 (PDT)
In-Reply-To: <20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610201154070.3264@virtualbox>
 <20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Oct 2016 09:30:27 -0700
Message-ID: <CAGZ79ka_McRkOyKH3diCXJSdCm+4pNZfqAqJW_tQLFdhb26tRQ@mail.gmail.com>
Subject: Re: Drastic jump in the time required for the test suite
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 5:31 AM, Jeff King <peff@peff.net> wrote:

>
> $ perl -lne '/execve\("(.*?)"/ and print $1' /tmp/foo.out | sort | uniq -c | sort -rn | head
>  152271 /home/peff/compile/git/git
>   57340 /home/peff/compile/git/t/../bin-wrappers/git
>   16865 /bin/sed
>   12650 /bin/rm
>   11257 /bin/cat
>    9326 /home/peff/compile/git/git-sh-i18n--envsubst
>    9079 /usr/bin/diff
>    8013 /usr/bin/wc
>    5924 /bin/mv
>    4566 /bin/grep
>

I am not an expert on perl nor tracing, but is it feasible to find out
how many internal calls there are? i.e. either some shell script (rebase,
submodule) calling git itself a couple of times or even from compile/git/git
itself, e.g. some submodule operations use forking in there.
