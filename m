Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72D211FC44
	for <e@80x24.org>; Tue,  9 May 2017 03:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754407AbdEIDaE (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 23:30:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:47864 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754277AbdEIDaC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 23:30:02 -0400
Received: (qmail 13839 invoked by uid 109); 9 May 2017 03:30:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 03:30:02 +0000
Received: (qmail 19418 invoked by uid 111); 9 May 2017 03:30:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 23:30:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 23:29:59 -0400
Date:   Mon, 8 May 2017 23:29:59 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 4/4] add--interactive: drop diff.indentHeuristic
 handling
Message-ID: <20170509032959.42nt6vbrt7zh3nkb@sigill.intra.peff.net>
References: <f867af6f-b601-251a-86a4-ede0bb942efb@xiplink.com>
 <20170508160339.4551-1-marcnarc@xiplink.com>
 <20170508160339.4551-5-marcnarc@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170508160339.4551-5-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 12:03:39PM -0400, Marc Branchaud wrote:

> @@ -730,9 +729,6 @@ sub parse_diff {
>  	if (defined $diff_algorithm) {
>  		splice @diff_cmd, 1, 0, "--diff-algorithm=${diff_algorithm}";
>  	}
> -	if ($diff_indent_heuristic) {
> -		splice @diff_cmd, 1, 0, "--indent-heuristic";
> -	}

I don't remember if I mentioned this before, but this series (and the
reasoning why it is OK to tweak the default) did make me wonder if it
be reasonable to respect diff.algorithm even in plumbing.

I don't actually use it myself, and certainly it would not need to be
part of this series. But perhaps if somebody is really into alternate
diff algorithms they'd be interested in following it up (my own
experience with alternate algorithms has usually been "wow, this diff is
ugly; I wonder if --patience helps" followed by "nope, still ugly").

-Peff
