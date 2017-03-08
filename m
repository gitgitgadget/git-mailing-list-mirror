Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B2420135
	for <e@80x24.org>; Wed,  8 Mar 2017 22:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754203AbdCHWNU (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 17:13:20 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35971 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbdCHWNU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 17:13:20 -0500
Received: by mail-ua0-f193.google.com with SMTP id y16so7042057uay.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 14:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TpFd0+5bmtxD30l4Sn7GrdzQvX1IjppUCnhQAKsNjq8=;
        b=FQFUfEQQefxdEaDqIB76bm+kNNmKKESgDdEfmyNvlQWOfzciU/CIZ4s+I6HfJKgYnR
         W1iBv3arz506pjZUB9DXmCfCwAkgW2VvmESwNqDuOeOSFRZ264mS/6g1inKwQRoWe6k1
         wgwvHxfUNa1OEUNfpBWn/5tHBMkI7EYpWkcywdPSn4Sd0M+aKqd9qCn4jLFRXt332XJC
         +vaIFIBWvFO3U8khQHrnyiaqfojC1K6q5c464fmZLUzEpH+lMJFVgaDQC9be7oXff90H
         ozg+IyzSLNX12en8sIEv/LMx9CU6EKmDe2MgpDeAqNayFwV8QkkGKlusG4HtON8jskL7
         fiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TpFd0+5bmtxD30l4Sn7GrdzQvX1IjppUCnhQAKsNjq8=;
        b=umija2X0Id7WAbMg7xsA0dS3VU3fTe0AOMMKO9VshuYbfJZ4zOKfzNuMOPxCfqTbeG
         2/3DI8K34UE28May9KdkqKPO9UnPALnJUlj4BXjizWHC3zuI8DWtSfEgAUon1tDK2itd
         u465mwC1GliCscRf3JLcgdASBxEJZpUrs5xOt7xlFqky3fAotpgdc9QBqThP1O+tqYaO
         bIXgYnY6//Yn/7IczVLIf7w3X58cgh7CniJF5OSgVxKqAosyhPkkPR6+Hp18QrZyz96V
         M8HVSyt6cxsV3WUs31z8I23XNi9CDIRHwgwQo8u/JitBe/l4uHTXrayAlpGp7OpDaRwn
         Po7A==
X-Gm-Message-State: AMke39mMYYSgTazSV4bfJNAdKqsBzRYByx1dhZjCJiURyEi/nk6Ca4CSVhPViyqrF6JAzK8UkrWad1RJEMhzJA==
X-Received: by 10.31.47.85 with SMTP id v82mr5302795vkv.2.1489011198547; Wed,
 08 Mar 2017 14:13:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.87.218 with HTTP; Wed, 8 Mar 2017 14:13:18 -0800 (PST)
In-Reply-To: <CAME+mvWVDPT+-F7Z-O=XR_EN4qeNEoQ5ksLpLVkVBb0O9LKROg@mail.gmail.com>
References: <0102015aae7b8536-00c57d0a-1d48-4153-a202-87c4ea9e0e19-000000@eu-west-1.amazonses.com>
 <E1cldl4-0006L6-CU@mylo.jdl.com> <CAME+mvWVDPT+-F7Z-O=XR_EN4qeNEoQ5ksLpLVkVBb0O9LKROg@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Thu, 9 Mar 2017 03:43:18 +0530
Message-ID: <CAME+mvV__RT5fbSBRU_SwP69xC-JuBE5bmfRbw91VN36-ToxZA@mail.gmail.com>
Subject: Re: [PATCH] t2027: avoid using pipes
To:     Jon Loeliger <jdl@jdl.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

But when I read the function carefully, it only removes the trash files created
when test_failure is equal to zero. But as far as I know, I can see the files
being removed even when a test_failure is non-zero for some test script.

On Thu, Mar 9, 2017 at 3:08 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Whenever a test suite is executed, after finishing every test, after running
> all tests, the function test_done is called. You may find this function in
> test-lib.sh . This function displays the result of the test and also removes
> the trash created by running the test.
>
> On Wed, Mar 8, 2017 at 9:14 PM, Jon Loeliger <jdl@jdl.com> wrote:
>> So, like, Prathamesh Chavan said:
>>> The exit code of the upstream of a pipe is ignored thus we should avoid
>>> using it. By writing out the output of the git command to a file, we
>>> can test the exit codes of both the commands.
>>>
>>> Signed-off-by: Prathamesh <pc44800@gmail.com>
>>> ---
>>>  t/t2027-worktree-list.sh | 14 +++++++-------
>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
>>> index 848da5f..daa7a04 100755
>>> --- a/t/t2027-worktree-list.sh
>>> +++ b/t/t2027-worktree-list.sh
>>> @@ -31,7 +31,7 @@ test_expect_success '"list" all worktrees from main' '
>>>       test_when_finished "rm -rf here && git worktree prune" &&
>>>       git worktree add --detach here master &&
>>>       echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short
>>> HEAD) (detached HEAD)" >>expect &&
>>> -     git worktree list | sed "s/  */ /g" >actual &&
>>> +     git worktree list >out && sed "s/  */ /g" <out >actual &&
>>>       test_cmp expect actual
>>>  '
>>
>> I confess I am not familiar with the test set up.
>> However, I'd ask the question do we care about the
>> lingering "out" and "actual" files here?  Or will
>> they silently be cleaned up along the way later?
>>
>> Thanks,
>> jdl
