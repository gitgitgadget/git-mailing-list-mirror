Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776461FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 23:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932400AbcLGXqN (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 18:46:13 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:32802 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752934AbcLGXqM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 18:46:12 -0500
Received: by mail-qk0-f175.google.com with SMTP id x190so434432194qkb.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 15:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g+mSts/88nGhD1RjtGJWWnk5X3NhaZISxoUMkWqGqzM=;
        b=f34wZPOM32VnVRWUXwkLETqSF7TaMKKnbzCJbtldA5ttSIHNZtyXXuhrX74mUOr7PE
         nZHDwLQVRawc4mnnUBMC38T1leppmo9/+SfwpVFeY9RCwOGAMiedU4n/4eN3t5RryeOL
         kTqeTCFnsyPXaK+pQ59ivN02BRxPCsald8XrBaahnFsgVgT8+HQYE3e3QpWiwfi7LOMl
         7x41krF7idExGIn/UCZ9+Yelig42OlkpZDHKVPyfCUPz0u/AY28ofWiBHPt3TnzeNI4U
         GH/whf2JYwKkOdtTHAfu9ACj1XlR7QgCuZDgG2eExR4c+MbUNwiGRt3QgND4/MIW3cj6
         2y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g+mSts/88nGhD1RjtGJWWnk5X3NhaZISxoUMkWqGqzM=;
        b=SkUjPNStEsmvwu6E+Du56coECEDqfOGvZ7at7h+QwdMpLohZ9iQKrj1Gw56cTUjAko
         z+Z3TUvMISmdPNHEBCZ9EZNMVENmJriKLJqB0ab+8k6RzrOCQE9mC3MNdhSvI3YoD/41
         bTPp6njfjbfB7itay9rQX0czIbf957M01rOHz/SLEDRDCXMq8ykgiiTTx3yLn9OZigAw
         a5f903MPuAYp4Qtlsxslpts5gQmlZcOz47qFnESt8qw6qPXoW5MsksCPNJmlfHq50oQz
         3TYZIFH1WbuIqLYDTEyy96urs+YM1luYYcdI6BPQDYHg4URJ7lPUlUQXL2H+sPUn2TPT
         F6fQ==
X-Gm-Message-State: AKaTC03oUo6w4CforsnHQfE/xBnOhP0ZyMVZuelpLIxJYeV8/gFyJViXeHRwFWXCSMm2j8jx3a0ZQa1XDLNE9oys
X-Received: by 10.55.16.147 with SMTP id 19mr61528349qkq.255.1481153998450;
 Wed, 07 Dec 2016 15:39:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 7 Dec 2016 15:39:58 -0800 (PST)
In-Reply-To: <xmqqeg1juxd7.fsf@gitster.mtv.corp.google.com>
References: <20161207210157.18932-1-sbeller@google.com> <xmqqzik7v04b.fsf@gitster.mtv.corp.google.com>
 <xmqqeg1juxd7.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Dec 2016 15:39:58 -0800
Message-ID: <CAGZ79kYD61XaKMtnNOy11BYEzw5byWKHWchfVs+gwwHB_QdMSg@mail.gmail.com>
Subject: Re: [PATCHv5 0/5] submodule embedgitdirs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> v5:
>>> * Add another layer of abstraction, i.e. the relocate_git_dir is only about
>>>   moving a git dir of one repository. The submodule specific stuff (e.g.
>>>   recursion into nested submodules) is in submodule.{c,h}
>>>
>>>   This was motivated by reviews on the series of checkout aware of submodules
>>>   building on top of this series, as we want to directly call the embed-git-dirs
>>>   function without the overhead of spawning a child process.
>>
>> OK.  Comparing the last steps between this round and the previous
>> one, I do think the separation of the responsibility among helpers
>> is much more reasonable in this version, where:
>>
>>  - submodule_embed_git_dir() is given a single path and is
>>    responsible for that submodule itself, which is done by calling
>>    submodule_embed_git_dir_for_path() on itself, and its
>>    sub-submodules, which is done by spawning the helper recursively
>>    with appropriate super-prefix;
>>
>>  - submodule_embed_git_dir_for_path() computes where the given path
>>    needs to be moved to using the knowledge specific to the
>>    submodule subsystem, and asks relocate_gitdir() to perform the
>>    actual relocation;
>>
>>  - relocate_gitdir() used to do quite a lot more, but now it is only
>>    about moving an existing .git directory elsewhere and pointing to
>>    the new location with .git file placed in the old location.
>>
>> I would have called the second helper submodule_embed_one_git_dir(),
>> but that is a minor detail.
>>
>> Very nicely done.
>
> One thing that is not so nice from the code organization point of
> view is that "dir.c" now needs to include "submodule.h" because it
> wants to call connect_work_tree_and_git_dir().
>
> I wonder if that function belongs to dir.c or worktree.c not
> submodule.c; I do not see anything that is submodule specific about
> what the function does.

Right, it just happened historically for that function to live
in submodule area. I'll move the connect_work_tree_and_git_dir
to dir.c as well.
