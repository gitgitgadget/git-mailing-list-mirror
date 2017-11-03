Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA5220450
	for <e@80x24.org>; Fri,  3 Nov 2017 18:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756139AbdKCSjX (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 14:39:23 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:52828 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756087AbdKCSjV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 14:39:21 -0400
Received: by mail-io0-f169.google.com with SMTP id f20so8259452ioj.9
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4mdHJGLzuCk8FbFoLqIDg1RBkH0klIvE/QWU+/k97dE=;
        b=Ry14YYNCwxZOfyuU0Qcy/TCnUQ6rYwD42ZgVCJFsa48seqf5tSxmrjkW2u/pLeBcpl
         oYAJw0U5XZbldbI4bu4yyGJuq/AHfhUtfcp94o1a0cKDwfIAzdpe8mZAQkJXLbBAQjwg
         QFxD/Joi9UOG1/i0SG6FqhH2VK+fJRlE94hy2WA7N74bnkzMK1OaVODYCHZYORwuItTJ
         pyB8+QyEp7foemvbJncTtqNcgM+H/Guxx7S+UcoTHatazzKmPt29nVf65Xl8cwhiGuzv
         O3d8VXe+enP7agkkO9OCxj2vKsitd+hpZV2cKVySIL1CMNS8vJ2vxbDobRbeWDswGH7U
         YjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mdHJGLzuCk8FbFoLqIDg1RBkH0klIvE/QWU+/k97dE=;
        b=b7TsfcwDGN7+KJcnd0URGgqn2DIkLrkiyts6WOszx6At+fW6puYvqXO28WRSj/h+5m
         tSxfLncjXataRZHev1jk0UIiRrKyu99Ps4mZ37h0v18NKYKJ9KIB0wmgZC1fBcNUot7f
         5mJG+UAbWgcqwJD6SPAAFFmYSuJOH0Wx9QMxOUA+am0j4HtM8UipJCfIEKgIXTAENp7q
         ZDJtiHr49oPXlbeMn9k0pUcuAj4BuRWD3qVGrdBV6TT56zQQbnkjfEtZprRZc3mShsGh
         EGxfm30GhB5CSlTCQaV6ekhBQ/co4tg3ms6BG86tRdBaSY4yikL4qBcS/gldIKxKR1Fi
         B3XQ==
X-Gm-Message-State: AJaThX4UsCdBNWFM/YWycKzXgaI1zs0toTXUoUhZ0IbGP35qVkFcMTXN
        8gSsp0AGPp22HTepvFgpdmMIPw==
X-Google-Smtp-Source: ABhQp+TCr6qLjlMa6L8KStyvie/TOJu/fNMXWSaajujRCECzzGARvdkl+lNd1Dnts/tXUSfIc2WmMw==
X-Received: by 10.36.9.144 with SMTP id 138mr1036310itm.106.1509734361149;
        Fri, 03 Nov 2017 11:39:21 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:5949:10b2:8e2d:2f6])
        by smtp.gmail.com with ESMTPSA id 5sm2990745ion.46.2017.11.03.11.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2017 11:39:20 -0700 (PDT)
Date:   Fri, 3 Nov 2017 11:39:19 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/9] extension.partialclone: introduce partial clone
 extension
Message-Id: <20171103113919.396807c82dbfdecff7f19c41@google.com>
In-Reply-To: <1db01a45-85c4-6243-c43f-9f5e50e9a6a8@jeffhostetler.com>
References: <20171102202052.58762-1-git@jeffhostetler.com>
        <20171102202052.58762-2-git@jeffhostetler.com>
        <20171102152427.32544b3d6149e7a7bfe840c8@google.com>
        <1db01a45-85c4-6243-c43f-9f5e50e9a6a8@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 3 Nov 2017 09:57:18 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> On 11/2/2017 6:24 PM, Jonathan Tan wrote:
> > On Thu,  2 Nov 2017 20:20:44 +0000
> > Jeff Hostetler <git@jeffhostetler.com> wrote:
> > 
> >> From: Jeff Hostetler <jeffhost@microsoft.com>
> >>
> >> Introduce the ability to have missing objects in a repo.  This
> >> functionality is guarded by new repository extension options:
> >>      `extensions.partialcloneremote` and
> >>      `extensions.partialclonefilter`.
> > 
> > With this, it is unclear what happens if extensions.partialcloneremote
> > is not set but extensions.partialclonefilter is set. For something as
> > significant as a repository extension (which Git uses to determine if it
> > will even attempt to interact with a repo), I think - I would prefer
> > just extensions.partialclone (or extensions.partialcloneremote, though I
> > prefer the former) which determines the remote (the important part,
> > which controls the dynamic object fetching), and have another option
> > "core.partialclonefilter" which is only useful if
> > "extensions.partialclone" is set.
> 
> Yes, that is a point I wanted to ask about.  I renamed the
> extensions.partialclone that you created and then I moved your
> remote.<name>.blob-max-bytes setting to be in extensions too.
> Moving it to core.partialclonefilter is fine.

OK - in that case, it might be easier to just reuse my first patch in
its entirety. "core.partialclonefilter" is not used until the
fetching/cloning part anyway.

I agree that "core.partialclonefilter" (or another place not in
"remote") instead of "remote.<name>.blob-max-bytes" is a good idea - in
the future, we might want to reuse the same filter setting for
non-fetching functionality.
