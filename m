Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9301F462
	for <e@80x24.org>; Tue, 28 May 2019 23:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfE1XBg (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 19:01:36 -0400
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:59938 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbfE1XBg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 May 2019 19:01:36 -0400
Received: from resomta-po-13v.sys.comcast.net ([96.114.154.237])
        by resqmta-po-08v.sys.comcast.net with ESMTP
        id Vkwth60N5FpWYVl67hJn0N; Tue, 28 May 2019 23:01:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559084495;
        bh=2CJd6B7H9txMmN0/gzPTDxq3m9ZxZ2WYc94o8yZP+a4=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=3tuybUW5pw06316Yw0z89lo8R7Cjk9FOW2TjssyFOKxTQ9lnjhwsIYNTdEEaK3WRk
         YRjKt5E5btUV0tyUyGWKalVihUM2ylRSWtjI8zxm7kMmaGXljlZwRltRbk0/q/TY0H
         QnRLwDpMuwTCNGFd01reSZMu+q0AmOLDQpHWAhnoTiqxAFhhipCVggRQ1wWWP1UNl+
         ODK+Bh9I6Y6mdIpu17RSsOztF7ptFUxZmXTECdtrJWDs8bxAJlv3F7Nlb08JEMtU9S
         FxIQ0QfjFDGWej2DpNNYLeDee+Mo8PQCa5npOou8hVzrldBHzQYoh08hEG7aOeJf4m
         7tMoOmWg0VxeQ==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:b43f:cfdf:8f71:b59d])
        by resomta-po-13v.sys.comcast.net with ESMTPSA
        id Vl65hZC07BnAXVl66hSeCO; Tue, 28 May 2019 23:01:35 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Tue, 28 May 2019 16:01:33 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 2/5] list-objects-filter-options: error is localizeable
Message-ID: <20190528230133.GB4700@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <6f4da02d494323e3ca946b4b20bf78d9dee419e4.1558484115.git.matvore@google.com>
 <20190524005512.GC46998@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524005512.GC46998@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 05:55:12PM -0700, Emily Shaffer wrote:
> What does it look like? Is it human-readable in its current form? I ask
> because (without having looked ahead) I think you're going to move it

You can make the error appear in this way:

$ git rev-list --filter=blob:nonse --objects HEAD
fatal: invalid filter-spec 'blob:nonse'

I included it in this patchset since I'm changing code in the vicinity and it's
possible the patchset may mutate to a point where these lines get moved to a
separate function or their indentation changes, meaning the maintainer has to
handle merge conflicts. But that may be more caution than necessary.

I don't feel so certain about what's going to happen either way, nor do I mind
having the patch stick around in this set, so maybe I'll just keep things as
they are for now.
