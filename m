Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24109C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 22:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjBCWjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 17:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjBCWjf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 17:39:35 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FECD442E8
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 14:39:33 -0800 (PST)
Received: from host-2-103-194-72.as13285.net ([2.103.194.72] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pO4iR-0001v5-6T;
        Fri, 03 Feb 2023 22:39:31 +0000
Message-ID: <01dd49c1-026d-1215-dd06-02fe73ce14f8@iee.email>
Date:   Fri, 3 Feb 2023 22:39:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Hash for a commit sourcetree beside to a commit hash
Content-Language: en-GB
To:     Andry <andry@inbox.ru>,
        =?UTF-8?B?xJBvw6BuIFRyw6LMgG4gQ8O0bmcgRGFuaA==?= 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
References: <1798489336.20230203042837@inbox.ru> <Y9xq5VAMjzUqTb6X@danh.dev>
 <563617028.20230203052145@inbox.ru>
 <22255406-42da-9ac3-4783-11a035877a3c@iee.email>
 <1309893232.20230203163720@inbox.ru>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <1309893232.20230203163720@inbox.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02/2023 13:37, Andry wrote:
> Hello Philip,
>
>
>
> Friday, February 3, 2023, 2:11:19 PM, you wrote:
>
> PO> On 03/02/2023 02:21, Andry wrote:
>>> Đoàn, 
>>> Friday, February 3, 2023, 5:01:09 AM, you wrote:
>>> ĐTCD>         git rev-list <a-commit-tish> |
>>> ĐTCD>         while read commit; do
>>> ĐTCD>                 if test $(git rev-parse $commit^{tree}) = $hash; then
>>> ĐTCD>                         echo $commit
>>> ĐTCD>                         break
>>> ĐTCD>                 fi
>>> ĐTCD>         done
>>>
>>> Nice, but I can not apply this over a git hub or a web interface without a clone.
> PO> As a 'Distributed'-VCS, cloning the repository would be the de-facto
> PO> normal approach, otherwise you have re-invented centralised VCS ;-)
>
> Cloning repository is a heavy operation by downloading everything instead of search a single commit.
> And searching at the remote does not make it a central.

It's not local though ;-)

Given that there's usually a trusted remote in this scenario (that's why
your searching it) it does feel very like a 'centralised' VCS, even if
formally is isn't stated as such.
>
> PO> Alternatively, you could approach the server (hub/web interface)
> PO> provider to see if they are willing to provide that level of search
> PO> interface.
>
> The GitHub already provides that in the search field. Just input a hash and see what happens.

There is still a need to walk the commit graph to discover each commit's
tree to do the look-back. There are some catch 22 steps to be done.

How do you determine the sourcetree has that starts this process? (have
we accidentally created an XY problem?)

Obliterating history is hard [1].
--
Philip

[1]
https://lore.kernel.org/git/5cab1530-f8b6-cef3-7b93-48fad410a160@iee.email/
