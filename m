Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56E920FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 20:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbcF2UVW (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 16:21:22 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38564 "EHLO
	mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbcF2UVV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 16:21:21 -0400
Received: by mail-it0-f53.google.com with SMTP id h190so52331314ith.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 13:20:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+tLNwcoI9iAM5N45zg9enYZJVrezhreFJOvVwu97bOc=;
        b=YNgsk+XXc6qLYxS+HAJSqTbzlFNGEZXKthqTrKs1MLoh4C4qdGiKyh6wEDUVlfKeOp
         zc2L+Z2UvJOn4byslr7QFBCxl2/UebEEZ0aUjyuMG+tDN3+qY4m5/ufhdkLu+cTlPNvl
         J8+SlmLjN1dqSQ8LsXDCc4rcpKeQ0TadFaT4tubczmrHMedvTT6vH0sflHUXO+fuuBu5
         10VoKy2R3U4nUH+zQQYX1V347qzXuNzl9nqGOZX2e7y4w7csmB5UyOGLjSgAC3oDOGvp
         30qiPYfkSgobezs6f+kYwr6GRQ3KO1dGHxynUwStitAHX+PmWA2O30D1l8rR9GcZHfnL
         iAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+tLNwcoI9iAM5N45zg9enYZJVrezhreFJOvVwu97bOc=;
        b=g192W7cyhCfkqgJUb98oGpMplMhqjCZcwD2u/4duYkErQzztYmM1n70hDDD+0t8q8S
         /hbkmwwIistGHWiZlj2iWYy1aH8iY9Y9MyXjKiijLhBK0OQkQ/GD/EZB8JAvuDtwx5qp
         ZiGwIEExFni0xOPv+gPxvu/1Diz+hTVXQCu/LxqzZlD07gunIHjBuqT1vtCMxDv01JhH
         q2ShAiegYxi1HkZJni1FqX+rR1qrOQnEIgaF4Ba1USXUzCtTPb3PLJYVL8jPnE5cWil+
         zEQlZqWtWW0la3w7iYd6zfSs+sYJ+HUP7S6isSQoENJaRoAIy0duOIDzvpanJNM10z0D
         N0vg==
X-Gm-Message-State: ALyK8tKSGcSkPtDfrqtfh0uGljul3Sd6SF9G5xFKpPaI6wmeQ0uuIxhgLgt26N81j9Ca7Td0JIOMysTKykYU2x1j
X-Received: by 10.107.186.196 with SMTP id k187mr11810797iof.173.1467231638506;
 Wed, 29 Jun 2016 13:20:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Wed, 29 Jun 2016 13:20:37 -0700 (PDT)
In-Reply-To: <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com> <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 29 Jun 2016 13:20:37 -0700
Message-ID: <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
Subject: Re: topological index field for commit objects
To:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 11:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Jun 29, 2016 at 11:31 AM, Marc Strapetz
> <marc.strapetz@syntevo.com> wrote:
>> This is no RFE but rather recurring thoughts whenever I'm working with
>> commit graphs: a topological index attribute for commit objects would be
>> incredible useful. By "topological index" I mean a simple integer for which
>> following condition holds true:
>
> Look for "generation numbers" in the list archive, perhaps?

Thanks for the pointer to the interesting discussions.

In http://www.spinics.net/lists/git/msg161363.html
Linus wrote in a discussion with Jeff:

> Right now, we do *have* a "generation number". It's just that it's
> very easy to corrupt even by mistake. It's called "committer date". We
> could improve on it.

Would it make sense to refuse creating commits that have a commit date
prior to its parents commit date (except when the user gives a
`--dammit-I-know-I-break-a-wildy-used-heuristic`)?

With the proposal to refuse an earlier committer date we would avoid
the corruption by mistake and only allow for corruption by actual
users intention. And then going forward we could rely more on the
committer date than we do today (i.e. some algorithms can go faster)?
For that we'd
 * need to document, what stuff actually breaks if the user overwrites
    the committer date to be earlier
 * and add a switch `--go-slow-because-dates-are-broken`

This seems to be the easiest fix in 2016 to me as that would require
to make just a very small change in commit creation, and we can postpone
the second part (relying even more on dates) until someone wants to fix it?

Thanks,
Stefan

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
