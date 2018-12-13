Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6773020A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 16:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeLMQPu (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 11:15:50 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:35204 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeLMQPu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 11:15:50 -0500
Received: by mail-qk1-f172.google.com with SMTP id w204so1444326qka.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 08:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LVJS6NqNDIyPkXVJdAeaVX8FjBfEc0RS1pzx4eIIqlw=;
        b=gv2mwrQzIYX3NptzQmN/uTECpXfYU+8XaCSFhqBn5d5VSHl+s80FzhEbWSwvnvMb1l
         j55pWzXlH+/RkRc9/Uu9m0qUa1NrhFODV2mkEwOq+jOJC2miUq+tnygEp9U5Hn3YTuka
         5WyqMsSw5GJ/58h6y4v7Q7TYvU7rshR5tNnkhKZVEMsA67YCMPiOjJCGUQGzgqzqnCL3
         ee1vZd6DfQXdSgzBZtmaxR9nmwC3ibyxYHoegFW1kNgt0Iv06Yh3rk/lPjCs+wompxMD
         ksRTqTOvTchK+XhUJnjcdnAj/L5j7ZeH/vN6IGGeKb/0tBqgWI+tktvU363JYI0L+tAn
         4cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LVJS6NqNDIyPkXVJdAeaVX8FjBfEc0RS1pzx4eIIqlw=;
        b=q/a4Lvki3rwYD7XlqzmVBrsFvroU7aA7vNtDdnEFzu20gAzCg8IQtuuePqDM4lp1H0
         x4r+XFRNAPw5wV7rOSz8jdts//73eS68rhjkrbl9j8NvdWOpd+vCj3lAcghok5go2Hm/
         zWpWNA8CHeZtUyCNuyrKsbOwpTL6TYW6qTVozxrI/JrtpW1mFL9fbbOfT2jU3RJibgho
         hINuyaYgHtYHrW7Xd/s580buwr3kDN56JxJ1OgpOUFDIvuraQ0TjhAH1eV62OlsO6ekk
         d2ViQ0bvoKUe/rrYMKCfR2M249rQKDIHa7nrx984+n4hkhI+NH+Y+eKhSUnuq2Ff7KRS
         vnaw==
X-Gm-Message-State: AA+aEWZKHHz4an2rey0refE6WBOncjuQK4JnwoZWTPUvN+XYrPE8pAKh
        LPKIJHvkEhOI6fbHQjga19E=
X-Google-Smtp-Source: AFSGD/U1RuVB9EcvysH40m+7pR4yDHrLIuGXwu3wV1AN8T+NqjgFX3xazN0NGK89QJX4kZby0Vid/A==
X-Received: by 2002:a37:5f05:: with SMTP id t5mr23145326qkb.47.1544717748561;
        Thu, 13 Dec 2018 08:15:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:b482])
        by smtp.gmail.com with ESMTPSA id t140sm1124039qke.6.2018.12.13.08.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 08:15:47 -0800 (PST)
Date:   Thu, 13 Dec 2018 08:15:46 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>, kernel-team@fb.com,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCHSET] git-reverse-trailer-xrefs: Reverse map cherry-picks
 and other cross-references
Message-ID: <20181213161546.GV2509588@devbig004.ftw2.facebook.com>
References: <20181211234909.2855638-1-tj@kernel.org>
 <xmqqo99rjjcu.fsf@gitster-ct.c.googlers.com>
 <20181212145456.GQ2509588@devbig004.ftw2.facebook.com>
 <xmqqefamgmey.fsf@gitster-ct.c.googlers.com>
 <20181213034041.GR2509588@devbig004.ftw2.facebook.com>
 <xmqqftv2f05j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftv2f05j.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Junio.

On Thu, Dec 13, 2018 at 02:47:36PM +0900, Junio C Hamano wrote:
> Tejun Heo <tj@kernel.org> writes:
> 
> > Hmmm... I see.  I still have a bit of trouble seeing why doing it that
> > way is better tho.  Wouldn't new-object-hook be simpler?  They'll
> > achieve about the same thing but one would need to keep the states in
> > two places.
> 
> The new-object-hook thing will not have keep the states.  Whenever
> Git realizes that it created a new object, it must call that hook,
> and at that point in time, without keeping any state, it knows which
> objects are what it has just created.  So "in two places" is not a

Yeap, that's what I was trying to say.

> problem at all.  There is only one place (i.e. the place the sweeper
> would record what it just did to communicate with its future
> invocation).
> 
> A new-object-hook that will always be called any time a new object
> enters the picture would be a nightmare to maintain up-to-date.  One

But I didn't know this.  I probably am too naive in thinking so but
it's a bit surprising that there's no single / few chokepoints for
repo updates that we can attach to.

> missed codepath and your coverage will have holes.  Having a back-up
> mechanism to sweep for new objects will give you a better chance of
> staying correct as the system evolves, I'd think.

The duplicate state tracking still bothers me a bit (duplicate in the
sense that the end results are the same) especially as this would mean
any similar mechanism would need to track their own states too, but I
really don't have the full (not even close) picture here and it can
easily be me missing something.

Anyways, I'll wait for Stefan to chime in.

Thanks.

-- 
tejun
