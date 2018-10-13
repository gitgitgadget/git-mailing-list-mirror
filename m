Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DAD91F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 01:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeJMIi1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 04:38:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51757 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeJMIi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 04:38:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so13721508wmf.1
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 18:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RhbjxFxDw/vYQpUcHcoJ2su4I9ds9xkhr0P1YBLekpc=;
        b=L7oSmsuItAldT4Q5S7lZioi6fw/vx0bb1dvRJJLjtjT8tXNbYaEUFRt0jmYIKjrrsq
         pvawUapfhxEHVJvty6g/J4iaHn4T2hzByti0IiRM3namKNx671v1C1ql3KY1N3sqcaTq
         s3XnloNQMLj5qxJF1x8i6AfmJTt484cB3q1+HIB2X7l3p6yoqjYjXIJP1DWU4Do7FT0p
         zE5uNe7cEguvlbXD810XIwomyQBUfhw8OZYNPq0mAjx+iTpZWctbfagrs5IUYWFwC3Js
         Bwopv3yhcvDOnXsxCPAElLidOBUmTTdLH5iBVFP2CtlGrw+6z5P6g28Gd/ArDGePUZ6A
         hmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RhbjxFxDw/vYQpUcHcoJ2su4I9ds9xkhr0P1YBLekpc=;
        b=isGXZ1U20/WYyULBIx10pAxgo32xJjBSx4tm9VYV1V4DFy2D9dboaS0Jxly20En7jL
         tOSPyoYk6KCtV6SRRKRhzXeBL/X3vOcaDCKgUJaDRDzVNsAfsaz5CpeDIJnJzxGvhRh+
         cjyuEdqIxPTR8ZuTVt7DMvuDjidwYcfpuu0YYLFUxW+6xferAAb6y91tazS4faHSMKQP
         ojgXsTL4tobqDTSv9eU9Z95spzkttqMvUSWaABhCeJ01XIVeuxGVxTVyEbjizYsQQ7e3
         hNJDA1YPIlA7f2ojgDj2K6La2RqcHuq1MvQDRyD9MlxsRLcEWlX1mHljKmNXetrIBVNt
         2TZA==
X-Gm-Message-State: ABuFfoirBvvFwvblC9Ap68prY7yvKxjdwPsvjOFmLGQsmiDLrbrgV4CI
        /Ro54Q9U+FM9sAqWPWOnWS4=
X-Google-Smtp-Source: ACcGV63PN3xP069Zr7me3hbVwbSp4BBykAX77c91ecAXc0n0qj4SPcmJZXPwotbBpojAz4co5PwKIg==
X-Received: by 2002:a1c:d750:: with SMTP id o77-v6mr6444558wmg.110.1539392602866;
        Fri, 12 Oct 2018 18:03:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b5-v6sm1499465wrr.94.2018.10.12.18.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 18:03:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2018, #02; Sat, 13)
References: <xmqqh8hr9pxb.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZGEMWpr7aqeqXbC4bkmsCCiW+1pxbEV4T0vfsYG+_3iA@mail.gmail.com>
Date:   Sat, 13 Oct 2018 10:03:21 +0900
In-Reply-To: <CAGZ79kZGEMWpr7aqeqXbC4bkmsCCiW+1pxbEV4T0vfsYG+_3iA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 12 Oct 2018 12:44:23 -0700")
Message-ID: <xmqqd0seac9y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * sb/submodule-recursive-fetch-gets-the-tip (2018-10-11) 9 commits
>>  . builtin/fetch: check for submodule updates for non branch fetches
>>  . fetch: retry fetching submodules if needed objects were not fetched
>>  . submodule: fetch in submodules git directory instead of in worktree
>>  . repository: repo_submodule_init to take a submodule struct
>>  . submodule.c: do not copy around submodule list
>>  . submodule.c: move global changed_submodule_names into fetch submodule struct
>>  . submodule.c: sort changed_submodule_names before searching it
>>  . submodule.c: fix indentation
>>  . sha1-array: provide oid_array_filter
>>
>>  "git fetch --recurse-submodules" may not fetch the necessary commit
>>  that is bound to the superproject, which is getting corrected.
>>
>>  Ejected for now, as it has fallouts in places like t/helper/.
>
> This is the first time I hear about that, I'll look into that.
> The tipmost commit there is also shoddy, I'll redo that.

This is the first time I saw the breakage with this series, but I
would not be suprised, as this was rerolled recently.  Who knows
what got changed in this series and in other topics---any new
interaction can arise and that is a normal part of distributed
development.

The xx/sb-submodule-recursive-fetch-gets-the-tip-in-pu branch at
git://github.com/gitster/git.git has a merge of this into 'pu', with
textual conflicts all resolved.  

At least t/helper/test-submodule-nested-repo-config.c fails to
build; I didn't check if there are other breakages.

