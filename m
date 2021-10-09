Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430C3C433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 10:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B99D60F55
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 10:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhJIKed (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 06:34:33 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:43152 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhJIKec (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 06:34:32 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mZ9ec-0002M5-4h; Sat, 09 Oct 2021 11:32:34 +0100
Subject: Re: Some problems for git beginners
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        ZhangJinbao <zhang709787793@icloud.com>, git@vger.kernel.org
References: <2EC9E24E-A8FD-4851-9F6A-F3D104465A23@icloud.com>
 <ffe633c5-151a-8646-20ef-be4f50c5f59e@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <4ef81a4e-e832-1968-3f31-5f15cd0c7320@iee.email>
Date:   Sat, 9 Oct 2021 11:32:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ffe633c5-151a-8646-20ef-be4f50c5f59e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/10/2021 10:12, Bagas Sanjaya wrote:
> On 09/10/21 14.43, ZhangJinbao wrote:
>
>> Third, when a commit event occurs, the current blob file stores the
>> full amount of data, while the previous version stores the
>> incremental data
>>
>
> When you `git commit`, Git will initially write objects related to the
> commit (blob, tree, and commit) as loose objects. Some point on the
> time, Git will repack many loose objects into one big packfile and
> write the corresponding pack index. Delta compression is applied when
> writing the packfile.
>
Git is multi-layered, and multi-faceted. So often the impression given
isn't the same as what happens internally.

All commits are full snapshots, even if git (normally) shows only the
changes for previous diffs.

But then git will, at a convenient point 'pack' all those snapshots
(fairly efficiently) so that the local git storage of the whole
repository, with full history, (typically) is no bigger than the checked
out files. The packing is part of that layering.

There are similar facet/layer effects from the Staging area ("index") /
Object store viewpoints.

The https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain
is worth a read, along with other descriptions.

Philip

