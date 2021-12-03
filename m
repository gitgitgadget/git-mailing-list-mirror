Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B60C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 16:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382143AbhLCQtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:49:43 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:8458 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354840AbhLCQtn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 11:49:43 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mtBhR-0002Qb-BT; Fri, 03 Dec 2021 16:46:17 +0000
Message-ID: <90007c1b-9183-d7f4-f7d0-6a90c5f6e247@iee.email>
Date:   Fri, 3 Dec 2021 16:46:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH 0/1] making --set-upstream have default arguments
Content-Language: en-GB
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git@vger.kernel.org
References: <b9bfd60b-9e4e-caa6-9836-e0f0e984a997@iee.email>
 <20211203160346.18221-1-chakrabortyabhradeep79@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20211203160346.18221-1-chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/12/2021 16:03, Abhradeep Chakraborty wrote:
> Philip Oakley wrote:
>
>> Can we protect the expectations of a user with a `pushDefault` setting?
> Are you talking about 'push.default'? If so, then I think, the proposed
> change would not affect the working of 'push.default' (if the idea is
> implemented in the right way). I am adding tests to be sure about it. 
>
>> If the user has one set, then the upstream won't be where they push in a
>> triangular repo workflow.
> Pardon me, I am unable to understand what you are trying to say. Could you
> please explain a little bit?
>
> Thanks.
>
In my scenario I am tracking various upstream repositories, none of
which I have push permission for. This means I have set up a
`remote.pushDefault` [1] to the remote "my", which is mapped to my
GitHub repo where I can publish work (i.e. push). 

So when I push, I am pushing to "my" remote, but when rebasing, the
upstream is not that destination, and in a collaboration environment,
may not even be the place I first forked from (e.g. the distinction
between 'git.git' [git], 'git-for-windows.git' [gfw], and Junio's repo
[gitster], all with the same root). I can then either send PRs (if
acceptable) or send patches (cover letter link to my publish repo).

In the case where a user has set their remote.pushDefault, then it's not
clear that there should be a default at all, though I maybe
misunderstanding the approach here.

Philip

[1]
https://git-scm.com/docs/git-config#Documentation/git-config.txt-remotepushDefault
