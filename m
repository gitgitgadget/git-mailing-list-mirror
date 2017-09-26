Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 486EE20281
	for <e@80x24.org>; Tue, 26 Sep 2017 17:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031087AbdIZRc4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 13:32:56 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:46234 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031084AbdIZRcy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 13:32:54 -0400
Received: by mail-pf0-f173.google.com with SMTP id r68so5873892pfj.3
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKnXzCmID2nFSQdCpmsKlHPMDdi66iZ5IH+EuacU7TA=;
        b=uodd7gDKrLZttsqv1zLv3BF56b2ucs16HheotmpBwtMaFqbk+Bp59W0U1qwEw1+VtV
         vmcI2Y/V3o5yo6Wdd/pjQLq1ydl4COjeal8aE++iVHRcFmJLZFaCSapPXI6fhpCm566N
         ey/CcOWO/4QqMotyAc0GUM6Gi7yhfGYUj7ueoqt4RhNusmghY7J4M0mwqLsPLRFfCn9Y
         tb0NXqtoNQL+4J17mbBwe0uLC7AUJUH2X9UBbVQYCQF8dT6d5CM2oJiQqxZ28JNzQvY4
         BOLJj8mg3pbUj6TIMvrWD/EKRshb6ooWkianrMhDqLmsSyD6ddDnNDQ7PlZn8y6N7XP8
         Lfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKnXzCmID2nFSQdCpmsKlHPMDdi66iZ5IH+EuacU7TA=;
        b=fZh9qKBepasVqUWWQQ4PlARPTm6CpupbIGrxX2BJRcuhOVAt9hcPob36KkwYvpf1lS
         SIyS1oF7I+uJXC1bY1jsq87j16GBCZBjl+qrjinv1mgKAAN8rvXxE2My4zDW5p83gF1O
         FllRtRaq08NKUqq28m9vnvij85fyT/iSTEw3AwOv6ovSzL3PeGK4Qj5smfFjtkr+jXSu
         HBbOogxsytjlxMR0S6FDIvWgN6IFf15CGfFjBmSooHHm2Q71oNPyA8/axlEsnnSb1rgw
         fXRdJXgn32qNVu92OvCzDMfk887F6pnmGf63JztMrcMeMGKouo4TNuJ+hX4PwxGIPCtC
         aTLA==
X-Gm-Message-State: AHPjjUgo09RWqWf/vASI5RS5KImE98bsGg+G9FwPc0/LNZ0+ejo4iA+d
        t2hSmUndsFE6EOCfy++0rfHiwA==
X-Google-Smtp-Source: AOwi7QD5dBEcE/Q02DcdJrqyNjCrtxansqFxqcC/nop1MDgNli5MzZF/0SEULo7NxK+uvi1k8WMfHA==
X-Received: by 10.99.55.85 with SMTP id g21mr11737431pgn.306.1506447173762;
        Tue, 26 Sep 2017 10:32:53 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:6046:dda3:c5ad:1d0b])
        by smtp.gmail.com with ESMTPSA id s62sm18140737pfe.91.2017.09.26.10.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2017 10:32:52 -0700 (PDT)
Date:   Tue, 26 Sep 2017 10:32:52 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: RFC: Design and code of partial clones (now, missing commits
 and trees OK) (part 3)
Message-Id: <20170926103252.8330a266cf450e64dee27500@google.com>
In-Reply-To: <e05a7978-c312-9e26-79a2-fca3ae44f59a@jeffhostetler.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
        <af717446-95bf-c5a5-cd27-aaf20531db0f@jeffhostetler.com>
        <20170921160416.1c4c6e2c@twelve2.svl.corp.google.com>
        <7977bab0-09c3-0e43-4d6f-f2bf87a3fd9e@jeffhostetler.com>
        <20170922155802.ab79717818578a23cc31f6fe@google.com>
        <e05a7978-c312-9e26-79a2-fca3ae44f59a@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Sep 2017 10:25:16 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> >> Perhaps you could augment the OID lookup to remember where the object
> >> was found (essentially a .promisor bit set).  Then you wouldn't need
> >> to touch them all.
> > 
> > Sorry - I don't understand this. Are you saying that missing promisor
> > objects should go into the global object hashtable, so that we can set a
> > flag on them?
> 
> I just meant could we add a bit to "struct object_info" to indicate
> that the object was found in a .promisor packfile ?  This could
> be set in sha1_object_info_extended().
> 
> Then the is_promised() calls in fsck and gc would just test that bit.
> 
> Given that that bit will be set on promisOR objects (and we won't
> have object_info for missing objects), you may need to adjust the
> iterator in the fsck/gc code slightly.
> 
> This is a bit of a handwave, but could something like that eliminate
> the need to build this oidset?

This oidset is meant to contain the missing objects, and is needed as
the final check (attempt to read the object, then check this oidset).
Admittedly, right now I add objects to it even if they are present in
the DB, but that's because I think that it's better for the set to be
bigger than to incur the repeated existence checks. But even if we only
include truly missing objects in this oidset, we still need the oidset,
or store information about missing objects in some equivalent data
structure.

The bit that you mention being set on promisOR objects is already being
set. See the invocation of mark_uninteresting() in rev-list.c.
