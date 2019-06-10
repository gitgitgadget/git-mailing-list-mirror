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
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB051F462
	for <e@80x24.org>; Mon, 10 Jun 2019 13:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390156AbfFJNp3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 09:45:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32935 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390063AbfFJNp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 09:45:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so4584858pga.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 06:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BgUvbOIXDtHEGHGsx3KAlZ2A/NY19l8iihPpa+bw84o=;
        b=my3PwXh9bTfQcmqw52DMGF+dgSnoyvZ95JPCNHEHzBBWt4x5/Xw0p92gDWu24vcqZG
         xDxWe1/+rwEdFFbr9qtdHYDpRY8eX9x+y4nwlcAcHW0K980vkr/ICSsR4y4jxW1g+qhS
         fBo0uCZjxANswQ1i7j/J54JT5O+Bky1uyNza/b33BJiS3jbuuQxoHwse3n3dgg/UttOt
         fjy2yJSwivwrKebfWMowNyv5WXDUIa0fbC9F8t3qJfUzF+ra4IJQvJO1/gi+TeJ68fkx
         spRCueu/C27Osq0qeOI84+a5+Fu54ViUK+M97YOMscfbRh2kTrJ8EM5K0Ezwvf2z4DVa
         GzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgUvbOIXDtHEGHGsx3KAlZ2A/NY19l8iihPpa+bw84o=;
        b=RcjzSHbMLzR38q8qJd8aY4RZ9XTT7qTUE+lWr2y/rpClobttQTbsgjEXptBTDewqtQ
         Evu6uCeYPl6h4L2yP40G65ls2/86WDNnclcrHEYKwa102mGWxXxlCnr4nrO54mSvyBg6
         vDBZosUruXc2442PJgyAQBr2OHhwjzGCr0m5fsyZ3vuodn2VmSJ5x+S1Ekr6LOR1ns2U
         zdt7ud/7SWMnxot7Ufx0a0gehdlsbkDSjZXE3Mscw3brHDVD8cDv8FG5Coke2JURlKOH
         JBvCNqFHzuFDrE15sNDREur/1sjzihQcV21IONrG0AxuI/eMdVUMfx/ONtG5ci0qlShc
         ILcg==
X-Gm-Message-State: APjAAAXb5VfiAaCfn/Exa9l5W4hX5XlZkmBw+x9vX2Zwc04G/81Ro8SM
        eHtLU8gJiiSeFY27jDm2NSw=
X-Google-Smtp-Source: APXvYqwKlGvuY3H4bXJeAzuRkCbWnQn+sXT2PbaIw/chrf9x8Ju95oKJEj09FvPluxFWzBKfAihfoA==
X-Received: by 2002:a63:1657:: with SMTP id 23mr14867025pgw.98.1560174328326;
        Mon, 10 Jun 2019 06:45:28 -0700 (PDT)
Received: from ar135.iitr.local ([223.188.3.146])
        by smtp.gmail.com with ESMTPSA id b66sm12973301pfa.77.2019.06.10.06.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 06:45:27 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH 2/3] cherry-pick/revert: add --skip option
Date:   Mon, 10 Jun 2019 19:13:21 +0530
Message-Id: <20190610134321.8203-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <2488ef91-b9e5-1836-aeea-2aaf11c3c383@gmail.com>
References: <2488ef91-b9e5-1836-aeea-2aaf11c3c383@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On 2019-06-10 10:40 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> [...]
> It's actually a bit more complicated as if the cherry-pick failed
> because it would have overwriten untracked files then CHERRY_PICK_HEAD
> will not exist but we want to be able to skip that pick. So it should
> not error out in that case either. (I think you may be able to use the
> abort safety file (see rollback_is_safe()) to distinguish the 'failed to
> pick case' from the 'user committed a conflict resolution' case.)

Oh! I was thinking about some other case. (spawing another cherry-pick,
which is wrong since the topic is --skip). I'm sorry. 

>> Yes, .git/{REVERT|CHERRY_PICK}_HEAD will not exist in this case, but
>> in case of cherry-picking/reverting:
>> 
>> 1. multiple commits:
>>     sequencer dir will exist which will throw out the error listed
>>     under `create_seq_dir`
>
> I don't understand. Wont it will error out here? Why would we call
> create_seq_dir() for --skip?

No, you are correct. This won't skip commit in this case. I'll change
it to do the required.

>>> If rollback_single_pick() sees that HEAD is the null oid then it gives
>>> the error "cannot abort from a branch yet to be born". We're not
>>> aborting and if we're picking a sequence of commits the skip ought
>>> succeed, but it won't at the moment. If we're picking a single commit
>>> then the skip should probably fail like abort but with an appropriate
>>> message. Admittedly that's all a bit of a corner case.
>> 
>> Yes, you are right here. We could actually modify the advice there
>> to be more like _("cannot perform the specified action, the branch
>> is yet to be born") and I think it should suffice this. What do you
>> think?
>
> I think it should allow the user to skip if there are more commits to
> pick . Just changing the error message does not fix that.

Right! I'll check what can be done here.

>> The overall test tests that only, if cherry-pick --skip "failed" then
>> we won't get 'e' inside of `foo` and `test_cmp expect foo` will also
>> fail and if it skipped wrongly then expect.log will not match the
>> actual.log and `test_cmp` will fail. Am I missing something here?
>> Please tell if so.
>
> You're right that the tests at the end would probably pick up a failure,
> but I'm concerned that there could be some obscure corner case we've not
> thought of so checking HEAD and the file contents here would be an
> additional safety measure. It also makes it easier for someone tracking
> down a test failure to see what happened. If they rely only on the test
> at the end they need to spend time to understand where the mismatched
> contents came from.

Yes, it is worth checking here if HEAD after cherry-picking is in the
correct position, same for the file foo. I'll change this test too.
Thanks for pointing out.

Thanks for the review
Rohit

