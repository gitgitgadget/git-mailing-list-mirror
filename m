Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1756D1F42B
	for <e@80x24.org>; Sat, 28 Apr 2018 06:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeD1G1Z convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 28 Apr 2018 02:27:25 -0400
Received: from listserv2.niif.hu ([193.225.14.155]:52056 "EHLO
        listserv2.niif.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbeD1G1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 02:27:24 -0400
Received: from business-188-142-225-206.business.broadband.hu ([188.142.225.206] helo=lant.ki.iif.hu)
        by listserv2.niif.hu with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <wferi@niif.hu>)
        id 1fCJKN-0002cl-CZ; Sat, 28 Apr 2018 08:27:23 +0200
Received: from wferi by lant.ki.iif.hu with local (Exim 4.89)
        (envelope-from <wferi@lant.ki.iif.hu>)
        id 1fCJKI-0005u3-0H; Sat, 28 Apr 2018 08:27:18 +0200
From:   wferi@niif.hu (Ferenc =?utf-8?Q?W=C3=A1gner?=)
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: branch --contains / tag --merged inconsistency
References: <20180427160344.12724-1-szeder.dev@gmail.com>
Date:   Sat, 28 Apr 2018 08:27:17 +0200
In-Reply-To: <20180427160344.12724-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 27 Apr 2018 18:03:44 +0200")
Message-ID: <877eor6e2i.fsf@lant.ki.iif.hu>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> The commit pointed to by the tag Pacemaker-0.6.1 and its parent have a
> serious clock skew, i.e. they are a few months older than their parents:
> [...]
> (branch|tag|describe|...) (--contains|--merged) use the commit timestamp
> information as a heuristic to avoid traversing parts of the history,
> which makes these operations, especially on big histories, an order of
> magnitude or two faster.  Yeah, commit timestamps can't always be
> trusted, but skewed commits are rare, and skewed commits with this much
> skew are even rarer.

Szia Gábor,

Thank you very much for the explanation!  Good to know there's no
serious problem or misunderstanding here, but a conscious algorithmic
choice being fooled by clock skew.  I wonder if there's a way such clock
skew can appear without actual committer clocks being off by months...

> FWIW, much work is being done on a cached commit graph including commit
> generation numbers, which will solve this issue both correctly and more
> efficiently.  Perhaps it will already be included in the next release.

Wonderful news, thanks for sharing it!
-- 
Regards,
Feri
