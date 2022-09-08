Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA7C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 16:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiIHQ6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 12:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiIHQ5p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 12:57:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540D5EA434
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 09:57:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 73so17360732pga.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 09:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=T96bUVf6lX2RAiBJlk7Gt1LtvCKwC+NHAwxgzGg3fxg=;
        b=APsuA+fossaHLmTRoHqSB/ZVZg1VZMjPvcBQvMmLXN/Q2vVAtTutOPEIkcI51jW37l
         qde8HciY7hR9Sg3sciXG3tB9OdId5DycW1QIAjK7HCs5/r9qv/19WBSpoWmxhAc53CbP
         n6K2BLqmvhTul5RsWuoo1GZb0VBzMq89eB/bO465x6RpRrRy/uAGDRQVkFWmIadnG/VN
         eOuQFfLLaJRs/E4M+3Xsqzcm4/6IU0qfNf81gdblWTYKw7IixU1647dVsEtz8UFNFFnP
         KEBkckDLnNeOUfHfl28CIX4bBTs9o8su3kWvxdJltbkbuRQ4sTx4Vem6PQFYKJbhEAbz
         o53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=T96bUVf6lX2RAiBJlk7Gt1LtvCKwC+NHAwxgzGg3fxg=;
        b=tuaSLNSKlljhUxcLLRjeQ6XzS42ju4QeviRgCbJ2tYOWVPFMBcIhPnPW/LqyZqty0E
         eFWHxziA0iSbFFqVHtc4JqQcGDRVZYS+mlmeO6H9Mu6JIOX9FAxkOjPnSInKmHdRMQ9T
         tZbTt82m5YNiOhlbAu4IMm7ViSK7kEuR+pgraQs75WroHnHcf9+mft6gueD8JoidAhNW
         8zVIib2VI0xnfZqU6WnAEAJ7PqptXEG5hhJogG+i14W158Ga/3lgvgvW+bJLfU/VAIaB
         qZ3Kq/uiAUkqecGSGh7CxcwHkq4bdbTM+sBAx5dVrYNonkVYY4IBIzq6OXzAQ/t2kdCF
         qvcw==
X-Gm-Message-State: ACgBeo10s4LQCjzSuO69VWefi7E+ajdrCEEPypFE369QwhseBfzUcscL
        5bh62Bj5mGQKIcYgGqcySRZxGwESm58=
X-Google-Smtp-Source: AA6agR581u8Fzb5ZtEZgfmj+5W4xaBldjzTwY+rwyhv2VVyRi9pr/Ikr5KwSk40MVNF34bODy6vIwQ==
X-Received: by 2002:a63:2014:0:b0:434:23a5:86d8 with SMTP id g20-20020a632014000000b0043423a586d8mr8513988pgg.85.1662656237676;
        Thu, 08 Sep 2022 09:57:17 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id cp10-20020a170902e78a00b00173368e9dedsm14718770plb.252.2022.09.08.09.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:57:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2022, #01; Mon, 5)
References: <xmqqilm1yp3m.fsf@gitster.g>
        <kl6ly1uu94ca.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 08 Sep 2022 09:57:16 -0700
In-Reply-To: <kl6ly1uu94ca.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 07 Sep 2022 16:01:25 -0700")
Message-ID: <xmqqpmg5rehf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * gc/submodule-propagate-branches (2022-08-29) 6 commits
>>  - clone, submodule update: check out branches
>>  - submodule--helper: refactor up-to-date criterion
>>  - submodule: return target of submodule symref
>>  - t5617: drop references to remote-tracking branches
>>  - repo-settings: add submodule_propagate_branches
>>  - clone: teach --detach option
>>
>>  "git clone --recurse-submodules" and "git submodule update" learns
>>  to honor the "propagete branches" option.
>>
>>  Needs review.
>>  source: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
>
> I suggest renaming the branch - the config "submodule.propagateBranches"
> will be used by many more commands in the future, several of which will
> probably be authored by me :)

OK.  So this is a "clone" and "update" part of the larger topic?

> Maybe gc/submodule-update-with-branches? Or
> gc/recursive-clone-with-branches.

Both sound good suggestions.
