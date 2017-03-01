Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9C782023D
	for <e@80x24.org>; Wed,  1 Mar 2017 18:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbdCAS46 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 13:56:58 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:35601 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbdCAS4s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 13:56:48 -0500
Received: by mail-it0-f42.google.com with SMTP id 203so104361480ith.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SnA/YDljbUBAlp13L51n0jADb1AIotEbTb2+vofkn2E=;
        b=Bad1QhV7d8+4qs67paIU2x7mjMbh0zCxHCsBYFYUFwGk1nIWimyn15Y4vQ0ege1oG1
         G+NNH9GX0bIGo+qtd37ksk4cSP3p9pHLpDep/1zCyl/XP3vpDHQtyQdWTvECSdL0lMTo
         kq3fjkiCj9i11Wyu5uodisv7eiT9Co7nv6kOJhJgPiwL7NhxxTyVbbwfom6qgj8vdaww
         g5Y3XrDiDiqhziQH/oV+/ijOOnTUk8Uz/vDiiUiNtsRKAbIvfkf2Oel/ZzaZ3ZwL5IsB
         9WQUs6VLR6lpK5ew2hCV54eGHu5exSVoITT/RB2oZKckA43Hj2XOajwSO7KkUGMW2lyR
         jBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SnA/YDljbUBAlp13L51n0jADb1AIotEbTb2+vofkn2E=;
        b=aAV9bdzftDBKb6pSbzBm3yeYvOdqXcbbIlt1JbhIYbRgSv0ImLQlRYv9DTEgB0QGXi
         RoUGmX0q3Cac00QYvtJjlH5irDPXxr9wgKgctpKog4Y20kxtenPO3saiWNNd/WurNXKF
         QjuusD5afR2VdiK/WfKptRXE/ncbfhT9W6dLJ2GAsz5vEWzhDufM7MHbPTgXj/k3MPjN
         70LE6C5aM5X+JBQ1Y0bp+dioPgmfxFoGUw7G74APgQDnQsdxKRnkAtqOVJSSGEhASZu9
         jVYdVvIjRpmTX5WQpJhFLpuGey0I16KfPBJ6Q0VG7peQuoCqm7blo23ZTwYF3oorwcFj
         LEkQ==
X-Gm-Message-State: AMke39lfZj94GDgYyKpT6ey0an3kFsUyHZg/UTeYa2g/IEMtWgWx6CY5wtoHhBmyo3f6bccQhcvz8LztYuLa3g==
X-Received: by 10.36.65.135 with SMTP id b7mr6162377itd.86.1488394195476; Wed,
 01 Mar 2017 10:49:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Wed, 1 Mar 2017 10:49:55 -0800 (PST)
In-Reply-To: <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2017 10:49:55 -0800
X-Google-Sender-Auth: c5VVv4hhpPrM59K5kEekDwlcg_I
Message-ID: <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
Subject: Re: [PATCH] Put sha1dc on a diet
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 10:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I see //c99 comments

sha1dc is already full of // style comments. I just followed the
existing practice.

> and also T array[] = { [58] = val } both of
> which I think we stay away from (and the former is from the initial
> import), so some people on other platforms MAY have trouble with
> this topic.

Hmm. The "{ [58] = val; }" kind of initialization would be easy to
work around by just filling in everything else with NULL, but it would
make for a pretty nasty readability issue.

That said, if you mis-count the NULL's, the end result will pretty
immediately SIGSEGV, so I guess it wouldn't be much of a maintenance
problem.

But if you're just willing to take the "let's see" approach, I think
the explicitly numbered initializer is much better.

The main people who I assume would really want to use the sha1dc
library are hosting places. And they won't be using crazy compilers
from the last century.

That said, I think that it would be lovely to just default to
USE_SHA1DC and just put the whole attack behind us. Yes, it's slower.
No, it doesn't really seem to matter that much in practice.

              Linus
