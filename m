Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80186208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 18:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753723AbdHUSkT (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 14:40:19 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36748 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbdHUSkS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 14:40:18 -0400
Received: by mail-pg0-f49.google.com with SMTP id i12so104573393pgr.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMRXCYJaBsFu6qG9tfvztaqgNJVx6gS699RUMLmnQlM=;
        b=FIRCJHjTPrep/p+qqSyrBMFAKfdp6uybNzrlzXhQYcTnIYn+CYhN2RSZl5TtaI/VUg
         sL4jeij05mnbtc6GxEkFM55eMkHYnWWt07dDDUd8rgxlnHQeheliyHJIhKNbWri7fAP4
         bzpZaidwkfvLCz25ADFCtuRrcz4PhTMrWkPQETaiH5qCOBXq2oZCmabOtEVTVxchx9x7
         0GIhlROQ5jsH9wZTKRNG9ZJabau1u2kvAhkOm50+Dl9yXYv0T4TmeYUOBfZ0gCkoRjsI
         SnYj+bgzgxKV2kIFFi9A/7JcJL07PsKuhhbRUJPaRbE3ZZYpnfJGuTsRL5D6VIXGhFSe
         of0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMRXCYJaBsFu6qG9tfvztaqgNJVx6gS699RUMLmnQlM=;
        b=JT7ku0bwbVXAd0aWg+ZyEUOPjXyyt+P9KtKzflgayQds+6IstPU2COHAjQW892wriQ
         s7ZS5eIpC0GysT4FGmOPsj0e6I8Gky/rVrghnJsmJ9G9JDPQqifnTgdzM82PrSS9bBWv
         BvEba6hsfaPGk5p29RbkuOVjlaLCiQm/usjcoDLCDu8CrdyD43OZsh35aXC2n/JnLA+y
         5q22ZoBRfVIbG3aWXTPOwDKmmkd0/kwlPx3wnYRmZqXDWc3QPhYr+PHAA+a2AhLleSye
         o+guCwvGAu4JLW1LDwRV2zrVFMK6I5Ro+UXWLCeUf8TbEeQ9OLGshgKKBhKEZWyeuPDQ
         4ylA==
X-Gm-Message-State: AHYfb5io0E3i11AV4Nq2vFUA+axA8LJl8B8PwA/eINFS490nQZ0KYz4v
        j1fMgWtzzVh4yKQg
X-Received: by 10.98.93.200 with SMTP id n69mr967339pfj.218.1503340818135;
        Mon, 21 Aug 2017 11:40:18 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:5dde:7508:affa:68fb])
        by smtp.gmail.com with ESMTPSA id v126sm22583557pfv.144.2017.08.21.11.40.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 11:40:17 -0700 (PDT)
Date:   Mon, 21 Aug 2017 11:40:15 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: Re: [PATCH v3 00/23] Move exported packfile funcs to its own file
Message-ID: <20170821114015.30e1ab23@twelve2.svl.corp.google.com>
In-Reply-To: <xmqqd17q91y6.fsf@gitster.mtv.corp.google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
        <cover.1503094448.git.jonathantanmy@google.com>
        <xmqqk2209fm8.fsf@gitster.mtv.corp.google.com>
        <xmqqd17q91y6.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 19 Aug 2017 23:40:33 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I have to say that this was a painful topic to integrate.
> >
> > As you may know, the mk/use-size-t-in-zlib topic is being retracted
> > and getting rerolled as a larger size_t series, most of which still
> > needs help in reviewing.
> >
> > The jt/sha1-file-cleanup topic is the only one among the other four
> > that are still not in 'next', and I think that topic, as well as the
> > other three, are all good and serve as a good base to build on top.
> > So I first rebuilt your patches on top of these four topics.  This
> > took some time but it wasn't all that painful.
> 
> ... but it turns out that I screwed it up in at least one place,
> making Linux32 build fail (Thanks Lars and folks who pushed hard to
> arrange Travis to build all my pushes to 'pu').  I'm pushing out my
> second attempt.  Let's see how it goes.

Thanks.

> A change like this that only moves code around without changing
> anything is painful to everybody to keep around, as nobody can
> safely touch the affected code while it is in flight.  On the other
> hand, as long as it is only moving code around, such a change is
> reasonably safe, and it is relatively easy to ensure that there is
> no change other than code movement is involved.  So let's 
> 
>  (1) make sure that the topics this depends on are sound by
>      re-reading them once again, and merge them quickly down to
>      'master';

I took a look and they look sound.

 - rs/find-pack-entry-bisection resolves an issue first introduced in
   commit 1f68855 ("[PATCH] Teach read_sha1_file() and friends about
   packed git object store.", 2005-06-27), which already had that issue.
 - jk/drop-sha1-entry-pos is some code deletion.
 - rs/unpack-entry-leakfix ensures that delta_stack is freed. This
   function does not (for example) expose the destination of delta_stack
   to its caller, so it is correct that delta_stack should be freed
   unless it points to the local buffer, just like in the success case.
 - jt/sha1-file-cleanup (my patches) still looks OK to me.

In your latest "What's cooking" (Aug 2017, #04; Fri, 18), you mentioned
that the first 3 will be merged to master, and the 4th will be merged to
next.

I didn't look at mk/use-size-t-in-zlib, which (as you said) is still
under review.

>  (2) merge this topic to 'next', optionally after rebasing it on
>      'master', after (1) happens; and
> 
>  (3) quickly merge it to 'master', to get it over with.
> 
> In the meantime we'd need to refrain from taking code that touch
> things that are moved by this series.
> 
> I plan to be offline for a week or so near the end of this month, so
> I am hoping that we can do all of the above before that. That may
> make us break our usual "tip of the 'master' is more stable and
> robust than any released version" promise by potentially leaving it
> broken for a while, but nobody can build on top of a fluid codebase
> that is in the process of moving things around in a big way, so it
> might not be such a bad idea to make it coincide with the period
> when the tree must become quiescent due to my being offline.  We'll
> see.
> 
> Thanks.
