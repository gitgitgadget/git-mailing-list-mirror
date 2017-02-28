Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA33A2022D
	for <e@80x24.org>; Tue, 28 Feb 2017 08:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbdB1IIX (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 03:08:23 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35303 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbdB1IIW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 03:08:22 -0500
Received: by mail-lf0-f49.google.com with SMTP id z127so2040217lfa.2
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 00:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZkGY6Om682gLHL21REjnl2NGf0yjzIk8YTXX016jlb0=;
        b=iAd9IlEgbugH8CTpJX9ZUWYYXKTF3Vmioo+g3WbGG1XbsRRsFvT8Bog6UL3KDYaamE
         Hs0FaQ/j67qpP7bmTBmmSg3tR/Rnpnw9reReWDGjIOrY6xCF8reO3BzdhBQwCDp9AB7v
         OwqpatpJvDf6fGdsvSPxJqKq8wvmkumdD/XUU8aYDLKQTal19GjLThwOls71b27TNRV0
         wlt1+0BkSLCOXfMaQ18+J2VLhX515zwKa8En5TK62ZmuY7fkPdKhzq+ZYqLP5RMzFnUj
         Cx9GKbcTVCg5cizpJbHeRrpDdJOO3I8p4Qguf7Qe/mbYnh+4M66yn6gqtCrcbXmeomJe
         hlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZkGY6Om682gLHL21REjnl2NGf0yjzIk8YTXX016jlb0=;
        b=Ow6ck4geKCSszxLcDFiK09fcEbxvwHjCo/X1+8plN0/E/c0wPHMAEToxZTCnK4ldh6
         lJpcwNPslK5tRpn5USEN2RspWPPsn8T9HszdPPmEUZ+BPVkp0SDjYDStntpnFcGvw6Td
         WzHwI28a+P/8Ox5FLfSrGr7DM/KOOacEQDmaIXmoVOc8lgmm5X4oM2Asn0dV+k92jZJ1
         bhhdiuOXxtUYebw2ex/wVnZJjYEKZC4PXy5/D/YpaZylHbxiFmKmoldgogMauChJMZmK
         uSxQHLF1VMAAZB+WMiMlZU3GJIWk8nVXgTi8OnQXvTqqthv5oFMV9aqCUtpvWaxzuYlm
         eqUQ==
X-Gm-Message-State: AMke39k0bHc8ukEE+o9ReaIgOLI87MQdIZ1K9AKSeoSCPW8LjebZj2nK+CR/58oTh9ZJQ4DY6zu0q01OWBrrzw==
X-Received: by 10.25.79.69 with SMTP id a5mr352974lfk.58.1488268741351; Mon,
 27 Feb 2017 23:59:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Mon, 27 Feb 2017 23:58:40 -0800 (PST)
In-Reply-To: <20170228005302.k6fyfinaxyl3ti76@sigill.intra.peff.net>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
 <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
 <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net> <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
 <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net> <xmqq60jvnu9y.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xpVt6NtSajqMX8OQ_SKdC9tfHH40JgK=9DgBxo9nMaWLA@mail.gmail.com>
 <xmqqzih7kvbz.fsf@gitster.mtv.corp.google.com> <20170228005302.k6fyfinaxyl3ti76@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 27 Feb 2017 23:58:40 -0800
Message-ID: <CA+P7+xp_w_BmkbDA03vRCg8JEmLkgd1_WbmtsBskpV0EarXejQ@mail.gmail.com>
Subject: Re: [BUG] branch renamed to 'HEAD'
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 4:53 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 27, 2017 at 04:33:36PM -0800, Junio C Hamano wrote:
>
>> A flag to affect the behaviour (as opposed to &flag as a secondary
>> return value, like Peff's patch does) can be made to work.  Perhaps
>> a flag that says "keep the input as is if the result is not a local
>> branch name" would pass an input "@" intact and that may be
>> sufficient to allow "git branch -m @" to rename the current branch
>> to "@" (I do not think it is a sensible rename, though ;-).  But
>> probably some callers need to keep the original input and compare
>> with the result to see if we expanded anything if we go that route.
>> At that point, I am not sure if there are much differences in the
>> ease of use between the two approaches.
>
> I just went into more detail in my reply to Jacob, but I do think this
> is a workable approach (and fortunately we seem to have banned bare "@"
> as a name, along with anything containing "@{}", so I think we would end
> up rejecting these nonsense names).
>
> I'll see if I can work up a patch. We'll still need to pass the flag
> around through the various functions, but at least it will be a flag and
> not a confusing negated out-parameter.
>
> -Peff

Yes, this is pretty much what I had imagined. I look forward to seeing
the patch.

Thanks,
Jake
