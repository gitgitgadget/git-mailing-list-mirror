Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62871F4BE
	for <e@80x24.org>; Sat,  5 Oct 2019 19:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfJETrB (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 15:47:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35091 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfJETrB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 15:47:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id v8so10860415wrt.2
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WWshh0A7OkZZ8eCjbO2lSgq3sIte7WuMIJagWRcoEv0=;
        b=lQI20REFqmsm74GE7AHfUtNjts9Sl0e3pn3/NQ6kCkp/NSbvZYEhDdDtkmM07ZgxXd
         UM9slSgsO3sHSu5DWWPy+DFfslKCzbNxYKGXKtdp8w6a3o+czlDyuw5pqs3jjT+lPE29
         zqoRJKxBHfwkV2PR503SbDZ47xFEKj0fUjcXECQuidlFRzkw/ozj+HFFd80dGRoONYRR
         Fxzswqt9REm/h9zCMJu6wS1FtCCBugmBhBGShKVYRP5mOUZ2GSgugicC3oWnTyRSmBse
         UjX7Q/5uU79KEHE7XhgffsiAS5GmfOs+ECKaNjlV/78cIlsFbfE+wfU0LIOQT/Bkm2O1
         ukjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WWshh0A7OkZZ8eCjbO2lSgq3sIte7WuMIJagWRcoEv0=;
        b=S4XrFzxCp4ZrraFSWxW5Ax6sIOHd9VYjVdvVoRx/FzNfUuhfOwuta2iBdmIOKj3PJM
         l7/p21cl5CHNnhCnDkhsK66h8qXBAzfw6/pf6xkTpj1YZnxNoid62pgixvfo+wnGS4If
         sLaUNA/G5XHeBWatFLM4Tis3Jx+t4ZXJyuV30GyOXfHNeden90UmcmD9RbhEb10lilxX
         plDecU9X5O+lILCnI8OqHqPd8MVOjwPbs0hETdTvQ5kaHQUTJ36xRwo+QuK6j73URFxE
         81VmoKf7lzVM2iiFjTEjrUrJWKx3rKsAEsU7JaY044T5KToGDDwYepspQHiBVSpjAvfu
         IUIA==
X-Gm-Message-State: APjAAAUuq3SU4ShyzBuujf9ssYguuvHtBdHyJpCX9GKmgpOJUSqKBdZ3
        b/lfykyTuabM/GbxePxfqyziIA6N
X-Google-Smtp-Source: APXvYqxEnZduUxylpYyyrfme1EWTKM8HcJ+2FZ1LHkqXo8eWNjY7tysjtd3rh3puaah7Hj3ViGfvMQ==
X-Received: by 2002:adf:d1a4:: with SMTP id w4mr13752447wrc.331.1570304816675;
        Sat, 05 Oct 2019 12:46:56 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-28-119.as13285.net. [92.22.28.119])
        by smtp.gmail.com with ESMTPSA id a7sm21588848wra.43.2019.10.05.12.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2019 12:46:56 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Oct 2019, #01; Thu, 3)
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <xmqqsgoabes8.fsf@gitster-ct.c.googlers.com>
 <972f4674-ed00-7113-24eb-f59f1b751690@gmail.com>
 <CABPp-BE+D-GFJaucgCCsBA8E7nQAxc0vNE92HaCpOTQrUp=mPA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a462c85b-5ae9-8b3d-27ee-00ba081d8af1@gmail.com>
Date:   Sat, 5 Oct 2019 20:46:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE+D-GFJaucgCCsBA8E7nQAxc0vNE92HaCpOTQrUp=mPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 05/10/2019 01:40, Elijah Newren wrote:
> On Fri, Oct 4, 2019 at 4:49 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Junio
>>
>> On 03/10/2019 06:04, Junio C Hamano wrote:
>>> Here are the topics that have been cooking.  Commits prefixed with
>>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>>> the integration branches, but I am still holding onto them.
>>> [...]
>>>
>>>
>>> * pw/rebase-i-show-HEAD-to-reword (2019-08-19) 3 commits
>>>    - sequencer: simplify root commit creation
>>>    - rebase -i: check for updated todo after squash and reword
>>>    - rebase -i: always update HEAD before rewording
>>>    (this branch is used by ra/rebase-i-more-options.)
>>>
>>>    "git rebase -i" showed a wrong HEAD while "reword" open the editor.
>>>
>>>    Will merge to 'next'.
>>
>> That's great, thanks
>>
>>>
>>> * ra/rebase-i-more-options (2019-09-09) 6 commits
>>>    - rebase: add --reset-author-date
>>>    - rebase -i: support --ignore-date
>>>    - sequencer: rename amend_author to author_to_rename
>>>    - rebase -i: support --committer-date-is-author-date
>>>    - sequencer: allow callers of read_author_script() to ignore fields
>>>    - rebase -i: add --ignore-whitespace flag
>>>    (this branch uses pw/rebase-i-show-HEAD-to-reword.)
>>>
>>>    "git rebase -i" learned a few options that are known by "git
>>>    rebase" proper.
>>>
>>>    Is this ready for 'next'.
>>
>> Nearly, but not quite I think cf [1]. Also I'm still not convinced that
>> having different behaviors for --ignore-whitespace depending on the
>> backend is going to be helpful but maybe they are close enough not to
>> matter too much in practice [2].
> 
> Sorry I should have chimed in sooner; I can speak to the second point.
> I would say that in practice it doesn't matter a lot; in most cases
> the two overlap.  Both am's --ignore-whitespace and merge's
> -Xignore-space-change are buggy (in different ways) and should be
> fixed, but I'd consider them both to be buggy in edge cases.  I
> recommended earlier this summer that Rohit submit the patches without
> first attempting to fix apply or xdiff, and kept in my TODO list
> that'd I'd go in and fix xdiff later if Rohit didn't have extra time
> for it.  I did a little digging back then to find out the differences
> and suggested some text to use to explain them and to argue that they
> shouldn't block this feature:
> 
> """
> am's --ignore-space-change (an alias for am's --ignore-whitespace; see
> git-apply's description of those two flags) not only share the same
> name with diff's --ignore-space-change and merge's
> -Xignore-space-change, but the similarity in naming appears to have
> been intentional with am's --ignore-space-change and merge's
> -Xignore-space-change being designed to have the same functionality
> (see e.g. the commit messages for f008cef4abb2 ("Merge branch
> 'jc/apply-ignore-whitespace'", 2014-06-03) and 4e5dd044c62f
> ("merge-recursive: options to ignore whitespace changes",
> 2010-08-26)).  For the most part, these options do provide the same
> behavior.  However, there are some edge cases where both apply's
> --ignore-space-change and merge's -Xignore-space-change fall short of
> optimal behavior, and in different ways.  In particular,
> --ignore-space-change for apply will handle whitespace changes in the
> context region but not in the region the other side modified, and
> -Xignore-space-change will delete whitespace changes even when the
> other side had no changes (thus treating both sides as unmodified).
> Fixing these differences in edge cases is left for future work; this
> patch simply wires interactive rebase to also understand
> --ignore-whitespace by translating it to -Xignore-space-change.
> """
> 
> I've got another email with even more detail if folks need it.

Thanks for clarifying that, it sounds like it shouldn't be a problem in 
practice then (especially if you're planning some improvements)

Best Wishes

Phillip
