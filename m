Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAAA41F461
	for <e@80x24.org>; Thu, 22 Aug 2019 17:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392821AbfHVRoa (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 13:44:30 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:32945 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403887AbfHVRXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 13:23:16 -0400
Received: by mail-vs1-f74.google.com with SMTP id q9so1935083vsj.0
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rrDn3ZNaCE6mgYpG/qUxNx9AD7a3hI5bWJgzkcfcTo0=;
        b=IRlpAUThSczMw4Ek3BBEn9MFSvy2vdP+DXJYo/43tl4Z6pm5GZ8UVf0exW8jWta2Si
         pkjRwM5NiwK8Tt+Gc7N7SDx6wnglJ6bbtD7dG4iIyJP8SKsGjzZ3XQyAtT4QAHntvO1S
         HN8TpjroEEzvjJEOHJ0BqnwGKHXF/oeUDm0KD3V4cuIyWFDeQ+Scwo3cGX+bmWeIGnLd
         ysx01i97sTf/mZNoyMZ9F3Wels2ifw8cMZEtD7fjmtHQ+oMehWzqLvXKbf2+w5ENL/ny
         /8+S4TnTR9nCSo/CKgmmzU1Kjn8OppoKSPg/Nk1sc4McaoTbeO6LQbhCcKQUoUhO4kQW
         1XkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rrDn3ZNaCE6mgYpG/qUxNx9AD7a3hI5bWJgzkcfcTo0=;
        b=o6zIbQD1/MHiAPL3hH74xaoaC7g1NFCadiJ3nZHj6f2aLLXPs3ujZGrKc312jDmLqL
         EMZMXnJgz4eVrhV0x6IXeWJ6E8c3MWofS+2IImdDyIIfdIXwKSKbhmmztabRyWe9QOC8
         IF5Erdd0rArrQG/lkFKrBm4Hh2d2ZAaJd+nEYwsGV+8rIXk496lM+KL63oDvbDnbgRMI
         wAWz2+GWBt1LblzymlEpUIgurE078Q2XX9ZmnaQdi4enwNU6pF5hkH76Ut+wlr4ygIj+
         3ozPcWK5oHCkuXADFXetyL4je3As6CRulr8/wPjrV28puMOK7BOCLcrNpjFj8Bw0gr/G
         IkgQ==
X-Gm-Message-State: APjAAAXoHHzInKHl6IlUpcaJ8COd1OxahJchrBYfebTbhOL0JdTsSbZk
        0GD8cywy2wgLHlwEgzXGD/KLPBv1rLPyaUXrE2rj
X-Google-Smtp-Source: APXvYqyNrN8iPYiRL9oEvLKbzKrzkar3mvFHJ+vgz5+2paPWgxB+orTnZqs+DM2ydBXvr1QpHsecPTTBNt+HwOQ4HUdY
X-Received: by 2002:a67:fe90:: with SMTP id b16mr93689vsr.135.1566494595355;
 Thu, 22 Aug 2019 10:23:15 -0700 (PDT)
Date:   Thu, 22 Aug 2019 10:23:12 -0700
In-Reply-To: <xmqqtva9p3ma.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190822172312.41404-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqtva9p3ma.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: Re: [PATCH 0/2] Skip ls-refs if possible for HTTP
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This probably is totally off-tangent, but do any of these "let's
> advertise fewer" changes at the protocol level have to take into
> account the use of --prune option on the client side?

I don't think so. According to what I understand from the documentation,
the prune option prunes based on the RHS of the refspec, and it doesn't
affect anything non-matching. When we advertise fewer, the only refs
that are missing are those that are non-matching anyway.

Some experimentation seems to show that that is the case also:

$ git init one
[snip]
$ git -C one commit --allow-empty -m x
[master (root-commit) 67056ac] x
$ git -C one branch maste
$ git -C one branch other
$ git clone "$(pwd)/one" two
Cloning into 'two'...
done.
$ git -C one branch -d maste
Deleted branch maste (was 67056ac).
$ git -C two checkout --detach HEAD
HEAD is now at 67056ac x
$ GIT_TRACE_PACKET=1 git -c protocol.version=2 -C two fetch --prune origin refs/heads/m*:refs/remotes/origin/m*
[snipped lots of stuff; basically, only refs/heads/master is sent]
10:15:46.308264 pkt-line.c:80           packet:        fetch> ref-prefix refs/heads/m
10:15:46.308276 pkt-line.c:80           packet:        fetch> ref-prefix refs/tags/
10:15:46.308523 pkt-line.c:80           packet:        fetch< 67056ac6d07814334716df760054ac5bec05b66a refs/heads/master
From /usr/local/google/home/jonathantanmy/tmp/g/one
 - [deleted]         (none)     -> origin/maste
$ git -C two for-each-ref
67056ac6d07814334716df760054ac5bec05b66a commit	refs/heads/master
67056ac6d07814334716df760054ac5bec05b66a commit	refs/remotes/origin/HEAD
67056ac6d07814334716df760054ac5bec05b66a commit	refs/remotes/origin/master
67056ac6d07814334716df760054ac5bec05b66a commit	refs/remotes/origin/other

(Notice that refs/remotes/origin/other is untouched.)
