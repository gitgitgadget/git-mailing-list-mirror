Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D9C55185
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 06:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FAC920728
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 06:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgDYGaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 02:30:24 -0400
Received: from aibo.runbox.com ([91.220.196.211]:49086 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDYGaY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 02:30:24 -0400
Received: from [10.9.9.203] (helo=mailfront21.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1jSEKT-0006HO-Nq; Sat, 25 Apr 2020 08:30:21 +0200
Received: by mailfront21.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1jSEKD-0005yq-Q2; Sat, 25 Apr 2020 08:30:06 +0200
Date:   Sat, 25 Apr 2020 06:29:57 +0000
From:   Emma Brooks <me@pluvano.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH] gitweb: Recognize *-to and Closes/Fixes trailers
Message-ID: <20200425062957.GA56088@pluvano.com>
References: <20200425021723.16346-1-me@pluvano.com>
 <xmqqeesc9m9l.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeesc9m9l.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-24 22:17:58-0700, Junio C Hamano wrote:
> Did you also sneak "cc" in without documenting/justifying?

No, that was already there in the original, before the colon:
> > -		if ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
> > +		if ($line =~ m/^\s*([A-Z][-A-Za-z]*-([Bb]y|[Tt]o)|C[Cc]|(Clos|Fix)es): /) {
