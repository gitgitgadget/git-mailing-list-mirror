Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3512022D
	for <e@80x24.org>; Thu, 23 Feb 2017 17:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbdBWRUJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 12:20:09 -0500
Received: from lang.hm ([66.167.227.134]:60157 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbdBWRUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 12:20:05 -0500
X-Greylist: delayed 680 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Feb 2017 12:20:01 EST
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v1NH0Kbi008180;
        Thu, 23 Feb 2017 09:00:20 -0800
Date:   Thu, 23 Feb 2017 09:00:20 -0800 (PST)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Joey Hess <id@joeyh.name>
cc:     git@vger.kernel.org
Subject: Re: SHA1 collisions found
In-Reply-To: <20170223164306.spg2avxzukkggrpb@kitenet.net>
Message-ID: <nycvar.QRO.7.75.62.1702230857420.6590@qynat-yncgbc>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 23 Feb 2017, Joey Hess wrote:

> https://shattered.io/static/shattered.pdf
> https://freedom-to-tinker.com/2017/02/23/rip-sha-1/
>
> IIRC someone has been working on parameterizing git's SHA1 assumptions
> so a repository could eventually use a more secure hash. How far has
> that gotten? There are still many "40" constants in git.git HEAD.
>
> In the meantime, git commit -S, and checks that commits are signed,
> seems like the only way to mitigate against attacks such as
> the ones described in the threads at
> https://joeyh.name/blog/sha-1/ and
> https://joeyh.name/blog/entry/size_of_the_git_sha1_collision_attack_surface/
>
> Since we now have collisions in valid PDF files, collisions in valid git
> commit and tree objects are probably able to be constructed.

keep in mind that there is a huge difference between

creating a collision between two documents you create, both of which contain a 
huge amount of arbitrary binary data that can be changed at will without 
affecting the results

and

creating a collision betwen an existing document that someone else created and a 
new document that is also valid C code without huge amounts of binary in it.

So, it's not time to panic, but it is one more push to make the changes to 
support something else.

David Lang
