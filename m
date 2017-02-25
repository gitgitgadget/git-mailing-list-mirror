Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74B120279
	for <e@80x24.org>; Sat, 25 Feb 2017 02:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbdBYC1D (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 21:27:03 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35800 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdBYC1C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 21:27:02 -0500
Received: by mail-lf0-f54.google.com with SMTP id z127so15594986lfa.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 18:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aG/OPsyQM0C3YjAp8yUcBplq/FRbVQ45pSVwYeRXwCA=;
        b=GVfkInBaVrhI6T+VUyOYyhej8wciXvWGWRQ00vlsd8PVBWHID0Pdkmwlv1x5knrZLa
         9lsXnVxeC9/tFSPfM/9wVTLOCv8ND9G3Q8v8vqegNfFH2OvA+OwDpp7lBvVKxNxbZLJ+
         wgXUqhaCTIn4NOs7wK7x1MIAhIWQVd7IMVdZehoO6s039m+a9TEerR2AomMlXKZ6hpY5
         QWzcKL2Izr9tAe5gFZqDmC7c9M03X+VfD7L/OCzYYNXDBSs/E8oFTJNJ3HovVhVA5DLg
         lGr4212i0v9SNYZQnIiSxn5FGVpy6NsIqu/ryo1TA65V3VZjwJ9kLOLQs0wgRCMSIVgm
         RNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aG/OPsyQM0C3YjAp8yUcBplq/FRbVQ45pSVwYeRXwCA=;
        b=M9ArG+F53J45Qx4gkryKQJOz3Azbx+KobI+RFN9lbgyIhgxKbU5Rca1tXxFmyyiVWd
         f/QMxVWsCHn7h23en/Mzg2SpQ0F7Wqy9CSsUw0kU3cxUhU3eKBStMquxyiybtsy8KTmq
         XkM1zj1iOPbKCT57X9u4iBUZ0t58WV0UYXR//y2Py5womYiSjdPRkprQf4aBKhhxbBRz
         YI9GAt46lg/ScdkaIQsH1Eb1Y/rr9tgYQ7sdnBafOe/tVD277HsxCGmz5Dw7/CpjOSKh
         SHPAYsmMuZeYsPdqI3TOubd1ZG+FyEmfY4uaW/wzz9aNxCJXPDqA51SrpuSTum0mhjkf
         YkSg==
X-Gm-Message-State: AMke39mlw2L7VNUKhuJHrhgMSVk7lrZCoJqzKsizxfdcx23vGmarfF1oPDwYGkr8I4I5A5JRc2lSGStZsbB0OA==
X-Received: by 10.25.21.214 with SMTP id 83mr1674063lfv.66.1487989620856; Fri,
 24 Feb 2017 18:27:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Fri, 24 Feb 2017 18:26:40 -0800 (PST)
In-Reply-To: <20170225012100.ivfdlwspsqd7bkhf@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <nycvar.QRO.7.75.62.1702241656010.6590@qynat-yncgbc> <20170225012100.ivfdlwspsqd7bkhf@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 24 Feb 2017 18:26:40 -0800
Message-ID: <CA+P7+xqyaWHBxug0BPdCgDVJBLtsvUxbgfgy1uJcoGf3q6xMQg@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Jeff King <peff@peff.net>
Cc:     David Lang <david@lang.hm>, Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 5:21 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 24, 2017 at 05:00:55PM -0800, David Lang wrote:
>
>> On Fri, 24 Feb 2017, Jeff King wrote:
>>
>> >
>> > So I'd much rather see strong rules like:
>> >
>> >  1. Once a repo has flag-day switched over to the new hash format[1],
>> >     new references are _always_ done with the new hash. Even ones that
>> >     point to pre-flag-day objects!
>>
>> how do you define when a repo has "switched over" to the new format in a
>> distributed environment?
>
> You don't. It's a decision for each local repo, but the rules push
> everybody towards upgrading (because you forbid them pulling from or
> pushing to people who have upgraded).
>
> So in practice, some centralized distribution point switches, and then
> it floods out from there.

This seems like the most reasonable strategy so far. I think that
trying to allow long term co-existence is a huge pain that discourages
switching, when we actually want to encourage everyone to switch
someone has switched.

I don't think it's sane to try and allow simultaneous use of both
hashes, since that creates a lot of headaches and discourages
transition somewhat.

Thanks,
Jake
