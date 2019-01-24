Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935A71F453
	for <e@80x24.org>; Thu, 24 Jan 2019 23:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfAXXkF (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 18:40:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37804 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfAXXkF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 18:40:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so8391100wrt.4
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 15:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QbRyeesGPEao5/3xj0N1iaaFsweaQzKE2CKpO3z8KqE=;
        b=nTTQBtkWpzpgdp1VO2mhij4F8xekldVfz6VRfPMcYhKb5AWjHNTCmECvfZP30qm/QF
         BMcA8ot3Gb4E78q1ZD/UjwUwDUbHrO/QSmkin0dtxelfFkm5W5jfmpWy726TOyq5DQqD
         IkQuNTsWrxkYRKlDKJRsLaMe24saP2VWuVsmiy+lO5+GMrgFxRYumh4DtJ1ZE1Bjemyo
         AeEKmubh+uQa5HNfbFCn7836hmGFuHBmYeKQMOHCu/zZ9i6O22P60rQ0GYMjEkl6CYqf
         zhYNnCF4EG4Ha1u7XSZfAn3512D2+qIErPYKmOYXSDmOCzyhkvjXm9SzpnhsMwBVps37
         5yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QbRyeesGPEao5/3xj0N1iaaFsweaQzKE2CKpO3z8KqE=;
        b=oNxw5QTbQDNtBhEj22i9bFwnru0qpAaqbo9miVzpvTO6jtHewgoqZEYZK7b7AsXtpX
         amcN+H5NNiEBVF0ciOs96+8YRSglkDmW1cc+ZwXM5iLaTFgp+g2C7kuUrLoXJwCtqSTH
         7bG4+VUdv4PWvOTFJHNwLJQFdTeceIJCOTL3wSIbRPCRjerLz8Zwodsto6P4ogc0X+cJ
         SrTc9VD9kojkOaQzXGOs2neltu8GJjzoQ/xcyJ3QGOgOwp7c47iFslzNv2SDnAc/FKI0
         MHgv9M91bcjP53gFzYnKdGeKvJJ3sxyKwJk4YAlyWzkH9XM9n6kGDsuYWS8tHPmc6GFi
         UZNA==
X-Gm-Message-State: AJcUukeKZ/TUqvX8mXyh2YAfPIsgL/11axGCYRJKcd1AYlceq4W7+xkw
        /semVAUraOANcGHd94TW5tiYGWrU
X-Google-Smtp-Source: ALg8bN7NWBn/K1dHtL1KQZN/9HFcpTbEU6N8I6ip0sGV3t+Q0FGSfgrTRTEw1lknuxQrhYkF7bOj8w==
X-Received: by 2002:adf:ca13:: with SMTP id o19mr9011935wrh.148.1548373202910;
        Thu, 24 Jan 2019 15:40:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s66sm54266324wmf.34.2019.01.24.15.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 15:40:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, avarab@gmail.com
Subject: Re: [PATCH 0/6] Create commit-graph file format v2
References: <pull.112.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Jan 2019 15:39:59 -0800
In-Reply-To: <pull.112.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Wed, 23 Jan 2019 13:59:14 -0800 (PST)")
Message-ID: <xmqqzhrpfwvk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series is based on ab/commit-graph-write-progress and bc/sha-256.

Thanks.

It seems that the base (i.e. merge between these two topics) you
used may have used a version of either topic (most likely the
latter) slightly older than what I have, as patches 1 and 2 seem to
lack the local variable "hashsz" in the context, near the beginning
of commit_graph_write().  I wiggled the patches in, but it has too
heavy conflict merging to 'pu', so it may have to wait until the
other topics stabilize a bit further.

