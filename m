Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536DA20133
	for <e@80x24.org>; Thu,  2 Mar 2017 06:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbdCBGkx (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 01:40:53 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:36358 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdCBGku (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 01:40:50 -0500
Received: by mail-io0-f177.google.com with SMTP id l7so47120993ioe.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 22:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+LPy8D/tPgJKcz/eVqZsD6sm8fkhYbwQprhqnZVIszo=;
        b=M1UZforIoMcaADm5Rt5lE5/c8Jfi4oeK6OZE7Us4ofkQ4zp+8UB4Qyy0rj9T/nzcrO
         FwdKD4/Aeg47uQ9CrYc0EKqe+138zQdlkrSTsk7rrRI3iulk7fkoBYVbTLm4bs3AANh/
         Roiz+F4ndGtV6RDpRUiwyB7LRDnQ6XW4PCJgexSCHgSAWr2MOQZ9se5QOVLSGmelQkkj
         j0apb/KiUijhzKUsUywBjOA9eDERJgfi/lx3Zkl8pGt5jcp7eAry3oCPfBiZftY6KHT6
         sixWqLsEM4TFYH2kh0ZMxS1tBJfes3MUyruPT9K0gg3h0FlmtyQkoDOq5zVwHemAjMxO
         kO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+LPy8D/tPgJKcz/eVqZsD6sm8fkhYbwQprhqnZVIszo=;
        b=nhc/sWQQghh/jI+g+WNEBPR68hDTdslbRnZG/HlZFZ5G2T/XojCRUhJcvN3fxY3RbP
         TYR3p4mFsS/OhwbKJPsGeUsOn1dNvvCPenU9IsqAUkYFx4GYn2AFsIkIHuip+fTjD3Z7
         uKeFJDDCHDIU2dlVUL3a2RIbpZvFIoVU2yDkEZWVABF4wMXqs5RIBL5GA1j2dRwosxWp
         kGqop2YUlx35cUu5rJm7XB3aRNmR13NtbiKJRpWnr1voRiYHkyLExw+AVjuaTgbQarX+
         quD/no8iGsbhaTylsztiqf4BE9rT1yUCLc3EEI+CJQS4+nVIlr3kxOM9jbk8yX14xip9
         QXwA==
X-Gm-Message-State: AMke39movOLDAIvtWtWHAxCjCNF8IH2iuPs8+QQ+wCL4guGNR09CLPAqKaJbHQP55EBz1MvZP0jLeSz0ZFNbTA==
X-Received: by 10.107.136.93 with SMTP id k90mr10140265iod.224.1488395454642;
 Wed, 01 Mar 2017 11:10:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Wed, 1 Mar 2017 11:10:54 -0800 (PST)
In-Reply-To: <20170301190711.nwlretmy6w675jvp@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <20170301190711.nwlretmy6w675jvp@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2017 11:10:54 -0800
X-Google-Sender-Auth: hFEenJSzitXoBIgEkIU2X0el1mQ
Message-ID: <CA+55aFzd+QYMCzyxzqucPMfNyazWdoo7XbDgsbdnJQRWHw+xPA@mail.gmail.com>
Subject: Re: [PATCH] Put sha1dc on a diet
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 11:07 AM, Jeff King <peff@peff.net> wrote:
>
> So obviously the smaller object size is nice, and the diffstat is
> certainly satisfying. My only qualm would be whether this conflicts with
> the optimizations that Dan is working on (probably not conceptually, but
> textually).

Yeah. But I'll happily just re-apply the patch on any new version that
Dan posts.  The patch is obviously trivial, even if size-wise it's a
fair number of lines.

So I wouldn't suggest using the patched version as some kind of
starting point. It's much easier to just take a new version of
upstream and repeat the diet patch on it.

.. and obviously later versions of the upstream sha1dc code may not
even need this at all since Dan and Marc are now aware of the issue.

                  Linus
