Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714BC1F406
	for <e@80x24.org>; Thu, 10 May 2018 19:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeEJTJ1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:09:27 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:42850 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeEJTJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:09:26 -0400
Received: by mail-qt0-f181.google.com with SMTP id c2-v6so3991837qtn.9
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tpgXQQhAwpsWaUxC1RDtY/H72H1piFlSd/5zu4EDDGE=;
        b=aX60fXzo6GRGT2TqIDrY/OeZFZ0IWk3hjrnq0CjvOjd6R/0D4tl+0CnbpeFlbZz5wt
         8Z8Dbr1+7DM0DhsfZL9HIiO3/MNFM1Msycz6tBvs6k456F2WlBOyk/PGvIeZ0JxOQQ6X
         HNKslbmp5ccnzex4Z1kc33M6NldB5Cu1kOwFWXnpiZhaFYB2Jod1kgYpKYf+l1fzjjAW
         dm3w46ShiNBH+uWqjaX08YvIBmcKq0NVPeuASgpcbv+ssdROFF+17TVwrfyKmyXsI/ue
         2quCpSTsiFlEVdy/mNn3uj5Z3sOkCX23W9VK5TY3URaw6Dlac9LjEZkloRXOYxQbJLWR
         nToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tpgXQQhAwpsWaUxC1RDtY/H72H1piFlSd/5zu4EDDGE=;
        b=DH66doF9+6GM/CT1ovtKCJ5390Hc5AxWPXtBKs1JQy2eQo1Ib39LIJJzv9rfTUGIqB
         moCefzAGljNFAOoYWoCTPT04hgAJ3zvccqhBKjaIgjcYcfLXaq0Jb26MHBjVKY8iLk90
         i99D4xMvAyKoy5vCpmrdogiwQpOrpvwmhhKok366F5n6Y/B7e4jwmyPPkaE0Fza1otu9
         /nGoabqzfKsQE9T6kfCjp8vYmdQhjIf4ias6/cylPLoEEqm0m2M/LH2ziWpkGFI/1BIO
         i1REvv92JmC8y1bq22wuItUCx58nirSOeltcHvqqAmKJKlYM2+o4L4dus1KOE3Z8MXUU
         ZKmw==
X-Gm-Message-State: ALKqPwcDrmKe3r0qbVyeOwkDoKVdKJwyHN2XxxV94++J/IquqYyn8Q8y
        q6G5VqVb5bMxwJuOtTZsPpc=
X-Google-Smtp-Source: AB8JxZqyOnGBCEcNlv4cDh/HhFeghCZGnWn1c2yvlft8tUMGndjPoO50mrZYpuF2Y3Y4d6dXwIk0ig==
X-Received: by 2002:a0c:d442:: with SMTP id r2-v6mr2523559qvh.77.1525979365310;
        Thu, 10 May 2018 12:09:25 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id t81-v6sm1208260qkt.36.2018.05.10.12.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 12:09:24 -0700 (PDT)
Subject: Re: [PATCH v2] add status config and command line options for rename
 detection
To:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
References: <20180509144213.18032-1-benpeart@microsoft.com>
 <20180510141621.9668-1-benpeart@microsoft.com>
 <CABPp-BGE6RXv3ka8wGXruFjk3W=kDEDJ6zpH3t5=_CGSTONCHQ@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <bc81823e-7b7d-c516-dfc2-cd47bedb5a5a@gmail.com>
Date:   Thu, 10 May 2018 15:09:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGE6RXv3ka8wGXruFjk3W=kDEDJ6zpH3t5=_CGSTONCHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/10/2018 12:19 PM, Elijah Newren wrote:
> Hi Ben,
> 
> On Thu, May 10, 2018 at 7:16 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
>> After performing a merge that has conflicts, git status will by default attempt
>> to detect renames which causes many objects to be examined.  In a virtualized
>> repo, those objects do not exist locally so the rename logic triggers them to be
>> fetched from the server. This results in the status call taking hours to
>> complete on very large repos.  Even in a small repo (the GVFS repo) turning off
>> break and rename detection has a significant impact:
> 
> It'd be nice if you could show that impact by comparing 'git status'
> to 'git status --no-renames', for some repo.  Showing only the latter
> gives us no way to assess the impact.
> 

