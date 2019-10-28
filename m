Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0EEA1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 22:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfJ1WNE (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 18:13:04 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:38275 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfJ1WNE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 18:13:04 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iPDG2-0003pt-Bl; Mon, 28 Oct 2019 22:13:03 +0000
Subject: Re: conflict markers on recursive strategy with diff3 enabled
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAOc6etaQvNChdRZ70xsYQxqtgmZVxaKV9K7_zZeET3JuQ4HEXg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <e26d24b2-6fca-8546-f2b3-bf4660db8184@iee.email>
Date:   Mon, 28 Oct 2019 22:13:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOc6etaQvNChdRZ70xsYQxqtgmZVxaKV9K7_zZeET3JuQ4HEXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Edmundo ,

On 25/10/2019 01:13, Edmundo Carmona Antoranz wrote:
> Hi!
>
> I'm sitting down hunting for conflict examples and while looking
> through past conflicts in git I found one that has a format that I
> hadn't seen before. When merging the parents of 8b79343fc0 we get
> this:
>
> <<<<<<< HEAD
>
> /*
> * Unlink the .pack and associated extension files.
> * Does not unlink if 'force_delete' is false and the pack-file is
> * marked as ".keep".
> */
> extern void unlink_pack_path(const char *pack_name, int force_delete);
> ||||||| merged common ancestors
>>>>>>>>>> Temporary merge branch 2
> =======
>>>>>>>> 8b79343fc0^2
> That is with merge.conflictStyle set to diff3. What I would like to
> know is if the details about how the additional information that is
> not normally seen on a conflict has to be interpreted (to be read as
> "the part about the temporary branches").
- "Temporary merge branch"

I believe this happens when no merge-base is found between the two lines 
of development that are being merged, so a fake merge-base is created to 
allow the regular 3-way merge to occur.

It may be described in the technical section of the Documentation.

>   I see some explanation about
> it in [1] but when checking inside "git help merge" all I see is that
> when you are using diff3 you will get the content of the parent but
> there's more stuff than just that. Is it documented somewhere?
>
> Thanks!
>
> [1]https://stackoverflow.com/questions/31392513/git-diff3-conflict-style-temporary-merge-branch

Philip
