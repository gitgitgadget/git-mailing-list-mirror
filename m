Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FE3420135
	for <e@80x24.org>; Wed,  8 Mar 2017 22:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754509AbdCHW2Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 17:28:24 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33866 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbdCHW2W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 17:28:22 -0500
Received: by mail-ua0-f196.google.com with SMTP id 72so7059815uaf.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 14:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IMm4/QlDuc0uwIfIZYk8mI4gpx3w7/s5uZyw7YwO1TM=;
        b=GbMZn9M+vXyR3I5//HstqBnwGhvgHMYjs1C2N9lAj0a7RarvWucYuCChidX7r/3MBA
         JnzRPXpYBcKj7K9LbPCWOt0aOrCTpdKCN+C9NgDjiy6oemj/5FB8QoP/739BjT4iHJoN
         Va5gSEaeHnVpmcyikRqwGQzs8zN5/zNrIQpz8ES2rv1yYWZkV/Nf9iKP4ViMqvwjCIYr
         nDn38m5T4at+VlbPdePOTY+LjiRgEVa6iZmgvlv0ykfEBTAj2/hnKdKRq3/JnLGX2jGM
         CvEAQq1w8+pg76I6N3oinpo5li95xr2sCrveFRNkrXiNpnKFMI0Gp8OCoJCntJPm3pWA
         lVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IMm4/QlDuc0uwIfIZYk8mI4gpx3w7/s5uZyw7YwO1TM=;
        b=c49kBlyjFDLcVVPiPG2XJF32vk8mCqws4AgxkX3gkdqDDHfSWvz/oHdzst4MY8PK3B
         gCxwCkATInN4H7Cfifk7CbFg/baPjt8WhfCf0pJh9Maq4Ow9xNSCcm5uJz+OunQ+2W+1
         eEsLrHrVbG2k/IlPviGzeLEOc/uDf0YILI+9pFzID2fNNSafYZdQ0iRotnkkybgtkSo6
         zU08oVf5Sh34MzJWtQGIQqor5ERnEnaB6rFBHdj5Od6c6uzU8W5OZ7fxJO7dlrAQQmJz
         gTarfZMzgd8ZrtVPWG0X4iczOoLh2SvAgUG6iPQNT3vOcioxoR9TNxMr0rK+glO6s2xQ
         u/MQ==
X-Gm-Message-State: AMke39mTAHrPBWeyUQ53fHDBc+52U2LrUiiR+nhPOVAn+x2bRaH4jNcI4f/bdi2XgsX8LgrtajWXQTolhy0iJA==
X-Received: by 10.31.182.216 with SMTP id g207mr5253390vkf.85.1489009119861;
 Wed, 08 Mar 2017 13:38:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.87.218 with HTTP; Wed, 8 Mar 2017 13:38:39 -0800 (PST)
In-Reply-To: <E1cldl4-0006L6-CU@mylo.jdl.com>
References: <0102015aae7b8536-00c57d0a-1d48-4153-a202-87c4ea9e0e19-000000@eu-west-1.amazonses.com>
 <E1cldl4-0006L6-CU@mylo.jdl.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Thu, 9 Mar 2017 03:08:39 +0530
Message-ID: <CAME+mvWVDPT+-F7Z-O=XR_EN4qeNEoQ5ksLpLVkVBb0O9LKROg@mail.gmail.com>
Subject: Re: [PATCH] t2027: avoid using pipes
To:     Jon Loeliger <jdl@jdl.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever a test suite is executed, after finishing every test, after running
all tests, the function test_done is called. You may find this function in
test-lib.sh . This function displays the result of the test and also removes
the trash created by running the test.

On Wed, Mar 8, 2017 at 9:14 PM, Jon Loeliger <jdl@jdl.com> wrote:
> So, like, Prathamesh Chavan said:
>> The exit code of the upstream of a pipe is ignored thus we should avoid
>> using it. By writing out the output of the git command to a file, we
>> can test the exit codes of both the commands.
>>
>> Signed-off-by: Prathamesh <pc44800@gmail.com>
>> ---
>>  t/t2027-worktree-list.sh | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
>> index 848da5f..daa7a04 100755
>> --- a/t/t2027-worktree-list.sh
>> +++ b/t/t2027-worktree-list.sh
>> @@ -31,7 +31,7 @@ test_expect_success '"list" all worktrees from main' '
>>       test_when_finished "rm -rf here && git worktree prune" &&
>>       git worktree add --detach here master &&
>>       echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short
>> HEAD) (detached HEAD)" >>expect &&
>> -     git worktree list | sed "s/  */ /g" >actual &&
>> +     git worktree list >out && sed "s/  */ /g" <out >actual &&
>>       test_cmp expect actual
>>  '
>
> I confess I am not familiar with the test set up.
> However, I'd ask the question do we care about the
> lingering "out" and "actual" files here?  Or will
> they silently be cleaned up along the way later?
>
> Thanks,
> jdl
