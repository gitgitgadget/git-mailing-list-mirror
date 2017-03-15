Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EF71202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 16:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbdCOQmW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 12:42:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:65190 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752562AbdCOQlY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 12:41:24 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXEs5-1ckWpi1UbF-00WHF0; Wed, 15
 Mar 2017 17:41:07 +0100
Date:   Wed, 15 Mar 2017 17:41:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     David Aguilar <davvid@gmail.com>
cc:     Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christophe Macabiau <christophemacabiau@gmail.com>
Subject: Re: [PATCH 3/3] difftool: handle modified symlinks in dir-diff
 mode
In-Reply-To: <20170315065406.6739-3-davvid@gmail.com>
Message-ID: <alpine.DEB.2.20.1703151739070.3767@virtualbox>
References: <20170315065406.6739-1-davvid@gmail.com> <20170315065406.6739-3-davvid@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9QPBRrIEaiF4PourFxPxfwgb7H6lF8kJGNOOtWshFB2HpzrU+8h
 uE0rr9tid0ToL/YUzXEHs9UdWJVw0ZeRrOSVmlbUQhMoqj/Cw8JvHTU5eUTa4MX2rPALeyp
 Rs7LNzS7Y+FSntAuAffbdKKkIS9+Qdud4PF4rzHPNVFDW8VkrmMJSTR0eWOHaSBLBBotIqi
 gYIfPFQTVsrPKbf1SEESA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vL1+DO5Bp4Q=:A+jRbtEFCXC4aYafGmesAi
 QnfC0B1HyklvIVnxjRz8A3SK2YHnIPehuLhgxXG2MG5obUT4DpXqwg5/T6dAtKJ7apPTXBO2a
 qVzkyYtMEr6QFamQOpFWgTgJQHrQlCj8f0OEwMGwePrSqZy3Q7TExuU2kg/SKv1sgSLJqxo44
 y1fuY5/pIFyX9faz58Uj/3RIi2MNb2jo+RcwFDhf26mpDaeoNDoNnsPWsDpp1JTQF3WRSo6Fw
 SIlcKklfBAykO2SiCSKoIQeGXGk/m7XtVXfarv0qGeukBlUfgvcC8213Bez4dNDAW1MwE0Pqa
 CXrXyDbPqZGW6BbOv0bM5S6Bxl6bSTxMYfqGrU6hNJHYO6E9l3YsYZXX2UOI1ZppHUw1pgbKO
 lIdxzKszVK46eZI4h87IxYE7UuEqGiQbipWe7BeV3HMqJ1n+LUTJP5uW09tIhlc479W4jjjFC
 dcI2iTeC3ADMCt2fBPnjQ/wT6rRl53Vu5eKrnGV0GBWSsfBYFqNpZ1ZRO/NO7YTiv19XfWoEe
 XHw67aErGZQ0KdCKfnCPNGF2X3f6fR2H5trliL9Jn0FWSHDaOZnzrq8bldPjXB4fBNiAeVTNy
 S1ZXlynF2Wfxf8kXR1kyR94rAS9+lO3WeWSC8363b7oitWMQ/GYRLyNoKWUcCvcf22k7xs0wS
 wnUCWLSbIdhDlbVZlz0VwAKnPrvFh64n4JVJr3e50k3kwOuTxfQVrxmTSg9WW2lYz/WIXP3m0
 +2gOZlVRLTqbHNatqFETEmKz6KtVSin/GynHoa0NUCmmt1JmH35h6nqUCGtgdxbJij9DeMXou
 ZBXp7Dy/M8AlFGHLuGbCyigGNYSMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Tue, 14 Mar 2017, David Aguilar wrote:

> Detect the null object ID for symlinks in dir-diff so that difftool can
> detect when symlinks are modified in the worktree.
> 
> Previously, a null symlink object ID would crash difftool.
> Handle null object IDs as unknown content that must be read from
> the worktree.
> 
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This was reworked a bit since the original patch.
> The subject line changed, a lot of comments were added,
> and the tests were made more extensive.
> 
> This implementation is simpler since we now use a get_symlink()
> function in one place and simply skip the problematic code path
> that does not apply to symlinks.  Existing code handles writing
> the symlink content so write_symlink_file() from the original
> patch is gone.

I really like this version. It is very easy to follow, the extensive
comments make a lot of sense.

Well done!
Dscho

