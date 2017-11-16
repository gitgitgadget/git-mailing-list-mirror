Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59329202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 20:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932754AbdKPUn6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 15:43:58 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:46333 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759152AbdKPUn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 15:43:57 -0500
Received: by mail-it0-f49.google.com with SMTP id r127so1556758itb.5
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 12:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hTbtZMEfmoB2joEr3nabtix/e6zHakhC8is9SaEx5Co=;
        b=V1DZOcajivDTZDaYzRoH1FYTgJ9vkeSQCwVxnyojgQu46/wg6K2qmb9kUydwbrqU+L
         MtvZ+aAWbQ6OYEP9W9hMUK4UPiMluLnz092futEYUzD5sRyIeNxFrhw+nbFlwkXQLebY
         gXwmQIjZpc67hlbSba7vlZm5hrNq8mc2VqYbjuRhaeEUbrZzzOzaEyGYlRYKraqCwhKD
         F03rasH3Nj4A5jS7qpC/2Wfv5TZlbLSXpCZJ8Q7XKFWYGNPnivxgR/vWaAy38tVEQD3W
         ebr9ZfFlNvVvuWGqYGL7Xg4kAZ+z4F3hgqSeIJlph3JptdtMX1c06DIIPT0ZU9qL0NhH
         iiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hTbtZMEfmoB2joEr3nabtix/e6zHakhC8is9SaEx5Co=;
        b=oQeSh1VemTB8DRBAxb6/JqjTvyuRAZAYxIcpAdD3MXKnK5baBvjhcJzTVmxw9s6O7a
         foJ7puRN0aFb6tLrLUtWMr9yFe7w7Cr+39OAL5KZH9xcjwlVZLuCqnorU45vaO+5xrCN
         ziZStYgVbkmRzCdElV5c0G/5vtDHFxlJknhdEZFYpmj60Rl1msKGLvKF8FaVbh+kjIvV
         TnU6VnNDbCqCY+dRKgF9YERYhVvb9JeHcNimi/+/Tavn3kG61i6VUbKXP0RQNDJKHrE7
         yXYuqOuYot1IeT4b7cJRorkik2WCW12Q6g2pWDjGLJk3Dd0/NfQpHsaNNQMvjjuzRqi0
         dg9A==
X-Gm-Message-State: AJaThX7twG11YUMk/+WY0W/WzFVCAGwdZrecoJpb2OmqafOENxdoOYDl
        ezbpz+0q3KExetyEpGwO5awiUw==
X-Google-Smtp-Source: AGs4zMb7LGvspNj1KqmXciPz0d0RNvVVl5ZRLs6Y3D3o8WCTmlf3n//DPY7J2qLwcMyVf0Psz4RLoQ==
X-Received: by 10.36.79.10 with SMTP id c10mr3650639itb.146.1510865036526;
        Thu, 16 Nov 2017 12:43:56 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:28fc:a358:3592:211f])
        by smtp.gmail.com with ESMTPSA id e82sm871463iof.34.2017.11.16.12.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 12:43:55 -0800 (PST)
Date:   Thu, 16 Nov 2017 12:43:54 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 5/6] rev-list: add list-objects filtering support
Message-Id: <20171116124354.3d800cc27dbe3ea668c64519@google.com>
In-Reply-To: <20171116180743.61353-6-git@jeffhostetler.com>
References: <20171116180743.61353-1-git@jeffhostetler.com>
        <20171116180743.61353-6-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 16 Nov 2017 18:07:42 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach rev-list to use the filtering provided by the
> traverse_commit_list_filtered() interface to omit
> unwanted objects from the result.  This feature is
> intended to help with partial clone.
> 
> Object filtering is only allowed when one of the "--objects*"
> options are used.
> 
> When the "--filter-print-omitted" option is used, the omitted
> objects are printed at the end.  These are marked with a "~".
> This option can be combined with "--quiet" to get a list of
> just the omitted objects.
> 
> Added "--missing=(error|print|omit)" argument to specify how
> rev-list should behave when it encounters a missing object
> (presumably from a prior partial clone).
> 
> When "--missing=print" is used, rev-list will print a list of
> any missing objects that should have been included in the output.
> These are marked with a "?".
> 
> Add t6112 test.

The patch itself looks good, except that I have a nagging feeling about
the usage of the term "partial clone" in the commit message,
documentation, and test description. I feel that the usage here leads
one to believe that partial clones haphazardly leave repositories
without random objects (and at the point that this patch is merged,
there will not be any patch in the main repo contradicting this
viewpoint), contrary to the fact that we will have a tracking mechanism
to track which missing objects are expected to be missing. (If I'm the
only one feeling this way, though, then I'll just let it slide.)

If it were up to me, I would remove all existing mentions of "partial
clone" and explain the presence of the "--missing" argument as follows:

    In the future, we will introduce a "partial clone" mechanism wherein
    an object in a repo, obtained from a remote, may reference a missing
    object that can be dynamically fetched from that remote once needed.
    This "partial clone" mechanism will have a way, sometimes slow, of
    determining if a missing link is one of the links expected to be
    produced by this mechanism.

    This patch introduces handling of missing objects to help debugging
    and development of the "partial clone" mechanism, and once the
    mechanism is implemented, for a power user to perform operations
    that are missing-object-aware without incurring the cost of checking
    if a missing link is expected.
