Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1151F42D
	for <e@80x24.org>; Fri, 25 May 2018 17:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967331AbeEYR1K (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 13:27:10 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38721 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936185AbeEYR1I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 13:27:08 -0400
Received: by mail-yb0-f194.google.com with SMTP id q62-v6so599500ybg.5
        for <git@vger.kernel.org>; Fri, 25 May 2018 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jXmW2lXnNdHIG9oLq4EBSlza4huauiITTWLuJg2pAxU=;
        b=L4tZpfnaDSGSowSJ+sd2lQJaNT0GZwW39HK2xbf9XPJkOtuDvxkveqvEnIVE0h8pCS
         9HOSkfGjVqxT5Khv/wvlqAVDn0+JnZDvSKUzH4rNoo6FFs3FdyTIWlBuULR4oPlrPhEd
         VuwGuck4/SxC6wDQHy78A41i69BV4/gJRIevD7sp5IUqvrq8B1V+TpbanIZug+jn2G2i
         t1klC7HzTE71Ylq9L6RHa7TZxkF6PsVlFOQQEClxwNTLudbLrdyVfIpOwbNhtYh5r7Zu
         +3viIeif0M6UNVgGyTdj98/mdaSLFLlJdOmqcdyqnTjf/b3+VDLe2M0kLmWbbeUz3oix
         Zydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jXmW2lXnNdHIG9oLq4EBSlza4huauiITTWLuJg2pAxU=;
        b=cgtvPoI9xrigOtq05GOprR5AuSe//rJMob5TAXpFx6QKXR3iN8lf1uprcbbvpwzXQI
         xBXKj7rA3jgPzXGTBjRGykKGCzzKc06SVQl6r4F5s29tDo2/msQ0oOBrS8ihpwd8r2DG
         tzeaRxUFIp/lqvF26NT37m4rvs0sYDk4/CJRb0EJrJU90lTSQ8lUTm2i5RXbmjEM7qdP
         5FIUf9TRgB/L937+GiE23MDN2m7jOOzDB2BMXz/ZlmgxJWfGILEM0zlMn1z4dxwQZOff
         5pKCm+KOZd0IKwRQ4gyJIBKzV/iCZsEYxaSKBnKM6qjE+7VhXqeJSLL86yAGgwm2mT7q
         6UMQ==
X-Gm-Message-State: ALKqPweIHzWBMzS0lrE/tNsQAw78HWSYamxun3RYlb4yzmmtbDHFFZHC
        mRFAGeljc5yP/yun//77Y2eDr0It2wWXtxrtB8vYpA==
X-Google-Smtp-Source: ADUXVKL/9FcWwhY7LQy4tRsFTFlA/UTQY/7AXdmErwDL5v2Nx0GVbxR93ajFhO5Iu2IhodKTuSk2Wf2lk37tUWtNnf8=
X-Received: by 2002:a25:31c3:: with SMTP id x186-v6mr1915426ybx.352.1527269227724;
 Fri, 25 May 2018 10:27:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Fri, 25 May 2018 10:27:07 -0700 (PDT)
In-Reply-To: <87lgc77wc7.fsf@evledraar.gmail.com>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com> <87lgc77wc7.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 May 2018 10:27:07 -0700
Message-ID: <CAGZ79kYC=Yrw1GXLAswJyY=E3diJSp7c1bBhp4hsgnw-ApHrXw@mail.gmail.com>
Subject: Re: sb/submodule-move-nested breaks t7411 under GIT_FSMONITOR_TEST
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Fri, May 25, 2018 at 5:28 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, May 17 2018, Junio C Hamano wrote:
>
>> * sb/submodule-move-nested (2018-03-29) 6 commits
>>   (merged to 'next' on 2018-04-25 at 86b177433a)
>>  + submodule: fixup nested submodules after moving the submodule
>>  + submodule-config: remove submodule_from_cache
>>  + submodule-config: add repository argument to submodule_from_{name, pa=
th}
>>  + submodule-config: allow submodule_free to handle arbitrary repositori=
es
>>  + grep: remove "repo" arg from non-supporting funcs
>>  + submodule.h: drop declaration of connect_work_tree_and_git_dir
>>
>>  Moving a submodule that itself has submodule in it with "git mv"
>>  forgot to make necessary adjustment to the nested sub-submodules;
>>  now the codepath learned to recurse into the submodules.
>
> I didn't spot this earlier because I don't test this a lot, but I've
> bisected the following breakage down to da62f786d2 ("submodule: fixup
> nested submodules after moving the submodule", 2018-03-28) (and manually
> confirmed by reverting). On Linux both Debian & CentOS I get tests 3 and
> 4 failing with:
>
>      GIT_FSMONITOR_TEST=3D$PWD/t7519/fsmonitor-all ./t7411-submodule-conf=
ig.sh

I can reproduce this. I'll look into it.
