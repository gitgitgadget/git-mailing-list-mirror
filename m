Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 142DF20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdAWSOP (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:14:15 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33941 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbdAWSOO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:14:14 -0500
Received: by mail-lf0-f67.google.com with SMTP id q89so14733657lfi.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 10:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FMRZahF/xLNExb3of/WhlNf3JaROt+bq4TViB+7d2BA=;
        b=OFviFWWxFSRRMF7YT3ZCZzm4SMimQwCjaQNMNRGwPTIM2aXpTu5ntYQkgk1A1M90eb
         Y6OQgkYvhfzCuSYV4bdrgyWntsCHpLzatiLbUEOz/vmCzE9UH3kd4A/ri0hQ9R5dCjUf
         5AKs+Z/RdkvHhxiKzHADkpdY+tdd7X6GAK24YJYEPnXsH14gC4MobDPYU/5A4vtGX0y4
         J0LJTcdyd4uSp/aLS93IaAAKexrzPH/cFEQppmMc1PjViutPhbemT59w6ei8ERougvgB
         7oUZ0C4YJ4FnbG181EwaSHFgOou5b12KhKKkTgOC4huZbCuTblHWwGY0sWm+yYEOxghg
         zWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FMRZahF/xLNExb3of/WhlNf3JaROt+bq4TViB+7d2BA=;
        b=as/fvRT8frRdzrtqz1CqZuyMlQBMu6CvXzWIB/iV5NLIckGMNC7Cy70KLbRiRYWp67
         AOJzs4/8rR3FU/1AJU9K2jXqZGnz9SUGe4vk6bHUhnmUzVOan6oJ/62t5y2ERBmKHoeN
         hWdmT4qLp7WPsshcKRUKSYPnJrP503AcTAOQcNpXeBgCnYZsRo31RdagObzDOyDZGzXg
         7AOPRSKJNHLLKLolyFcuchl5vQgtbLg4H5HrKbUtthV1Js0GwzzTCsYUu4NFA/D3ces0
         Z7M2n4L2xh6xi/cWZpZ8OK9QCAeYx7Vq2lldYxVacnIRFj9mfZwP/4KB/ZWeMSQhO6/C
         DQRQ==
X-Gm-Message-State: AIkVDXJzKpwYD8jzr6WkiAQgIRerjVLD1AkoUzCcW6c1Kucd+Vbm1KIvVf84cB/ukw0evxt1AmlQnZ7Rmu8ANw==
X-Received: by 10.25.210.79 with SMTP id j76mr8568104lfg.129.1485195252569;
 Mon, 23 Jan 2017 10:14:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Mon, 23 Jan 2017 10:14:11 -0800 (PST)
In-Reply-To: <xmqqlgu627uj.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-15-chriscool@tuxfamily.org> <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
 <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com> <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
 <xmqqvatouwsh.fsf@gitster.mtv.corp.google.com> <CACsJy8B_xe6RtszPrncvDdSYosNUQxvhcEQ3DO_WO0sepXqvvQ@mail.gmail.com>
 <xmqqlgu627uj.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 23 Jan 2017 19:14:11 +0100
Message-ID: <CAP8UFD2LWGtNtdhtQTZXqsACBvK=jD25vt8M4HzBRBVS1sJ+=Q@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 8:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Mon, Jan 9, 2017 at 9:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> On Sun, Jan 8, 2017 at 4:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Christian Couder <christian.couder@gmail.com> writes:
>>>>>
>>>>>> So what should we do if freshen_file() returns 0 which means that the
>>>>>> freshening failed?
>>>>>
>>>>> You tell me ;-)  as you are the one who is proposing this feature.

Before the above question I already had given my opinion about what we
should do.

There are the following cases:

- Freshening failed because the shared index file does not exist
anymore. In this case it could have been removed for a good reason
(for example maybe the user wants to remove all the shared index
files), or it could be a bug somewhere else. Anyway we cannot know and
the user will get an error if the shared index file that disappeared
is read from afterwards, so I don't think we need to warn or do
anything.

- Freshening failed because the mtime of the shared index cannot be
changed. You already in a previous email wrote that we shoudn't warn
if the file system is read only, and I agree with that, as anyway if
the file system is read only, the shared index file cannot be deleted,
so there is no risk from the current user. Also the split index mode
is useful to speed up index writing at the cost of making index
reading a little slower, so its use in a read only mode should not be
the primary way it is used.

So my opinion is that there are good reasons not to do anything if
freshening fails.

>>>> My answer is, we are not worse than freshening loose objects case
>>>> (especially since I took the idea from there).
>>>
>>> I do not think so, unfortunately.  Loose object files with stale
>>> timestamps are not removed as long as objects are still reachable.

As the current index is read, which freshens its shared index file,
before a new index is created, the number of shared index files
doesn't go below 2. This can be seen in the tests changed in patch
19/21. So the risk of deleting interesting shared index files is quite
low in my opinion.

Also in general the split-index mode is useful when you often write
new indexes, and in this case shared index files that are used will
often be freshened, so the risk of deleting interesting shared index
files should be low.

>> But there are plenty of unreachable loose objects, added in index,
>> then got replaced with new versions. cache-tree can create loose trees
>> too and it's been run more often, behind user's back, to take
>> advantage of the shortcut in unpack-trees.
>
> I am not sure if I follow.  Aren't objects reachable from the
> cache-tree in the index protected from gc?
>
> Not that I think freshening would actually fail in a repository
> where you can actually write into to update the index or its refs to
> make a difference (iow, even if we make it die() loudly when shared
> index cannot be "touched" because we are paranoid, no real life
> usage will trigger that die(), and if a repository does trigger the
> die(), I think you would really want to know about it).

As I wrote above, I think if we can actually write the shared index
file but its freshening fails, it probably means that the shared index
file has been removed behind us, and this case is equivalent as when
loose files have been removed behind us.
