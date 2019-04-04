Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC65320248
	for <e@80x24.org>; Thu,  4 Apr 2019 08:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfDDIaw (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 04:30:52 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:33232 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfDDIav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 04:30:51 -0400
Received: by mail-ed1-f46.google.com with SMTP id q3so1413051edg.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6cZKAYPM4S+BQHr3wD6SOpwYCMmH6zpgtX+NTekErgk=;
        b=qqMrE0RfuXj9T5jZqThypLCmgZENRMEKjkM9Ws05FzZ2IsXhzPhw+VE3fg9AQeD2U+
         sJToB+L30Jv7hTyowpl9SHQCcU7yG/rdapBWvy0i64KoBilfOJ3vrqvRqXEeuaQhxFce
         IHngliChOxToz4QDh7NzCzPKqiYPzZb48DGjCE16LY8G0T6pzmnsPnNyKjEpuFrVVI6m
         JHny1IP91VgCP7beRlk2t0PUyQlah2gT0h/fC1UhJiNfQjCORB9aZw81NrAbxnVO2MQW
         J4JW7AEsXFXNS+DRrwGuiwmwQRRAWLIChUlnXguTAfHxw4FFT/r4aTWCF5nMp0qRGijy
         LjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6cZKAYPM4S+BQHr3wD6SOpwYCMmH6zpgtX+NTekErgk=;
        b=WCP7USM5ig8MQQIKtgNcH48iMSQRrnnh4ko5Wl78D7Ptcg1sLqqC3WBcvGVBK4tDN2
         wJqxynntiYo6D/yvj427MGTIbNTykbAVGzPU9Tr8q4Cqt21XZO6F20NL72gsRRLwmc+k
         jW8cba8LedJnFnoarmw19dcqmuP0AFHsa843l0nZtbBW5TFk1UOnoiAwNIWz91YiOVGh
         h8XzrLo0ZcztqEp2+8YxWt0L1GIbEMyu4jHLk8Cf7WgI0XOJYj90CzAdOVpE4z7hsVdM
         B+eU4/iit1ZKZGVFlPiQshWwkYmC1HL9AozHUvwc/aatIGza1wf8CoKa/HPZ5MwQBS7N
         3fBg==
X-Gm-Message-State: APjAAAX6/0kLUGMwpgg9iMrUdzrD4jJJRWpVyNSYY1AapPCNlfhcWURY
        d/fIYqHy5UYEMFHlkEF/eTbrRE3wxx+Pn+FVILg=
X-Google-Smtp-Source: APXvYqwjs9hYrSC+BHluDorPRT10J6rcuM+ADYwKkQgXPX0EjqEF6rrGOOxVvzNjf0Bw4HltKWn/Kh179vU8prE4qhM=
X-Received: by 2002:a50:a90d:: with SMTP id l13mr2912857edc.45.1554366649911;
 Thu, 04 Apr 2019 01:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8q83SifH-7mKOet-Uuf_KHCqvO2mkxiZgEyQhoNRhshFG_Lg@mail.gmail.com>
In-Reply-To: <CAD8q83SifH-7mKOet-Uuf_KHCqvO2mkxiZgEyQhoNRhshFG_Lg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 4 Apr 2019 10:30:38 +0200
Message-ID: <CAP8UFD2z2au=Ftx828++kziwcEV+FaRrVJd4rqMw-N3=w5DN=w@mail.gmail.com>
Subject: Re: [GSoC][RFC] proposal: convert git-submodule to builtin script
To:     Khalid Ali <khalludi123@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Apr 2, 2019 at 10:34 PM Khalid Ali <khalludi123@gmail.com> wrote:
>
> My name is Khalid Ali and I am looking to convert the git-submodule to
> a builtin C script. The link below contains my first proposal draft
> [1] and my microproject is at [2]. My main concern is that my second
> task is not verbose enough. I am not sure if I should add a specific
> breakdown of large items within the submodule command.

There was a GSoC project about the same subject a few years ago:

https://public-inbox.org/git/CAME+mvXtA6iZNfErTX5tYB-o-5xa1yesAG5h=iP_Z2_zL_kOnQ@mail.gmail.com/

I think you should take a look at the work that was done (merged and
not merged) and report about it in your proposal.

Thanks,
Christian.
