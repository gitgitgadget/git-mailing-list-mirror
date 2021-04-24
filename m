Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E236C433ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 01:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF57B61153
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 01:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhDXBN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 21:13:29 -0400
Received: from marcos.anarc.at ([206.248.172.91]:47486 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhDXBN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 21:13:29 -0400
Received: by marcos.anarc.at (Postfix, from userid 1000)
        id 940AB10E237; Fri, 23 Apr 2021 21:12:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
        s=marcos-debian.anarcat.user; t=1619226771;
        bh=GbjwoHugyJ7YYReaq8GuQRkJcWBH/055WRovAcZyyqU=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=aogqxjAC+ccSyRHI99y1ymJXyn/RT5tZ1GGwOJVpNPceThTUZAaqyHm0LF3/1g03/
         N8bhosOznkVoFXHNXVp9HLL7ENvsaL7Fxi+qLKCsw/O43dsHP6vvuKgz9bRs/ShUwe
         bya88/InCxzUVEsYYCk4nOFMfYrJAzLc1nnZYJsKjZ5le2kDPWaA+9WNYtlyuVGppG
         qpawT287PCpD50awh0fMCAHOb0QyAeaoH6ACotRQvbtx79gRt8WGslQQPCHw6JY0O6
         B4ijT372mpLna+XHnk4sKsGJiQSYzB/Du+KZIS7nz49jj2iimeOCPGOdrj8ZHpyhEO
         F78lW3+0/y/JA==
Received: by angela.anarc.at (Postfix, from userid 1000)
        id 47E25AC08E; Fri, 23 Apr 2021 21:12:51 -0400 (EDT)
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: RE: how to rename remote branches, the long way
In-Reply-To: <60836fa129078_ff602089c@natae.notmuch>
Organization: Debian
References: <87mttofs5t.fsf@angela.anarc.at> <60836fa129078_ff602089c@natae.notmuch>
Date:   Fri, 23 Apr 2021 21:12:51 -0400
Message-ID: <87k0osfpt8.fsf@angela.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-23 20:08:49, Felipe Contreras wrote:
> Antoine Beaupr=C3=A9 wrote:
>> Before people start throwing things (like `git push origin oldref:newref
>> :oldref`) at me, consider that I've been beating my head against this
>> for a while, and everywhere I look basically suggests this:
>>=20
>>     git branch -m to_branch
>>     git push origin from_branch:to_branch :from_branch
>
> Better:
>
>   git push origin from_branch:to_branch :from_branch &&
>   git branch -m from_branch to_branch

How so?

>> I wrote this primarily with the "master to main" migration, because a
>> bunch of projects (including mine) are suddenly, actually migrating
>> their main branch from master to main. Personnally, it's because I'm
>> tired of being yelled "master" from my shell prompt all the time, but
>> naturally, I guess opinions on the matter vary.
>
> Just tell git to stop bothering you:
>
>   git config --global init.defaultbranch master

I think you misunderstood me; I am tired of seeing the name "master"
everywhere. I actually did this, when it started working:

    git config --global init.defaultbranch main

And the reason I wrote this is to fix legacy.

A.

--=20
In god we trust, others pay cash.
                        - Richard Desjardins, Miami
