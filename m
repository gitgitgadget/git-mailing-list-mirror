Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 10790 invoked by uid 107); 4 Oct 2009 13:12:18 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 09:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347AbZJDNBa (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 09:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756884AbZJDNB2
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 09:01:28 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:36262 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757274AbZJDNBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 09:01:06 -0400
Received: by ywh6 with SMTP id 6so1804304ywh.4
        for <git@vger.kernel.org>; Sun, 04 Oct 2009 06:00:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=ictFAgRKRr1QWiEOLKUm3gQpyHpIT3Aa/50YKE/EwOA=;
        b=nTpbWnIsb55HZfBpoqxWmHjBjVq7eq2CZuAm/iA6QbvW5W0AO7HtjLhYVgQQ7bh+E3
         2QvzYmJ3eWph9TMrgVITeJJPVxvD4uv8GzqJjK/DPVr2cXn5nNgN2LJSsrQdKY01Teiu
         WaVXFs9dcWJbMmaDCQbG7zXx+kfgShtCplCWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=rxAd58od8RfuvMW2K7GitDfqBSaMx0rtn8li3H+iPBYudnFbvkTwkwd1CGknE+0h6e
         sWKaXJ13bVI4P/2/mz2QNSKgetKl/x/yMhmuwraQKSmNq7QnwWXd9NTPZEia+QNN3diD
         8fbL0WZCiFriL1V5FdhUDROX+GSq4lP3MIvRk=
MIME-Version: 1.0
Received: by 10.100.78.16 with SMTP id a16mr4270843anb.180.1254661229152; Sun, 
	04 Oct 2009 06:00:29 -0700 (PDT)
In-Reply-To: <9e4733910910011604w68cdca86l2baa2f2fe4db4a32@mail.gmail.com>
References: <9e4733910910011604w68cdca86l2baa2f2fe4db4a32@mail.gmail.com>
Date:	Sun, 4 Oct 2009 09:00:28 -0400
Message-ID: <9e4733910910040600g2cbd1deah6e7ae3ad9a4aa54e@mail.gmail.com>
Subject: Re: stgit, rebasing with 100 patches
From:	Jon Smirl <jonsmirl@gmail.com>
To:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Oct 1, 2009 at 7:04 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> I have 100 patches loaded into in stgit. My tree is at 2.6.30. Now I
> want to rebase to 2.6.31-rc1. About 30 of these hundred patches got
> committed in this interval.
>
> If I rebase directly to 2.6.31-rc1 I end up with a bunch of merge
> conflicts as the patches are applied. That's because patches 'a,b,c'
> got applied in the merge window. When I push 'a' back down it sees the
> combination of 'a,b,c' not just 'a'. It is unable to figure out that
> 'a' was applied and then 'b' and 'c' applied on top of it.
>
> Is there a better way to locate the patches the got applied?

A solution to this is to make an option on rebase that walks the patch
stack forward one commit at a time.

What does the --merged option do on stg rebase? The doc is rather sparse.


-- 
Jon Smirl
jonsmirl@gmail.com
