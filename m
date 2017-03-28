Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005081FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 00:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753652AbdC1Axm (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 20:53:42 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35975 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753686AbdC1Axl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 20:53:41 -0400
Received: by mail-pg0-f68.google.com with SMTP id 81so17000378pgh.3
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 17:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6SnCwp2jGhBOCkI3WlQShUFtzk/NULUvxX4CxmeNM0I=;
        b=QOT4x3+/CiFYB4iqwFaW8IHWr7pTedfsZUQKm62fcW8HY5cuOta15J9I8SBg4ieDPD
         p1IetK1jX8JTeIyDQFigT6WKJT+1mmYxJ0OKM2h3jk+WFSOSg50J2nEaiDFFRPiNjMp3
         isrvNaSfhJtSqaHNQkITJ4xZND9yDGTAhe0u3dWQ1Q4L0t5iGrTtICsaegaYdjoYkoIo
         39Dw/rNiSHkOhWB7RecAGsensNexIfoYXl5jHHZACWZXVeBKCJXVzTtdWmYGXy12hZ4N
         eyvJZL8yXZ6Gx9C+klkn69MTfg5D19+De5IGaffPo072tJNVRSMLxi0zYLU1ExXw+zSZ
         7FOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6SnCwp2jGhBOCkI3WlQShUFtzk/NULUvxX4CxmeNM0I=;
        b=WyVb655hPSVx6JYY30a3mccfGueNJd54YLuok7W7aqeoBQPKbxIQ12pygDP/O9xc6P
         MwJO6CLJAdXxqkJVGWFEuW8aA+RYVdWMWn0+V4CSLFF9SULHeIYIJ2+VqxUjx7Xs1skG
         RPIYqFxaQmE1DqKFaPemlCSKio/dstSooDprf/Xe/+fv8f8JuyackfXvFP41A1sdsuWW
         7DPEY7AoNKoXU1IDSpY1HFmYaDi27BvjOXRCKFQow7+0KowibMY+H6GVtA4Bodzl6HWu
         3vivENA+JFnjK6pWHbM/FY5E2ci0WffkNEymYD8Ovx1VB29eiShCWcLkrwirGmHm435j
         47LA==
X-Gm-Message-State: AFeK/H1gYQGiTYh3RFfHvsCv2syFSpuQ1oWqlVF1ZKjU/HK4UZClZ0e1UX179p4QtPWtdw==
X-Received: by 10.99.149.9 with SMTP id p9mr27058206pgd.112.1490662289582;
        Mon, 27 Mar 2017 17:51:29 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:c051:ab1a:5a93:a0ac])
        by smtp.gmail.com with ESMTPSA id c1sm3275949pfk.112.2017.03.27.17.51.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Mar 2017 17:51:28 -0700 (PDT)
Date:   Mon, 27 Mar 2017 17:51:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Romuald Brunet <romuald@chivil.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] push: allow atomic flag via configuration
Message-ID: <20170328005126.GP31294@aiede.mtv.corp.google.com>
References: <1490375874.745.227.camel@locke.gandi.net>
 <20170324184550.3l6mw4ybynizblsm@sigill.intra.peff.net>
 <xmqqmvca79sh.fsf@gitster.mtv.corp.google.com>
 <1490603272.9788.7.camel@locke.gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490603272.9788.7.camel@locke.gandi.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Romuald Brunet wrote:
> On ven., 2017-03-24 at 12:29 -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:

>>> My one question would be whether people would want this to actually be
>>> specific to a particular remote, and not just on for a given repository
>>> (your "site-specific" in the description made me think of that). In that
>>> case it would be better as part of the remote.* config.
>>
>> Yeah, I had the same reaction.
>>
>> Conceptually, this sits next to remote.*.push that defines which set
>> of refs are sent by default, and remote.<name>.pushAtomic does make
>> sense.  If (and only if) it turns out to be cumbersome for somebody
>> to set the configuration for each and every remote, it is OK to also
>> add push.atomic to serve as a fallback for remote.*.pushAtomic, I
>> would think, but adding only push.atomic feels somewhat backwards.
>
> Thanks for your feedback
>
> I'm mostly using single remotes that's why I didn't even think of making
> it configurable per remote. But you're right that makes more sense.
>
> I'll try to make that modification to the patch.
>
> As for my use case: I'd like to use default atomic pushes when pushing a
> new tag among our stable branch, but inevitably forgetting to rebase
> beforehand. Therefore pushing a "dangling" commit/tag

Making it per-remote would also address my concern about scripts.
Existing scripts may be using

	git push $url $refs

and relying on the push to partially succeed even when some refs
cannot be fast-forwarded.  (For example, I had such a script that did

	git push my-mirror refs/remotes/origin/*:refs/heads/*
	git push my-mirror +origin/pu:pu

because the first command would fail to update pu, and then the second
command would clean up after it.)  A configuration that globally
changes the effect of "git push" to mean "git push --atomic" would
break such scripts.  A per-remote configuration is tightly enough
scoped to not be likely to cause unrelated breakage for users that run
scripts written by others.

Thanks and hope that helps,
Jonathan
