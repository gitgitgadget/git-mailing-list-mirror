Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F8120281
	for <e@80x24.org>; Fri, 29 Sep 2017 19:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbdI2TFA (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 15:05:00 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:46679 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbdI2TE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 15:04:59 -0400
Received: by mail-pg0-f49.google.com with SMTP id v3so278971pgv.3
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 12:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4l/VH7pKe5H6s7XNygiCBPUm2pqq/3BsgxrbbzcYWYQ=;
        b=TMNAv+MONrB9BSH5JzqNqobmj7gBLwq1U17ZdEKWUCvL0a+jL/IPEDovVCSFSM8Oha
         Acxf1KGxbx/p+TArlwM+HYKOQB+uIUfNQAC0DmOYPLnnQZco3Mob5VeAICUliZl2FoH6
         JCmaA+aKuF/tu2yx75MuWiSlLUCTXPu5ejFGuNhiQNCgKiReVLgg6M+fCz84WIyPTtsu
         xEolwENtZ6j0JmXZGXL5KBneGQVQ6bzM55Jwel7Z6seQ7uRikd6IQkpaDm7nHk9MQfVo
         01qQ25Nm1zE5Q1UaE6VyCNICsP4nI9gdmEWImKJEBVbU2MOnv/yua3BdSFCrYTRYxkWt
         nh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4l/VH7pKe5H6s7XNygiCBPUm2pqq/3BsgxrbbzcYWYQ=;
        b=fOJl7SobJP78e+PC2DaO7uGvVuW1n24JwXueLTnDWeLmwmfamZpRDUSaPSoo1hjgwW
         KLyqc4m2DcyeZGGGgKehydQDORALgPw8d+VvVXSOnBiot/615sLkC2aTJyMNBsAIc26r
         3VR7GWUaHr3N/YOQoGWkLVp3Eco41aY1I8vXBL/hcZASOdBbmpRG9nV7mDxOBC/3fzhn
         fTXjOdF1v5ISmL0zphf61zXF4E9ua5uWxl9BeydL+bc3lcy34p73EbJf9JXX57Ite/Xo
         n7Aj9yZCe2bTuA8eNWd4kiKSYQffk2d+lyEEwJ6Z+MsMNiRdfiMKAc1REhm+6t2EPOU5
         lJBw==
X-Gm-Message-State: AMCzsaV6Q5NeModutFQO0yYy/FT0GiCkO6Hr9Koo3xauNydUckOsmLXh
        DEv3wLt33q2+YQx7ugBMAhS4KQ==
X-Google-Smtp-Source: AOwi7QCGwcP+G0GK6+HgaDSyVZRZLAu9mRYUc0f+CFpkSPeGXz3SVAFngg6VjIvFB8Le6MI7HuyXFQ==
X-Received: by 10.98.58.157 with SMTP id v29mr147356pfj.5.1506711898362;
        Fri, 29 Sep 2017 12:04:58 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:90bd:4d6a:ace4:8d67])
        by smtp.gmail.com with ESMTPSA id w134sm7997464pfd.186.2017.09.29.12.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2017 12:04:57 -0700 (PDT)
Date:   Fri, 29 Sep 2017 12:04:56 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH] oidmap: map with OID as key
Message-Id: <20170929120456.3bb8021de1c7aebee7bb5026@google.com>
In-Reply-To: <20170928200556.grysihlj7cbzocfq@sigill.intra.peff.net>
References: <20170927221910.164552-1-jonathantanmy@google.com>
        <20170928004137.GD68699@google.com>
        <20170928104616.be61b394b50dc5193be275be@google.com>
        <20170928200556.grysihlj7cbzocfq@sigill.intra.peff.net>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Sep 2017 16:05:57 -0400
Jeff King <peff@peff.net> wrote:

> When I saw that you were implementing "oidset" in terms of "oidmap", I
> was all ready to be crabby about this extra memory. But then I saw that
> the implementation tries hard not to waste any memory. :)
> 
> All of which is to say I gave this some thought when I was in the "ready
> to be crabby" phase, and came to the conclusion that it probably isn't
> that painful. An unused pointer is 8 bytes per entry. We're already
> spending 20 for the oid itself (which is likely to grow to 32
> eventually), plus 8 for the chained "next" pointer. Plus potentially 8
> for a padded version of the hash, if we just use a straight hashmap that
> duplicates the hash field.
> 
> So depending how you count it, we're wasting between 28% (sha1 and no
> extra hash) and 16% (sha256 plus reusing hashmap). That's not great, but
> it's probably not breaking the bank.

Hmm...how did you get the 16% figure? The values, as I see it, are:
 - 32 for the sha256 hash itself
 - 8 for the "next" chain pointer
 - 8 for the padded hash
 - 8 for the "util" pointer

For an oidset, the padded hash and the "util" pointer are wasted, which is
16/56=0.286. (If you assume, say, 8 bytes of malloc bookkeeping overhead, then
16/64=0.25.)

For other uses of an oidmap, the padded hash and "util" pointer are still
wasted, so the numbers are the same as above (except that the malloc
bookkeeping overhead is doubled).

> Another way of thinking about it. Large-ish (but not insane) repos have
> on the order of 5-10 million objects. If we had an oidset that mentioned
> every single object in the repository, that's 40-80MB wasted in the
> worst case. For current uses of oidset, that's probably fine. It's
> generally used only to collect ref tips (so probably two orders of
> magnitude less).
> 
> If you're planning on using an oidset to mark every object in a
> 100-million-object monorepo, we'd probably care more. But I'd venture to
> say that any scheme which involves generating that hash table on the fly
> is doing it wrong. At at that scale we'd want to look at compact
> mmap-able on-disk representations.

In a 100-million-object monorepo, we will probably end up only operating on the
"frontier" objects (objects that we do not have but we know about because some
object we have reference them) at the worst. I don't have numbers but I think
that that is at least an order of magnitude less than 100M.

> So I think we may be better off going with the solution here that's
> simpler and requires introducing less code. If it does turn out to be a
> memory problem in the future, this is a _really_ easy thing to optimize
> after the fact, because we have these nice abstractions.

Optimizing away the padded hash should be straightforward. Optimizing away the
"util" pointer after we have code that uses it is (slightly?) less
straightforward, but still doable.

I still lean towards saving memory by eliminating the padded hash and
not using the "util" pointer, because the complication is contained
within only two files (oidmap.{c,h}), and because the constant factors
in memory savings might end up mattering. But I don't feel strongly
about that - I think any of the oidmaps that we have discussed is an
improvement over what we have now.
