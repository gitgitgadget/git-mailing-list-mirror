Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8487BC2BA2B
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 01:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A3E221E9
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 01:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgDQBra (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 21:47:30 -0400
Received: from aibo.runbox.com ([91.220.196.211]:56732 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgDQBr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 21:47:29 -0400
Received: from [10.9.9.204] (helo=mailfront22.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1jPG6J-000370-Nm; Fri, 17 Apr 2020 03:47:27 +0200
Received: by mailfront22.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1jPG6E-0004u9-6H; Fri, 17 Apr 2020 03:47:22 +0200
Date:   Fri, 17 Apr 2020 01:47:13 +0000
From:   Emma Brooks <me@pluvano.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Documentation: explain "mboxrd" pretty format
Message-ID: <20200417014713.GA20574@pluvano.com>
References: <20200416041658.85100-1-me@pluvano.com>
 <xmqqlfmw2f9z.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfmw2f9z.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-15 22:03:36-0700, Junio C Hamano wrote:
> > +Like 'email', but lines in the commit message starting with "From "
> > +(preceded by zero or more ">") are quoted with ">" so they aren't
> > +confused as starting a new commit.
> 
> I am torn between rephrasing "starting a new commit" with "starting
> a new e-mail message", and keeping it as-is.  Technically, the latter
> is more correct---the >From quoting is a technique to avoid starting
> a line with "From " in a reversible way, as pieces of e-mails in a
> single mailbox file needs to be split at the boundary.  But in the
> context of format-patch, perhaps saying each "record" in the output
> file is a "commit" (not a piece of e-mail message) would probably be
> an acceptable white lie.

While it is more accurate to say "starting a new email" rather than
"commit", I think it might be less confusing to say "starting a new
commit", if the reader isn't already familiar with how mbox works or its
variants, since the pretty formats control commit display and would
typically be thought about in terms of commits rather than emails.
