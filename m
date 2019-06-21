Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6721F1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 07:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfFUHt0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 03:49:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42393 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFUHt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 03:49:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id l19so2951403pgh.9
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PWqjyJCr8/tzWkKVfcuvcCEKQ7Sj1w06RMQZcugzNUQ=;
        b=lMT6CypSdNoMQL5kMa3ilJ0wnYn/i/QVtF7O9VKOjRJICCkUvBk3DQQoup2h+OZz7Z
         NJDGbO4Bu1J0ssGGI8Iw0O26wy6s4LYhiSYokxHDrZ5OUqY3XmbepdWrU5FyuR/QOQjs
         +4jN4jM7a5lklKDD31In9AQdbMiW7kBIOM0N4m1HH9ngiH7JvLhzLQOvVCESlLJj6uSw
         MtAdM8Y/3B2D8f5qlxPQoCvByZ+aXcrsf09pJsl8sZkvKO5lJNwPH7Kd2Sn3fhtNxkiZ
         pBPP5gjpwBRUGwc/DFf7nCC4axOLQyC270uWfhnppfxRcnrx7fc/rCQQddJXZ2+lMAbU
         wHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PWqjyJCr8/tzWkKVfcuvcCEKQ7Sj1w06RMQZcugzNUQ=;
        b=Y3Hi+iyJ9UbV6aahhRMwXGc+u+tjX5jSVdQ0GuSR2/DFoPdQj4iLrK0Ypc5eEWYN3v
         Bxo/6c+RYw367YrEirFtigYQrDiGvEUU3sG4aaQolHaydj6NvCqMdYhMyBV2H5fXKk37
         Utx1tufh/17mxJm2dfZJW6yUcEZcXk+MATKx86Y9LTlHDJ8NLC3EC52HT4vL4nrL7NvG
         nzz6o29DZpQTLcz/y8fCny0qTDGsuUyzQMFwpr2Eu3ZMR3utI0m2vAmxC2Iq54UuPheF
         TEvAzZQZmNJbwC2ErlSgaPdh8Lwd6eFe4HTPdqWJn6MXQaF59LClI3eFGwnomgT/+JPW
         hV4g==
X-Gm-Message-State: APjAAAWK1JaaZ0gOCoUZCe7CYG/5tlPoqm7NVWtXq506RUVlNLR6pg8k
        xWPqga6xRo1NtbZQFBE6vYQ=
X-Google-Smtp-Source: APXvYqw7ZDehhaoOvdcS8GdPENJ3PJMPAeXIdd1+P1yiAOljxealvmoqZyBIe04Rdku5ZyIKAnHqQA==
X-Received: by 2002:a63:4553:: with SMTP id u19mr16877091pgk.420.1561103365454;
        Fri, 21 Jun 2019 00:49:25 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.216])
        by smtp.gmail.com with ESMTPSA id k184sm1619079pgk.7.2019.06.21.00.49.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 00:49:24 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood@dunelm.org.uk, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v5 4/5] cherry-pick/revert: add --skip option
Date:   Fri, 21 Jun 2019 13:17:04 +0530
Message-Id: <20190621074704.6870-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <b6cf26b0-51b7-0c63-fb1c-4da1eb3666cb@gmail.com>
References: <b6cf26b0-51b7-0c63-fb1c-4da1eb3666cb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On 2019-06-20 11:42 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Rohit
>
> On 20/06/2019 11:34, Rohit Ashiwal wrote:
>> Hi Phillip
>>
>> On 2019-06-20 10:02 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>>> +test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
>>>> +	pristine_detach initial &&
>>>> +	git rm --cached unrelated &&
>>>> +	git commit -m "untrack unrelated" &&
>>>> +	test_must_fail git cherry-pick initial base &&
>>>> +	test_path_is_missing .git/CHERRY_PICK_HEAD &&
>>>> +	git cherry-pick --skip
>>>
>>> If you change this to --continue rather than --skip the test also
>>> passes! I think we could fix this by checking if HEAD has changed if
>>> CHERRY_PICK_HEAD/REVERT_HEAD is missing and not dropping the last
>>> command in the todo list in that case when we continue.
>>
>> I don't think I fully understood this. At this point --skip is essentially
>> --continue. How is checking unmoved HEAD and unchanged todo uniquely related
>> to --skip flag (or for that matter any _flag_)?
>
> My point is that --continue should reschedule the failed pick and try to
> pick it again - it should not silently skip a failed pick and  --skip
> should skip it.

So, this is a flaw in the --continue, I guess? Fixing that is beyond the
scope of this patch. May be we can launch another series in which we fix
this and decouple skip and continue?

Thanks
Rohit