Given the example perf impact is arbitrary (the actual example that 
triggered this patch took status from 2+ hours to seconds) and can't be 
replicated using the current performance tools in git, I'm just going 
drop the specific numbers.  I believe the patch is worth while just to 
give users the flexibility to control these behaviors.

>> git status --no-renames:
>> 31 secs., 105 loose object downloads
>>
>> git status --no-breaks
>> 7 secs., 17 loose object downloads
>>
>> git status --no-breaks --no-renames
>> 1 sec., 1 loose object download
> 
> This patch doesn't add a --no-breaks option and it doesn't exist
> previously, so adding it to the commit message serves to confuse
> rather than help.  I'd just drop the last two of these (and redo the
> timing for --no-renames assuming you are built on
> em/status-rename-config).
> 

OK

>> Add a new config status.renames setting to enable turning off rename detection
>> during status.  This setting will default to the value of diff.renames.
>>
>> Add a new config status.renamelimit setting to to enable bounding the time spent
>> finding out inexact renames during status.  This setting will default to the
>> value of diff.renamelimit.
> 
> It may be worth mentioning that these config settings also affect 'git
> commit' (and it does, in my testing, which I think is a good thing).
> 

I agree this is a good thing as the other status settings behave the 
same way.  I'll update the documentation to reflect this as well.

>> Add status --no-renames command line option that enables overriding the config
>> setting from the command line. Add --find-renames[=<n>] to enable detecting
>> renames and optionally setting the similarity index from the command line.
> 
> The command line options are specific to 'git status'.  I don't really
> have a strong opinion on whether they should also be added to
> git-commit; I suspect users would be more likely to use the config
> options in order to set it once and forget about it and that users
> would be more likely to want to override their config setting for
> status than for commit.
> 
>> Note: I removed the --no-breaks command line option from the original patch as
>> it will no longer be needed once the default has been changed [1] to turn it off.
>>
>> [1] https://public-inbox.org/git/20180430093421.27551-2-eckhard.s.maass@gmail.com/
> 
> I'd just drop these lines from the commit message, and instead mention
> that your patch depends on em/status-rename-config.
> 

OK

>> +       if ((intptr_t)rename_score_arg != -1) {
>> +               s.detect_rename = DIFF_DETECT_RENAME;
> 
> I'd still prefer this was a
>          if (s.detect_rename < DIFF_DETECT_RENAME)
>                  s.detect_rename = DIFF_DETECT_RENAME;
> 
> If a user specifies they are willing to pay for copy detection, but
> then just passes --find-renames=40% because they want to find more
> renames, it seems odd to disable copy detection to me.
> 

I agree and will change it. It is unfortunate this will behave 
differently than it does with merge.  Fixing the merge behavior to match 
is outside the scope of this patch.

>> +++ b/t/t7525-status-rename.sh
> 
> Testcases look good.  It'd be nice to also add a few testcases where
> copy detection is turned on -- in particular, I'd like to see one with
> --find-renames=$DIFFERENT_THAN_DEFAULT being passed when
> merge.renames=copies.
> 

OK.  I also added tests to verify the settings correctly impact commit.

> 
>> +test_expect_success 'setup' '
>> +       echo 1 >original &&
>> +       git add . &&
>> +       git commit -m"Adding original file." &&
>> +       mv original renamed &&
>> +       echo 2 >> renamed &&
>> +       git add .
>> +'
> 
> 
>> +cat >.gitignore <<\EOF
>> +.gitignore
>> +expect*
>> +actual*
>> +EOF
> 
> Can this just be included in the setup?
> 

OK

> 
> Everything else in the patch looked good to me.
> 
