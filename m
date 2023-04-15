Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D194AC7619A
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 15:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjDOPhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDOPhB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 11:37:01 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC603AA6
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 08:36:57 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id dd8so8769687qvb.13
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681573016; x=1684165016;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6qQfQe16BA/M0umKhSvT3vMRqt7kxi+X0x97+YtjsA=;
        b=Mg9dBTdInZIveg8uLDBLS+9katHLjac9qVTn4Amyah+ovkQtjJlgClDxpqeg55o/Dp
         mb9flgepdNH6mF4oA+FU3z9OzOMNOrxFUK0K5Po/QFS7N/DDkK1ZjcfRezpnzmu7PeTj
         wkKvnnpFJE+mW6X7cQazh2civaV2TSAX5Nu6i4DGo1b1yfKZV+sTjqcThs9pWkOEbM3l
         Fb2+AriQOlbhN49TCIR+1C4ETlHH2wdH22xqU6A0rdBmP+hNqnIB/E8QQEf2cDx0nMBr
         42peCFh308ZM5q2zp11GwVXjjlKk4ej1g7fcBr6vHXkXets8xYWK3lvODPQzVY9pt086
         IOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681573016; x=1684165016;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6qQfQe16BA/M0umKhSvT3vMRqt7kxi+X0x97+YtjsA=;
        b=abglU+4KR155rCmJ5sIQ8kNvbz1T0zhLMZrDAjb0UKoL5Kar0jaSIoKMFB5tXgYurN
         SqcLXJP7lmWwA8QcvmAYSI9Hco4lC5QyvrFq/7Ie5KAtACzzSJVQL5VsmzxMt8Cx6wlQ
         DKE0hDhWZ94wmvbtu079V5Z19lLJJ5babwM8LeaIXlJH3RXVLeRtl74UfQxB3Ds2K5W1
         vqkQtNvQWv9UjrIIv8GujeNNzSmJbAErAJz5VdTUTvXoEoP/zOH+xR4rKaekbOb3jN8k
         jzKJpF5B26IxGjEQNc0kMeQarn1erBGx5XWj3enPty7cSoGwYst6A3+zDiiyv+9kSfHA
         YCJA==
X-Gm-Message-State: AAQBX9frlyo3EBKdCzu3MOGYbvs0v5Kazp+CkICZIn1IeHUcgF73mXxf
        eQZLTqkOBQSnvLWepHefZ/C/ZbfeAwE=
X-Google-Smtp-Source: AKy350awJa8p++v/8f80RDtiap6K3QDtCUTckeroDBZ6uXKyIXMCH8YLTyicoy4rj7FiCb+Eo9wHHA==
X-Received: by 2002:a05:6214:c69:b0:5a3:79cd:8ef7 with SMTP id t9-20020a0562140c6900b005a379cd8ef7mr10440990qvj.23.1681573016518;
        Sat, 15 Apr 2023 08:36:56 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id om14-20020a0562143d8e00b005eb3a61bc29sm1829174qvb.66.2023.04.15.08.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 08:36:55 -0700 (PDT)
Subject: Re: [PATCH 4/5] Documentation: document AUTO_MERGE
To:     Elijah Newren <newren@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
 <0cdd4ab3d739e07357ea9efef2cdece633db6ebb.1681495119.git.gitgitgadget@gmail.com>
 <CABPp-BHyvVhVKa+M-GYTG3OEmgmoaEij15BFXQ6oyDDsboxS9g@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <5cd89e46-f099-24bb-ebe4-fabdd6f94aef@gmail.com>
Date:   Sat, 15 Apr 2023 11:36:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHyvVhVKa+M-GYTG3OEmgmoaEij15BFXQ6oyDDsboxS9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Le 2023-04-15 à 03:03, Elijah Newren a écrit :
> On Fri, Apr 14, 2023 at 10:58 AM Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>

Thanks for pointing out my typos, those are fixed.

>> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
>> index dc9c6a663a9..99e5f652e92 100644
>> --- a/Documentation/user-manual.txt
>> +++ b/Documentation/user-manual.txt
>> @@ -1343,6 +1343,33 @@ $ git diff -3 file.txt           # diff against stage 3
>>  $ git diff --theirs file.txt   # same as the above.
>>  -------------------------------------------------
>>
>> +When using the 'ort' merge strategy (the default), before updating the working
>> +tree with the result of the merge, Git writes a special ref named AUTO_MERGE
>> +reflecting the state of the tree it is about to write. Conflicted paths that
>> +could not be automatically merged are written to this tree with conflict
>> +markers, just as in the working tree. AUTO_MERGE can thus be used with
>> +linkgit:git-diff[1] to show the changes you've made so far to resolve
>> +conflicts. Using the same example as above, after resolving the conflict we
>> +get:
> 
> Mostly...  To clarify, conflicted paths *with a textual conflict* are
> written with conflict markers.  Conflicted paths with non-textual
> conflicts are not.  There are several conflict types that fall into
> the non-textual conflict umbrella: binary files, file/directory,
> symlink/directory, symlink/file, modify/delete, rename/add,
> rename/delete, rename/rename (1to2), and various submodule and
> directory rename conflict types as well.
> 
> The AUTO_MERGE stuff will only help with seeing how textual conflicts
> were resolved, it's not much help with the non-textual conflicts.

That's true. I think that it might be a good idea to be explicit about
"textual conflicts". Although, I think that precision should also be made
in the other parts of the doc, not just the user manual, so I'll do that.

Thanks,

Philippe.

> (By contrast, the closely related --remerge-diff option to `git log`
> or `git show` does help see the resolution of *both* the textual and
> non-textual conflicts, but of course one can't use that option on the
> current merge until after first commiting the existing changes.)

That's true. And, remerge-diff only helps when actually looking at two-way
merge commit, not with conflicts hit during a rebase, cherry-pick or revert. 

A semi-related trick I use to check conflict resolution during a rebase (after
resolving the conflicts but before 'git rebase --continue') is to manually 
construct a commit from the index and use 'git range-diff' to compare it
to REBASE_HEAD. Thinking out loud, maybe a '--check-resolution' flag to the 
sequencer would make sense to do that automatically...
