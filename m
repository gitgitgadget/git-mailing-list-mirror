Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3042CC2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 04:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0728460232
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 04:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhF1EFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 00:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhF1EFt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 00:05:49 -0400
Received: from act-MTAout5.csiro.au (act-mtaout5.csiro.au [IPv6:2405:b000:e00:257::7:42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3333C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 21:00:19 -0700 (PDT)
IronPort-SDR: 88FI9/bRqc46NNU1EWFlJH0oIr/MhLTSmWC8I4UhmLMcQxeBel5FOgVjkPpR4WzAgDHbhq7qXU
 Ye1+Kza+FtNg==
X-SBRS: 4.0
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AQNqFs65q2Esa7tNRSQPXwPjXdLJyesId70?=
 =?us-ascii?q?hD6qkRc3Bom6mj/PxG88516faZslgssQgb6LS90cu7MBHhHO9OgLX5VI3KNG?=
 =?us-ascii?q?OKhILPFuFfBODZsljd8kPFh41g/JYlX69iCMDhSXhW5PyKmTVQyuxQp+VvJp?=
 =?us-ascii?q?rY49vj8w=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G0AgDzR9lgjA9OdpJagQmEZGyFM4k?=
 =?us-ascii?q?EiDswnUoLAQEBD0EEAQGEUgKCciY4EwIEAQEBEgEBBgEBAQEBBgQCAhABAQE?=
 =?us-ascii?q?BKUOFdYZPAQIDIxUbGQgCEwsYAgImAgJXEwgBAYJtgwcBqwqBMoEBhGaDZIF?=
 =?us-ascii?q?jgRAqjWo3gVVEgTwPgm0+hRGCSoJkBIMaAYEOAYFDUZ9cWpxCLAeDI4EuC5A?=
 =?us-ascii?q?TjDMGDgUWEJUakG66bIFrgX4zGh+DPk8ZDo44jkI0agIGCgEBAwmMRAEB?=
X-IPAS-Result: =?us-ascii?q?A2G0AgDzR9lgjA9OdpJagQmEZGyFM4kEiDswnUoLAQEBD?=
 =?us-ascii?q?0EEAQGEUgKCciY4EwIEAQEBEgEBBgEBAQEBBgQCAhABAQEBKUOFdYZPAQIDI?=
 =?us-ascii?q?xUbGQgCEwsYAgImAgJXEwgBAYJtgwcBqwqBMoEBhGaDZIFjgRAqjWo3gVVEg?=
 =?us-ascii?q?TwPgm0+hRGCSoJkBIMaAYEOAYFDUZ9cWpxCLAeDI4EuC5ATjDMGDgUWEJUak?=
 =?us-ascii?q?G66bIFrgX4zGh+DPk8ZDo44jkI0agIGCgEBAwmMRAEB?=
Received: from mail-server.pawsey.org.au (HELO prod-mail.pawsey.org.au) ([146.118.78.15])
  by act-ironport-int.csiro.au with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 14:00:16 +1000
Received: from [192.168.42.112] (unknown [1.126.195.168])
        by prod-mail.pawsey.org.au (Postfix) with ESMTPSA id C3D9F32273B8
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:00:15 +0800 (AWST)
Subject: Re: Definition of "the Git repository"
To:     git@vger.kernel.org
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
 <435b0150-cd9f-32ce-7a07-3057ef20662a@iee.email>
 <12dd4f05-456f-c763-441e-5bb16634306a@pawsey.org.au>
 <60d9410bb07a1_aac5d20888@natae.notmuch>
From:   Kevin Buckley <Kevin.Buckley@pawsey.org.au>
Message-ID: <ec31434f-0c99-ffb7-6eb0-6ecb1f6e761c@pawsey.org.au>
Date:   Mon, 28 Jun 2021 12:00:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60d9410bb07a1_aac5d20888@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021/06/28 11:24, Felipe Contreras wrote:
> Kevin Buckley wrote:
> 
>> Everything within the .git directory "belongs", in my way of thinking,
>> to the "repository", that is, the directory that gets created when git
>> is (init)ialised.
>> 
>> For me, the 'objects", the 'ref/heads', the "staging area' and the like,
>> also lie within the repository.
> 
> Does it?
> 
> Suppose you have three directories, each with exactly the same contents
> in their corresponding .git directory, the only difference is the
> .git/index file:
> 
>   a) No .git/index file at all
>   b) The .git/index file doesn't have anything staged
>   c) The .git/index file contains some staged changes
> 
> Do you really consider them three different repositories?
> 
> In my mind the staging area is where you put stuff in preparation for
> the commit. The commit is part of the repository, the staging area
> isn't.
> 

I think I do consider them as different, yes, but in the sense that,
because the contents of any working directory can change in isolation
to the others, they have become different instances (perhaps clones?)
of the same repository.

Let's say I make two commits, that resulted in the same state of the
files in the working directory, but I make them in different order
in two of the working directories.

Clearly I need to sync the two different repositories in order to gain
a consistency across them, and that suggets, to me, that they should
be thought of as different.

Let's say I'd rsync-d one working directory, in which I'd made changes
on its branch, with an unchanged one on a different branch (not that
I'd recommend doing this without the utmost caution), then although the
sync will not have affected the original branch in the unchanged directory,
the git internals, stored in the .git repository, would have changed to
reflect the new state.

As to the staging area,

again, for me, Git has an understanding of a "staging area" based on its
inspection of the state of the working directory and a comparison of that
state with what it knows has been committed.

Given that one can stash uncommited changes fron the "staging area", I
think of both the "staging area" and various stashes as parts of the
repository, in that you can't have a "staging area", unless there's a
.git repository there to help instantiate the staging area".


Very much my perception of it all though: as others have pointed out,
there does seem to be some wriggle room in how it is percieved.

Kevin
