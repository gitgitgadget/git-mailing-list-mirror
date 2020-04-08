Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84021C2BA16
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5428420730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgDHEId (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:08:33 -0400
Received: from aibo.runbox.com ([91.220.196.211]:38556 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgDHEId (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:08:33 -0400
Received: from [10.9.9.203] (helo=mailfront21.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1jM20r-00036x-Rg; Wed, 08 Apr 2020 06:08:29 +0200
Received: by mailfront21.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1jM20b-00057O-Q1; Wed, 08 Apr 2020 06:08:14 +0200
Date:   Wed, 8 Apr 2020 04:08:04 +0000
From:   Emma Brooks <me@pluvano.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: teach --no-encode-headers
Message-ID: <20200408040746.GA41187@pluvano.com>
References: <20200405231109.8249-1-me@pluvano.com>
 <xmqqd08lwatm.fsf@gitster.c.googlers.com>
 <20200407034622.GA42812@pluvano.com>
 <xmqq8sj7t7d0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sj7t7d0.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-07 12:37:31-0700, Junio C Hamano wrote:
> Emma Brooks <me@pluvano.com> writes:
> 
> > It's also too vague and it's not entirely clear from the option itself
> > what sort of encoding it refers to. I will change it to
> > --[no-]q-encode-headers and format.qEncodeHeaders in v2 unless there are
> > other suggestions.
> 
> I actually did not mean to push you into that direction.  We can,
> and do want to, keep the most generic "--[no-]encode-headers" if we
> do not anticipate us wanting to special case the Q encoding.  A
> sample question to ask is "would it make sense to disable q-encoding
> but still perform other parts of 'encode headers'?"  I haven't
> thought deeply about such questions, but as a proposer of this
> topic, you would certainly have, and I was hoping that you'd say
> things like "Q-encoding is the only thing that we do to munge
> headers, so there aren't any 'other parts of encoding headers' we
> need to worry about", "there are things like X, Y and Z that we do
> to the headers when we enable Q-encoding, but they all are what we
> do not want when we do not want the Q-encoding", which would be a
> very good sign that assures us that "--[no-]encode-headers" is a
> good name.

Ah. I don't think there are any cases where we do other sorts of
encoding, or want to enable one "part" of encoding and disable another.
I do think the name need to be more obviously about *email* headers as
Jeff pointed out, though.
