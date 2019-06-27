Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240EB1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 21:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfF0VRU (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 17:17:20 -0400
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:57438 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726384AbfF0VRT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Jun 2019 17:17:19 -0400
Received: from resomta-po-17v.sys.comcast.net ([96.114.154.241])
        by resqmta-po-06v.sys.comcast.net with ESMTP
        id ga8Hh4sY4MC2xgblfhlh5a; Thu, 27 Jun 2019 21:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1561670239;
        bh=1V/o4hVXZ6lJLj9zgvskdxvVmBQG597d+0tBepIQ5Hs=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=kV4vd081XYOGja03JJgKY1zQjC4kl47jtJfZX674ep+ere/bB4GkSXW4m7gURIIFx
         KOQ59dZ8ZvMI6RXlR0CX+LpxP45zIXt730a51z4oK1ag04jPr6XUy2EUZLtBDcqbK2
         e1Zw0xbkAm2lUALl0SYwmF/HjkLNZpNBFhyvdxN9CFqR5AOE84A6jamy1dB4xVetmo
         ad7l+dKnh9Zu3I3V8LUmIlN/eb6kCc2pXtSBLZnp2EUulEMbsVpOwYKhmG9JdCOQvZ
         fF8+6eI76tS7pw4W12/npTrTPqg+7Y84HlXzoAxMy4o1GRe5sDdSE6j5vcUfj8euwK
         VUD0K6tv5+A1Q==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:5954:f056:f8d3:3ba7])
        by resomta-po-17v.sys.comcast.net with ESMTPSA
        id gblQhG092RbEbgblUhf0Zv; Thu, 27 Jun 2019 21:17:17 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Thu, 27 Jun 2019 14:17:04 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org
Subject: Re: [PATCH v4 06/10] list-objects-filter-options: make filter_spec a
 string_list
Message-ID: <20190627211704.GC54617@comcast.net>
References: <1a95dd91927973038c3d59bc3215556e448f0e63.1560558910.git.matvore@google.com>
 <20190622003713.248581-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622003713.248581-1-jonathantanmy@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 05:37:13PM -0700, Jonathan Tan wrote:
> Patch 5 and this patch look good to me.
> 
> <snip>
> 
> So expand_list_objects_filter_spec() now returns a filter_options-owned
> string (instead of previously writing to a strbuf), which is why we no
> longer need to do any freeing or releasing. That makes sense. (Same for
> the other call sites.)
> 
> <snip>
> 
> This append needs to be called with xstrdup, because a zero-initialized
> string list is NODUP. OK.

Thank you for taking a look.
