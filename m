Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC9DC43334
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 20:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiGDUSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 16:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiGDUSA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 16:18:00 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CAD12607
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 13:17:58 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d3so9436956ioi.9
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BnijjHHH8naDUtz8oIGLLfEjQBxGDyZqWc+qvgX8870=;
        b=KTK5ljOWB1qpSJmsDzrTOZQhsPs+haLt2kzny/PQ3P+1GAI2IS9Q/1wOdrPyhRS0R4
         YNnrxnYOGmX+sYLqHqJLSh6JAhJEJit+rQxt7E64G/Ht48ijZKiz8QWdhz5DDWG6tl5E
         9ipbIAuhwhiEozj2gGCfG4OeVBZicmcQsmYurCAV8A6F/eVCWGrnT7p+WFk44UTtn/b0
         dp4p3yFCOggYJgEl59kowIJyT5Xtc77kxPYZUJgRXR4ySJYaStEFeA34zmINJd2xdZrw
         ClH6EUQAUK5oh1BrG6WKF/1Lzle2XiDD3tZ5Hlpa2RAzsx5DZ1bqeCOhcDjywe7P0iew
         T1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BnijjHHH8naDUtz8oIGLLfEjQBxGDyZqWc+qvgX8870=;
        b=fdiwMJOFJuMJahsbWFdM2j1bW/+/j+c9aHDzrsY9EKr9jiYQthRlWbXO7g/KH6Z0QD
         JCPAzpEI9hkWaNFPZZgO99wgYJAefEogCXKqihSCf11MYWDevIt+ytkoooehQzPcgHmM
         ElGUXyGpZaDMisVdxAOq+QX83uAd3tt2mb8J28rEiLIM9vOJMkpnX144obTZHQSO3a5W
         NV/tO/HNbNbqNHUd2bUXRWzvvbggIq6ofDF2lSwsKKx7JIjCqz8Pdva9ZVFoEvE9yI4P
         RJjts7tWG79yaLVfVbXGdKRmIkdxtJ/zS3h2KzMVV2xawPm3Oaj9U6tHqvbVu1F9jWf4
         H+TQ==
X-Gm-Message-State: AJIora+GpXyRryKF84GfwlmrZAkPn9SGVt9aFhAuAVCKXvpV9FTPtdKW
        JVLe1Zd4Vo7n1WE0GHN9qwCR
X-Google-Smtp-Source: AGRyM1tLK8oTZk0zpJ/U5y+gQnzEiz1gfDwxFkKJPohoBvgaJkBWyEl/axfVW5ZyMSJFHEyW5g9Alg==
X-Received: by 2002:a05:6602:8d1:b0:675:3baa:d47 with SMTP id h17-20020a05660208d100b006753baa0d47mr16636142ioz.194.1656965878249;
        Mon, 04 Jul 2022 13:17:58 -0700 (PDT)
Received: from [192.168.103.232] ([4.1.157.141])
        by smtp.gmail.com with ESMTPSA id k30-20020a02335e000000b00339e6f88235sm13898151jak.61.2022.07.04.13.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 13:17:57 -0700 (PDT)
Message-ID: <9662ac37-1458-8cf2-c0dd-5cd2b9107e4b@github.com>
Date:   Mon, 4 Jul 2022 14:17:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: ds/rebase-update-re (was Re: What's cooking in git.git (Jul 2022,
 #01; Fri, 1))
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, vdye@github.com
References: <xmqqo7y85t44.fsf@gitster.g>
 <15631ea2-6722-fd24-c8a6-0cee638b0602@github.com>
 <CABPp-BEHj6gXe+GNR8cw+UUG27E0Mn-wiBb=Dp=ZgX_2gT915w@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BEHj6gXe+GNR8cw+UUG27E0Mn-wiBb=Dp=ZgX_2gT915w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/4/22 10:58 AM, Elijah Newren wrote:
> On Mon, Jul 4, 2022 at 6:26 AM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> On 7/1/22 5:08 PM, Junio C Hamano wrote:
>>
>>> * ds/rebase-update-ref (2022-06-28) 8 commits
>>>  - rebase: add rebase.updateRefs config option
>>>  - rebase: update refs from 'update-ref' commands
>>>  - rebase: add --update-refs option
>>>  - sequencer: add update-ref command
>>>  - sequencer: define array with enum values
>>>  - rebase-interactive: update 'merge' description
>>>  - branch: consider refs under 'update-refs'
>>>  - t2407: test branches currently using apply backend
>>>  (this branch uses ds/branch-checked-out.)
>>>
>>>  "git rebase -i" learns to update branches whose tip appear in the
>>>  rebased range.
>>>
>>>  Will merge to 'next'?
>>>  source: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
>>
>> Please expect at least one more re-roll. Here are the things I
>> intend to fix in the next re-roll, which should arrive sometime
>> this week.
>>
>> * Some commit message tweaks.
>> * Actually interrupt 'git bisect' and 'git rebase' in the tests.
>> * Be careful to update the update-refs file when the user edits
>>   the todo file.
>> * Consider storing the "before" values in the update-refs file
>>   and removing refs whose update-ref steps were removed by the
>>   user.
> 
> First half sounds good to me.  Not sure I understand the second half
> about "removing refs"; do you mean actually deleting the ref, or just
> not updating it, or something else?

I mean removing it from the $GIT_DIR/rebase-merge/update-refs file
so it is no longer blocking others from using it (and the value in
the file can be used for a --force-with-lease type update).

>> * Elijah had a question about focusing on "pick" actions, not
>>   "fixup" or "squash" steps. This might be worth marking the
>>   option as experimental so we have flexibility in changing the
>>   behavior as new workflows are tested against this option.
> 
> This sounds good to me.  I do sometimes want to fixup or squash into a
> commit that a branch I depend upon directly points to, so I'm worried
> your feature may update refs incorrectly without this support.

I've been using this quite a bit in my own work, and it properly
moves fixups and squashes into the right branches, but I've only
done that with fixups and squashes on the tip branch, not inside
the earlier branches. It's also been really good when I rebase
and add "break" or "edit" steps and do really complicated commit
squashing or splitting operations.

I'll try to collect some example runs, but it would also help a
great deal if you added these patches to your local version of
Git and try it own in your workflow. Use the rebase.updateRefs=true
config setting so you don't need to think about it. Victoria has
been testing this for me in her own workflows, so maybe she has
ideas here.

Thanks,
-Stolee
